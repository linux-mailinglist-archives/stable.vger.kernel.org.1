Return-Path: <stable+bounces-80550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386498DE1B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468AFB21087
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C581D0E01;
	Wed,  2 Oct 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Ree+tzjP"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625889475
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880727; cv=none; b=tLcn739yMVRyYAAn8oOW1CvT3nDvdIzL4fdGAgQIjZU2VVC+FJa1XE3mNcOlUWmvrHqu7XSDYY6NfhiPes5LQkm7b7fJJJlHE+DTxONoQJ7kfWDM/5OVBP1lydynVP+WiaDKZ+Qe2iNcseejPggN/G2cj4F0ZMau9J15GmXjXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880727; c=relaxed/simple;
	bh=Pz+iIK6kOT0FvoM+Z59k2196gumJybUoqTaA3U1GMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxaCYEReTcHudyGBkc5SsaAQ4yobtzIoE2ygbaKddK48CaSkoAo6HAGP0tl8k1E+2k8XKAwWyGHPqCueMDcQqewHkqEdcA9eNdd8vOxdTuvwjjUHnaqnCVPOV8+qL7JwEwZpfRpHV1DMdU4mUyEoAb0clEScLXk4l8VLww0byEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Ree+tzjP; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CC911483738;
	Wed,  2 Oct 2024 16:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727880723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ynEun/P3ScZRmDQsi1Oi/THxnBWlwS83j9p4SMuVfk4=;
	b=Ree+tzjP5nAyTRRkC/GvUqRJV2OTLRSo+DV3utWRU/NhUqIYj2rFpyPn2l4J9fbjfViPzk
	L8mgWZwfMgJ3peCowWQcHu0yvaRVkcpXxKPN7DEZpbaCogsdK4DsM1nqlYaM6hcXqferc4
	nTPpY7FQhr5JUrTSQKqDletd02F8GuPPJTxxZIq3JanAKMjMmwzPfUNHkD9XlByEu6uule
	gtIwWAwMF745AK8O4ISIQkCXC5YV0OStDvAyzGK+6Lhfn9MrEyfJx22yV44dnmZ+wPXWR2
	07B38q2ndGlMC2f1Ca9ItzMKDoMedZ88wyBHCtD33e2thNW2vGRaOjZKiBXt3A==
Date: Wed, 2 Oct 2024 16:52:02 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Alexander Dahl <ada@thorsis.com>, Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 351/538] spi: atmel-quadspi: Avoid overwriting delay
 register settings
Message-ID: <20241002-payable-gaffe-54f97e7b8e5c@thorsis.com>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20241002125751.964700919@linuxfoundation.org>
 <20241002125806.283289301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002125806.283289301@linuxfoundation.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Greg,

Am Wed, Oct 02, 2024 at 02:59:50PM +0200 schrieb Greg Kroah-Hartman:
> 6.6-stable review patch.  If anyone has any objections, please let me know.

Same as for 6.11, if you take this, please also take
<20240926090356.105789-1-ada@thorsis.com>.

Thanks
Alex

Link: https://lore.kernel.org/linux-spi/20240926090356.105789-1-ada@thorsis.com/T/#u

> 
> ------------------
> 
> From: Alexander Dahl <ada@thorsis.com>
> 
> [ Upstream commit 329ca3eed4a9a161515a8714be6ba182321385c7 ]
> 
> Previously the MR and SCR registers were just set with the supposedly
> required values, from cached register values (cached reg content
> initialized to zero).
> 
> All parts fixed here did not consider the current register (cache)
> content, which would make future support of cs_setup, cs_hold, and
> cs_inactive impossible.
> 
> Setting SCBR in atmel_qspi_setup() erases a possible DLYBS setting from
> atmel_qspi_set_cs_timing().  The DLYBS setting is applied by ORing over
> the current setting, without resetting the bits first.  All writes to MR
> did not consider possible settings of DLYCS and DLYBCT.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Fixes: f732646d0ccd ("spi: atmel-quadspi: Add support for configuring CS timing")
> Link: https://patch.msgid.link/20240918082744.379610-2-ada@thorsis.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/spi/atmel-quadspi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index af0464999af1f..bf7999ac22c80 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -375,9 +375,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
>  	 * If the QSPI controller is set in regular SPI mode, set it in
>  	 * Serial Memory Mode (SMM).
>  	 */
> -	if (aq->mr != QSPI_MR_SMM) {
> -		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
> -		aq->mr = QSPI_MR_SMM;
> +	if (!(aq->mr & QSPI_MR_SMM)) {
> +		aq->mr |= QSPI_MR_SMM;
> +		atmel_qspi_write(aq->scr, aq, QSPI_MR);
>  	}
>  
>  	/* Clear pending interrupts */
> @@ -501,7 +501,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	aq->scr = QSPI_SCR_SCBR(scbr);
> +	aq->scr &= ~QSPI_SCR_SCBR_MASK;
> +	aq->scr |= QSPI_SCR_SCBR(scbr);
>  	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
>  
>  	pm_runtime_mark_last_busy(ctrl->dev.parent);
> @@ -534,6 +535,7 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> +	aq->scr &= ~QSPI_SCR_DLYBS_MASK;
>  	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
>  	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
>  
> @@ -549,8 +551,8 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
>  	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
>  
>  	/* Set the QSPI controller by default in Serial Memory Mode */
> -	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
> -	aq->mr = QSPI_MR_SMM;
> +	aq->mr |= QSPI_MR_SMM;
> +	atmel_qspi_write(aq->mr, aq, QSPI_MR);
>  
>  	/* Enable the QSPI controller */
>  	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
> -- 
> 2.43.0
> 
> 
> 

