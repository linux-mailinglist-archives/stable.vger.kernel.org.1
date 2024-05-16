Return-Path: <stable+bounces-45251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B58C7246
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413261C20C1F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C85025A;
	Thu, 16 May 2024 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KY9HiCbo"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D19282EF
	for <stable@vger.kernel.org>; Thu, 16 May 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845985; cv=none; b=grfneYMnmmu8IDERJRUbcTwJLQhSLUEms0FKkUXyP+L1jrcsyn1rn8dqIFFgJKsSMpKd+d/qPo+ySrkNRja/zwii+cGlc8nBYei7k6N3Ax7G3D1RUWXs8uvCSkm8z4sT98jQb3nogCeJ11ZiUo4lLD2u+5dSVKWQssTMaj4UyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845985; c=relaxed/simple;
	bh=sBNUDiMrZw2H4KCzXHiJhbdLF/HKwWUfX7Zq6lXHlZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc6ZiFf0M4YURHzr9QhaSaOQLY+8l85NOC7YqezM382EIdvyj5rbwz3+wo3XXrXR3tEZCV32O9hpB74v5QLH1gEQegjteI1Ycjlyg0JBulYKDaqPby8cVjpfDEJOpS78PMM7+mtUZDOHkYuT8PFEt+qIdwjs20O3HylRxIzE288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KY9HiCbo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15CAA1C0007;
	Thu, 16 May 2024 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715845979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgJ3Llky/QfG8NT7dqX+eduKgJw2O/SWp7aGIaNCak8=;
	b=KY9HiCboAzjSxvfbQpdL8Wt4hcrCtQ/X3T70xQsxU//9/647Iwp2OHVRBofH9bfOtkP0um
	bVbtN9Ob5M/IH/PGSW7m6J+IaGZJ4SuspUY4u207r6se4RIsIdgSduul6p5YYB5fLAGQ/M
	1mY+frALkvOwpONN1vPzVQIcVJycCz3vUs6k4UXMbcp2ERnPXok+Syy6PvAxsu+sYbbDR9
	IBcbgxmD5rCH3iT09T7RlijrZL+JLUxp+am85sNVit8ITpyc4AjN79BT57DnRVlv8wAo6x
	QnxO9u3PnzqVqGdNIVqTKTGpAZMtI4txqpHVbbG9/xe2gO+IH0fGHaFYJNVjuw==
Date: Thu, 16 May 2024 09:52:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: Bypass a couple of sanity checks
 during NAND identification
Message-ID: <20240516095257.18ad0017@xps-13>
In-Reply-To: <DM6PR05MB450689909396CB80A56B8732F7E32@DM6PR05MB4506.namprd05.prod.outlook.com>
References: <20240507160546.130255-1-miquel.raynal@bootlin.com>
	<20240507160546.130255-3-miquel.raynal@bootlin.com>
	<DM6PR05MB450689909396CB80A56B8732F7E32@DM6PR05MB4506.namprd05.prod.outlook.com>
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

Hi Steven,

steven.seeger@flightsystems.net wrote on Tue, 14 May 2024 17:57:46
+0000:

> On Tuesday, May 7, 2024, Miquel Raynal wrote:
>=20
> >So, if the fields are empty, especially mtd->writesize which is *always*
> >set quite rapidly after identification, let's skip the sanity checks. =20
>=20
> I noticed this when first looking at my board with the bitflip in a NAND =
chip's parameter page. I just assumed that since I was setting it up to do =
column change operations, I needed to add this in at the time. Looking at i=
t now, since this information is being supplied by me before the scan, it's=
 wrong.  So I agree it's a bug, but I didn't think about it again since I w=
as tackling the bug of trying to read additional parameter page copies furt=
her down the page due to the bitflip.
>=20
> I don't have access to the board right now, but when I get to it again I =
can try this patch. I will need to remove what I already added in to check =
and reply back. It may be a few weeks, though.
>=20
> On another note, I think that this entire API would benefit from discoura=
ging hybrid approaches. I implement function overloads for things like ecc.=
read_page, write_page, read_page_raw, etc, but also use the exec function f=
or things like erase, read id, read parameter page, etc. I maybe did it "wr=
ong" but it works. Past drivers I've done use the legacy cmdfunc, so this w=
as my first attempt at using the command parser. I suspect there are a lot =
of people like me writing drivers for proprietary hardware that uses FPGAs =
to do some of the NAND interaction, rather than direct chip access as the A=
PI was originally designed for.

I don't know what you mean with direct chip access. ->cmd_ctrl() and
->cmdfunc() were desperately too simple and many drivers started
guessing what the core was trying to do, making it very hard to
extend/modify the core without breaking them all. This was sign
of an inadequate design and hence ->exec_op() (providing all the
operation) was introduced.

Just to make it clear, the original APIs were totally fine back then,
but controllers evolved, became smarter^W more complex, until the APIs
were no longer fitting.

> So, to explain further, read_page triggers my addr/chip select, read page=
 command, and retrieving the buffer. Read parameter page goes through the c=
ommand parser, as does the column change op, with some state variables to k=
eep track of where in the read cycle we are so that each copy of the parame=
ter page data can be accessed in the buffer. I lament the lack of consisten=
cy here. But, it works and the customer is unlikely to want to change anyth=
ing at this point. :)

The logic is:

- Early at boot you need to identify the chip, its parameters, its
  configuration, etc.

  -> exec_op() is used

- During normal operation, it's time for I/Os. Using ->exec_op() again
  can work, but most of the time these operations can be done faster
  with a more custom approach, especially since most controller drivers
  embed and ECC engine that also needs to be managed during these
  accesses.

  -> your page helpers are here for that

- During debugging you might want to perform raw page reads,
  performance does not matter here but the data layout in the chip is
  NAND controller and ECC engine specific, while the user expected
  layout is: [all the data][all the oob].=20

  -> your raw page helpers are here for that

And there are standard helpers provided in the core if your controller
does not need specific implementations. You may want to use them
because it makes your life easier, they will use ->exec_op().

Thanks,
Miqu=C3=A8l

