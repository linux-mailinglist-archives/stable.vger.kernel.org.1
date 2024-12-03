Return-Path: <stable+bounces-96449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F29E1FCB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA25416913A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F151EE029;
	Tue,  3 Dec 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6rpMjjB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07A1EF08A;
	Tue,  3 Dec 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236852; cv=none; b=smo/m24Hw8xsDqVhgNiHodBFmSM4Oqtd5M9N2aFa1MR/9p1P3xeuXUt4+WWN5rMlwOYyXtgdBbhtUX8urDpDsUA5ZBNZNJm13ZFy3opZkPfOGMtA2AB/VwJJteRa0Xej8KqikbrljOXa9ElsnteAUH8KOmSrUnd7aHLSb+xg1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236852; c=relaxed/simple;
	bh=GyT3sZpg3GfgppRWx7fBq9EP61929tJrbP4e16XfjZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxddvPcSObYTDH5MRDu3UXgQ4jvY9dFwiA9htNDQwpH+4l2qMSJf750HGWWeW+SqqniGOlFxfuOR5XQUop87B+A/gmYJDmycPnf7CkIJXc/5hNS3VIm8Uipixdzg3RmTC8e/EWu3CSePyUyJQTkQXgMXpOq65zwaJO7nIYsn8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6rpMjjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CD6C4CECF;
	Tue,  3 Dec 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733236852;
	bh=GyT3sZpg3GfgppRWx7fBq9EP61929tJrbP4e16XfjZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6rpMjjBWQuENDiOV7nQQFSghQ86HaaJbeNsieh0fRUEmiuL6yUdRUtp/ZVbrZoDS
	 qK/YbNOwfwKwNHBSPPRa/UuOAorEAbBV48JI19vNTQyFH6gc4GXX5GzjUuycswK0qK
	 NwGF1E59x7lmWOajzyqNlA5axcK0ylVgHF4bSFG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4.19 104/138] PCI: Fix use-after-free of slot->bus on hot remove
Date: Tue,  3 Dec 2024 15:32:13 +0100
Message-ID: <20241203141927.543892041@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit c7acef99642b763ba585f4a43af999fcdbcc3dc4 upstream.

Dennis reports a boot crash on recent Lenovo laptops with a USB4 dock.

Since commit 0fc70886569c ("thunderbolt: Reset USB4 v2 host router") and
commit 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot
firmware"), USB4 v2 and v1 Host Routers are reset on probe of the
thunderbolt driver.

The reset clears the Presence Detect State and Data Link Layer Link Active
bits at the USB4 Host Router's Root Port and thus causes hot removal of the
dock.

The crash occurs when pciehp is unbound from one of the dock's Downstream
Ports:  pciehp creates a pci_slot on bind and destroys it on unbind.  The
pci_slot contains a pointer to the pci_bus below the Downstream Port, but
a reference on that pci_bus is never acquired.  The pci_bus is destroyed
before the pci_slot, so a use-after-free ensues when pci_slot_release()
accesses slot->bus.

In principle this should not happen because pci_stop_bus_device() unbinds
pciehp (and therefore destroys the pci_slot) before the pci_bus is
destroyed by pci_remove_bus_device().

However the stacktrace provided by Dennis shows that pciehp is unbound from
pci_remove_bus_device() instead of pci_stop_bus_device().  To understand
the significance of this, one needs to know that the PCI core uses a two
step process to remove a portion of the hierarchy:  It first unbinds all
drivers in the sub-hierarchy in pci_stop_bus_device() and then actually
removes the devices in pci_remove_bus_device().  There is no precaution to
prevent driver binding in-between pci_stop_bus_device() and
pci_remove_bus_device().

In Dennis' case, it seems removal of the hierarchy by pciehp races with
driver binding by pci_bus_add_devices().  pciehp is bound to the
Downstream Port after pci_stop_bus_device() has run, so it is unbound by
pci_remove_bus_device() instead of pci_stop_bus_device().  Because the
pci_bus has already been destroyed at that point, accesses to it result in
a use-after-free.

One might conclude that driver binding needs to be prevented after
pci_stop_bus_device() has run.  However it seems risky that pci_slot points
to pci_bus without holding a reference.  Solely relying on correct ordering
of driver unbind versus pci_bus destruction is certainly not defensive
programming.

If pci_slot has a need to access data in pci_bus, it ought to acquire a
reference.  Amend pci_create_slot() accordingly.  Dennis reports that the
crash is not reproducible with this change.

Abridged stacktrace:

  pcieport 0000:00:07.0: PME: Signaling with IRQ 156
  pcieport 0000:00:07.0: pciehp: Slot #12 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
  pci_bus 0000:20: dev 00, created physical slot 12
  pcieport 0000:00:07.0: pciehp: Slot(12): Card not present
  ...
  pcieport 0000:21:02.0: pciehp: pcie_disable_notification: SLOTCTRL d8 write cmd 0
  Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 13 UID: 0 PID: 134 Comm: irq/156-pciehp Not tainted 6.11.0-devel+ #1
  RIP: 0010:dev_driver_string+0x12/0x40
  pci_destroy_slot
  pciehp_remove
  pcie_port_remove_service
  device_release_driver_internal
  bus_remove_device
  device_del
  device_unregister
  remove_iter
  device_for_each_child
  pcie_portdrv_remove
  pci_device_remove
  device_release_driver_internal
  bus_remove_device
  device_del
  pci_remove_bus_device (recursive invocation)
  pci_remove_bus_device
  pciehp_unconfigure_device
  pciehp_disable_slot
  pciehp_handle_presence_or_link_change
  pciehp_ist

Link: https://lore.kernel.org/r/4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de
Reported-by: Dennis Wassenberg <Dennis.Wassenberg@secunet.com>
Closes: https://lore.kernel.org/r/6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com/
Tested-by: Dennis Wassenberg <Dennis.Wassenberg@secunet.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/slot.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -115,6 +115,7 @@ static void pci_slot_release(struct kobj
 	up_read(&pci_bus_sem);
 
 	list_del(&slot->list);
+	pci_bus_put(slot->bus);
 
 	kfree(slot);
 }
@@ -296,7 +297,7 @@ placeholder:
 		goto err;
 	}
 
-	slot->bus = parent;
+	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
 	slot->kobj.kset = pci_slots_kset;
@@ -304,6 +305,7 @@ placeholder:
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		pci_bus_put(slot->bus);
 		kfree(slot);
 		goto err;
 	}



