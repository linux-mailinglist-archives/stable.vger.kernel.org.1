Return-Path: <stable+bounces-43175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB128BE2D6
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FE1B268ED
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9715EFC0;
	Tue,  7 May 2024 12:57:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302715ECD3
	for <stable@vger.kernel.org>; Tue,  7 May 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086650; cv=none; b=tpIA1UPB6QBC1P5T+qlbeIc8gYviJXnOC02mvtKbl3/SPdbecWTN9haLDP0+YxVbRrx9/eQBggGXgPHDkkYtaC+rdeuaYmUqX2DxpyM2arug0KkGz5vWt6PecS2yRcmwiqnogFzmLyiLk8kDFbW9Ur3S0VcO4xWpEGRaLiMvQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086650; c=relaxed/simple;
	bh=1BCQZJCDcXux4QEChiI3vQsNmAXCSe00oWP7zDKgitE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRp034VhOzrP1HNNA9AtJbC4FFMqX9BJpeTxnGbSoSfiWwjvllCUXNDD60RyWduvheilXkciSzXQKMbb5ZkK02wGX1es4j3VCIrfLuKxEpBaj04/nHmLat7O5U3y+Wj6CUQPnHMziFwpy2v68C2H1KR0n/ulZImoALTCR3QWQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s4K4i-00039G-Cp; Tue, 07 May 2024 14:37:40 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s4K4g-00065t-US; Tue, 07 May 2024 14:37:38 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s4K4g-00GQDk-2g;
	Tue, 07 May 2024 14:37:38 +0200
Date: Tue, 7 May 2024 14:37:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: Ensure ECC configuration is propagated to
 upper layers
Message-ID: <ZjogkgrQ46H1hXSi@pengutronix.de>
References: <20240507085842.108844-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507085842.108844-1-miquel.raynal@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Miquel,

On Tue, May 07, 2024 at 10:58:42AM +0200, Miquel Raynal wrote:
> Until recently the "upper layer" was MTD. But following incremental
> reworks to bring spi-nand support and more recently generic ECC support,
> there is now an intermediate "generic NAND" layer that also needs to get
> access to some values. When using "converted" ECC engines, like the
> software ones, these values are already propagated correctly. But
> otherwise when using good old raw NAND controller drivers, we need to
> manually set these values ourselves at the end of the "scan" operation,
> once these values have been negotiated.
> 
> Without this propagation, later (generic) checks like the one warning
> users that the ECC strength is not high enough might simply no longer
> work.
> 
> Fixes: 8c126720fe10 ("mtd: rawnand: Use the ECC framework nand_ecc_is_strong_enough() helper")
> Cc: stable@vger.kernel.org
> Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
> Closes: https://lore.kernel.org/all/Zhe2JtvvN1M4Ompw@pengutronix.de/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Hello Sascha, this is only compile tested, would you mind checking if
> that fixes your setup?

Works as expected:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> Thanks, Miquèl
> 
>  drivers/mtd/nand/raw/nand_base.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index d7dbbd469b89..acd137dd0957 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -6301,6 +6301,7 @@ static const struct nand_ops rawnand_ops = {
>  static int nand_scan_tail(struct nand_chip *chip)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_device *base = &chip->base;
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  	int ret, i;
>  
> @@ -6445,9 +6446,13 @@ static int nand_scan_tail(struct nand_chip *chip)
>  	if (!ecc->write_oob_raw)
>  		ecc->write_oob_raw = ecc->write_oob;
>  
> -	/* propagate ecc info to mtd_info */
> +	/* Propagate ECC info to the generic NAND and MTD layers */
>  	mtd->ecc_strength = ecc->strength;
> +	if (!base->ecc.ctx.conf.strength)
> +		base->ecc.ctx.conf.strength = ecc->strength;
>  	mtd->ecc_step_size = ecc->size;
> +	if (!base->ecc.ctx.conf.step_size)
> +		base->ecc.ctx.conf.step_size = ecc->size;
>  
>  	/*
>  	 * Set the number of read / write steps for one page depending on ECC
> @@ -6455,6 +6460,8 @@ static int nand_scan_tail(struct nand_chip *chip)
>  	 */
>  	if (!ecc->steps)
>  		ecc->steps = mtd->writesize / ecc->size;
> +	if (!base->ecc.ctx.nsteps)
> +		base->ecc.ctx.nsteps = ecc->steps;
>  	if (ecc->steps * ecc->size != mtd->writesize) {
>  		WARN(1, "Invalid ECC parameters\n");
>  		ret = -EINVAL;
> -- 
> 2.40.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

