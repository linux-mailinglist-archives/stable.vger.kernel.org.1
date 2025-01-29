Return-Path: <stable+bounces-111199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35861A22208
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB1162496
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331E1DF255;
	Wed, 29 Jan 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coSCwG+F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C61DF253
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169247; cv=none; b=llJb+ZpFnqhuHVcV8LhsochTTfTmZA/UNNBciOJR9ntzqKI18t7qn8pxhzZN1u2sT00I5/2A0MWH6o8RbXR62+WysBL+CE6fYL938F03VfRbjaBo85dm1vJt0fchojZg6oF470smR5TKmxT8KZo5jKXu3cz22yonvmwDFwXo4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169247; c=relaxed/simple;
	bh=ooP3pe3KdtfDyGZLyFiXoFKRF6varPHxN9kzq9FM2jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bx/SV6dcC475J97NDgvHnK9pkBsLguONgjk1BsyB3OQCPQE0F4Q8fsMY7mNrBvCpDF+KFeAd3jsoYJWiGCF7Ws3AWVKLMNfCJZ7/i3wWd4Ubra8fIQew3mLqVGHKA9s4MP0SQM2Cfcm/13hyUPU4ipQevB9aGKPxf6XNGmg8B+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coSCwG+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96084C4CED1;
	Wed, 29 Jan 2025 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169247;
	bh=ooP3pe3KdtfDyGZLyFiXoFKRF6varPHxN9kzq9FM2jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coSCwG+FqlXyaYenaI64c1zh8INg+S283dNaMeL+opei1pbnHUgr5tyUEABF6VHsQ
	 8NgskU6d8NNjYdSZO+5T3QrnvqMddezD0ALJRHGIys+l8IiVc1v92yiRlNU7J+bfIF
	 TyeDVAG0KMGD1OhZS+/asxzgEOOlLRVXW/pVV8UBU9XkDNgAoFG/4iJwDCooUgu5RH
	 Dv/juk4D5Xuuga57YD4ns8avTao+TD1FxhRwKk8jG6IaE+0d8WXRIxi7Po8r2wBZCx
	 QpmpXT9/s03CswLUtry0JFJljGO8O01vsCemKAjDX6nKRoLBQvTa28qv8bFDXA9OgO
	 7aEQl/hUJU9Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.10] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 11:47:24 -0500
Message-Id: <20250129112746-f05051a5cb0ff583@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129142555.2448994-1-dmantipov@yandex.ru>
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
1:  efbe8f81952fe ! 1:  6281b199ae74f wifi: iwlwifi: add a few rate index validity checks
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
    +- * Copyright (C) 2019 - 2020 Intel Corporation
     + * Copyright (C) 2019 - 2020, 2022 - 2023 Intel Corporation
    -  *****************************************************************************/
    - #include <linux/kernel.h>
    - #include <linux/skbuff.h>
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
    +- * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
     + * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
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

