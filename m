Return-Path: <stable+bounces-154252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B998ADD979
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0904819E7B70
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31922E264E;
	Tue, 17 Jun 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="beR46hKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1F1E3DCF;
	Tue, 17 Jun 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178591; cv=none; b=nVMeVl6kiSuNFz0ZJdpjqSNeUHvHaIIJODzX3+5V7KGAv2OiXbJlNk4DnN7nih/oM6zJn99tDywutbFcxwk44X+RpI6oALSoDGC1ymtyeKYmK274U4nCanAHs+ErMDkWPi47HGsx6SJLXds7Wotffhexavk6W3+SksC/5EGsQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178591; c=relaxed/simple;
	bh=G4sLLsK4YVM7ZMu2jIeRnI+n+43d3HLniA9EnAQ4V2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdp+TQeV5mfS2YnSxzoeQWvVLyVENAz63rPz5nHyuV3i5Enka44CHBZ9xpcyDVP+2T0VJVmBZvXnKcAimE5ty/f33ZiSfkmtuUZz/pnFjJxrXrvG5tIsKwMamGZLAkQ5zcIGIyJmsrfCekJx2cEUOk3Hpcc4wNfzw08xsSbCEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=beR46hKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02954C4CEE3;
	Tue, 17 Jun 2025 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178591;
	bh=G4sLLsK4YVM7ZMu2jIeRnI+n+43d3HLniA9EnAQ4V2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beR46hKrlAzzs8f0KeRQVliu2FmLcEtTj+JfFIB5Ua85QAwP4Y2yQ2c2TqVcMo374
	 oqt8lU4UYxcI85GJOFfxCDQqhy8QK/X2JxFqo1SZcytcC5UK45lbw4dZPg4nelXhxu
	 67lNfZ4hrMYB7cJjSW4eIipa9efN906xOXy8jpS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 494/780] PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
Date: Tue, 17 Jun 2025 17:23:22 +0200
Message-ID: <20250617152511.604362479@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 2af781a9edc4ef5f6684c0710cc3542d9be48b31 ]

When a Secondary Bus Reset is issued at a hotplug port, it causes a Data
Link Layer State Changed event as a side effect.  On hotplug ports using
in-band presence detect, it additionally causes a Presence Detect Changed
event.

These spurious events should not result in teardown and re-enumeration of
the device in the slot.  Hence commit 2e35afaefe64 ("PCI: pciehp: Add
reset_slot() method") masked the Presence Detect Changed Enable bit in the
Slot Control register during a Secondary Bus Reset.  Commit 06a8d89af551
("PCI: pciehp: Disable link notification across slot reset") additionally
masked the Data Link Layer State Changed Enable bit.

However masking those bits only disables interrupt generation (PCIe r6.2
sec 6.7.3.1).  The events are still visible in the Slot Status register
and picked up by the IRQ handler if it runs during a Secondary Bus Reset.
This can happen if the interrupt is shared or if an unmasked hotplug event
occurs, e.g. Attention Button Pressed or Power Fault Detected.

The likelihood of this happening used to be small, so it wasn't much of a
problem in practice.  That has changed with the recent introduction of
bandwidth control in v6.13-rc1 with commit 665745f27487 ("PCI/bwctrl:
Re-add BW notification portdrv as PCIe BW controller"):

Bandwidth control shares the interrupt with PCIe hotplug.  A Secondary Bus
Reset causes a Link Bandwidth Notification, so the hotplug IRQ handler
runs, picks up the masked events and tears down the device in the slot.

As a result, Joel reports VFIO passthrough failure of a GPU, which Ilpo
root-caused to the incorrect handling of masked hotplug events.

Clearly, a more reliable way is needed to ignore spurious hotplug events.

For Downstream Port Containment, a new ignore mechanism was introduced by
commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").
It has been working reliably for the past four years.

Adapt it for Secondary Bus Resets.

Introduce two helpers to annotate code sections which cause spurious link
changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
Use those helpers in lieu of masking interrupts in the Slot Control
register.

Introduce a helper to check whether such a code section is executing
concurrently and if so, await it:  pci_hp_spurious_link_change()
Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
IRQ thread's existing code which ignores DPC-induced link changes unless
the link is unexpectedly down after reset recovery or the device was
replaced during the bus reset.

That code block in pciehp_ist() was previously only executed if a Data
Link Layer State Changed event has occurred.  Additionally execute it for
Presence Detect Changed events.  That's necessary for compatibility with
PCIe r1.0 hotplug ports because Data Link Layer State Changed didn't exist
before PCIe r1.1.  DPC was added with PCIe r3.1 and thus DPC-capable
hotplug ports always support Data Link Layer State Changed events.
But the same cannot be assumed for Secondary Bus Reset, which already
existed in PCIe r1.0.

Secondary Bus Reset is only one of many causes of spurious link changes.
Others include runtime suspend to D3cold, firmware updates or FPGA
reconfiguration.  The new pci_hp_{,un}ignore_link_change() helpers may be
used by all kinds of drivers to annotate such code sections, hence their
declarations are publicly visible in <linux/pci.h>.  A case in point is
the Mellanox Ethernet driver which disables a firmware reset feature if
the Ethernet card is attached to a hotplug port, see commit 3d7a3f2612d7
("net/mlx5: Nack sync reset request when HotPlug is enabled").  Going
forward, PCIe hotplug will be able to cope gracefully with all such use
cases once the code sections are properly annotated.

The new helpers internally use two bits in struct pci_dev's priv_flags as
well as a wait_queue.  This mirrors what was done for DPC by commit
a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").  That may
be insufficient if spurious link changes are caused by multiple sources
simultaneously.  An example might be a Secondary Bus Reset issued by AER
during FPGA reconfiguration.  If this turns out to happen in real life,
support for it can easily be added by replacing the PCI_LINK_CHANGING flag
with an atomic_t counter incremented by pci_hp_ignore_link_change() and
decremented by pci_hp_unignore_link_change().  Instead of awaiting a zero
PCI_LINK_CHANGING flag, the pci_hp_spurious_link_change() helper would
then simply await a zero counter.

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 69 ++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c       | 35 +++++--------
 drivers/pci/pci.h                      |  3 ++
 include/linux/pci.h                    |  8 +++
 4 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d30f1316c98e2..d7fc3bc039643 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -492,6 +492,75 @@ void pci_hp_destroy(struct hotplug_slot *slot)
 }
 EXPORT_SYMBOL_GPL(pci_hp_destroy);
 
+static DECLARE_WAIT_QUEUE_HEAD(pci_hp_link_change_wq);
+
+/**
+ * pci_hp_ignore_link_change - begin code section causing spurious link changes
+ * @pdev: PCI hotplug bridge
+ *
+ * Mark the beginning of a code section causing spurious link changes on the
+ * Secondary Bus of @pdev, e.g. as a side effect of a Secondary Bus Reset,
+ * D3cold transition, firmware update or FPGA reconfiguration.
+ *
+ * Hotplug drivers can thus check whether such a code section is executing
+ * concurrently, await it with pci_hp_spurious_link_change() and ignore the
+ * resulting link change events.
+ *
+ * Must be paired with pci_hp_unignore_link_change().  May be called both
+ * from the PCI core and from Endpoint drivers.  May be called for bridges
+ * which are not hotplug-capable, in which case it has no effect because
+ * no hotplug driver is bound to the bridge.
+ */
+void pci_hp_ignore_link_change(struct pci_dev *pdev)
+{
+	set_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
+	smp_mb__after_atomic(); /* pairs with implied barrier of wait_event() */
+}
+
+/**
+ * pci_hp_unignore_link_change - end code section causing spurious link changes
+ * @pdev: PCI hotplug bridge
+ *
+ * Mark the end of a code section causing spurious link changes on the
+ * Secondary Bus of @pdev.  Must be paired with pci_hp_ignore_link_change().
+ */
+void pci_hp_unignore_link_change(struct pci_dev *pdev)
+{
+	set_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
+	mb(); /* ensure pci_hp_spurious_link_change() sees either bit set */
+	clear_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
+	wake_up_all(&pci_hp_link_change_wq);
+}
+
+/**
+ * pci_hp_spurious_link_change - check for spurious link changes
+ * @pdev: PCI hotplug bridge
+ *
+ * Check whether a code section is executing concurrently which is causing
+ * spurious link changes on the Secondary Bus of @pdev.  Await the end of the
+ * code section if so.
+ *
+ * May be called by hotplug drivers to check whether a link change is spurious
+ * and can be ignored.
+ *
+ * Because a genuine link change may have occurred in-between a spurious link
+ * change and the invocation of this function, hotplug drivers should perform
+ * sanity checks such as retrieving the current link state and bringing down
+ * the slot if the link is down.
+ *
+ * Return: %true if such a code section has been executing concurrently,
+ * otherwise %false.  Also return %true if such a code section has not been
+ * executing concurrently, but at least once since the last invocation of this
+ * function.
+ */
+bool pci_hp_spurious_link_change(struct pci_dev *pdev)
+{
+	wait_event(pci_hp_link_change_wq,
+		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
+
+	return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
+}
+
 static int __init pci_hotplug_init(void)
 {
 	int result;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 388fbed25402b..ebd342bda235d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -592,21 +592,21 @@ bool pciehp_device_replaced(struct controller *ctrl)
 	return false;
 }
 
-static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
-					  struct pci_dev *pdev, int irq,
-					  u16 ignored_events)
+static void pciehp_ignore_link_change(struct controller *ctrl,
+				      struct pci_dev *pdev, int irq,
+				      u16 ignored_events)
 {
 	/*
 	 * Ignore link changes which occurred while waiting for DPC recovery.
 	 * Could be several if DPC triggered multiple times consecutively.
+	 * Also ignore link changes caused by Secondary Bus Reset, etc.
 	 */
 	synchronize_hardirq(irq);
 	atomic_and(~ignored_events, &ctrl->pending_events);
 	if (pciehp_poll_mode)
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 					   ignored_events);
-	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
-		  slot_name(ctrl));
+	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored\n", slot_name(ctrl));
 
 	/*
 	 * If the link is unexpectedly down after successful recovery,
@@ -762,9 +762,11 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 
 	/*
 	 * Ignore Link Down/Up events caused by Downstream Port Containment
-	 * if recovery from the error succeeded.
+	 * if recovery succeeded, or caused by Secondary Bus Reset,
+	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
 	 */
-	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
+	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
 	    ctrl->state == ON_STATE) {
 		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
 
@@ -772,7 +774,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
 
 		events &= ~ignored_events;
-		pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
+		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
 	}
 
 	/*
@@ -937,7 +939,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
 	if (probe)
@@ -945,23 +946,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 
 	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
-	if (!ATTN_BUTTN(ctrl)) {
-		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
-		stat_mask |= PCI_EXP_SLTSTA_PDC;
-	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
-	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
-
-	pcie_write_cmd(ctrl, 0, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	pci_hp_ignore_link_change(pdev);
 
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
-	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
+	pci_hp_unignore_link_change(pdev);
 
 	up_write(&ctrl->reset_lock);
 	return rc;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62a..7db798bdcaaae 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -227,6 +227,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
+bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
 void pci_create_legacy_files(struct pci_bus *bus);
@@ -557,6 +558,8 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
 #define PCI_DEV_REMOVED 3
+#define PCI_LINK_CHANGED 4
+#define PCI_LINK_CHANGING 5
 
 static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cda..081e5c0a3ddf4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1850,6 +1850,14 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI
+void pci_hp_ignore_link_change(struct pci_dev *pdev);
+void pci_hp_unignore_link_change(struct pci_dev *pdev);
+#else
+static inline void pci_hp_ignore_link_change(struct pci_dev *pdev) { }
+static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
 #else
-- 
2.39.5




