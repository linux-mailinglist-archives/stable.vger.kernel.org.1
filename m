Return-Path: <stable+bounces-6815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6881483E
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F912815F4
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B02CCDA;
	Fri, 15 Dec 2023 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cPPh4SR8"
X-Original-To: stable@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FF2C6AB
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0680FC2814
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:32:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 532921BF212;
	Fri, 15 Dec 2023 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702643535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZUUBRErULdv3C9qn7gpgjmSanyKBol055lJLffurYk=;
	b=cPPh4SR89xO5lUpmKwm4hTSakYUFeifYzEZHASpOqEOrzWjv/3rlPG1idAe8gtmXfMH5fE
	My1Uc7wO0rn7vJB5jGhOLvH9MPKG9zm7Od+gDmz4MTlEz6R9kXY6YeT56aiUxIjQZGetwr
	Ye4M4ZOrvt5/dz0kUOZG3WAHo51cASVxZUfytIEWbmzFc4nKCFJshYJwYwUxPylF3CS1RP
	H9hxuUxBog6tev4epZNt2pPS0+sZOFTiflS6ime+APnmcqgVnjp3lHVzs5WMtx6T9Nzt8y
	ZTL6EbwO/T3sDToeXgQj04EijIH/oTuJqxpc1JAdNvAQqKHlG5wNypmqZ0M0zA==
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
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] mtd: rawnand: Prevent crossing LUN boundaries during sequential reads
Date: Fri, 15 Dec 2023 13:32:05 +0100
Message-Id: <20231215123208.516590-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-1-miquel.raynal@bootlin.com>
References: <20231215123208.516590-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The ONFI specification states that devices do not need to support
sequential reads across LUN boundaries. In order to prevent such event
from happening and possibly failing, let's introduce the concept of
"pause" in the sequential read to handle these cases. The first/last
pages remain the same but any time we cross a LUN boundary we will end
and restart (if relevant) the sequential read operation.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 43 +++++++++++++++++++++++++++-----
 include/linux/mtd/rawnand.h      |  2 ++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9e24bedffd89..04e80ace4182 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1207,6 +1207,23 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
+static void rawnand_cap_cont_reads(struct nand_chip *chip)
+{
+	struct nand_memory_organization *memorg;
+	unsigned int pages_per_lun, first_lun, last_lun;
+
+	memorg = nanddev_get_memorg(&chip->base);
+	pages_per_lun = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
+	first_lun = chip->cont_read.first_page / pages_per_lun;
+	last_lun = chip->cont_read.last_page / pages_per_lun;
+
+	/* Prevent sequential cache reads across LUN boundaries */
+	if (first_lun != last_lun)
+		chip->cont_read.pause_page = first_lun * pages_per_lun + pages_per_lun - 1;
+	else
+		chip->cont_read.pause_page = chip->cont_read.last_page;
+}
+
 static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int page,
 					  unsigned int offset_in_page, void *buf,
 					  unsigned int len, bool check_only)
@@ -1225,7 +1242,7 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 		NAND_OP_DATA_IN(len, buf, 0),
 	};
 	struct nand_op_instr cont_instrs[] = {
-		NAND_OP_CMD(page == chip->cont_read.last_page ?
+		NAND_OP_CMD(page == chip->cont_read.pause_page ?
 			    NAND_CMD_READCACHEEND : NAND_CMD_READCACHESEQ,
 			    NAND_COMMON_TIMING_NS(conf, tWB_max)),
 		NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tR_max),
@@ -1262,16 +1279,29 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 	}
 
 	if (page == chip->cont_read.first_page)
-		return nand_exec_op(chip, &start_op);
+		ret = nand_exec_op(chip, &start_op);
 	else
-		return nand_exec_op(chip, &cont_op);
+		ret = nand_exec_op(chip, &cont_op);
+	if (ret)
+		return ret;
+
+	if (!chip->cont_read.ongoing)
+		return 0;
+
+	if (page == chip->cont_read.pause_page &&
+	    page != chip->cont_read.last_page) {
+		chip->cont_read.first_page = chip->cont_read.pause_page + 1;
+		rawnand_cap_cont_reads(chip);
+	} else if (page == chip->cont_read.last_page) {
+		chip->cont_read.ongoing = false;
+	}
+
+	return 0;
 }
 
 static bool rawnand_cont_read_ongoing(struct nand_chip *chip, unsigned int page)
 {
-	return chip->cont_read.ongoing &&
-		page >= chip->cont_read.first_page &&
-		page <= chip->cont_read.last_page;
+	return chip->cont_read.ongoing && page >= chip->cont_read.first_page;
 }
 
 /**
@@ -3445,6 +3475,7 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
 	if (col)
 		chip->cont_read.first_page++;
 	chip->cont_read.last_page = page + ((readlen >> chip->page_shift) & chip->pagemask);
+	rawnand_cap_cont_reads(chip);
 }
 
 /**
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index c29ace15a053..9d0fc5109af6 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1265,6 +1265,7 @@ struct nand_secure_region {
  * @cont_read: Sequential page read internals
  * @cont_read.ongoing: Whether a continuous read is ongoing or not
  * @cont_read.first_page: Start of the continuous read operation
+ * @cont_read.pause_page: End of the current sequential cache read operation
  * @cont_read.last_page: End of the continuous read operation
  * @controller: The hardware controller	structure which is shared among multiple
  *              independent devices
@@ -1321,6 +1322,7 @@ struct nand_chip {
 	struct {
 		bool ongoing;
 		unsigned int first_page;
+		unsigned int pause_page;
 		unsigned int last_page;
 	} cont_read;
 
-- 
2.34.1


