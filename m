Return-Path: <stable+bounces-15779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F583BCE9
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE071C23C14
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B912B9F;
	Thu, 25 Jan 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PQ7/zBMe"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70984175BE
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173710; cv=none; b=k5BtO2l1XTEXhXR27THEA9P0ebIXiWclrbmndwv6KerbEDkfnTd0B5xq0lY1mTbl0R3ISfzGO4f/rnNkcvFhQiquGw5MRwhkwhY071DmhYbvMCKHFO/YoQquMkxQjnJALp4XJIrVtqGsE+VqeyA+R41ZsE8ohsRkAUMuw7TIxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173710; c=relaxed/simple;
	bh=VMOlO9QISWna9c+ZVb8HSdWYWBu8mo95r8aoLsS44KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vny527dO8xbkJYZR0xE3G2O+8T4s9ouFMKiInEuOUp77YKWj/aAkze8C3bigZQTptllpo5Cywd4OSAVJzOgdPhUsHtjairAGFoT4lS4ehVy/pn+dlgczAL+XG/4sB8ECIyrIIC8ZWgSlP5W/h66XMTUv/aheVLq4GRKPDmJ8XxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PQ7/zBMe; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 016271C0013;
	Thu, 25 Jan 2024 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706173702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm60V/hSeVZarANf9QjFrk14Rowm9GTafsOy25Yi66g=;
	b=PQ7/zBMewnz8DScYEO7nHAFvNC8bSqUu9MXflVeWIaqtA0J+YarVb6AesRLzDHoZQDFGHT
	Fs8EgKlM6CU/lC3yJ9kmsWUgrVrIDS20EMMlhOyZ6AKRHNFphku4WA1EJaWBuBI/WNtjux
	jBa5LmDkqkUJlZeNFYAbjDB9Xo2vuC2xfTxWq6mtNYMQQZNTYDWcRpX+OdJoor8ZKU2dBu
	lbsoSJt8xXjr/whnAnS+Z6gZnZSgPZP4ZrjlxscYfW7SgKppdIZGvgIEaXKznojUy/ZpkB
	GdROEjuho1lwd4Hgi3GC0VJKEixsZm/dTBZgMV4kpStLp2Xggu6RBez5Vqo6vw==
Date: Thu, 25 Jan 2024 10:08:20 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: jaimeliao@mxic.com.tw, stable@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spinand: macronix: Fix MX35LFxGE4AD page size
Message-ID: <20240125100820.174eb458@xps-13>
In-Reply-To: <20240125024816.222554-1-jaimeliao.tw@gmail.com>
References: <20240125024816.222554-1-jaimeliao.tw@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jaime,

+ linux-mtd which was missing to your contribution.

jaimeliao.tw@gmail.com wrote on Thu, 25 Jan 2024 10:48:16 +0800:

> From: JaimeLiao <jaimeliao@mxic.com.tw>
>=20
> Support for MX35LF{2,4}GE4AD chips was added in mainline through
> upstream commit 5ece78de88739b4c68263e9f2582380c1fd8314f.
>=20
> The patch was later adapted to 5.4.y and backported through
> stable commit 85258ae3070848d9d0f6fbee385be2db80e8cf26.
>=20
> Fix the backport mentioned right above as it is wrong: the bigger chip
> features 4kiB pages and not 2kiB pages.
>=20
> Fixes: 85258ae30708 ("mtd: spinand: macronix: Add support for MX35LFxGE4A=
D")
> Cc: stable@vger.kernel.org # v5.4.y
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>

Looks legitimate.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
> Hello,
>=20
> This is my third attempt to fix a stable kernel. This patch is not a
> backport from Linus' tree per-se, but a fix of a backport. The original
> mainline commit is fine but the backported one is not, we need to fix
> the backported commit in the 5.4.y stable kernel, and this is what I am
> attempting to do. Let me know if further explanations are needed.
>=20
> Regards,
> Jaime
> ---
>  drivers/mtd/nand/spi/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macro=
nix.c
> index bbb1d68bce4a..f18c6cfe8ff5 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -125,7 +125,7 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
>  	SPINAND_INFO("MX35LF4GE4AD", 0x37,
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,


Thanks,
Miqu=C3=A8l

