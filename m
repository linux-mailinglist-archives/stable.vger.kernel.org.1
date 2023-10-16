Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30867CA28B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjJPIvN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjJPIvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDDE6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:51:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F259BC433CA;
        Mon, 16 Oct 2023 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446269;
        bh=RdqryuMFO/YIUJtPVnwpHj0ygNQJOkdqBTLWaPRvEio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCPgr7FT1aB00e4k+Vm2LSmmhBJAzjvjLZ9SYP+JVOudXdO+pBeIbX+7C+VC8l0vP
         ULlRN2BwhteX9LgfT58RDZmuZaRCqHOIZl2u31yGrE5y1KlH7GIKZtYT3y8+JiC8Hs
         jxlMoV9X3Zp/1sfTUNthvmP7ciaCpN++oSb0RMQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rex Zhang <rex.zhang@intel.com>,
        Lijun Pan <lijun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 081/102] dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq
Date:   Mon, 16 Oct 2023 10:41:20 +0200
Message-ID: <20231016083955.855001526@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rex Zhang <rex.zhang@intel.com>

[ Upstream commit c0409dd3d151f661e7e57b901a81a02565df163c ]

In idxd_cmd_exec(), wait_event_lock_irq() explicitly calls
spin_unlock_irq()/spin_lock_irq(). If the interrupt is on before entering
wait_event_lock_irq(), it will become off status after
wait_event_lock_irq() is called. Later, wait_for_completion() may go to
sleep but irq is disabled. The scenario is warned in might_sleep().

Fix it by using spin_lock_irqsave() instead of the primitive spin_lock()
to save the irq status before entering wait_event_lock_irq() and using
spin_unlock_irqrestore() instead of the primitive spin_unlock() to restore
the irq status before entering wait_for_completion().

Before the change:
idxd_cmd_exec() {
interrupt is on
spin_lock()                        // interrupt is on
	wait_event_lock_irq()
		spin_unlock_irq()  // interrupt is enabled
		...
		spin_lock_irq()    // interrupt is disabled
spin_unlock()                      // interrupt is still disabled
wait_for_completion()              // report "BUG: sleeping function
				   // called from invalid context...
				   // in_atomic() irqs_disabled()"
}

After applying spin_lock_irqsave():
idxd_cmd_exec() {
interrupt is on
spin_lock_irqsave()                // save the on state
				   // interrupt is disabled
	wait_event_lock_irq()
		spin_unlock_irq()  // interrupt is enabled
		...
		spin_lock_irq()    // interrupt is disabled
spin_unlock_irqrestore()           // interrupt is restored to on
wait_for_completion()              // No Call trace
}

Fixes: f9f4082dbc56 ("dmaengine: idxd: remove interrupt disable for cmd_lock")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Signed-off-by: Lijun Pan <lijun.pan@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/r/20230916060619.3744220-1-rex.zhang@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 535f021911c55..f2cfefc505a8c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -490,6 +490,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	u32 stat;
+	unsigned long flags;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -503,7 +504,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock(&idxd->cmd_lock);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
 			    idxd->cmd_lock);
@@ -520,7 +521,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock(&idxd->cmd_lock);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
 	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 	spin_lock(&idxd->cmd_lock);
-- 
2.40.1



