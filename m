Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD427758FD
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjHIK4Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjHIK4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B21FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADF362DC8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571EC433C7;
        Wed,  9 Aug 2023 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578583;
        bh=e5dE3oWEJjyPuzfpDjfZxWOAfMkD0nYTA6auk8D9cvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TybHU5EbH9G63qrr1+rprfOCko6F9K7q1sQ1bSPG9dnqKBoJKFBE8XKFcbRWlfVg8
         ZYf/Ry8PtQ6oLpUvoLAoflMdlA1iMMEtJYW+n/M9YeBVCnyqEY5UCklcelXiNssp5m
         h2WUp8sPSd0f2jqOEwPP+mqHCjQpq7/rg8cSk/zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Jonker <jbx6244@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/127] mtd: rawnand: rockchip: fix oobfree offset and description
Date:   Wed,  9 Aug 2023 12:41:39 +0200
Message-ID: <20230809103640.324366160@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit d0ca3b92b7a6f42841ea9da8492aaf649db79780 ]

Rockchip boot blocks are written per 4 x 512 byte sectors per page.
Each page with boot blocks must have a page address (PA) pointer in OOB
to the next page.

The currently advertised free OOB area starts at offset 6, like
if 4 PA bytes were located right after the BBM. This is wrong as the
PA bytes are located right before the ECC bytes.

Fix the layout by allowing access to all bytes between the BBM and the
PA bytes instead of reserving 4 bytes right after the BBM.

This change breaks existing jffs2 users.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/d202f12d-188c-20e8-f2c2-9cc874ad4d22@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index f133985cc053a..9070dafae9db8 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -562,9 +562,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
 		 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
 		 *
 		 * The rk_nfc_ooblayout_free() function already has reserved
-		 * these 4 bytes with:
+		 * these 4 bytes together with 2 bytes for BBM
+		 * by reducing it's length:
 		 *
-		 * oob_region->offset = NFC_SYS_DATA_SIZE + 2;
+		 * oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
 		 */
 		if (!i)
 			memcpy(rk_nfc_oob_ptr(chip, i),
@@ -933,12 +934,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section)
 		return -ERANGE;
 
-	/*
-	 * The beginning of the OOB area stores the reserved data for the NFC,
-	 * the size of the reserved data is NFC_SYS_DATA_SIZE bytes.
-	 */
 	oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
-	oob_region->offset = NFC_SYS_DATA_SIZE + 2;
+	oob_region->offset = 2;
 
 	return 0;
 }
-- 
2.40.1



