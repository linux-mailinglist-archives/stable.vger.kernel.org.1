Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3877A81BF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjITMsL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjITMsJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:48:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EFCF5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:48:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7118C433C7;
        Wed, 20 Sep 2023 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214082;
        bh=cOJxlbML5tscX/wCsxYaq60YrThWy/11VFIKPbcKBt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K64xPcSsEOFLAwpcRi1OeO0aIafiVN6qytIK/5LUpNYbDQTAM1Llk2r+dp6O0uMO8
         HiF2n/QUIKXMMZDp8wRkUFAwaQqx+ggznabxuGxTICAkgmr17kajEQ/4Nfjo2h/vnh
         fzRBFIPbAHlZqsYc267yp05AABDF3MBUS/Wgu7vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 105/110] scsi: pm8001: Setup IRQs on resume
Date:   Wed, 20 Sep 2023 13:32:43 +0200
Message-ID: <20230920112834.341365909@linuxfoundation.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

commit c91774818b041ed290df29fb1dc0725be9b12e83 upstream.

The function pm8001_pci_resume() only calls pm8001_request_irq() without
calling pm8001_setup_irq(). This causes the IRQ allocation to fail, which
leads all drives being removed from the system.

Fix this issue by integrating the code for pm8001_setup_irq() directly
inside pm8001_request_irq() so that MSI-X setup is performed both during
normal initialization and resume operations.

Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230911232745.325149-2-dlemoal@kernel.org
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/pm8001/pm8001_init.c |   51 ++++++++++++--------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -255,7 +255,6 @@ static irqreturn_t pm8001_interrupt_hand
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -276,13 +275,6 @@ static int pm8001_alloc(struct pm8001_hb
 	pm8001_dbg(pm8001_ha, INIT, "pm8001_alloc: PHY:%x\n",
 		   pm8001_ha->chip->n_phy);
 
-	/* Setup Interrupt */
-	rc = pm8001_setup_irq(pm8001_ha);
-	if (rc) {
-		pm8001_dbg(pm8001_ha, FAIL,
-			   "pm8001_setup_irq failed [ret: %d]\n", rc);
-		goto err_out;
-	}
 	/* Request Interrupt */
 	rc = pm8001_request_irq(pm8001_ha);
 	if (rc)
@@ -1002,47 +994,38 @@ static u32 pm8001_request_msix(struct pm
 }
 #endif
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha)
-{
-	struct pci_dev *pdev;
-
-	pdev = pm8001_ha->pdev;
-
-#ifdef PM8001_USE_MSIX
-	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX))
-		return pm8001_setup_msix(pm8001_ha);
-	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-#endif
-	return 0;
-}
-
 /**
  * pm8001_request_irq - register interrupt
  * @pm8001_ha: our ha struct.
  */
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = pm8001_ha->pdev;
+#ifdef PM8001_USE_MSIX
 	int rc;
 
-	pdev = pm8001_ha->pdev;
+	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX)) {
+		rc = pm8001_setup_msix(pm8001_ha);
+		if (rc) {
+			pm8001_dbg(pm8001_ha, FAIL,
+				   "pm8001_setup_irq failed [ret: %d]\n", rc);
+			return rc;
+		}
 
-#ifdef PM8001_USE_MSIX
-	if (pdev->msix_cap && pci_msi_enabled())
-		return pm8001_request_msix(pm8001_ha);
-	else {
-		pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-		goto intx;
+		if (pdev->msix_cap && pci_msi_enabled())
+			return pm8001_request_msix(pm8001_ha);
 	}
+
+	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
 #endif
 
-intx:
 	/* initialize the INT-X interrupt */
 	pm8001_ha->irq_vector[0].irq_id = 0;
 	pm8001_ha->irq_vector[0].drv_inst = pm8001_ha;
-	rc = request_irq(pdev->irq, pm8001_interrupt_handler_intx, IRQF_SHARED,
-		pm8001_ha->name, SHOST_TO_SAS_HA(pm8001_ha->shost));
-	return rc;
+
+	return request_irq(pdev->irq, pm8001_interrupt_handler_intx,
+			   IRQF_SHARED, pm8001_ha->name,
+			   SHOST_TO_SAS_HA(pm8001_ha->shost));
 }
 
 /**


