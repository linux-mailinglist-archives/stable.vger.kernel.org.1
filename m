Return-Path: <stable+bounces-114142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D2A2AE58
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C4A169EE3
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB4236424;
	Thu,  6 Feb 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SRkeT0/0"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1418DF86;
	Thu,  6 Feb 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861302; cv=none; b=Q32x74kEqN0xmqdvrJ9Mnf4nkTI9pPl5JD1p7FkbA6gk1s+qzwXvkBhS0k/mX/K8o5KqwE/VoEczrupCfhlOqIrGjN97fqQTVFrHWOgdwVPVEut0+8kubs684urOjGHkujcPLjjhVofSpTBzO5HGNmL+Vpmfy7TvXm3kc4BVA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861302; c=relaxed/simple;
	bh=UJQQI/vkueVkM4LiOEGZpMl39Ri+HuaVkJJe4HFDf9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VyaH+wVXEzgqsYTTw7VL1s0G3HYJkBPM3H+ykqdGt52v8FkC998k2YmvvTjJGOyY2dkG7Rq1g3kF79iRTo7KV6pq2LiSnZ4GuCVVZIQJSb0X3WPYQBDor5w5jO7LAutdSZjatrQDKShX6qKH5udLybNPyBgTjR/HDntee0C2T+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SRkeT0/0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54F02441CC;
	Thu,  6 Feb 2025 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738861293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJQQI/vkueVkM4LiOEGZpMl39Ri+HuaVkJJe4HFDf9s=;
	b=SRkeT0/0Z/bP3Ro4IzZ+8dyfhzZfsQt9nEN5/uqUx/7pjuFUaQwBWLfN3D/cmOnADFtOfQ
	jrOaPT02dUXFK0osuNgv+3BOxVncBdweltrde428ViMvo1LAKNOQkC1AZfE5tLBApS4lgS
	B+mo0cgeCwMzzvhKLF9OsclOAPecgsgK9qprjpKjXusE26JsVJotK2dzyXQMwrOQdHSQJW
	dfd/1x7m75Es/XA8esWOpEtJs0+tc/4tVSCoCOUlU93uo8rvjHth4q631Q64woWeh3qJdW
	OpfoBmqzsPBF6xuOW+RhpMZuwr51uZ+JVAGacgRAKcEacATJ5e814G7CdcfsvQ==
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
In-Reply-To: <BL3PR11MB653239DDBD9D8E7D413B60F4A2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Tue, 4 Feb 2025 14:11:16 +0000")
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
	<87frkt96nw.fsf@bootlin.com>
	<BL3PR11MB653239DDBD9D8E7D413B60F4A2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Feb 2025 18:01:30 +0100
Message-ID: <877c6357o5.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteehkeelvddvheehtdefkedtjeeutedthfegudekgeefleetkeettdekiefftdeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepnhhirhgrvhhkuhhmrghrrdhlrdhrrggsrghrrgesihhnthgvlhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehshhgvnhhlihgthhhurghnsehvihhvo
 hdrtghomhdprhgtphhtthhopehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> >> > My apologies for the confusion.
>> >> > Slave DMA terminology used in cadence nand controller bindings and
>> >> > driver is indeed confusing.
>> >> >
>> >> > To answer your question it is,
>> >> > 1 - External DMA (Generic DMA controller).
>> >> >
>> >> > Nand controller IP do not have embedded DMA controller (2 -
>> >> > peripheral
>> >> DMA).
>> >> >
>> >> > FYR, how external DMA is used.
>> >> > https://elixir.bootlin.com/linux/v6.13.1/source/drivers/mtd/nand/ra
>> >> > w/c
>> >> > adence-nand-controller.c#L1962
>> >>
>> >> In this case we should have a dmas property (and perhaps dma-names), =
no?
>> >>
>> > No, I believe.
>> > Cadence NAND controller IP do not have dedicated handshake interface
>> > to connect with DMA controller.
>> > My understanding is dmas (and dma-names) are only used for the
>> > dedicated handshake interface between peripheral and the DMA controlle=
r.
>>=20
>> I don't see well how you can defer if there is no resource to grab. And =
if there is
>> a resource to grab, why is it not described anywhere?
>>=20
>
> Since NAND controller do not have handshake interface with DMA controller.
> Driver is using external DMA for memory-to-memory copy.

I'm sorry you lost me again. What do you mean handshake? There is no
request line? There is no way the NAND controller can trigger DMA
transfers?

What do you mean mem-to-mem, how is this useful to the controller?

> Your point is since the driver is using external DMA and it should be
> described in bindings?

Yes. But maybe I still don't get it correctly.

Thanks,
Miqu=C3=A8l

