Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59A7D1BDA
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjJUJBR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjJUJBR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:01:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097CA6
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:01:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E404C433C8;
        Sat, 21 Oct 2023 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697878871;
        bh=bq2BaSJMF/R6HwR8qbHIKV1D+OQMnwFfBkHWRNW7xmg=;
        h=Subject:To:Cc:From:Date:From;
        b=AD2Iv09NDEQ9ie4mfG/GfSJ93sUKX2QnbMwJl5MdKQamIcEw93lz7/Xgz9IYQgUh2
         Pdpci9mJk9v4N7lgwujA/XBzQoyNPqBQZOjyeptBehvN4PINERgUdl2rRi6P+i72XU
         GJlZl3Q63kHUOQmpj1fcuwXtGswBtQkx+nuqrE6w=
Subject: FAILED: patch "[PATCH] mtd: rawnand: marvell: Ensure program page operations are" failed to apply to 5.4-stable tree
To:     miquel.raynal@bootlin.com, aviramd@marvell.com,
        rminnikanti@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:01:08 +0200
Message-ID: <2023102108-winner-gorged-4d0d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 3e01d5254698ea3d18e09d96b974c762328352cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102108-winner-gorged-4d0d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e01d5254698ea3d18e09d96b974c762328352cd Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 17 Jul 2023 21:42:19 +0200
Subject: [PATCH] mtd: rawnand: marvell: Ensure program page operations are
 successful

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
Tested-by: Ravi Chandra Minnikanti <rminnikanti@marvell.com>
Link: https://lore.kernel.org/linux-mtd/20230717194221.229778-1-miquel.raynal@bootlin.com

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 2c94da7a3b3a..b841a81cb128 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1165,6 +1165,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1198,7 +1199,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 
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
@@ -1627,6 +1639,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1663,6 +1676,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
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
 

