Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027A7A2FFD
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbjIPMXv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbjIPMXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D1CED
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:23:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC1DC433C8;
        Sat, 16 Sep 2023 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867011;
        bh=c1DaT94f7l0JGGpX91QReqdkQsYh96Zg2J8+fXsX8Yc=;
        h=Subject:To:Cc:From:Date:From;
        b=Kldjizg9KtRSzXBHz+uC74FkBRE+9KI+av5fIj+jD6INvN/r3MaylU8T+lIan4Vid
         y7cA5Awe2CPlj4klDaZy8KHke8kdD8P+e/3XPXDXhdg4HvK0tE6F37DTs3no2Vk8LS
         gAUC0BneZkMWMG7OmbryLhzOx9IhUXJ9GdFpTmpw=
Subject: FAILED: patch "[PATCH] mtd: rawnand: brcmnand: Fix potential false time out warning" failed to apply to 4.14-stable tree
To:     william.zhang@broadcom.com, florian.fainelli@broadcom.com,
        miquel.raynal@bootlin.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:23:16 +0200
Message-ID: <2023091616-equipment-bucktooth-6ae5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 9cc0a598b944816f2968baf2631757f22721b996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091616-equipment-bucktooth-6ae5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

9cc0a598b944 ("mtd: rawnand: brcmnand: Fix potential false time out warning")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cc0a598b944816f2968baf2631757f22721b996 Mon Sep 17 00:00:00 2001
From: William Zhang <william.zhang@broadcom.com>
Date: Thu, 6 Jul 2023 11:29:06 -0700
Subject: [PATCH] mtd: rawnand: brcmnand: Fix potential false time out warning

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

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 9ea96911d16b..9a373a10304d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1080,6 +1080,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
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
 

