Return-Path: <stable+bounces-172857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333DEB34090
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A668207722
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55459270ED9;
	Mon, 25 Aug 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="TiJ2yGu/"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B726E6EA;
	Mon, 25 Aug 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128159; cv=none; b=rNO8+pkANfUfAVahI99TsFofgsBwm55m5WV6f0N6wEUCf+a/rLTFV9n/E3fJEfJ26n9DuDUFZoxf7UGOkzLBad5hsqRiCefMuShvdU//dvPBzY7iivYlnD3gjC967HUgpvoL0NwM6tgjt3+QE57F0FO4UdRuqmo+5uLaH+8Uuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128159; c=relaxed/simple;
	bh=YEhCtZy0gdBRMZr8uCFAnXBtNOnMpOVwpKselqLhj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXwa6+8TrOAZBYhxmp+CL5qTcVcBHQyykhOMHPRxeJ6KFOlaMMYz+VOQdjz7T45DtcJlw/2jiPNkXSRbkhWh03UXidOCnRrqY+YEK8CfJZZ6fxwkRi10S065d+pn5pMmj+RsAwx8aTnkkAdOH6gpyTxZ8By+4t9Ju2NrA/YOFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=TiJ2yGu/; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D10431485849;
	Mon, 25 Aug 2025 15:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756128154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Dt3bZHXB6Pw2aBzNRDnFUH71ehaQs545/ECq/BqLHbE=;
	b=TiJ2yGu/EIyLweS6Rmf8/EcDyy6SW4NeWhK4WYeHGsm+cYyJPXK13GVlLgbT83mswrnIO+
	aYPIdv+fEOuEv3/UACURpcsfkiQW6CW4A2hrRrpaMxOLp440xjHFq9RKfH7DmSyZFOXgX+
	JuWeqI4AwpJAUHU0vs4zAr57uEpv3mALFU8NIgntRAZa5GHi9N67wdL60ZZqm72xDDhxow
	vv9TQ7FG+y2CeCwtzxqmmPBCzqBci0m9oWH3OUCkwuKJx+4pKeWUdI0mT+2x0YkyHCYaw5
	9OKfn5L0FRsRZ4GfhvIzPdviJhb+77SjE751fi/jMwrLxf0puKFVNKvhIKdj9A==
Date: Mon, 25 Aug 2025 15:22:29 +0200
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
Message-ID: <20250825-vista-cuddle-c159a6bd97ec@thorsis.com>
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
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d0259caac9925e3d5dd3dd27a6785b2a2e82c0b.camel@siemens.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Alexander,

Am Mon, Aug 25, 2025 at 12:21:24PM +0000 schrieb Sverdlin, Alexander:
> Hi Alexander,
> 
> On Mon, 2025-08-25 at 13:02 +0200, Alexander Dahl wrote:
> > > Having setup time 0 violates tAR, tCLR of some chips, for instance
> > > TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
> > > being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
> > > 98 dc 90 15 76 ...).
> > > 
> > > Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
> > > [1], but it looks more appropriate to just calculate setup time properly.
> > > 
> > > [1] Link: https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ApplicationNotes/ApplicationNotes/doc6255.pdf
> > > Cc: stable@vger.kernel.org
> > > Fixes: f9ce2eddf176 ("mtd: nand: atmel: Add ->setup_data_interface() hooks")
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > Tested-by: Alexander Dahl <ada@thorsis.com>
> > 
> > Threw this on top of 6.12.39-rt11 and tested on two custom platforms
> > both with a Spansion S34ML02G1 SLC 2GBit flash chip, but with
> > different SoCs (sama5d2, sam9x60).  We had difficulties with the
> > timing of those NAND flash chips in the past and I wanted to make sure
> > this patch does not break our setup.  Seems fine in a quick test,
> > reading and writing and reading back is successful.
> 
> thank you for your feedback!
> 
> Do you see an opportunity to drop the downstream timing quirks with my patch?

Which downstream do you refer to?

> I actually have another patch related to timings, but it's based on code-review
> only and the theoretical issue never manifested itself in practice on our side...

I also have another one, for which fixes got merged in at91bootstrap
and U-Boot already, but I never found the time to upstream it on
Linux.  It's related to pulse timing.

> (it's about missing ndelay at the end of atmel_smc_nand_exec_instr())

That does not ring a bell here, sorry.

Greets
Alex


