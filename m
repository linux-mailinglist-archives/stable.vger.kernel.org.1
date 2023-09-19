Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB57A6A90
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 20:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjISSSQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSSQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 14:18:16 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 11:18:10 PDT
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C58F
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 11:18:10 -0700 (PDT)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6BFFBC0019A4;
        Tue, 19 Sep 2023 11:18:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6BFFBC0019A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1695147490;
        bh=J4TE+RH45S5ziuzqP5Hp6uQGgZ92z9N5QWBAry+usqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRKXvAwe7DDd5G+0J85gC9XTn9zh2rwgYO3CZVIFo572X2GBzAmG2McCHh38U5Ptp
         GI9PvC42eKj4MJJ3bCfKMQGHZ4RqKFx91i2pwxjg1v/XcX3FWopoTAqX8OFTNPiAdG
         rjQGbbQ9m8iEdYEu7b1wiTPVCEZsPK/k5mkiNMh4=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 5765B18728C;
        Tue, 19 Sep 2023 11:18:10 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     stable@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.14.y] mtd: rawnand: brcmnand: Fix potential false time out warning
Date:   Tue, 19 Sep 2023 11:18:00 -0700
Message-Id: <20230919181800.188471-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2023091616-equipment-bucktooth-6ae5@gregkh>
References: <2023091616-equipment-bucktooth-6ae5@gregkh>
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

If system is busy during the command status polling function, the driver
may not get the chance to poll the status register till the end of time
out and return the premature status.  Do a final check after time out
happens to ensure reading the correct status.

Fixes: 9d2ee0a60b8b ("mtd: nand: brcmnand: Check flash #WP pin status before nand erase/program")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-3-william.zhang@broadcom.com
(cherry picked from commit 9cc0a598b944816f2968baf2631757f22721b996)
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 2ab03ac409f8..3676a38fafe9 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -836,6 +836,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
 		cpu_relax();
 	} while (time_after(limit, jiffies));
 
+	/*
+	 * do a final check after time out in case the CPU was busy and the driver
+	 * did not get enough time to perform the polling to avoid false alarms
+	 */
+	val = brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
+	if ((val & mask) == expected_val)
+		return 0;
+
 	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 
-- 
2.37.3

