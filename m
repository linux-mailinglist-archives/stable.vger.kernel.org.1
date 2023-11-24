Return-Path: <stable+bounces-1376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7B7F7F59
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC22822B9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8935F1D;
	Fri, 24 Nov 2023 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWsLwM7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870D2EAEA;
	Fri, 24 Nov 2023 18:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57D2C433C7;
	Fri, 24 Nov 2023 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851244;
	bh=LW99In0MLQnRL5jmJ/jC8GLMb8LelYOwXIsP9Nbe13Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWsLwM7MaG4SocwS5Ci5A5gRsLroOqp3+YJbxI5RfMTr+cA5LcrDd54MIkwqf4xOu
	 nQEUJGpsUoNDlRRCNyw/QOYlWvafRdtbw3i1LDfeSeKi/NvscO8zZJvV1INGftodvK
	 QtK46oACRHPX4NP3GT/smcIDrC1CZ2oNggOhE0m4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 370/491] PCI: Create device tree node for bridge
Date: Fri, 24 Nov 2023 17:50:06 +0000
Message-ID: <20231124172035.699502499@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 407d1a51921e9f28c1bcec647c2205925bd1fdab ]

The PCI endpoint device such as Xilinx Alveo PCI card maps the register
spaces from multiple hardware peripherals to its PCI BAR. Normally,
the PCI core discovers devices and BARs using the PCI enumeration process.
There is no infrastructure to discover the hardware peripherals that are
present in a PCI device, and which can be accessed through the PCI BARs.

Apparently, the device tree framework requires a device tree node for the
PCI device. Thus, it can generate the device tree nodes for hardware
peripherals underneath. Because PCI is self discoverable bus, there might
not be a device tree node created for PCI devices. Furthermore, if the PCI
device is hot pluggable, when it is plugged in, the device tree nodes for
its parent bridges are required. Add support to generate device tree node
for PCI bridges.

Add an of_pci_make_dev_node() interface that can be used to create device
tree node for PCI devices.

Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
the kernel will generate device tree nodes for PCI bridges unconditionally.

Initially, add the basic properties for the dynamically generated device
tree nodes which include #address-cells, #size-cells, device_type,
compatible, ranges, reg.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://lore.kernel.org/r/1692120000-46900-3-git-send-email-lizhi.hou@amd.com
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: c9260693aa0c ("PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/Kconfig       |  12 ++
 drivers/pci/Makefile      |   1 +
 drivers/pci/bus.c         |   2 +
 drivers/pci/of.c          |  79 +++++++++
 drivers/pci/of_property.c | 355 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  12 ++
 drivers/pci/remove.c      |   1 +
 7 files changed, 462 insertions(+)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 3c07d8d214b38..49bd09c7dd0a1 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -194,6 +194,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DYNAMIC_OF_NODES
+	bool "Create Device tree nodes for PCI devices"
+	depends on OF
+	select OF_DYNAMIC
+	help
+	  This option enables support for generating device tree nodes for some
+	  PCI devices. Thus, the driver of this kind can load and overlay
+	  flattened device tree for its downstream devices.
+
+	  Once this option is selected, the device tree nodes will be generated
+	  for all PCI bridges.
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2680e4c92f0ab..cc8b4e01e29de 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 46b252bbe5000..9c2137dae429a 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -342,6 +342,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
+	if (pci_is_bridge(dev))
+		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3c158b17dcb53..2af64bcb7da3a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -606,6 +606,85 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+
+void of_pci_remove_node(struct pci_dev *pdev)
+{
+	struct device_node *np;
+
+	np = pci_device_to_OF_node(pdev);
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+		return;
+	pdev->dev.of_node = NULL;
+
+	of_changeset_revert(np->data);
+	of_changeset_destroy(np->data);
+	of_node_put(np);
+}
+
+void of_pci_make_dev_node(struct pci_dev *pdev)
+{
+	struct device_node *ppnode, *np = NULL;
+	const char *pci_type;
+	struct of_changeset *cset;
+	const char *name;
+	int ret;
+
+	/*
+	 * If there is already a device tree node linked to this device,
+	 * return immediately.
+	 */
+	if (pci_device_to_OF_node(pdev))
+		return;
+
+	/* Check if there is device tree node for parent device */
+	if (!pdev->bus->self)
+		ppnode = pdev->bus->dev.of_node;
+	else
+		ppnode = pdev->bus->self->dev.of_node;
+	if (!ppnode)
+		return;
+
+	if (pci_is_bridge(pdev))
+		pci_type = "pci";
+	else
+		pci_type = "dev";
+
+	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!name)
+		return;
+
+	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
+	if (!cset)
+		goto failed;
+	of_changeset_init(cset);
+
+	np = of_changeset_create_node(cset, ppnode, name);
+	if (!np)
+		goto failed;
+	np->data = cset;
+
+	ret = of_pci_add_properties(pdev, cset, np);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto failed;
+
+	pdev->dev.of_node = np;
+	kfree(name);
+
+	return;
+
+failed:
+	if (np)
+		of_node_put(np);
+	kfree(name);
+}
+#endif
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
new file mode 100644
index 0000000000000..710ec35ba4a17
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include "pci.h"
+
+#define OF_PCI_ADDRESS_CELLS		3
+#define OF_PCI_SIZE_CELLS		2
+#define OF_PCI_MAX_INT_PIN		4
+
+struct of_pci_addr_pair {
+	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
+	u32		size[OF_PCI_SIZE_CELLS];
+};
+
+/*
+ * Each entry in the ranges table is a tuple containing the child address,
+ * the parent address, and the size of the region in the child address space.
+ * Thus, for PCI, in each entry parent address is an address on the primary
+ * side and the child address is the corresponding address on the secondary
+ * side.
+ */
+struct of_pci_range {
+	u32		child_addr[OF_PCI_ADDRESS_CELLS];
+	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
+	u32		size[OF_PCI_SIZE_CELLS];
+};
+
+#define OF_PCI_ADDR_SPACE_IO		0x1
+#define OF_PCI_ADDR_SPACE_MEM32		0x2
+#define OF_PCI_ADDR_SPACE_MEM64		0x3
+
+#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
+#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
+#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
+#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
+#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
+#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
+#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
+
+enum of_pci_prop_compatible {
+	PROP_COMPAT_PCI_VVVV_DDDD,
+	PROP_COMPAT_PCICLASS_CCSSPP,
+	PROP_COMPAT_PCICLASS_CCSS,
+	PROP_COMPAT_NUM,
+};
+
+static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
+			       u32 reg_num, u32 flags, bool reloc)
+{
+	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	prop[0] |= flags | reg_num;
+	if (!reloc) {
+		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
+		prop[1] = upper_32_bits(addr);
+		prop[2] = lower_32_bits(addr);
+	}
+}
+
+static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
+{
+	u32 ss;
+
+	if (res->flags & IORESOURCE_IO)
+		ss = OF_PCI_ADDR_SPACE_IO;
+	else if (res->flags & IORESOURCE_MEM_64)
+		ss = OF_PCI_ADDR_SPACE_MEM64;
+	else if (res->flags & IORESOURCE_MEM)
+		ss = OF_PCI_ADDR_SPACE_MEM32;
+	else
+		return -EINVAL;
+
+	*flags = 0;
+	if (res->flags & IORESOURCE_PREFETCH)
+		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+
+	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
+
+	return 0;
+}
+
+static int of_pci_prop_bus_range(struct pci_dev *pdev,
+				 struct of_changeset *ocs,
+				 struct device_node *np)
+{
+	u32 bus_range[] = { pdev->subordinate->busn_res.start,
+			    pdev->subordinate->busn_res.end };
+
+	return of_changeset_add_prop_u32_array(ocs, np, "bus-range", bus_range,
+					       ARRAY_SIZE(bus_range));
+}
+
+static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
+			      struct device_node *np)
+{
+	struct of_pci_range *rp;
+	struct resource *res;
+	int i, j, ret;
+	u32 flags, num;
+	u64 val64;
+
+	if (pci_is_bridge(pdev)) {
+		num = PCI_BRIDGE_RESOURCE_NUM;
+		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
+	} else {
+		num = PCI_STD_NUM_BARS;
+		res = &pdev->resource[PCI_STD_RESOURCES];
+	}
+
+	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; j < num; j++) {
+		if (!resource_size(&res[j]))
+			continue;
+
+		if (of_pci_get_addr_flags(&res[j], &flags))
+			continue;
+
+		val64 = res[j].start;
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+				   false);
+		if (pci_is_bridge(pdev)) {
+			memcpy(rp[i].child_addr, rp[i].parent_addr,
+			       sizeof(rp[i].child_addr));
+		} else {
+			/*
+			 * For endpoint device, the lower 64-bits of child
+			 * address is always zero.
+			 */
+			rp[i].child_addr[0] = j;
+		}
+
+		val64 = resource_size(&res[j]);
+		rp[i].size[0] = upper_32_bits(val64);
+		rp[i].size[1] = lower_32_bits(val64);
+
+		i++;
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
+					      i * sizeof(*rp) / sizeof(u32));
+	kfree(rp);
+
+	return ret;
+}
+
+static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
+			   struct device_node *np)
+{
+	struct of_pci_addr_pair reg = { 0 };
+
+	/* configuration space */
+	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
+
+	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
+					       sizeof(reg) / sizeof(u32));
+}
+
+static int of_pci_prop_interrupts(struct pci_dev *pdev,
+				  struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	int ret;
+	u8 pin;
+
+	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+	if (ret != 0)
+		return ret;
+
+	if (!pin)
+		return 0;
+
+	return of_changeset_add_prop_u32(ocs, np, "interrupts", (u32)pin);
+}
+
+static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
+				struct device_node *np)
+{
+	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
+	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
+	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
+	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
+	struct device_node *pnode;
+	struct pci_dev *child;
+	u32 *int_map, *mapp;
+	int ret;
+	u8 pin;
+
+	pnode = pci_device_to_OF_node(pdev->bus->self);
+	if (!pnode)
+		pnode = pci_bus_to_OF_node(pdev->bus);
+
+	if (!pnode) {
+		pci_err(pdev, "failed to get parent device node");
+		return -EINVAL;
+	}
+
+	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
+	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
+		i = pin - 1;
+		out_irq[i].np = pnode;
+		out_irq[i].args_count = 1;
+		out_irq[i].args[0] = pin;
+		ret = of_irq_parse_raw(laddr, &out_irq[i]);
+		if (ret) {
+			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
+			continue;
+		}
+		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
+					   &addr_sz[i]);
+		if (ret)
+			addr_sz[i] = 0;
+	}
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
+		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
+			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
+		}
+	}
+
+	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
+	mapp = int_map;
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
+		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
+			*mapp = (child->bus->number << 16) |
+				(child->devfn << 8);
+			mapp += OF_PCI_ADDRESS_CELLS;
+			*mapp = pin;
+			mapp++;
+			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			*mapp = out_irq[i].np->phandle;
+			mapp++;
+			if (addr_sz[i]) {
+				ret = of_property_read_u32_array(out_irq[i].np,
+								 "reg", mapp,
+								 addr_sz[i]);
+				if (ret)
+					goto failed;
+			}
+			mapp += addr_sz[i];
+			memcpy(mapp, out_irq[i].args,
+			       out_irq[i].args_count * sizeof(u32));
+			mapp += out_irq[i].args_count;
+		}
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map", int_map,
+					      map_sz);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
+					      int_map_mask,
+					      ARRAY_SIZE(int_map_mask));
+	if (ret)
+		goto failed;
+
+	kfree(int_map);
+	return 0;
+
+failed:
+	kfree(int_map);
+	return ret;
+}
+
+static int of_pci_prop_compatible(struct pci_dev *pdev,
+				  struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
+	int i, ret;
+
+	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
+		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
+		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
+		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
+
+	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
+						 compat_strs, PROP_COMPAT_NUM);
+	for (i = 0; i < PROP_COMPAT_NUM; i++)
+		kfree(compat_strs[i]);
+
+	return ret;
+}
+
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np)
+{
+	int ret;
+
+	/*
+	 * The added properties will be released when the
+	 * changeset is destroyed.
+	 */
+	if (pci_is_bridge(pdev)) {
+		ret = of_changeset_add_prop_string(ocs, np, "device_type",
+						   "pci");
+		if (ret)
+			return ret;
+
+		ret = of_pci_prop_bus_range(pdev, ocs, np);
+		if (ret)
+			return ret;
+
+		ret = of_pci_prop_intr_map(pdev, ocs, np);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_pci_prop_ranges(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					OF_PCI_ADDRESS_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					OF_PCI_SIZE_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_pci_prop_reg(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	ret = of_pci_prop_compatible(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	ret = of_pci_prop_interrupts(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..ba717bdd700db 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -679,6 +679,18 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #endif /* CONFIG_OF */
 
+struct of_changeset;
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+void of_pci_make_dev_node(struct pci_dev *pdev);
+void of_pci_remove_node(struct pci_dev *pdev);
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np);
+#else
+static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
+static inline void of_pci_remove_node(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d68aee29386b4..d749ea8250d65 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -22,6 +22,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
 	}
-- 
2.42.0




