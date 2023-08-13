Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59877AB1D
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHMUTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHMUTh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3FC10F9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D354162713
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD021C433C8;
        Sun, 13 Aug 2023 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691957978;
        bh=C7MiadIW/UdgcpUzRnJ2lp+zxgkdr3fNPQlvztt1OL8=;
        h=Subject:To:Cc:From:Date:From;
        b=eTOPJIZTfYOjCyF8NrDjiONrcd7dLgy9Cdf6If6FE2ywjNL35NiISE7PinbHIZ0CH
         xGS91vFsA5RSkmHHGx51ReG46iys7KMMuE3bbicsW2+0Jrroe9LT8+KiqzG9g41Uma
         Ivs8lTBFrgDHL4r5tmtaTgvEDRyXZ4XT57nAg+iY=
Subject: FAILED: patch "[PATCH] scsi: qedi: Fix firmware halt over suspend and resume" failed to apply to 5.4-stable tree
To:     njavali@marvell.com, martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 13 Aug 2023 22:19:35 +0200
Message-ID: <2023081335-disperser-acting-9c76@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1516ee035df32115197cd93ae3619dba7b020986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081335-disperser-acting-9c76@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

1516ee035df3 ("scsi: qedi: Fix firmware halt over suspend and resume")
96a766a789eb ("scsi: qedi: Add support for handling PCIe errors")
f4ba4e55db6d ("scsi: qedi: Add firmware error recovery invocation support")
5c35e4646566 ("scsi: qedi: Skip firmware connection termination for PCI shutdown handler")
e4020e0835ed ("scsi: qedi: Remove 2 set but unused variables")
4f93c4bf0f74 ("scsi: qedi: Add PCI shutdown handler support")
4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")

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

