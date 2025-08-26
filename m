Return-Path: <stable+bounces-172936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB533B35A40
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867471897BA8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DEA334379;
	Tue, 26 Aug 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="gHASm2ES"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11B301021;
	Tue, 26 Aug 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205064; cv=none; b=GU0cQpP9lfsRAyZUMcBvJJl/eNbUYZK8gtG7F929dHeqHZ1UFggJ+hFIp2aADYlf5T9+q9G2F1cklHb76mi3xY8drolXOk7V+nv151nbK0Eu9gvczHbHGnW1I6ih5c+aWpoxXWzdCuVfTqRaul53SSMlSx2PVa0kciVO/0MGigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205064; c=relaxed/simple;
	bh=IF68GH+EbXIyK+UeQ0WTm/EWLoqcYsqJS4TSMfVq6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf57QTG0F6K5fxi30otFp4M/RxaSb3gFhNm/jj0SyeB4yTLDFavY73Tr+deIYp51UsA1OAuQrFykeTCaULjREkwQamHmkxzUz1ABTxbbBvepdMvPab/J+gzm535B+ixsnYAgjQvDtWglFeFCLeEYDX+Mb/fnvPGRoMtSufBAoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=gHASm2ES; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 126661484416;
	Tue, 26 Aug 2025 12:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756205055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KwLQqQaMoEE+Hv1ZG6dhCcc/rDPs+TlmKuOnBY34Nv0=;
	b=gHASm2ESs1rHyh92A6xH9vOgeJ18Q2+bcxVpa9MXJ00778LYLJ3oO6LyJt5mVWzcS/K5oa
	GZsAoJCgfuuKMSrkOTD0EL9y/yyo1iTiiW49gR2zKA+cLsdxQwh3Sj9Xvm0fnU5kmYUiy0
	Vkkjs9KSveVfRuJ/u6/zjR9jRI38SJdat918MpT8nmvsR9JgfC5s4R57eWyKV9LP0RYSXY
	yNNssAaegaU+Q/K5GsWd8V5w9pMBOy3pqkeXt4/7E7tV9o9/36j+6twrWhXAoyJg3yvVwM
	CEcN7tCTQmyNt5V0PP4nMoBe5m8xO3BLgDLydiKcN/UQxTcMxmISi+HYIQOoRA==
Date: Tue, 26 Aug 2025 12:44:08 +0200
From: Alexander Dahl <ada@thorsis.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "Balamanikandan.Gunasundar@microchip.com" <Balamanikandan.Gunasundar@microchip.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"richard@nod.at" <richard@nod.at>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"bbrezillon@kernel.org" <bbrezillon@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read
 setup timing
Message-ID: <20250826-wake-jet-e15c7a209bb4@thorsis.com>
Mail-Followup-To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"Balamanikandan.Gunasundar@microchip.com" <Balamanikandan.Gunasundar@microchip.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"richard@nod.at" <richard@nod.at>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"bbrezillon@kernel.org" <bbrezillon@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
 <20250825-uneven-barman-7f932d0ca964@thorsis.com>
 <3d0259caac9925e3d5dd3dd27a6785b2a2e82c0b.camel@siemens.com>
 <20250825-vista-cuddle-c159a6bd97ec@thorsis.com>
 <513ad54017eb96a55176d232ce1464ff51bf452f.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <513ad54017eb96a55176d232ce1464ff51bf452f.camel@siemens.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Alexander,

Am Mon, Aug 25, 2025 at 01:41:05PM +0000 schrieb Sverdlin, Alexander:
> Hi Alexander,
> 
> On Mon, 2025-08-25 at 15:22 +0200, Alexander Dahl wrote:
> > > > Threw this on top of 6.12.39-rt11 and tested on two custom platforms
> > > > both with a Spansion S34ML02G1 SLC 2GBit flash chip, but with
> > > > different SoCs (sama5d2, sam9x60).  We had difficulties with the
>                                           ^^^^^^^^^^^^^^^^^^^
> [*]
> 
> > > > timing of those NAND flash chips in the past and I wanted to make sure
> > > > this patch does not break our setup.  Seems fine in a quick test,
> > > > reading and writing and reading back is successful.
> > > 
> > > thank you for your feedback!
> > > 
> > > Do you see an opportunity to drop the downstream timing quirks with my patch?
> > 
> > Which downstream do you refer to?
> 
> That's how I understood the phrase above, that some adjustments are still required
> on your side additionally to standard timings. Sorry for the confusion, if it turns
> out to be a misunderstanding on my side!

I don't think your patch is sufficient to solve our problems with
sam9x60 and S34ML02G1.  Different parts of the timings are affected.
You changed NRD_SETUP while I changed NRD_PULSE.  I just wanted to
make sure both patches do not interfere.

For reference, these are the changes in at91bootstrap and u-boot I
referred to:

https://github.com/linux4sam/at91bootstrap/issues/174
https://github.com/linux4sam/at91bootstrap/commit/e2dfd8141d00613a37acee66ef5724f70f34a538

https://source.denx.de/u-boot/u-boot/-/commit/344e2f2cd4a407f847b301804f37d036e8a0a10c

My problem might be fixed with commit f552a7c7e0a1 ("mtd: rawnand:
atmel: set pmecc data setup time"), but I did not have time to test
that assumption.

Sorry for the confusion.

Greets
Alex


