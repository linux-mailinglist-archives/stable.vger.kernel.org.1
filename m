Return-Path: <stable+bounces-23459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696BD8610DB
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 12:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044A0B23313
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822517A722;
	Fri, 23 Feb 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WcErOA83"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43478B4F
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689361; cv=none; b=joaajdq/Z/9j6fp+ThNbBMySAaqxC4kXrZP87dW4yx8ba/vgCXADOYa2NFgaA4xPZcGXK0FH7MXdhDM2jZJ6tvpbzPvvPHn6woYVhXAHtGRUsuoM2md/oufrUvZ3jbaMHsVvSejyYVpRSwleFv34yL4ujmUxoj0dgxbrSAk+qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689361; c=relaxed/simple;
	bh=g1M0Ia5P8ctilwma0Jg/wu7TnCsymxAIrtD7TstdTA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CW3RsgJoH6GdXomVR3fiEblNNe5rrtE9C7OE4ABNyRELXw+/uYCVEIauHF0VCzAm6K1CO16WETz7XnN9ZHii89Nr5Vv7JY5iwrgcxHKozl0ucMoui4G9Q1X2V9jgQ0ToBufLJrif4C5pxRHVeL9J6sOT5RKBB1hWipLgNLtLmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WcErOA83; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA410C0011;
	Fri, 23 Feb 2024 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708689352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrEN5TvhX5/r3qsoC4vp32SJepM9NsZrN5JkiWr7IcI=;
	b=WcErOA83RYMMh38XrwuXrvfqtTUJltPjlqhY+/HmZTbFP2fAdAqOy4qsbSQki41OvsMtqX
	8sfLN+1QF1Yjn2CFuronLxOAB8Hsa+uJd/bnb0LqyKeaOZG956rLjxgeOzjbPwCvermdXs
	c6xpiH/6bvYXF3gAxTO/gLCAkTLWZvTUQqXCAaGOCG946zkc3cl3jUv5ZAKlikN/k4XMhF
	QStfP3iqMu8orfvVOP3hHSsck0cOaE162Ne3TQyYTz3APab4bzn3U8or2vvNbslWjiiguo
	Q9R8wsCLDKOwTGd8iSdjJhYcBQrCGMZHWyGRLYt5GBZEXBlt73Kzf0R1/hUQ1g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] mtd: rawnand: Ensure all continuous terms are always in sync
Date: Fri, 23 Feb 2024 12:55:45 +0100
Message-Id: <20240223115545.354541-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223115545.354541-1-miquel.raynal@bootlin.com>
References: <20240223115545.354541-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

While crossing a LUN boundary, it is probably safer (and clearer) to
keep all members of the continuous read structure aligned, including the
pause page (which is the last page of the lun or the last page of the
continuous read). Once these members properly in sync, we can use the
rawnand_cap_cont_reads() helper everywhere to "prepare" the next
continuous read if there is one.

Fixes: bbcd80f53a5e ("mtd: rawnand: Prevent crossing LUN boundaries during sequential reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This is not 100% a fix but I believe it is worth backporting as there
may be corner cases which were not identified with the initial
implementation.
---
 drivers/mtd/nand/raw/nand_base.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d6a27e08b112..4d5a663e4e05 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1232,6 +1232,15 @@ static void rawnand_cap_cont_reads(struct nand_chip *chip)
 		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
+
+	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		chip->cont_read.pause_page = min(chip->cont_read.last_page,
+						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+	}
+
+	if (chip->cont_read.first_page >= chip->cont_read.last_page)
+		chip->cont_read.ongoing = false;
 }
 
 static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int page,
@@ -1298,12 +1307,11 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 	if (!chip->cont_read.ongoing)
 		return 0;
 
-	if (page == chip->cont_read.pause_page &&
-	    page != chip->cont_read.last_page) {
-		chip->cont_read.first_page = chip->cont_read.pause_page + 1;
-		rawnand_cap_cont_reads(chip);
-	} else if (page == chip->cont_read.last_page) {
+	if (page == chip->cont_read.last_page) {
 		chip->cont_read.ongoing = false;
+	} else if (page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		rawnand_cap_cont_reads(chip);
 	}
 
 	return 0;
@@ -3510,10 +3518,7 @@ static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned i
 		return;
 
 	chip->cont_read.first_page++;
-	if (chip->cont_read.first_page == chip->cont_read.pause_page)
-		chip->cont_read.first_page++;
-	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-		chip->cont_read.ongoing = false;
+	rawnand_cap_cont_reads(chip);
 }
 
 /**
-- 
2.34.1


