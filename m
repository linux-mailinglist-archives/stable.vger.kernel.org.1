Return-Path: <stable+bounces-110986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57AA20E53
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CE63A390A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377D1D8DE1;
	Tue, 28 Jan 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg2N+fzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332B1917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081074; cv=none; b=M1v8tWuY1HIeB+OKVjXslq4YlTBMFqIUildlFSV1xvbJy5d/bAp3KxUyyZxbXFyMkng7c7wRe0vSS/K0hHWkkCLLZn09BwFBLdfRt/hbLTbRu/rTnLTaELhaXQ2sytgK0DLbLe3FU2owW0l7MfBAaBLVKBFpSCl3LEecYTgFKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081074; c=relaxed/simple;
	bh=TvvN3COHfFN0D23s2hDH1ZlhO1GXxcaU9rw+i246a2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2xTBOYSLiYeeDdn0Z23l6p1+kDsfAx7FMa9jlPs7dqB3XmeZgvfkurqpMDjR7zEPml67ubiExkrg2xorUrr2VWrlctvjeSdBZsBttXWbAYvaOSz7WtG38/5lhGn5sfOUvVyXOyvI5zE/tEri4FmePAZMbUe2bCr2L7Gn9JG92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg2N+fzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98C8C4CED3;
	Tue, 28 Jan 2025 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081074;
	bh=TvvN3COHfFN0D23s2hDH1ZlhO1GXxcaU9rw+i246a2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zg2N+fzrCvLV4U7+B5iXv2YOgn7Z158uV2hKXcW/x5WDVQIEir10VePhZfFhQrb0M
	 HoiWp4ZXewjfFgbjXS8qjDkERF9UtBq/cWxpdIkcg+cbY8XU57d8xcDUqKXSAX31+C
	 o2WaIVWzkvYvj5Vh+84bXh/L1E9PF76KLa7efqw3zHV/x8sAEVZBQ5TzyHOIAfJD+6
	 wD6Ho2yRZOQOTt/AQL1/Zcq/1fQyFtZPmDynWNaPFoRE8bALwxbWDT11T6VfgsiwjQ
	 CSo/hUR6MtTIQNM3S3E1bROdC0z1BEibwccBxo0KOeMPoh7EGrImDikcEtbEhKkwEP
	 isRb14S9mVMzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] wifi: iwlwifi: add a few rate index validity checks
Date: Tue, 28 Jan 2025 11:17:52 -0500
Message-Id: <20250128105344-76485f9fabf36849@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128095802.1410328-1-dmantipov@yandex.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: efbe8f81952fe469d38655744627d860879dcde8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Dmitry Antipov<dmantipov@yandex.ru>
Commit author: Anjaneyulu<pagadala.yesu.anjaneyulu@intel.com>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  efbe8f81952fe ! 1:  7963551783c9b wifi: iwlwifi: add a few rate index validity checks
    @@ Metadata
      ## Commit message ##
         wifi: iwlwifi: add a few rate index validity checks
     
    +    commit efbe8f81952fe469d38655744627d860879dcde8 upstream.
    +
         Validate index before access iwl_rate_mcs to keep rate->index
         inside the valid boundaries. Use MCS_0_INDEX if index is less
    -    than MCS_0_INDEX and MCS_9_INDEX if index is greater then
    +    than MCS_0_INDEX and MCS_9_INDEX if index is greater than
         MCS_9_INDEX.
     
         Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
         Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
         Link: https://lore.kernel.org/r/20230614123447.79f16b3aef32.If1137f894775d6d07b78cbf3a6163ffce6399507@changeid
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    +    Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
     
      ## drivers/net/wireless/intel/iwlwifi/dvm/rs.c ##
     @@
      /******************************************************************************
       *
       * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
    -- * Copyright (C) 2019 - 2020, 2022 Intel Corporation
    -+ * Copyright (C) 2019 - 2020, 2022 - 2023 Intel Corporation
    -  *****************************************************************************/
    - #include <linux/kernel.h>
    - #include <linux/skbuff.h>
    +- * Copyright (C) 2019 - 2020 Intel Corporation
    ++ * Copyright (C) 2019 - 2020, 2023 Intel Corporation
    +  *
    +  * Contact Information:
    +  *  Intel Linux Wireless <linuxwifi@intel.com>
     @@ drivers/net/wireless/intel/iwlwifi/dvm/rs.c: static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
      				return idx;
      	}
    @@ drivers/net/wireless/intel/iwlwifi/mvm/rs.c
      // SPDX-License-Identifier: GPL-2.0-only
      /******************************************************************************
       *
    -- * Copyright(c) 2005 - 2014, 2018 - 2022 Intel Corporation. All rights reserved.
    -+ * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
    +- * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
    ++ * Copyright(c) 2005 - 2014, 2018 - 2020, 2023 Intel Corporation.
    ++ * All rights reserved.
       * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
       * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
    -  *****************************************************************************/
    +  *
     @@ drivers/net/wireless/intel/iwlwifi/mvm/rs.c: static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
      
      		rate->bw = RATE_MCS_CHAN_WIDTH_20;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

