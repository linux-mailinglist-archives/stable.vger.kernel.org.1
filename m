Return-Path: <stable+bounces-87942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D59AD38B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624E81C22320
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673621D07BF;
	Wed, 23 Oct 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TA9IBz3t"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031521C6F6C;
	Wed, 23 Oct 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706710; cv=none; b=do5ckQD0alOI/Vz0i8svhd8mOlCtX59uO0V7bXbw4lmDz02LP+omIPNymSjSRdsKKexwaWQqqNiSAbn35inxmgx16IAZe29L8RoGyST14BFgwB8Y8A+YRePhyFGNBLhEhXAHwkjSlcN0nxRVQXY6JH+Wk6lT+R9yvOaTYsnR5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706710; c=relaxed/simple;
	bh=PHIMaIodTUUlEyV45AV49IkmrCm+6VlkRQLf/9XYmrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eseHyxW9VGoPBsS+ItsaJqxhuwe5jpfkPtarFldZN0LeiFCDwXMqhUSAHAJ5u0rIeRMVL5GVlTjm/Ly7vtpr6KzWkYgH82Ekdcd/U+s53aYbdbE/oC3ZnWl973gxFvT7DaJjEf3u44y5Qbv9hTWf7fwyPsdQ1Bt/kiKBw4Tf5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TA9IBz3t; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B6496C00152E;
	Wed, 23 Oct 2024 11:05:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B6496C00152E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729706700;
	bh=PHIMaIodTUUlEyV45AV49IkmrCm+6VlkRQLf/9XYmrE=;
	h=From:To:Cc:Subject:Date:From;
	b=TA9IBz3tp3NIGw06D91EY8bwvb0kXuHlFwhtBSMqP7plJhWA+8ri91Z0XnD0I8u3b
	 SNH4d8WmyqKC0Lwhnt+XwWLQ0ahNA9ssvI4HdxQb2pyNz0C9lo+0T8IVXxT9NR0OIF
	 7omIkQFNijtF4WWBpkt1J6P5BbtPrFYs8123XR7I=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4C65C18041CAC6;
	Wed, 23 Oct 2024 11:05:00 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: kamal.dasu@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Sean Nyekjaer <sean@geanix.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.4] mtd: rawnand: protect access to rawnand devices while in suspend
Date: Wed, 23 Oct 2024 11:04:49 -0700
Message-ID: <20241023180449.231713-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Nyekjaer <sean@geanix.com>

commit 8cba323437a49a45756d661f500b324fc2d486fe upstream.

Prevent rawnand access while in a suspended state.

Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
rawnand layer to return errors rather than waiting in a blocking wait.

Tested on a iMX6ULL.

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220208085213.1838273-1-sean@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[florian: Adjust rawnand.h members documentation and position]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mtd/nand/raw/nand_base.c | 44 +++++++++++++++-----------------
 include/linux/mtd/rawnand.h      |  2 ++
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index db66c1be6e5f..29e3a5b04778 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -359,16 +359,19 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  *
  * Return: -EBUSY if the chip has been suspended, 0 otherwise
  */
-static int nand_get_device(struct nand_chip *chip)
+static void nand_get_device(struct nand_chip *chip)
 {
-	mutex_lock(&chip->lock);
-	if (chip->suspended) {
+	/* Wait until the device is resumed. */
+	while (1) {
+		mutex_lock(&chip->lock);
+		if (!chip->suspended) {
+			mutex_lock(&chip->controller->lock);
+			return;
+		}
 		mutex_unlock(&chip->lock);
-		return -EBUSY;
-	}
-	mutex_lock(&chip->controller->lock);
 
-	return 0;
+		wait_event(chip->resume_wq, !chip->suspended);
+	}
 }
 
 /**
@@ -593,9 +596,7 @@ static int nand_block_markbad_lowlevel(struct nand_chip *chip, loff_t ofs)
 		nand_erase_nand(chip, &einfo, 0);
 
 		/* Write bad block marker to OOB */
-		ret = nand_get_device(chip);
-		if (ret)
-			return ret;
+		nand_get_device(chip);
 
 		ret = nand_markbad_bbm(chip, ofs);
 		nand_release_device(chip);
@@ -3576,9 +3577,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 	    ops->mode != MTD_OPS_RAW)
 		return -ENOTSUPP;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	if (!ops->datbuf)
 		ret = nand_do_read_oob(chip, from, ops);
@@ -4122,13 +4121,11 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 			  struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
+	int ret = 0;
 
 	ops->retlen = 0;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	switch (ops->mode) {
 	case MTD_OPS_PLACE_OOB:
@@ -4184,9 +4181,7 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		return -EINVAL;
 
 	/* Grab the lock and see if the device is available */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	/* Shift to get first page */
 	page = (int)(instr->addr >> chip->page_shift);
@@ -4273,7 +4268,7 @@ static void nand_sync(struct mtd_info *mtd)
 	pr_debug("%s: called\n", __func__);
 
 	/* Grab the lock and see if the device is available */
-	WARN_ON(nand_get_device(chip));
+	nand_get_device(chip);
 	/* Release it and go back */
 	nand_release_device(chip);
 }
@@ -4290,9 +4285,7 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 	int ret;
 
 	/* Select the NAND device */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	nand_select_target(chip, chipnr);
 
@@ -4354,6 +4347,8 @@ static void nand_resume(struct mtd_info *mtd)
 		pr_err("%s called for a chip which is not in suspended state\n",
 			__func__);
 	mutex_unlock(&chip->lock);
+
+	wake_up_all(&chip->resume_wq);
 }
 
 /**
@@ -5014,6 +5009,7 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
 	chip->cur_cs = -1;
 
 	mutex_init(&chip->lock);
+	init_waitqueue_head(&chip->resume_wq);
 
 	/* Enforce the right timings for reset/detection */
 	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4ab9bccfcde0..9db457532870 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1064,6 +1064,7 @@ struct nand_legacy {
  * @lock:		lock protecting the suspended field. Also used to
  *			serialize accesses to the NAND device.
  * @suspended:		set to 1 when the device is suspended, 0 when it's not.
+ * @resume_wq:		wait queue to sleep if rawnand is in suspended state.
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
  *			lookup.
@@ -1117,6 +1118,7 @@ struct nand_chip {
 
 	struct mutex lock;
 	unsigned int suspended : 1;
+	wait_queue_head_t resume_wq;
 
 	uint8_t *oob_poi;
 	struct nand_controller *controller;
-- 
2.43.0


