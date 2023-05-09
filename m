Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99036FC735
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjEIM4a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEIM43 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:56:29 -0400
X-Greylist: delayed 8061 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 05:56:28 PDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF51EA
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:56:27 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 78E7A1002E5AF;
        Tue,  9 May 2023 14:56:26 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 5414D603E119;
        Tue,  9 May 2023 14:56:26 +0200 (CEST)
X-Mailbox-Line: From 8017b674a87ae89a0577f008d7cef15e002b88d1 Mon Sep 17 00:00:00 2001
Message-Id: <8017b674a87ae89a0577f008d7cef15e002b88d1.1683636753.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 9 May 2023 14:55:09 +0200
Subject: [PATCH 4.19.y 1/2] PCI: pciehp: Use
 down_read/write_nested(reset_lock) to fix lockdep errors
To:     stable@vger.kernel.org
Cc:     Anatoli.Antonovitch@amd.com, alex.williamson@redhat.com,
        amichon@kalrayinc.com, andrey2805@gmail.com, ashok.raj@intel.com,
        bhelgaas@google.com, dstein@hpe.com, ian.may@canonical.com,
        michael.haeuptle@hpe.com, mika.westerberg@linux.intel.com,
        rahul.kumar1@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        wangxiongfeng2@huawei.com, zhangjialin11@huawei.com,
        hdegoede@redhat.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 085a9f43433f30cbe8a1ade62d9d7827c3217f4d upstream.

Use down_read_nested() and down_write_nested() when taking the
ctrl->reset_lock rw-sem, passing the number of PCIe hotplug controllers in
the path to the PCI root bus as lock subclass parameter.

This fixes the following false-positive lockdep report when unplugging a
Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:

  pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
  pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
  ============================================
  WARNING: possible recursive locking detected
  5.16.0-rc2+ #621 Not tainted
  --------------------------------------------
  irq/124-pciehp/86 is trying to acquire lock:
  ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80

  but task is already holding lock:
  ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180

   other info that might help us debug this:
   Possible unsafe locking scenario:

	 CPU0
	 ----
    lock(&ctrl->reset_lock);
    lock(&ctrl->reset_lock);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  3 locks held by irq/124-pciehp/86:
   #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
   #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
   #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40

  stack backtrace:
  CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
  Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
  Call Trace:
   <TASK>
   dump_stack_lvl+0x59/0x73
   __lock_acquire.cold+0xc5/0x2c6
   lock_acquire+0xb5/0x2b0
   down_read+0x3e/0x50
   pciehp_check_presence+0x23/0x80
   pciehp_runtime_resume+0x5c/0xa0
   device_for_each_child+0x45/0x70
   pcie_port_device_runtime_resume+0x20/0x30
   pci_pm_runtime_resume+0xa7/0xc0
   __rpm_callback+0x41/0x110
   rpm_callback+0x59/0x70
   rpm_resume+0x512/0x7b0
   __pm_runtime_resume+0x4a/0x90
   __device_release_driver+0x28/0x240
   device_release_driver+0x26/0x40
   pci_stop_bus_device+0x68/0x90
   pci_stop_bus_device+0x2c/0x90
   pci_stop_and_remove_bus_device+0xe/0x20
   pciehp_unconfigure_device+0x6c/0x110
   pciehp_disable_slot+0x5b/0xe0
   pciehp_handle_presence_or_link_change+0xc3/0x2f0
   pciehp_ist+0x179/0x180

This lockdep warning is triggered because with Thunderbolt, hotplug ports
are nested. When removing multiple devices in a daisy-chain, each hotplug
port's reset_lock may be acquired recursively. It's never the same lock, so
the lockdep splat is a false positive.

Because locks at the same hierarchy level are never acquired recursively, a
per-level lockdep class is sufficient to fix the lockdep warning.

The choice to use one lockdep subclass per pcie-hotplug controller in the
path to the root-bus was made to conserve class keys because their number
is limited and the complexity grows quadratically with number of keys
according to Documentation/locking/lockdep-design.rst.

Link: https://lore.kernel.org/linux-pci/20190402021933.GA2966@mit.edu/
Link: https://lore.kernel.org/linux-pci/de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com/
Link: https://lore.kernel.org/r/20211217141709.379663-1-hdegoede@redhat.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208855
Reported-by: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
[lukas: backport to v4.19-stable]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  3 +++
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 19 +++++++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ef6071807072..522719ca1c2b 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -84,6 +84,8 @@ struct slot {
  * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
  *	Link Status register and to the Presence Detect State bit in the Slot
  *	Status register during a slot reset which may cause them to flap
+ * @depth: Number of additional hotplug ports in the path to the root bus,
+ *	used as lock subclass for @reset_lock
  * @slot: pointer to the controller's slot structure
  * @queue: wait queue to wake up on reception of a Command Completed event,
  *	used for synchronous writes to the Slot Control register
@@ -115,6 +117,7 @@ struct controller {
 	struct mutex ctrl_lock;
 	struct pcie_device *pcie;
 	struct rw_semaphore reset_lock;
+	unsigned int depth;
 	struct slot *slot;
 	wait_queue_head_t queue;
 	u32 slot_cap;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 518c46f8e63b..5ebfff9356c7 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -215,7 +215,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 	struct slot *slot = ctrl->slot;
 	u8 occupied;
 
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	mutex_lock(&slot->lock);
 
 	pciehp_get_adapter_status(slot, &occupied);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 2795445233b3..7392b26e9f15 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -674,7 +674,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(slot);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
@@ -785,7 +785,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
+	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
@@ -872,6 +872,20 @@ static inline void dbg_ctrl(struct controller *ctrl)
 
 #define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
 
+static inline int pcie_hotplug_depth(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int depth = 0;
+
+	while (bus->parent) {
+		bus = bus->parent;
+		if (bus->self && bus->self->is_hotplug_bridge)
+			depth++;
+	}
+
+	return depth;
+}
+
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
@@ -884,6 +898,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		goto abort;
 
 	ctrl->pcie = dev;
+	ctrl->depth = pcie_hotplug_depth(dev->port);
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
-- 
2.39.2

