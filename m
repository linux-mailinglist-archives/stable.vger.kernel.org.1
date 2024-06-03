Return-Path: <stable+bounces-47852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E064E8D7C4B
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBB1C21B02
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF83EA95;
	Mon,  3 Jun 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vb8bqlKL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDA3F8ED;
	Mon,  3 Jun 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399014; cv=none; b=X2fqZDVus26nD6K/0Xxr8EmDOc3rt2J+MNeROdPAzmyYp0gSX3enXbwb+ZXYI7j3EQ3nLpbyEQ09dZ5ClsVAvAvCIDNjePOwpWoS6SaV+8KGPrjQm7I+E0OWRzS+8rvURkYmVJdPblD+6yuyh2o2noKAKzZug3aey8pYK5EW7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399014; c=relaxed/simple;
	bh=m5qfisp6+B/mJSSIOLTA72QEKYH/9Z1DK0HDNp+yAyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHycvcXzTxwH3F7dvzND/btMqX0JeCFxayVe5MSU2mQQCAPNqtcPIWWoFrgE/HhgtNiQrQcghWal/ufBnN1bZo1gcKY5Or/fy0pq4mhZVroOtHsvXKEpXPwhvfGaQ8Mo5Tg3G6Agm11aaz7hERiHv2aWH8s3okt8V1lEkVeOSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb8bqlKL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717399012; x=1748935012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m5qfisp6+B/mJSSIOLTA72QEKYH/9Z1DK0HDNp+yAyg=;
  b=Vb8bqlKLmSdu5zCFt1Nzr4y2+WnIvrPsnzeCCojfhfD10Qli8mQKMStp
   ZcpEK+2f1hUkT4dM0BivD7JQ4GmDHk/PTl8vuSE8OXaUfzzpJsb6L6pg6
   uKBCt4iRXMOLWDCB+Kcu5QJaFJWHtz+yZl/5+blLeGf/SZdarrgVSB2Ro
   mtj1GDRNlg5I/B7p6YQqz5ymRXBW+EeXJRAaEF49L4nyjRDnfY74R8TML
   5ZVk2PhZKj82TvFFQBhlIBa17fnB+drfm7lY3z9iM/l3uVi16inPZtLOI
   q6vcp9FofyeVhpplnU605fNOnTrHhN8fqD9E6+YwvVYfYeWgh/RQNLFkI
   g==;
X-CSE-ConnectionGUID: RZj51ER1S2uaw9JJ4g6zpg==
X-CSE-MsgGUID: +jFkueJbSg+E7PqayEPLng==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17720699"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="17720699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:16:51 -0700
X-CSE-ConnectionGUID: Y01BxGcBSHKvU1QsfSK1ew==
X-CSE-MsgGUID: 3PiJn1eJTs2X9iWsu8muwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36712984"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:16:47 -0700
Message-ID: <06bfb46a-1fba-4372-a290-f638ffbf78c9@intel.com>
Date: Mon, 3 Jun 2024 10:16:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return
 codes to errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Chevron Li
 <chevron.li@bayhubtech.com>, Dinghao Liu <dinghao.liu@zju.edu.cn>,
 Adam Lee <adam.lee@canonical.com>, Chris Ball <chris@printf.net>,
 Peter Guo <peter.guo@bayhubtech.com>, Jennifer Li <Jennifer.li@o2micro.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
 <20240527132443.14038-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240527132443.14038-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/24 16:24, Ilpo Järvinen wrote:
> sdhci_pci_o2_probe() uses pci_read_config_{byte,dword}() that return
> PCIBIOS_* codes. The return code is then returned as is but as
> sdhci_pci_o2_probe() is probe function chain, it should return normal
> errnos.
> 
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning them. Add a label for read failure so that the
> conversion can be done in one place rather than on all of the return
> statements.
> 
> Fixes: 3d757ddbd68c ("mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for UHS-I")
> Fixes: d599005afde8 ("mmc: sdhci-pci-o2micro: Add missing checks in sdhci_pci_o2_probe")
> Fixes: 706adf6bc31c ("mmc: sdhci-pci-o2micro: Add SeaBird SeaEagle SD3 support")
> Fixes: 01acf6917aed ("mmc: sdhci-pci: add support of O2Micro/BayHubTech SD hosts")
> Fixes: 26daa1ed40c6 ("mmc: sdhci: Disable ADMA on some O2Micro SD/MMC parts.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 41 +++++++++++++++-------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index d4a02184784a..058bef1c7e41 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -823,7 +823,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch &= 0x7f;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
> @@ -834,7 +834,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_CLKREQ, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x20;
>  		pci_write_config_byte(chip->pdev, O2_SD_CLKREQ, scratch);
>  
> @@ -843,7 +843,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		 */
>  		ret = pci_read_config_byte(chip->pdev, O2_SD_CAPS, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x01;
>  		pci_write_config_byte(chip->pdev, O2_SD_CAPS, scratch);
>  		pci_write_config_byte(chip->pdev, O2_SD_CAPS, 0x73);
> @@ -856,7 +856,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_INF_MOD, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x08;
>  		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
>  
> @@ -864,7 +864,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x80;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  		break;
> @@ -875,7 +875,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  
>  		scratch &= 0x7f;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> @@ -886,7 +886,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  						    O2_SD_FUNC_REG0,
>  						    &scratch_32);
>  			if (ret)
> -				return ret;
> +				goto read_fail;
>  			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
>  
>  			/* Check Whether subId is 0x11 or 0x12 */
> @@ -898,7 +898,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  							    O2_SD_FUNC_REG4,
>  							    &scratch_32);
>  				if (ret)
> -					return ret;
> +					goto read_fail;
>  
>  				/* Enable Base Clk setting change */
>  				scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> @@ -921,7 +921,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_dword(chip->pdev,
>  					    O2_SD_CLK_SETTING, &scratch_32);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  
>  		scratch_32 &= ~(0xFF00);
>  		scratch_32 |= 0x07E0C800;
> @@ -931,14 +931,14 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_dword(chip->pdev,
>  					    O2_SD_CLKREQ, &scratch_32);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch_32 |= 0x3;
>  		pci_write_config_dword(chip->pdev, O2_SD_CLKREQ, scratch_32);
>  
>  		ret = pci_read_config_dword(chip->pdev,
>  					    O2_SD_PLL_SETTING, &scratch_32);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  
>  		scratch_32 &= ~(0x1F3F070E);
>  		scratch_32 |= 0x18270106;
> @@ -949,7 +949,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_dword(chip->pdev,
>  					    O2_SD_CAP_REG2, &scratch_32);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch_32 &= ~(0xE0);
>  		pci_write_config_dword(chip->pdev,
>  				       O2_SD_CAP_REG2, scratch_32);
> @@ -961,7 +961,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  					   O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x80;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  		break;
> @@ -971,7 +971,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  				O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  
>  		scratch &= 0x7f;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> @@ -979,7 +979,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_dword(chip->pdev,
>  					    O2_SD_PLL_SETTING, &scratch_32);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  
>  		if ((scratch_32 & 0xff000000) == 0x01000000) {
>  			scratch_32 &= 0x0000FFFF;
> @@ -998,7 +998,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  						    O2_SD_FUNC_REG4,
>  						    &scratch_32);
>  			if (ret)
> -				return ret;
> +				goto read_fail;
>  			scratch_32 |= (1 << 22);
>  			pci_write_config_dword(chip->pdev,
>  					       O2_SD_FUNC_REG4, scratch_32);
> @@ -1017,7 +1017,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		ret = pci_read_config_byte(chip->pdev,
>  					   O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x80;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  		break;
> @@ -1028,7 +1028,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		/* UnLock WP */
>  		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch &= 0x7f;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
> @@ -1057,13 +1057,16 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		/* Lock WP */
>  		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>  		if (ret)
> -			return ret;
> +			goto read_fail;
>  		scratch |= 0x80;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  		break;
>  	}
>  
>  	return 0;
> +
> +read_fail:
> +	return pcibios_err_to_errno(ret);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP


