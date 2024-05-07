Return-Path: <stable+bounces-43166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99388BDD96
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6974F28480D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F714D433;
	Tue,  7 May 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bTVq2gkS"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43610E3
	for <stable@vger.kernel.org>; Tue,  7 May 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072329; cv=none; b=Q033UA3hVKrPNZHoU52E9fFyY+mUgF/QKeU88qsA+VAUbcQd3XzcqCTPf7Z0DnlZqlk6JP1SZ8OPaoSW//WWVjyCKztmUnlJxHaTiQFsqp0jcNGm/tXgQWTxJci+sB22N1oO4u/GWL2M6UjBFV1AdIL4ybU+FzIX65N7UVa93R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072329; c=relaxed/simple;
	bh=xgERL5NTmRREmCY5g/81EWDbZVYhwjZciYutb7aF1f8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F8NdG2xdh6Jr4J0gxedbYsQPz3dE/dwF7gtUWXAnMTPTIdMTFb8wePgBjdRZbuWV1l0sNCpzG6IFjQikzXqgWQqm2snNdSCsrpCL/k+Wx4Ps8fiE9tyjyEdp/gefSdmf4sVdPzwMaEzyekm/QVirtQad6F8wk9alqICn3ZQUZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bTVq2gkS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 525711BF208;
	Tue,  7 May 2024 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715072324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2sHF3ypEAiEpeHREQw270xHX0lb0//dUYs40hlXNE8=;
	b=bTVq2gkSqk6FKob/jyCEmCCnfPOvQ8h/4EGY7Zxu9FmE/5MAShOQd3K3Nnjz642jMgVVgc
	nhMb4ZrwKUJVMKuZbwAwBxgeCtCi9mxHDy4miCjkugz2kftrYmualM6ISAF1FvvS5cSlHu
	oDubIS3KuhWqxy+8Rh5KPyNdwg6CHGnGnIWtR2SYMpUY5e3p+YRNfhfyK1TqNMJYf//v65
	n9iT+M6bvWKXI2EfKC1ZZTxKczPkEYeyxDJ3DtrkHcOeEdv/k5yhINfzI1ugFfqe/0732n
	+DIrV2UQxtCpflT+0yngNyVLqQCesFxyRxot2c9z3b5e/V0I55F9La4cNPHegw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mtd: rawnand: Ensure ECC configuration is propagated to upper layers
Date: Tue,  7 May 2024 10:58:42 +0200
Message-Id: <20240507085842.108844-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Until recently the "upper layer" was MTD. But following incremental
reworks to bring spi-nand support and more recently generic ECC support,
there is now an intermediate "generic NAND" layer that also needs to get
access to some values. When using "converted" ECC engines, like the
software ones, these values are already propagated correctly. But
otherwise when using good old raw NAND controller drivers, we need to
manually set these values ourselves at the end of the "scan" operation,
once these values have been negotiated.

Without this propagation, later (generic) checks like the one warning
users that the ECC strength is not high enough might simply no longer
work.

Fixes: 8c126720fe10 ("mtd: rawnand: Use the ECC framework nand_ecc_is_strong_enough() helper")
Cc: stable@vger.kernel.org
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Closes: https://lore.kernel.org/all/Zhe2JtvvN1M4Ompw@pengutronix.de/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello Sascha, this is only compile tested, would you mind checking if
that fixes your setup?
Thanks, Miquèl

 drivers/mtd/nand/raw/nand_base.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d7dbbd469b89..acd137dd0957 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6301,6 +6301,7 @@ static const struct nand_ops rawnand_ops = {
 static int nand_scan_tail(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_device *base = &chip->base;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i;
 
@@ -6445,9 +6446,13 @@ static int nand_scan_tail(struct nand_chip *chip)
 	if (!ecc->write_oob_raw)
 		ecc->write_oob_raw = ecc->write_oob;
 
-	/* propagate ecc info to mtd_info */
+	/* Propagate ECC info to the generic NAND and MTD layers */
 	mtd->ecc_strength = ecc->strength;
+	if (!base->ecc.ctx.conf.strength)
+		base->ecc.ctx.conf.strength = ecc->strength;
 	mtd->ecc_step_size = ecc->size;
+	if (!base->ecc.ctx.conf.step_size)
+		base->ecc.ctx.conf.step_size = ecc->size;
 
 	/*
 	 * Set the number of read / write steps for one page depending on ECC
@@ -6455,6 +6460,8 @@ static int nand_scan_tail(struct nand_chip *chip)
 	 */
 	if (!ecc->steps)
 		ecc->steps = mtd->writesize / ecc->size;
+	if (!base->ecc.ctx.nsteps)
+		base->ecc.ctx.nsteps = ecc->steps;
 	if (ecc->steps * ecc->size != mtd->writesize) {
 		WARN(1, "Invalid ECC parameters\n");
 		ret = -EINVAL;
-- 
2.40.1


