Return-Path: <stable+bounces-55143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447E915EE7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F881C21AA9
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB36145FE4;
	Tue, 25 Jun 2024 06:28:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67512BCF6
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296913; cv=none; b=qY8lhX4nViyeH+JH36bJItXaSmeWMRjeYpOEI8RHYN6XFU1Qu3Em0TZZknajV1RSxOJxe/BGyi6Xz7DINyYfmEhcxwLbSFiZoRcKEuahWSPXTBWOavuEv5HvrXLq+4WmoVwxBwF60vq7vPWJUpc62WGz9RzgDZb6n81/278bEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296913; c=relaxed/simple;
	bh=fw4Cmzm744lsr+rdoKMCP/EsRz4QD606yxJ6UOAKaFg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Npz6e64kG620nMhkzbPXt9LlG0CIJOqByzuX1MThWJTGdiT3ihUAe8GW7KC9lfqqS7uDflb22G8Yn+LcAQh1uqldmhyutkuE19k8ygbsYASluizTwK4+Jd5wJHC+5vhygnHpBs2lRPngwRrEeHRAxXcZxrS6ftSbP+K3EqpjE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9920af9344=ms@dev.tdt.de>)
	id 1sLzfH-000cK8-OX; Tue, 25 Jun 2024 08:28:27 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sLzfH-0031wm-82; Tue, 25 Jun 2024 08:28:27 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 00EA4240053;
	Tue, 25 Jun 2024 08:28:27 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A3AA8240050;
	Tue, 25 Jun 2024 08:28:26 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 2367220892;
	Tue, 25 Jun 2024 08:28:26 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jun 2024 08:28:25 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: gregkh@linuxfoundation.org
Cc: tsbogend@alpha.franken.de, stable@vger.kernel.org
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Organization: TDT AG
In-Reply-To: <2024062436-wrist-skier-47a6@gregkh>
References: <2024062436-wrist-skier-47a6@gregkh>
Message-ID: <fb91fed8b962373e995c0afa9757abf5@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1719296907-34DF7522-6AB3D666/0/0

On 2024-06-24 19:01, gregkh@linuxfoundation.org wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     MIPS: pci: lantiq: restore reset gpio polarity
> 
> to the 6.9-stable tree which can be found at:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable 
> tree,
> please let <stable@vger.kernel.org> know about it.


This patch is buggy and should not go into the stable trees.
It has already been reverted upstream in the mips-fixes.

Thank you very much and sorry for the inconvenience,
Martin

> 
> 
> From 277a0363120276645ae598d8d5fea7265e076ae9 Mon Sep 17 00:00:00 2001
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Fri, 7 Jun 2024 11:04:00 +0200
> Subject: MIPS: pci: lantiq: restore reset gpio polarity
> 
> From: Martin Schiller <ms@dev.tdt.de>
> 
> commit 277a0363120276645ae598d8d5fea7265e076ae9 upstream.
> 
> Commit 90c2d2eb7ab5 ("MIPS: pci: lantiq: switch to using gpiod API") 
> not
> only switched to the gpiod API, but also inverted / changed the 
> polarity
> of the GPIO.
> 
> According to the PCI specification, the RST# pin is an active-low
> signal. However, most of the device trees that have been widely used 
> for
> a long time (mainly in the openWrt project) define this GPIO as
> active-high and the old driver code inverted the signal internally.
> 
> Apparently there are actually boards where the reset gpio must be
> operated inverted. For this reason, we cannot use the 
> GPIOD_OUT_LOW/HIGH
> flag for initialization. Instead, we must explicitly set the gpio to
> value 1 in order to take into account any "GPIO_ACTIVE_LOW" flag that
> may have been set.
> 
> In order to remain compatible with all these existing device trees, we
> should therefore keep the logic as it was before the commit.
> 
> Fixes: 90c2d2eb7ab5 ("MIPS: pci: lantiq: switch to using gpiod API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/pci/pci-lantiq.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/mips/pci/pci-lantiq.c
> +++ b/arch/mips/pci/pci-lantiq.c
> @@ -124,14 +124,14 @@ static int ltq_pci_startup(struct platfo
>  		clk_disable(clk_external);
> 
>  	/* setup reset gpio used by pci */
> -	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> -					     GPIOD_OUT_LOW);
> +	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset", 
> GPIOD_ASIS);
>  	error = PTR_ERR_OR_ZERO(reset_gpio);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to request gpio: %d\n", error);
>  		return error;
>  	}
>  	gpiod_set_consumer_name(reset_gpio, "pci_reset");
> +	gpiod_direction_output(reset_gpio, 1);
> 
>  	/* enable auto-switching between PCI and EBU */
>  	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
> @@ -194,10 +194,10 @@ static int ltq_pci_startup(struct platfo
> 
>  	/* toggle reset pin */
>  	if (reset_gpio) {
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
>  		wmb();
>  		mdelay(1);
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
>  	}
>  	return 0;
>  }
> 
> 
> Patches currently in stable-queue which might be from ms@dev.tdt.de are
> 
> queue-6.9/mips-pci-lantiq-restore-reset-gpio-polarity.patch

