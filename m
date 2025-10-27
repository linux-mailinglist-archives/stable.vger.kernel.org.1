Return-Path: <stable+bounces-190014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD9C0ED5A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556A3464216
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CC2D12E7;
	Mon, 27 Oct 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AE64DYqH"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE64A3E;
	Mon, 27 Oct 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577471; cv=none; b=faIiRoA9sw2+XCwCea3VfZLpt2WQBYT1ltwzRS8QTZWpIpl7MZKPe7qxgcsinKG3h8dmqbASIichuP3UbvrIC0uDdYCtROadS6d4pj7itIUVyz393jtEarZvJhAunwJDYx4XcvaZqdvlAUV/eHeY8a285yZMqT1sGFTGpSPf0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577471; c=relaxed/simple;
	bh=TmqNnd/b7ZzA9B8s9Hq0HIEIEmiflsvLoR5faerHGNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KWH/kF7WJNKr0MQIK2Vkh5zTF+U+JrVAKbyGki6u3SS72lSnVeqL4YKkctyxgr9SqjHBp7/lnJv0IkUM9bRMMCtXVWVuxMWQFFlQ8dYl2Ql2JzYn5swljIP7f6GxYmjtEudBVi3ZyVt1U4f7lDwTyLvg5QK7h9MG/DZDuHS6K6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AE64DYqH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 977B51A16DA;
	Mon, 27 Oct 2025 15:04:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B2876062C;
	Mon, 27 Oct 2025 15:04:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3C40102F24D3;
	Mon, 27 Oct 2025 16:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761577466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oR3xHK66IvxkAJonlfP0A+qAw3zMjh3EBogsOU6SzqE=;
	b=AE64DYqH6b4guLExjNXBUXYsgzTMtTCFa58jfRvwsdeKCFjk3QzlG9+09/zKttszVggnj+
	VUUxC1WKGoB4zJwbVUQM3lfMzx07d0/sgiuMKUZwiWofWiEpeVJCnuv1kVw6q0NWlhfMUt
	iY3kAVzu42zV/Ao0dg0InWN2GTvJkZLWNSccR7/sApfZe4ZZDACGUMEmRKnrZ7NReKwNNa
	vojJeVVUKdUvWqf5hpEU9YorjebFz5ixx4E8BbZX+7hxHoZxVXp54Un/LiT3ca1noDfxrX
	LivJaWz0Bq+UH8MIYeJjDdT3dwvHEAPzbg/U0hgc5yzDG7JXhp89hYU3YoYFxQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miaoqian Lin <linmq006@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nam Cao
 <namcao@linutronix.de>, Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
 Miroslav Ondra <ondra@faster.cz>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: linmq006@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: prefer dma_mapping_error() over
 explicit address checking
In-Reply-To: <20251027092053.87937-1-linmq006@gmail.com>
References: <20251027092053.87937-1-linmq006@gmail.com>
Date: Mon, 27 Oct 2025 16:04:19 +0100
Message-ID: <87a51ce68c.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Miaoqian Lin <linmq006@gmail.com> writes:

> Check for returned DMA addresses using specialized dma_mapping_error()
> helper which is generally recommended for this purpose by
> Documentation/core-api/dma-api.rst:
>
>   "In some circumstances dma_map_single(), ...
> will fail to create a mapping. A driver can check for these errors
> by testing the returned DMA address with dma_mapping_error()."
>
> Found via static analysis and this is similar to commit fa0308134d26
> ("ALSA: memalloc: prefer dma_mapping_error() over explicit address checki=
ng")
>
> Fixes: 58ac1b379979 ("ARM: PL011: Fix DMA support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>


Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/amba-pl011.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 22939841b1de..7f17d288c807 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -628,7 +628,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port =
*uap)
>  	dmatx->len =3D count;
>  	dmatx->dma =3D dma_map_single(dma_dev->dev, dmatx->buf, count,
>  				    DMA_TO_DEVICE);
> -	if (dmatx->dma =3D=3D DMA_MAPPING_ERROR) {
> +	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
>  		uap->dmatx.queued =3D false;
>  		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
>  		return -EBUSY;
> --=20
> 2.39.5 (Apple Git-154)
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

