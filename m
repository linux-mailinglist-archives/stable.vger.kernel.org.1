Return-Path: <stable+bounces-27069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E15874E51
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 12:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5271F2808E
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51184FD7;
	Thu,  7 Mar 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pEalU7Z7"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E385634
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812405; cv=none; b=iegpyKL9uhyLeAfcQzE5zqjV8Wqypjw1j1CN6iARmBcozEV/2s9IvNprxVK0cho3KSnPaN41egDi0ZqfM3K52K01xMHHhrbkabT5esRmb37XKxktXx8ajODMIf7jl/DEiTQHT1Mkqps4Fbs0lcER4wfowTbwcU/+QJB+ZR7zFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812405; c=relaxed/simple;
	bh=ORm9RFrtycYm2ntpwYPq5FJ9fVxF4WZ9C++4JFHExjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzbgDuA9xx8ZfZeN84ErWzI83sbYf8vb8PiN2fA3zvbDAYBfRW8kLlN9NxKGHbNWDVxBDYI+7t/6UeT+rLiGUBoul3bLkOeCjD6OwwM8EafEmvqw2SbA2lPLUY7EQDow/tq1Acd3hOkWwEqRVq1C50hNaReTpUjYbKluali3CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pEalU7Z7; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81FE8E000F;
	Thu,  7 Mar 2024 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709812401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4gfOLzMfOuj4PpOKwX97oBCeemWK8LHtpA2XW/OPMjA=;
	b=pEalU7Z7OK34nBBZELLnLk1hBXNu4Kd/y67OaFV0nwiHCnXHG7QJYLvW1wGVE+cdXAYCWR
	wCTSGIH/nfc/qfAquKGFYdd+f9GkP2D2SzHs3fMsbxT1go6ok+1P9iPOlE59XibmJKku+e
	h+tdvPONIGm2yMz+MmvCPStmNyqwdhyEdQFG42JwSTdcNPNCgqZ3fgZtOhCJanC3o+XutB
	h2CiTyAz9cqeM5omb5BklfJSdcOtQbrQf/PkpOCNZ62yFVnA9B/g2vrE7aWLgEcQypVDcO
	PIT2m7dZRklsxy1Ci8zFn0mi41BXFAjX+mI+7Mg3cqsWeEmHqXgcd5HN4MaRdA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: Constrain even more when continuous reads are enabled
Date: Thu,  7 Mar 2024 12:53:14 +0100
Message-Id: <20240307115315.1942678-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

As a matter of fact, continuous reads require additional handling at the
operation level in order for them to work properly. The core helpers do
have this additional logic now, but any time a controller implements its
own page helper, this extra logic is "lost". This means we need another
level of per-controller driver checks to ensure they can leverage
continuous reads. This is for now unsupported, so in order to ensure
continuous reads are enabled only when fully using the core page
helpers, we need to add more initial checks.

Also, as performance is not relevant during raw accesses, we also
prevent these from enabling the feature.

This should solve the issue seen with controllers such as the STM32 FMC2
when in sequencer mode. In this case, the continuous read feature would
be enabled but not leveraged, and most importantly not disabled, leading
to further operations to fail.

Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 4d5a663e4e05..2479fa98f991 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3594,7 +3594,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 	oob = ops->oobbuf;
 	oob_required = oob ? 1 : 0;
 
-	rawnand_enable_cont_reads(chip, page, readlen, col);
+	if (likely(ops->mode != MTD_OPS_RAW))
+		rawnand_enable_cont_reads(chip, page, readlen, col);
 
 	while (1) {
 		struct mtd_ecc_stats ecc_stats = mtd->ecc_stats;
@@ -5212,6 +5213,15 @@ static void rawnand_late_check_supported_ops(struct nand_chip *chip)
 	if (!nand_has_exec_op(chip))
 		return;
 
+	/*
+	 * For now, continuous reads can only be used with the core page helpers.
+	 * This can be extended later.
+	 */
+	if (!(chip->ecc.read_page == nand_read_page_hwecc ||
+	      chip->ecc.read_page == nand_read_page_syndrome ||
+	      chip->ecc.read_page == nand_read_page_swecc))
+		return;
+
 	rawnand_check_cont_read_support(chip);
 }
 
-- 
2.40.1


