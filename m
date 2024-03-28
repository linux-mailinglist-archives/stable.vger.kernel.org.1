Return-Path: <stable+bounces-26356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99B870E33
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05501F21A5C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D41C6AB;
	Mon,  4 Mar 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQVFrb13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E228F58;
	Mon,  4 Mar 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588511; cv=none; b=cQca/XB3BP6CTACSg30JGnlgMzyLn31xiHncP8vvRvmdUuoWRPZmwZRHEBk3wHJq3s7uyyQa0fTi3+o8yWZh2S3SM0nGhzPxfLw9dcy4WvRTLlB+LdkGwUSHTkch95jdUgvxFaMNk4b3QTfjf4tXaIOs4REGwyszI6jq4cYO8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588511; c=relaxed/simple;
	bh=zUFBvRBKxZ2T2eNVGBESGfqKUJxedwYJ/oinlzlfDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ85iVvegulrTJkXKRZgvwLRzKkd3sEaLCFD1+te+YNc8rCQd8PffnLj6PguZn5/Pu95tUQdWGGI4G59psDVJFpyxiPfaqdWFVxf9jgR/1eSZ5UYtwWDg+Ng4fexKe8bs1SUQHcIeeak9yldWzh3Szqmc1Kt3OGHiJdefocenHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQVFrb13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BADC433F1;
	Mon,  4 Mar 2024 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588510;
	bh=zUFBvRBKxZ2T2eNVGBESGfqKUJxedwYJ/oinlzlfDTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQVFrb13hlqWTL8FVF5xEtfBnQUscifuSgraIvoKIIkMlAhjVFzvX9YfW5ZZCiO/3
	 O8yNK1YhLdMIG7gh7toh+2KiQDc+uwXXcW9CqtkAF+GbUXAWa3EIOdsnNxMbRvigtk
	 yd2+UE+Ia5TBcSLGBc5tF4psG7VUwKUDzEELM3Ok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaurav Batra <gbatra@linux.vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 127/143] powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV
Date: Mon,  4 Mar 2024 21:24:07 +0000
Message-ID: <20240304211553.958979702@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Batra <gbatra@linux.vnet.ibm.com>

[ Upstream commit 09a3c1e46142199adcee372a420b024b4fc61051 ]

When kdump kernel tries to copy dump data over SR-IOV, LPAR panics due
to NULL pointer exception:

  Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
  BUG: Kernel NULL pointer dereference on read at 0x00000000
  Faulting instruction address: 0xc000000020847ad4
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: mlx5_core(+) vmx_crypto pseries_wdt papr_scm libnvdimm mlxfw tls psample sunrpc fuse overlay squashfs loop
  CPU: 12 PID: 315 Comm: systemd-udevd Not tainted 6.4.0-Test102+ #12
  Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_008) hv:phyp pSeries
  NIP:  c000000020847ad4 LR: c00000002083b2dc CTR: 00000000006cd18c
  REGS: c000000029162ca0 TRAP: 0300   Not tainted  (6.4.0-Test102+)
  MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48288244  XER: 00000008
  CFAR: c00000002083b2d8 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
  ...
  NIP _find_next_zero_bit+0x24/0x110
  LR  bitmap_find_next_zero_area_off+0x5c/0xe0
  Call Trace:
    dev_printk_emit+0x38/0x48 (unreliable)
    iommu_area_alloc+0xc4/0x180
    iommu_range_alloc+0x1e8/0x580
    iommu_alloc+0x60/0x130
    iommu_alloc_coherent+0x158/0x2b0
    dma_iommu_alloc_coherent+0x3c/0x50
    dma_alloc_attrs+0x170/0x1f0
    mlx5_cmd_init+0xc0/0x760 [mlx5_core]
    mlx5_function_setup+0xf0/0x510 [mlx5_core]
    mlx5_init_one+0x84/0x210 [mlx5_core]
    probe_one+0x118/0x2c0 [mlx5_core]
    local_pci_probe+0x68/0x110
    pci_call_probe+0x68/0x200
    pci_device_probe+0xbc/0x1a0
    really_probe+0x104/0x540
    __driver_probe_device+0xb4/0x230
    driver_probe_device+0x54/0x130
    __driver_attach+0x158/0x2b0
    bus_for_each_dev+0xa8/0x130
    driver_attach+0x34/0x50
    bus_add_driver+0x16c/0x300
    driver_register+0xa4/0x1b0
    __pci_register_driver+0x68/0x80
    mlx5_init+0xb8/0x100 [mlx5_core]
    do_one_initcall+0x60/0x300
    do_init_module+0x7c/0x2b0

At the time of LPAR dump, before kexec hands over control to kdump
kernel, DDWs (Dynamic DMA Windows) are scanned and added to the FDT.
For the SR-IOV case, default DMA window "ibm,dma-window" is removed from
the FDT and DDW added, for the device.

Now, kexec hands over control to the kdump kernel.

When the kdump kernel initializes, PCI busses are scanned and IOMMU
group/tables created, in pci_dma_bus_setup_pSeriesLP(). For the SR-IOV
case, there is no "ibm,dma-window". The original commit: b1fc44eaa9ba,
fixes the path where memory is pre-mapped (direct mapped) to the DDW.
When TCEs are direct mapped, there is no need to initialize IOMMU
tables.

iommu_table_setparms_lpar() only considers "ibm,dma-window" property
when initiallizing IOMMU table. In the scenario where TCEs are
dynamically allocated for SR-IOV, newly created IOMMU table is not
initialized. Later, when the device driver tries to enter TCEs for the
SR-IOV device, NULL pointer execption is thrown from iommu_area_alloc().

The fix is to initialize the IOMMU table with DDW property stored in the
FDT. There are 2 points to remember:

	1. For the dedicated adapter, kdump kernel would encounter both
	   default and DDW in FDT. In this case, DDW property is used to
	   initialize the IOMMU table.

	2. A DDW could be direct or dynamic mapped. kdump kernel would
	   initialize IOMMU table and mark the existing DDW as
	   "dynamic". This works fine since, at the time of table
	   initialization, iommu_table_clear() makes some space in the
	   DDW, for some predefined number of TCEs which are needed for
	   kdump to succeed.

Fixes: b1fc44eaa9ba ("pseries/iommu/ddw: Fix kdump to work in absence of ibm,dma-window")
Signed-off-by: Gaurav Batra <gbatra@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240125203017.61014-1-gbatra@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 156 +++++++++++++++++--------
 1 file changed, 105 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 496e16c588aaa..e8c4129697b14 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -574,29 +574,6 @@ static void iommu_table_setparms(struct pci_controller *phb,
 
 struct iommu_table_ops iommu_table_lpar_multi_ops;
 
-/*
- * iommu_table_setparms_lpar
- *
- * Function: On pSeries LPAR systems, return TCE table info, given a pci bus.
- */
-static void iommu_table_setparms_lpar(struct pci_controller *phb,
-				      struct device_node *dn,
-				      struct iommu_table *tbl,
-				      struct iommu_table_group *table_group,
-				      const __be32 *dma_window)
-{
-	unsigned long offset, size, liobn;
-
-	of_parse_dma_window(dn, dma_window, &liobn, &offset, &size);
-
-	iommu_table_setparms_common(tbl, phb->bus->number, liobn, offset, size, IOMMU_PAGE_SHIFT_4K, NULL,
-				    &iommu_table_lpar_multi_ops);
-
-
-	table_group->tce32_start = offset;
-	table_group->tce32_size = size;
-}
-
 struct iommu_table_ops iommu_table_pseries_ops = {
 	.set = tce_build_pSeries,
 	.clear = tce_free_pSeries,
@@ -724,26 +701,71 @@ struct iommu_table_ops iommu_table_lpar_multi_ops = {
  * dynamic 64bit DMA window, walking up the device tree.
  */
 static struct device_node *pci_dma_find(struct device_node *dn,
-					const __be32 **dma_window)
+					struct dynamic_dma_window_prop *prop)
 {
-	const __be32 *dw = NULL;
+	const __be32 *default_prop = NULL;
+	const __be32 *ddw_prop = NULL;
+	struct device_node *rdn = NULL;
+	bool default_win = false, ddw_win = false;
 
 	for ( ; dn && PCI_DN(dn); dn = dn->parent) {
-		dw = of_get_property(dn, "ibm,dma-window", NULL);
-		if (dw) {
-			if (dma_window)
-				*dma_window = dw;
-			return dn;
+		default_prop = of_get_property(dn, "ibm,dma-window", NULL);
+		if (default_prop) {
+			rdn = dn;
+			default_win = true;
+		}
+		ddw_prop = of_get_property(dn, DIRECT64_PROPNAME, NULL);
+		if (ddw_prop) {
+			rdn = dn;
+			ddw_win = true;
+			break;
+		}
+		ddw_prop = of_get_property(dn, DMA64_PROPNAME, NULL);
+		if (ddw_prop) {
+			rdn = dn;
+			ddw_win = true;
+			break;
 		}
-		dw = of_get_property(dn, DIRECT64_PROPNAME, NULL);
-		if (dw)
-			return dn;
-		dw = of_get_property(dn, DMA64_PROPNAME, NULL);
-		if (dw)
-			return dn;
+
+		/* At least found default window, which is the case for normal boot */
+		if (default_win)
+			break;
 	}
 
-	return NULL;
+	/* For PCI devices there will always be a DMA window, either on the device
+	 * or parent bus
+	 */
+	WARN_ON(!(default_win | ddw_win));
+
+	/* caller doesn't want to get DMA window property */
+	if (!prop)
+		return rdn;
+
+	/* parse DMA window property. During normal system boot, only default
+	 * DMA window is passed in OF. But, for kdump, a dedicated adapter might
+	 * have both default and DDW in FDT. In this scenario, DDW takes precedence
+	 * over default window.
+	 */
+	if (ddw_win) {
+		struct dynamic_dma_window_prop *p;
+
+		p = (struct dynamic_dma_window_prop *)ddw_prop;
+		prop->liobn = p->liobn;
+		prop->dma_base = p->dma_base;
+		prop->tce_shift = p->tce_shift;
+		prop->window_shift = p->window_shift;
+	} else if (default_win) {
+		unsigned long offset, size, liobn;
+
+		of_parse_dma_window(rdn, default_prop, &liobn, &offset, &size);
+
+		prop->liobn = cpu_to_be32((u32)liobn);
+		prop->dma_base = cpu_to_be64(offset);
+		prop->tce_shift = cpu_to_be32(IOMMU_PAGE_SHIFT_4K);
+		prop->window_shift = cpu_to_be32(order_base_2(size));
+	}
+
+	return rdn;
 }
 
 static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
@@ -751,17 +773,20 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	const __be32 *dma_window = NULL;
+	struct dynamic_dma_window_prop prop;
 
 	dn = pci_bus_to_OF_node(bus);
 
 	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %pOF\n",
 		 dn);
 
-	pdn = pci_dma_find(dn, &dma_window);
+	pdn = pci_dma_find(dn, &prop);
 
-	if (dma_window == NULL)
-		pr_debug("  no ibm,dma-window property !\n");
+	/* In PPC architecture, there will always be DMA window on bus or one of the
+	 * parent bus. During reboot, there will be ibm,dma-window property to
+	 * define DMA window. For kdump, there will at least be default window or DDW
+	 * or both.
+	 */
 
 	ppci = PCI_DN(pdn);
 
@@ -771,13 +796,24 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	if (!ppci->table_group) {
 		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
 		tbl = ppci->table_group->tables[0];
-		if (dma_window) {
-			iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
-						  ppci->table_group, dma_window);
 
-			if (!iommu_init_table(tbl, ppci->phb->node, 0, 0))
-				panic("Failed to initialize iommu table");
-		}
+		iommu_table_setparms_common(tbl, ppci->phb->bus->number,
+				be32_to_cpu(prop.liobn),
+				be64_to_cpu(prop.dma_base),
+				1ULL << be32_to_cpu(prop.window_shift),
+				be32_to_cpu(prop.tce_shift), NULL,
+				&iommu_table_lpar_multi_ops);
+
+		/* Only for normal boot with default window. Doesn't matter even
+		 * if we set these with DDW which is 64bit during kdump, since
+		 * these will not be used during kdump.
+		 */
+		ppci->table_group->tce32_start = be64_to_cpu(prop.dma_base);
+		ppci->table_group->tce32_size = 1 << be32_to_cpu(prop.window_shift);
+
+		if (!iommu_init_table(tbl, ppci->phb->node, 0, 0))
+			panic("Failed to initialize iommu table");
+
 		iommu_register_group(ppci->table_group,
 				pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->table_group);
@@ -968,6 +1004,12 @@ static void find_existing_ddw_windows_named(const char *name)
 			continue;
 		}
 
+		/* If at the time of system initialization, there are DDWs in OF,
+		 * it means this is during kexec. DDW could be direct or dynamic.
+		 * We will just mark DDWs as "dynamic" since this is kdump path,
+		 * no need to worry about perforance. ddw_list_new_entry() will
+		 * set window->direct = false.
+		 */
 		window = ddw_list_new_entry(pdn, dma64);
 		if (!window) {
 			of_node_put(pdn);
@@ -1524,8 +1566,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	const __be32 *dma_window = NULL;
 	struct pci_dn *pci;
+	struct dynamic_dma_window_prop prop;
 
 	pr_debug("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
 
@@ -1538,7 +1580,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	pr_debug("  node is %pOF\n", dn);
 
-	pdn = pci_dma_find(dn, &dma_window);
+	pdn = pci_dma_find(dn, &prop);
 	if (!pdn || !PCI_DN(pdn)) {
 		printk(KERN_WARNING "pci_dma_dev_setup_pSeriesLP: "
 		       "no DMA window found for pci dev=%s dn=%pOF\n",
@@ -1551,8 +1593,20 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (!pci->table_group) {
 		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
 		tbl = pci->table_group->tables[0];
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
-				pci->table_group, dma_window);
+
+		iommu_table_setparms_common(tbl, pci->phb->bus->number,
+				be32_to_cpu(prop.liobn),
+				be64_to_cpu(prop.dma_base),
+				1ULL << be32_to_cpu(prop.window_shift),
+				be32_to_cpu(prop.tce_shift), NULL,
+				&iommu_table_lpar_multi_ops);
+
+		/* Only for normal boot with default window. Doesn't matter even
+		 * if we set these with DDW which is 64bit during kdump, since
+		 * these will not be used during kdump.
+		 */
+		pci->table_group->tce32_start = be64_to_cpu(prop.dma_base);
+		pci->table_group->tce32_size = 1 << be32_to_cpu(prop.window_shift);
 
 		iommu_init_table(tbl, pci->phb->node, 0, 0);
 		iommu_register_group(pci->table_group,
-- 
2.43.0




