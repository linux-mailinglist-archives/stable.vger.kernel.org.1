Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40417A6AA1
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjISSYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 14:24:09 -0400
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297390
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 11:24:04 -0700 (PDT)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6C2A6C0019A3;
        Tue, 19 Sep 2023 11:16:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6C2A6C0019A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1695147364;
        bh=SKNywjMDlIhDM4LGitYH1ovoA87rLwWDY1EAJnrUbHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb4ge94VGLuqagUV/W2ZaMl/ZzmdgEABURtcglbqwtA2fPmf43uSMRp3UqCgDDOUN
         AjnBFVt5u5J5wL1lGTCeHPzO4hk4VuauOblQ948kBmEV+D2aNt1/3LR32OWKeqkFRE
         MKveGuF02VCA5B5SGfMVABiGU9XF2QQkNa+UhZH4=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 5CD3518728C;
        Tue, 19 Sep 2023 11:16:04 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     stable@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.14.y] mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
Date:   Tue, 19 Sep 2023 11:15:44 -0700
Message-Id: <20230919181544.188110-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2023091632-marauding-viable-2fad@gregkh>
References: <2023091632-marauding-viable-2fad@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When the oob buffer length is not in multiple of words, the oob write
function does out-of-bounds read on the oob source buffer at the last
iteration. Fix that by always checking length limit on the oob buffer
read and fill with 0xff when reaching the end of the buffer to the oob
registers.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-5-william.zhang@broadcom.com
(cherry picked from commit 5d53244186c9ac58cb88d76a0958ca55b83a15cd)
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 8ebc23041194..2ab03ac409f8 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1213,19 +1213,33 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
 			     const u8 *oob, int sas, int sector_1k)
 {
 	int tbytes = sas << sector_1k;
-	int j;
+	int j, k = 0;
+	u32 last = 0xffffffff;
+	u8 *plast = (u8 *)&last;
 
 	/* Adjust OOB values for 1K sector size */
 	if (sector_1k && (i & 0x01))
 		tbytes = max(0, tbytes - (int)ctrl->max_oob);
 	tbytes = min_t(int, tbytes, ctrl->max_oob);
 
-	for (j = 0; j < tbytes; j += 4)
+	/*
+	 * tbytes may not be multiple of words. Make sure we don't read out of
+	 * the boundary and stop at last word.
+	 */
+	for (j = 0; (j + 3) < tbytes; j += 4)
 		oob_reg_write(ctrl, j,
 				(oob[j + 0] << 24) |
 				(oob[j + 1] << 16) |
 				(oob[j + 2] <<  8) |
 				(oob[j + 3] <<  0));
+
+	/* handle the remaing bytes */
+	while (j < tbytes)
+		plast[k++] = oob[j++];
+
+	if (tbytes & 0x3)
+		oob_reg_write(ctrl, (tbytes & ~0x3), (__force u32)cpu_to_be32(last));
+
 	return tbytes;
 }
 
-- 
2.37.3

