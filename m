Return-Path: <stable+bounces-192531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DBDC371C2
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636CC503AC5
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818B336EFB;
	Wed,  5 Nov 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q0OMW6Ai"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EC21A453
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363650; cv=none; b=kBui5SfDpdx11o9FWbof0JZ4dJDMNU2e9XRLSbpVbSDjIWv6YX6sxZDKUdA0vFN3vzuYoSdlEG1T5sj+pzg0yBXlj5wmPY2ewb6k+apJ7Z55HqprV7mlBFnzj8lO7ps2WeYZ6ge/wzPKPq6OtFEuKviTA0I8uIFHgOH2r8GTVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363650; c=relaxed/simple;
	bh=is4eN6RpZt6sOERf8/HARwvHIOtBrjGvtYHglnRe/C8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ab5otr3rk3HhDcRvcLBfxc5xenMKt8m4EwIadAnzd3z3BFsBLsRLHq21oYYjwF6No179V1uCffL/IhZCtLN2PEOr1TOHuAipNkLy/kMDimWReIIv6ve6CGuRPsZ2aygduwkHwRjciyvq1eCofHIcriux7xcj0Z+dK8Jpw3MI4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q0OMW6Ai; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 42F374E4153E;
	Wed,  5 Nov 2025 17:27:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1948E60693;
	Wed,  5 Nov 2025 17:27:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A58A710B50A4D;
	Wed,  5 Nov 2025 18:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762363644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HKjwLc9WMgewf//y7bZUVi151/7kk6WShUalaztiDao=;
	b=Q0OMW6Aiio1vz08fxNMUflPROrTRHaX/bt1lUn+/6oEfHe82s1qDXLWwVrG5+kLHb36Z9l
	MFyLK28rAViy0SKFM44ffzWqGsanwYQJFgdlKfqqUsqMWUEpxkdfDu9+/bPqjZ3gpan9XL
	rWGbZAxWEGQWPrf3f8EV/dWenT1R/HAFP3N29Ba1q/4tWR3a5oVqfKo8MIVC3UQfyQHJGa
	g8d/7iagjH6MvJp+OfVKpluEDldrdQkPbAwYBBknE0tB7/MWW4yAd1oaVlpKCiRW0vwxqc
	AjN8/qB6u11M6Ei11ju2dRiGFmDmtGsvpPZn+dpfznaJtIteLFYW5oXpR2QICQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/6] Hello,
Date: Wed, 05 Nov 2025 18:26:59 +0100
Message-Id: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOOIC2kC/x3MQQqEMAxA0atI1hMwhdriVYZZjG3UbFJJQQXx7
 haXb/H/BZVNuMLYXWC8S5WiDfTpIK1/XRglN4PrnSfqPR6iU9GM+4AU0RJh3QS1GIY5xDS5EH0
 eoPWb8Szn+/7+7vsBHCEDUGsAAAA=
X-Change-ID: 20251105-winbond-v6-18-rc1-spi-nor-7f78cb2785d6
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Here is a series adding support for 6 Winbond SPI NOR chips. Describing
these chips is needed otherwise the block protection feature is not
available. Everything else looks fine otherwise.

In practice I am only adding 6 very similar IDs but I split the commits
because the amount of meta data to show proof that all the chips have
been tested and work is pretty big.

As the commits simply add an ID, I am Cc'ing stable with the hope to
get these backported to LTS kernels as allowed by the stable rules (see
link below, but I hope I am doing this right).

Link: https://elixir.bootlin.com/linux/v6.17.7/source/Documentation/process/stable-kernel-rules.rst#L15

Thanks,
Miquèl

---
Miquel Raynal (6):
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ chips
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25Q02NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25H512NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H01NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H02NWxxAM chips

 drivers/mtd/spi-nor/winbond.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
---
base-commit: 479ba7fc704936b74a91ee352fe113d6391d562f
change-id: 20251105-winbond-v6-18-rc1-spi-nor-7f78cb2785d6

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


