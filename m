Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15547B8850
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbjJDSOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbjJDSOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D2A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53371C433C7;
        Wed,  4 Oct 2023 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443286;
        bh=SSbvqeQQFhnIPlG8LJ4xM+JMUPVwjjUFlagABklbanc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iW75QMUeuBodEcaOPWxlWZGWDrHK/VGCGAQLWnDmQ71j045YMPjAype/KN6JTwv2g
         TUKimXbcTDndK0ZxEjT+L8vDp+rYqddUZ0x9ajRsd2KceLkysD1E5JnfbTV17Pg3O/
         ddBD+qReMivhP5MfVWR4eZxaXMU+uhusQYUVLxPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shreyas Deodhar <sdeodhar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/259] scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called
Date:   Wed,  4 Oct 2023 19:54:36 +0200
Message-ID: <20231004175222.076546442@linuxfoundation.org>
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

From: Shreyas Deodhar <sdeodhar@marvell.com>

[ Upstream commit 1d201c81d4cc6840735bbcc99e6031503e5cf3b8 ]

In current I/O path, Tx and Rx may not be processed on same CPU. This may
lead to thrashing and optimum performance may not be achieved.

Pick qpair such that Tx and Rx are processed on same CPU.

Signed-off-by: Shreyas Deodhar <sdeodhar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 59f10a05b5c7 ("scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h    |  2 ++
 drivers/scsi/qla2xxx/qla_init.c   |  2 --
 drivers/scsi/qla2xxx/qla_inline.h | 55 +++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_isr.c    |  3 +-
 drivers/scsi/qla2xxx/qla_nvme.c   |  4 +++
 drivers/scsi/qla2xxx/qla_os.c     |  6 ++++
 6 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 7d282906598f3..817efdd32ad63 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3475,6 +3475,7 @@ struct qla_msix_entry {
 	int have_irq;
 	int in_use;
 	uint32_t vector;
+	uint32_t vector_base0;
 	uint16_t entry;
 	char name[30];
 	void *handle;
@@ -4133,6 +4134,7 @@ struct qla_hw_data {
 	struct req_que **req_q_map;
 	struct rsp_que **rsp_q_map;
 	struct qla_qpair **queue_pair_map;
+	struct qla_qpair **qp_cpu_map;
 	unsigned long req_qid_map[(QLA_MAX_QUEUES / 8) / sizeof(unsigned long)];
 	unsigned long rsp_qid_map[(QLA_MAX_QUEUES / 8) / sizeof(unsigned long)];
 	unsigned long qpair_qid_map[(QLA_MAX_QUEUES / 8)
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 36abdb0de1694..79de31e7e8b2a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9758,8 +9758,6 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 		qpair->req = ha->req_q_map[req_id];
 		qpair->rsp->req = qpair->req;
 		qpair->rsp->qpair = qpair;
-		/* init qpair to this cpu. Will adjust at run time. */
-		qla_cpu_update(qpair, raw_smp_processor_id());
 
 		if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif) {
 			if (ha->fw_attributes & BIT_4)
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index a7b5d11146827..d5cf9db2a8ea3 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -573,3 +573,58 @@ fcport_is_bigger(fc_port_t *fcport)
 {
 	return !fcport_is_smaller(fcport);
 }
+
+static inline struct qla_qpair *
+qla_mapq_nvme_select_qpair(struct qla_hw_data *ha, struct qla_qpair *qpair)
+{
+	int cpuid = smp_processor_id();
+
+	if (qpair->cpuid != cpuid &&
+	    ha->qp_cpu_map[cpuid]) {
+		qpair = ha->qp_cpu_map[cpuid];
+	}
+	return qpair;
+}
+
+static inline void
+qla_mapq_init_qp_cpu_map(struct qla_hw_data *ha,
+			 struct qla_msix_entry *msix,
+			 struct qla_qpair *qpair)
+{
+	const struct cpumask *mask;
+	unsigned int cpu;
+
+	if (!ha->qp_cpu_map)
+		return;
+	mask = pci_irq_get_affinity(ha->pdev, msix->vector_base0);
+	qpair->cpuid = cpumask_first(mask);
+	for_each_cpu(cpu, mask) {
+		ha->qp_cpu_map[cpu] = qpair;
+	}
+	msix->cpuid = qpair->cpuid;
+}
+
+static inline void
+qla_mapq_free_qp_cpu_map(struct qla_hw_data *ha)
+{
+	if (ha->qp_cpu_map) {
+		kfree(ha->qp_cpu_map);
+		ha->qp_cpu_map = NULL;
+	}
+}
+
+static inline int qla_mapq_alloc_qp_cpu_map(struct qla_hw_data *ha)
+{
+	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
+
+	if (!ha->qp_cpu_map) {
+		ha->qp_cpu_map = kcalloc(NR_CPUS, sizeof(struct qla_qpair *),
+					 GFP_KERNEL);
+		if (!ha->qp_cpu_map) {
+			ql_log(ql_log_fatal, vha, 0x0180,
+			       "Unable to allocate memory for qp_cpu_map ptrs.\n");
+			return -1;
+		}
+	}
+	return 0;
+}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 0111249cc8774..a5e6246127ed3 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3819,7 +3819,6 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 
 	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
-		qla_cpu_update(rsp->qpair, smp_processor_id());
 	}
 
 #define __update_rsp_in(_is_shadow_hba, _rsp, _rsp_in)			\
@@ -4425,6 +4424,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 	for (i = 0; i < ha->msix_count; i++) {
 		qentry = &ha->msix_entries[i];
 		qentry->vector = pci_irq_vector(ha->pdev, i);
+		qentry->vector_base0 = i;
 		qentry->entry = i;
 		qentry->have_irq = 0;
 		qentry->in_use = 0;
@@ -4652,5 +4652,6 @@ int qla25xx_request_irq(struct qla_hw_data *ha, struct qla_qpair *qpair,
 	}
 	msix->have_irq = 1;
 	msix->handle = qpair;
+	qla_mapq_init_qp_cpu_map(ha, msix, qpair);
 	return ret;
 }
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index c9a6fc882a801..9941b38eac93c 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -609,6 +609,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	fc_port_t *fcport;
 	struct srb_iocb *nvme;
 	struct scsi_qla_host *vha;
+	struct qla_hw_data *ha;
 	int rval;
 	srb_t *sp;
 	struct qla_qpair *qpair = hw_queue_handle;
@@ -629,6 +630,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 		return -ENODEV;
 
 	vha = fcport->vha;
+	ha = vha->hw;
 
 	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags))
 		return -EBUSY;
@@ -643,6 +645,8 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (fcport->nvme_flag & NVME_FLAG_RESETTING)
 		return -EBUSY;
 
+	qpair = qla_mapq_nvme_select_qpair(ha, qpair);
+
 	/* Alloc SRB structure */
 	sp = qla2xxx_get_qpair_sp(vha, qpair, fcport, GFP_ATOMIC);
 	if (!sp)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 78f7cd16967fa..b33ffec1cb75e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -480,6 +480,11 @@ static int qla2x00_alloc_queues(struct qla_hw_data *ha, struct req_que *req,
 			    "Unable to allocate memory for queue pair ptrs.\n");
 			goto fail_qpair_map;
 		}
+		if (qla_mapq_alloc_qp_cpu_map(ha) != 0) {
+			kfree(ha->queue_pair_map);
+			ha->queue_pair_map = NULL;
+			goto fail_qpair_map;
+		}
 	}
 
 	/*
@@ -554,6 +559,7 @@ static void qla2x00_free_queues(struct qla_hw_data *ha)
 		ha->base_qpair = NULL;
 	}
 
+	qla_mapq_free_qp_cpu_map(ha);
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	for (cnt = 0; cnt < ha->max_req_queues; cnt++) {
 		if (!test_bit(cnt, ha->req_qid_map))
-- 
2.40.1



