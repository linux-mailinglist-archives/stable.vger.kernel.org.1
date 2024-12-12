Return-Path: <stable+bounces-102844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD59EF601
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE21F177227
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DE223E9C;
	Thu, 12 Dec 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7FQu+42"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D7223E93;
	Thu, 12 Dec 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022700; cv=none; b=t/2HItymTSDMlz/O9yx4P9AWBLiwiEI93V3/ON3HzDodT62PRE9ljUC5Q6qxhzP8HmuKokYBcYISrXQ+8qhIaTcShMrwleL9ZuU4pc08ceAryxmRchoEZNg8eKeCHBAlUD/zsVDJR6HZFUZDn0wpwbLxRBWv5wxa2vbhb43QqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022700; c=relaxed/simple;
	bh=DbOwH0lGa1bmKvDsA5h7kZuqCrOg1fChLS3Rm08y84s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLym16aRpoWAYLDO0k+32LeQkemA05GbO8wJC+uo1jID7HhpTZnnz3mhHCzaRiaMNPkO8NMMRpoY0Sokc3Ng3eGZlo/ab1Ss8AdLol0uUM93ZtnMIo4lcC7BAw4n8uKaTS6b4r/i6jjX8XvREDTItvtCzZj2XXSvRmRS7c0Yih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7FQu+42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2DAC4CECE;
	Thu, 12 Dec 2024 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022699;
	bh=DbOwH0lGa1bmKvDsA5h7kZuqCrOg1fChLS3Rm08y84s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7FQu+42Dt7Ng9QKXd3P1Pxdva2bDV8Q/hUiX0wJvq7f04nFHPyzliyKBS8wmrI9a
	 5BjEGL0+2Z0A5njP8cclGsHawihbYpDDz5g5Cb96BMP+DWOXHqplz1RA0T5Uwv0GKf
	 +J4jc0XCyf/yexuNmtjp6cm8Vcb40twNdCwRXS/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.15 312/565] PCI: Fix use-after-free of slot->bus on hot remove
Date: Thu, 12 Dec 2024 15:58:27 +0100
Message-ID: <20241212144323.938750349@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -79,6 +79,7 @@ static void pci_slot_release(struct kobj
 	up_read(&pci_bus_sem);
 
 	list_del(&slot->list);
+	pci_bus_put(slot->bus);
 
 	kfree(slot);
 }
@@ -260,7 +261,7 @@ placeholder:
 		goto err;
 	}
 
-	slot->bus = parent;
+	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
 	slot->kobj.kset = pci_slots_kset;
@@ -268,6 +269,7 @@ placeholder:
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		pci_bus_put(slot->bus);
 		kfree(slot);
 		goto err;
 	}



