Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89428726E68
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjFGUua (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjFGUtp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02DD213C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF0D646D4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DC5C433EF;
        Wed,  7 Jun 2023 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170966;
        bh=bvUJX6zol3W4Jldbjlq7JZpJ0EH3cfP/GH4aQtUG12o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzyKnwH4uq1uHTozo2Zlp2ApCaSCTz176EYxCl41t3WKCq6wjh+fLtff9W8jKQ5be
         i7akGEogdDMRdC/TKJ3V8p79L9PHhgHcNJQby+HK1cL1LHNdikY1Bq28SgqrPpH8gy
         VpIU2jsl6S4uaRE5W1OqQTdO+VhkUOpvXqXE29Is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 032/120] mtd: rawnand: marvell: dont set the NAND frequency select
Date:   Wed,  7 Jun 2023 22:15:48 +0200
Message-ID: <20230607200901.921615889@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 9d437f1566ed5..2ef1a5adfcfc1 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2891,10 +2891,6 @@ static int marvell_nfc_init(struct marvell_nfc *nfc)
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



