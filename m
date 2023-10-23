Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF67D35A4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjJWLu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjJWLuZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FADE
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97429C433CA;
        Mon, 23 Oct 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061823;
        bh=DtptvEwHAZSKg2IN87fTGBJYcWPc40oje24av1a+K+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IATjs+HCPMsCZ/XlZZrE6J0PvHL9xWxv4srKjBDyYvXXJD7Mh1WUwccDJqGYtzwmK
         VWpcKQluZxO3CoY4TWKVJPnXq4bh7meh+rwAWsNY1W1FJUxk9BTgcG5S+YHF/CYVd2
         p3f60jOo8ZhuLP8T+g4rjPnPzXCz2CXGHYopLJLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Simek <michal.simek@amd.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 176/202] mtd: rawnand: arasan: Ensure program page operations are successful
Date:   Mon, 23 Oct 2023 12:58:03 +0200
Message-ID: <20231023104831.616037758@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 3a4a893dbb19e229db3b753f0462520b561dee98 upstream.

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
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/linux-mtd/20230717194221.229778-2-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -451,6 +451,7 @@ static int anfc_write_page_hw_ecc(struct
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int len = mtd->writesize + (oob_required ? mtd->oobsize : 0);
 	dma_addr_t dma_addr;
+	u8 status;
 	int ret;
 	struct anfc_op nfc_op = {
 		.pkt_reg =
@@ -497,10 +498,21 @@ static int anfc_write_page_hw_ecc(struct
 	}
 
 	/* Spare data is not protected */
-	if (oob_required)
+	if (oob_required) {
 		ret = nand_write_oob_std(chip, page);
+		if (ret)
+			return ret;
+	}
+
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
 
-	return ret;
+	return 0;
 }
 
 static int anfc_sel_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,


