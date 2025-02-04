Return-Path: <stable+bounces-112149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62178A27360
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3201882842
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6620DD6C;
	Tue,  4 Feb 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kv4bzN9o"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304529CEB;
	Tue,  4 Feb 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675985; cv=none; b=d1RtGN3lL002Ypu9wnEsBeGCmLBqdaadFv9H5TxQ/PYx43wHfcpUSxRQ4QJbAT8TDDuwmCPHhIPWwMShF8hwefNT2xOTF6vimkMXD/EkD5sTAaPcJH2R1yiMx/4PLwjgo6yB+l5iUdRcWDlSdyqEE0ibMYVb+h+AZi6X6Y7rnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675985; c=relaxed/simple;
	bh=5mH9LB5DunDIjPd1SMurzuCEO+7lGZ04kevPMYpIDU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqWiEgdITB6/sWKuwqcnt/+Z876SBMyySUCKHLi5/3N6ivp3amhw+P44XjgIqab02sqjaz2u8p4Po9ZkG+D84iIb4NX+oDYrsNcTL6nTQStMxoMH4hooD6aXI3h8LARZKk9v9a+hONGX/XtFe1jykS/dMMZGGGsPOtOngdnDZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kv4bzN9o; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF0C3204AC;
	Tue,  4 Feb 2025 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738675974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mH9LB5DunDIjPd1SMurzuCEO+7lGZ04kevPMYpIDU0=;
	b=Kv4bzN9oj1skiwQaACJfFZSDU+mIMpGXc9ncjJFp1/ku1ZBCY2IINbH7D9roCTDAZuBuGw
	IUdD8hJ7szkj2i1H5zMLYEgEbYqXY/tYhU3KPf2xrj3cHr26PrXU3r9BPZfS5jI1UplZ1m
	QN0+Kr+g+ODNjJ3wQ2Xtijw3Ux6v2Oh7S5ley8gwEW5SpNT7TITmGZ0prGtiBxCyK2fEfh
	G1xNi/Wg/e/Ydns8MZNQ+thHgnXMa8B/aiDlXkQwMBEJHQLhzh/fQTiuUHczKPuZ1eVI2G
	5XGtPF496+zdNeQedQNsd17w7+oX4bRhkcB0b0qDIVmd6TOXbneAJ5I1eSW89Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  "linux@treblig.org" <linux@treblig.org>,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob
 when DMA is not ready
In-Reply-To: <BL3PR11MB6532369D14375CC94AA2714BA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Tue, 4 Feb 2025 10:43:20 +0000")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	<874j1i0wfq.fsf@bootlin.com>
	<BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87msf8z5uu.fsf@bootlin.com>
	<BL3PR11MB6532451B44E7C5D82F5EC4AFA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
	<87o6zi83se.fsf@bootlin.com>
	<BL3PR11MB6532369D14375CC94AA2714BA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Feb 2025 14:32:51 +0100
Message-ID: <87frkt96nw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteehkeelvddvheehtdefkedtjeeutedthfegudekgeefleetkeettdekiefftdeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepnhhirhgrvhhkuhhmrghrrdhlrdhrrggsrghrrgesihhnthgvlhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehshhgvnhhlihgthhhurghnsehvihhvo
 hdrtghomhdprhgtphhtthhopehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 04/02/2025 at 10:43:20 GMT, "Rabara, Niravkumar L" <niravkumar.l.rabara@=
intel.com> wrote:

> Hi Miquel,
>
>> -----Original Message-----
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>> Sent: Tuesday, 4 February, 2025 5:20 PM
>> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
>> Cc: Richard Weinberger <richard@nod.at>; Vignesh Raghavendra
>> <vigneshr@ti.com>; linux@treblig.org; Shen Lichuan <shenlichuan@vivo.com=
>;
>> Jinjie Ruan <ruanjinjie@huawei.com>; u.kleine-koenig@baylibre.com; linux-
>> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; stable@vger.kerne=
l.org
>> Subject: Re: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob=
 when
>> DMA is not ready
>>=20
>> Hello,
>>=20
>> > My apologies for the confusion.
>> > Slave DMA terminology used in cadence nand controller bindings and
>> > driver is indeed confusing.
>> >
>> > To answer your question it is,
>> > 1 - External DMA (Generic DMA controller).
>> >
>> > Nand controller IP do not have embedded DMA controller (2 - peripheral
>> DMA).
>> >
>> > FYR, how external DMA is used.
>> > https://elixir.bootlin.com/linux/v6.13.1/source/drivers/mtd/nand/raw/c
>> > adence-nand-controller.c#L1962
>>=20
>> In this case we should have a dmas property (and perhaps dma-names), no?
>>=20
> No, I believe.
> Cadence NAND controller IP do not have dedicated handshake interface to c=
onnect
> with DMA controller.
> My understanding is dmas (and dma-names) are only used for the dedicated =
handshake
> interface between peripheral and the DMA controller.

I don't see well how you can defer if there is no resource to grab. And
if there is a resource to grab, why is it not described anywhere?

Thanks,
Miqu=C3=A8l

