Return-Path: <stable+bounces-100186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932B9E98C1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0701885752
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA91B0430;
	Mon,  9 Dec 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXZyJ6NK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808F1B0407;
	Mon,  9 Dec 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754478; cv=none; b=OVpFdGVddVys7QoYK3SfvHQIz89ffqYrHmnpmdz2Vqcg8Mkkz+JaHlbPp3Rb/veCtG5Bj0wV82NkNg2I48ERVt1Y1+UV8d5c0/rPp1XidFBKxRefu6pGM7qt6mcSShLnLXQxzWFcRxrfCS5ECoDYSM/hKlZVJfTnj9UqY4dHBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754478; c=relaxed/simple;
	bh=0m4Nll53SUs8R6YzahIOIM07jNhLhTzeX1XF3EFXvq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3AaE6qSIojDiycxjhy6Ch2Ljrl3GzZDst3RG4nZJwLhpYhJTHSDd+k+jt4rHIFOHW3sTlxNGvZ+MZuglL4RFIGmA6I/aMPfZbyQoGmdLrYjSgpLi7FW7v1+iLEyS9WmYNDZunFpznkChIlMDPb8job/GDrW4SMsiWnY6G+GAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXZyJ6NK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733754476; x=1765290476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0m4Nll53SUs8R6YzahIOIM07jNhLhTzeX1XF3EFXvq0=;
  b=UXZyJ6NKTQwOHGHd2i6+jP9EE0+RRWH4rHiBI3TOiv8/vs+J6baNwtqZ
   13+OJEiIyJxLegxr7z79jbAm7WmWH/vQb7QvkKXqCHUt9KjmUAj6p5wmf
   pGEbyN4xsICSEA/iJVXFPG6WQT80bbvF66HfOIsaEJjZZooYtL0jAOFP4
   cR+X4Xcj12ckQ6DrJgB/7BlhOqsJ9Ha7EL679z0liC/z2hbPhS6+9/jzU
   trDD6sequCD2p8oVXduwRsJaQUdo+mKwvbjwVIRfiUWb6N+FBY0u1eoQs
   1fLSeSQfqbmIRbOGrWSRr6Gv16+LwgpaQ0TYjfdgqRMVUFkQbBoeuz1Zg
   w==;
X-CSE-ConnectionGUID: G23U0cqWScC5ozGLG+tsow==
X-CSE-MsgGUID: hws2hh0XTcelnZoKmi8w8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45454738"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="45454738"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:27:55 -0800
X-CSE-ConnectionGUID: sVJNZMkzQ1ujVxfJ9I1Nfg==
X-CSE-MsgGUID: vgsEEJ2vQXKqA2fp+eI9xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95441055"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:27:52 -0800
Message-ID: <8342dd26-481d-424d-9fd3-819b7c972807@intel.com>
Date: Mon, 9 Dec 2024 16:27:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-tegra: Remove
 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk
To: Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, linux-mmc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anrao@nvidia.com, stable@vger.kernel.org
References: <20241209101009.22710-1-pshete@nvidia.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241209101009.22710-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 12:10, Prathamesh Shete wrote:
> Value 0 in ADMA length decsriptor is interpretated as 65536 on new Tegra
> chips, remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk to make sure
> max ADMA2 length is 65536
> 
> Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 1ad0a6b3a2eb..7b6b82bec855 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1525,7 +1525,6 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
> -		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,


