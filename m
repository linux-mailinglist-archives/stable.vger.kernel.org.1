Return-Path: <stable+bounces-43193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A328BE854
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BB31C24D44
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509B916ABC4;
	Tue,  7 May 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L07Er9Z9"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515716190C
	for <stable@vger.kernel.org>; Tue,  7 May 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097955; cv=none; b=lj0Goxa8eaXFHRk3Fj1egNDhrYnBXeZX4DNY66Xttjsll2HvVNPPKKx7yZlugKsC8qXJfw6rs3eF4rreu8Sw+Ecbul1HrZT6nXP1+UL1zaQ8bllAhXORZDyDJ32aU5Kp3NVWXjZqb2+wouRPvigc82PJBFPOUicNw1n2Kqe9vis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097955; c=relaxed/simple;
	bh=IBDmMCQDsB8MlYzMT2whLMg/8mQ9+RU3Yo3BVwlADnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IB5xTRJ6v0q9A7HsFPm9+xXkR3ocVGbN/5QNPZYPjztq2o/gJh4+BP15TpNy4+9QAiFpMANoJ43zebtkZJXHb80Yzl92aE7CRhpApF2peM0kEUTwvlBxwsY1A/z8kKtkH3tLGZ0WD0q2MzHAOaYTkTtFk4dCUqIGTP4mwqrEWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L07Er9Z9; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38F09C0006;
	Tue,  7 May 2024 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715097949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/VgyGaJjH+jEEQ1nJwlL4A4AubzyPoAEJvUeqkn8bc=;
	b=L07Er9Z9stSHoo9MSAtJzXk75Mxy8k0lbzfFwZu1G2C9oQ07D6oCePF+FjgQuttwPRchEP
	hsD2oDTqZknNDSdIW53dqPOUgBxjg4NXucHCu7+pnKkaypZfa1s0WbGk5JGMY4C/YO34Lv
	aCfPc26dZGcC4K9huI5bUeEIgowHCfiEAL9XYliKQG/tjo+bhr1HHZtl5KEB8t+gw1tlMo
	QR1/fVhN2ELyRVVfRwa7yhukZaTmGzE2GKDLc08bwR1M1yT1iK16eiJkv4WiC43uXuhez5
	eNvxPLKS8ETQoXlxe252MqcHnAhlcfmYJ9/5+06xdEm8wmuaGNEWdwS+AqAZHA==
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
	Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>
Subject: [PATCH 2/2] mtd: rawnand: Bypass a couple of sanity checks during NAND identification
Date: Tue,  7 May 2024 18:05:46 +0200
Message-Id: <20240507160546.130255-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507160546.130255-1-miquel.raynal@bootlin.com>
References: <20240507160546.130255-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Early during NAND identification, mtd_info fields have not yet been
initialized (namely, writesize and oobsize) and thus cannot be used for
sanity checks yet. Of course if there is a misuse of
nand_change_read_column_op() so early we won't be warned, but there is
anyway no actual check to perform at this stage as we do not yet know
the NAND geometry.

So, if the fields are empty, especially mtd->writesize which is *always*
set quite rapidly after identification, let's skip the sanity checks.

nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
identification in the very unlikely case of:
- bitflips appearing in the parameter page,
- the controller driver not supporting simple DATA_IN cycles.

Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers")
Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers")
Cc: stable@vger.kernel.org
Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 248e654ecefd..a66e73cd68cb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1440,12 +1440,14 @@ int nand_change_read_column_op(struct nand_chip *chip,
 	if (len && !buf)
 		return -EINVAL;
 
-	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
-		return -EINVAL;
+	if (mtd->writesize) {
+		if ((offset_in_page + len > mtd->writesize + mtd->oobsize))
+			return -EINVAL;
 
-	/* Small page NANDs do not support column change. */
-	if (mtd->writesize <= 512)
-		return -ENOTSUPP;
+		/* Small page NANDs do not support column change. */
+		if (mtd->writesize <= 512)
+			return -ENOTSUPP;
+	}
 
 	if (nand_has_exec_op(chip)) {
 		const struct nand_interface_config *conf =
-- 
2.40.1


