Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9070397C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbjEORnB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbjEORmp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046041BBA2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C0762E2F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388DC4339B;
        Mon, 15 May 2023 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172417;
        bh=zBx2anFjfuaiovUssj2Nv9O03SampItMCGmi8SyYcZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHFTFwx8THlv90CJRS0pYsVzo0RSL7vcYtjZDJM0kblLPfnFdwidY5JfYDwvT1T88
         1j2IxZd6dOeM5wW61wjZu+33a1v2BPrnrl9ucsZZUpSSq1o8N0BOMs+V/LSQlpCvhx
         AxHv8z1JP/fTNDjXnhBwgYcZaoMUIKPs7E1x9sYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 147/381] scsi: target: Make state_list per CPU
Date:   Mon, 15 May 2023 18:26:38 +0200
Message-Id: <20230515161743.495424600@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 1526d9f10c6184031e42afad0adbdde1213e8ad1 ]

Do a state_list/execute_task_lock per CPU, so we can do submissions from
different CPUs without contention with each other.

Note: tcm_fc was passing TARGET_SCF_USE_CPUID, but never set cpuid.  The
assumption is that it wanted to set the cpuid to the CPU it was submitting
from so it will get this behavior with this patch.

[mkp: s/printk/pr_err/ + resolve COMPARE AND WRITE patch conflict]

Link: https://lore.kernel.org/r/1604257174-4524-8-git-send-email-michael.christie@oracle.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 673db054d7a2 ("scsi: target: Fix multiple LUN_RESET handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c    |  16 ++-
 drivers/target/target_core_tmr.c       | 166 +++++++++++++------------
 drivers/target/target_core_transport.c |  27 ++--
 drivers/target/tcm_fc/tfc_cmd.c        |   2 +-
 include/target/target_core_base.h      |  13 +-
 5 files changed, 126 insertions(+), 98 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 1eded5c4ebda6..bd3f1192c75a1 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -724,11 +724,24 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 {
 	struct se_device *dev;
 	struct se_lun *xcopy_lun;
+	int i;
 
 	dev = hba->backend->ops->alloc_device(hba, name);
 	if (!dev)
 		return NULL;
 
+	dev->queues = kcalloc(nr_cpu_ids, sizeof(*dev->queues), GFP_KERNEL);
+	if (!dev->queues) {
+		dev->transport->free_device(dev);
+		return NULL;
+	}
+
+	dev->queue_cnt = nr_cpu_ids;
+	for (i = 0; i < dev->queue_cnt; i++) {
+		INIT_LIST_HEAD(&dev->queues[i].state_list);
+		spin_lock_init(&dev->queues[i].lock);
+	}
+
 	dev->se_hba = hba;
 	dev->transport = hba->backend->ops;
 	dev->transport_flags = dev->transport->transport_flags_default;
@@ -738,9 +751,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	INIT_LIST_HEAD(&dev->dev_sep_list);
 	INIT_LIST_HEAD(&dev->dev_tmr_list);
 	INIT_LIST_HEAD(&dev->delayed_cmd_list);
-	INIT_LIST_HEAD(&dev->state_list);
 	INIT_LIST_HEAD(&dev->qf_cmd_list);
-	spin_lock_init(&dev->execute_task_lock);
 	spin_lock_init(&dev->delayed_cmd_lock);
 	spin_lock_init(&dev->dev_reservation_lock);
 	spin_lock_init(&dev->se_port_lock);
@@ -1014,6 +1025,7 @@ void target_free_device(struct se_device *dev)
 	if (dev->transport->free_prot)
 		dev->transport->free_prot(dev);
 
+	kfree(dev->queues);
 	dev->transport->free_device(dev);
 }
 
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 3efd5a3bd69d1..5da384bb88c82 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -121,57 +121,61 @@ void core_tmr_abort_task(
 	unsigned long flags;
 	bool rc;
 	u64 ref_tag;
-
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
-	list_for_each_entry_safe(se_cmd, next, &dev->state_list, state_list) {
-
-		if (se_sess != se_cmd->se_sess)
-			continue;
-
-		/* skip task management functions, including tmr->task_cmd */
-		if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
-			continue;
-
-		ref_tag = se_cmd->tag;
-		if (tmr->ref_task_tag != ref_tag)
-			continue;
-
-		printk("ABORT_TASK: Found referenced %s task_tag: %llu\n",
-			se_cmd->se_tfo->fabric_name, ref_tag);
-
-		spin_lock(&se_sess->sess_cmd_lock);
-		rc = __target_check_io_state(se_cmd, se_sess, 0);
-		spin_unlock(&se_sess->sess_cmd_lock);
-		if (!rc)
-			continue;
-
-		list_move_tail(&se_cmd->state_list, &aborted_list);
-		se_cmd->state_active = false;
-
-		spin_unlock_irqrestore(&dev->execute_task_lock, flags);
-
-		/*
-		 * Ensure that this ABORT request is visible to the LU RESET
-		 * code.
-		 */
-		if (!tmr->tmr_dev)
-			WARN_ON_ONCE(transport_lookup_tmr_lun(tmr->task_cmd) <
-					0);
-
-		if (dev->transport->tmr_notify)
-			dev->transport->tmr_notify(dev, TMR_ABORT_TASK,
-						   &aborted_list);
-
-		list_del_init(&se_cmd->state_list);
-		target_put_cmd_and_wait(se_cmd);
-
-		printk("ABORT_TASK: Sending TMR_FUNCTION_COMPLETE for"
-				" ref_tag: %llu\n", ref_tag);
-		tmr->response = TMR_FUNCTION_COMPLETE;
-		atomic_long_inc(&dev->aborts_complete);
-		return;
+	int i;
+
+	for (i = 0; i < dev->queue_cnt; i++) {
+		spin_lock_irqsave(&dev->queues[i].lock, flags);
+		list_for_each_entry_safe(se_cmd, next, &dev->queues[i].state_list,
+					 state_list) {
+			if (se_sess != se_cmd->se_sess)
+				continue;
+
+			/*
+			 * skip task management functions, including
+			 * tmr->task_cmd
+			 */
+			if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
+				continue;
+
+			ref_tag = se_cmd->tag;
+			if (tmr->ref_task_tag != ref_tag)
+				continue;
+
+			pr_err("ABORT_TASK: Found referenced %s task_tag: %llu\n",
+			       se_cmd->se_tfo->fabric_name, ref_tag);
+
+			spin_lock(&se_sess->sess_cmd_lock);
+			rc = __target_check_io_state(se_cmd, se_sess, 0);
+			spin_unlock(&se_sess->sess_cmd_lock);
+			if (!rc)
+				continue;
+
+			list_move_tail(&se_cmd->state_list, &aborted_list);
+			se_cmd->state_active = false;
+			spin_unlock_irqrestore(&dev->queues[i].lock, flags);
+
+			/*
+			 * Ensure that this ABORT request is visible to the LU
+			 * RESET code.
+			 */
+			if (!tmr->tmr_dev)
+				WARN_ON_ONCE(transport_lookup_tmr_lun(tmr->task_cmd) < 0);
+
+			if (dev->transport->tmr_notify)
+				dev->transport->tmr_notify(dev, TMR_ABORT_TASK,
+							   &aborted_list);
+
+			list_del_init(&se_cmd->state_list);
+			target_put_cmd_and_wait(se_cmd);
+
+			pr_err("ABORT_TASK: Sending TMR_FUNCTION_COMPLETE for ref_tag: %llu\n",
+			       ref_tag);
+			tmr->response = TMR_FUNCTION_COMPLETE;
+			atomic_long_inc(&dev->aborts_complete);
+			return;
+		}
+		spin_unlock_irqrestore(&dev->queues[i].lock, flags);
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
 
 	if (dev->transport->tmr_notify)
 		dev->transport->tmr_notify(dev, TMR_ABORT_TASK, &aborted_list);
@@ -273,7 +277,7 @@ static void core_tmr_drain_state_list(
 	struct se_session *sess;
 	struct se_cmd *cmd, *next;
 	unsigned long flags;
-	int rc;
+	int rc, i;
 
 	/*
 	 * Complete outstanding commands with TASK_ABORTED SAM status.
@@ -297,35 +301,39 @@ static void core_tmr_drain_state_list(
 	 * Note that this seems to be independent of TAS (Task Aborted Status)
 	 * in the Control Mode Page.
 	 */
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
-	list_for_each_entry_safe(cmd, next, &dev->state_list, state_list) {
-		/*
-		 * For PREEMPT_AND_ABORT usage, only process commands
-		 * with a matching reservation key.
-		 */
-		if (target_check_cdb_and_preempt(preempt_and_abort_list, cmd))
-			continue;
-
-		/*
-		 * Not aborting PROUT PREEMPT_AND_ABORT CDB..
-		 */
-		if (prout_cmd == cmd)
-			continue;
-
-		sess = cmd->se_sess;
-		if (WARN_ON_ONCE(!sess))
-			continue;
-
-		spin_lock(&sess->sess_cmd_lock);
-		rc = __target_check_io_state(cmd, tmr_sess, tas);
-		spin_unlock(&sess->sess_cmd_lock);
-		if (!rc)
-			continue;
-
-		list_move_tail(&cmd->state_list, &drain_task_list);
-		cmd->state_active = false;
+	for (i = 0; i < dev->queue_cnt; i++) {
+		spin_lock_irqsave(&dev->queues[i].lock, flags);
+		list_for_each_entry_safe(cmd, next, &dev->queues[i].state_list,
+					 state_list) {
+			/*
+			 * For PREEMPT_AND_ABORT usage, only process commands
+			 * with a matching reservation key.
+			 */
+			if (target_check_cdb_and_preempt(preempt_and_abort_list,
+							 cmd))
+				continue;
+
+			/*
+			 * Not aborting PROUT PREEMPT_AND_ABORT CDB..
+			 */
+			if (prout_cmd == cmd)
+				continue;
+
+			sess = cmd->se_sess;
+			if (WARN_ON_ONCE(!sess))
+				continue;
+
+			spin_lock(&sess->sess_cmd_lock);
+			rc = __target_check_io_state(cmd, tmr_sess, tas);
+			spin_unlock(&sess->sess_cmd_lock);
+			if (!rc)
+				continue;
+
+			list_move_tail(&cmd->state_list, &drain_task_list);
+			cmd->state_active = false;
+		}
+		spin_unlock_irqrestore(&dev->queues[i].lock, flags);
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
 
 	if (dev->transport->tmr_notify)
 		dev->transport->tmr_notify(dev, preempt_and_abort_list ?
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 84d654c14917c..230fffa993c00 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -650,12 +650,12 @@ static void target_remove_from_state_list(struct se_cmd *cmd)
 	if (!dev)
 		return;
 
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
+	spin_lock_irqsave(&dev->queues[cmd->cpuid].lock, flags);
 	if (cmd->state_active) {
 		list_del(&cmd->state_list);
 		cmd->state_active = false;
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
+	spin_unlock_irqrestore(&dev->queues[cmd->cpuid].lock, flags);
 }
 
 /*
@@ -866,10 +866,7 @@ void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status)
 
 	INIT_WORK(&cmd->work, success ? target_complete_ok_work :
 		  target_complete_failure_work);
-	if (cmd->se_cmd_flags & SCF_USE_CPUID)
-		queue_work_on(cmd->cpuid, target_completion_wq, &cmd->work);
-	else
-		queue_work(target_completion_wq, &cmd->work);
+	queue_work_on(cmd->cpuid, target_completion_wq, &cmd->work);
 }
 EXPORT_SYMBOL(target_complete_cmd);
 
@@ -904,12 +901,13 @@ static void target_add_to_state_list(struct se_cmd *cmd)
 	struct se_device *dev = cmd->se_dev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
+	spin_lock_irqsave(&dev->queues[cmd->cpuid].lock, flags);
 	if (!cmd->state_active) {
-		list_add_tail(&cmd->state_list, &dev->state_list);
+		list_add_tail(&cmd->state_list,
+			      &dev->queues[cmd->cpuid].state_list);
 		cmd->state_active = true;
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
+	spin_unlock_irqrestore(&dev->queues[cmd->cpuid].lock, flags);
 }
 
 /*
@@ -1397,6 +1395,9 @@ void transport_init_se_cmd(
 	cmd->sense_buffer = sense_buffer;
 	cmd->orig_fe_lun = unpacked_lun;
 
+	if (!(cmd->se_cmd_flags & SCF_USE_CPUID))
+		cmd->cpuid = smp_processor_id();
+
 	cmd->state_active = false;
 }
 EXPORT_SYMBOL(transport_init_se_cmd);
@@ -1614,6 +1615,9 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 	BUG_ON(!se_tpg);
 	BUG_ON(se_cmd->se_tfo || se_cmd->se_sess);
 	BUG_ON(in_interrupt());
+
+	if (flags & TARGET_SCF_USE_CPUID)
+		se_cmd->se_cmd_flags |= SCF_USE_CPUID;
 	/*
 	 * Initialize se_cmd for target operation.  From this point
 	 * exceptions are handled by sending exception status via
@@ -1623,11 +1627,6 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 				data_length, data_dir, task_attr, sense,
 				unpacked_lun);
 
-	if (flags & TARGET_SCF_USE_CPUID)
-		se_cmd->se_cmd_flags |= SCF_USE_CPUID;
-	else
-		se_cmd->cpuid = WORK_CPU_UNBOUND;
-
 	if (flags & TARGET_SCF_UNKNOWN_SIZE)
 		se_cmd->unknown_data_length = 1;
 	/*
diff --git a/drivers/target/tcm_fc/tfc_cmd.c b/drivers/target/tcm_fc/tfc_cmd.c
index a7ed56602c6cd..8936a094f8461 100644
--- a/drivers/target/tcm_fc/tfc_cmd.c
+++ b/drivers/target/tcm_fc/tfc_cmd.c
@@ -551,7 +551,7 @@ static void ft_send_work(struct work_struct *work)
 	if (target_submit_cmd(&cmd->se_cmd, cmd->sess->se_sess, fcp->fc_cdb,
 			      &cmd->ft_sense_buffer[0], scsilun_to_int(&fcp->fc_lun),
 			      ntohl(fcp->fc_dl), task_attr, data_dir,
-			      TARGET_SCF_ACK_KREF | TARGET_SCF_USE_CPUID))
+			      TARGET_SCF_ACK_KREF))
 		goto err;
 
 	pr_debug("r_ctl %x target_submit_cmd %p\n", fh->fh_r_ctl, cmd);
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 16992ba455deb..0109adcdfa0b4 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -541,6 +541,10 @@ struct se_cmd {
 	unsigned int		t_prot_nents;
 	sense_reason_t		pi_err;
 	u64			sense_info;
+	/*
+	 * CPU LIO will execute the cmd on. Defaults to the CPU the cmd is
+	 * initialized on. Drivers can override.
+	 */
 	int			cpuid;
 };
 
@@ -761,6 +765,11 @@ struct se_dev_stat_grps {
 	struct config_group scsi_lu_group;
 };
 
+struct se_device_queue {
+	struct list_head	state_list;
+	spinlock_t		lock;
+};
+
 struct se_device {
 	/* RELATIVE TARGET PORT IDENTIFER Counter */
 	u16			dev_rpti_counter;
@@ -794,7 +803,6 @@ struct se_device {
 	atomic_t		dev_qf_count;
 	u32			export_count;
 	spinlock_t		delayed_cmd_lock;
-	spinlock_t		execute_task_lock;
 	spinlock_t		dev_reservation_lock;
 	unsigned int		dev_reservation_flags;
 #define DRF_SPC2_RESERVATIONS			0x00000001
@@ -814,7 +822,6 @@ struct se_device {
 	struct work_struct	qf_work_queue;
 	struct work_struct	delayed_cmd_work;
 	struct list_head	delayed_cmd_list;
-	struct list_head	state_list;
 	struct list_head	qf_cmd_list;
 	/* Pointer to associated SE HBA */
 	struct se_hba		*se_hba;
@@ -841,6 +848,8 @@ struct se_device {
 	/* For se_lun->lun_se_dev RCU read-side critical access */
 	u32			hba_index;
 	struct rcu_head		rcu_head;
+	int			queue_cnt;
+	struct se_device_queue	*queues;
 };
 
 struct se_hba {
-- 
2.39.2



