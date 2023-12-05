Return-Path: <stable+bounces-4194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCB804675
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E9B20C88
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37579E3;
	Tue,  5 Dec 2023 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3KzVNmy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB726FAF;
	Tue,  5 Dec 2023 03:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0927C433C8;
	Tue,  5 Dec 2023 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746875;
	bh=ITyXX4JeDjGz9kiZTN3faCjBcMP0mR53kYIZpGZU5FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3KzVNmyGwICjUyihlG8FyAYicZjclvzOa7awKeNx9n87UNC4KP4WFYDqTpbH5BJ0
	 B0wH1zxt0vKlEEhinMiWnZDU2yncZi6YT8XM0jsrO6tuZ6WcxaLhFBVgsoWvFjPz3C
	 KyOAHEkwNz/n+ADDhbKci3Tbe7edbwJZLzWYBFrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/71] PCI: let pci_disable_link_state propagate errors
Date: Tue,  5 Dec 2023 12:16:50 +0900
Message-ID: <20231205031520.899034529@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 4cfd218855923a07dc02a5bec3d3bb37a118ebc2 ]

Drivers may rely on pci_disable_link_state() having disabled certain
ASPM link states. If OS can't control ASPM then pci_disable_link_state()
turns into a no-op w/o informing the caller. The driver therefore may
falsely assume the respective ASPM link states are disabled.
Let pci_disable_link_state() propagate errors to the caller, enabling
the caller to react accordingly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 3cb4f534bac0 ("Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c  | 20 +++++++++++---------
 include/linux/pci-aspm.h |  7 ++++---
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 118c91586798d..f2b5f3a8535e5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1078,18 +1078,18 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
+static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
 	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link;
 
 	if (!pci_is_pcie(pdev))
-		return;
+		return 0;
 
 	if (pdev->has_secondary_link)
 		parent = pdev;
 	if (!parent || !parent->link_state)
-		return;
+		return -EINVAL;
 
 	/*
 	 * A driver requested that ASPM be disabled on this device, but
@@ -1101,7 +1101,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	 */
 	if (aspm_disabled) {
 		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
-		return;
+		return -EPERM;
 	}
 
 	if (sem)
@@ -1120,11 +1120,13 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	mutex_unlock(&aspm_lock);
 	if (sem)
 		up_read(&pci_bus_sem);
+
+	return 0;
 }
 
-void pci_disable_link_state_locked(struct pci_dev *pdev, int state)
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
-	__pci_disable_link_state(pdev, state, false);
+	return __pci_disable_link_state(pdev, state, false);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
@@ -1132,14 +1134,14 @@ EXPORT_SYMBOL(pci_disable_link_state_locked);
  * pci_disable_link_state - Disable device's link state, so the link will
  * never enter specific states.  Note that if the BIOS didn't grant ASPM
  * control to the OS, this does nothing because we can't touch the LNKCTL
- * register.
+ * register. Returns 0 or a negative errno.
  *
  * @pdev: PCI device
  * @state: ASPM link state to disable
  */
-void pci_disable_link_state(struct pci_dev *pdev, int state)
+int pci_disable_link_state(struct pci_dev *pdev, int state)
 {
-	__pci_disable_link_state(pdev, state, true);
+	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index df28af5cef210..67064145d76e0 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -24,11 +24,12 @@
 #define PCIE_LINK_STATE_CLKPM	4
 
 #ifdef CONFIG_PCIEASPM
-void pci_disable_link_state(struct pci_dev *pdev, int state);
-void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+int pci_disable_link_state(struct pci_dev *pdev, int state);
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 #else
-static inline void pci_disable_link_state(struct pci_dev *pdev, int state) { }
+static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
 static inline void pcie_no_aspm(void) { }
 #endif
 
-- 
2.42.0




