Return-Path: <stable+bounces-87453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EE9A65CC
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C1AB2888B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83751F12FB;
	Mon, 21 Oct 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkOGWAGu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B41F12E4;
	Mon, 21 Oct 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507650; cv=none; b=Ak7IchrJd5KWQ9emolyNnZwgJaE6bl6SSagR5HGhU0WbVyAQn6IRO8d1LRG6YU4W+SEeUYDXqwaWuSTevdzCC/zA318oP1KhoVqKWozX/7Cu6wwFbx8lUhIaBtuVxtDJH6j/dG5+SadDhotbRbGpBQ+S8/5+nokxoM+sYy15cJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507650; c=relaxed/simple;
	bh=8+aCw08J+IitHIZPJ6yBKdfACnb42TiH1BFfVCDni+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvK3tLh1FG5z5Y+V3NZXMQb9be//dxv1/fi+e0JXrfapr978xW98k2NiEYFvmUIxLFMDduNQ5ATSS85RZ/XnFx3mpNMGgrU6WYyUr+xI84sZ5Y+Mek3pzjCCHcBRWnxkWQeIFx7vYWM2EN6Vsk5jYJdOtQlXxB0CLvFZOKMmgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkOGWAGu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729507648; x=1761043648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8+aCw08J+IitHIZPJ6yBKdfACnb42TiH1BFfVCDni+E=;
  b=gkOGWAGuX23f0bYeSYTkinhHnGUYgz4Koy2r17pCP4Tubv0POf2xMrHT
   A5PeDfaeEMxC1AYIcZaH6efzuuCrfb6R0G8tiXzkXXZyMqAJPOaP7l9+m
   EILAl+jlbErqBOysPBvuozOYo6YII1mBXj9VeiZonUN5xLh8t614Wjr6G
   zV90fmFeR+OVEIPWkNGjbn1UXT3xe8Og9n0Z8s5SvpqTVE7D+LYs/Q/Kx
   TSf2il22kwl07yKChHPahbYY/OqoLDveL1lhAHokaL+/4Vn1dwApJGZlQ
   3eGthZ9BYyx76zkF9knFd5eChHxdTerxB5f4WKTZUT91Ths0HGFDEOJ3W
   Q==;
X-CSE-ConnectionGUID: ls2VtkUtT5SyOeH5wEHwVA==
X-CSE-MsgGUID: jw1dzxMUTkWqCufgVDtO2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28439678"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28439678"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:47:27 -0700
X-CSE-ConnectionGUID: ixXPU/fqTqCYYkOqxoaOSw==
X-CSE-MsgGUID: i1ammzECSRuv7qNfpVeSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110325579"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:47:24 -0700
Message-ID: <59f6c217-d84e-4626-9265-ce5cd8a043f4@intel.com>
Date: Mon, 21 Oct 2024 13:47:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241018052901.446638-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241018052901.446638-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/24 08:29, Avri Altman wrote:
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

Some checkpatch warnings:

  WARNING: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
  #12: 
  [1] https://www.spinics.net/lists/linux-mmc/msg82199.html

  WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

  total: 0 errors, 2 warnings, 17 lines checked

Otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> Changes since v1:
>  - Move memalloc_noio_restore around (Adrian)
> ---
>  drivers/mmc/core/block.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 04f3165cf9ae..a813fd7f39cc 100644
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
> @@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	mrq.cmd = &cmd;
>  	mrq.data = &data;
>  
> +	noio_flag = memalloc_noio_save();
>  	blocks = kmalloc(resp_sz, GFP_KERNEL);
> +	memalloc_noio_restore(noio_flag);
>  	if (!blocks)
>  		return -ENOMEM;
>  


