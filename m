Return-Path: <stable+bounces-186088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B320BE389F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97C1881EE8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014D334388;
	Thu, 16 Oct 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iO8BieIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F7305E19
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619493; cv=none; b=tvjwff/3p1gIJfDr1DIyxsdLeAvt5S7blbC49oDyHpJslI4ihKZpz0RxJNdqBMMra9TRuswcdtZYjl/LRoK7NT7Sgo4KEbXEEcXL3rCQFUcnc5iyk9rSDSF+GRzfa5g30A3hmXm3pTQBGhT5xysyU9mlXEMFC2wHYxUCjGe652w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619493; c=relaxed/simple;
	bh=C2JgDm3+91IjS6Owa9wpJup90f602ymFL/XaBMrIzjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ji9FYQzfB5UjR0IYiI4BjMQ9Y97K7Xfstl7Ex8ASt56iC4IdknQpufHtcUZ0bpdLWzyQixl77ouzN13AYk+XCFBkXl/ZP+L1EfAGpaHnM5WNVyr9EJ76xfLAtZIxNFk01PVb9ruoS6MaI+e9Vcmh/70EplM1labzT7w6nRFDLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iO8BieIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9777C4CEF1;
	Thu, 16 Oct 2025 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619493;
	bh=C2JgDm3+91IjS6Owa9wpJup90f602ymFL/XaBMrIzjw=;
	h=Subject:To:Cc:From:Date:From;
	b=iO8BieIVXaX2yx+5Yg2retutALWMrP9fAkVOG3Yalsxm4aOkwi0LBO1tUfc3ox5kF
	 zYCp0nC94exOYglIUki4q6k9DtL9PpFgjMFPxfVKS1u0FeyyLcJPB0Iab54jnQVR0w
	 aMe4W6Ho0SaY+wFJ5YL8xORtUc5xyN+RUgJKv41o=
Subject: FAILED: patch "[PATCH] PCI/ERR: Fix uevent on failure to recover" failed to apply to 5.4-stable tree
To: lukas@wunner.de,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:58:10 +0200
Message-ID: <2025101610-deserve-skittle-9bde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1cbc5e25fb70e942a7a735a1f3d6dd391afc9b29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101610-deserve-skittle-9bde@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cbc5e25fb70e942a7a735a1f3d6dd391afc9b29 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:02 +0200
Subject: [PATCH] PCI/ERR: Fix uevent on failure to recover

Upon failure to recover from a PCIe error through AER, DPC or EDR, a
uevent is sent to inform user space about disconnection of the bridge
whose subordinate devices failed to recover.

However the bridge itself is not disconnected.  Instead, a uevent should
be sent for each of the subordinate devices.

Only if the "bridge" happens to be a Root Complex Event Collector or
Integrated Endpoint does it make sense to send a uevent for it (because
there are no subordinate devices).

Right now if there is a mix of subordinate devices with and without
pci_error_handlers, a BEGIN_RECOVERY event is sent for those with
pci_error_handlers but no FAILED_RECOVERY event is ever sent for them
afterwards.  Fix it.

Fixes: 856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org  # v4.16+
Link: https://patch.msgid.link/68fc527a380821b5d861dd554d2ce42cb739591c.1755008151.git.lukas@wunner.de

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e795e5ae6b03..21d554359fb1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -108,6 +108,12 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
 	return report_error_detected(dev, pci_channel_io_normal, data);
 }
 
+static int report_perm_failure_detected(struct pci_dev *dev, void *data)
+{
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	return 0;
+}
+
 static int report_mmio_enabled(struct pci_dev *dev, void *data)
 {
 	struct pci_driver *pdrv;
@@ -272,7 +278,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
-	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
 
 	pci_info(bridge, "device recovery failed\n");
 


