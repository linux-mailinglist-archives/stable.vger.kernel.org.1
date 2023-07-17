Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9F756D8C
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGQTmb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQTma (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 15:42:30 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC9D3
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 12:42:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE27E1BF204;
        Mon, 17 Jul 2023 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689622946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RW03N0S/bEhxMDlvc7ZnHFSbKTSNbVdEvn4DEIHdDvw=;
        b=S3cq2YVGjPjyLO/zN1cJlZ/PGK5hAMYIFnMJ1pD5D/T2hlneLXaOKNuMcrvbAh78yqYs5Y
        BNSL6M0l1tI5SMJ2x47bdO4igVcWXKwSBpX0mWBAyiUP7bp74JFn/8/ymfLzdCxQotxk5b
        Way8MBFUx7Z8hv5ekT2cGMpRDA+nMPgBvQvV7J/kVOKErlJOJY834hrNXFJJbq0Id+GYjF
        6OBFrKMQex+TrPF+drrhJ81hQ2nfNhFGSXZ1WcsZKKncr3/KGcDbhsN79oUudj/dDayntN
        FVfigHBnxSfDxF6JvA86GDLjcs8+nG7GJ1v5vRYp/E0JpWvpflTE4vJI8uME6g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org, Aviram Dali <aviramd@marvell.com>
Subject: [PATCH 1/3] mtd: rawnand: marvell: Ensure program page operations are successful
Date:   Mon, 17 Jul 2023 21:42:19 +0200
Message-Id: <20230717194221.229778-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org
Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Reported-by: Aviram Dali <aviramd@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

Hello Aviram,

I have not tested this, but based on your report I believe the status
check is indeed missing here and could sometimes lead to unnoticed
partial writes.

Please test on your side and reply with your Tested-by if you validate
the change.

Any backport on kernels predating v4.17 will likely fail because of a
folder rename, so you will have to do the backport manually if needed.

Thanks,
Miquèl
---
 drivers/mtd/nand/raw/marvell_nand.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 30c15e4e1cc0..576441095012 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1162,6 +1162,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1195,7 +1196,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 
 	ret = marvell_nfc_wait_op(chip,
 				  PSEC_TO_MSEC(sdr->tPROG_max));
-	return ret;
+	if (ret)
+		return ret;
+
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
 
 static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct nand_chip *chip,
@@ -1624,6 +1636,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1660,6 +1673,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	if (ret)
 		return ret;
 
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.34.1

