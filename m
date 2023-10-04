Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE827B8851
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjJDSO4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbjJDSOy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208FC4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066B1C433C8;
        Wed,  4 Oct 2023 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443289;
        bh=O8khzd7cs4pMHx4FS1IKNIv2Mu1Av50td72D3qY2yCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3y1mmpVpsKB4Wr9A/cJk3jAaf8cfSyZy8Z11oAszAwK1dJVuVpVEdD0ToDSf5YPS
         0D0rQsp+VahnERSphOk/pQtzYN2ZFHvja/Hl0wMT6NHVKR6nlxqaatIDbM2iACZ73W
         i02ogHAUMosx4pWvzwQ64VoEAkd7yV6QjhpoH2u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Garry <john.g.garry@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/259] scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id()
Date:   Wed,  4 Oct 2023 19:54:37 +0200
Message-ID: <20231004175222.117086006@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 59f10a05b5c7b675256a66e3161741239889ff80 ]

The following call trace was observed:

localhost kernel: nvme nvme0: NVME-FC{0}: controller connect complete
localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u129:4/75092
localhost kernel: nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.1992-08.com.netapp:sn.b42d198afb4d11ecad6d00a098d6abfa:subsystem.PR_Channel2022_RH84_subsystem_291"
localhost kernel: caller is qla_nvme_post_cmd+0x216/0x1380 [qla2xxx]
localhost kernel: CPU: 6 PID: 75092 Comm: kworker/u129:4 Kdump: loaded Tainted: G    B   W  OE    --------- ---  5.14.0-70.22.1.el9_0.x86_64+debug #1
localhost kernel: Hardware name: HPE ProLiant XL420 Gen10/ProLiant XL420 Gen10, BIOS U39 01/13/2022
localhost kernel: Workqueue: nvme-wq nvme_async_event_work [nvme_core]
localhost kernel: Call Trace:
localhost kernel: dump_stack_lvl+0x57/0x7d
localhost kernel: check_preemption_disabled+0xc8/0xd0
localhost kernel: qla_nvme_post_cmd+0x216/0x1380 [qla2xxx]

Use raw_smp_processor_id() instead of smp_processor_id().

Also use queue_work() across the driver instead of queue_work_on() thus
avoiding usage of smp_processor_id() when CONFIG_DEBUG_PREEMPT is enabled.

Cc: stable@vger.kernel.org
Suggested-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230831112146.32595-2-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_inline.h  | 2 +-
 drivers/scsi/qla2xxx/qla_isr.c     | 6 +++---
 drivers/scsi/qla2xxx/qla_target.c  | 3 +--
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index d5cf9db2a8ea3..e66441355f7ae 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -577,7 +577,7 @@ fcport_is_bigger(fc_port_t *fcport)
 static inline struct qla_qpair *
 qla_mapq_nvme_select_qpair(struct qla_hw_data *ha, struct qla_qpair *qpair)
 {
-	int cpuid = smp_processor_id();
+	int cpuid = raw_smp_processor_id();
 
 	if (qpair->cpuid != cpuid &&
 	    ha->qp_cpu_map[cpuid]) {
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a5e6246127ed3..cf1025c917267 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3817,7 +3817,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 	if (!ha->flags.fw_started)
 		return;
 
-	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
+	if (rsp->qpair->cpuid != raw_smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
 	}
 
@@ -4305,7 +4305,7 @@ qla2xxx_msix_rsp_q(int irq, void *dev_id)
 	}
 	ha = qpair->hw;
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
@@ -4331,7 +4331,7 @@ qla2xxx_msix_rsp_q_hs(int irq, void *dev_id)
 	wrt_reg_dword(&reg->hccr, HCCRX_CLR_RISC_INT);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 545473a0ffc84..5a5beb41786ed 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4442,8 +4442,7 @@ static int qlt_handle_cmd_for_atio(struct scsi_qla_host *vha,
 		queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq, &cmd->work);
 	} else if (ha->msix_count) {
 		if (cmd->atio.u.isp24.fcp_cmnd.rddata)
-			queue_work_on(smp_processor_id(), qla_tgt_wq,
-			    &cmd->work);
+			queue_work(qla_tgt_wq, &cmd->work);
 		else
 			queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq,
 			    &cmd->work);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 8fa0056b56ddb..e54ee6770e79f 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -310,7 +310,7 @@ static void tcm_qla2xxx_free_cmd(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_CMD_DONE;
 
 	INIT_WORK(&cmd->work, tcm_qla2xxx_complete_free);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 /*
@@ -557,7 +557,7 @@ static void tcm_qla2xxx_handle_data(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_DATA_IN;
 	cmd->cmd_in_wq = 1;
 	INIT_WORK(&cmd->work, tcm_qla2xxx_handle_data_work);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 static int tcm_qla2xxx_chk_dif_tags(uint32_t tag)
-- 
2.40.1



