Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3132B7D332A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjJWL1V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjJWL1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1FD7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A3C433CA;
        Mon, 23 Oct 2023 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060437;
        bh=3ls6LZGyZixvaIaT13MSOrVXxG+Nh+gss8o/7fgxnY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ig/1NeXJ0IUL/VaukmgUdA5/k4IAv9XMJULLkaGyJvx4S3uFnU9+DIjlvIBf8Of78
         jA5clN+h74OhbwR54/Ie5nzp0pG3Mcdq8Bz/QwFbhCn26CfgGF0HeVFwK1VAoD/P9s
         TdmDwxw1oiwh5ezUORcn6zHIaW16J0NaaJRniHIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aviram Dali <aviramd@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Ravi Chandra Minnikanti <rminnikanti@marvell.com>
Subject: [PATCH 6.1 144/196] mtd: rawnand: marvell: Ensure program page operations are successful
Date:   Mon, 23 Oct 2023 12:56:49 +0200
Message-ID: <20231023104832.554692353@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 3e01d5254698ea3d18e09d96b974c762328352cd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/marvell_nand.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1154,6 +1154,7 @@ static int marvell_nfc_hw_ecc_hmg_do_wri
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1187,7 +1188,18 @@ static int marvell_nfc_hw_ecc_hmg_do_wri
 
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
@@ -1616,6 +1628,7 @@ static int marvell_nfc_hw_ecc_bch_write_
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1652,6 +1665,14 @@ static int marvell_nfc_hw_ecc_bch_write_
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
 


