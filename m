Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA167A81BE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjITMsI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjITMsG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C31D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35AFC433C8;
        Wed, 20 Sep 2023 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214079;
        bh=WVJDvfSkGXZ/px4cHma3qH7l3HI6oasGAm+jlnWo7u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Drcov4q4+feso9A/HsQExzA9M8rhEAMIeV4M56o/LQY9PtiFJnuPtAn9+PXAKKUQV
         fB+KKPfjnNG1fm7JEkE9ykECgXK5AcCnpPne63KBah+gQ0ik9H2+7Dfkj/6998NnG/
         0I5kd6avVodIKAU7FWkUN98cIOj8GUbxtIlPnL1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junxiao Bi <junxiao.bi@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 104/110] scsi: megaraid_sas: Fix deadlock on firmware crashdump
Date:   Wed, 20 Sep 2023 13:32:42 +0200
Message-ID: <20230920112834.302306886@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 0b0747d507bffb827e40fc0f9fb5883fffc23477 upstream.

The following processes run into a deadlock. CPU 41 was waiting for CPU 29
to handle a CSD request while holding spinlock "crashdump_lock", but CPU 29
was hung by that spinlock with IRQs disabled.

  PID: 17360    TASK: ffff95c1090c5c40  CPU: 41  COMMAND: "mrdiagd"
  !# 0 [ffffb80edbf37b58] __read_once_size at ffffffff9b871a40 include/linux/compiler.h:185:0
  !# 1 [ffffb80edbf37b58] atomic_read at ffffffff9b871a40 arch/x86/include/asm/atomic.h:27:0
  !# 2 [ffffb80edbf37b58] dump_stack at ffffffff9b871a40 lib/dump_stack.c:54:0
   # 3 [ffffb80edbf37b78] csd_lock_wait_toolong at ffffffff9b131ad5 kernel/smp.c:364:0
   # 4 [ffffb80edbf37b78] __csd_lock_wait at ffffffff9b131ad5 kernel/smp.c:384:0
   # 5 [ffffb80edbf37bf8] csd_lock_wait at ffffffff9b13267a kernel/smp.c:394:0
   # 6 [ffffb80edbf37bf8] smp_call_function_many at ffffffff9b13267a kernel/smp.c:843:0
   # 7 [ffffb80edbf37c50] smp_call_function at ffffffff9b13279d kernel/smp.c:867:0
   # 8 [ffffb80edbf37c50] on_each_cpu at ffffffff9b13279d kernel/smp.c:976:0
   # 9 [ffffb80edbf37c78] flush_tlb_kernel_range at ffffffff9b085c4b arch/x86/mm/tlb.c:742:0
   #10 [ffffb80edbf37cb8] __purge_vmap_area_lazy at ffffffff9b23a1e0 mm/vmalloc.c:701:0
   #11 [ffffb80edbf37ce0] try_purge_vmap_area_lazy at ffffffff9b23a2cc mm/vmalloc.c:722:0
   #12 [ffffb80edbf37ce0] free_vmap_area_noflush at ffffffff9b23a2cc mm/vmalloc.c:754:0
   #13 [ffffb80edbf37cf8] free_unmap_vmap_area at ffffffff9b23bb3b mm/vmalloc.c:764:0
   #14 [ffffb80edbf37cf8] remove_vm_area at ffffffff9b23bb3b mm/vmalloc.c:1509:0
   #15 [ffffb80edbf37d18] __vunmap at ffffffff9b23bb8a mm/vmalloc.c:1537:0
   #16 [ffffb80edbf37d40] vfree at ffffffff9b23bc85 mm/vmalloc.c:1612:0
   #17 [ffffb80edbf37d58] megasas_free_host_crash_buffer [megaraid_sas] at ffffffffc020b7f2 drivers/scsi/megaraid/megaraid_sas_fusion.c:3932:0
   #18 [ffffb80edbf37d80] fw_crash_state_store [megaraid_sas] at ffffffffc01f804d drivers/scsi/megaraid/megaraid_sas_base.c:3291:0
   #19 [ffffb80edbf37dc0] dev_attr_store at ffffffff9b56dd7b drivers/base/core.c:758:0
   #20 [ffffb80edbf37dd0] sysfs_kf_write at ffffffff9b326acf fs/sysfs/file.c:144:0
   #21 [ffffb80edbf37de0] kernfs_fop_write at ffffffff9b325fd4 fs/kernfs/file.c:316:0
   #22 [ffffb80edbf37e20] __vfs_write at ffffffff9b29418a fs/read_write.c:480:0
   #23 [ffffb80edbf37ea8] vfs_write at ffffffff9b294462 fs/read_write.c:544:0
   #24 [ffffb80edbf37ee8] SYSC_write at ffffffff9b2946ec fs/read_write.c:590:0
   #25 [ffffb80edbf37ee8] SyS_write at ffffffff9b2946ec fs/read_write.c:582:0
   #26 [ffffb80edbf37f30] do_syscall_64 at ffffffff9b003ca9 arch/x86/entry/common.c:298:0
   #27 [ffffb80edbf37f58] entry_SYSCALL_64 at ffffffff9ba001b1 arch/x86/entry/entry_64.S:238:0

  PID: 17355    TASK: ffff95c1090c3d80  CPU: 29  COMMAND: "mrdiagd"
  !# 0 [ffffb80f2d3c7d30] __read_once_size at ffffffff9b0f2ab0 include/linux/compiler.h:185:0
  !# 1 [ffffb80f2d3c7d30] native_queued_spin_lock_slowpath at ffffffff9b0f2ab0 kernel/locking/qspinlock.c:368:0
   # 2 [ffffb80f2d3c7d58] pv_queued_spin_lock_slowpath at ffffffff9b0f244b arch/x86/include/asm/paravirt.h:674:0
   # 3 [ffffb80f2d3c7d58] queued_spin_lock_slowpath at ffffffff9b0f244b arch/x86/include/asm/qspinlock.h:53:0
   # 4 [ffffb80f2d3c7d68] queued_spin_lock at ffffffff9b8961a6 include/asm-generic/qspinlock.h:90:0
   # 5 [ffffb80f2d3c7d68] do_raw_spin_lock_flags at ffffffff9b8961a6 include/linux/spinlock.h:173:0
   # 6 [ffffb80f2d3c7d68] __raw_spin_lock_irqsave at ffffffff9b8961a6 include/linux/spinlock_api_smp.h:122:0
   # 7 [ffffb80f2d3c7d68] _raw_spin_lock_irqsave at ffffffff9b8961a6 kernel/locking/spinlock.c:160:0
   # 8 [ffffb80f2d3c7d88] fw_crash_buffer_store [megaraid_sas] at ffffffffc01f8129 drivers/scsi/megaraid/megaraid_sas_base.c:3205:0
   # 9 [ffffb80f2d3c7dc0] dev_attr_store at ffffffff9b56dd7b drivers/base/core.c:758:0
   #10 [ffffb80f2d3c7dd0] sysfs_kf_write at ffffffff9b326acf fs/sysfs/file.c:144:0
   #11 [ffffb80f2d3c7de0] kernfs_fop_write at ffffffff9b325fd4 fs/kernfs/file.c:316:0
   #12 [ffffb80f2d3c7e20] __vfs_write at ffffffff9b29418a fs/read_write.c:480:0
   #13 [ffffb80f2d3c7ea8] vfs_write at ffffffff9b294462 fs/read_write.c:544:0
   #14 [ffffb80f2d3c7ee8] SYSC_write at ffffffff9b2946ec fs/read_write.c:590:0
   #15 [ffffb80f2d3c7ee8] SyS_write at ffffffff9b2946ec fs/read_write.c:582:0
   #16 [ffffb80f2d3c7f30] do_syscall_64 at ffffffff9b003ca9 arch/x86/entry/common.c:298:0
   #17 [ffffb80f2d3c7f58] entry_SYSCALL_64 at ffffffff9ba001b1 arch/x86/entry/entry_64.S:238:0

The lock is used to synchronize different sysfs operations, it doesn't
protect any resource that will be touched by an interrupt. Consequently
it's not required to disable IRQs. Replace the spinlock with a mutex to fix
the deadlock.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Link: https://lore.kernel.org/r/20230828221018.19471-1-junxiao.bi@oracle.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas.h      |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |   21 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2330,7 +2330,7 @@ struct megasas_instance {
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
 	bool smp_affinity_enable;
-	spinlock_t crashdump_lock;
+	struct mutex crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
 	u32 __iomem *reply_post_host_index_addr[MR_MAX_MSIX_REG_ARRAY];
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3275,14 +3275,13 @@ fw_crash_buffer_store(struct device *cde
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	instance->fw_crash_buffer_offset = val;
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 	return strlen(buf);
 }
 
@@ -3297,24 +3296,23 @@ fw_crash_buffer_show(struct device *cdev
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
 	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
-	unsigned long flags;
 	u32 buff_offset;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	buff_offset = instance->fw_crash_buffer_offset;
 	if (!instance->crash_dump_buf ||
 		!((instance->fw_crash_state == AVAILABLE) ||
 		(instance->fw_crash_state == COPYING))) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump is not available\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return -EINVAL;
 	}
 
 	if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump offset is out of range\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return 0;
 	}
 
@@ -3326,7 +3324,7 @@ fw_crash_buffer_show(struct device *cdev
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
 		(buff_offset % dmachunk);
 	memcpy(buf, (void *)src_addr, size);
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 
 	return size;
 }
@@ -3351,7 +3349,6 @@ fw_crash_state_store(struct device *cdev
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
@@ -3365,9 +3362,9 @@ fw_crash_state_store(struct device *cdev
 	instance->fw_crash_state = val;
 
 	if ((val == COPIED) || (val == COPY_ERROR)) {
-		spin_lock_irqsave(&instance->crashdump_lock, flags);
+		mutex_lock(&instance->crashdump_lock);
 		megasas_free_host_crash_buffer(instance);
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		if (val == COPY_ERROR)
 			dev_info(&instance->pdev->dev, "application failed to "
 				"copy Firmware crash dump\n");
@@ -7432,7 +7429,7 @@ static inline void megasas_init_ctrl_par
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
-	spin_lock_init(&instance->crashdump_lock);
+	mutex_init(&instance->crashdump_lock);
 	spin_lock_init(&instance->mfi_pool_lock);
 	spin_lock_init(&instance->hba_lock);
 	spin_lock_init(&instance->stream_lock);


