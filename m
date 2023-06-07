Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B677726EDE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjFGUx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjFGUxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DAB2113
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3091E64794
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4905FC433D2;
        Wed,  7 Jun 2023 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171195;
        bh=JmY8i5tmEGselaARSB0P4+af/A5ZKmZzV3iI9qFN5nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w46OEja2xTTlDeVFcIKUtEDoxX72lgMRuKWIKC+6a1UEoNRwVuaJg8VUakOGpp9jp
         4nm5Yb37WflKF9GgfLyyqfT4JAeNEwDJyQ4kabPutHoDI4rawo65sJQ2QiY5PPi67Q
         hWDv69+7rf8bCVTqajbLIRHn769gbi+Rr30+PTz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miquel Raynal <miquel.raynal@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 26/99] mtd: rawnand: marvell: ensure timing values are written
Date:   Wed,  7 Jun 2023 22:16:18 +0200
Message-ID: <20230607200901.079414363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 8a6f4d346f3bad9c68b4a87701eb3f7978542d57 ]

When new timing values are calculated in marvell_nfc_setup_interface()
ensure that they will be applied in marvell_nfc_select_target() by
clearing the selected_chip pointer.

Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_chip()")
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230525003154.2303012-1-chris.packham@alliedtelesis.co.nz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 36cb0db02bbb0..7ab9e9920c06e 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2401,6 +2401,12 @@ static int marvell_nfc_setup_data_interface(struct nand_chip *chip, int chipnr,
 			NDTR1_WAIT_MODE;
 	}
 
+	/*
+	 * Reset nfc->selected_chip so the next command will cause the timing
+	 * registers to be updated in marvell_nfc_select_target().
+	 */
+	nfc->selected_chip = NULL;
+
 	return 0;
 }
 
-- 
2.39.2



