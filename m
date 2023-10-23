Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F77D3329
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjJWL1U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjJWL1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EE102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB37C433C8;
        Mon, 23 Oct 2023 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060434;
        bh=9WqIOMui8MD2U9avQd948ejDIltfiN/wABZ5yawB0Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWbySAvsUNy7NNBGB14HxUsPSX8FsHUdmiHLymOwYiWCOO5E/Wccv4fF/5wwx5GKe
         c4SzMogZ5ySg+KIj6v27BFq5B1zTQ9CHIEIma6XRBr4uPCLAUM45dQRLWGday70Tje
         6F4EW6XDLc9nDXj8tYf0ixtp5dKHagJU1O+k+6GQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Simek <michal.simek@amd.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 143/196] mtd: rawnand: pl353: Ensure program page operations are successful
Date:   Mon, 23 Oct 2023 12:56:48 +0200
Message-ID: <20231023104832.527582189@linuxfoundation.org>
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

commit 9777cc13fd2c3212618904636354be60835e10bb upstream.

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
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/linux-mtd/20230717194221.229778-3-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -513,6 +513,7 @@ static int pl35x_nand_write_page_hwecc(s
 	u32 addr1 = 0, addr2 = 0, row;
 	u32 cmd_addr;
 	int i, ret;
+	u8 status;
 
 	ret = pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_APB);
 	if (ret)
@@ -565,6 +566,14 @@ static int pl35x_nand_write_page_hwecc(s
 	if (ret)
 		goto disable_ecc_engine;
 
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		goto disable_ecc_engine;
+
+	if (status & NAND_STATUS_FAIL)
+		ret = -EIO;
+
 disable_ecc_engine:
 	pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_BYPASS);
 


