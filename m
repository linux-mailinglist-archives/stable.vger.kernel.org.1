Return-Path: <stable+bounces-172818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAEB33DBB
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEEA3AD9E3
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83C2E11D5;
	Mon, 25 Aug 2025 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="FQ58mAI9"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500D23B636;
	Mon, 25 Aug 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120225; cv=none; b=lUPf1qhuFLFqIhtYh01RUcgLEEQ3k85Ju80hrQUu69jmcyzDbNdTxiCAV6Td7H5aKcjwgIwioqxZtoII47Ya17FSfhdot0HfYOSGITXBM/G0QijSoNMe23TRaROZStSqkAC4+dqaD7Ro8XCu+Ej1eNETUpW/TsORVaqFrt8BtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120225; c=relaxed/simple;
	bh=MHYTG4YoP1kWBzLB4oi6Zyzatc0XGGvt7zAp6Z40sFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFtLL0FP4vUHAi0r2FaDy2u94FjZlkdqqFybM03FnESY8E+zoYT+DyfMZwv1cEgjEM6sI7VtKcustl5xdeCfCFTYBwhcLHNr/I6rjawdP6wOWTWGT6ZwhsAXHx/sTJpV+HiZ3hriXFJtfOBb+rTphfRwkItvGfimcaqW880hm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=FQ58mAI9; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D3931480453;
	Mon, 25 Aug 2025 13:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756119762; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b6xnnOWxU5iOspNsDZprgcmihfZ1HupGLGLAbK4wzWk=;
	b=FQ58mAI9pOap707dWMZNES/WSPKZC3aSwdxpENbbxayKwuspVlE5RtCQgI5k0WD5BbTD4G
	Luv4owtXLzJxH8F0gGU8Xboq9enPfaJRk6DvNzFho8W58s6h3rlZJNi1hKjdlEqVDQLHGs
	pbSUdoRwy+90La/w/IFyOeCpLELu93WTZA5YmiTCDjcJSVepgZ8Yd4Gz3/j+JZ7ZaQpI+T
	WrJu8tcH2f9+wO+S+ljpZtUvINdheKYRMnQlqq0ixtmM4cGdP40GO2cYageD+QMsqJ9zNB
	P5iH54L+GsGg69VbE/LyHmegpYjxb2y+7MlJ7qTJAqod8FpRKwiJoCMABTUI5w==
Date: Mon, 25 Aug 2025 13:02:34 +0200
From: Alexander Dahl <ada@thorsis.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org,
	Balamanikandan.Gunasundar@microchip.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read
 setup timing
Message-ID: <20250825-uneven-barman-7f932d0ca964@thorsis.com>
Mail-Followup-To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	linux-mtd@lists.infradead.org,
	Balamanikandan.Gunasundar@microchip.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Thu, Aug 21, 2025 at 02:00:57PM +0200 schrieb A. Sverdlin:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Having setup time 0 violates tAR, tCLR of some chips, for instance
> TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
> being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
> 98 dc 90 15 76 ...).
> 
> Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
> [1], but it looks more appropriate to just calculate setup time properly.
> 
> [1] Link: https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ApplicationNotes/ApplicationNotes/doc6255.pdf
> Cc: stable@vger.kernel.org
> Fixes: f9ce2eddf176 ("mtd: nand: atmel: Add ->setup_data_interface() hooks")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Tested-by: Alexander Dahl <ada@thorsis.com>

Threw this on top of 6.12.39-rt11 and tested on two custom platforms
both with a Spansion S34ML02G1 SLC 2GBit flash chip, but with
different SoCs (sama5d2, sam9x60).  We had difficulties with the
timing of those NAND flash chips in the past and I wanted to make sure
this patch does not break our setup.  Seems fine in a quick test,
reading and writing and reading back is successful.

Kernel log output is unobtrusive, here for the first device:

  [  +0.001100] AT91: Detected SoC family: sam9x60
  [  +0.000024] AT91: Detected SoC: sam9x60 64MiB DDR2 SiP, revision 2
  …
  [  +0.011069] atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
  [  +0.000836] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xda
  [  +0.000031] nand: AMD/Spansion S34ML02G1
  [  +0.000011] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
  [  +0.051629] Bad block table found at page 131008, version 0xFF
  [  +0.005350] Bad block table found at page 130944, version 0xFF
  [  +0.000479] 5 fixed-partitions partitions found on MTD device atmel_nand
  [  +0.000047] Creating 5 MTD partitions on "atmel_nand":
  [  +0.000025] 0x000000000000-0x000000040000 : "at91bootstrap"
  [  +0.001104] 0x000000040000-0x000000140000 : "u-boot"
  [  +0.001063] 0x000000140000-0x000000180000 : "U-Boot Env"
  [  +0.026887] 0x000000180000-0x0000001c0000 : "U-Boot Env Redundant"
  [  +0.001022] 0x000000200000-0x00000ff00000 : "UBI"
  …
  [  +0.043872] ubi0: attaching mtd4
  [  +0.932080] ubi0: scanning is finished
  [  +0.032686] ubi0: attached mtd4 (name "UBI", size 253 MiB)
  [  +0.000048] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
  [  +0.000022] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
  [  +0.000018] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
  [  +0.000018] ubi0: good PEBs: 2024, bad PEBs: 0, corrupted PEBs: 0
  [  +0.000017] ubi0: user volume: 4, internal volumes: 1, max. volumes count: 128
  [  +0.000017] ubi0: max/mean erase counter: 7/3, WL threshold: 4096, image sequence number: 1905565080
  [  +0.000023] ubi0: available PEBs: 2, total reserved PEBs: 2022, PEBs reserved for bad PEB handling: 40
  [  +0.000043] ubi0: background thread "ubi_bgt0d" started, PID 47

And for the second:

  [  +0.001519] AT91: Detected SoC family: sama5d2
  [  +0.000030] AT91: Detected SoC: sama5d27c 128MiB SiP, revision 2
  …
  [  +0.002585] atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
  [  +0.036590] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xda
  [  +0.000044] nand: AMD/Spansion S34ML02G1
  [  +0.000017] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
  [  +0.001571] Bad block table found at page 131008, version 0xFF
  [  +0.001249] Bad block table found at page 130944, version 0xFF
  [  +0.000572] 6 cmdlinepart partitions found on MTD device atmel_nand
  [  +0.000037] Creating 6 MTD partitions on "atmel_nand":
  [  +0.000026] 0x000000000000-0x000000040000 : "bootstrap"
  [  +0.001496] 0x000000040000-0x000000100000 : "uboot"
  [  +0.031417] 0x000000100000-0x000000140000 : "env1"
  [  +0.013718] 0x000000140000-0x000000180000 : "env2"
  [  +0.001276] 0x000000180000-0x000000200000 : "reserved"
  [  +0.001209] 0x000000200000-0x000010000000 : "UBI"
  …
  [  +0.055885] ubi0: attaching mtd5
  [  +1.468075] ubi0: scanning is finished
  [  +0.047323] ubi0: attached mtd5 (name "UBI", size 254 MiB)
  [  +0.000065] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
  [  +0.000022] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
  [  +0.000017] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
  [  +0.000017] ubi0: good PEBs: 2028, bad PEBs: 4, corrupted PEBs: 0
  [  +0.000016] ubi0: user volume: 4, internal volumes: 1, max. volumes count: 128
  [  +0.000018] ubi0: max/mean erase counter: 6/3, WL threshold: 4096, image sequence number: 1534026892
  [  +0.000022] ubi0: available PEBs: 0, total reserved PEBs: 2028, PEBs reserved for bad PEB handling: 36
  [  +0.000050] ubi0: background thread "ubi_bgt0d" started, PID 49

Thanks and greets
Alex

> ---
> v2:
> - Cc'ed stable
> - reformatted atmel_smc_cs_conf_set_setup() call
> - rebased onto mtd/fixes
> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index dedcca87defc7..ad0eff385e123 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1377,14 +1377,24 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Read setup timing depends on the operation done on the NAND:
> +	 *
> +	 * NRD_SETUP = max(tAR, tCLR)
> +	 */
> +	timeps = max(conf->timings.sdr.tAR_min, conf->timings.sdr.tCLR_min);
> +	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
> +	totalcycles += ncycles;
> +	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NRD_SHIFT, ncycles);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The read cycle timing is directly matching tRC, but is also
>  	 * dependent on the setup and hold timings we calculated earlier,
>  	 * which gives:
>  	 *
> -	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
> -	 *
> -	 * NRD_SETUP is always 0.
> +	 * NRD_CYCLE = max(tRC, NRD_SETUP + NRD_PULSE + NRD_HOLD)
>  	 */
>  	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
>  	ncycles = max(totalcycles, ncycles);
> -- 
> 2.50.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

