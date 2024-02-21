Return-Path: <stable+bounces-21830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAC85D6B9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F028411D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38C3FB3C;
	Wed, 21 Feb 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GsiG4OHc"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227F3F9C9
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514445; cv=none; b=MjefoGY+34YuxGZhPGv4yhxiFLgiV6Au47dRVN2CJomvsG1WqKhMEAZcZEDZJlI6YzLesCYHCVf0lr+hKgO/Cx2YcLSyW/Q+BaqXzB4c2HQMuMLX1m8w5sfqaGr1e9CNT/rVmBE9cfIkFAmV5DKkYbqU8ieiWmZhIpNxHFVCdw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514445; c=relaxed/simple;
	bh=/OqB9gKHXei8JHmCy0lZ7+XxoGcfRjpgrTdVFR3DKsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B61+CVPmfs6QoRKia18WdOTtiua0nmb6bcrHhxNySH2WqY0ylCJr9O6Jrc+xTS7861FHeTu/GFzcngLsK10r0XbeF4Q+hXBZWahnEvdYFYUqphEECMv2ALOXUMf9h7l+aK/rZE9Pt7NjgxDgJUWCU/gSe9yBejoAtaaNpqaI4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GsiG4OHc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 306331C0007;
	Wed, 21 Feb 2024 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708514435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cZ5i4n54ZZl4j6dUvtTwqTXJ11DN72pkExFKwV8TAw=;
	b=GsiG4OHcKSaQv/V+15amwbsKOgyAo/ez5hejHOZbFcCQLgD+1AXAURJywNuLk4EJRz0iLJ
	flJRVShYp2764IrkcrKZzckRlt6FM34XhOzW84vY49gdelE+pcLmKXSs26DQt35vSG/hlf
	S+5bfx3DH3vTz/eKdM7cLun8JCnKc7i76EtGS9pozjk2CHNJBL1oKtg8vFIFXgbXThBm8N
	fw8QeeqBS6EmpofCbH06HbKjdE0PHXlfYag1m83lPQ4PNefoQ3rqMW2luElFJ+WP842XGE
	rOQiVGdGZCickttPTZEpng6iEUx/O5PwLkPO3oXEs3LQaTSoNKhv2AJfPJNpHA==
Date: Wed, 21 Feb 2024 12:20:32 +0100
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
Message-ID: <20240221122032.502fbf3f@xps-13>
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

I believe the issue is not in the indexes but related to the OOB. I
currently test on a device on which I would prefer not to smash the
content, so this is just compile tested and not run time verified, but
could you tell me if this solves the issue:

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3577,7 +3577,8 @@ static int nand_do_read_ops(struct nand_chip *chip, l=
off_t from,
        oob =3D ops->oobbuf;
        oob_required =3D oob ? 1 : 0;
=20
-       rawnand_enable_cont_reads(chip, page, readlen, col);
+       if (!oob_required)
+               rawnand_enable_cont_reads(chip, page, readlen, col);
=20
        while (1) {
                struct mtd_ecc_stats ecc_stats =3D mtd->ecc_stats;


If that does not work, I'll destroy the content of the flash and
properly reproduce.

Thanks,
Miqu=C3=A8l

