Return-Path: <stable+bounces-47869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6D8D83BC
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4243F2862E6
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511C12CD91;
	Mon,  3 Jun 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eYHNDE/7"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA959B4A;
	Mon,  3 Jun 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420748; cv=none; b=hopmKHuPk/omAWcQnVMv1eXNWwWCZ+h4KKiKrkheED3ZGAc4CgpSZj4xqDwxetHrQxpQvbOCxU0uKpz92SobyzfQPk1CzJyJsBsUDjhweqvDuw1l/qXq/TxXU+zHytmECirbQ57sop2iXxEEwatE7JBIlBxD6BhSSqBGAKvllr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420748; c=relaxed/simple;
	bh=GK2AfA1M79f2aqpUrI3391kmio+ich9V7b2BHuq700E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNK5no9LGGLFQe7BMQF+6Nxf6Tq5dqHPt5iMrOEeowA0NDX9qvyH6gYEkDkGeSxFFGlbaZsPUG99QHTPBfs5Kf44INzZfGGelnkl7dywtM0ru3Godw2SaXw1dcXFC1+Chs7u6EfNuy/GdGO+xfqW2JKpWMbU9E2dYATmDbP+9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eYHNDE/7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30E74C0003;
	Mon,  3 Jun 2024 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717420744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWTAgpYCIu49JLdIyprRH1Zu4acqXIrkyC2difOhhhM=;
	b=eYHNDE/7/U/qh4LarIt8BnyirHTGA6S+fDK3gaZYjJgV0NYPn3moTUkgEyb4k9iSoaifd0
	R8X8NIkjxcU3xiGKRl+v6V9p3JMbH1Jg3sKENAL6xIyEBeKHNUJ+B2EFQZ32roQBC9MmR4
	IA9E35QFDoT8k6luSZ3MrfR22mLrUlNm2HSFVZJtPBA5yqi5oYUjSmM8PO9IpXS1lC19mr
	ZXWXmDNtePlR1x52h9XrAj+z4q0h0A4boIcqXa+qEmXhjR/MH1u9e1XQhOc8p7BLXrvyDQ
	8HgtRocYje9zcb3ch8I6vRhLsYJh9yL+XFUTukDZb7Iu+WqfLysVmcFxsbeLsg==
Date: Mon, 3 Jun 2024 15:18:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Cheng Ming Lin <linchengming884@gmail.com>, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <20240603151854.4db274a6@xps-13>
In-Reply-To: <2024060337-relatable-ozone-510e@gregkh>
References: <20240603073953.16399-1-linchengming884@gmail.com>
	<2024060337-relatable-ozone-510e@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

gregkh@linuxfoundation.org wrote on Mon, 3 Jun 2024 09:58:23 +0200:

> On Mon, Jun 03, 2024 at 03:39:53PM +0800, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>

The title prefix contains "Documentation: ", but I don't see anything
related in the diff.

> >=20
> > MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into=20
> > Linux kernel mainline.  =20
>=20
> Trailing whitespace :(
>=20
> > Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf". =20
>=20
> See the kernel documentation for how to properly reference commits in
> changelog messages.
>=20
> > For SPI-NAND flash support on Linux kernel LTS v5.4.y,
> > add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables.
> >=20
> > Those five flashes have been validate on Xilinx zynq-picozed board and
> > Linux kernel LTS v5.4.y. =20
>=20
> What does 5.4.y have to do with the latest mainline tree?  Is this
> tested on our latest tree?
>=20
> thanks,
>=20
> greg k-h


Thanks,
Miqu=C3=A8l

