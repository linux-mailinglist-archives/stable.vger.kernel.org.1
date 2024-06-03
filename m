Return-Path: <stable+bounces-47851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9A8D7C48
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDB61C21B0C
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33A3F9D9;
	Mon,  3 Jun 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjpPRfE6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAB3D0D1;
	Mon,  3 Jun 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398975; cv=none; b=lSJCBss8EmUlxggn7RsuLnMOckxFSWl6SlmgOUCVsQnqHlr9MLkkUAByEco6MGl6aLj4+cn7/BK7VoVIe7leWiC2Qu/QZ0excMBhFX8ID0Ae5BMbBQtpDp4zpjWazk58JOsy4BRCYruO4COej8Q/cx8yyAVBmpBrRTD3rb/Cp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398975; c=relaxed/simple;
	bh=n5EupW/9f+aEbVXy971JIpT2h7qZ4Jk0L+7MDSzusJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6a1QlVXJ1bTB6lUuGDbL/XglU2WBDL8VNJ282Sh0Qu1camgMKkB6ixdqOlqxqXBq/VcLTsQbJPVWRNV5RAe915iUc3z1p0QJsECduiFeBs++POGar+8/rTLzq5fiNpfrQgjWSCi0C8fAK+eJb+mMVA/CUndoNch2xAOPbECliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjpPRfE6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717398970; x=1748934970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n5EupW/9f+aEbVXy971JIpT2h7qZ4Jk0L+7MDSzusJI=;
  b=UjpPRfE6nCx7/ZXb4yWCg49BMxd5H51a+h2gHuywZe+J2l9E5SW8GaI1
   e6kX6fq8f2KjcdrLzlhgAy5lBfaaveral8stGH54muqC9PdlhOLg2iE3A
   Um5ypdKgPcvcT8Qt3z1I5lQdNF7jJ3KfeFG9kyi1/K+scH7Wr3Fxc5vCY
   V4N6HP9bN6SCXQRtbIaU3trDZ46EMHuh84TJyO9/bFd1ds+o1INvIKW1/
   bEcqVosS7M/SO8pr9ojzsPBIeg1r+CAaYYU4HNmoUkgbHMLDcrn/YhLmf
   S7HtqOOoSz9dO/Dv/+gyx2vcTe+jA4GeDL9J2EPu0lCVe+hMniJI/QLMo
   A==;
X-CSE-ConnectionGUID: 8f0PtVZjTkazgGouljOY4A==
X-CSE-MsgGUID: X1wavJ2iQBCQpwo2ZtWL0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17720489"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="17720489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:16:10 -0700
X-CSE-ConnectionGUID: h8dcp8niTiGMn1O9gdgcEA==
X-CSE-MsgGUID: WXcGZefETL+i1/E8m1nV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36712696"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:16:07 -0700
Message-ID: <1f0b04a9-449b-423a-8f74-e6d2e463d6bb@intel.com>
Date: Mon, 3 Jun 2024 10:16:03 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Convert PCIBIOS_* return codes to
 errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/24 16:24, Ilpo Järvinen wrote:
> jmicron_pmos() and sdhci_pci_probe() use pci_{read,write}_config_byte()
> that return PCIBIOS_* codes. The return code is then returned as is by
> jmicron_probe() and sdhci_pci_probe(). Similarly, the return code is
> also returned as is from jmicron_resume(). Both probe and resume
> functions should return normal errnos.
> 
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning them the fix these issues.
> 
> Fixes: 7582041ff3d4 ("mmc: sdhci-pci: fix simple_return.cocci warnings")
> Fixes: 45211e215984 ("sdhci: toggle JMicron PMOS setting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ef89ec382bfe..23e6ba70144c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1326,7 +1326,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
>  
>  	ret = pci_read_config_byte(chip->pdev, 0xAE, &scratch);
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	/*
>  	 * Turn PMOS on [bit 0], set over current detection to 2.4 V
> @@ -1337,7 +1337,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
>  	else
>  		scratch &= ~0x47;
>  
> -	return pci_write_config_byte(chip->pdev, 0xAE, scratch);
> +	ret = pci_write_config_byte(chip->pdev, 0xAE, scratch);
> +
> +fail:
> +	return pcibios_err_to_errno(ret);
>  }
>  
>  static int jmicron_probe(struct sdhci_pci_chip *chip)
> @@ -2202,7 +2205,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
>  	if (ret)
> -		return ret;
> +		return pcibios_err_to_errno(ret);
>  
>  	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>  	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> @@ -2211,7 +2214,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
>  	if (ret)
> -		return ret;
> +		return pcibios_err_to_errno(ret);
>  
>  	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
>  


