Return-Path: <stable+bounces-62516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877993F505
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073E328233A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78951474BF;
	Mon, 29 Jul 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b3F3Bvvz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B251474B9
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255511; cv=none; b=BKP3SBp5PPs7EtQ6G8R/KoFbebtBPiEGDeKLV62x/WcMDQnrjMGxnKHNfysDu9NTME0WuthtwhCCqgxFaXNVP7QytRle1897EXhFgIyys6Ov/Ur4gASgi2QmaLvWLXrMjrbCfcQUp36vDjMF3ZlcRSGDgidT6KFjbCePYmgCRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255511; c=relaxed/simple;
	bh=fOZFiWuNNMOOhRr+W91cJ9/qAvOoGaPJ4TYybHza2ao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LljOdrlGKT5fTJy1Ki5LlMJVO9PTi86MyQAFhukmFBZDGcxPVVtcLHqrCNb37YKigOTB9S+rQG42DUOkoEdvc9DW7KD9sOf6tc5jr2zn0ofA7iNn6VxYmKY4GOhsmU1ZjjIDrJGMfDl09tC26Zy6vzPAT9gO+FR9Qtv/EaFrqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b3F3Bvvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE5FC32786;
	Mon, 29 Jul 2024 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255511;
	bh=fOZFiWuNNMOOhRr+W91cJ9/qAvOoGaPJ4TYybHza2ao=;
	h=Subject:To:Cc:From:Date:From;
	b=b3F3BvvzVN+VLxTgMz9NFCe9UWWB4n+2QpX2JH7gE9CqByKH01YVK7YoTeGSjSHIp
	 +8+4UT/ERu4q0UDbCFoxOgK2p6Yrk8Xb4dTNFmle2l5oZ/afS2YUuJWhpj0ZGFjhr1
	 x2dem+w5tF/qMpWy+LkCixflHQTdbz9BDo1Okuaw=
Subject: FAILED: patch "[PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal" failed to apply to 6.6-stable tree
To: lukas@wunner.de,kbusch@kernel.org,kwilczynski@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:18:20 +0200
Message-ID: <2024072919-usual-unstopped-30af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 11a1f4bc47362700fcbde717292158873fb847ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072919-usual-unstopped-30af@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


