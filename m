Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18D7A3876
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbjIQTgc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjIQTgA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:36:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E758C11D
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278EEC433C8;
        Sun, 17 Sep 2023 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979349;
        bh=8XpjDZpP3P6Ftntz6YoVaxpiaV/simXY3XWNPQy/nLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ye5kBUUMTV5BNSkm4tprJCLQyh10IBl9CwRzHzNhoGifsoz3ZuiiDlziMXqbRQMl5
         SwyrCuIS342vey+gslkPpYXq6opMYh/fVmHEoXu+yxjdgHVVZdlaT1SB8nJdjjvl2s
         epV1LBMWhPpT0jqHsScVBs9vx0TVMpN7E9Hznp8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ranjan Kumar <ranjan.kumar@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 287/406] scsi: mpt3sas: Perform additional retries if doorbell read returns 0
Date:   Sun, 17 Sep 2023 21:12:21 +0200
Message-ID: <20230917191108.884582542@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

commit 4ca10f3e31745d35249a727ecd108eb58f0a8c5e upstream.

The driver retries certain register reads 3 times if the returned value is
0. This was done because the controller could return 0 for certain
registers if other registers were being accessed concurrently by the BMC.

In certain systems with increased BMC interactions, the register values
returned can be 0 for longer than 3 retries. Change the retry count from 3
to 30 for the affected registers to prevent problems with out-of-band
management.

Fixes: b899202901a8 ("scsi: mpt3sas: Add separate function for aero doorbell reads")
Cc: stable@vger.kernel.org
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20230829090020.5417-2-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c |   46 +++++++++++++++++++++++++-----------
 drivers/scsi/mpt3sas/mpt3sas_base.h |    1 
 2 files changed, 34 insertions(+), 13 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -131,6 +131,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPT
 static void
 _base_clear_outstanding_commands(struct MPT3SAS_ADAPTER *ioc);
 
+static u32
+_base_readl_ext_retry(const volatile void __iomem *addr);
+
 /**
  * mpt3sas_base_check_cmd_timeout - Function
  *		to check timeout and command termination due
@@ -206,6 +209,20 @@ _base_readl_aero(const volatile void __i
 	return ret_val;
 }
 
+static u32
+_base_readl_ext_retry(const volatile void __iomem *addr)
+{
+	u32 i, ret_val;
+
+	for (i = 0 ; i < 30 ; i++) {
+		ret_val = readl(addr);
+		if (ret_val == 0)
+			continue;
+	}
+
+	return ret_val;
+}
+
 static inline u32
 _base_readl(const volatile void __iomem *addr)
 {
@@ -861,7 +878,7 @@ mpt3sas_halt_firmware(struct MPT3SAS_ADA
 
 	dump_stack();
 
-	doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+	doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
 		mpt3sas_print_fault_code(ioc, doorbell &
 		    MPI2_DOORBELL_DATA_MASK);
@@ -5667,7 +5684,7 @@ mpt3sas_base_get_iocstate(struct MPT3SAS
 {
 	u32 s, sc;
 
-	s = ioc->base_readl(&ioc->chip->Doorbell);
+	s = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	sc = s & MPI2_IOC_STATE_MASK;
 	return cooked ? sc : s;
 }
@@ -5812,7 +5829,7 @@ _base_wait_for_doorbell_ack(struct MPT3S
 					   __func__, count, timeout));
 			return 0;
 		} else if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
-			doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+			doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 			if ((doorbell & MPI2_IOC_STATE_MASK) ==
 			    MPI2_IOC_STATE_FAULT) {
 				mpt3sas_print_fault_code(ioc, doorbell);
@@ -5852,7 +5869,7 @@ _base_wait_for_doorbell_not_used(struct
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		doorbell_reg = ioc->base_readl(&ioc->chip->Doorbell);
+		doorbell_reg = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 		if (!(doorbell_reg & MPI2_DOORBELL_USED)) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -5989,7 +6006,7 @@ _base_handshake_req_reply_wait(struct MP
 	__le32 *mfp;
 
 	/* make sure doorbell is not in use */
-	if ((ioc->base_readl(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
+	if ((ioc->base_readl_ext_retry(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
 		return -EFAULT;
 	}
@@ -6038,7 +6055,7 @@ _base_handshake_req_reply_wait(struct MP
 	}
 
 	/* read the first two 16-bits, it gives the total length of the reply */
-	reply[0] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[0] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 	if ((_base_wait_for_doorbell_int(ioc, 5))) {
@@ -6046,7 +6063,7 @@ _base_handshake_req_reply_wait(struct MP
 			__LINE__);
 		return -EFAULT;
 	}
-	reply[1] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[1] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 
@@ -6057,10 +6074,10 @@ _base_handshake_req_reply_wait(struct MP
 			return -EFAULT;
 		}
 		if (i >=  reply_bytes/2) /* overflow case */
-			ioc->base_readl(&ioc->chip->Doorbell);
+			ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 		else
 			reply[i] = le16_to_cpu(
-			    ioc->base_readl(&ioc->chip->Doorbell)
+			    ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 			    & MPI2_DOORBELL_DATA_MASK);
 		writel(0, &ioc->chip->HostInterruptStatus);
 	}
@@ -6906,7 +6923,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER
 			goto out;
 		}
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 		drsprintk(ioc,
 			  ioc_info(ioc, "wrote magic sequence: count(%d), host_diagnostic(0x%08x)\n",
 				   count, host_diagnostic));
@@ -6926,7 +6943,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER
 	for (count = 0; count < (300000000 /
 		MPI2_HARD_RESET_PCIE_SECOND_READ_DELAY_MICRO_SEC); count++) {
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 
 		if (host_diagnostic == 0xFFFFFFFF) {
 			ioc_info(ioc,
@@ -7313,10 +7330,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPT
 	ioc->rdpq_array_enable_assigned = 0;
 	ioc->use_32bit_dma = false;
 	ioc->dma_mask = 64;
-	if (ioc->is_aero_ioc)
+	if (ioc->is_aero_ioc) {
 		ioc->base_readl = &_base_readl_aero;
-	else
+		ioc->base_readl_ext_retry = &_base_readl_ext_retry;
+	} else {
 		ioc->base_readl = &_base_readl;
+		ioc->base_readl_ext_retry = &_base_readl;
+	}
 	r = mpt3sas_base_map_resources(ioc);
 	if (r)
 		goto out_free_resources;
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1469,6 +1469,7 @@ struct MPT3SAS_ADAPTER {
 	u8		diag_trigger_active;
 	u8		atomic_desc_capable;
 	BASE_READ_REG	base_readl;
+	BASE_READ_REG	base_readl_ext_retry;
 	struct SL_WH_MASTER_TRIGGER_T diag_trigger_master;
 	struct SL_WH_EVENT_TRIGGERS_T diag_trigger_event;
 	struct SL_WH_SCSI_TRIGGERS_T diag_trigger_scsi;


