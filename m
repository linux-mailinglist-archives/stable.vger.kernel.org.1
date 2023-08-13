Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20277AB22
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjHMUUC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjHMUUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C9C10F9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A94306274B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDB5C433C7;
        Sun, 13 Aug 2023 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691958003;
        bh=by3PZSUsFQQFuygTz2tMpwNLhM5trCyWODvjZtS3gUA=;
        h=Subject:To:Cc:From:Date:From;
        b=q2O2QRIadquvTzh3hud2Vevr/wHCUJu9pzfc6HVcpbzf3EWVYz9gi1yVfGIj0D+mx
         3c7mmg/xQcPcbF3FEUdzuO0rHzEnuM6mMyUUagGG6kPwBhQyjIiLx0TNLeO5YB1tkd
         w3QARjUnsYKD2VZqqZr/wDKmwDtnnExbS2FzAYtg=
Subject: FAILED: patch "[PATCH] scsi: qedf: Fix firmware halt over suspend and resume" failed to apply to 4.19-stable tree
To:     njavali@marvell.com, martin.petersen@oracle.com,
        skashyap@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 13 Aug 2023 22:19:52 +0200
Message-ID: <2023081352-pouncing-speller-9684@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ef222f551e7c4e2008fc442ffc9edcd1a7fd8f63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081352-pouncing-speller-9684@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ef222f551e7c ("scsi: qedf: Fix firmware halt over suspend and resume")
f6b172f21999 ("scsi: qedf: Add schedule recovery handler")
6e7c8eea929e ("scsi: qedf: Implement callback for bw_update")
31696204c44c ("scsi: qedf: Add shutdown callback handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef222f551e7c4e2008fc442ffc9edcd1a7fd8f63 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Mon, 7 Aug 2023 15:07:24 +0530
Subject: [PATCH] scsi: qedf: Fix firmware halt over suspend and resume

While performing certain power-off sequences, PCI drivers are called to
suspend and resume their underlying devices through PCI PM (power
management) interface. However the hardware does not support PCI PM
suspend/resume operations so system wide suspend/resume leads to bad MFW
(management firmware) state which causes various follow-up errors in driver
when communicating with the device/firmware.

To fix this driver implements PCI PM suspend handler to indicate
unsupported operation to the PCI subsystem explicitly, thus avoiding system
to go into suspended/standby mode.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230807093725.46829-1-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 2a31ddc99dde..7825765c936c 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -31,6 +31,7 @@ static void qedf_remove(struct pci_dev *pdev);
 static void qedf_shutdown(struct pci_dev *pdev);
 static void qedf_schedule_recovery_handler(void *dev);
 static void qedf_recovery_handler(struct work_struct *work);
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state);
 
 /*
  * Driver module parameters.
@@ -3271,6 +3272,7 @@ static struct pci_driver qedf_pci_driver = {
 	.probe = qedf_probe,
 	.remove = qedf_remove,
 	.shutdown = qedf_shutdown,
+	.suspend = qedf_suspend,
 };
 
 static int __qedf_probe(struct pci_dev *pdev, int mode)
@@ -4000,6 +4002,22 @@ static void qedf_shutdown(struct pci_dev *pdev)
 	__qedf_remove(pdev, QEDF_MODE_NORMAL);
 }
 
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedf_ctx *qedf;
+
+	if (!pdev) {
+		QEDF_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedf = pci_get_drvdata(pdev);
+
+	QEDF_ERR(&qedf->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 /*
  * Recovery handler code
  */

