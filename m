Return-Path: <stable+bounces-175327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C47B367B4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24EF173604
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7093352FD4;
	Tue, 26 Aug 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCFA7Umb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AC352095;
	Tue, 26 Aug 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216742; cv=none; b=CP2kYdqGqBCCANiq3q4zNmfG5DVbY0S31tX0xwpszgzb2q5W3vxcoGXEX7L7hHZt962pftPTvM4v1JJlxnkUxrG2ATwjNGOP9ebk0cSQbSSsi87U4HqUWJqLwScYTMhWYruhNcxdif0or3tIgNMKjyQulG9fZaASj0StNOhbpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216742; c=relaxed/simple;
	bh=2+6A7VOqx49AaB7bzP76kAJ4Cj40Q1v9LpH6ynDWUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkmHDVNL7LYv9A6fN4jvfwG02C21mvBrLWkoQEmXe+Hrl7t8Y8I8sq3cnQyKCf1tYRFG2J+t/wVJS8zVdn7+3HlF1PMTg2g6lsjJzXF7oLnxVtutobDP7Tyu2pmQyfvVyCBC6gn3PzvJ6rMWLHsJOYxNJwFtFfFAmQpiLt7R5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCFA7Umb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D18AC113D0;
	Tue, 26 Aug 2025 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216742;
	bh=2+6A7VOqx49AaB7bzP76kAJ4Cj40Q1v9LpH6ynDWUDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCFA7UmbT6YcSqjpfIUNu9IXMuYBUw+FoYpl/mDa1eEO6pFdPhXekabkCjsbaPjiS
	 g/rV8I67Bia1PQCSkqsC5uL939o9Sxp2ekkdN5TxAQvtCZpUwT/O1f5jJRXqVjCVT7
	 tj2ZFCTnfG0IsPTSjBmdVOqqV/p8zclwIUtSg+fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 526/644] PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
Date: Tue, 26 Aug 2025 13:10:17 +0200
Message-ID: <20250826110959.543958468@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
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

[ Upstream commit 6cff20ce3b92ffbf2fc5eb9e5a030b3672aa414a ]

pci_bridge_d3_possible() is called from both pcie_portdrv_probe() and
pcie_portdrv_remove() to determine whether runtime power management shall
be enabled (on probe) or disabled (on remove) on a PCIe port.

The underlying assumption is that pci_bridge_d3_possible() always returns
the same value, else a runtime PM reference imbalance would occur.  That
assumption is not given if the PCIe port is inaccessible on remove due to
hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(), which
accesses Config Space to determine whether the port is Hot-Plug Capable.
An inaccessible port returns "all ones", which is converted to "all
zeroes" by pcie_capability_read_dword().  Hence the port no longer seems
Hot-Plug Capable on remove even though it was on probe.

The resulting runtime PM ref imbalance causes warning messages such as:

  pcieport 0000:02:04.0: Runtime PM usage count underflow!

Avoid the Config Space access (and thus the runtime PM ref imbalance) by
caching the Hot-Plug Capable bit in struct pci_dev.

The struct already contains an "is_hotplug_bridge" flag, which however is
not only set on Hot-Plug Capable PCIe ports, but also Conventional PCI
Hot-Plug bridges and ACPI slots.  The flag identifies bridges which are
allocated additional MMIO and bus number resources to allow for hierarchy
expansion.

The kernel is somewhat sloppily using "is_hotplug_bridge" in a number of
places to identify Hot-Plug Capable PCIe ports, even though the flag
encompasses other devices.  Subsequent commits replace these occurrences
with the new flag to clearly delineate Hot-Plug Capable PCIe ports from
other kinds of hotplug bridges.

Document the existing "is_hotplug_bridge" and the new "is_pciehp" flag
and document the (non-obvious) requirement that pci_bridge_d3_possible()
always returns the same value across the entire lifetime of a bridge,
including its hot-removal.

Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
Reported-by: Laurent Bigonville <bigon@bigon.be>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org # v4.18+
Link: https://patch.msgid.link/fe5dcc3b2e62ee1df7905d746bde161eb1b3291c.1752390101.git.lukas@wunner.de
[ changed "recent enough PCIe ports" comment to "some PCIe ports" ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-acpi.c |    4 +---
 drivers/pci/pci.c      |    8 ++++++--
 drivers/pci/probe.c    |    2 +-
 include/linux/pci.h    |   10 +++++++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -792,13 +792,11 @@ int pci_acpi_program_hp_params(struct pc
 bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
-	u32 slot_cap;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if (!bridge->is_pciehp)
 		return false;
 
 	if (pcie_ports_native)
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2921,8 +2921,12 @@ static const struct dmi_system_id bridge
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+ * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
+ *
+ * Return: Whether it is possible to move the bridge to D3.
+ *
+ * The return value is guaranteed to be constant across the entire lifetime
+ * of the bridge, including its hot-removal.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1590,7 +1590,7 @@ void set_pcie_hotplug_bridge(struct pci_
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
-		pdev->is_hotplug_bridge = 1;
+		pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -317,7 +317,14 @@ struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
 
-/* The pci_dev structure describes PCI devices */
+/* struct pci_dev - describes a PCI device
+ *
+ * @is_hotplug_bridge:	Hotplug bridge of any kind (e.g. PCIe Hot-Plug Capable,
+ *			Conventional PCI Hot-Plug, ACPI slot).
+ *			Such bridges are allocated additional MMIO and bus
+ *			number resources to allow for hierarchy expansion.
+ * @is_pciehp:		PCIe Hot-Plug Capable bridge.
+ */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -440,6 +447,7 @@ struct pci_dev {
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*



