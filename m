Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678A73B389
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjFWJ2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFWJ2g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9339D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0087619E3
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE6FC433CA;
        Fri, 23 Jun 2023 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512514;
        bh=JNd2SU2hjcc+uSWRAPC2dTimq1/JxjGW+3TLJvKaXTQ=;
        h=Subject:To:Cc:From:Date:From;
        b=DLWs1QfviEiw/vVHVPiYFJxLPdfcFrKvWbm2m85Gzak5h07ACAGWQoADVGdb7nMT6
         +kAMCxusqOhV213KkhY3poQRt1AM4gmNMnC/ibCBBzPrYRb1ubSGcSC/fLve+GE148
         kJeM6SAMQnldfR0Ln+UkiwkVG1lSUNij0fT5W1Ro=
Subject: FAILED: patch "[PATCH] PCI: hv: Fix a race condition in hv_irq_unmask() that can" failed to apply to 4.19-stable tree
To:     decui@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:28:29 +0200
Message-ID: <2023062328-harmonics-nastily-a8fd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 2738d5ab7929a845b654cd171a1e275c37eb428e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062328-harmonics-nastily-a8fd@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2738d5ab7929a845b654cd171a1e275c37eb428e Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 14 Jun 2023 21:44:48 -0700
Subject: [PATCH] PCI: hv: Fix a race condition in hv_irq_unmask() that can
 cause panic

When the host tries to remove a PCI device, the host first sends a
PCI_EJECT message to the guest, and the guest is supposed to gracefully
remove the PCI device and send a PCI_EJECTION_COMPLETE message to the host;
the host then sends a VMBus message CHANNELMSG_RESCIND_CHANNELOFFER to
the guest (when the guest receives this message, the device is already
unassigned from the guest) and the guest can do some final cleanup work;
if the guest fails to respond to the PCI_EJECT message within one minute,
the host sends the VMBus message CHANNELMSG_RESCIND_CHANNELOFFER and
removes the PCI device forcibly.

In the case of fast device addition/removal, it's possible that the PCI
device driver is still configuring MSI-X interrupts when the guest receives
the PCI_EJECT message; the channel callback calls hv_pci_eject_device(),
which sets hpdev->state to hv_pcichild_ejecting, and schedules a work
hv_eject_device_work(); if the PCI device driver is calling
pci_alloc_irq_vectors() -> ... -> hv_compose_msi_msg(), we can break the
while loop in hv_compose_msi_msg() due to the updated hpdev->state, and
leave data->chip_data with its default value of NULL; later, when the PCI
device driver calls request_irq() -> ... -> hv_irq_unmask(), the guest
crashes in hv_arch_irq_unmask() due to data->chip_data being NULL.

Fix the issue by not testing hpdev->state in the while loop: when the
guest receives PCI_EJECT, the device is still assigned to the guest, and
the guest has one minute to finish the device removal gracefully. We don't
really need to (and we should not) test hpdev->state in the loop.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-3-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ea8862e656b6..733637d96765 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -635,6 +635,11 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
+	if (!int_desc) {
+		dev_warn(&hbus->hdev->device, "%s() can not unmask irq %u\n",
+			 __func__, data->irq);
+		return;
+	}
 
 	local_irq_save(flags);
 
@@ -2004,12 +2009,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_pci_onchannelcallback(hbus);
 		spin_unlock_irqrestore(&channel->sched_lock, flags);
 
-		if (hpdev->state == hv_pcichild_ejecting) {
-			dev_err_once(&hbus->hdev->device,
-				     "the device is being ejected\n");
-			goto enable_tasklet;
-		}
-
 		udelay(100);
 	}
 

