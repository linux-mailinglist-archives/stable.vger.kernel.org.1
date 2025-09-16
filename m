Return-Path: <stable+bounces-179708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1EAB59248
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344213AA842
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EEA28B512;
	Tue, 16 Sep 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wjtdg6QG"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394C28469D
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015190; cv=none; b=eaoV782tYisxfAMXG05ejApii+c6OJ9AUNgfW1TZpp5Ob1ZY2jKizRNp8ICqgolmuA6W3SRPduiW7WHhdFbqYJkN6XCdotR8UMr9xQ6RfUt1bIdmYvjGZkq461bqRje8935ocrDyX2wsn7vRgJTqVf/SrlAJKCxp11d+MmfVtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015190; c=relaxed/simple;
	bh=Y01HExwkodCRNS+5lJN9tYjQHBHpPfUIr3T1GZgbMws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVlnj2QTb267LJDGLhmC02xwW4aBc3WGvvWgTR2Vp5Oj3+2VOCqD5muy9ikEchrFpOpK6ElQzz+wKCG7oDpmk4y/ydUoHYYvsAb3TwOzLeGWzbQGCMwMgv/eJQHMFgU7ppx5t+dab5AHGCjIMGJZMfvrqf7an/96rQGmP76qjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wjtdg6QG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 128E4C8F1F3;
	Tue, 16 Sep 2025 09:32:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F0B66061E;
	Tue, 16 Sep 2025 09:33:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF02102F16A1;
	Tue, 16 Sep 2025 11:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758015184; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jUHDhIk4lXzFELL7ItP2OHbvC4jAgKomX4rA9TKCWxc=;
	b=Wjtdg6QGcZp1veOwxQX82+vGUdpU/1KCTsisYBKEYahBvIcy+2lD/5CbvKyBP+2FWjS/u/
	NGdRkW9bcfT+PcyWQGJYZ2zpER5JXS+PjWsaeRgqbGsBXHCnk/Z3BlgAwBtjnZe1I4aW/J
	teMh0qOpbCGzv6Z+/Rd3srwcW57Uev7zIV/Q6xNTzXqbOtBgOhgtPDOILbUqDyr589Gg11
	/WZ2dhCLQVmKIvkZLUcYDE6dnQXbQMJUrK7/4D6WXrHfQkK9U9Rx/JFKBvFZgVxatQP8wq
	cp8PhKQukIHpWEY6OtT54uBJ59vtUS4DKtXpy17zMiM2W2fOBfDDEqC+gOTTwQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsmc: Default to autodetect buswidth
In-Reply-To: <20250914-fsmc-v1-1-6d86d8b48552@linaro.org> (Linus Walleij's
	message of "Sun, 14 Sep 2025 00:35:37 +0200")
References: <20250914-fsmc-v1-1-6d86d8b48552@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 16 Sep 2025 11:32:58 +0200
Message-ID: <87h5x27ned.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus,

On 14/09/2025 at 00:35:37 +02, Linus Walleij <linus.walleij@linaro.org> wro=
te:

> If you don't specify buswidth 2 (16 bits) in the device
> tree, FSMC doesn't even probe anymore:
>
> fsmc-nand 10100000.flash: FSMC device partno 090,
>   manufacturer 80, revision 00, config 00
> nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
> nand: ST Micro 10100000.flash
> nand: bus width 8 instead of 16 bits
> nand: No NAND device found
> fsmc-nand 10100000.flash: probe with driver fsmc-nand failed
>   with error -22
>
> With this patch to use autodetection unless buswidth is
> specified, the device is properly detected again:
>
> fsmc-nand 10100000.flash: FSMC device partno 090,
>   manufacturer 80, revision 00, config 00
> nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
> nand: ST Micro NAND 128MiB 1,8V 16-bit
> nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> fsmc-nand 10100000.flash: Using 1-bit HW ECC scheme
> Scanning device for bad blocks
>
> I don't know where or how this happened, I think some change
> in the nand core.

I had a look and honnestly could not find where we broke this. Could it
be possible that it never worked with DT probing and only with platform
data? Any idea of what was the previously working base?

Anyhow, this is just curiosity, patch is relevant (just a little nit
below?).

> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/fsmc_nand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc=
_nand.c
> index df61db8ce466593d533e617c141a8d2498b3a180..154fd9bea3016b2fa7fa720a4=
1ef9eeed6063fd5 100644
> --- a/drivers/mtd/nand/raw/fsmc_nand.c
> +++ b/drivers/mtd/nand/raw/fsmc_nand.c
> @@ -879,7 +879,9 @@ static int fsmc_nand_probe_config_dt(struct platform_=
device *pdev,
>  		} else if (val !=3D 1) {
>  			dev_err(&pdev->dev, "invalid bank-width %u\n", val);
>  			return -EINVAL;
> -		}
> +		};

                 ^
There is a spurious ';' here, no?

> +	} else {
> +		nand->options |=3D NAND_BUSWIDTH_AUTO;
>  	}

Thanks,
Miqu=C3=A8l

