Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847E7BE179
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377375AbjJINuq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377445AbjJINuj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:50:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8C111
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE67C116A8;
        Mon,  9 Oct 2023 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859427;
        bh=/qezE9P/an2log2tmm3zBiRYGBEE6/6MzvIWYPTlzjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBj2jn6rQkw/Q4a6IDnAKoNVzIDQPff0g2faGMy/AVim+7e2VwwTr1fCDNxBcCrrr
         U/FgpVhmt3OZebGan6JH4nb9BVaHu2h2Iw9sKxhomqgEhK3jCwduxFtTr+8ivPVA6D
         q9iopShqPI8ZzcB4pIMAASPO74l+I+Vqnw9oAsxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/91] scsi: megaraid_sas: Load balance completions across all MSI-X
Date:   Mon,  9 Oct 2023 15:05:50 +0200
Message-ID: <20231009130112.163149933@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 1d15d9098ad12b0021ac5a6b851f26d1ab021e5a ]

Driver will use "reply descriptor post queues" in round robin fashion when
the combined MSI-X mode is not enabled. With this IO completions are
distributed and load balanced across all the available reply descriptor
post queues equally.

This is enabled only if combined MSI-X mode is not enabled in firmware.
This improves performance and also fixes soft lockups.

When load balancing is enabled, IRQ affinity from driver needs to be
disabled.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 0b0747d507bf ("scsi: megaraid_sas: Fix deadlock on firmware crashdump")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  3 +++
 drivers/scsi/megaraid/megaraid_sas_base.c   | 22 +++++++++++++++++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 18 +++++++++++++----
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 67d356d847176..80ae48b65b608 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2193,6 +2193,7 @@ struct megasas_instance {
 	u32 secure_jbod_support;
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
+	bool smp_affinity_enable;
 	spinlock_t crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
@@ -2210,6 +2211,7 @@ struct megasas_instance {
 	u16 ldio_threshold;
 	u16 cur_can_queue;
 	u32 max_sectors_per_req;
+	bool msix_load_balance;
 	struct megasas_aen_event *ev;
 
 	struct megasas_cmd **cmd_list;
@@ -2246,6 +2248,7 @@ struct megasas_instance {
 	atomic_t sge_holes_type1;
 	atomic_t sge_holes_type2;
 	atomic_t sge_holes_type3;
+	atomic64_t total_io_count;
 
 	struct megasas_instance_template *instancet;
 	struct tasklet_struct isr_tasklet;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8d1df03386b4f..2b6b6d3deba86 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5101,6 +5101,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 					 &instance->irq_context[j]);
 			/* Retry irq register for IO_APIC*/
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
 			if (is_probe) {
 				pci_free_irq_vectors(instance->pdev);
 				return megasas_setup_irqs_ioapic(instance);
@@ -5109,6 +5110,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 			}
 		}
 	}
+
 	return 0;
 }
 
@@ -5364,6 +5366,12 @@ static int megasas_init_fw(struct megasas_instance *instance)
 				if (rdpq_enable)
 					instance->is_rdpq = (scratch_pad_2 & MR_RDPQ_MODE_OFFSET) ?
 								1 : 0;
+
+				if (!instance->msix_combined) {
+					instance->msix_load_balance = true;
+					instance->smp_affinity_enable = false;
+				}
+
 				fw_msix_count = instance->msix_vectors;
 				/* Save 1-15 reply post index address to local memory
 				 * Index 0 is already saved from reg offset
@@ -5382,17 +5390,20 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->msix_vectors);
 		} else /* MFI adapters */
 			instance->msix_vectors = 1;
+
 		/* Don't bother allocating more MSI-X vectors than cpus */
 		instance->msix_vectors = min(instance->msix_vectors,
 					     (unsigned int)num_online_cpus());
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 		i = pci_alloc_irq_vectors(instance->pdev, 1,
 					  instance->msix_vectors, irq_flags);
-		if (i > 0)
+		if (i > 0) {
 			instance->msix_vectors = i;
-		else
+		} else {
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
+		}
 	}
 	/*
 	 * MSI-X host index 0 is common for all adapter.
@@ -6447,6 +6458,7 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	INIT_LIST_HEAD(&instance->internal_reset_pending_q);
 
 	atomic_set(&instance->fw_outstanding, 0);
+	atomic64_set(&instance->total_io_count, 0);
 
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
@@ -6469,6 +6481,8 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	instance->last_time = 0;
 	instance->disableOnlineCtrlReset = 1;
 	instance->UnevenSpanSupport = 0;
+	instance->smp_affinity_enable = smp_affinity_enable ? true : false;
+	instance->msix_load_balance = false;
 
 	if (instance->adapter_type != MFI_SERIES) {
 		INIT_WORK(&instance->work_init, megasas_fusion_ocr_wq);
@@ -6818,7 +6832,7 @@ megasas_resume(struct pci_dev *pdev)
 	/* Now re-enable MSI-X */
 	if (instance->msix_vectors) {
 		irq_flags = PCI_IRQ_MSIX;
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 	}
 	rval = pci_alloc_irq_vectors(instance->pdev, 1,
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index b400167f9ad42..294e1a3a6adfa 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2641,8 +2641,13 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	praid_context = &io_request->RaidContext;
 
@@ -2969,8 +2974,13 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	if (!fp_possible) {
 		/* system pd firmware path */
-- 
2.40.1



