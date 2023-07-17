Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D75756D8E
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGQTmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 15:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQTme (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 15:42:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3B132
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 12:42:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D659E1BF206;
        Mon, 17 Jul 2023 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689622948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBN2hYgkZC+vX2/vBakjoME0dxps0dBkBhnZWQPKiLs=;
        b=UZlw3ThIPhfB0CmBrpMhZwVxCED6vFYJJwuDlhoSqA8tLKVL7D/rPCapNN98zleSbsa6As
        vlZJsgm6+QsyQpAymX5t2KImlJfSFd5UTSBMJpUjhljQ4hTfD/pppYPrA8N9R9kpiuUTHe
        F4hF873Jzzg2TqZcFlVQYleaC8T5BMs/kSPvjPrI/aq0llu3nnDuh2X1yZcyBPHPR1RSJT
        UzSblPMTFC3WVIp+oRwDDbm13rIi8PtqJRch9XRN8op340K/tdDTdxBli3fYH2fgHlW9i6
        1vlF+vT9kQ377Gj/l3cDr9J9PWRiWFO7nMdM7ZGqENgZrhd5rpIccGZGTYb8nw==
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
Subject: [PATCH 3/3] mtd: rawnand: pl353: Ensure program page operations are successful
Date:   Mon, 17 Jul 2023 21:42:21 +0200
Message-Id: <20230717194221.229778-3-miquel.raynal@bootlin.com>
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
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

Hello Michal,

Same as for the Arasan controller, this is not tested, but I believe it
is required. Let me know how testing goes.

Thanks,
Miquèl
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 28b7bd7e22eb..9dd06eeb021e 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -513,6 +513,7 @@ static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
 	u32 addr1 = 0, addr2 = 0, row;
 	u32 cmd_addr;
 	int i, ret;
+	u8 status;
 
 	ret = pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_APB);
 	if (ret)
@@ -565,6 +566,14 @@ static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
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
 
-- 
2.34.1

