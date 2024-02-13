Return-Path: <stable+bounces-20070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0088538B1
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE71C26504
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206860240;
	Tue, 13 Feb 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wDQjiCqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F1E502;
	Tue, 13 Feb 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845974; cv=none; b=o9fIava3P78Ci7QXy7qe6nuH9DVDJcjM1puGClU1fqBS9yzKxLXhOoE3LaHu/N16vNGTNJrJvsDDyY5i4fVnyOIzxhBvZgpxZQAI0PsNxjvjvn5OQ/rqMcPRuDgHdwn/POYZ2UNq8jCO+oRUKU3cFPyj/Mg26fSCuZgMnjsZ458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845974; c=relaxed/simple;
	bh=+pGLEYNk5+jtr6goBQ2kPtSCYWeUZN/eEZ3DXMH72UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B76mUdf60+PzMdk9xLmDRcXb58a+TG4bj6bqfkihNzxp31tYh2RsqWMtlvt4c/qGfqvRxoBPHfca6GnobKf/KTDGzoUbD++bm6sgNBfWHrJJf39gL9nvOJzTwzHpTT5Awio9AiBn5MiQzJErLXoM4z2XXjICtJOnPC3t058PJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wDQjiCqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9DBC433F1;
	Tue, 13 Feb 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845974;
	bh=+pGLEYNk5+jtr6goBQ2kPtSCYWeUZN/eEZ3DXMH72UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wDQjiCqJtwWq07zBUqpmNgkAZdHd10S/YldTYPf8b/knNfwMp/8vvOSW4MKUCOybj
	 WKQGTFdF7pIqRVQIUHQgfcjNMCmiI3Dj58saqJEW0lHAXfj0XrvWVUA8djTQ6ZF/WY
	 T9wKEBVghUPrZdwNfUzUiafz27WVKTcsugho+Aes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.7 109/124] PCI/ASPM: Fix deadlock when enabling ASPM
Date: Tue, 13 Feb 2024 18:22:11 +0100
Message-ID: <20240213171856.915220041@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 1e560864159d002b453da42bd2c13a1805515a20 upstream.

A last minute revert in 6.7-final introduced a potential deadlock when
enabling ASPM during probe of Qualcomm PCIe controllers as reported by
lockdep:

  ============================================
  WARNING: possible recursive locking detected
  6.7.0 #40 Not tainted
  --------------------------------------------
  kworker/u16:5/90 is trying to acquire lock:
  ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pcie_aspm_pm_state_change+0x58/0xdc

              but task is already holding lock:
  ffffacfa78ced000 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc

              other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(pci_bus_sem);
    lock(pci_bus_sem);

               *** DEADLOCK ***

  Call trace:
   print_deadlock_bug+0x25c/0x348
   __lock_acquire+0x10a4/0x2064
   lock_acquire+0x1e8/0x318
   down_read+0x60/0x184
   pcie_aspm_pm_state_change+0x58/0xdc
   pci_set_full_power_state+0xa8/0x114
   pci_set_power_state+0xc4/0x120
   qcom_pcie_enable_aspm+0x1c/0x3c [pcie_qcom]
   pci_walk_bus+0x64/0xbc
   qcom_pcie_host_post_init_2_7_0+0x28/0x34 [pcie_qcom]

The deadlock can easily be reproduced on machines like the Lenovo ThinkPad
X13s by adding a delay to increase the race window during asynchronous
probe where another thread can take a write lock.

Add a new pci_set_power_state_locked() and associated helper functions that
can be called with the PCI bus semaphore held to avoid taking the read lock
twice.

Link: https://lore.kernel.org/r/ZZu0qx2cmn7IwTyQ@hovoldconsulting.com
Link: https://lore.kernel.org/r/20240130100243.11011-1-johan+linaro@kernel.org
Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>	# 6.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/bus.c                      |   49 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-qcom.c |    2 
 drivers/pci/pci.c                      |   78 ++++++++++++++++++++++-----------
 drivers/pci/pci.h                      |    4 -
 drivers/pci/pcie/aspm.c                |   13 +++--
 include/linux/pci.h                    |    5 ++
 6 files changed, 101 insertions(+), 50 deletions(-)

--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -386,21 +386,8 @@ void pci_bus_add_devices(const struct pc
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
 
-/** pci_walk_bus - walk devices on/under bus, calling callback.
- *  @top      bus whose devices should be walked
- *  @cb       callback to be called for each device found
- *  @userdata arbitrary pointer to be passed to callback.
- *
- *  Walk the given bus, including any bridged devices
- *  on buses under this bus.  Call the provided callback
- *  on each device found.
- *
- *  We check the return of @cb each time. If it returns anything
- *  other than 0, we break out.
- *
- */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			   void *userdata, bool locked)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -408,7 +395,8 @@ void pci_walk_bus(struct pci_bus *top, i
 	int retval;
 
 	bus = top;
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -431,10 +419,37 @@ void pci_walk_bus(struct pci_bus *top, i
 		if (retval)
 			break;
 	}
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
+}
+
+/**
+ *  pci_walk_bus - walk devices on/under bus, calling callback.
+ *  @top: bus whose devices should be walked
+ *  @cb: callback to be called for each device found
+ *  @userdata: arbitrary pointer to be passed to callback
+ *
+ *  Walk the given bus, including any bridged devices
+ *  on buses under this bus.  Call the provided callback
+ *  on each device found.
+ *
+ *  We check the return of @cb each time. If it returns anything
+ *  other than 0, we break out.
+ */
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	__pci_walk_bus(top, cb, userdata, false);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	__pci_walk_bus(top, cb, userdata, true);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
+
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
 	if (bus)
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -972,7 +972,7 @@ static int qcom_pcie_enable_aspm(struct
 	 * Downstream devices need to be in D0 state before enabling PCI PM
 	 * substates.
 	 */
-	pci_set_power_state(pdev, PCI_D0);
+	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1291,6 +1291,7 @@ end:
 /**
  * pci_set_full_power_state - Put a PCI device into D0 and update its state
  * @dev: PCI device to power up
+ * @locked: whether pci_bus_sem is held
  *
  * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
  * to confirm the state change, restore its BARs if they might be lost and
@@ -1300,7 +1301,7 @@ end:
  * to D0, it is more efficient to use pci_power_up() directly instead of this
  * function.
  */
-static int pci_set_full_power_state(struct pci_dev *dev)
+static int pci_set_full_power_state(struct pci_dev *dev, bool locked)
 {
 	u16 pmcsr;
 	int ret;
@@ -1336,7 +1337,7 @@ static int pci_set_full_power_state(stru
 	}
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
@@ -1365,10 +1366,22 @@ void pci_bus_set_current_state(struct pc
 		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
 }
 
+static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state, bool locked)
+{
+	if (!bus)
+		return;
+
+	if (locked)
+		pci_walk_bus_locked(bus, __pci_dev_set_current_state, &state);
+	else
+		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
+}
+
 /**
  * pci_set_low_power_state - Put a PCI device into a low-power state.
  * @dev: PCI device to handle.
  * @state: PCI power state (D1, D2, D3hot) to put the device into.
+ * @locked: whether pci_bus_sem is held
  *
  * Use the device's PCI_PM_CTRL register to put it into a low-power state.
  *
@@ -1379,7 +1392,7 @@ void pci_bus_set_current_state(struct pc
  * 0 if device already is in the requested state.
  * 0 if device's power state has been successfully changed.
  */
-static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	u16 pmcsr;
 
@@ -1433,29 +1446,12 @@ static int pci_set_low_power_state(struc
 				     pci_power_name(state));
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
 
-/**
- * pci_set_power_state - Set the power state of a PCI device
- * @dev: PCI device to handle.
- * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
- *
- * Transition a device to a new power state, using the platform firmware and/or
- * the device's PCI PM registers.
- *
- * RETURN VALUE:
- * -EINVAL if the requested state is invalid.
- * -EIO if device does not support PCI PM or its PM capabilities register has a
- * wrong version, or device doesn't support the requested state.
- * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
- * 0 if device already is in the requested state.
- * 0 if the transition is to D3 but D3 is not supported.
- * 0 if device's power state has been successfully changed.
- */
-int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int __pci_set_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	int error;
 
@@ -1479,7 +1475,7 @@ int pci_set_power_state(struct pci_dev *
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_set_full_power_state(dev);
+		return pci_set_full_power_state(dev, locked);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
@@ -1493,16 +1489,16 @@ int pci_set_power_state(struct pci_dev *
 		 * To put the device in D3cold, put it into D3hot in the native
 		 * way, then put it into D3cold using platform ops.
 		 */
-		error = pci_set_low_power_state(dev, PCI_D3hot);
+		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
 
 		if (pci_platform_power_transition(dev, PCI_D3cold))
 			return error;
 
 		/* Powering off a bridge may power off the whole hierarchy */
 		if (dev->current_state == PCI_D3cold)
-			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+			__pci_bus_set_current_state(dev->subordinate, PCI_D3cold, locked);
 	} else {
-		error = pci_set_low_power_state(dev, state);
+		error = pci_set_low_power_state(dev, state, locked);
 
 		if (pci_platform_power_transition(dev, state))
 			return error;
@@ -1510,8 +1506,38 @@ int pci_set_power_state(struct pci_dev *
 
 	return 0;
 }
+
+/**
+ * pci_set_power_state - Set the power state of a PCI device
+ * @dev: PCI device to handle.
+ * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ *
+ * Transition a device to a new power state, using the platform firmware and/or
+ * the device's PCI PM registers.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
+ * 0 if device already is in the requested state.
+ * 0 if the transition is to D3 but D3 is not supported.
+ * 0 if device's power state has been successfully changed.
+ */
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	return __pci_set_power_state(dev, state, false);
+}
 EXPORT_SYMBOL(pci_set_power_state);
 
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	return __pci_set_power_state(dev, state, true);
+}
+EXPORT_SYMBOL(pci_set_power_state_locked);
+
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -569,12 +569,12 @@ int pcie_retrain_link(struct pci_dev *pd
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1008,8 +1008,11 @@ void pcie_aspm_exit_link_state(struct pc
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+/*
+ * @pdev: the root port or switch downstream port
+ * @locked: whether pci_bus_sem is held
+ */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
 {
 	struct pcie_link_state *link = pdev->link_state;
 
@@ -1019,12 +1022,14 @@ void pcie_aspm_pm_state_change(struct pc
 	 * Devices changed PM state, we should recheck if latency
 	 * meets all functions' requirement
 	 */
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	pcie_update_aspm_capable(link->root);
 	pcie_config_aspm_path(link);
 	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
 }
 
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1417,6 +1417,7 @@ int pci_load_and_free_saved_state(struct
 				  struct pci_saved_state **state);
 int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
@@ -1620,6 +1621,8 @@ int pci_scan_bridge(struct pci_bus *bus,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			 void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
@@ -2019,6 +2022,8 @@ static inline int pci_save_state(struct
 static inline void pci_restore_state(struct pci_dev *dev) { }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
+static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,



