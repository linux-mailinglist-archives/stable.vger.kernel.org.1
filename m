Return-Path: <stable+bounces-114249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F76A2C36B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C301654FB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942021EA7F3;
	Fri,  7 Feb 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="afh4qDIV"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B99454;
	Fri,  7 Feb 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934528; cv=none; b=XHVlLDVMkRmjKLaI8PFnHyYC6T11JhScAlslr9zzCTV9tHjPc82ABeib58JOKyofpmQOXHdz8/BWolXJ2rTSn8WbHeIoLJKjC6t4koyC68Xn359tfV5FdWMx5xWUlcqFXK1AKSj/FkPlLpQGjEgAWN6UM/Jti7SrI8PaEpMTvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934528; c=relaxed/simple;
	bh=x3MPmRQLk1AbgqBDCcQ3vNHDApwtWPJ2zOR9fDuK2UY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZqATvrqv5UHq7tuqqOOo8klfYwHhyr7tR2gpWQ1w2uPnzzEkifFlb37/jh6JhQkfwd13P3hijezs4v6HGaXxBPra9qd7n93HGLwxZaMHsugceh3fSaMLPJqttfgf/bPrWmxDv4XfZ1PUVUyKS5TAzAGpY7JvQWsXRxpPJg33ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=afh4qDIV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 757C044408;
	Fri,  7 Feb 2025 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738934523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAoBxYtUrA+ImixRo4h70vs5ozOMbJ+LCR06GvVPFo4=;
	b=afh4qDIV12OqDpxGG9POlW/Ful9p+5JGQ5qX3/lTlhDj5DUKDoL5jTNdjweBuT6KjAxufx
	dddXk3qct2y18ieVIkccL3yPotdffCSZKl0bq0LnUu1rkTcsaQfZ2SOD1HawnHLhiG5UtV
	satrL61jVdC+nRv3WQbrtpBvEhOXX+wefn5P1seGOUuud7vc8KnIc8e7jsKaqIB119V8fx
	S5prJcTsbD4km1s6jbbThG14GmOpeYLZjqn4gc7aBroQapHT/Zq/boIRoz1gfLo4Afu5Kd
	qY22F5tMCVb0Nbq+RJpPlmU3t5yGf2bCrHCdhFpfQqKGFbdEol+sJ4wU/QagUw==
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
In-Reply-To: <BL3PR11MB65320CBE12D13EBD3940CE44A2F12@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Fri, 7 Feb 2025 09:12:44 +0000")
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
	<877c6357o5.fsf@bootlin.com>
	<BL3PR11MB65320CBE12D13EBD3940CE44A2F12@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Feb 2025 14:22:01 +0100
Message-ID: <87ikpl3n5y.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueegtdekjeekueekfeeuudekkedutdejhfefgfevtdeutdetgfduvdfggfffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehnihhrrghvkhhumhgrrhdrlhdrrhgrsggrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepshhhvghnl
 hhitghhuhgrnhesvhhivhhordgtohhmpdhrtghpthhtoheprhhurghnjhhinhhjihgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com


>> >> >> > My apologies for the confusion.
>> >> >> > Slave DMA terminology used in cadence nand controller bindings
>> >> >> > and driver is indeed confusing.
>> >> >> >
>> >> >> > To answer your question it is,
>> >> >> > 1 - External DMA (Generic DMA controller).
>> >> >> >
>> >> >> > Nand controller IP do not have embedded DMA controller (2 -
>> >> >> > peripheral
>> >> >> DMA).
>> >> >> >
>> >> >> > FYR, how external DMA is used.
>> >> >> > https://elixir.bootlin.com/linux/v6.13.1/source/drivers/mtd/nand
>> >> >> > /ra
>> >> >> > w/c
>> >> >> > adence-nand-controller.c#L1962
>> >> >>
>> >> >> In this case we should have a dmas property (and perhaps dma-names=
),
>> no?
>> >> >>
>> >> > No, I believe.
>> >> > Cadence NAND controller IP do not have dedicated handshake
>> >> > interface to connect with DMA controller.
>> >> > My understanding is dmas (and dma-names) are only used for the
>> >> > dedicated handshake interface between peripheral and the DMA
>> controller.
>> >>
>> >> I don't see well how you can defer if there is no resource to grab.
>> >> And if there is a resource to grab, why is it not described anywhere?
>> >>
>> >
>> > Since NAND controller do not have handshake interface with DMA
>> controller.
>> > Driver is using external DMA for memory-to-memory copy.
>>=20
>> I'm sorry you lost me again. What do you mean handshake? There is no
>> request line? There is no way the NAND controller can trigger DMA transf=
ers?
>>=20
> Yes, I mean there is no request line, so there is no way the NAND control=
ler can
> trigger DMA transfer.
>
> Sorry I used the terminology based on Synopsys DesignWare AXI DMA Control=
ler
> that is used with Agilex5 SoCFPGA platform.=20=20
> https://github.com/torvalds/linux/blob/v6.14-rc1/drivers/dma/dw-axi-dmac/=
dw-axi-dmac-platform.c#L1372
>
>> What do you mean mem-to-mem, how is this useful to the controller?
>>=20
> I mean system memory to/from NAND MMIO register address for page
>  read/write data transfer.=20
>
> 	reg =3D <0x10b80000 0x10000>,=20
> 		<0x10840000 0x1000>; <--- This MMIO address block
> 	reg-names =3D "reg", "sdma";
>
>> > Your point is since the driver is using external DMA and it should be
>> > described in bindings?
>>=20
>> Yes. But maybe I still don't get it correctly.
>>=20
> dmas is an optional property in cadence nand controller bindings.=20
> https://github.com/torvalds/linux/blob/v6.14-rc1/Documentation/devicetree=
/bindings/mtd/cdns%2Chp-nfc.yaml#L36
> Does it need to change to required property in bindings?

On one side you have a dedicated MMIO region, which imply we should have
an external DMA engine that is probably generic. On the other side it
feels like only the NAND controller uses it and it should be pictured as
a peripheral DMA controller and in this case we should not use the DMA
engine API at all. Your case is something in between, I don't like it
much. Anyway, we cannot break bindings, so please respin the series
because I totally lost your initial target.

Miqu=C3=A8l

