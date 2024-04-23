Return-Path: <stable+bounces-40764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55538AF80D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 22:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FE9B21BC4
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78D14198A;
	Tue, 23 Apr 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AccLvEu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26E1F95E
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904581; cv=none; b=ZcQnjaKxHpuJ/hcYPiKzCTwQUH/ybnQgMAVz0r1Fsl8IAJIrYB4w+bAcjAc3YborVxH8c2gPAOOPbcI5Z5HNWUawJCFFUDAbFneELV5/JbCecHJ2sFuidozpQ/pJ7porVYYMtBSHxLTb9ovEmv9rUkVqSZm6n/y23NyQpYbfV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904581; c=relaxed/simple;
	bh=y8E9yAVYPm115SXNsPNii4IEfKzRkCHVvUcPHD3W8uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isjAgTXVQj444LcLl+tjFWqaQXsxpATc2iDSyWT48iI2fz7UwBTdgNKRiSTBuJH0eamKzWQfg7EGGC2TLf4ZZRiMNkmvon9On0wcgwksgSHUuzF7yLlWaJV+NHn3OIxxLe/Ou+3NohULHtU+UBdQsIYRupBBWdIB6iYc3JjeUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AccLvEu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3645C116B1;
	Tue, 23 Apr 2024 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713904581;
	bh=y8E9yAVYPm115SXNsPNii4IEfKzRkCHVvUcPHD3W8uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AccLvEu4WiDQtkXwjOz4JW4lN/AQXEPgwWxncr9M9gfQEPXel4+ejt9bfL5nzMhgM
	 UzyXHcWIq3FbVwU+4d0tKYs3/0mcIwCzENtV+mKKQQUK784gbymN6Trl3n8Yi+YsZz
	 KRvZprDs27CN1OdRhidSypXjFYQ0ebaVg7PSbh6IhNPbXJWBuIQe5f6nAQKpxUTkQ/
	 3ijuqW9WQuMA7dxv+npCGHDdW8Q0SE5DTuYBXcW+DITYjvQGY3UzTXHE8qXxOm4vUE
	 yuxTlOR3ZoyGEjmWEj/udQXHhQFRdoL9+Mw4OvefAay1lX0W1RXlLQGPR9tM6NTH0/
	 GuYJlZi1xy1mA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.6.y] PCI/ASPM: Fix deadlock when enabling ASPM
Date: Tue, 23 Apr 2024 15:36:11 -0500
Message-Id: <20240423203611.463084-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024021328-stylus-ooze-f752@gregkh>
References: <2024021328-stylus-ooze-f752@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[bhelgaas: backported to v6.6.y, which contains 8cc22ba3f77c ("Revert
"PCI/ASPM: Remove pcie_aspm_pm_state_change()""), a backport of
f93e71aea6c6.  This omits the drivers/pci/controller/dwc/pcie-qcom.c hunk
that updates qcom_pcie_enable_aspm(), which was added by 9f4f3dfad8cf
("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops"), which is not
present in v6.6.28.]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c       | 49 +++++++++++++++++---------
 drivers/pci/pci.c       | 78 +++++++++++++++++++++++++++--------------
 drivers/pci/pci.h       |  4 +--
 drivers/pci/pcie/aspm.c | 13 ++++---
 include/linux/pci.h     |  5 +++
 5 files changed, 100 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9c2137dae429..826b5016a101 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -386,21 +386,8 @@ void pci_bus_add_devices(const struct pci_bus *bus)
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
@@ -408,7 +395,8 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 	int retval;
 
 	bus = top;
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -431,10 +419,37 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 06fc6f532d6c..dddd30deea32 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1291,6 +1291,7 @@ int pci_power_up(struct pci_dev *dev)
 /**
  * pci_set_full_power_state - Put a PCI device into D0 and update its state
  * @dev: PCI device to power up
+ * @locked: whether pci_bus_sem is held
  *
  * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
  * to confirm the state change, restore its BARs if they might be lost and
@@ -1300,7 +1301,7 @@ int pci_power_up(struct pci_dev *dev)
  * to D0, it is more efficient to use pci_power_up() directly instead of this
  * function.
  */
-static int pci_set_full_power_state(struct pci_dev *dev)
+static int pci_set_full_power_state(struct pci_dev *dev, bool locked)
 {
 	u16 pmcsr;
 	int ret;
@@ -1336,7 +1337,7 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 	}
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
@@ -1365,10 +1366,22 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
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
@@ -1379,7 +1392,7 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
  * 0 if device already is in the requested state.
  * 0 if device's power state has been successfully changed.
  */
-static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	u16 pmcsr;
 
@@ -1433,29 +1446,12 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
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
 
@@ -1479,7 +1475,7 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_set_full_power_state(dev);
+		return pci_set_full_power_state(dev, locked);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
@@ -1493,16 +1489,16 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
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
@@ -1510,8 +1506,38 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1b4f94182972..2cc032e8cbb9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -561,12 +561,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
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
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7e3b342215e5..cde1a5a63943 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1001,8 +1001,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
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
 
@@ -1012,12 +1015,14 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b548d5646a86..ee89a69817aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1391,6 +1391,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
 int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
@@ -1594,6 +1595,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			 void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
@@ -1990,6 +1993,8 @@ static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline void pci_restore_state(struct pci_dev *dev) { }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
+static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
-- 
2.34.1


