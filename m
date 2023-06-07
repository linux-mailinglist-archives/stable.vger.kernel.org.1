Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AF726F79
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjFGU6j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjFGU6e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3C2693
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2096489C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDDCC433EF;
        Wed,  7 Jun 2023 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171492;
        bh=9ad7ZqI0JW+a0d0z29ZE8gLVc6qUfEiBBEvkrZOGYaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKsXdXHZNuKyEpxSVQzo3/Umrub+iAsx8m5gsCW73wekgMA/tRcOk3/F8x35qgO73
         mmVLyeaUSK4ryQLnqimnSSx5UW6T24VUSJT6m/uF1/fI5yaumvpQcUnh+WrdCVGCe0
         mIvczFXb/OMzYc4u0nry+lpr1VGqEGXwcWtCHuNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 038/159] mtd: rawnand: marvell: dont set the NAND frequency select
Date:   Wed,  7 Jun 2023 22:15:41 +0200
Message-ID: <20230607200904.915907775@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

[ Upstream commit c4d28e30a8d0b979e4029465ab8f312ab6ce2644 ]

marvell_nfc_setup_interface() uses the frequency retrieved from the
clock associated with the nand interface to determine the timings that
will be used. By changing the NAND frequency select without reflecting
this in the clock configuration this means that the timings calculated
don't correctly meet the requirements of the NAND chip. This hasn't been
an issue up to now because of a different bug that was stopping the
timings being updated after they were initially set.

Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_chip()")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230525003154.2303012-2-chris.packham@alliedtelesis.co.nz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 95dee54fe079c..9f662d5cf7fac 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2885,10 +2885,6 @@ static int marvell_nfc_init(struct marvell_nfc *nfc)
 		regmap_update_bits(sysctrl_base, GENCONF_CLK_GATING_CTRL,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE);
-
-		regmap_update_bits(sysctrl_base, GENCONF_ND_CLK_CTRL,
-				   GENCONF_ND_CLK_CTRL_EN,
-				   GENCONF_ND_CLK_CTRL_EN);
 	}
 
 	/* Configure the DMA if appropriate */
-- 
2.39.2



