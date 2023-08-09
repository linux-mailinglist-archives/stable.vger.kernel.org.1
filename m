Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6877582F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjHIKuw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjHIKua (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3201BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F31630F7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7902DC433C9;
        Wed,  9 Aug 2023 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578227;
        bh=lb0igJ6ekcNPyY/9qC3alyjtWVuLdfTFXiXOe8e0xgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzgN3OGsUknGSK7WOd09VcsS1Zj3nj2uBWsC7TYquGtDzlIf7aFOG3hi58tCjbiVr
         EVw7yyyxxzd8c7+RSWoYtVBu200Qbnht9oeobBKDD4F6hckGwNjc0ulg8ejstXt13l
         Ibap1sfng7mHwDJ7gPu3XfG0w4dt7aezlq7B1MC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Jonker <jbx6244@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 150/165] mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts
Date:   Wed,  9 Aug 2023 12:41:21 +0200
Message-ID: <20230809103647.686288629@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit ea690ad78dd611e3906df5b948a516000b05c1cb ]

Currently, read/write_page_hwecc() and read/write_page_raw() are not
aligned: there is a mismatch in the OOB bytes which are not
read/written at the same offset in both cases (raw vs. hwecc).

This is a real problem when relying on the presence of the Page
Addresses (PA) when using the NAND chip as a boot device, as the
BootROM expects additional data in the OOB area at specific locations.

Rockchip boot blocks are written per 4 x 512 byte sectors per page.
Each page with boot blocks must have a page address (PA) pointer in OOB
to the next page. Pages are written in a pattern depending on the NAND chip ID.

Generate boot block page address and pattern for hwecc in user space
and copy PA data to/from the already reserved last 4 bytes before ECC
in the chip->oob_poi data layout.

Align the different helpers. This change breaks existing jffs2 users.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/5e782c08-862b-51ae-47ff-3299940928ca@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 37fc07ba57aab..5a04680342c32 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -598,7 +598,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	int pages_per_blk = mtd->erasesize / mtd->writesize;
 	int ret = 0, i, boot_rom_mode = 0;
 	dma_addr_t dma_data, dma_oob;
-	u32 reg;
+	u32 tmp;
 	u8 *oob;
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
@@ -625,6 +625,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	 *
 	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
 	 *
+	 * The code here just swaps the first 4 bytes with the last
+	 * 4 bytes without losing any data.
+	 *
+	 * The chip->oob_poi data layout:
+	 *
+	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
+	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
@@ -635,21 +642,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	}
 
 	for (i = 0; i < ecc->steps; i++) {
-		if (!i) {
-			reg = 0xFFFFFFFF;
-		} else {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
 			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
-			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
-			      oob[3] << 24;
-		}
 
-		if (!i && boot_rom_mode)
-			reg = (page & (pages_per_blk - 1)) * 4;
+		tmp = oob[0] | oob[1] << 8 | oob[2] << 16 | oob[3] << 24;
 
 		if (nfc->cfg->type == NFC_V9)
-			nfc->oob_buf[i] = reg;
+			nfc->oob_buf[i] = tmp;
 		else
-			nfc->oob_buf[i * (oob_step / 4)] = reg;
+			nfc->oob_buf[i * (oob_step / 4)] = tmp;
 	}
 
 	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
@@ -812,12 +815,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
 		goto timeout_err;
 	}
 
-	for (i = 1; i < ecc->steps; i++) {
-		oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+	for (i = 0; i < ecc->steps; i++) {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
+			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+
 		if (nfc->cfg->type == NFC_V9)
 			tmp = nfc->oob_buf[i];
 		else
 			tmp = nfc->oob_buf[i * (oob_step / 4)];
+
 		*oob++ = (u8)tmp;
 		*oob++ = (u8)(tmp >> 8);
 		*oob++ = (u8)(tmp >> 16);
-- 
2.40.1



