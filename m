Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059B1726BD2
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjFGU2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjFGU2f (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFF1FEE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10695644A8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CC7C433D2;
        Wed,  7 Jun 2023 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169695;
        bh=ATjML6lJGwZ9+QGvbyh2iZqPUSl5J3oc8zpo4JAorLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Og3IDMY5rpMT3r+IQcpvz/0lwfS277C/M2rAO+eK7NXEZXQxLunLPAK3MHKK5sxc2
         4NdQw9EO/mxLIKFuqA9+KsBfV9kxx4qHcPThd4Z6tkPSmh+6pBPyf//6+cQBRVudTv
         RSh6bkVpXD+tZwJQb1azlIVbvNEo1JKvVRuWncEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gleb Chesnokov <gleb.chesnokov@scst.dev>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 179/286] scsi: qla2xxx: Fix NULL pointer dereference in target mode
Date:   Wed,  7 Jun 2023 22:14:38 +0200
Message-ID: <20230607200929.119492837@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gleb Chesnokov <gleb.chesnokov@scst.dev>

[ Upstream commit d54820b22e404b06b2b65877ff802cc7b31688bc ]

When target mode is enabled, the pci_irq_get_affinity() function may return
a NULL value in qla_mapq_init_qp_cpu_map() due to the qla24xx_enable_msix()
code that handles IRQ settings for target mode. This leads to a crash due
to a NULL pointer dereference.

This patch fixes the issue by adding a check for the NULL value returned by
pci_irq_get_affinity() and introducing a 'cpu_mapped' boolean flag to the
qla_qpair structure, ensuring that the qpair's CPU affinity is updated when
it has not been mapped to a CPU.

Fixes: 1d201c81d4cc ("scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called")
Signed-off-by: Gleb Chesnokov <gleb.chesnokov@scst.dev>
Link: https://lore.kernel.org/r/56b416f2-4e0f-b6cf-d6d5-b7c372e3c6a2@scst.dev
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h    | 1 +
 drivers/scsi/qla2xxx/qla_init.c   | 3 +++
 drivers/scsi/qla2xxx/qla_inline.h | 3 +++
 drivers/scsi/qla2xxx/qla_isr.c    | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ec0e987b71fa5..807ae5ede44c6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3797,6 +3797,7 @@ struct qla_qpair {
 	uint64_t retry_term_jiff;
 	struct qla_tgt_counters tgt_counters;
 	uint16_t cpuid;
+	bool cpu_mapped;
 	struct qla_fw_resources fwres ____cacheline_aligned;
 	struct  qla_buf_pool buf_pool;
 	u32	cmd_cnt;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ec0423ec66817..1a955c3ff3d6c 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9426,6 +9426,9 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 		qpair->rsp->req = qpair->req;
 		qpair->rsp->qpair = qpair;
 
+		if (!qpair->cpu_mapped)
+			qla_cpu_update(qpair, raw_smp_processor_id());
+
 		if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif) {
 			if (ha->fw_attributes & BIT_4)
 				qpair->difdix_supported = 1;
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index cce6e425c1214..7b42558a8839a 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -539,11 +539,14 @@ qla_mapq_init_qp_cpu_map(struct qla_hw_data *ha,
 	if (!ha->qp_cpu_map)
 		return;
 	mask = pci_irq_get_affinity(ha->pdev, msix->vector_base0);
+	if (!mask)
+		return;
 	qpair->cpuid = cpumask_first(mask);
 	for_each_cpu(cpu, mask) {
 		ha->qp_cpu_map[cpu] = qpair;
 	}
 	msix->cpuid = qpair->cpuid;
+	qpair->cpu_mapped = true;
 }
 
 static inline void
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 71feda2cdb630..245e3a5d81fd3 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3770,6 +3770,9 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 
 	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
+
+		if (!rsp->qpair->cpu_mapped)
+			qla_cpu_update(rsp->qpair, raw_smp_processor_id());
 	}
 
 #define __update_rsp_in(_is_shadow_hba, _rsp, _rsp_in)			\
-- 
2.39.2



