Return-Path: <stable+bounces-111101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260BA21A03
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C761883D6B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF51A01D4;
	Wed, 29 Jan 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvzvUE/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAA18EFDE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143483; cv=none; b=Y9EMsOGaqtIjZJQDkRZ/GryRBVUDs2rQYeuj2S71HV+mhqExj7zsKeKozVMpfuwG0ls+wjlZMqBTVrP8rG7QQwk50Py1VMYyEBhW6U8STdgI/LZCuFvgKYJkk7ltNiDMQW2GTD60me7ur5z//qTLa+mIYDxaNeFTaxCBDFKXZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143483; c=relaxed/simple;
	bh=CzeMfTg7o4aE6ChtmK451y2OPTi7J42qaDUCKTbLgus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPP3ypPTaf1dbS2O2K8MNrXGFlTGcRXYYBklOgZfcoZ5cIcLsfNdfMCjboqcBqjRSR+g6wXsqyWjUblyzCvAMCqc0ix8PTdeEfysnRbFAdwdLjEYiMVucSAnx328eKce33AAOeRWJvygSVZSxlihF8BzQge/mNazyQowaoxnRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvzvUE/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E7FC4CED3;
	Wed, 29 Jan 2025 09:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738143482;
	bh=CzeMfTg7o4aE6ChtmK451y2OPTi7J42qaDUCKTbLgus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvzvUE/eFrYgNGg0HVcMxt7+8WANtJD0sx9ZwXN9kmqxc/fUXSozOgX66Ofit9sFU
	 pa73KnxaPM3gEVz/mjFjYjJnrv6XDOmW3th+PdOILThbZZLqObPntj5UObEGnShh51
	 yxSVEGpikDD9HqSEUkU4vATFMEvRfZGwhgv/hSC0=
Date: Wed, 29 Jan 2025 10:36:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5.10] wifi: iwlwifi: add a few rate index validity checks
Message-ID: <2025012931-flinch-delusion-e443@gregkh>
References: <20250128095802.1410328-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128095802.1410328-1-dmantipov@yandex.ru>

On Tue, Jan 28, 2025 at 12:58:02PM +0300, Dmitry Antipov wrote:
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
> index 548540dd0c0f..a2b477bc574a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> @@ -2,7 +2,7 @@
>  /******************************************************************************
>   *
>   * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
> - * Copyright (C) 2019 - 2020 Intel Corporation
> + * Copyright (C) 2019 - 2020, 2023 Intel Corporation
>   *
>   * Contact Information:
>   *  Intel Linux Wireless <linuxwifi@intel.com>
> @@ -130,7 +130,7 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
>  				return idx;
>  	}
>  
> -	return -1;
> +	return IWL_RATE_INVALID;
>  }
>  
>  static void rs_rate_scale_perform(struct iwl_priv *priv,
> @@ -3151,7 +3151,10 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
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
> index ed7382e7ea17..0a9634d9006c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /******************************************************************************
>   *
> - * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
> + * Copyright(c) 2005 - 2014, 2018 - 2020, 2023 Intel Corporation.
> + * All rights reserved.

Same here, why?

Also, what about 5.15.y?

thanks,

greg k-h

