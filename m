Return-Path: <stable+bounces-62514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032C93F501
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBB61C21627
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB31474CA;
	Mon, 29 Jul 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9rKj2CQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DD1474B9
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255486; cv=none; b=UgBxgsz4hyxNMxSYDdmmUzNqSjf54+qY+vqc6GrQTC8H8EZSadKGe6+yRRByf1+IL/PgREWnYVYO03EYrz/8XhHH/hB2yh/hNVQ+RBmeZyEEdSaXLbhsB+hEZQXU79L1NJlkCj04J037V0jBxIDGKhU5TS+vxtHeJ0WfHdYmxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255486; c=relaxed/simple;
	bh=HG8/FW/f3eOALnUI3znl4dtfNVQHEeipNbOaXWnOHx0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E+N3/kJKfPRI10S+XiTmeMgneNUpmgVye9MvCJsJkCap8Tj0RXoM+8WEkRYquLVaDXenvrXJtbQLEEsi7t54FIBZAeKavY0VkMIhDP6jDKH8YcY6S0hUorxqCg+yK9I/gt6+bJILmPEl0786uZR3d6/I5EG6b3vdL+8T3QP3zxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9rKj2CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F2C4AF07;
	Mon, 29 Jul 2024 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255486;
	bh=HG8/FW/f3eOALnUI3znl4dtfNVQHEeipNbOaXWnOHx0=;
	h=Subject:To:Cc:From:Date:From;
	b=O9rKj2CQq1h2DJLzX+AdDSbTv1rCTeVxlaGabRWxlCcIWZHvunSt9htMK2dz5eUZk
	 AAu526Ezp/mFfXUK4l2TwqGV51bFdsF1UyxS7Ic7inCHCJMxIwoWeXmQbxWZlQtihu
	 VHM/q1Zxzo/kZertdNgPKhoAbBdZcs152UHIIVR0=
Subject: FAILED: patch "[PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal" failed to apply to 5.15-stable tree
To: lukas@wunner.de,kbusch@kernel.org,kwilczynski@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:17:21 +0200
Message-ID: <2024072921-crazed-babble-80d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 11a1f4bc47362700fcbde717292158873fb847ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072921-crazed-babble-80d9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

11a1f4bc4736 ("PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11a1f4bc47362700fcbde717292158873fb847ed Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 18 Jun 2024 12:54:55 +0200
Subject: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Keith reports a use-after-free when a DPC event occurs concurrently to
hot-removal of the same portion of the hierarchy:

The dpc_handler() awaits readiness of the secondary bus below the
Downstream Port where the DPC event occurred.  To do so, it polls the
config space of the first child device on the secondary bus.  If that
child device is concurrently removed, accesses to its struct pci_dev
cause the kernel to oops.

That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
reference on the child device.  Before v6.3, the function was only
called on resume from system sleep or on runtime resume.  Holding a
reference wasn't necessary back then because the pciehp IRQ thread
could never run concurrently.  (On resume from system sleep, IRQs are
not enabled until after the resume_noirq phase.  And runtime resume is
always awaited before a PCI device is removed.)

However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
of secondary bus after reset"), which introduced that, failed to
appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
reference on the child device because dpc_handler() and pciehp may
indeed run concurrently.  The commit was backported to v5.10+ stable
kernels, so that's the oldest one affected.

Add the missing reference acquisition.

Abridged stack trace:

  BUG: unable to handle page fault for address: 00000000091400c0
  CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
  RIP: pci_bus_read_config_dword+0x17/0x50
  pci_dev_wait()
  pci_bridge_wait_for_secondary_bus()
  dpc_reset_link()
  pcie_do_recovery()
  dpc_handler()

Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
Link: https://lore.kernel.org/linux-pci/8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de
Reported-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org # v5.10+

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..c40a6c11e959 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4753,7 +4753,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  */
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 {
-	struct pci_dev *child;
+	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
 
 	if (pci_dev_is_disconnected(dev))
@@ -4782,8 +4782,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*


