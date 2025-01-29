Return-Path: <stable+bounces-111200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E707AA22209
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3E3A4455
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367C1DF743;
	Wed, 29 Jan 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKWq7MiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA1DE892
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169250; cv=none; b=AlUaQ3xF8z67PshbUgxaksEKH5TFkNmpuWal20Ht+P82yx7XGCwZGXAma0wndBvkcjRRDfs56HuohEjJTolc/aUf4ouweb9WrDRrGZF1Q84e9CG3/aGm2Y2BdPfTWqakxKOuFZuCW7KTn4+ld/oYfxp0x/pYLl11eqOE3iynXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169250; c=relaxed/simple;
	bh=pgNWWOE/b2u149pucNYj1TeP7Um3FlDwNK/KsdWBQoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXtUMWvh47gfIFsxgyqddcphXlQotA86ZqN5GVg1Yz7zye2gFdMFFo6I0p1+c4eqvxImbtghHaZxcyzYXhERJdVIxSrW5Get4R/F6jCTQsIFQMjsn0iYcTxkGA6xKgSNIoXqDySfpwJMVgNvM9P73+AbEGxhz7/aR3GKg6sGp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKWq7MiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9136C4CED1;
	Wed, 29 Jan 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169249;
	bh=pgNWWOE/b2u149pucNYj1TeP7Um3FlDwNK/KsdWBQoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKWq7MiQMz/WQhyBJHQeFTTF9ilmbjQ8bs5hRNJ6MotQRAM7yro+U/FQVHUBp6gct
	 PfCF4mHRiZSrbKF3kk23q2bnOsM35iK3An+eFnLiaRAkAeVLT8rYrfJWESC+PnrnMY
	 pRETcFHRoJ/Q42AQq7u6qrgPYPf5gyQ7zgvXo6oV315YSQIhw9Xe1rHMM1vC+XmcW3
	 fapddtxBZOzsSnx5Yf7keZcIKLYX7KGGOSMSvq0c16rDlLQtfnRBT8O+G6cFb+DGsc
	 f8Acw++xnCJxudjUrlbGFp+ARMIbcZ+J6l6rs30ah8kocEnycpK45cxjqMc8JDY788
	 OkLwDDjP9dqag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 11:47:27 -0500
Message-Id: <20250129112150-3c62cdaa28d3f388@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129143343.2449440-1-dmantipov@yandex.ru>
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

Note: The patch differs from the upstream commit:
---
1:  efbe8f81952fe ! 1:  0db320c7e5f3d wifi: iwlwifi: add a few rate index validity checks
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
    +- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
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
| stable/linux-5.15.y       |  Success    |  Success   |

