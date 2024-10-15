Return-Path: <stable+bounces-85113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B099E2FC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA51A1F22CF1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A51DF261;
	Tue, 15 Oct 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMihmCbl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91211BF2B;
	Tue, 15 Oct 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985485; cv=none; b=e9ImnWoRXiRt2eXZW1sn0DLfFcS2yN5qmLoLKiE0aFSzKpQxh0UfRBciSbA0jNi/f4Q+9WAgCgqaUeC6oEsUIUOOf+oCdfRWSb5li3t+4idvNKrR88DjX/IB+b36JvKGYkjX0cmZO43qFJyp/hGG2ElAhB64NJPIQKDQHoYMMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985485; c=relaxed/simple;
	bh=xDzom3Mp9aBUd2cif8YQ9ZgSLhcqWvPQSQFDkhI/jYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHp2yKBpSIIW7uhBD6G4NKkrPLUISyJuQKR59PEqGy3R/5SWUb51di67OQfCcsChozUUS/A7l8lZqso/nHLqQDmn3Kl2SS6ejoZoiu4NAnuulG8vve6SYaw7P0jfyFFTj8j4rsl6QqdGgWPzKTWzyx7YJu/4j509B9Vxm34Gw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMihmCbl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728985484; x=1760521484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDzom3Mp9aBUd2cif8YQ9ZgSLhcqWvPQSQFDkhI/jYo=;
  b=iMihmCblQoMimcHMFSMpBZ6j0aGS3pi9EuHxcLgnr043PPEhT0C3UxYm
   AFPKEFKmtz8fKqiHIcJLcf/a4sNI2aADN/AyI1o8x+qyZ7OD9VxCl0z2q
   hEghiEakctWxmeiqrYAYmhKIkMF/eCi+ni7H/b5/1PJl2l2OXpjX5uNEd
   2NsHu4pfwukbiZQP4t67qOTQ1b4F8NJLGnUPrOVcr8kRBXEURhMU0ZVCu
   GAtKUTsNbYzFUvEGLv9PNXgUeSK9LOIEfxFvbdPhi8mjRK9k7ZdCIFZFP
   F0WMDChpli2uXXPXEz79kYEBdQ4Z7SZ9WWxONTgd3RMSV9xIfgSVTph42
   w==;
X-CSE-ConnectionGUID: sfshIy9BRjOcFqbm9mlBXg==
X-CSE-MsgGUID: ceLh9gRQRTSxvWVAQPyB2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45839815"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45839815"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:44:43 -0700
X-CSE-ConnectionGUID: 2BiOxhbyTiCfFN8BIwtL2A==
X-CSE-MsgGUID: mFRFN6fJQ+epfUaK8fPLRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82615994"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:44:41 -0700
Message-ID: <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
Date: Tue, 15 Oct 2024 12:44:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241014114458.360538-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241014114458.360538-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/24 14:44, Avri Altman wrote:
> While reviewing the SDUC series, Adrian made a comment concerning the
> memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> Prevent memory allocations from triggering I/O operations while ACMD22
> is in progress.
> 
> [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/core/block.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 04f3165cf9ae..042b0147d47e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	u32 result;
>  	__be32 *blocks;
>  	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> +	unsigned int noio_flag;
> +
>  	struct mmc_request mrq = {};
>  	struct mmc_command cmd = {};
>  	struct mmc_data data = {};
> @@ -1018,9 +1020,13 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	mrq.cmd = &cmd;
>  	mrq.data = &data;
>  
> +	noio_flag = memalloc_noio_save();
> +
>  	blocks = kmalloc(resp_sz, GFP_KERNEL);

Could have memalloc_noio_restore() here:

	memalloc_noio_restore(noio_flag);

but I feel maybe adding something like:

	u64 __aligned(8)	tiny_io_buf;

to either struct mmc_card or struct mmc_host is better?
Ulf, any thoughts?

> -	if (!blocks)
> +	if (!blocks) {
> +		memalloc_noio_restore(noio_flag);
>  		return -ENOMEM;
> +	}
>  
>  	sg_init_one(&sg, blocks, resp_sz);
>  
> @@ -1041,6 +1047,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	}
>  	kfree(blocks);
>  
> +	memalloc_noio_restore(noio_flag);
> +
>  	if (cmd.error || data.error)
>  		return -EIO;
>  


