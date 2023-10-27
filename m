Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7818F7D97BC
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0MTw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:19:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EC18A
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:19:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D13C433C7;
        Fri, 27 Oct 2023 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409189;
        bh=yZodkgXkTQweCM0qCJLXsHmn+bsZyb1tzlxa4EQeACM=;
        h=Subject:To:Cc:From:Date:From;
        b=lflwSkqFeIo/oIAwP3D4w0lrqlSVFgE/ThQd77rTc9qTrxNjoQfU2Q1SPCOtB+d35
         Q8oFMLQgWnZfm0oW0t+ipUyf6P6682eJ9Jt0aE/I/1J+Ira6X5QbqH1Os5ivoX/v4Q
         szg4aNbG7d+THdpfqmpjNGCKiY8sO9xgSwwWQiEY=
Subject: FAILED: patch "[PATCH] accel/ivpu/37xx: Fix missing VPUIP interrupts" failed to apply to 6.5-stable tree
To:     karol.wachowski@linux.intel.com, stanislaw.gruszka@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:19:46 +0200
Message-ID: <2023102746-unengaged-cosponsor-948a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x b132ac51d7a50c37683be56c96ff64f8c887930f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102746-unengaged-cosponsor-948a@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b132ac51d7a50c37683be56c96ff64f8c887930f Mon Sep 17 00:00:00 2001
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Date: Tue, 24 Oct 2023 18:19:52 +0200
Subject: [PATCH] accel/ivpu/37xx: Fix missing VPUIP interrupts

Move sequence of masking and unmasking global interrupts from buttress
interrupt handler to generic one that handles both VPUIP and BTRS
interrupts. Unmasking global interrupts will re-trigger MSI for any
pending interrupts.

Lack of this sequence will cause the driver to miss any
VPUIP interrupt that comes after reading VPU_37XX_HOST_SS_ICB_STATUS_0
and before clearing all active interrupt sources.

Fixes: 35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
Cc: stable@vger.kernel.org
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231024161952.759914-1-stanislaw.gruszka@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_hw_37xx.c b/drivers/accel/ivpu/ivpu_hw_37xx.c
index 976019429164..18be8b98e9a8 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -940,9 +940,6 @@ static u32 ivpu_hw_37xx_irqb_handler(struct ivpu_device *vdev, int irq)
 	if (status == 0)
 		return 0;
 
-	/* Disable global interrupt before handling local buttress interrupts */
-	REGB_WR32(VPU_37XX_BUTTRESS_GLOBAL_INT_MASK, 0x1);
-
 	if (REG_TEST_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, FREQ_CHANGE, status))
 		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x",
 			 REGB_RD32(VPU_37XX_BUTTRESS_CURRENT_PLL));
@@ -974,9 +971,6 @@ static u32 ivpu_hw_37xx_irqb_handler(struct ivpu_device *vdev, int irq)
 	else
 		REGB_WR32(VPU_37XX_BUTTRESS_INTERRUPT_STAT, status);
 
-	/* Re-enable global interrupt */
-	REGB_WR32(VPU_37XX_BUTTRESS_GLOBAL_INT_MASK, 0x0);
-
 	if (schedule_recovery)
 		ivpu_pm_schedule_recovery(vdev);
 
@@ -988,9 +982,14 @@ static irqreturn_t ivpu_hw_37xx_irq_handler(int irq, void *ptr)
 	struct ivpu_device *vdev = ptr;
 	u32 ret_irqv, ret_irqb;
 
+	REGB_WR32(VPU_37XX_BUTTRESS_GLOBAL_INT_MASK, 0x1);
+
 	ret_irqv = ivpu_hw_37xx_irqv_handler(vdev, irq);
 	ret_irqb = ivpu_hw_37xx_irqb_handler(vdev, irq);
 
+	/* Re-enable global interrupts to re-trigger MSI for pending interrupts */
+	REGB_WR32(VPU_37XX_BUTTRESS_GLOBAL_INT_MASK, 0x0);
+
 	return IRQ_RETVAL(ret_irqb | ret_irqv);
 }
 

