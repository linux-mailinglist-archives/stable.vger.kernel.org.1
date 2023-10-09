Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3657BDD34
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376665AbjJINIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376731AbjJINIX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA7AB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12897C433CA;
        Mon,  9 Oct 2023 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856901;
        bh=GPgZm9CaiIWT5PaXc7QtWxtrX/hyyrXWO0tgQ8BrXsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ojh5FtFdp1HzrfwMFqMDodU9ppPI1KJmnlgDQr/9n+ULk7h3fx8K0Oswzc6f7YnDC
         ob6+OSXtZIOOn6bqIleCWv4ER5OqsOKYlsONW8qBam9loolMGaWPA9viWMXl/2MIbc
         jhbFLgYslfAfuPf2WW38o6MSWcz1L5OTPMa5D2KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "Ooi, Chin Hao" <chin.hao.ooi@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Ooi@vger.kernel.org
Subject: [PATCH 6.5 028/163] iommu/vt-d: Avoid memory allocation in iommu_suspend()
Date:   Mon,  9 Oct 2023 14:59:52 +0200
Message-ID: <20231009130124.783485559@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

commit 59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e upstream.

The iommu_suspend() syscore suspend callback is invoked with IRQ disabled.
Allocating memory with the GFP_KERNEL flag may re-enable IRQs during
the suspend callback, which can cause intermittent suspend/hibernation
problems with the following kernel traces:

Calling iommu_suspend+0x0/0x1d0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 15 at kernel/time/timekeeping.c:868 ktime_get+0x9b/0xb0
...
CPU: 0 PID: 15 Comm: rcu_preempt Tainted: G     U      E      6.3-intel #r1
RIP: 0010:ktime_get+0x9b/0xb0
...
Call Trace:
 <IRQ>
 tick_sched_timer+0x22/0x90
 ? __pfx_tick_sched_timer+0x10/0x10
 __hrtimer_run_queues+0x111/0x2b0
 hrtimer_interrupt+0xfa/0x230
 __sysvec_apic_timer_interrupt+0x63/0x140
 sysvec_apic_timer_interrupt+0x7b/0xa0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1f/0x30
...
------------[ cut here ]------------
Interrupts enabled after iommu_suspend+0x0/0x1d0
WARNING: CPU: 0 PID: 27420 at drivers/base/syscore.c:68 syscore_suspend+0x147/0x270
CPU: 0 PID: 27420 Comm: rtcwake Tainted: G     U  W   E      6.3-intel #r1
RIP: 0010:syscore_suspend+0x147/0x270
...
Call Trace:
 <TASK>
 hibernation_snapshot+0x25b/0x670
 hibernate+0xcd/0x390
 state_store+0xcf/0xe0
 kobj_attr_store+0x13/0x30
 sysfs_kf_write+0x3f/0x50
 kernfs_fop_write_iter+0x128/0x200
 vfs_write+0x1fd/0x3c0
 ksys_write+0x6f/0xf0
 __x64_sys_write+0x1d/0x30
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Given that only 4 words memory is needed, avoid the memory allocation in
iommu_suspend().

CC: stable@kernel.org
Fixes: 33e07157105e ("iommu/vt-d: Avoid GFP_ATOMIC where it is not needed")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Ooi, Chin Hao <chin.hao.ooi@intel.com>
Link: https://lore.kernel.org/r/20230921093956.234692-1-rui.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230925120417.55977-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |   16 ----------------
 drivers/iommu/intel/iommu.h |    2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3004,13 +3004,6 @@ static int iommu_suspend(void)
 	struct intel_iommu *iommu = NULL;
 	unsigned long flag;
 
-	for_each_active_iommu(iommu, drhd) {
-		iommu->iommu_state = kcalloc(MAX_SR_DMAR_REGS, sizeof(u32),
-					     GFP_KERNEL);
-		if (!iommu->iommu_state)
-			goto nomem;
-	}
-
 	iommu_flush_all();
 
 	for_each_active_iommu(iommu, drhd) {
@@ -3030,12 +3023,6 @@ static int iommu_suspend(void)
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
 	return 0;
-
-nomem:
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
-
-	return -ENOMEM;
 }
 
 static void iommu_resume(void)
@@ -3067,9 +3054,6 @@ static void iommu_resume(void)
 
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
-
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
 }
 
 static struct syscore_ops iommu_syscore_ops = {
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -680,7 +680,7 @@ struct intel_iommu {
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	struct q_inval  *qi;            /* Queued invalidation info */
-	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
+	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */


