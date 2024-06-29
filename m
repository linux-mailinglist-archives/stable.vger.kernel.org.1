Return-Path: <stable+bounces-56134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5291CE74
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 19:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA10B1C20DC4
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14D132113;
	Sat, 29 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="HyvcYbt8"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749D200AF;
	Sat, 29 Jun 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683939; cv=none; b=P3twygdiG0edW04bTOPtQFsIuLpOgnctoST0bJ45L3chovND59ZcGtPpZ4ZplOwhXIiL8OG4LsFpK9TWQscXRSyuuAsA/lMHeyrSkbhMDunyYNzhl7NUqQWBCbAcBBEXY5fW6SKNYtSSVATQsU7bEU6C3Em1nBSQEvdC4sPp374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683939; c=relaxed/simple;
	bh=aLrT4oOnpymwjd8DVpGHvZEJrdv2DOdEX0kQWZpJWRA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qvQ38NKBFrT/3N3syaYx57AeLX2LwxcKt43Qig/cYsjkn1vQ7JeM5RQGlAIVIAgwrtxhzlQT7RUvoyzLJu/+qzfvKOxdeWrkxRGhWK96k2nxtd2aLWRzXRIOUh3QTBbrxFsO4xK/dbFcFjl35H0WKv53lbkGaVDM2iitjPf95Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=HyvcYbt8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1719683920; x=1720288720; i=frank-w@public-files.de;
	bh=aLrT4oOnpymwjd8DVpGHvZEJrdv2DOdEX0kQWZpJWRA=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HyvcYbt8SJ7A8KWkB1a032mAMta423UnsOZPh6Z/cAD08ObBFIif9W+6xAiEx7Uf
	 gUfW9YnxAseq0SsQcg3bajeU4DOPvCoIuBT3R3Jv4Yfr/ernWvBFi1nOrWefPcfnt
	 cdEpjSH7YbYC0HjHdcDXKnEk2nAPkXzOhBkuFXOEeZJzyLEa586GF8a+mhRUtKJAz
	 YZv1dWrI8V6YJdXqzwmXV+r/y3n+MWj1TPcrs8yWhGtvnZnmmdwFLnvI+gBq+pYto
	 Rmu0qsOA1Pg1oEKjhG/uhcG7Jqvb5qg7u6TCKVTcsPqOZddt8rBDmdaICck4uYEGW
	 aJ6nwhBUZfIRNW6CYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.77.57]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1sUV2E3kxl-008jaY; Sat, 29
 Jun 2024 19:58:40 +0200
Date: Sat, 29 Jun 2024 19:58:38 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Markus Elfring <Markus.Elfring@web.de>,
 Christian Marangi <ansuelsmth@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_arm64=3A_dts=3A_mediate?=
 =?US-ASCII?Q?k=3A_mt7622=3A_readd_syscon_to_pciesys_node?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <9f67af8b-9c8c-4ad6-88c3-03d9fd9673d2@web.de>
References: <20240628105542.5456-1-ansuelsmth@gmail.com> <9f67af8b-9c8c-4ad6-88c3-03d9fd9673d2@web.de>
Message-ID: <7B85B9EF-589B-4025-9933-847C6BDCF284@public-files.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XeJwdnckIOl1ojd6eCqyn4n7VHLmaLRB1MmDzcRq4iP+LgaqM9
 aoGV8ocSw5XCK4SmmZ1AbuTshcCrdsRGiL+8VJHOJ1BlVgb4RS0Rd85iUeJ2E7Mg0xQbLRM
 pR5Ahj6teUQXjEAd/oS/GXWScw0jHEKyEElJ3x6U02BecSyNGKNtGAs0Rx3ZO2Qs+NeqDgk
 trX5YINi4Ej7VdcpAZinA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aXtMXo6gijc=;daTEpV3dzaZ3Xfnp2LUT3IOkcIi
 ITveyJxrT/X8ytrJYBRNKr/x95owVeX/C9T7qBD/Kmtd2U3QUSPqpXFR5E4dUzjgE7g35amDP
 /zkpkeIHV8ipLjst1NnPEG0iarLJVo9Hs1Ijkzop02rQMhBEb4Bx3j4S3YB5ZvNL3n7M8oKGw
 fPdMJJduhdtG1ToRI1EpPWczgVYycNv0UBfi8yMKzwy/o6t6eEkxPNmaMrunHK8yERfyvEVEX
 NnK6zUkDwaqLEmqE7LAuNpseuRZgRFff9npL2cK5HC+PXDh3vvidymtN7GJ/UZcG5RZ7zwSdg
 RKSNV0JH1wux420g3qhWF5ovJHiOyOmOrDAaIe4nbVy37B7vgoeuXEv5tiE5BQV55XeHd+Rng
 KIS0JcpFyh6lAhixklb/llgvBEmo8SQfY1VoEYL+bYItPnghx70X4TDQNYYNN9QvsEfsF1VcG
 Eo4vsgx9MFWnawBrIMyYvil9UDpNE+MUc8ABhnF357XiVNMp1E4Wwjjctq4cRRnA0UeZrSZmc
 gKlG7PmI90ODmiecKDgsE9nOftb/zbBChNgGNKbQC5Zv88CKepaAES6A2a432Yi7nSmmPY8RV
 RMJwXhhS5xfd3x7uAaSucm1K3FZrAjsVZl3Fky+eWGhMHtOfabaTj6x3hyJsHcknYhjwotnsj
 Upg+TXk6bxPGRRIJ4uCZSbLO27nl5eZAI2VS4WODbF6RO4NgVcFBvIxu6nJv8irTJ1mnOFhAu
 G/a62lLZuVX8YJDT689FohWgNFXt92hDEOC+lz36w6rptZkal8xiTnIkhTMeLRpJIXZnRSQ98
 1vgJich+5VizoOGmB27nJlslGE7vaoitXvpEbb+5sOhuY=

Am 29=2E Juni 2024 19:35:01 MESZ schrieb Markus Elfring <Markus=2EElfring@w=
eb=2Ede>:
>> Sata node reference the pciesys with the property mediatek,phy-node
>> and that is used as a syscon to access the pciesys regs=2E
>>
>> Readd the syscon compatible to pciesys node to restore correct
>> functionality of the SATA interface=2E
>=E2=80=A6
>> Reported-by: Frank Wunderlich =E2=80=A6
>
>Was any related information published?
>
>Regards,
>Markus
>

Hi,

I found this while changing uboot to of_upstream and fixed it there (not y=
et send to mailinglist)=2E As of_upstream uses linux dts,i rechecked if it =
is broken there too and yes it is=2E

But i have not sent issue to mailinglist because we fixed it before :)
regards Frank

