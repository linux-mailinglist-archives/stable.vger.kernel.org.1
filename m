Return-Path: <stable+bounces-173345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D78B35D51
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77184363C42
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C729D292;
	Tue, 26 Aug 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPKGzoAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29633EB19;
	Tue, 26 Aug 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208005; cv=none; b=tqnko+AgkAzeALEOz/53Q+3URNMVd/Zx1SaSE09YihdkOhF1YfYVS60uZxhY+DOMJ8MUrpdmVzy0ZZkONRAfqXOXIjMXNMoimegj595eS3IHpsam9Yj8PD3Z6cHpnlY85/pXSEptOUy98KCsfPsHjbDJROJMyMf6ZhMhPCJTbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208005; c=relaxed/simple;
	bh=MmG36sSpSs0f6IfpGh9SLU4MUDDhMDOZZHYtuSMO1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJljSkCxKTTZSj5tS58O2QTEEbO12KJsfJaxmnRTsHg8g1W2zxoEgFO7gn/HUEp09zgZV0qGPc+MFGrFHsgp7LNOYVEtH8u/NJvejklyijAGgIypW0kwjPtARw4p4s2BqeFhRd11UQOba9xKNnsojRiKbp+woG3Qh5hiAYR6tX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPKGzoAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F42C4CEF4;
	Tue, 26 Aug 2025 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208005;
	bh=MmG36sSpSs0f6IfpGh9SLU4MUDDhMDOZZHYtuSMO1o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPKGzoACoh59iBs/hRd4jK2G6lnsF4v0KgAv3Fn3L8Z7TrtJDTieAh1JYJXtTSVHx
	 N0Ecjm1KMPK0F8psK2ImEFs/HEURCy1QKtOjnVnAkKY82tdg64a3U7QCJenjGILokz
	 DvviU4Xk08D6pjW9+pMX7DG4lPdB2MciH8BSRsOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 401/457] scsi: ufs: core: Fix IRQ lock inversion for the SCSI host lock
Date: Tue, 26 Aug 2025 13:11:25 +0200
Message-ID: <20250826110947.203923774@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit eabcac808ca3ee9878223d4b49b750979029016b ]

Commit 3c7ac40d7322 ("scsi: ufs: core: Delegate the interrupt service
routine to a threaded IRQ handler") introduced an IRQ lock inversion
issue. Fix this lock inversion by changing the spin_lock_irq() calls into
spin_lock_irqsave() calls in code that can be called either from
interrupt context or from thread context. This patch fixes the following
lockdep complaint:

WARNING: possible irq lock inversion dependency detected
6.12.30-android16-5-maybe-dirty-4k #1 Tainted: G        W  OE
--------------------------------------------------------
kworker/u28:0/12 just changed the state of lock:
ffffff881e29dd60 (&hba->clk_gating.lock){-...}-{2:2}, at: ufshcd_release_scsi_cmd+0x60/0x110
but this lock took another, HARDIRQ-unsafe lock in the past:
 (shost->host_lock){+.+.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(shost->host_lock);
                               local_irq_disable();
                               lock(&hba->clk_gating.lock);
                               lock(shost->host_lock);
  <Interrupt>
    lock(&hba->clk_gating.lock);

 *** DEADLOCK ***

4 locks held by kworker/u28:0/12:
 #0: ffffff8800ac6158 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x1bc/0x65c
 #1: ffffffc085c93d70 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1e4/0x65c
 #2: ffffff881e29c0e0 (&shost->scan_mutex){+.+.}-{3:3}, at: __scsi_add_device+0x74/0x120
 #3: ffffff881960ea00 (&hwq->cq_lock){-...}-{2:2}, at: ufshcd_mcq_poll_cqe_lock+0x28/0x104

the shortest dependencies between 2nd lock and 1st lock:
 -> (shost->host_lock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x134/0x2b4
                      _raw_spin_lock+0x48/0x64
                      ufshcd_sl_intr+0x4c/0xa08
                      ufshcd_threaded_intr+0x70/0x12c
                      irq_thread_fn+0x48/0xa8
                      irq_thread+0x130/0x1ec
                      kthread+0x110/0x134
                      ret_from_fork+0x10/0x20
    SOFTIRQ-ON-W at:
                      lock_acquire+0x134/0x2b4
                      _raw_spin_lock+0x48/0x64
                      ufshcd_sl_intr+0x4c/0xa08
                      ufshcd_threaded_intr+0x70/0x12c
                      irq_thread_fn+0x48/0xa8
                      irq_thread+0x130/0x1ec
                      kthread+0x110/0x134
                      ret_from_fork+0x10/0x20
    INITIAL USE at:
                     lock_acquire+0x134/0x2b4
                     _raw_spin_lock+0x48/0x64
                     ufshcd_sl_intr+0x4c/0xa08
                     ufshcd_threaded_intr+0x70/0x12c
                     irq_thread_fn+0x48/0xa8
                     irq_thread+0x130/0x1ec
                     kthread+0x110/0x134
                     ret_from_fork+0x10/0x20
  }
  ... key      at: [<ffffffc085ba1a98>] scsi_host_alloc.__key+0x0/0x10
  ... acquired at:
   _raw_spin_lock_irqsave+0x5c/0x80
   __ufshcd_release+0x78/0x118
   ufshcd_send_uic_cmd+0xe4/0x118
   ufshcd_dme_set_attr+0x88/0x1c8
   ufs_google_phy_initialization+0x68/0x418 [ufs]
   ufs_google_link_startup_notify+0x78/0x27c [ufs]
   ufshcd_link_startup+0x84/0x720
   ufshcd_init+0xf3c/0x1330
   ufshcd_pltfrm_init+0x728/0x7d8
   ufs_google_probe+0x30/0x84 [ufs]
   platform_probe+0xa0/0xe0
   really_probe+0x114/0x454
   __driver_probe_device+0xa4/0x160
   driver_probe_device+0x44/0x23c
   __driver_attach_async_helper+0x60/0xd4
   async_run_entry_fn+0x4c/0x17c
   process_one_work+0x26c/0x65c
   worker_thread+0x33c/0x498
   kthread+0x110/0x134
   ret_from_fork+0x10/0x20

-> (&hba->clk_gating.lock){-...}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x134/0x2b4
                    _raw_spin_lock_irqsave+0x5c/0x80
                    ufshcd_release_scsi_cmd+0x60/0x110
                    ufshcd_compl_one_cqe+0x2c0/0x3f4
                    ufshcd_mcq_poll_cqe_lock+0xb0/0x104
                    ufs_google_mcq_intr+0x80/0xa0 [ufs]
                    __handle_irq_event_percpu+0x104/0x32c
                    handle_irq_event+0x40/0x9c
                    handle_fasteoi_irq+0x170/0x2e8
                    generic_handle_domain_irq+0x58/0x80
                    gic_handle_irq+0x48/0x104
                    call_on_irq_stack+0x3c/0x50
                    do_interrupt_handler+0x7c/0xd8
                    el1_interrupt+0x34/0x58
                    el1h_64_irq_handler+0x18/0x24
                    el1h_64_irq+0x68/0x6c
                    _raw_spin_unlock_irqrestore+0x3c/0x6c
                    debug_object_assert_init+0x16c/0x21c
                    __mod_timer+0x4c/0x48c
                    schedule_timeout+0xd4/0x16c
                    io_schedule_timeout+0x48/0x70
                    do_wait_for_common+0x100/0x194
                    wait_for_completion_io_timeout+0x48/0x6c
                    blk_execute_rq+0x124/0x17c
                    scsi_execute_cmd+0x18c/0x3f8
                    scsi_probe_and_add_lun+0x204/0xd74
                    __scsi_add_device+0xbc/0x120
                    ufshcd_async_scan+0x80/0x3c0
                    async_run_entry_fn+0x4c/0x17c
                    process_one_work+0x26c/0x65c
                    worker_thread+0x33c/0x498
                    kthread+0x110/0x134
                    ret_from_fork+0x10/0x20
   INITIAL USE at:
                   lock_acquire+0x134/0x2b4
                   _raw_spin_lock_irqsave+0x5c/0x80
                   ufshcd_hold+0x34/0x14c
                   ufshcd_send_uic_cmd+0x28/0x118
                   ufshcd_dme_set_attr+0x88/0x1c8
                   ufs_google_phy_initialization+0x68/0x418 [ufs]
                   ufs_google_link_startup_notify+0x78/0x27c [ufs]
                   ufshcd_link_startup+0x84/0x720
                   ufshcd_init+0xf3c/0x1330
                   ufshcd_pltfrm_init+0x728/0x7d8
                   ufs_google_probe+0x30/0x84 [ufs]
                   platform_probe+0xa0/0xe0
                   really_probe+0x114/0x454
                   __driver_probe_device+0xa4/0x160
                   driver_probe_device+0x44/0x23c
                   __driver_attach_async_helper+0x60/0xd4
                   async_run_entry_fn+0x4c/0x17c
                   process_one_work+0x26c/0x65c
                   worker_thread+0x33c/0x498
                   kthread+0x110/0x134
                   ret_from_fork+0x10/0x20
 }
 ... key      at: [<ffffffc085ba6fe8>] ufshcd_init.__key+0x0/0x10
 ... acquired at:
   mark_lock+0x1c4/0x224
   __lock_acquire+0x438/0x2e1c
   lock_acquire+0x134/0x2b4
   _raw_spin_lock_irqsave+0x5c/0x80
   ufshcd_release_scsi_cmd+0x60/0x110
   ufshcd_compl_one_cqe+0x2c0/0x3f4
   ufshcd_mcq_poll_cqe_lock+0xb0/0x104
   ufs_google_mcq_intr+0x80/0xa0 [ufs]
   __handle_irq_event_percpu+0x104/0x32c
   handle_irq_event+0x40/0x9c
   handle_fasteoi_irq+0x170/0x2e8
   generic_handle_domain_irq+0x58/0x80
   gic_handle_irq+0x48/0x104
   call_on_irq_stack+0x3c/0x50
   do_interrupt_handler+0x7c/0xd8
   el1_interrupt+0x34/0x58
   el1h_64_irq_handler+0x18/0x24
   el1h_64_irq+0x68/0x6c
   _raw_spin_unlock_irqrestore+0x3c/0x6c
   debug_object_assert_init+0x16c/0x21c
   __mod_timer+0x4c/0x48c
   schedule_timeout+0xd4/0x16c
   io_schedule_timeout+0x48/0x70
   do_wait_for_common+0x100/0x194
   wait_for_completion_io_timeout+0x48/0x6c
   blk_execute_rq+0x124/0x17c
   scsi_execute_cmd+0x18c/0x3f8
   scsi_probe_and_add_lun+0x204/0xd74
   __scsi_add_device+0xbc/0x120
   ufshcd_async_scan+0x80/0x3c0
   async_run_entry_fn+0x4c/0x17c
   process_one_work+0x26c/0x65c
   worker_thread+0x33c/0x498
   kthread+0x110/0x134
   ret_from_fork+0x10/0x20

stack backtrace:
CPU: 6 UID: 0 PID: 12 Comm: kworker/u28:0 Tainted: G        W  OE      6.12.30-android16-5-maybe-dirty-4k #1 ccd4020fe444bdf629efc3b86df6be920b8df7d0
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Spacecraft board based on MALIBU (DT)
Workqueue: async async_run_entry_fn
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xa0
 dump_stack+0x18/0x24
 print_irq_inversion_bug+0x2fc/0x304
 mark_lock_irq+0x388/0x4fc
 mark_lock+0x1c4/0x224
 __lock_acquire+0x438/0x2e1c
 lock_acquire+0x134/0x2b4
 _raw_spin_lock_irqsave+0x5c/0x80
 ufshcd_release_scsi_cmd+0x60/0x110
 ufshcd_compl_one_cqe+0x2c0/0x3f4
 ufshcd_mcq_poll_cqe_lock+0xb0/0x104
 ufs_google_mcq_intr+0x80/0xa0 [ufs dd6f385554e109da094ab91d5f7be18625a2222a]
 __handle_irq_event_percpu+0x104/0x32c
 handle_irq_event+0x40/0x9c
 handle_fasteoi_irq+0x170/0x2e8
 generic_handle_domain_irq+0x58/0x80
 gic_handle_irq+0x48/0x104
 call_on_irq_stack+0x3c/0x50
 do_interrupt_handler+0x7c/0xd8
 el1_interrupt+0x34/0x58
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x68/0x6c
 _raw_spin_unlock_irqrestore+0x3c/0x6c
 debug_object_assert_init+0x16c/0x21c
 __mod_timer+0x4c/0x48c
 schedule_timeout+0xd4/0x16c
 io_schedule_timeout+0x48/0x70
 do_wait_for_common+0x100/0x194
 wait_for_completion_io_timeout+0x48/0x6c
 blk_execute_rq+0x124/0x17c
 scsi_execute_cmd+0x18c/0x3f8
 scsi_probe_and_add_lun+0x204/0xd74
 __scsi_add_device+0xbc/0x120
 ufshcd_async_scan+0x80/0x3c0
 async_run_entry_fn+0x4c/0x17c
 process_one_work+0x26c/0x65c
 worker_thread+0x33c/0x498
 kthread+0x110/0x134
 ret_from_fork+0x10/0x20

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Fixes: 3c7ac40d7322 ("scsi: ufs: core: Delegate the interrupt service routine to a threaded IRQ handler")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20250815155842.472867-2-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3cc566e8bd1d..f2eeb82ffa9b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5531,7 +5531,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 	irqreturn_t retval = IRQ_NONE;
 	struct uic_command *cmd;
 
-	spin_lock(hba->host->host_lock);
+	guard(spinlock_irqsave)(hba->host->host_lock);
 	cmd = hba->active_uic_cmd;
 	if (WARN_ON_ONCE(!cmd))
 		goto unlock;
@@ -5558,8 +5558,6 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 		ufshcd_add_uic_command_trace(hba, cmd, UFS_CMD_COMP);
 
 unlock:
-	spin_unlock(hba->host->host_lock);
-
 	return retval;
 }
 
@@ -6892,7 +6890,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 	bool queue_eh_work = false;
 	irqreturn_t retval = IRQ_NONE;
 
-	spin_lock(hba->host->host_lock);
+	guard(spinlock_irqsave)(hba->host->host_lock);
 	hba->errors |= UFSHCD_ERROR_MASK & intr_status;
 
 	if (hba->errors & INT_FATAL_ERRORS) {
@@ -6951,7 +6949,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 	 */
 	hba->errors = 0;
 	hba->uic_error = 0;
-	spin_unlock(hba->host->host_lock);
+
 	return retval;
 }
 
-- 
2.50.1




