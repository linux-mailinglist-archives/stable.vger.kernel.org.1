Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C917DA850
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJ1Rx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Rx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 13:53:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C1ED
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698515605; x=1730051605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nA82oiS6OwSAKblQ370dp2vW/UtelFuft3ISN5WeRoM=;
  b=EFNZIunXDQ2dg0N6t7kHHMoceR6Yf3b3/YYPDyEeT0H+OhTn46EAXokY
   oFZSRO0+mf1z32RWaliC7jQAeBjrSAYa8SVEXog0RvlJJVWZ15nRbgC+z
   Ms+e6fi6755sd7dB/CpUlDcp/AV9RpkbLBFOadTwViXow7v9QNhBcizL3
   R7SY3aNuTnjcII4q4IrYAnh2ZXKJ5tk4HOFGM87bXG4HbubVyirP3akhQ
   N8qvjhSResbqzlHPPoikfA3P3Pv3Vffn5oLgjatnacCfXrVSi0qNzXPEB
   hVLFlSob3eKjzTfjwH7BBWHc5QQOvHzclyJHRPwu5oFMCZlavBjE2JLqv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="723695"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="723695"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 10:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="876676910"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="876676910"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 10:53:22 -0700
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        stanislaw.gruszka@linux.intel.com,
        Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 6.5] accel/ivpu/37xx: Fix missing VPUIP interrupts
Date:   Sat, 28 Oct 2023 19:53:20 +0200
Message-Id: <20231028175320.6791-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Wachowski <karol.wachowski@linux.intel.com>

commit b132ac51d7a50c37683be56c96ff64f8c887930f upstream.

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
---
 drivers/accel/ivpu/ivpu_hw_mtl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_mtl.c b/drivers/accel/ivpu/ivpu_hw_mtl.c
index 2a5dd3a5dc46..9a49255e60c8 100644
--- a/drivers/accel/ivpu/ivpu_hw_mtl.c
+++ b/drivers/accel/ivpu/ivpu_hw_mtl.c
@@ -953,9 +953,6 @@ static u32 ivpu_hw_mtl_irqb_handler(struct ivpu_device *vdev, int irq)
 	if (status == 0)
 		return 0;
 
-	/* Disable global interrupt before handling local buttress interrupts */
-	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x1);
-
 	if (REG_TEST_FLD(MTL_BUTTRESS_INTERRUPT_STAT, FREQ_CHANGE, status))
 		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x", REGB_RD32(MTL_BUTTRESS_CURRENT_PLL));
 
@@ -986,9 +983,6 @@ static u32 ivpu_hw_mtl_irqb_handler(struct ivpu_device *vdev, int irq)
 	else
 		REGB_WR32(MTL_BUTTRESS_INTERRUPT_STAT, status);
 
-	/* Re-enable global interrupt */
-	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x0);
-
 	if (schedule_recovery)
 		ivpu_pm_schedule_recovery(vdev);
 
@@ -1000,9 +994,14 @@ static irqreturn_t ivpu_hw_mtl_irq_handler(int irq, void *ptr)
 	struct ivpu_device *vdev = ptr;
 	u32 ret_irqv, ret_irqb;
 
+	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x1);
+
 	ret_irqv = ivpu_hw_mtl_irqv_handler(vdev, irq);
 	ret_irqb = ivpu_hw_mtl_irqb_handler(vdev, irq);
 
+	/* Re-enable global interrupts to re-trigger MSI for pending interrupts */
+	REGB_WR32(MTL_BUTTRESS_GLOBAL_INT_MASK, 0x0);
+
 	return IRQ_RETVAL(ret_irqb | ret_irqv);
 }
 
-- 
2.34.1

