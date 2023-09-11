Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB379BE71
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjIKVKS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbjIKOyt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDA118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD446C433C7;
        Mon, 11 Sep 2023 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444084;
        bh=mEsXe9iUMEnxk6btcEEIdp4P4hWM3jz1vBuauQvKm60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kytDjDhzGT3Dvt56hawGpROk+8myo/ly/ljuF6Mzns5jleQtB+wmZ7EGYj+Vz4c6V
         idBqBZID6LQu6r2uyfENNeyzuezs/bVcl+3UEFPR+Fcnv2cidiydHn58ItNQcehnqu
         i50GzJRiyoIGinDznOUJrgj/nSX5fTJ630JnHQaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Zhang <william.zhang@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 604/737] mtd: rawnand: brcmnand: Fix mtd oobsize
Date:   Mon, 11 Sep 2023 15:47:43 +0200
Message-ID: <20230911134707.408187773@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit 60177390fa061c62d156f4a546e3efd90df3c183 ]

brcmnand controller can only access the flash spare area up to certain
bytes based on the ECC level. It can be less than the actual flash spare
area size. For example, for many NAND chip supporting ECC BCH-8, it has
226 bytes spare area. But controller can only uses 218 bytes. So brcmand
driver overrides the mtd oobsize with the controller's accessible spare
area size. When the nand base driver utilizes the nand_device object, it
resets the oobsize back to the actual flash spare aprea size from
nand_memory_organization structure and controller may not able to access
all the oob area as mtd advises.

This change fixes the issue by overriding the oobsize in the
nand_memory_organization structure to the controller's accessible spare
area size.

Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-6-william.zhang@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2e9c2e2d9c9f7..d8418d7fcc372 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2612,6 +2612,8 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	struct nand_chip *chip = &host->chip;
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&chip->base);
+	struct nand_memory_organization *memorg =
+		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
 	char msg[128];
@@ -2633,10 +2635,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	if (cfg->spare_area_size > ctrl->max_oob)
 		cfg->spare_area_size = ctrl->max_oob;
 	/*
-	 * Set oobsize to be consistent with controller's spare_area_size, as
-	 * the rest is inaccessible.
+	 * Set mtd and memorg oobsize to be consistent with controller's
+	 * spare_area_size, as the rest is inaccessible.
 	 */
 	mtd->oobsize = cfg->spare_area_size * (mtd->writesize >> FC_SHIFT);
+	memorg->oobsize = mtd->oobsize;
 
 	cfg->device_size = mtd->size;
 	cfg->block_size = mtd->erasesize;
-- 
2.40.1



