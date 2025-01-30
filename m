Return-Path: <stable+bounces-111707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC06A230F0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 16:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00231889180
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87EE1E9B11;
	Thu, 30 Jan 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hlX/R9OC"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512101B21A9;
	Thu, 30 Jan 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250399; cv=none; b=Tntnx2HlR/5LNkXarVSPY3mSEKv5rDOqL6q0SFAZp4TznOMM28ozKqnp1NcdITwzqW9AtueH2ZSqHyrf1VHmwO3auCqxDU9C2hl15uXMLWzPg4avS2YzkpyKcZjIOJmqaMBj1SU3gisUx0Vzze4RmKXjmZFsrV97/B15nvlIPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250399; c=relaxed/simple;
	bh=++5F+U/NM5cGq1DEAB3TXntJxWEnJwv2eL4zaC6Opxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQRMeVnhcKJnZTgJ/UgRsOvo6R/ODqfEhYqvlx+2LsboU/wPTcvy5AN2I1S7OnaIEac1paqdY5xz2wrcHnWzCsD3Hh6CauuHIR0goZLH7gHbz192BnoKVohJx9nB9CKjoX/qdXW40r589BTSi9yvCt7m9Zsjytk8GTBqPTrJOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hlX/R9OC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 535D544280;
	Thu, 30 Jan 2025 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738250395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mthSOymJzZU3NBmJRQSU6dHuOu/XGt2aFg8/OQCwRBI=;
	b=hlX/R9OCvuRRz9TzdoX5x2NhDsPTeQ5LsAlA0ZE7l7BchG9XBhMUjmgWYMOP8J0Ifhwxh7
	8Th0Hg2aH6+/RaAmzvGY6hY/vWhXV2lPSwbf5kEdzEO4gK4zbdywX+RwxhILhoRKy7jQM6
	fNkqlkYEMNYV78vY1/vJ5p2iThdAi4sITHhKRjz/Zw7kZSDEIU9auSE+P43fmxl/pWTpKl
	YknKucUQo5Yp/fGaN+jGImu45E4ZDlVgntE7qw32BP5fl2xwWKUHIq+laW92GXd0Y5W6O+
	9f8VfIxoCb+/pqjoO1HMw5wdyVChvXnyMre7kDdvxOVtELsPxPJ9/deli5pDSw==
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
In-Reply-To: <BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Thu, 30 Jan 2025 03:51:08 +0000")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	<874j1i0wfq.fsf@bootlin.com>
	<BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 30 Jan 2025 16:19:53 +0100
Message-ID: <87msf8z5uu.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehnihhrrghvkhhumhgrrhdrlhdrrhgrsggrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepshhhvghnlhhitghhuhgrnhesvhhivhhordgtohhmpdhrtghpthhtoheprhhurghnjhhinhhji
 hgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> > Driver works without external DMA interface i.e. has_dma=3D0.
>> > However current driver does not have a mechanism to configure it from
>> > device tree.
>>=20
>> What? Why are you requesting a DMA channel from a dmaengine in this case?
>>=20
>> Please make the distinction between the OS implementation (the driver) a=
nd
>> the DT binding which describe the HW and only the HW.
>>=20
>
> Let me clarify from bindings(hw) and driver prospective.=20
>
> Bindings :-
> Cadence NAND controller HW has MMIO registers, so called slave DMA interf=
ace
> for page programming or page read.=20
>         reg =3D <0x10b80000 0x10000>,
>               <0x10840000 0x10000>;
>         reg-names =3D "reg", "sdma"; // sdma =3D  Slave DMA data port reg=
ister set
>
> It appears that dt bindings has captured sdma interface correctly.

Slave DMA is very confusing because in Linux we make the distinction
between:
1- external DMA (generic DMA controller) driven
   through the dmaengine API, through which we interact using the so
   called slave API
2- peripheral DMA (DMA controller embedded in the NAND IP) when there is
   no "external/generic" engine. In this case we control DMA transfers
   using the registers of the NAND controller (or a nearby range, in
   this case), the same driver handles both the NAND and the DMA part.

You used the wording Slave DMA (#1), but it feels like you are talking
about the other (#2). Can you please confirm in which case we are?

> Linux Driver:-
> Driver can read these sdma registers directly or it can use the DMA.
> Existing driver code has hardcoded has_dma with an assumption that
> an external DMA is always used and relies on DMA API for data
> transfer.

I am sorry but DMA API does not mean much. There are 3 APIs:
- dma-mapping, for the buffers and the coherency
- dmaengine, used in case #1 only, to drive the external DMA controllers
- dma-buf to share buffers between areas in the kernel (out of scope)

> Thant is why it requires to use DMA channel from dmaengine.

If I understand it right, no :-)

Either you have an external DMA controller (#2) or an internal one (#1)
but in this second case there is no DMA channel request nor any
engine-related API. Of course you need to use the dma-mapping API for
the buffers.

> In my previous reply, I tried to describe this driver scenario but maybe =
I mixed up.=20
> has_dma=3D0, i.e. accessing sdma register without using dmaengine is
> also working.

But do you have an external DMA engine in the end? Or is it specific to
the NAND controller?

> However, currently there is no option in driver to choose between using d=
maengine and
> direct register access.
>

Thanks,
Miqu=C3=A8l

