Return-Path: <stable+bounces-111100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D1A21A02
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E3A3A6058
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01C1A01D4;
	Wed, 29 Jan 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AR3zKp2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98118EFDE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143456; cv=none; b=K5oSQtOtm3p9WfHk1vf8QGI2rdgaR0n4GgXudXdX7ORfEVavtIs7E8+HPJXMF3fb18AqGLvuq64Vv/lAHu9TwHcpK9g+V6urBb4sZCurOf8DbKp1nIXc+ngDlgr3SRu/iV7npzBmbotztTh9kivE6E1XgseFXgRpGFV/ozWQQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143456; c=relaxed/simple;
	bh=JxogNDW29+EwAEcJT284cLAP+Zdukm8qzgA+7oraSF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUlf/9Lvo6kV7qumnV9doIj6DCOH/p8asYIuad18UNIyIyoqNqsKL3uy1J8KIL4xpGQS3gSyJXURJ8At4SRvqN7iiI1RYUDI/IcfFdFi7Ua20K0rGZrtM5/b/NuVBNcm1VGLEXjEQD8gGqOG3SkxkH5q4+Za7lgbZ54GibS2B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AR3zKp2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B969BC4CED3;
	Wed, 29 Jan 2025 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738143455;
	bh=JxogNDW29+EwAEcJT284cLAP+Zdukm8qzgA+7oraSF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AR3zKp2X1RupNsHRoLc7sZSxYV2sL/v18ujfLwdL/UHZbMqBO6dk6aWUoy4XYu6pA
	 7y+iwWeg3NJB/RRXCt2n5LZGLkQMoxprTf/R0p4I68NF4KtM22uGrZazXZW6kUNGpW
	 PowVF76D9st/gGY/7Sz0FZRsPvm2AvvElR/pGaTM=
Date: Wed, 29 Jan 2025 10:36:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 6.1] wifi: iwlwifi: add a few rate index validity checks
Message-ID: <2025012949-unclasp-probation-a0df@gregkh>
References: <20250128095935.1413363-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128095935.1413363-1-dmantipov@yandex.ru>

On Tue, Jan 28, 2025 at 12:59:35PM +0300, Dmitry Antipov wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> 
> commit efbe8f81952fe469d38655744627d860879dcde8 upstream.
> 
> Validate index before access iwl_rate_mcs to keep rate->index
> inside the valid boundaries. Use MCS_0_INDEX if index is less
> than MCS_0_INDEX and MCS_9_INDEX if index is greater than
> MCS_9_INDEX.
> 
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Link: https://lore.kernel.org/r/20230614123447.79f16b3aef32.If1137f894775d6d07b78cbf3a6163ffce6399507@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/intel/iwlwifi/dvm/rs.c |  9 ++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 12 ++++++++----
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> index 687c906a9d72..4b1f006c105b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> @@ -2,7 +2,7 @@
>  /******************************************************************************
>   *
>   * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
> - * Copyright (C) 2019 - 2020, 2022 Intel Corporation
> + * Copyright (C) 2019 - 2020, 2022 - 2023 Intel Corporation
>   *****************************************************************************/
>  #include <linux/kernel.h>
>  #include <linux/skbuff.h>
> @@ -125,7 +125,7 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
>  				return idx;
>  	}
>  
> -	return -1;
> +	return IWL_RATE_INVALID;
>  }
>  
>  static void rs_rate_scale_perform(struct iwl_priv *priv,
> @@ -3146,7 +3146,10 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
>  	for (i = 0; i < LINK_QUAL_MAX_RETRY_NUM; i++) {
>  		index = iwl_hwrate_to_plcp_idx(
>  			le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
> -		if (is_legacy(tbl->lq_type)) {
> +		if (index == IWL_RATE_INVALID) {
> +			desc += sprintf(buff + desc, " rate[%d] 0x%X invalid rate\n",
> +				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
> +		} else if (is_legacy(tbl->lq_type)) {
>  			desc += sprintf(buff+desc, " rate[%d] 0x%X %smbps\n",
>  				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags),
>  				iwl_rate_mcs[index].mbps);
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
> index 2be6801d48ac..e42387a4663a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /******************************************************************************
>   *
> - * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
> + * Copyright(c) 2005 - 2014, 2018 - 2021, 2023 Intel Corporation.
> + * All rights reserved.

Why did you wrap the copyright line like this?  Please just leave it
alone for backports, or better yet, follow what was done upstream in the
original patch.

thanks,

greg k-h

