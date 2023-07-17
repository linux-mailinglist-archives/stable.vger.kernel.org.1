Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAD756D8D
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 21:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGQTmf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQTme (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 15:42:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12932129
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 12:42:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3D871BF205;
        Mon, 17 Jul 2023 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689622947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gEUn549HX6Kut5VTQH3vbjTC7LCGLE2/fOFWaktOz4=;
        b=fbQxt2fNLkhDxfzd7Vt8XwYtMdwJgL/QKaWkeSdLrmz0X5uQpYQIzRM+m2/a4bcTGRBsz7
        ka/0eEzwcx2uKW6lFPovIDVYLpAYM7+Iho11pdvW0KM64QUkxOD9x59Aglgdr/V23gmK0V
        VFqLWiM61he5e0hGSgjc4FYqXGg1670S/MvWBqYicIqyPwd/Mjqf+m/aCFoRcUvcy7b1yt
        IHEaa6ajvEgFO8jtn/nPf2N0k9HD6f/Msuzg73pmdp4T1maWUs9tiX+VRFYlzX1OnTkeT0
        8DmPB+k/zxJ6dMZYdrvgSd0/DKxpoaIyrz8QTWNDvyNIpXEGvN8s23lR1J7dhw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michal Simek <michal.simek@amd.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] mtd: rawnand: arasan: Ensure program page operations are successful
Date:   Mon, 17 Jul 2023 21:42:20 +0200
Message-Id: <20230717194221.229778-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717194221.229778-1-miquel.raynal@bootlin.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The NAND core complies with the ONFI specification, which itself
mentions that after any program or erase operation, a status check
should be performed to see whether the operation was finished *and*
successful.

The NAND core offers helpers to finish a page write (sending the
"PAGE PROG" command, waiting for the NAND chip to be ready again, and
checking the operation status). But in some cases, advanced controller
drivers might want to optimize this and craft their own page write
helper to leverage additional hardware capabilities, thus not always
using the core facilities.

Some drivers, like this one, do not use the core helper to finish a page
write because the final cycles are automatically managed by the
hardware. In this case, the additional care must be taken to manually
perform the final status check.

Let's read the NAND chip status at the end of the page write helper and
return -EIO upon error.

Cc: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH ECC engine")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

Hello Michal,

I have not tested this, but based on a report on another driver, I
believe the status check is also missing here and could sometimes
lead to unnoticed partial writes.

Please test on your side that everything still works and let me
know how it goes.

Thanks a lot.
Miquèl
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 906eef70cb6d..487c139316fe 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -515,6 +515,7 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int len = mtd->writesize + (oob_required ? mtd->oobsize : 0);
 	dma_addr_t dma_addr;
+	u8 status;
 	int ret;
 	struct anfc_op nfc_op = {
 		.pkt_reg =
@@ -561,10 +562,21 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	}
 
 	/* Spare data is not protected */
-	if (oob_required)
+	if (oob_required) {
 		ret = nand_write_oob_std(chip, page);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
 }
 
 static int anfc_sel_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
-- 
2.34.1

