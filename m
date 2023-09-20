Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8D7A784C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjITJ6j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjITJ6g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64B110
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:58:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C8AC433CC;
        Wed, 20 Sep 2023 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203903;
        bh=Q7p9ybYWxOz4RM8X7CjWgE3uu4p6dZJZt/dMp9lDGSg=;
        h=Subject:To:Cc:From:Date:From;
        b=C6+CczdMmt5coql1H8ibAJDREMMjewmfvZobvMB5SzqXpxn9RSf+Ve+o0PH1zSVUu
         8Hl5bAvnoJ+Y9UETrIZVq2a7noIPcFgMINExDcdHSM6Gu/BQIM57RaWGXh+Ak4eVZX
         zEqanOzpKETFQDRmM8uzKV11o+JffFFbYhpW5f6Q=
Subject: FAILED: patch "[PATCH] scsi: pm8001: Setup IRQs on resume" failed to apply to 4.19-stable tree
To:     dlemoal@kernel.org, jinpu.wang@ionos.com,
        martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:58:12 +0200
Message-ID: <2023092012-enrich-emergency-af23@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c91774818b041ed290df29fb1dc0725be9b12e83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092012-enrich-emergency-af23@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c91774818b04 ("scsi: pm8001: Setup IRQs on resume")
653926205741 ("scsi: pm80xx: Do not call scsi_remove_host() in pm8001_alloc()")
1b5d2793283d ("scsi: pm8001: Neaten debug logging macros and uses")
1f889b58716a ("scsi: pm80xx: Fix pm8001_mpi_get_nvmd_resp() race condition")
4a2efd4b89fc ("scsi: pm80xx: Make running_req atomic")
7640e1eb8c5d ("scsi: pm80xx: Make mpi_build_cmd locking consistent")
5a141315ed7c ("scsi: pm80xx: Increase the number of outstanding I/O supported to 1024")
27bc43bd7c42 ("scsi: pm80xx: Remove DMA memory allocation for ccb and device structures")
05c6c029a44d ("scsi: pm80xx: Increase number of supported queues")
dba2cc03b9db ("scsi: pm80xx: sysfs attribute for non fatal dump")
b40f28820fba ("scsi: pm80xx: Cleanup initialization loading fail path")
9d9c7c20fb35 ("scsi: pm80xx: Free the tag when mpi_set_phy_profile_resp is received")
d384be6ede5c ("scsi: pm80xx: Deal with kexec reboots")
58bf14c17e65 ("scsi: pm80xx: Increase request sg length")
20bc1ad2e4da ("scsi: pm80xx: fix spelling mistake "to" -> "too"")
044f59de3a3d ("scsi: pm80xx: Modified the logic to collect fatal dump")
7295493682aa ("scsi: pm80xx: Tie the interrupt name to the module instance")
3e253d9657b0 ("scsi: pm80xx: Do not request 12G sas speeds")
51c1c5f6ed64 ("scsi: pm80xx: Cleanup command when a reset times out")
91a43fa61f10 ("scsi: pm80xx: Fix command issue sizing")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c91774818b041ed290df29fb1dc0725be9b12e83 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 12 Sep 2023 08:27:36 +0900
Subject: [PATCH] scsi: pm8001: Setup IRQs on resume

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

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 5e5ce1e74c3b..443a3176c6c0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -273,7 +273,6 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -294,13 +293,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
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
@@ -1031,47 +1023,38 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
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

