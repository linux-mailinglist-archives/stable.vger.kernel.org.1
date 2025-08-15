Return-Path: <stable+bounces-169833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFEB28831
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03259AC3A4C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF76256C6F;
	Fri, 15 Aug 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1mAa0mE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77028399
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295709; cv=none; b=i4fqpscRsPoVoEKW7KZ0DxhGFJTdrDb7y67hNKkbgR97/Ko2+bza/iznvTH+puyaK3UYZlwFmP2WX9DVILp8Dwy95l0aoLNf3xxLF/r/wWs8tiL36rQX50gAqKMCpStB+/yOinlOaj36YZ/5mr/qdb7wCJvRsLAaatYROeuKdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295709; c=relaxed/simple;
	bh=SzolPRlU9fqujFujXdZjEDl5c6+eEnWw5hw4lbSFUHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOg6CfooJiDVOJrCcFch6pd4vmvppq2yKdxUW++lJmEe985Qq7A8quw0gOLX+TJ4lbusaAmr0ZmU1Hy/NNUC30c/Dsm7nEzsBTZpJjiqYKKyk344PZxuHzsKNgObFG1alG/ij1mpm6coxPLWP+DxxoDd5yUnF7cJaG/naSODfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1mAa0mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E5C4CEF0;
	Fri, 15 Aug 2025 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295709;
	bh=SzolPRlU9fqujFujXdZjEDl5c6+eEnWw5hw4lbSFUHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1mAa0mEVvYvtlRfzx8do7YQM7qbTv55Ae1MWgQXsD1rd+E9OxdrtAcx/ZXXOds8k
	 lNhgsuuGm4xhHqr4IfQVPRiIApOA1LOCtkp7laoRhihjB6P+AksifohkV/nyb9Oqxu
	 5ikuQyD3/hUtelTDaNaJUQ2C1gv5AjSgEmfODaOIsnLudr9CnjKUrf2rZ9JjfhUROW
	 UPgmp7Gfv/eN1g77ydjN9WSKg+biwgXiDepl008E8hxLHEwIk6nw+M4CqyqscTtBXE
	 iucV5AW2wsRikxFF7/9oVxdZhdPXKOlEuQ6n7Bw0/jgfx/k3Lecq42YfYXJLBkcVBl
	 UM8xPhxjbJPJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
Date: Fri, 15 Aug 2025 18:08:24 -0400
Message-ID: <20250815220824.248963-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815220824.248963-1-sashal@kernel.org>
References: <2025081508-ultra-derived-f72d@gregkh>
 <20250815220824.248963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-acpi.c | 4 +---
 drivers/pci/pci.c      | 6 +++++-
 drivers/pci/probe.c    | 2 +-
 include/linux/pci.h    | 6 ++++++
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..99c58ee09fbb 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -816,13 +816,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfd1893d92ec..d4e89123a112 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3023,8 +3023,12 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
  * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
+ *
+ * Return: Whether it is possible to move the bridge to D3.
+ *
+ * The return value is guaranteed to be constant across the entire lifetime
+ * of the bridge, including its hot-removal.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b777e1b01839..b358b93a0275 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1627,7 +1627,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
-		pdev->is_hotplug_bridge = 1;
+		pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f611837f1989..6b3fef24d60e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -327,6 +327,11 @@ struct rcec_ea;
  *			determined (e.g., for Root Complex Integrated
  *			Endpoints without the relevant Capability
  *			Registers).
+ * @is_hotplug_bridge:	Hotplug bridge of any kind (e.g. PCIe Hot-Plug Capable,
+ *			Conventional PCI Hot-Plug, ACPI slot).
+ *			Such bridges are allocated additional MMIO and bus
+ *			number resources to allow for hierarchy expansion.
+ * @is_pciehp:		PCIe Hot-Plug Capable bridge.
  */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
@@ -450,6 +455,7 @@ struct pci_dev {
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-- 
2.50.1


