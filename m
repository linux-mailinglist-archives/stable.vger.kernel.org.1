Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDB7BC75D
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbjJGMDA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJGMC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E5BF
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D47DC433C7;
        Sat,  7 Oct 2023 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696680178;
        bh=HRkZPNxouJ0FOvq/Wr2KqYw+92g8K579BntloK0Fxd4=;
        h=Subject:To:Cc:From:Date:From;
        b=1YMGQ9vvrvpZ+g31k/d27/FQZDcB1FtVakUiElfz4XBiO5HjwERwovs9cqRbvYZs3
         uvmjl806gs09MVHdid32Po2F1D0xj9zgUCNdHAP7865GCWkOAkRZ1JqxcIsyHmVrFM
         RjPScE1etQo4b2C5c1ryW6T2Z4O/zEqfuaJy2wio=
Subject: FAILED: patch "[PATCH] iommu/vt-d: Avoid memory allocation in iommu_suspend()" failed to apply to 5.15-stable tree
To:     rui.zhang@intel.com, baolu.lu@linux.intel.com,
        chin.hao.ooi@intel.com, jroedel@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:02:55 +0200
Message-ID: <2023100755-chevron-epilogue-4117@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100755-chevron-epilogue-4117@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

59df44bfb0ca ("iommu/vt-d: Avoid memory allocation in iommu_suspend()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 25 Sep 2023 20:04:17 +0800
Subject: [PATCH] iommu/vt-d: Avoid memory allocation in iommu_suspend()

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

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5db283c17e0d..3685ba90ec88 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2998,13 +2998,6 @@ static int iommu_suspend(void)
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
@@ -3024,12 +3017,6 @@ static int iommu_suspend(void)
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
@@ -3061,9 +3048,6 @@ static void iommu_resume(void)
 
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
-
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
 }
 
 static struct syscore_ops iommu_syscore_ops = {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c18fb699c87a..7dac94f62b4e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -681,7 +681,7 @@ struct intel_iommu {
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	struct q_inval  *qi;            /* Queued invalidation info */
-	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
+	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */

