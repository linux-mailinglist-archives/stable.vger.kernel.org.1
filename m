Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159C7A3B51
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjIQUQD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjIQUPt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:15:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408E101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:15:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DFDC433C7;
        Sun, 17 Sep 2023 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981743;
        bh=QB0xNPL6gGfOOIx/B6CvlWcZ6XvzpuuofnDrBpCjgs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/+9PJb7bnDB4o1/LmMwexwiwry/0DrnbgVZUhOCh+6NA24P5OU+NlPimRL8Op1io
         5bHjThOjh4uvTVbGMAkPxgnOJkBG1Hw/IqhVeITZog4T7QGLZd9HxVuBoh2K6MzxBB
         A4sXmPVoI+PF03WoxnsmXciwkPNz7cuEjagaTy+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 166/219] mtd: rawnand: brcmnand: Fix potential false time out warning
Date:   Sun, 17 Sep 2023 21:14:53 +0200
Message-ID: <20230917191047.027479217@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Zhang <william.zhang@broadcom.com>

commit 9cc0a598b944816f2968baf2631757f22721b996 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1072,6 +1072,14 @@ static int bcmnand_ctrl_poll_status(stru
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
 


