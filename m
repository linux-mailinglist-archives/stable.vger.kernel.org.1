Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BA77AB1F
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHMUTt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHMUTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538710FA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950196273E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B122C433C7;
        Sun, 13 Aug 2023 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691957990;
        bh=Lvsqu7DoP1XA6G106ASSrUHDqNYE2msZoXfMB8DpvWA=;
        h=Subject:To:Cc:From:Date:From;
        b=vT4pb36j4VAICfB1aeqbKdTMCYFB7EUVXK4JnIO+Oe5DczywX7D4j7LpWAch5cZnr
         p33mfNp39KUchBdUClUIkE0+WK4t10ZsG0RDv+DdUAOD0mgJ+xByLgnuky+yRXPrmR
         e4q/m+0Kq54AzfQZ2q1ZSSDxRL1dmhUKW5YvyrpQ=
Subject: FAILED: patch "[PATCH] scsi: qedi: Fix firmware halt over suspend and resume" failed to apply to 4.14-stable tree
To:     njavali@marvell.com, martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 13 Aug 2023 22:19:37 +0200
Message-ID: <2023081337-splendor-opal-8b0b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1516ee035df32115197cd93ae3619dba7b020986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081337-splendor-opal-8b0b@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

1516ee035df3 ("scsi: qedi: Fix firmware halt over suspend and resume")
96a766a789eb ("scsi: qedi: Add support for handling PCIe errors")
f4ba4e55db6d ("scsi: qedi: Add firmware error recovery invocation support")
5c35e4646566 ("scsi: qedi: Skip firmware connection termination for PCI shutdown handler")
e4020e0835ed ("scsi: qedi: Remove 2 set but unused variables")
4f93c4bf0f74 ("scsi: qedi: Add PCI shutdown handler support")
4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
2bfbc570586e ("qedi: Use hwfns and affin_hwfn_idx to get MSI-X vector index")
13b99d3d3907 ("Revert "scsi: qedi: Allocate IRQs based on msix_cnt"")
dcceeeb71fb7 ("scsi: qedi: add module param to set ping packet size")
1a291bce5eaf ("scsi: qedi: Allocate IRQs based on msix_cnt")
3fb5a21fd008 ("scsi: qedi: Cleanup redundant QEDI_PAGE_SIZE macro definition")
a3440d0d2f57 ("scsi: qedi: Send driver state to MFW")
534bbdf8832a ("qedi: Add support for populating ethernet TLVs.")
da09091732ae ("qed*: Utilize FW 8.33.1.0")
21dd79e82f00 ("qed*: HSI renaming for different types of HW")
a2e7699eb50f ("qed*: Refactoring and rearranging FW API with no functional impact")
ed468ebee04f ("qed: Add ll2 ability of opening a secondary queue")
d1abfd0b4ee2 ("qed: Add iWARP out of order support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1516ee035df32115197cd93ae3619dba7b020986 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Mon, 7 Aug 2023 15:07:25 +0530
Subject: [PATCH] scsi: qedi: Fix firmware halt over suspend and resume

While performing certain power-off sequences, PCI drivers are called to
suspend and resume their underlying devices through PCI PM (power
management) interface. However the hardware does not support PCI PM
suspend/resume operations so system wide suspend/resume leads to bad MFW
(management firmware) state which causes various follow-up errors in driver
when communicating with the device/firmware.

To fix this driver implements PCI PM suspend handler to indicate
unsupported operation to the PCI subsystem explicitly, thus avoiding system
to go into suspended/standby mode.

Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230807093725.46829-2-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 77a56a136678..cd0180b1f5b9 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -69,6 +69,7 @@ static struct nvm_iscsi_block *qedi_get_nvram_block(struct qedi_ctx *qedi);
 static void qedi_recovery_handler(struct work_struct *work);
 static void qedi_schedule_hw_err_handler(void *dev,
 					 enum qed_hw_err_type err_type);
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state);
 
 static int qedi_iscsi_event_cb(void *context, u8 fw_event_code, void *fw_handle)
 {
@@ -2511,6 +2512,22 @@ static void qedi_shutdown(struct pci_dev *pdev)
 	__qedi_remove(pdev, QEDI_MODE_SHUTDOWN);
 }
 
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedi_ctx *qedi;
+
+	if (!pdev) {
+		QEDI_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedi = pci_get_drvdata(pdev);
+
+	QEDI_ERR(&qedi->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 static int __qedi_probe(struct pci_dev *pdev, int mode)
 {
 	struct qedi_ctx *qedi;
@@ -2869,6 +2886,7 @@ static struct pci_driver qedi_pci_driver = {
 	.remove = qedi_remove,
 	.shutdown = qedi_shutdown,
 	.err_handler = &qedi_err_handler,
+	.suspend = qedi_suspend,
 };
 
 static int __init qedi_init(void)

