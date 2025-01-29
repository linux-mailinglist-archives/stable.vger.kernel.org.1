Return-Path: <stable+bounces-111104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD69A21A59
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E6B1666C3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE151AB6D4;
	Wed, 29 Jan 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XD36neVS"
X-Original-To: stable@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B481ACEAB;
	Wed, 29 Jan 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144262; cv=none; b=eHlCiCrr1GPYuDfVPdPCwg5jWINKrVZ8bkphWkQeHPukNv0UQX7e5uuMLNLg/BbR3jCRv97z8fWugbQIPRbngGIvqTFFNVWNzb3K0H1MX7g+0uCCRlWiz/v72J7+EznhkK8I0glwz/T5rUjPYUuDVNwMlkW8CjPPQ5N7jNlFUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144262; c=relaxed/simple;
	bh=F5/hH2eQNIxaEKR4UZ9Yifx6/1l0+sclpZ9danicZY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AUprCtLJBnlrETGmALOobHf6/jX3WKHDIGa0ZksGgLLFkoFmlrYebuSIPxL0IpSzoFq1VXds7Hfx4gHo5XgJ6s260DPUbzkJNlf2h4265n2X5kk6YolCh2zOkI3qHnqMdvqnSY6Z8PzssuoLOJYI+Fj+pA3CU9hZQ6U69VF8jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XD36neVS; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDDCD43CE7;
	Wed, 29 Jan 2025 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738144252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5/hH2eQNIxaEKR4UZ9Yifx6/1l0+sclpZ9danicZY8=;
	b=XD36neVSI3h1WebmsU2nMfPdWrLKpbXdjiBx1m6SjRy/2Qy/WYjF++Kyba9tvZ7tUy88Xn
	nfZ/sGdny6WZxOByOWG3x8sFV4IYiCqzOGAMYJTMtIBANIkDwhE3tMBB2p/S+KH6r3wb/9
	MEhSHkrmnpLmYE3BI1mT5XeACzOOe1zjKIvCJov7MINCZ0Kaa6/8apvpCjmSEHZibKYVM5
	KLR1DYDl82rl86tg5+OZMt4YQrB/Q3JdJrD0WmmjJ+AnDqrBIQz5Fm76+L3w5jAdE+Vkdu
	2tZk/bDMi/J5/M5Pu3712VPTiZl84rIPGRtJB+S8iyJJibicFIciVCTorCRbUg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  "linux@treblig.org" <linux@treblig.org>,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: rawnand: cadence: use dma_map_resource for
 sdma address
In-Reply-To: <BL3PR11MB653280E16A4399DDBB300CA8A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Wed, 29 Jan 2025 09:02:58 +0000")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-3-niravkumar.l.rabara@intel.com>
	<87ed0wpk6h.fsf@bootlin.com>
	<BL3PR11MB653280E16A4399DDBB300CA8A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 29 Jan 2025 10:50:50 +0100
Message-ID: <87wmee0wzp.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehnihhrrghvkhhumhgrrhdrlhdrrhgrsggrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepshhhvghnlhhitghhuhgrnhesvhhivhhordgtohhmpdhrtghpthhtoheprhhurghnjhhinhhji
 hgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> > Map the slave DMA I/O address using dma_map_resource.
>> > When ARM SMMU is enabled, using a direct physical address of SDMA
>> > results in DMA transaction failure.
>>=20
>> It is in general a better practice anyway. Drivers should be portable and
>> always remap resources.

I actually had a look at the kernel sources again regarding the use of
the map_resource() helper, and it is very strangely used. Sometimes the
DMA controller does the remapping, sometimes it is the slave device. The
core and headers are totally unclear about who should take the action.
Anyway, your diff is fine I believe.

> Do you think the commit message below would be better, or=20
> stick with the existing one?
>
> Remap the slave DMA I/O resources to enhance driver portability.
> Using a physical address causes DMA translation failure when the
> ARM SMMU is enabled.

Fine by me!

Thanks,
Miqu=C3=A8l

