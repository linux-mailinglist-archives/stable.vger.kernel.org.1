Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB397A2FF8
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbjIPMXt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjIPMXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:23:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67E194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:23:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA054C433C7;
        Sat, 16 Sep 2023 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866997;
        bh=x2hr1qPMfCf381fqZQJopvZpum0dt5xxWuQIeumvp3o=;
        h=Subject:To:Cc:From:Date:From;
        b=DL6HbUcHWS/BnjEnA+HIhYPpF8TYzH8m2bryqMe8RgBJs2bpGLSH8MdT9A55hv/xJ
         5IpFB34kX4UOLvZpVO+gH7Ij6utMzIUcEe1hKhSl4wzPPc/FqLmSae+Hw1KG2lR+qy
         323RigYIFqf1UnMMG+QNcF62smDOANX8b0JgRxS0=
Subject: FAILED: patch "[PATCH] mtd: rawnand: brcmnand: Fix crash during the panic_write" failed to apply to 4.14-stable tree
To:     william.zhang@broadcom.com, florian.fainelli@broadcom.com,
        kamal.dasu@broadcom.com, kursad.oney@broadcom.com,
        miquel.raynal@bootlin.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:22:16 +0200
Message-ID: <2023091616-collapse-uncrown-ad3a@gregkh>
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
git cherry-pick -x e66dd317194daae0475fe9e5577c80aa97f16cb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091616-collapse-uncrown-ad3a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

e66dd317194d ("mtd: rawnand: brcmnand: Fix crash during the panic_write")
3c7c1e4594ef ("mtd: rawnand: brcmnand: Refactored code to introduce helper functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e66dd317194daae0475fe9e5577c80aa97f16cb9 Mon Sep 17 00:00:00 2001
From: William Zhang <william.zhang@broadcom.com>
Date: Thu, 6 Jul 2023 11:29:07 -0700
Subject: [PATCH] mtd: rawnand: brcmnand: Fix crash during the panic_write

When executing a NAND command within the panic write path, wait for any
pending command instead of calling BUG_ON to avoid crashing while
already crashing.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>
Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-4-william.zhang@broadcom.com

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 9a373a10304d..b2c6396060db 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1608,7 +1608,17 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 
 	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
 
-	BUG_ON(ctrl->cmd_pending != 0);
+	/*
+	 * If we came here through _panic_write and there is a pending
+	 * command, try to wait for it. If it times out, rather than
+	 * hitting BUG_ON, just return so we don't crash while crashing.
+	 */
+	if (oops_in_progress) {
+		if (ctrl->cmd_pending &&
+			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
+			return;
+	} else
+		BUG_ON(ctrl->cmd_pending != 0);
 	ctrl->cmd_pending = cmd;
 
 	ret = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);

