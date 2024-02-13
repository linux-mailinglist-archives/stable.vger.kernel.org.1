Return-Path: <stable+bounces-20108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E753853B4D
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3410FB29BBD
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526F60B8E;
	Tue, 13 Feb 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ccjt6NIO"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA460B8D
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853172; cv=none; b=tZFbb24hTi9fDPoizBaiW7T5+5FxRzZo+/RBYYbhBBPmGszwHJoQF4kJ0OpQeCO5nOjtNf4W/0Q1NQDYBXpB4+ZgVXJvYW0A9vHfvLmGYBrcGZ3HKI+8qlU9ZFUrEx9nPs2Ldj898X9zDS99S5ueBeUsT4NGtYl/CI5ztYmQZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853172; c=relaxed/simple;
	bh=12PdMn9845wEQthVeQ9P6apXZCfyoHYDQhMyBEfydz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIfyZMiIa2tLTwa2158xlBaP4QJrgGHTAEb9c3NzlN81zeHFtWXNO8A4j5IDOOccpcmYwxrUuJt6Bjbj0ferbm+EAKc7Ni04b+/g/NOZCzAB/J0QwhLFgONyYnC84aOVrRpWswu9D1d2jEfrkjFvYnw1xjacM6WOlCv4mTF16Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ccjt6NIO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 710AC1BF204;
	Tue, 13 Feb 2024 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707853168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98wHR8N5swI5CcswZvQB0y4SYl7ri+xACOseh4+JLEo=;
	b=Ccjt6NIOhzWHLyjE6XydWhcyOziPE2qReXO36/nxB88YwJA9tzCnrUgBAmu8GZYqCzftU7
	U9SiCRofLlgn4DY4JpAGNbEcL2hrm4ZRxaJu604hzeiTdGi8Kj7I04N2yayVKXdDCpTf6O
	yGMCBGeUgX+acZIgOx+PYw7UKW3CbhrDpbrINR2nLZsoc4/axDWt3s/qVcZ+Sr7CZ6W20y
	8qsoiSluTBBlCusiJgIQi29tL5sbznnha1vZDJsZf1SK73xW0arhDialTpfuB0y6AZq3PQ
	xTFVXUv7D9Y6uOa2GYTbeXggroS0xEFEO4cHyn0f9l55df6igQvgJJLJrzUZ1A==
Date: Tue, 13 Feb 2024 20:39:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 <linux-mtd@lists.infradead.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Julien Su <juliensu@mxic.com.tw>, Jaime
 Liao <jaimeliao@mxic.com.tw>, Jaime Liao <jaimeliao.tw@gmail.com>, Alvin
 Zhou <alvinzhou@mxic.com.tw>, <eagle.alexander923@gmail.com>,
 <mans@mansr.com>, <martin@geanix.com>, Sean =?UTF-8?B?Tnlla2rDpnI=?=
 <sean@geanix.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4/4] mtd: rawnand: Clarify conditions to enable
 continuous reads
Message-ID: <20240213203922.27fb4884@xps-13>
In-Reply-To: <cce57281-4149-459f-b741-0f3c08af7d20@foss.st.com>
References: <20231222113730.786693-1-miquel.raynal@bootlin.com>
	<cce57281-4149-459f-b741-0f3c08af7d20@foss.st.com>
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

Hi Christophe,

christophe.kerello@foss.st.com wrote on Fri, 9 Feb 2024 14:35:44 +0100:

> Hi Miquel,
>=20
> I am testing last nand/next branch with the MP1 board, and i get an issue=
 since this patch was applied.
>=20
> When I read the SLC NAND using nandump tool (reading page 0 and page 1), =
the OOB is not displayed at expected. For page 1, oob is displayed when for=
 page 0 the first data of the page are displayed.
>=20
> The nanddump command used is: nanddump -c -o -l 0x2000 /dev/mtd9
>=20
> Page 0:
>    OOB Data: 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 |.ELF.......=
.....|
>    OOB Data: 03 00 28 00 01 00 00 00 a4 03 00 00 34 00 00 00 |..(........=
.4...|
>    OOB Data: 7c 11 00 00 00 04 00 05 34 00 20 00 06 00 28 00 ||.......4. =
...(.|
>    OOB Data: 1b 00 1a 00 01 00 00 00 00 00 00 00 00 00 00 00 |...........=
.....|
>    OOB Data: 00 00 00 00 10 05 00 00 10 05 00 00 05 00 00 00 |...........=
.....|
>    OOB Data: 00 00 01 00 01 00 00 00 e8 0e 00 00 e8 0e 01 00 |...........=
.....|
>    OOB Data: e8 0e 01 00 44 01 00 00 48 01 00 00 06 00 00 00 |....D...H..=
.....|
>    OOB Data: 00 00 01 00 02 00 00 00 f0 0e 00 00 f0 0e 01 00 |...........=
.....|
>    OOB Data: f0 0e 01 00 10 01 00 00 10 01 00 00 06 00 00 00 |...........=
.....|
>    OOB Data: 04 00 00 00 04 00 00 00 f4 00 00 00 f4 00 00 00 |...........=
.....|
>    OOB Data: f4 00 00 00 44 00 00 00 44 00 00 00 04 00 00 00 |....D...D..=
.....|
>    OOB Data: 04 00 00 00 51 e5 74 64 00 00 00 00 00 00 00 00 |....Q.td...=
.....|
>    OOB Data: 00 00 00 00 00 00 00 00 00 00 00 00 06 00 00 00 |...........=
.....|
>    OOB Data: 10 00 00 00 52 e5 74 64 e8 0e 00 00 e8 0e 01 00 |....R.td...=
.....|
>=20
> Page 1:
>    OOB Data: ff ff 94 25 8c 3c c7 44 e7 c0 b7 b0 92 5e 50 fb |...%.<.D...=
..^P.|
>    OOB Data: 80 ca a3 de e2 73 b4 4e 58 39 fe b4 85 76 65 31 |.....s.NX9.=
..ve1|
>    OOB Data: 48 86 91 f3 58 0b 59 df 2c 08 75 8b 6f 48 36 a6 |H...X.Y.,.u=
.oH6.|
>    OOB Data: bc 16 61 58 db 52 08 75 8b 6f 48 36 a6 bc 16 61 |..aX.R.u.oH=
6...a|
>    OOB Data: 58 db 52 08 75 8b 6f 48 36 a6 bc 16 61 58 db 52 |X.R.u.oH6..=
.aX.R|
>    OOB Data: 08 75 8b 6f 48 36 a6 bc 16 61 58 db 52 08 75 8b |.u.oH6...aX=
.R.u.|
>    OOB Data: 6f 48 36 a6 bc 16 61 58 db 52 ff ff ff ff ff ff |oH6...aX.R.=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |...........=
.....|
>=20
> I have checked what is happening in rawnand_enable_cont_reads function,
> and for page 0, con_read.ongoing =3D true when for page 1 con_read.ongoin=
g =3D false
>=20
> page 0:
> [   51.785623] rawnand_enable_cont_reads: page=3D0, col=3D0, readlen=3D40=
96, mtd->writesize=3D4096
> [   51.793751] rawnand_enable_cont_reads: end_page=3D1, end_col=3D0
> [   51.799356] rawnand_enable_cont_reads: con_read.ongoing=3D1
>=20
> page 1:
> [   53.493337] rawnand_enable_cont_reads: page=3D1, col=3D0, readlen=3D40=
96, mtd->writesize=3D4096
> [   53.501413] rawnand_enable_cont_reads: end_page=3D1, end_col=3D0
> [   53.507013] rawnand_enable_cont_reads: con_read.ongoing=3D0
>=20
> I do not expect con_read.ongoing set to true when we read one page.
>=20
> I have also dumped what happened when we read the bad block table and it =
is also strange for me in particular the value end_page.
>=20
> [    1.581940] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xd3
> [    1.581966] nand: Micron MT29F8G08ABACAH4
> [    1.581974] nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 4096,=
 OOB size: 224
> [    1.582379] rawnand_enable_cont_reads: page=3D262080, col=3D0, readlen=
=3D5, mtd->writesize=3D4096
> [    1.582411] rawnand_enable_cont_reads: end_page=3D0, end_col=3D5
> [    1.582419] rawnand_enable_cont_reads: con_read.ongoing=3D0
> [    1.585817] Bad block table found at page 262080, version 0x01
> [    1.585943] rawnand_enable_cont_reads: page=3D262080, col=3D0, readlen=
=3D5, mtd->writesize=3D4096
> [    1.585960] rawnand_enable_cont_reads: end_page=3D0, end_col=3D5
> [    1.585968] rawnand_enable_cont_reads: con_read.ongoing=3D0
> [    1.586677] rawnand_enable_cont_reads: page=3D262016, col=3D0, readlen=
=3D5, mtd->writesize=3D4096
> [    1.586700] rawnand_enable_cont_reads: end_page=3D0, end_col=3D5
> [    1.586708] rawnand_enable_cont_reads: con_read.ongoing=3D0
> [    1.587139] Bad block table found at page 262016, version 0x01
> [    1.587168] rawnand_enable_cont_reads: page=3D262081, col=3D5, readlen=
=3D1019, mtd->writesize=3D4096
> [    1.587181] rawnand_enable_cont_reads: end_page=3D0, end_col=3D1024
> [    1.587189] rawnand_enable_cont_reads: con_read.ongoing=3D0
> [    1.587672] rawnand_enable_cont_reads: page=3D262081, col=3D1024, read=
len=3D5, mtd->writesize=3D4096
> [    1.587692] rawnand_enable_cont_reads: end_page=3D0, end_col=3D1029
> [    1.587700] rawnand_enable_cont_reads: con_read.ongoing=3D0

Interesting, I played with those corner cases in earlier tests but
for this series I was focused on playing with filesystems and the fact
that sometimes continuous read was very sporadically breaking, so I
played with much more complex patterns but I don't remember checking
these two basic cases again...

Sorry for the breakage, I will have a look and keep you updated. I
believe the continuous read feature is fine per se, but the problem
here is that there is a mismatch between the actual operation and the
continuous read configuration on "top" of it, which should in these
cases not be enabled at all.

I am away this week, I will look into this when I'm back.

Thanks for the useful report,
Miqu=C3=A8l

