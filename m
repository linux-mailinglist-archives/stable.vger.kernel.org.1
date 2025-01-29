Return-Path: <stable+bounces-111103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CBA21A4C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2B91884FA9
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25CA1ACEB7;
	Wed, 29 Jan 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ohWyyJbW"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71970194C78;
	Wed, 29 Jan 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144139; cv=none; b=nS7VnHP30fZDKc/jEV4PjyoKoUdWsdN4f+q9ujPfNUijwNm/ryRRSXPAGVx9Dm8tV33RDY0CnqvWZmD4XbTDmfgyvjG+oCzfCGX26VuIigfqoGw2EG6343bLnOaoKhggQ0fibgUdbhpuqfXJG0958/WSrOrZbHnR0/vGPljSsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144139; c=relaxed/simple;
	bh=oVuTnPCAKwBS/56T6+nHjnL7KVAXlq5ifzpL9W0xdGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDEvaVQo3nBQttTja21KiwdZ4SmdTz/knci74OFxVVsM2fX/usujZlby4LJ5eaGmCz/s/HiOdC9vg04Aklc031U3NKRjgIMfwffw34BM7WnbbMNFH9ZpsxBmmk9oPkUb/miXr8kaB/DFxunCTVfwn4r39kK1yDt10qMAJdmbuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ohWyyJbW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5D4C43315;
	Wed, 29 Jan 2025 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738144130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVuTnPCAKwBS/56T6+nHjnL7KVAXlq5ifzpL9W0xdGc=;
	b=ohWyyJbW9yvb8lNnxzxXHrJQwwJBvbzdYapsglHzzBA+kJQrfHrWoHl7ingGsr/jY1GmlH
	yDFZJR1zQ++ejCSW4/3L5LihddHaG7TzxerIAU+CLJvjY27mi64B6q0bkdp36ojGcLG23v
	R4PslEJ2xVTtiShsNmEJnMAdKeEuwU5+T4Kgs+uCS+4YnNr5t8Yr2KSHDgMoi0A6h+hnEH
	siYeltGLgQztVJwPT+o17LYgQtU2e2244uaZnZoMS+4k7N7n0bcUQLqxH7LwOSd4Mftmgx
	QArq09wenyO1C6s2BDiLa/wSqKQO0w9M7mjoNXF5k5R5RS/HkK7aswM3IfhNpA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  "linux@treblig.org" <linux@treblig.org>,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mtd: rawnand: cadence: fix incorrect dev context
 in dma_unmap_single
In-Reply-To: <BL3PR11MB653275BDFAB8FAA2EC499666A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Wed, 29 Jan 2025 08:58:56 +0000")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-4-niravkumar.l.rabara@intel.com>
	<875xm8pk4n.fsf@bootlin.com>
	<BL3PR11MB653275BDFAB8FAA2EC499666A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 29 Jan 2025 10:48:47 +0100
Message-ID: <878qqu2bnk.fsf@bootlin.com>
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

>> > dma_map_single is using dma_dev->dev, however dma_unmap_single is
>> > using cdns_ctrl->dev, which is incorrect.
>> > Used the correct device context dma_dev->dev for dma_unmap_single.
>>=20
>> I guess on is the physical/bus device and the other the framework device=
? It
>> would be nice to clarify this in the commit log.
>>=20
>
> Noted. Is the commit message below acceptable?=20
>
> dma_map_single is using physical/bus device (DMA) but dma_unmap_single
> is using framework device(NAND controller), which is incorrect.
> Fixed dma_unmap_single to use correct physical/bus device.

Ok for me.

Thanks,
Miqu=C3=A8l

