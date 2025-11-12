Return-Path: <stable+bounces-194601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C097C51CD0
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C67104EB3FC
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6F3019C5;
	Wed, 12 Nov 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mizS3kv6"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DC29BD9B
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944645; cv=none; b=MsNUGU1Oo1zKeCnRcdfEexLEmQQMTc9gmmVP3IskfG+yqcaZ5BT9H0FqzHKYh7r2u5Urodb3hPV/rLygz+Pi9MGLVfhoeusg1yKJREJNXS5jENvFRmT18sY2yj90VrqxHzpCK/lQBbWHUtbx6d+EvdXm07c2wU5yUfOJHCF0/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944645; c=relaxed/simple;
	bh=0+unaSKUFdFHJhkY4RjZVR+uXBrXziaM/doRPyYlSzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUrrqBhi1V3wtIyvRtW3BoiLSiUBpeFH0FR1TDAALVOHJKTSDMnUzQqTqVJb7MBdtN+3GCvsvSOCl3zHuM34NCp4pwXbLImhfrDdroT6skKyHV5d1FX8gPWZl6HX2Pm31s/xnd1skLrAmqgAJx+979tuSErY2oMu6QIau3CHywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mizS3kv6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F081E1A1A00;
	Wed, 12 Nov 2025 10:50:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C59876070B;
	Wed, 12 Nov 2025 10:50:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 768F3102F1699;
	Wed, 12 Nov 2025 11:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762944640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0+unaSKUFdFHJhkY4RjZVR+uXBrXziaM/doRPyYlSzQ=;
	b=mizS3kv6uoJgba8W4pJm2oS1mrMVnDNPFVJGQtU9ZgSJ701Y4ZdRvd79WEdYs8x9oSCo2s
	eib7tTolLYvjh7nAX9IW6fY5GD8Dgi75aZpad/kIZtuuxlEK/m2S4KhbjV1/IpEbPG4YM2
	BFwpY/jSKDhFPWfHHmicaiK5iFxE+KicBh5szT0Jp1pNgGc7eO6h5gHI90amSMyC1579zS
	Bz8F33OK+M9WL7/qMB9goIa/Hl52oAH+mAW7AeSQ+z73GxrFCxw7aWX7rc5S4dU7E2bytQ
	Vego2TDdagK+fyvI6188iQ+SZ7qAHIr4CIpclwQWxXBNFSNm/te+7wtwhoAAEA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on
 subpartitions
In-Reply-To: <691456b8.050a0220.3c21b3.5c4c@mx.google.com> (Christian
	Marangi's message of "Wed, 12 Nov 2025 10:43:17 +0100")
References: <20251109115247.15448-1-ansuelsmth@gmail.com>
	<87y0ob7fyy.fsf@bootlin.com>
	<691456b8.050a0220.3c21b3.5c4c@mx.google.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 12 Nov 2025 11:50:36 +0100
Message-ID: <87ikffikxv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 12/11/2025 at 10:43:17 +01, Christian Marangi <ansuelsmth@gmail.com> wro=
te:

> On Wed, Nov 12, 2025 at 10:33:25AM +0100, Miquel Raynal wrote:
>> Hi Christian,
>>=20
>> On 09/11/2025 at 12:52:44 +01, Christian Marangi <ansuelsmth@gmail.com> =
wrote:
>>=20
>> > Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
>> > result") introduced some kind of regression with parser on subpartitio=
ns
>> > where if a parser emits an error then the entire parsing process from =
the
>> > upper parser fails and partitions are deleted.
>> >
>> > Not checking for error in subpartitions was originally intended as
>> > special parser can emit error also in the case of the partition not
>> > correctly init (for example a wiped partition) or special case where t=
he
>> > partition should be skipped due to some ENV variables externally
>> > provided (from bootloader for example)
>> >
>> > One example case is the TRX partition where, in the context of a wiped
>> > partition, returns a -ENOENT as the trx_magic is not found in the
>> > expected TRX header (as the partition is wiped)
>>=20
>> I didn't had in mind this was a valid case. I am a bit puzzled because
>> it opens the breach to other special cases, but at the same time I have
>> no strong arguments to refuse this situation so let's go for it.
>>=20
>
> Thanks a lot for accepting this. I checked all the parser both upstream
> and downstream and I found this ""undocumented"" pattern of returning
> -ENOENT. [1] [2] [3]
>
> For sure it's a regression, we had various device on OpenWrt that broke
> from migrating from 6.6 to 6.12. I agree there is the risk you are
> pointing out but I feel this is a good compromise to restore original
> functionality of the upstream parsers.
>
> (the other error condition are -ENOMEM or sometimes -EINVAL for parser
> header present but very wrong)
>
> [1] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/t=
plink_safeloader.c#L93
> [2] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/s=
cpart.c#L170
> [3] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/o=
fpart_bcm4908.c#L47

Thanks for the digging. I will apply this to -next and not -fixes. It
will be slightly longer to get it backported, but this gives a bit more
time for this patch to be thought about as I plan on sending my fixes PR
in the next days.

Miqu=C3=A8l

