Return-Path: <stable+bounces-169887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C9B29347
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3AD7AEBC5
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60C288C05;
	Sun, 17 Aug 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOGFS8oW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B609288C0F
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437516; cv=none; b=aQx/bCPl55UzwTCIt3mCEN70uj3l1YCrMGpstRT9n2034THLdVhrV+XcSdyulA2GUhWaZWUHQfUQ7eKJPzhT33frH1f9MrfgcqAzyWr2mI/AheE54juVgYI0Nw0RlELOolxaklZ6KUoVwW1iz0+V9zvL0wa0jtNWvk4NK5Tf32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437516; c=relaxed/simple;
	bh=ARVzZY0g2oyWnk6NxWLhmAkhe7QP6XArLEHDO64Dsuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCExB1xpWxCphkNe9nhT2s8CfXuWuEf7fbl9ktKqO1TKRADiyljO56uhwfs4ZNkobpNoqXqpKN24EBruU262ZNJ/H32PploDaDz5XaxZ9+Ng6jEarhP0S4ptwcrrMU/1/MTs2tN8eFCEcq4OWnybtkDRJW1dtxtzZKQAFKhrqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOGFS8oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED74C4CEEB;
	Sun, 17 Aug 2025 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755437516;
	bh=ARVzZY0g2oyWnk6NxWLhmAkhe7QP6XArLEHDO64Dsuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOGFS8oWsaW7lB890RhS5J182OWMtpi/Juyw5isKkvbqUWzshhNOH9yDQkwesiT0J
	 eEII1/w4TVHeD3JEECFJ5XhDE6E9ykk2ITvCVbAepOwRgUDc/lwhgAzhKjwGASsbwm
	 bwp35JM9S3wpNZOi/JPe5H0nq816S9t4iHllJnhYUlRoePMUpYxi/yY6cRMYg2pi7m
	 xjgov+4PSSBqBW41pdgoQBk107kPLe6A4eIOeslcBhwdRteZrDW1VMGsLN3+gQ/7al
	 RRCctigABydXVIn1Z79QNrcq6Bn7wFTbbPQF25g87WdMzc27sSXx6iESoJBoKPkZPP
	 WANU+fb0ZLm3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
Date: Sun, 17 Aug 2025 09:31:53 -0400
Message-ID: <20250817133153.1436810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081513-doorpost-truck-2a5e@gregkh>
References: <2025081513-doorpost-truck-2a5e@gregkh>
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
[ Adjust surrounding documentation changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-acpi.c | 4 +---
 drivers/pci/pci.c      | 8 ++++++--
 drivers/pci/probe.c    | 2 +-
 include/linux/pci.h    | 1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 86dc5ae17c6d..07d1508e6dc5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -791,13 +791,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
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
index 050fb376d1c5..11aa5cf9bd1f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2646,8 +2646,12 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cae7ca18a69d..aa726740514b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1479,7 +1479,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
-		pdev->is_hotplug_bridge = 1;
+		pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f2f92eb950cc..d24d709e5625 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -415,6 +415,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-- 
2.50.1


