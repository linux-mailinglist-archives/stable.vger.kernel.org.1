Return-Path: <stable+bounces-200274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF80CAAE49
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 22:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE9A43008311
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A102DEA93;
	Sat,  6 Dec 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qel9NZ7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283A2DEA8C;
	Sat,  6 Dec 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057225; cv=none; b=EJoUXeTyw54y62/PDJnOJPMA6BoL5lctxA42wu+p+1OjNvMg0MGTnPQizVufocsQEMhGFS2PGg9CINDH5COqBDrcY+/z93z9O1ebIlYBs2FbJd5kdXv5t0FVNg8GSIz2tCRIdzrtABlZhsGMdwUGdL5JWfIIY+K2WhXEFt+MyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057225; c=relaxed/simple;
	bh=88Zbl99e03HCBM5p35nX5sppXnml5ISMiedJSph9urI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW2mSwJdVRx4T0sR0+TiBJhy2EzStgcSK57XGEoqaTOD++olYkcNgzQXyVOzG1p+sTusTi9/dIR9USxArHUu8eiH9P9L1UG+m8cEdyLPfcJWzb7UXEbYBaLk03XIXqHD6+YIbvy41u5TMhnUnjcLThfmjlcJAAXBZFYsRyM3cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qel9NZ7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F0EC4AF09;
	Sat,  6 Dec 2025 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765057225;
	bh=88Zbl99e03HCBM5p35nX5sppXnml5ISMiedJSph9urI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qel9NZ7t6BWgN3b3se2q2DD62Y0MfBABuWjTKQHYIPS/tNDicdZqLYWs3UfWmo8qV
	 2Mh6T7exEqx8sXbC89MpSOSaZ8NqlkFXTFohbqJuTxMtxJMZqQ/Ja4YBN/XnqKWQPI
	 XiU18QOgRde6GEDhwdBihtsGcloKeRJ1FdiSyaEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.11
Date: Sun,  7 Dec 2025 06:39:48 +0900
Message-ID: <2025120747-manatee-scuba-a69c@gregkh>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025120747-gradation-spotless-6d31@gregkh>
References: <2025120747-gradation-spotless-6d31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 2b8d9e95f50c..d977c277e44f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 17
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 6de224dd2bb9..6eb80f867f50 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -339,7 +339,7 @@ sai3: sai@2030000 {
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x02030000 0x4000>;
-					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
 						 <&clks IMX6UL_CLK_SAI3>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 9b114bed084b..0596457e8023 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -27,8 +27,8 @@ eqos: ethernet@5b050000 {
 		compatible = "nxp,imx8dxl-dwmac-eqos", "snps,dwmac-5.10a";
 		reg = <0x5b050000 0x10000>;
 		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq", "eth_wake_irq";
 		clocks = <&eqos_lpcg IMX_LPCG_CLK_4>,
 			 <&eqos_lpcg IMX_LPCG_CLK_6>,
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
index bbc6abb0fdf2..e04d59750995 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
@@ -54,3 +54,8 @@ pcie0_ep: pcie-ep@5f010000 {
 		interrupt-names = "dma";
 	};
 };
+
+&pcieb_ep {
+	interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "dma";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 95523c538135..5f1cbc9be1a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -217,8 +217,8 @@ mux-controller {
 		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_typec_mux>;
-		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
-		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_LOW>;
 		orientation-switch;
 
 		port {
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 4d529ff7ba51..b9a66fc146c9 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -197,8 +197,6 @@ static int __init acpi_fadt_sanity_check(void)
  */
 void __init acpi_boot_table_init(void)
 {
-	int ret;
-
 	/*
 	 * Enable ACPI instead of device tree unless
 	 * - ACPI has been disabled explicitly (acpi=off), or
@@ -252,12 +250,10 @@ void __init acpi_boot_table_init(void)
 		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
 		 * table as default serial console.
 		 */
-		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
+		acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
-			pr_info("Use ACPI SPCR as default console: No\n");
-		else
-			pr_info("Use ACPI SPCR as default console: Yes\n");
+		pr_info("Use ACPI SPCR as default console: %s\n",
+				param_acpi_nospcr ? "No" : "Yes");
 
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 347126dc010d..44a662536148 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -12,9 +12,11 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/export.h>
+#include <linux/sort.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu-type.h>
@@ -508,58 +510,95 @@ static int __init set_ntlb(char *str)
 
 __setup("ntlb=", set_ntlb);
 
-/* Initialise all TLB entries with unique values */
-static void r4k_tlb_uniquify(void)
+
+/* Comparison function for EntryHi VPN fields.  */
+static int r4k_vpn_cmp(const void *a, const void *b)
 {
-	int entry = num_wired_entries();
+	long v = *(unsigned long *)a - *(unsigned long *)b;
+	int s = sizeof(long) > sizeof(int) ? sizeof(long) * 8 - 1: 0;
+	return s ? (v != 0) | v >> s : v;
+}
+
+/*
+ * Initialise all TLB entries with unique values that do not clash with
+ * what we have been handed over and what we'll be using ourselves.
+ */
+static void __ref r4k_tlb_uniquify(void)
+{
+	int tlbsize = current_cpu_data.tlbsize;
+	bool use_slab = slab_is_available();
+	int start = num_wired_entries();
+	phys_addr_t tlb_vpn_size;
+	unsigned long *tlb_vpns;
+	unsigned long vpn_mask;
+	int cnt, ent, idx, i;
+
+	vpn_mask = GENMASK(cpu_vmbits - 1, 13);
+	vpn_mask |= IS_ENABLED(CONFIG_64BIT) ? 3ULL << 62 : 1 << 31;
+
+	tlb_vpn_size = tlbsize * sizeof(*tlb_vpns);
+	tlb_vpns = (use_slab ?
+		    kmalloc(tlb_vpn_size, GFP_KERNEL) :
+		    memblock_alloc_raw(tlb_vpn_size, sizeof(*tlb_vpns)));
+	if (WARN_ON(!tlb_vpns))
+		return; /* Pray local_flush_tlb_all() is good enough. */
 
 	htw_stop();
+
+	for (i = start, cnt = 0; i < tlbsize; i++, cnt++) {
+		unsigned long vpn;
+
+		write_c0_index(i);
+		mtc0_tlbr_hazard();
+		tlb_read();
+		tlb_read_hazard();
+		vpn = read_c0_entryhi();
+		vpn &= vpn_mask & PAGE_MASK;
+		tlb_vpns[cnt] = vpn;
+
+		/* Prevent any large pages from overlapping regular ones.  */
+		write_c0_pagemask(read_c0_pagemask() & PM_DEFAULT_MASK);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+		tlbw_use_hazard();
+	}
+
+	sort(tlb_vpns, cnt, sizeof(tlb_vpns[0]), r4k_vpn_cmp, NULL);
+
+	write_c0_pagemask(PM_DEFAULT_MASK);
 	write_c0_entrylo0(0);
 	write_c0_entrylo1(0);
 
-	while (entry < current_cpu_data.tlbsize) {
-		unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
-		unsigned long asid = 0;
-		int idx;
+	idx = 0;
+	ent = tlbsize;
+	for (i = start; i < tlbsize; i++)
+		while (1) {
+			unsigned long entryhi, vpn;
 
-		/* Skip wired MMID to make ginvt_mmid work */
-		if (cpu_has_mmid)
-			asid = MMID_KERNEL_WIRED + 1;
+			entryhi = UNIQUE_ENTRYHI(ent);
+			vpn = entryhi & vpn_mask & PAGE_MASK;
 
-		/* Check for match before using UNIQUE_ENTRYHI */
-		do {
-			if (cpu_has_mmid) {
-				write_c0_memorymapid(asid);
-				write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+			if (idx >= cnt || vpn < tlb_vpns[idx]) {
+				write_c0_entryhi(entryhi);
+				write_c0_index(i);
+				mtc0_tlbw_hazard();
+				tlb_write_indexed();
+				ent++;
+				break;
+			} else if (vpn == tlb_vpns[idx]) {
+				ent++;
 			} else {
-				write_c0_entryhi(UNIQUE_ENTRYHI(entry) | asid);
+				idx++;
 			}
-			mtc0_tlbw_hazard();
-			tlb_probe();
-			tlb_probe_hazard();
-			idx = read_c0_index();
-			/* No match or match is on current entry */
-			if (idx < 0 || idx == entry)
-				break;
-			/*
-			 * If we hit a match, we need to try again with
-			 * a different ASID.
-			 */
-			asid++;
-		} while (asid < asid_mask);
-
-		if (idx >= 0 && idx != entry)
-			panic("Unable to uniquify TLB entry %d", idx);
-
-		write_c0_index(entry);
-		mtc0_tlbw_hazard();
-		tlb_write_indexed();
-		entry++;
-	}
+		}
 
 	tlbw_use_hazard();
 	htw_start();
 	flush_micro_tlb();
+	if (use_slab)
+		kfree(tlb_vpns);
+	else
+		memblock_free(tlb_vpns, tlb_vpn_size);
 }
 
 /*
@@ -602,6 +641,7 @@ static void r4k_tlb_configure(void)
 
 	/* From this point on the ARC firmware is dead.	 */
 	r4k_tlb_uniquify();
+	local_flush_tlb_all();
 
 	/* Did I tell you that ARC SUCKS?  */
 }
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 6367112e614a..a7442a508433 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -28,7 +28,7 @@ cpu0: cpu@0 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
 					       "zifencei", "zihpm", "xtheadvector";
-			thead,vlenb = <128>;
+			thead,vlenb = <16>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..38f7102e2dac 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2787,13 +2787,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_callchain_store(entry, regs->ip))
-		return;
-
-	if (perf_hw_regs(regs))
+	if (perf_hw_regs(regs)) {
+		if (perf_callchain_store(entry, regs->ip))
+			return;
 		unwind_start(&state, current, regs, NULL);
-	else
+	} else {
 		unwind_start(&state, current, NULL, (void *)regs->sp);
+	}
 
 	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a722446ec73d..fa683bb7f0b4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2711,9 +2711,21 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+	struct btmtk_data *btmtk_data;
 	int err;
 
+	if (!data->hdev)
+		return;
+
+	btmtk_data = hci_get_priv(data->hdev);
+	if (!btmtk_data)
+		return;
+
+	if (!btmtk_data->isopkt_intf) {
+		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
+		return;
+	}
+
 	/*
 	 * The function usb_driver_claim_interface() is documented to need
 	 * locks held if it's not called from a probe routine. The code here
@@ -2735,17 +2747,30 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct btmtk_data *btmtk_data;
+
+	if (!hdev)
+		return;
+
+	btmtk_data = hci_get_priv(hdev);
+	if (!btmtk_data)
+		return;
 
 	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 		clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
 
-		dev_kfree_skb_irq(btmtk_data->isopkt_skb);
-		btmtk_data->isopkt_skb = NULL;
-		usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
-		usb_driver_release_interface(&btusb_driver,
-					     btmtk_data->isopkt_intf);
+		if (btmtk_data->isopkt_skb) {
+			dev_kfree_skb_irq(btmtk_data->isopkt_skb);
+			btmtk_data->isopkt_skb = NULL;
+		}
+
+		if (btmtk_data->isopkt_intf) {
+			usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
+			usb_driver_release_interface(&btusb_driver,
+						     btmtk_data->isopkt_intf);
+			btmtk_data->isopkt_intf = NULL;
+		}
 	}
 
 	clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1a299d1f350b..19d457ae4c3b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -451,7 +451,7 @@ static void mchp_tc_irq_remove(void *ptr)
 static int mchp_tc_irq_enable(struct counter_device *const counter, int irq)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
-	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, 0,
+	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, IRQF_SHARED,
 				   dev_name(counter->parent), counter);
 
 	if (ret < 0)
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..00f58e27f6de 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -134,6 +134,7 @@ struct stratix10_svc_data {
  * @complete_status: state for completion
  * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -150,6 +151,7 @@ struct stratix10_svc_controller {
 	struct completion complete_status;
 	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1206,6 +1208,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1237,8 +1240,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_fcs_dev;
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -1256,8 +1257,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	of_platform_depopulate(ctrl->dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aaee97cd9a10..a713d5e6e401 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2604,6 +2604,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "navi12";
 		break;
 	case CHIP_CYAN_SKILLFISH:
+		if (adev->mman.discovery_bin)
+			return 0;
 		chip_name = "cyan_skillfish";
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 97b562a79ea8..4814be022f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -597,6 +597,9 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		/* reserve engine 5 for firmware */
 		if (adev->enable_mes)
 			vm_inv_engs[i] &= ~(1 << 5);
+		/* reserve engine 6 for uni mes */
+		if (adev->enable_uni_mes)
+			vm_inv_engs[i] &= ~(1 << 6);
 		/* reserve mmhub engine 3 for firmware */
 		if (adev->enable_umsch_mm)
 			vm_inv_engs[i] &= ~(1 << 3);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c39bb06ebda1..17638952cd27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1056,7 +1056,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked && vm->is_compute_context) {
+	if (!params->unlocked) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f06c918f5a33..b259439a3205 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4898,6 +4898,21 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	struct dc_link *link;
 	u32 brightness;
 	bool rc, reallow_idle = false;
+	struct drm_connector *connector;
+
+	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		if (aconnector->bl_idx != bl_idx)
+			continue;
+
+		/* if connector is off, save the brightness for next time it's on */
+		if (!aconnector->base.encoder) {
+			dm->brightness[bl_idx] = user_brightness;
+			dm->actual_brightness[bl_idx] = 0;
+			return;
+		}
+	}
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
 	caps = &dm->backlight_caps[bl_idx];
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 7ed7027150d3..91cda9c9d748 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -996,8 +996,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
 	struct i2c_adapter *ddc;
-	int retry = 3;
-	enum dc_edid_status edid_status;
+	int retry = 25;
+	enum dc_edid_status edid_status = EDID_NO_RESPONSE;
 	const struct drm_edid *drm_edid;
 	const struct edid *edid;
 
@@ -1027,7 +1027,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		}
 
 		if (!drm_edid)
-			return EDID_NO_RESPONSE;
+			continue;
 
 		edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 		if (!edid ||
@@ -1045,7 +1045,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 						&sink->dc_edid,
 						&sink->edid_caps);
 
-	} while (edid_status == EDID_BAD_CHECKSUM && --retry > 0);
+	} while ((edid_status == EDID_BAD_CHECKSUM || edid_status == EDID_NO_RESPONSE) && --retry > 0);
 
 	if (edid_status != EDID_OK)
 		DRM_ERROR("EDID err: %d, on connector: %s",
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9ac2d41f8fca..0a46e834357a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -705,9 +705,14 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 {
 	uint8_t i;
 	bool ret = false;
-	struct dc  *dc = stream->ctx->dc;
-	struct resource_context *res_ctx =
-		&dc->current_state->res_ctx;
+	struct dc  *dc;
+	struct resource_context *res_ctx;
+
+	if (!stream->ctx)
+		return false;
+
+	dc = stream->ctx->dc;
+	res_ctx = &dc->current_state->res_ctx;
 
 	dc_exit_ips_for_hw_access(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 537f53811460..39de51cbbde9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -671,7 +671,6 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index d938170ebabd..e3525e41c5e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3060,8 +3060,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0fe763704945..b95b98cc2553 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -968,8 +968,6 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index cb80b4599936..8c8682f743d6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2458,6 +2458,7 @@ void link_set_dpms_on(
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
 		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
@@ -2501,6 +2502,8 @@ void link_set_dpms_on(
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 	// Enable VPG before building infoframe
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 6ffc74fc9dcd..ad088d70e189 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -44,11 +44,6 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link) {}
 
-static void virtual_stream_encoder_lvds_set_stream_attribute(
-	struct stream_encoder *enc,
-	struct dc_crtc_timing *crtc_timing)
-{}
-
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
@@ -120,8 +115,6 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
-	.lvds_set_stream_attribute =
-		virtual_stream_encoder_lvds_set_stream_attribute,
 	.set_throttled_vcp_size =
 		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..1f0aba28ad1e 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -179,7 +179,6 @@ struct sii902x {
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
-	bool sink_is_hdmi;
 	u32 bus_width;
 
 	/*
@@ -315,8 +314,6 @@ static int sii902x_get_modes(struct drm_connector *connector)
 		drm_edid_free(drm_edid);
 	}
 
-	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
-
 	return num;
 }
 
@@ -342,9 +339,17 @@ static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
 					 struct drm_atomic_state *state)
 {
 	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	struct drm_connector *connector;
+	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (connector && connector->display_info.is_hdmi)
+		output_mode = SII902X_SYS_CTRL_OUTPUT_HDMI;
 
 	mutex_lock(&sii902x->mutex);
 
+	regmap_update_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA,
+			   SII902X_SYS_CTRL_OUTPUT_MODE, output_mode);
 	regmap_update_bits(sii902x->regmap, SII902X_PWR_STATE_CTRL,
 			   SII902X_AVI_POWER_STATE_MSK,
 			   SII902X_AVI_POWER_STATE_D(0));
@@ -359,16 +364,12 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
 				    const struct drm_display_mode *adj)
 {
 	struct sii902x *sii902x = bridge_to_sii902x(bridge);
-	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;
 	struct regmap *regmap = sii902x->regmap;
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct hdmi_avi_infoframe frame;
 	u16 pixel_clock_10kHz = adj->clock / 10;
 	int ret;
 
-	if (sii902x->sink_is_hdmi)
-		output_mode = SII902X_SYS_CTRL_OUTPUT_HDMI;
-
 	buf[0] = pixel_clock_10kHz & 0xff;
 	buf[1] = pixel_clock_10kHz >> 8;
 	buf[2] = drm_mode_vrefresh(adj);
@@ -384,11 +385,6 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
 
 	mutex_lock(&sii902x->mutex);
 
-	ret = regmap_update_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA,
-				 SII902X_SYS_CTRL_OUTPUT_MODE, output_mode);
-	if (ret)
-		goto out;
-
 	ret = regmap_bulk_write(regmap, SII902X_TPI_VIDEO_DATA, buf, 10);
 	if (ret)
 		goto out;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 11a5b60cb9ce..0b3ee008523d 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -31,9 +31,7 @@
 
 #include <linux/console.h>
 #include <linux/export.h>
-#include <linux/pci.h>
 #include <linux/sysrq.h>
-#include <linux/vga_switcheroo.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
@@ -566,11 +564,6 @@ EXPORT_SYMBOL(drm_fb_helper_release_info);
  */
 void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
-	struct fb_info *info = fb_helper->info;
-	struct device *dev = info->device;
-
-	if (dev_is_pci(dev))
-		vga_switcheroo_client_fb_set(to_pci_dev(dev), NULL);
 	unregister_framebuffer(fb_helper->info);
 }
 EXPORT_SYMBOL(drm_fb_helper_unregister_info);
@@ -1632,7 +1625,6 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
 	struct drm_fb_helper_surface_size sizes;
-	struct fb_info *info;
 	int ret;
 
 	if (drm_WARN_ON(dev, !dev->driver->fbdev_probe))
@@ -1653,12 +1645,6 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 
 	strcpy(fb_helper->fb->comm, "[fbcon]");
 
-	info = fb_helper->info;
-
-	/* Set the fb info for vgaswitcheroo clients. Does nothing otherwise. */
-	if (dev_is_pci(info->device))
-		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 7035c1fc9033..350a282bc4a3 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5958,6 +5958,14 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 		return -EINVAL;
 	}
 
+	/* FIXME: selective fetch should be disabled for async flips */
+	if (new_crtc_state->enable_psr2_sel_fetch) {
+		drm_dbg_kms(display->drm,
+			    "[CRTC:%d:%s] async flip disallowed with PSR2 selective fetch\n",
+			    crtc->base.base.id, crtc->base.name);
+		return -EINVAL;
+	}
+
 	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
 					     new_plane_state, i) {
 		if (plane->pipe != crtc->pipe)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 179b7d27eb4c..624f4985ea46 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1274,12 +1274,6 @@ static bool intel_psr2_sel_fetch_config_valid(struct intel_dp *intel_dp,
 		return false;
 	}
 
-	if (crtc_state->uapi.async_flip) {
-		drm_dbg_kms(display->drm,
-			    "PSR2 sel fetch not enabled, async flip enabled\n");
-		return false;
-	}
-
 	return crtc_state->enable_psr2_sel_fetch = true;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index ee81691b3203..ce6bc7e7b135 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -143,12 +143,17 @@ struct sti_vtg {
 struct sti_vtg *of_vtg_find(struct device_node *np)
 {
 	struct platform_device *pdev;
+	struct sti_vtg *vtg;
 
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return NULL;
 
-	return (struct sti_vtg *)platform_get_drvdata(pdev);
+	vtg = platform_get_drvdata(pdev);
+
+	put_device(&pdev->dev);
+
+	return vtg;
 }
 
 static void vtg_reset(struct sti_vtg *vtg)
diff --git a/drivers/gpu/drm/xe/xe_gt_clock.c b/drivers/gpu/drm/xe/xe_gt_clock.c
index 4f011d1573c6..f65d1edd0567 100644
--- a/drivers/gpu/drm/xe/xe_gt_clock.c
+++ b/drivers/gpu/drm/xe/xe_gt_clock.c
@@ -93,11 +93,6 @@ int xe_gt_clock_init(struct xe_gt *gt)
 	return 0;
 }
 
-static u64 div_u64_roundup(u64 n, u32 d)
-{
-	return div_u64(n + d - 1, d);
-}
-
 /**
  * xe_gt_clock_interval_to_ms - Convert sampled GT clock ticks to msec
  *
@@ -108,5 +103,5 @@ static u64 div_u64_roundup(u64 n, u32 d)
  */
 u64 xe_gt_clock_interval_to_ms(struct xe_gt *gt, u64 count)
 {
-	return div_u64_roundup(count * MSEC_PER_SEC, gt->info.reference_clock);
+	return mul_u64_u32_div(count, MSEC_PER_SEC, gt->info.reference_clock);
 }
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 75ac0c424476..d0c7ab6396a9 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -237,6 +237,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
 	spin_lock_init(&ct->dead.lock);
 	INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
+	stack_depot_init();
+#endif
 #endif
 	init_waitqueue_head(&ct->wq);
 	init_waitqueue_head(&ct->g2h_fence_wq);
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 2e00fd51b4d5..5fc7f814b907 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -56,6 +56,8 @@
 #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
 #define ADXL355_SELF_TEST_REG		0x2E
 #define ADXL355_RESET_REG		0x2F
+#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
+#define ADXL355_SHADOW_REG_COUNT	5
 
 #define ADXL355_DEVID_AD_VAL		0xAD
 #define ADXL355_DEVID_MST_VAL		0x1D
@@ -294,7 +296,12 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
 static int adxl355_setup(struct adxl355_data *data)
 {
 	unsigned int regval;
+	int retries = 5; /* the number is chosen based on empirical reasons */
 	int ret;
+	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
+
+	if (!shadow_regs)
+		return -ENOMEM;
 
 	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
 	if (ret)
@@ -321,14 +328,41 @@ static int adxl355_setup(struct adxl355_data *data)
 	if (regval != ADXL355_PARTID_VAL)
 		dev_warn(data->dev, "Invalid DEV ID 0x%02x\n", regval);
 
-	/*
-	 * Perform a software reset to make sure the device is in a consistent
-	 * state after start-up.
-	 */
-	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
+	/* Read shadow registers to be compared after reset */
+	ret = regmap_bulk_read(data->regmap,
+			       ADXL355_BASE_ADDR_SHADOW_REG,
+			       shadow_regs, ADXL355_SHADOW_REG_COUNT);
 	if (ret)
 		return ret;
 
+	do {
+		if (--retries == 0) {
+			dev_err(data->dev, "Shadow registers mismatch\n");
+			return -EIO;
+		}
+
+		/*
+		 * Perform a software reset to make sure the device is in a consistent
+		 * state after start-up.
+		 */
+		ret = regmap_write(data->regmap, ADXL355_RESET_REG,
+				   ADXL355_RESET_CODE);
+		if (ret)
+			return ret;
+
+		/* Wait at least 5ms after software reset */
+		usleep_range(5000, 10000);
+
+		/* Read shadow registers for comparison */
+		ret = regmap_bulk_read(data->regmap,
+				       ADXL355_BASE_ADDR_SHADOW_REG,
+				       data->buffer.buf,
+				       ADXL355_SHADOW_REG_COUNT);
+		if (ret)
+			return ret;
+	} while (memcmp(shadow_regs, data->buffer.buf,
+			ADXL355_SHADOW_REG_COUNT));
+
 	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index be5fbb0c5d29..100d6b847074 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -526,6 +526,10 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	const struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	/* We do not always have an IRQ */
+	if (data->irq <= 0)
+		return 0;
+
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
@@ -1699,6 +1703,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	}
 
 	if (irq > 0) {
+		data->irq = irq;
 		ret = devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 7a7baf52e595..e8f26198359f 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -58,6 +58,7 @@ enum bmc150_accel_trigger_id {
 
 struct bmc150_accel_data {
 	struct regmap *regmap;
+	int irq;
 	struct regulator_bulk_data regulators[2];
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a22470..d8bee6a4215a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -385,7 +385,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 
-	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index ed35d2a8bbf1..57c0e5d80c73 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1196,10 +1196,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 	int ret, i;
 
 	for (i = 0; i < st->num_channels; i++) {
-
-		if (indio_dev->channels[i].type != IIO_VOLTAGE)
-			continue;
-
 		/*
 		 * For calibration the OFFSET register should hold its reset default
 		 * value. For the GAIN register there is no such requirement but
@@ -1209,6 +1205,14 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		st->channels[i].cfg.calibration_offset = 0x800000;
 		st->channels[i].cfg.calibration_gain = st->gain_default;
 
+		/*
+		 * Only the main voltage input channels are important enough
+		 * to be automatically calibrated here. For everything else,
+		 * just use the default values set above.
+		 */
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
 		/*
 		 * Full-scale calibration isn't supported at gain 1, so skip in
 		 * that case. Note that untypically full-scale calibration has
diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index dda2986ccda0..50a6ff7c8b1c 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index fa251dc1aae6..bfd908deefc0 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1227,6 +1227,14 @@ static int ad7380_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the sequencer is required to read all channels, we need to
+	 * trigger twice per sample period in order to read one complete set
+	 * of samples.
+	 */
+	if (st->seq)
+		config.periodic.frequency_hz *= 2;
+
 	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
 	if (ret)
 		spi_unoptimize_message(&st->offload_msg);
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad9738228b7f..2bf3a09ac6b0 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -300,7 +300,7 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 		return IIO_VAL_INT;
 	case RTQ6056_REG_SHUNTVOLT:
 	case RTQ6056_REG_CURRENT:
-		*val = sign_extend32(regval, 16);
+		*val = sign_extend32(regval, 15);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index c2d21eecafe7..a07461a08d00 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -725,9 +725,8 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->src = val;
 
-	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
-	if (ret != -EINVAL)
-		df_ch->alt_si = 0;
+	if (fwnode_property_present(node, "st,adc-alt-channel"))
+		df_ch->alt_si = 1;
 
 	if (adc->dev_data->type == DFSDM_IIO) {
 		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index ee294a775e8a..7a7a9d37339b 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -786,6 +786,12 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enqueue_dmabuf, "IIO_DMA_BUFFER");
 
+struct device *iio_dma_buffer_get_dma_dev(struct iio_buffer *buffer)
+{
+	return iio_buffer_to_queue(buffer)->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_get_dma_dev, "IIO_DMA_BUFFER");
+
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index e9d9a7d39fe1..27dd56334345 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -177,6 +177,8 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.lock_queue = iio_dma_buffer_lock_queue,
 	.unlock_queue = iio_dma_buffer_unlock_queue,
 
+	.get_dma_dev = iio_dma_buffer_get_dma_dev,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1e167dc673ca..da09c9f3ceb6 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to setup spi\n");
-		return ret;
+		goto err_setup_spi;
 	}
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
@@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
 err_setup_irq:
 	mutex_destroy(&data->pending_lock);
 	mutex_destroy(&data->comm_lock);
+err_setup_spi:
+	mfd_remove_devices(&spi->dev);
 
 	dev_err(&spi->dev, "Probe failed!\n");
 
diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8..78b2c171c8da 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -72,6 +72,9 @@
 #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
 #define HDC3020_MAX_HUM_MICRO		99220264
 
+/* Divide 65535 from the datasheet by 5 to avoid overflows */
+#define HDC3020_THRESH_FRACTION		(65535 / 5)
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	struct gpio_desc *reset_gpio;
@@ -301,9 +304,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175 * MILLI;
 		else
-			*val = 100;
+			*val = 100 * MILLI;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:
@@ -376,15 +379,18 @@ static int hdc3020_thresh_get_temp(u16 thresh)
 	int temp;
 
 	/*
-	 * Get the temperature threshold from 9 LSBs, shift them to get
-	 * the truncated temperature threshold representation and
-	 * calculate the threshold according to the formula in the
-	 * datasheet. Result is degree celsius scaled by 65535.
+	 * Get the temperature threshold from 9 LSBs, shift them to get the
+	 * truncated temperature threshold representation and calculate the
+	 * threshold according to the explicit formula in the datasheet:
+	 * T(C) = -45 + (175 * temp) / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is degree
+	 * celsius scaled by HDC3020_THRESH_FRACTION.
 	 */
 	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
 	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
 
-	return -2949075 + (175 * temp);
+	return -2949075 / 5 + (175 / 5 * temp);
 }
 
 static int hdc3020_thresh_get_hum(u16 thresh)
@@ -394,13 +400,16 @@ static int hdc3020_thresh_get_hum(u16 thresh)
 	/*
 	 * Get the humidity threshold from 7 MSBs, shift them to get the
 	 * truncated humidity threshold representation and calculate the
-	 * threshold according to the formula in the datasheet. Result is
-	 * percent scaled by 65535.
+	 * threshold according to the explicit formula in the datasheet:
+	 * RH(%) = 100 * hum / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is percent
+	 * scaled by HDC3020_THRESH_FRACTION.
 	 */
 	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
 	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
 
-	return hum * 100;
+	return hum * 100 / 5;
 }
 
 static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
@@ -455,8 +464,8 @@ int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
 	else
 		s_clr = s_thresh + s_hyst;
 
-	/* Divide by 65535 to get units of micro */
-	return div_s64(s_clr, 65535);
+	/* Divide by HDC3020_THRESH_FRACTION to get units of micro */
+	return div_s64(s_clr, HDC3020_THRESH_FRACTION);
 }
 
 static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
@@ -507,7 +516,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 
 	clr = ret;
 	/* Scale value to include decimal part into calculations */
-	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+	s_val = (val < 0) ? (val * 1000 - val2) : (val * 1000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
 		switch (info) {
@@ -523,7 +532,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Set old hysteresis */
@@ -532,16 +542,17 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_temp returns temperature
-			 * in degree celsius scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * in degree celsius scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			/*
 			 * Units of s_val are in micro degree celsius, scale by
-			 * 65535 to get same units as s_thresh.
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
 			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
 			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
@@ -565,7 +576,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Try to set old hysteresis */
@@ -574,15 +586,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_hum returns relative
-			 * humidity in percent scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * humidity in percent scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			/*
-			 * Units of s_val are in micro percent, scale by 65535
-			 * to get same units as s_thresh.
+			 * Units of s_val are in micro percent, scale by
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, 0);
 			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
@@ -630,7 +643,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 		thresh = hdc3020_thresh_get_temp(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -638,18 +651,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_temp(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
 		thresh = hdc3020_thresh_get_hum(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -657,12 +670,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_hum(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..381b016fa524 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -192,6 +192,22 @@ struct st_lsm6dsx_fifo_ops {
  * @fifo_en: Hw timer FIFO enable register info (addr + mask).
  * @decimator: Hw timer FIFO decimator register info (addr + mask).
  * @freq_fine: Difference in % of ODR with respect to the typical.
+ * @ts_sensitivity: Nominal timestamp sensitivity.
+ * @ts_trim_coeff: Coefficient for calculating the calibrated timestamp gain.
+ *                 This coefficient comes into play when linearizing the formula
+ *                 used to calculate the calibrated timestamp (please see the
+ *                 relevant formula in the AN for the specific IMU).
+ *                 For example, in the case of LSM6DSO we have:
+ *
+ *                  1 / (1 + x) ~= 1 - x (Taylor’s Series)
+ *                  ttrim[s] = 1 / (40000 * (1 + 0.0015 * val)) (from AN5192)
+ *                  ttrim[ns] ~= 25000 - 37.5 * val
+ *                  ttrim[ns] ~= 25000 - (37500 * val) / 1000
+ *
+ *                  so, replacing ts_sensitivity = 25000 and
+ *                  ts_trim_coeff = 37500
+ *
+ *                  ttrim[ns] ~= ts_sensitivity - (ts_trim_coeff * val) / 1000
  */
 struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg timer_en;
@@ -199,6 +215,8 @@ struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg fifo_en;
 	struct st_lsm6dsx_reg decimator;
 	u8 freq_fine;
+	u16 ts_sensitivity;
+	u16 ts_trim_coeff;
 };
 
 /**
@@ -252,6 +270,15 @@ struct st_lsm6dsx_event_settings {
 	u8 wakeup_src_x_mask;
 };
 
+enum st_lsm6dsx_sensor_id {
+	ST_LSM6DSX_ID_GYRO,
+	ST_LSM6DSX_ID_ACC,
+	ST_LSM6DSX_ID_EXT0,
+	ST_LSM6DSX_ID_EXT1,
+	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_MAX
+};
+
 enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
@@ -337,23 +364,14 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
-	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
-	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_ID_MAX];
+	struct st_lsm6dsx_reg batch[2];
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
 };
 
-enum st_lsm6dsx_sensor_id {
-	ST_LSM6DSX_ID_GYRO,
-	ST_LSM6DSX_ID_ACC,
-	ST_LSM6DSX_ID_EXT0,
-	ST_LSM6DSX_ID_EXT1,
-	ST_LSM6DSX_ID_EXT2,
-	ST_LSM6DSX_ID_MAX,
-};
-
 enum st_lsm6dsx_fifo_mode {
 	ST_LSM6DSX_FIFO_BYPASS = 0x0,
 	ST_LSM6DSX_FIFO_CONT = 0x6,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad49829e7..72d8af39a953 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,8 +94,6 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
-#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
-
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -983,6 +981,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -1196,6 +1196,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.event_settings = {
 			.enable_reg = {
@@ -1371,6 +1373,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x4f,
+			.ts_sensitivity = 21701,
+			.ts_trim_coeff = 28212,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -2248,20 +2252,13 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	}
 
 	/* calibrate timestamp sensitivity */
-	hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY;
+	hw->ts_gain = ts_settings->ts_sensitivity;
 	if (ts_settings->freq_fine) {
 		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
 		if (err < 0)
 			return err;
 
-		/*
-		 * linearize the AN5192 formula:
-		 * 1 / (1 + x) ~= 1 - x (Taylor’s Series)
-		 * ttrim[s] = 1 / (40000 * (1 + 0.0015 * val))
-		 * ttrim[ns] ~= 25000 - 37.5 * val
-		 * ttrim[ns] ~= 25000 - (37500 * val) / 1000
-		 */
-		hw->ts_gain -= ((s8)val * 37500) / 1000;
+		hw->ts_gain -= ((s8)val * ts_settings->ts_trim_coeff) / 1000;
 	}
 
 	return 0;
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27..96ea0f039dfb 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1623,19 +1623,28 @@ static int iio_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
 	return 0;
 }
 
+static struct device *iio_buffer_get_dma_dev(const struct iio_dev *indio_dev,
+					     struct iio_buffer *buffer)
+{
+	if (buffer->access->get_dma_dev)
+		return buffer->access->get_dma_dev(buffer);
+
+	return indio_dev->dev.parent;
+}
+
 static struct dma_buf_attachment *
 iio_buffer_find_attachment(struct iio_dev_buffer_pair *ib,
 			   struct dma_buf *dmabuf, bool nonblock)
 {
-	struct device *dev = ib->indio_dev->dev.parent;
 	struct iio_buffer *buffer = ib->buffer;
+	struct device *dma_dev = iio_buffer_get_dma_dev(ib->indio_dev, buffer);
 	struct dma_buf_attachment *attach = NULL;
 	struct iio_dmabuf_priv *priv;
 
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == dev
+		if (priv->attach->dev == dma_dev
 		    && priv->attach->dmabuf == dmabuf) {
 			attach = priv->attach;
 			break;
@@ -1653,6 +1662,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 {
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_buffer *buffer = ib->buffer;
+	struct device *dma_dev = iio_buffer_get_dma_dev(indio_dev, buffer);
 	struct dma_buf_attachment *attach;
 	struct iio_dmabuf_priv *priv, *each;
 	struct dma_buf *dmabuf;
@@ -1679,7 +1689,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 		goto err_free_priv;
 	}
 
-	attach = dma_buf_attach(dmabuf, indio_dev->dev.parent);
+	attach = dma_buf_attach(dmabuf, dma_dev);
 	if (IS_ERR(attach)) {
 		err = PTR_ERR(attach);
 		goto err_dmabuf_put;
@@ -1719,7 +1729,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	 * combo. If we do, refuse to attach.
 	 */
 	list_for_each_entry(each, &buffer->dmabufs, entry) {
-		if (each->attach->dev == indio_dev->dev.parent
+		if (each->attach->dev == dma_dev
 		    && each->attach->dmabuf == dmabuf) {
 			/*
 			 * We unlocked the reservation object, so going through
@@ -1758,6 +1768,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 {
 	struct iio_buffer *buffer = ib->buffer;
 	struct iio_dev *indio_dev = ib->indio_dev;
+	struct device *dma_dev = iio_buffer_get_dma_dev(indio_dev, buffer);
 	struct iio_dmabuf_priv *priv;
 	struct dma_buf *dmabuf;
 	int dmabuf_fd, ret = -EPERM;
@@ -1772,7 +1783,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == indio_dev->dev.parent
+		if (priv->attach->dev == dma_dev
 		    && priv->attach->dmabuf == dmabuf) {
 			list_del(&priv->entry);
 
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6cdc8ed53520..2078b810745b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1042,13 +1042,16 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us;
 	int ret;
 
-	/* Check if we are using a BME280 device */
-	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
-				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+	/* Constant part of the measurement time */
+	meas_time_us = BMP280_MEAS_OFFSET;
 
-	else
-		meas_time_us = 0;
+	/*
+	 * Check if we are using a BME280 device,
+	 * Humidity measurement time
+	 */
+	if (data->chip_info->oversampling_humid_avail)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 6f1010da221c..21d4a35538f6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -161,8 +161,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-	memcpy(vevent->event_data, event_data, data_len);
 	vevent->data_len = data_len;
+	memcpy(vevent->event_data, event_data, data_len);
 	veventq->num_events++;
 
 out_set_header:
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index c9dd8c42c0cd..3a28ab5c42e5 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -268,7 +268,7 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 		return 0;
 
 	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
-	if (!tdev->root_debugfs_dir) {
+	if (IS_ERR(tdev->root_debugfs_dir)) {
 		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
 		return -EINVAL;
 	}
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 654a60f63756..5791f80f995a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -92,6 +92,18 @@ struct gce_plat {
 	u32 gce_num;
 };
 
+static inline u32 cmdq_convert_gce_addr(dma_addr_t addr, const struct gce_plat *pdata)
+{
+	/* Convert DMA addr (PA or IOVA) to GCE readable addr */
+	return addr >> pdata->shift;
+}
+
+static inline dma_addr_t cmdq_revert_gce_addr(u32 addr, const struct gce_plat *pdata)
+{
+	/* Revert GCE readable addr to DMA addr (PA or IOVA) */
+	return (dma_addr_t)addr << pdata->shift;
+}
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -188,13 +200,12 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
 	struct cmdq_task *prev_task = list_last_entry(
 			&thread->task_busy_list, typeof(*task), list_entry);
 	u64 *prev_task_base = prev_task->pkt->va_base;
+	u32 gce_addr = cmdq_convert_gce_addr(task->pa_base, task->cmdq->pdata);
 
 	/* let previous task jump to this task */
 	dma_sync_single_for_cpu(dev, prev_task->pa_base,
 				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
-	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
-		(u64)CMDQ_JUMP_BY_PA << 32 |
-		(task->pa_base >> task->cmdq->pdata->shift);
+	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] = (u64)CMDQ_JUMP_BY_PA << 32 | gce_addr;
 	dma_sync_single_for_device(dev, prev_task->pa_base,
 				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
 
@@ -237,7 +248,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 				    struct cmdq_thread *thread)
 {
 	struct cmdq_task *task, *tmp, *curr_task = NULL;
-	u32 curr_pa, irq_flag, task_end_pa;
+	u32 irq_flag, gce_addr;
+	dma_addr_t curr_pa, task_end_pa;
 	bool err;
 
 	irq_flag = readl(thread->base + CMDQ_THR_IRQ_STATUS);
@@ -259,7 +271,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 	else
 		return;
 
-	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
+	gce_addr = readl(thread->base + CMDQ_THR_CURR_ADDR);
+	curr_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
@@ -378,7 +391,8 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
-	unsigned long curr_pa, end_pa;
+	u32 gce_addr;
+	dma_addr_t curr_pa, end_pa;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
@@ -402,20 +416,20 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 		 */
 		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
 
-		writel(task->pa_base >> cmdq->pdata->shift,
-		       thread->base + CMDQ_THR_CURR_ADDR);
-		writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->pdata->shift,
-		       thread->base + CMDQ_THR_END_ADDR);
+		gce_addr = cmdq_convert_gce_addr(task->pa_base, cmdq->pdata);
+		writel(gce_addr, thread->base + CMDQ_THR_CURR_ADDR);
+		gce_addr = cmdq_convert_gce_addr(task->pa_base + pkt->cmd_buf_size, cmdq->pdata);
+		writel(gce_addr, thread->base + CMDQ_THR_END_ADDR);
 
 		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
 		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
 		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
 	} else {
 		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
-		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) <<
-			cmdq->pdata->shift;
-		end_pa = readl(thread->base + CMDQ_THR_END_ADDR) <<
-			cmdq->pdata->shift;
+		gce_addr = readl(thread->base + CMDQ_THR_CURR_ADDR);
+		curr_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
+		gce_addr = readl(thread->base + CMDQ_THR_END_ADDR);
+		end_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
 		/* check boundary */
 		if (curr_pa == end_pa - CMDQ_INST_SIZE ||
 		    curr_pa == end_pa) {
@@ -646,6 +660,9 @@ static int cmdq_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	dma_set_coherent_mask(dev,
+			      DMA_BIT_MASK(sizeof(u32) * BITS_PER_BYTE + cmdq->pdata->shift));
+
 	cmdq->mbox.dev = dev;
 	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->pdata->thread_nr,
 					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0a00719b2482..ff292b9e0be9 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -276,9 +276,8 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
 	if (ret)
 		return ret;
 
-	val &= pchan->error.status_mask;
-	if (val) {
-		val &= ~pchan->error.status_mask;
+	if (val & pchan->error.status_mask) {
+		val &= pchan->error.preserve_mask;
 		pcc_chan_reg_write(&pchan->error, val);
 		return -EIO;
 	}
@@ -745,7 +744,8 @@ static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
 
 		ret = pcc_chan_reg_init(&pchan->error,
 					&pcct_ext->error_status_register,
-					0, 0, pcct_ext->error_status_mask,
+					~pcct_ext->error_status_mask, 0,
+					pcct_ext->error_status_mask,
 					"Error Status");
 	}
 	return ret;
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index d382a390d39a..72047b47a7a0 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -320,11 +320,7 @@ static int fec_alloc_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio)
 		if (fio->bufs[n])
 			continue;
 
-		fio->bufs[n] = mempool_alloc(&v->fec->prealloc_pool, GFP_NOWAIT);
-		if (unlikely(!fio->bufs[n])) {
-			DMERR("failed to allocate FEC buffer");
-			return -ENOMEM;
-		}
+		fio->bufs[n] = mempool_alloc(&v->fec->prealloc_pool, GFP_NOIO);
 	}
 
 	/* try to allocate the maximum number of buffers */
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e23a590af722..212e820255ef 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -289,6 +289,19 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
 	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
+static void dwcmshc_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	/* The dwcmshc does not comply with the SDHCI specification
+	 * regarding the "Software Reset for CMD line should clear 'Command
+	 * Complete' in the Normal Interrupt Status Register." Clear the bit
+	 * here to compensate for this quirk.
+	 */
+	if (mask & SDHCI_RESET_CMD)
+		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+}
+
 static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -832,15 +845,7 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2;
 
-	sdhci_reset(host, mask);
-
-	/* The T-Head 1520 SoC does not comply with the SDHCI specification
-	 * regarding the "Software Reset for CMD line should clear 'Command
-	 * Complete' in the Normal Interrupt Status Register." Clear the bit
-	 * here to compensate for this quirk.
-	 */
-	if (mask & SDHCI_RESET_CMD)
-		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+	dwcmshc_reset(host, mask);
 
 	if (priv->flags & FLAG_IO_FIXED_1V8) {
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -886,7 +891,7 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 
-	sdhci_reset(host, mask);
+	dwcmshc_reset(host, mask);
 
 	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
 		val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
@@ -958,7 +963,7 @@ static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
 	val |= SDHCI_INT_DATA_AVAIL;
 	sdhci_writel(host, val, SDHCI_INT_STATUS);
 
-	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 }
 
 static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= dwcmshc_get_max_clock,
-	.reset			= sdhci_reset,
+	.reset			= dwcmshc_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 	.irq			= dwcmshc_cqe_irq_handler,
 };
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 10064d7b7249..41ee169f80c5 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1058,7 +1058,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 
 	ret = most_register_interface(&mdev->iface);
 	if (ret)
-		goto err_free_busy_urbs;
+		return ret;
 
 	mutex_lock(&mdev->io_mutex);
 	if (le16_to_cpu(usb_dev->descriptor.idProduct) == USB_DEV_ID_OS81118 ||
@@ -1068,8 +1068,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		if (!mdev->dci) {
 			mutex_unlock(&mdev->io_mutex);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_busy_urbs;
+			return -ENOMEM;
 		}
 
 		mdev->dci->dev.init_name = "dci";
@@ -1078,18 +1077,15 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		mdev->dci->dev.release = release_dci;
 		if (device_register(&mdev->dci->dev)) {
 			mutex_unlock(&mdev->io_mutex);
+			put_device(&mdev->dci->dev);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_dci;
+			return -ENOMEM;
 		}
 		mdev->dci->usb_device = mdev->usb_device;
 	}
 	mutex_unlock(&mdev->io_mutex);
 	return 0;
-err_free_dci:
-	put_device(&mdev->dci->dev);
-err_free_busy_urbs:
-	kfree(mdev->busy_urbs);
+
 err_free_ep_address:
 	kfree(mdev->ep_address);
 err_free_cap:
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4f3ce948d74d..83a19b8cf5f1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -726,6 +726,11 @@ static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
 	rcar_canfd_update(val, val, addr);
 }
 
+static void rcar_canfd_clear_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, 0, addr);
+}
+
 static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
 {
 	rcar_canfd_update(mask, val, addr);
@@ -772,25 +777,6 @@ static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
 
-static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-{
-	if (gpriv->info->ch_interface_mode) {
-		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
-					    : RCANFD_GEN4_FDCFG_CLOE;
-
-		for_each_set_bit(ch, &gpriv->channels_mask,
-				 gpriv->info->max_channels)
-			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
-	} else {
-		if (gpriv->fdmode)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
-					   RCANFD_GRMCFG_RCMC);
-		else
-			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
-					     RCANFD_GRMCFG_RCMC);
-	}
-}
-
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
 	struct device *dev = &gpriv->pdev->dev;
@@ -823,6 +809,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* Set the controller into appropriate mode */
+	if (!gpriv->info->ch_interface_mode) {
+		if (gpriv->fdmode)
+			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
+					   RCANFD_GRMCFG_RCMC);
+		else
+			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
+					     RCANFD_GRMCFG_RCMC);
+	}
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -840,10 +836,23 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
-	}
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+		/* Set the controller into appropriate mode */
+		if (gpriv->info->ch_interface_mode) {
+			/* Do not set CLOE and FDOE simultaneously */
+			if (!gpriv->fdmode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_CLOE);
+			} else {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+			}
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4d245857ef1c..83476af8adb5 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -548,8 +548,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
 		goto out;
 
-	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
-	       (n < SJA1000_MAX_IRQ)) {
+	while ((n < SJA1000_MAX_IRQ) &&
+	       (isrc = priv->read_reg(priv, SJA1000_IR))) {
 
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 53bfd873de9b..0a7ba0942839 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -657,8 +657,8 @@ static irqreturn_t sun4i_can_interrupt(int irq, void *dev_id)
 	u8 isrc, status;
 	int n = 0;
 
-	while ((isrc = readl(priv->base + SUN4I_REG_INT_ADDR)) &&
-	       (n < SUN4I_CAN_MAX_IRQ)) {
+	while ((n < SUN4I_CAN_MAX_IRQ) &&
+	       (isrc = readl(priv->base + SUN4I_REG_INT_ADDR))) {
 		n++;
 		status = readl(priv->base + SUN4I_REG_STA_ADDR);
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 69b8d6da651b..8d8a610f9144 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -261,14 +261,21 @@ struct canfd_quirk {
 	u8 quirk;
 } __packed;
 
+/* struct gs_host_frame::echo_id == GS_HOST_FRAME_ECHO_ID_RX indicates
+ * a regular RX'ed CAN frame
+ */
+#define GS_HOST_FRAME_ECHO_ID_RX 0xffffffff
+
 struct gs_host_frame {
-	u32 echo_id;
-	__le32 can_id;
+	struct_group(header,
+		u32 echo_id;
+		__le32 can_id;
 
-	u8 can_dlc;
-	u8 channel;
-	u8 flags;
-	u8 reserved;
+		u8 can_dlc;
+		u8 channel;
+		u8 flags;
+		u8 reserved;
+	);
 
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
@@ -568,6 +575,37 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 	return len;
 }
 
+static unsigned int
+gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_frame *hf,
+			     unsigned int *data_length_p)
+{
+	unsigned int minimum_length, data_length = 0;
+
+	if (hf->flags & GS_CAN_FLAG_FD) {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX)
+			data_length = can_fd_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, canfd_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	} else {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX &&
+		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
+			data_length = can_cc_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, classic_can_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	}
+
+	*data_length_p = data_length;
+	return minimum_length;
+}
+
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
@@ -576,6 +614,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
+	unsigned int minimum_length, data_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -594,6 +633,15 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		return;
 	}
 
+	minimum_length = sizeof(hf->header);
+	if (urb->actual_length < minimum_length) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "short read (actual_length=%u, minimum_length=%u)\n",
+				    urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
 	/* device reports out of range channel id */
 	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
@@ -609,20 +657,33 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_running(netdev))
 		goto resubmit_urb;
 
-	if (hf->echo_id == -1) { /* normal rx */
+	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
+	if (urb->actual_length < minimum_length) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "short read (actual_length=%u, minimum_length=%u)\n",
+				   urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
+	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
-			cfd->len = can_fd_dlc2len(hf->can_dlc);
+			cfd->len = data_length;
 			if (hf->flags & GS_CAN_FLAG_BRS)
 				cfd->flags |= CANFD_BRS;
 			if (hf->flags & GS_CAN_FLAG_ESI)
 				cfd->flags |= CANFD_ESI;
 
-			memcpy(cfd->data, hf->canfd->data, cfd->len);
+			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
@@ -631,7 +692,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
 
-			memcpy(cf->data, hf->classic_can->data, 8);
+			memcpy(cf->data, hf->classic_can->data, data_length);
 
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
@@ -687,7 +748,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
 			  parent->pipe_in,
-			  hf, dev->parent->hf_size_rx,
+			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
@@ -750,8 +811,21 @@ static void gs_usb_xmit_callback(struct urb *urb)
 	struct gs_can *dev = txc->dev;
 	struct net_device *netdev = dev->netdev;
 
-	if (urb->status)
-		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
+	if (!urb->status)
+		return;
+
+	if (urb->status != -ESHUTDOWN && net_ratelimit())
+		netdev_info(netdev, "failed to xmit URB %u: %pe\n",
+			    txc->echo_id, ERR_PTR(urb->status));
+
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	can_free_echo_skb(netdev, txc->echo_id, NULL);
+	gs_free_tx_context(txc);
+	atomic_dec(&dev->active_tx_urbs);
+
+	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..1167d38344f1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 			 * for further details.
 			 */
 			if (tmp->len == 0) {
-				pos = round_up(pos,
+				pos = round_up(pos + 1,
 					       le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 				continue;
@@ -1732,7 +1732,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 		 * number of events in case of a heavy rx load on the bus.
 		 */
 		if (cmd->len == 0) {
-			pos = round_up(pos, le16_to_cpu
+			pos = round_up(pos + 1, le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 			continue;
 		}
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 933ae8dc6337..0c10351fe5eb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2587,8 +2587,8 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 
 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -EINVAL;
 				goto out;
 			}
 			ds->user_mii_bus->irq[phy] = irq;
@@ -2952,8 +2952,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);
-	if (pirq->irq_num < 0)
-		return pirq->irq_num;
+	if (!pirq->irq_num)
+		return -EINVAL;
 
 	return ksz_irq_common_setup(dev, pirq);
 }
@@ -3038,12 +3038,12 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds) {
 			ret = ksz_pirq_setup(dev, dp->index);
 			if (ret)
-				goto out_girq;
+				goto port_release;
 
 			if (dev->info->ptp_capable) {
 				ret = ksz_ptp_irq_setup(ds, dp->index);
 				if (ret)
-					goto out_pirq;
+					goto pirq_release;
 			}
 		}
 	}
@@ -3053,7 +3053,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
 				ret);
-			goto out_ptpirq;
+			goto port_release;
 		}
 	}
 
@@ -3076,17 +3076,16 @@ static int ksz_setup(struct dsa_switch *ds)
 out_ptp_clock_unregister:
 	if (dev->info->ptp_capable)
 		ksz_ptp_clock_unregister(ds);
-out_ptpirq:
-	if (dev->irq > 0 && dev->info->ptp_capable)
-		dsa_switch_for_each_user_port(dp, dev->ds)
-			ksz_ptp_irq_free(ds, dp->index);
-out_pirq:
-	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
 			ksz_irq_free(&dev->ports[dp->index].pirq);
-out_girq:
-	if (dev->irq > 0)
+		}
 		ksz_irq_free(&dev->girq);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 35fc21b1ee48..997e4a76d0a6 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1093,19 +1093,19 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
+	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
+	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	if (!ptpmsg_irq->num)
+		return -EINVAL;
 
 	ptpmsg_irq->port = port;
 	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[n]);
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1135,12 +1135,9 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
-
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
-	if (ptpirq->irq_num < 0) {
-		ret = ptpirq->irq_num;
+	if (!ptpirq->irq_num) {
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1159,12 +1156,11 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 out_ptp_msg:
 	free_irq(ptpirq->irq_num, ptpirq);
-	while (irq--)
+	while (irq--) {
 		free_irq(port->ptpmsg_irq[irq].num, &port->ptpmsg_irq[irq]);
-out:
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
 		irq_dispose_mapping(port->ptpmsg_irq[irq].num);
-
+	}
+out:
 	irq_domain_remove(ptpirq->domain);
 
 	return ret;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f674c400f05b..aa2145cf29a6 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1302,14 +1302,7 @@ static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
 	 * table, since this will be used for the clocking setup, and we no
 	 * longer need to store it in the static config (already told hardware
 	 * we want auto during upload phase).
-	 * Actually for the SGMII port, the MAC is fixed at 1 Gbps and
-	 * we need to configure the PCS only (if even that).
 	 */
-	if (priv->phy_mode[port] == PHY_INTERFACE_MODE_SGMII)
-		speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
-	else if (priv->phy_mode[port] == PHY_INTERFACE_MODE_2500BASEX)
-		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
-
 	mac[port].speed = speed;
 
 	return 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
index 1921741f7311..18b08277d2e1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
@@ -15,6 +15,7 @@
 
 #include "aq_hw.h"
 #include "aq_nic.h"
+#include "hw_atl/hw_atl_llh.h"
 
 void aq_hw_write_reg_bit(struct aq_hw_s *aq_hw, u32 addr, u32 msk,
 			 u32 shift, u32 val)
@@ -81,6 +82,27 @@ void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value)
 		lo_hi_writeq(value, hw->mmio + reg);
 }
 
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw)
+{
+	int err;
+	u32 val;
+
+	/* Invalidate Descriptor Cache to prevent writing to the cached
+	 * descriptors and to the data pointer of those descriptors
+	 */
+	hw_atl_rdm_rx_dma_desc_cache_init_tgl(hw);
+
+	err = aq_hw_err_from_flags(hw);
+	if (err)
+		goto err_exit;
+
+	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
+				  hw, val, val == 1, 1000U, 10000U);
+
+err_exit:
+	return err;
+}
+
 int aq_hw_err_from_flags(struct aq_hw_s *hw)
 {
 	int err = 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
index ffa6e4067c21..d89c63d88e4a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
@@ -35,6 +35,7 @@ u32 aq_hw_read_reg(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg(struct aq_hw_s *hw, u32 reg, u32 value);
 u64 aq_hw_read_reg64(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value);
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw);
 int aq_hw_err_from_flags(struct aq_hw_s *hw);
 int aq_hw_num_tcs(struct aq_hw_s *hw);
 int aq_hw_q_per_tc(struct aq_hw_s *hw);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..d23d23bed39f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -547,6 +547,11 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 
 		if (!buff->is_eop) {
 			unsigned int frag_cnt = 0U;
+
+			/* There will be an extra fragment */
+			if (buff->len > AQ_CFG_RX_HDR_SIZE)
+				frag_cnt++;
+
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 493432d036b9..c7895bfb2ecf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1198,26 +1198,9 @@ static int hw_atl_b0_hw_interrupt_moderation_set(struct aq_hw_s *self)
 
 static int hw_atl_b0_hw_stop(struct aq_hw_s *self)
 {
-	int err;
-	u32 val;
-
 	hw_atl_b0_hw_irq_disable(self, HW_ATL_B0_INT_MASK);
 
-	/* Invalidate Descriptor Cache to prevent writing to the cached
-	 * descriptors and to the data pointer of those descriptors
-	 */
-	hw_atl_rdm_rx_dma_desc_cache_init_tgl(self);
-
-	err = aq_hw_err_from_flags(self);
-
-	if (err)
-		goto err_exit;
-
-	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
-				  self, val, val == 1, 1000U, 10000U);
-
-err_exit:
-	return err;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 int hw_atl_b0_hw_ring_tx_stop(struct aq_hw_s *self, struct aq_ring_s *ring)
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index b0ed572e88c6..0ce9caae8799 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,7 +759,7 @@ static int hw_atl2_hw_stop(struct aq_hw_s *self)
 {
 	hw_atl_b0_hw_irq_disable(self, HW_ATL2_INT_MASK);
 
-	return 0;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2601e0b074dd 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -680,6 +680,7 @@ struct fec_enet_private {
 	unsigned int reload_period;
 	int pps_enable;
 	unsigned int next_counter;
+	bool perout_enable;
 	struct hrtimer perout_timer;
 	u64 perout_stime;
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index fa88b47d526c..4b7bad9a485d 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -128,6 +128,12 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->perout_enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		dev_err(&fep->pdev->dev, "PEROUT is running");
+		return -EBUSY;
+	}
+
 	if (fep->pps_enable == enable) {
 		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return 0;
@@ -243,6 +249,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 * the FEC_TCCR register in time and missed the start time.
 	 */
 	if (fep->perout_stime < curr_time + 100 * NSEC_PER_MSEC) {
+		fep->perout_enable = false;
 		dev_err(&fep->pdev->dev, "Current time is too close to the start time!\n");
 		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return -1;
@@ -497,7 +504,10 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 {
 	unsigned long flags;
 
+	hrtimer_cancel(&fep->perout_timer);
+
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	fep->perout_enable = false;
 	writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
@@ -529,6 +539,8 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 
 		return ret;
 	} else if (rq->type == PTP_CLK_REQ_PEROUT) {
+		u32 reload_period;
+
 		/* Reject requests with unsupported flags */
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
@@ -548,12 +560,14 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 			return -EOPNOTSUPP;
 		}
 
-		fep->reload_period = div_u64(period_ns, 2);
-		if (on && fep->reload_period) {
+		reload_period = div_u64(period_ns, 2);
+		if (on && reload_period) {
+			u64 perout_stime;
+
 			/* Convert 1588 timestamp to ns*/
 			start_time.tv_sec = rq->perout.start.sec;
 			start_time.tv_nsec = rq->perout.start.nsec;
-			fep->perout_stime = timespec64_to_ns(&start_time);
+			perout_stime = timespec64_to_ns(&start_time);
 
 			mutex_lock(&fep->ptp_clk_mutex);
 			if (!fep->ptp_clk_on) {
@@ -562,18 +576,41 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 				return -EOPNOTSUPP;
 			}
 			spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+			if (fep->pps_enable) {
+				dev_err(&fep->pdev->dev, "PPS is running");
+				ret = -EBUSY;
+				goto unlock;
+			}
+
+			if (fep->perout_enable) {
+				dev_err(&fep->pdev->dev,
+					"PEROUT has been enabled\n");
+				ret = -EBUSY;
+				goto unlock;
+			}
+
 			/* Read current timestamp */
 			curr_time = timecounter_read(&fep->tc);
-			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-			mutex_unlock(&fep->ptp_clk_mutex);
+			if (perout_stime <= curr_time) {
+				dev_err(&fep->pdev->dev,
+					"Start time must be greater than current time\n");
+				ret = -EINVAL;
+				goto unlock;
+			}
 
 			/* Calculate time difference */
-			delta = fep->perout_stime - curr_time;
+			delta = perout_stime - curr_time;
+			fep->reload_period = reload_period;
+			fep->perout_stime = perout_stime;
+			fep->perout_enable = true;
 
-			if (fep->perout_stime <= curr_time) {
-				dev_err(&fep->pdev->dev, "Start time must larger than current time!\n");
-				return -EINVAL;
-			}
+unlock:
+			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+			mutex_unlock(&fep->ptp_clk_mutex);
+
+			if (ret)
+				return ret;
 
 			/* Because the timer counter of FEC only has 31-bits, correspondingly,
 			 * the time comparison register FEC_TCCR also only low 31 bits can be
@@ -681,8 +718,11 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
 		fep->next_counter = (fep->next_counter + fep->reload_period) &
 				fep->cc.mask;
 
-		event.type = PTP_CLOCK_PPS;
-		ptp_clock_event(fep->ptp_clock, &event);
+		if (fep->pps_enable) {
+			event.type = PTP_CLOCK_PPS;
+			ptp_clock_event(fep->ptp_clock, &event);
+		}
+
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 9b93da4d52f6..cf8f14ce4cd5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -627,7 +627,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else if (max_bw_value[i] <= upper_limit_gbps) {
+		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_1GB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c55be7d2547..acc1ad91b0c3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -201,7 +201,7 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
 		return -ENODEV;
 
 	/* Fill all but 1 unused descriptors in the Rx queue. */
-	count = (head - tail - 1) % FBNIC_IPC_MBX_DESC_LEN;
+	count = (head - tail - 1) & (FBNIC_IPC_MBX_DESC_LEN - 1);
 	while (!err && count--) {
 		struct fbnic_tlv_msg *msg;
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index b4377b8613c3..8c40db90ee8f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/ptp_classify.h>
+#include <linux/units.h>
 
 #include "lan966x_main.h"
 #include "vcap_api.h"
 #include "vcap_api_client.h"
 
+#define LAN9X66_CLOCK_RATE	165617754
+
 #define LAN966X_MAX_PTP_ID	512
 
 /* Represents 1ppm adjustment in 2^59 format with 6.037735849ns as reference
@@ -1126,5 +1129,5 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 u32 lan966x_ptp_get_period_ps(void)
 {
 	/* This represents the system clock period in picoseconds */
-	return 15125;
+	return PICO / LAN9X66_CLOCK_RATE;
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bf79e2e9b7ec..44ae014f8004 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1514,11 +1514,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 
 static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_38)
-		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+	case RTL_GIGA_MAC_VER_38:
+		break;
+	case RTL_GIGA_MAC_VER_80:
+		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
+		break;
+	default:
+		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
+		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
+		break;
+	}
 }
 
 static void rtl_reset_packet_filter(struct rtl8169_private *tp)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 75bad561b352..849c5a6c2af1 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1521,8 +1521,10 @@ static int sxgbe_rx(struct sxgbe_priv_data *priv, int limit)
 
 		skb = priv->rxq[qnum]->rx_skbuff[entry];
 
-		if (unlikely(!skb))
+		if (unlikely(!skb)) {
 			netdev_err(priv->dev, "rx descriptor is not consistent\n");
+			break;
+		}
 
 		prefetch(skb->data - NET_IP_ALIGN);
 		priv->rxq[qnum]->rx_skbuff[entry] = NULL;
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 0c8dc16ee7bd..2a873f791733 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -540,7 +540,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 	/* Interface mode is fixed for USXGMII and integrated PHY */
 	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
 	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
-		return -EINVAL;
+		return 0;
 
 	/* Automatically switch SERDES interface between SGMII and 2500-BaseX
 	 * according to speed. Disable ANEG in 2500-BaseX mode.
@@ -578,13 +578,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 		break;
 	}
 
-	if (phydev->speed == SPEED_2500 || phydev->speed == SPEED_1000) {
-		ret = genphy_read_master_slave(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
-	return gpy_update_mdix(phydev);
+	return 0;
 }
 
 static int gpy_read_status(struct phy_device *phydev)
@@ -639,6 +633,16 @@ static int gpy_read_status(struct phy_device *phydev)
 		ret = gpy_update_interface(phydev);
 		if (ret < 0)
 			return ret;
+
+		if (phydev->speed == SPEED_2500 || phydev->speed == SPEED_1000) {
+			ret = genphy_read_master_slave(phydev);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = gpy_update_mdix(phydev);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..25562b17debe 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1191,10 +1191,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EPERM;
 	}
 
-	err = team_dev_type_check_change(dev, port_dev);
-	if (err)
-		return err;
-
 	if (port_dev->flags & IFF_UP) {
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
@@ -1212,10 +1208,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	INIT_LIST_HEAD(&port->qom_list);
 
 	port->orig.mtu = port_dev->mtu;
-	err = dev_set_mtu(port_dev, dev->mtu);
-	if (err) {
-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
-		goto err_set_mtu;
+	/*
+	 * MTU assignment will be handled in team_dev_type_check_change
+	 * if dev and port_dev are of different types
+	 */
+	if (dev->type == port_dev->type) {
+		err = dev_set_mtu(port_dev, dev->mtu);
+		if (err) {
+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
+			goto err_set_mtu;
+		}
 	}
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
@@ -1290,6 +1292,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_dev_type;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
@@ -1308,6 +1314,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	return 0;
 
+err_set_dev_type:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..a5f93b6c4482 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					vlan_hlen, true)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 35dd89aff4a9..cc502bf022d5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -975,6 +975,9 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
+	if (stats.xdp_tx > 0)
+		veth_xdp_flush(rq, &bq);
+	xdp_clear_return_frame_no_direct();
 
 	if (done < budget && napi_complete_done(napi, done)) {
 		/* Write rx_notify_masked before reading ptr_ring */
@@ -987,10 +990,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (stats.xdp_tx > 0)
-		veth_xdp_flush(rq, &bq);
-	xdp_clear_return_frame_no_direct();
-
 	/* Release backpressure per NAPI poll */
 	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
 	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 36b1bc0d5684..3643c220c3e3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3340,7 +3340,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev), 0,
+					false))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index c814fbd756a1..f8bc9a39bfa3 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -98,7 +98,7 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
+	    strcmp(cntrl->name, "foxconn-t99w640") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
 	return 0;
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index f381ce1e84bd..7ebe53249035 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -51,7 +51,7 @@ static int nvmem_layout_bus_uevent(const struct device *dev,
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
-	if (ret != ENODEV)
+	if (ret != -ENODEV)
 		return ret;
 
 	return 0;
diff --git a/drivers/platform/x86/intel/punit_ipc.c b/drivers/platform/x86/intel/punit_ipc.c
index bafac8aa2baf..14513010daad 100644
--- a/drivers/platform/x86/intel/punit_ipc.c
+++ b/drivers/platform/x86/intel/punit_ipc.c
@@ -250,7 +250,7 @@ static int intel_punit_ipc_probe(struct platform_device *pdev)
 	} else {
 		ret = devm_request_irq(&pdev->dev, irq, intel_punit_ioc,
 				       IRQF_NO_SUSPEND, "intel_punit_ipc",
-				       &punit_ipcdev);
+				       punit_ipcdev);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to request irq: %d\n", irq);
 			return ret;
diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index b0138ca9f851..9f4366250bfd 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -184,6 +184,7 @@ tegra_powergate_add(struct tegra_bpmp *bpmp,
 	powergate->genpd.name = kstrdup(info->name, GFP_KERNEL);
 	powergate->genpd.power_on = tegra_powergate_power_on;
 	powergate->genpd.power_off = tegra_powergate_power_off;
+	powergate->genpd.flags = GENPD_FLAG_NO_STAY_ON;
 
 	err = pm_genpd_init(&powergate->genpd, NULL, off);
 	if (err < 0) {
diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 9cde7181b0f0..f669a562f036 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -53,7 +53,7 @@
 #define RTQ2208_MASK_BUCKPH_GROUP1		GENMASK(6, 4)
 #define RTQ2208_MASK_BUCKPH_GROUP2		GENMASK(2, 0)
 #define RTQ2208_MASK_LDO2_OPT0			BIT(7)
-#define RTQ2208_MASK_LDO2_OPT1			BIT(6)
+#define RTQ2208_MASK_LDO2_OPT1			BIT(7)
 #define RTQ2208_MASK_LDO1_FIXED			BIT(6)
 
 /* Size */
@@ -543,14 +543,14 @@ static int rtq2208_regulator_check(struct device *dev, int *num, int *regulator_
 
 	switch (FIELD_GET(RTQ2208_MASK_BUCKPH_GROUP2, buck_phase)) {
 	case 2:
-		rtq2208_used_table[RTQ2208_BUCK_F] = true;
+		rtq2208_used_table[RTQ2208_BUCK_H] = true;
 		fallthrough;
 	case 1:
 		rtq2208_used_table[RTQ2208_BUCK_E] = true;
 		fallthrough;
 	case 0:
 	case 3:
-		rtq2208_used_table[RTQ2208_BUCK_H] = true;
+		rtq2208_used_table[RTQ2208_BUCK_F] = true;
 		fallthrough;
 	default:
 		rtq2208_used_table[RTQ2208_BUCK_G] = true;
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 4fb66986cc22..cd40ab839c54 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1241,6 +1241,7 @@ static void qcom_slim_ngd_notify_slaves(struct qcom_slim_ngd_ctrl *ctrl)
 
 		if (slim_get_logical_addr(sbdev))
 			dev_err(ctrl->dev, "Failed to get logical address\n");
+		put_device(&sbdev->dev);
 	}
 }
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..9f20cb75bb85 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1170,10 +1170,10 @@ config SPI_TEGRA210_QUAD
 
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
-	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	help
-	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
+	  SPI controller driver for NVIDIA Tegra114 and later SoCs. This controller
 	  is different than the older SoCs SPI controller and also register interface
 	  get changed with this controller.
 
diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 18c9aa2cbc29..eb503790017b 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -353,7 +353,9 @@ static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(spifc->dev, 500);
 	pm_runtime_use_autosuspend(spifc->dev);
-	devm_pm_runtime_enable(spifc->dev);
+	ret = devm_pm_runtime_enable(spifc->dev);
+	if (ret)
+		return ret;
 
 	ctrl->num_chipselect = 1;
 	ctrl->dev.of_node = pdev->dev.of_node;
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index b56210734caa..2e3c62f12bef 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -247,6 +247,20 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 
 		if (t->rx_buf) {
 			do_rx = true;
+
+			/*
+			 * In certain hardware implementations, there appears to be a
+			 * hidden accumulator that tracks the number of bytes written into
+			 * the hardware FIFO, and this accumulator overrides the length in
+			 * the SPI_MSG_CTL register.
+			 *
+			 * Therefore, for read-only transfers, we need to write some dummy
+			 * value into the FIFO to keep the accumulator tracking the correct
+			 * length.
+			 */
+			if (!t->tx_buf)
+				memset_io(bs->tx_io + len, 0xFF, t->len);
+
 			/* prepend is half-duplex write only */
 			if (t == first)
 				prepend_len = 0;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ce0f605ab688..8d2684a129f2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1981,6 +1981,13 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
+
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
@@ -1995,14 +2002,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_dma_failed;
-	}
-
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_enable(dev);
-		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
+			goto probe_setup_failed;
 	}
 
 	ret = spi_register_controller(host);
@@ -2012,7 +2012,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_put_autosuspend(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
@@ -2021,7 +2020,6 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_setup_failed:
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
-probe_dma_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index ab13f11242c3..f96638cae1d9 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -330,6 +330,8 @@
 
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
+/* Disable DTR */
+#define FSPI_QUIRK_DISABLE_DTR	BIT(1)
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -344,7 +346,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
-	.quirks = 0,
+	.quirks = FSPI_QUIRK_DISABLE_DTR,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
@@ -1236,6 +1238,13 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 };
 
 static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.dtr = true,
+	.swap16 = false,
+	.per_op_freq = true,
+};
+
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps_disable_dtr = {
+	.dtr = false,
 	.per_op_freq = true,
 };
 
@@ -1261,7 +1270,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct resource *res;
 	struct nxp_fspi *f;
 	int ret, irq;
@@ -1283,7 +1292,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, f);
 
 	/* find the resources - configuration register address space */
-	if (is_acpi_node(dev_fwnode(f->dev)))
+	if (is_acpi_node(fwnode))
 		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
 		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
@@ -1291,7 +1300,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		return PTR_ERR(f->iobase);
 
 	/* find the resources - controller memory mapped space */
-	if (is_acpi_node(dev_fwnode(f->dev)))
+	if (is_acpi_node(fwnode))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	else
 		res = platform_get_resource_byname(pdev,
@@ -1304,7 +1313,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f->memmap_phy_size = resource_size(res);
 
 	/* find the clocks */
-	if (dev_of_node(&pdev->dev)) {
+	if (is_of_node(fwnode)) {
 		f->clk_en = devm_clk_get(dev, "fspi_en");
 		if (IS_ERR(f->clk_en))
 			return PTR_ERR(f->clk_en);
@@ -1351,8 +1360,13 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
-	ctlr->mem_caps = &nxp_fspi_mem_caps;
-	ctlr->dev.of_node = np;
+
+	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
+		ctlr->mem_caps = &nxp_fspi_mem_caps_disable_dtr;
+	else
+		ctlr->mem_caps = &nxp_fspi_mem_caps;
+
+	device_set_node(&ctlr->dev, fwnode);
 
 	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
 	if (ret)
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f3a2264e012b..38c5b27ad972 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1528,6 +1528,8 @@ static struct pci_device_id nhi_ids[] = {
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_P_NHI1),
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_WCL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI) },
 
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 16744f25a9a0..24ac4246d0ca 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -75,6 +75,7 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
 #define PCI_DEVICE_ID_INTEL_ADL_NHI0			0x463e
 #define PCI_DEVICE_ID_INTEL_ADL_NHI1			0x466d
+#define PCI_DEVICE_ID_INTEL_WCL_NHI0			0x4d33
 #define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI	0x5781
 #define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI	0x5784
 #define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_80G_BRIDGE 0x5786
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index cfe6ba286b45..76c0a2db3bda 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -317,13 +317,13 @@ static inline void serial8250_pnp_exit(void) { }
 #endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
-void univ8250_rsa_support(struct uart_ops *ops);
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops);
 void rsa_enable(struct uart_8250_port *up);
 void rsa_disable(struct uart_8250_port *up);
 void rsa_autoconfig(struct uart_8250_port *up);
 void rsa_reset(struct uart_8250_port *up);
 #else
-static inline void univ8250_rsa_support(struct uart_ops *ops) { }
+static inline void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops) { }
 static inline void rsa_enable(struct uart_8250_port *up) {}
 static inline void rsa_disable(struct uart_8250_port *up) {}
 static inline void rsa_autoconfig(struct uart_8250_port *up) {}
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index c0343bfb8064..660867316c28 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -74,7 +74,7 @@ static void __init __serial8250_isa_init_ports(void)
 
 	/* chain base port ops to support Remote Supervisor Adapter */
 	univ8250_port_ops = *univ8250_port_base_ops;
-	univ8250_rsa_support(&univ8250_port_ops);
+	univ8250_rsa_support(&univ8250_port_ops, univ8250_port_base_ops);
 
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 12a65b79583c..ac885e8f949e 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -14,6 +14,8 @@
 static unsigned long probe_rsa[PORT_RSA_MAX];
 static unsigned int probe_rsa_count;
 
+static const struct uart_ops *core_port_base_ops;
+
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
@@ -67,7 +69,7 @@ static void univ8250_config_port(struct uart_port *port, int flags)
 		}
 	}
 
-	univ8250_port_base_ops->config_port(port, flags);
+	core_port_base_ops->config_port(port, flags);
 
 	if (port->type != PORT_RSA && up->probe & UART_PROBE_RSA)
 		rsa8250_release_resource(up);
@@ -78,11 +80,11 @@ static int univ8250_request_port(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
-	ret = univ8250_port_base_ops->request_port(port);
+	ret = core_port_base_ops->request_port(port);
 	if (ret == 0 && port->type == PORT_RSA) {
 		ret = rsa8250_request_resource(up);
 		if (ret < 0)
-			univ8250_port_base_ops->release_port(port);
+			core_port_base_ops->release_port(port);
 	}
 
 	return ret;
@@ -94,15 +96,25 @@ static void univ8250_release_port(struct uart_port *port)
 
 	if (port->type == PORT_RSA)
 		rsa8250_release_resource(up);
-	univ8250_port_base_ops->release_port(port);
+	core_port_base_ops->release_port(port);
 }
 
-void univ8250_rsa_support(struct uart_ops *ops)
+/*
+ * It is not allowed to directly reference any symbols from 8250.ko here as
+ * that would result in a dependency loop between the 8250.ko and
+ * 8250_base.ko modules. This function is called from 8250.ko and is used to
+ * break the symbolic dependency cycle. Anything that is needed from 8250.ko
+ * has to be passed as pointers to this function which then can adjust those
+ * variables on 8250.ko side or store them locally as needed.
+ */
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops)
 {
+	core_port_base_ops = core_ops;
 	ops->config_port  = univ8250_config_port;
 	ops->request_port = univ8250_request_port;
 	ops->release_port = univ8250_release_port;
 }
+EXPORT_SYMBOL_FOR_MODULES(univ8250_rsa_support, "8250");
 
 module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
@@ -147,7 +159,6 @@ void rsa_enable(struct uart_8250_port *up)
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 		serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_enable, "8250_base");
 
 /*
  * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
@@ -179,7 +190,6 @@ void rsa_disable(struct uart_8250_port *up)
 		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
 	uart_port_unlock_irq(&up->port);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_disable, "8250_base");
 
 void rsa_autoconfig(struct uart_8250_port *up)
 {
@@ -192,7 +202,6 @@ void rsa_autoconfig(struct uart_8250_port *up)
 	if (__rsa_enable(up))
 		up->port.type = PORT_RSA;
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_autoconfig, "8250_base");
 
 void rsa_reset(struct uart_8250_port *up)
 {
@@ -201,7 +210,6 @@ void rsa_reset(struct uart_8250_port *up)
 
 	serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_reset, "8250_base");
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 513a0941c284..9ec4d5fe64de 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o
 8250-y					:= 8250_core.o
 8250-y					+= 8250_platform.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
-8250-$(CONFIG_SERIAL_8250_RSA)		+= 8250_rsa.o
 
 obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-y				:= 8250_port.o
@@ -15,6 +14,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
+8250_base-$(CONFIG_SERIAL_8250_RSA)	+= 8250_rsa.o
 
 obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..7f17d288c807 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -628,7 +628,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dmatx->len = count;
 	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-	if (dmatx->dma == DMA_MAPPING_ERROR) {
+	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 3b3b3dc75f35..57f57c24c663 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -98,10 +98,8 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		wrap = pci_get_drvdata(func);
 	} else {
 		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
-		if (!wrap) {
-			pci_disable_device(pdev);
+		if (!wrap)
 			return -ENOMEM;
-		}
 	}
 
 	res = wrap->dev_res;
@@ -160,7 +158,6 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		/* register platform device */
 		wrap->plat_dev = platform_device_register_full(&plat_info);
 		if (IS_ERR(wrap->plat_dev)) {
-			pci_disable_device(pdev);
 			err = PTR_ERR(wrap->plat_dev);
 			kfree(wrap);
 			return err;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..839514d7f3c7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
@@ -2240,7 +2241,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
+	if (!dev_is_pci(dwc->sysdev) &&
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 39c72cb52ce7..8f5faf632a8b 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -21,40 +21,41 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 
+#define PCI_DEVICE_ID_INTEL_CMLLP		0x02ee
+#define PCI_DEVICE_ID_INTEL_CMLH		0x06ee
+#define PCI_DEVICE_ID_INTEL_BXT			0x0aaa
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f37
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x119e
-#define PCI_DEVICE_ID_INTEL_BSW			0x22b7
-#define PCI_DEVICE_ID_INTEL_SPTLP		0x9d30
-#define PCI_DEVICE_ID_INTEL_SPTH		0xa130
-#define PCI_DEVICE_ID_INTEL_BXT			0x0aaa
 #define PCI_DEVICE_ID_INTEL_BXT_M		0x1aaa
-#define PCI_DEVICE_ID_INTEL_APL			0x5aaa
-#define PCI_DEVICE_ID_INTEL_KBP			0xa2b0
-#define PCI_DEVICE_ID_INTEL_CMLLP		0x02ee
-#define PCI_DEVICE_ID_INTEL_CMLH		0x06ee
+#define PCI_DEVICE_ID_INTEL_BSW			0x22b7
 #define PCI_DEVICE_ID_INTEL_GLK			0x31aa
-#define PCI_DEVICE_ID_INTEL_CNPLP		0x9dee
-#define PCI_DEVICE_ID_INTEL_CNPH		0xa36e
-#define PCI_DEVICE_ID_INTEL_CNPV		0xa3b0
 #define PCI_DEVICE_ID_INTEL_ICLLP		0x34ee
-#define PCI_DEVICE_ID_INTEL_EHL			0x4b7e
-#define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
-#define PCI_DEVICE_ID_INTEL_JSP			0x4dee
-#define PCI_DEVICE_ID_INTEL_WCL			0x4d7e
 #define PCI_DEVICE_ID_INTEL_ADL			0x460e
-#define PCI_DEVICE_ID_INTEL_ADL_PCH		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLN		0x465e
+#define PCI_DEVICE_ID_INTEL_EHL			0x4b7e
+#define PCI_DEVICE_ID_INTEL_WCL			0x4d7e
+#define PCI_DEVICE_ID_INTEL_JSP			0x4dee
+#define PCI_DEVICE_ID_INTEL_ADL_PCH		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLN_PCH		0x54ee
-#define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
-#define PCI_DEVICE_ID_INTEL_RPL			0xa70e
+#define PCI_DEVICE_ID_INTEL_APL			0x5aaa
+#define PCI_DEVICE_ID_INTEL_NVLS_PCH		0x6e6f
+#define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_RPLS		0x7a61
+#define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
+#define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
 #define PCI_DEVICE_ID_INTEL_MTLM		0x7eb1
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
-#define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
-#define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
+#define PCI_DEVICE_ID_INTEL_SPTLP		0x9d30
+#define PCI_DEVICE_ID_INTEL_CNPLP		0x9dee
+#define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
+#define PCI_DEVICE_ID_INTEL_SPTH		0xa130
+#define PCI_DEVICE_ID_INTEL_KBP			0xa2b0
+#define PCI_DEVICE_ID_INTEL_CNPH		0xa36e
+#define PCI_DEVICE_ID_INTEL_CNPV		0xa3b0
+#define PCI_DEVICE_ID_INTEL_RPL			0xa70e
 #define PCI_DEVICE_ID_INTEL_PTLH		0xe332
 #define PCI_DEVICE_ID_INTEL_PTLH_PCH		0xe37e
 #define PCI_DEVICE_ID_INTEL_PTLU		0xe432
@@ -412,40 +413,41 @@ static void dwc3_pci_remove(struct pci_dev *pci)
 }
 
 static const struct pci_device_id dwc3_pci_id_table[] = {
-	{ PCI_DEVICE_DATA(INTEL, BSW, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, BYT, &dwc3_pci_intel_byt_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, MRFLD, &dwc3_pci_intel_mrfld_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, CMLLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, CMLH, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, SPTLP, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, SPTH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, BXT, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, BYT, &dwc3_pci_intel_byt_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MRFLD, &dwc3_pci_intel_mrfld_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, BXT_M, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, APL, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, KBP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, BSW, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, GLK, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, CNPLP, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, CNPH, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, CNPV, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ICLLP, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, EHL, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, TGPLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGPH, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, JSP, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, WCL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADL, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, ADL_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADLN, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, EHL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, WCL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, JSP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADL_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADLN_PCH, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, ADLS, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, RPL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, APL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, NVLS_PCH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, RPLS, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADLS, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLM, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, SPTLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, TGPLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, SPTH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, KBP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPV, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, RPL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLU, &dwc3_pci_intel_swnode) },
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b4229aa13f37..e0bad5708664 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -94,6 +94,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 	req->epnum		= dep->number;
+	req->status		= DWC3_REQUEST_STATUS_QUEUED;
 
 	list_add_tail(&req->list, &dep->pending_list);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 554f997eb8c4..ffe96d4a2be7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -228,6 +228,13 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 {
 	struct dwc3			*dwc = dep->dwc;
 
+	/*
+	 * The request might have been processed and completed while the
+	 * spinlock was released. Skip processing if already completed.
+	 */
+	if (req->status == DWC3_REQUEST_STATUS_COMPLETED)
+		return;
+
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index 6de81ea17274..edbbadad6138 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -477,8 +477,13 @@ static int eem_unwrap(struct gether *port,
 				req->complete = eem_cmd_complete;
 				req->zero = 1;
 				req->context = ctx;
-				if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
+				if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC)) {
 					DBG(cdev, "echo response queue fail\n");
+					kfree(ctx);
+					kfree(req->buf);
+					usb_ep_free_request(ep, req);
+					dev_kfree_skb_any(skb2);
+				}
 				break;
 
 			case 1:  /* echo response */
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e3d63b8fa0f4..8dbe79bdc0f9 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1126,8 +1126,14 @@ static void usb_gadget_state_work(struct work_struct *work)
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gadget->state_lock, flags);
 	gadget->state = state;
-	schedule_work(&gadget->work);
+	if (!gadget->teardown)
+		schedule_work(&gadget->work);
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
+	trace_usb_gadget_set_state(gadget, 0);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
@@ -1360,6 +1366,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1534,6 +1542,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1547,6 +1556,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	sysfs_remove_link(&udc->dev.kobj, "gadget");
 	device_del(&gadget->dev);
+	/*
+	 * Set the teardown flag before flushing the work to prevent new work
+	 * from being scheduled while we are cleaning up.
+	 */
+	spin_lock_irqsave(&gadget->state_lock, flags);
+	gadget->teardown = true;
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
diff --git a/drivers/usb/gadget/udc/renesas_usbf.c b/drivers/usb/gadget/udc/renesas_usbf.c
index 14f4b2cf05a4..4c201574a0af 100644
--- a/drivers/usb/gadget/udc/renesas_usbf.c
+++ b/drivers/usb/gadget/udc/renesas_usbf.c
@@ -3262,7 +3262,9 @@ static int usbf_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->regs))
 		return PTR_ERR(udc->regs);
 
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 4e334298b0e8..fa3e6ddf0a12 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -81,6 +81,11 @@ DECLARE_EVENT_CLASS(udc_log_gadget,
 		__entry->ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_state,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_frame_number,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 47ac72c2286d..5426c971d2d3 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -114,6 +114,7 @@ struct dbc_port {
 	unsigned int			tx_boundary;
 
 	bool				registered;
+	bool				tx_running;
 };
 
 struct dbc_driver {
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d894081d8d15..57cdda4e09c8 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -47,7 +47,7 @@ dbc_kfifo_to_req(struct dbc_port *port, char *packet)
 	return len;
 }
 
-static int dbc_start_tx(struct dbc_port *port)
+static int dbc_do_start_tx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
 {
@@ -57,6 +57,8 @@ static int dbc_start_tx(struct dbc_port *port)
 	bool			do_tty_wake = false;
 	struct list_head	*pool = &port->write_pool;
 
+	port->tx_running = true;
+
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
 		len = dbc_kfifo_to_req(port, req->buf);
@@ -77,12 +79,25 @@ static int dbc_start_tx(struct dbc_port *port)
 		}
 	}
 
+	port->tx_running = false;
+
 	if (do_tty_wake && port->port.tty)
 		tty_wakeup(port->port.tty);
 
 	return status;
 }
 
+/* must be called with port->port_lock held */
+static int dbc_start_tx(struct dbc_port *port)
+{
+	lockdep_assert_held(&port->port_lock);
+
+	if (port->tx_running)
+		return -EBUSY;
+
+	return dbc_do_start_tx(port);
+}
+
 static void dbc_start_rx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
@@ -535,6 +550,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	tty_vhangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6309200e93dc..a51e21dc96c3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1984,6 +1984,7 @@ static void xhci_cavium_reset_phy_quirk(struct xhci_hcd *xhci)
 
 static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 {
+	struct xhci_virt_device *vdev = NULL;
 	struct usb_hcd *hcd;
 	u32 port_id;
 	u32 portsc, cmd_reg;
@@ -2015,6 +2016,9 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		goto cleanup;
 	}
 
+	if (port->slot_id)
+		vdev = xhci->devs[port->slot_id];
+
 	/* We might get interrupts after shared_hcd is removed */
 	if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
 		xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
@@ -2037,10 +2041,11 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		usb_hcd_resume_root_hub(hcd);
 	}
 
-	if (hcd->speed >= HCD_USB3 &&
-	    (portsc & PORT_PLS_MASK) == XDEV_INACTIVE) {
-		if (port->slot_id && xhci->devs[port->slot_id])
-			xhci->devs[port->slot_id]->flags |= VDEV_PORT_ERROR;
+	if (vdev && (portsc & PORT_PLS_MASK) == XDEV_INACTIVE) {
+		if (!(portsc & PORT_RESET))
+			vdev->flags |= VDEV_PORT_ERROR;
+	} else if (vdev && portsc & PORT_RC) {
+		vdev->flags &= ~VDEV_PORT_ERROR;
 	}
 
 	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_RESUME) {
@@ -2098,7 +2103,7 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		 * so the roothub behavior is consistent with external
 		 * USB 3.0 hub behavior.
 		 */
-		if (port->slot_id && xhci->devs[port->slot_id])
+		if (vdev)
 			xhci_ring_device(xhci, port->slot_id);
 		if (bus_state->port_remote_wakeup & (1 << hcd_portnum)) {
 			xhci_test_and_clear_bit(xhci, port, PORT_PLC);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 742c23826e17..25cd778d3fbd 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3993,6 +3993,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 				xhci_get_slot_state(xhci, virt_dev->out_ctx));
 		xhci_dbg(xhci, "Not freeing device rings.\n");
 		/* Don't treat this as an error.  May change my mind later. */
+		virt_dev->flags = 0;
 		ret = 0;
 		goto command_cleanup;
 	case COMP_SUCCESS:
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 18a6ef4dce51..8016b7ffaa18 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -809,18 +809,18 @@ static void usbhs_remove(struct platform_device *pdev)
 
 	flush_delayed_work(&priv->notify_hotplug_work);
 
-	/* power off */
-	if (!usbhs_get_dparam(priv, runtime_pwctrl))
-		usbhsc_power_ctrl(priv, 0);
-
-	pm_runtime_disable(&pdev->dev);
-
 	usbhs_platform_call(priv, hardware_exit, pdev);
-	usbhsc_clk_put(priv);
 	reset_control_assert(priv->rsts);
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
+
+	/* power off */
+	if (!usbhs_get_dparam(priv, runtime_pwctrl))
+		usbhsc_power_ctrl(priv, 0);
+
+	usbhsc_clk_put(priv);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int usbhsc_suspend(struct device *dev)
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49666c33b41f..b37fa31f5694 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1074,6 +1074,7 @@ static const struct usb_device_id id_table_combined[] = {
 	/* U-Blox devices */
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ZED_PID) },
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
+	{ USB_DEVICE_INTERFACE_NUMBER(UBLOX_VID, UBLOX_EVK_M101_PID, 2) },
 	/* FreeCalypso USB adapters */
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 4cc1fae8acb9..2539b9e2f712 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1614,6 +1614,7 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+#define UBLOX_EVK_M101_PID		0x0506
 
 /*
  * GMC devices
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5de856f65f0d..e9400727ad36 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2424,12 +2424,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
 	{ USB_DEVICE(0x33f8, 0x0104),						/* Rolling RW101-GL (laptop RMNET) */
 	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a2, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a3, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a4, 0xff),			/* Rolling RW101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
-	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a8, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a9, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0301, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b323f0a36260..9d813727e65f 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -469,6 +469,12 @@ static int sddr55_write_data(struct us_data *us,
 		new_pba = (status[3] + (status[4] << 8) + (status[5] << 16))
 						  >> info->blockshift;
 
+		/* check if device-reported new_pba is out of range */
+		if (new_pba >= (info->capacity >> (info->blockshift + info->pageshift))) {
+			result = USB_STOR_TRANSPORT_FAILED;
+			goto leave;
+		}
+
 		/* check status for error */
 		if (status[0] == 0xff && status[1] == 0x4) {
 			info->pba_to_lba[new_pba] = BAD_BLOCK;
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1aa1bd26c81f..9a4bf86e7b6a 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1200,7 +1200,23 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 						US_BULK_CS_WRAP_LEN &&
 					bcs->Signature ==
 						cpu_to_le32(US_BULK_CS_SIGN)) {
+				unsigned char buf[US_BULK_CS_WRAP_LEN];
+
 				usb_stor_dbg(us, "Device skipped data phase\n");
+
+				/*
+				 * Devices skipping data phase might leave CSW data in srb's
+				 * transfer buffer. Zero it to prevent USB protocol leakage.
+				 */
+				sg = NULL;
+				offset = 0;
+				memset(buf, 0, sizeof(buf));
+				if (usb_stor_access_xfer_buf(buf,
+						US_BULK_CS_WRAP_LEN, srb, &sg,
+						&offset, TO_XFER_BUF) !=
+							US_BULK_CS_WRAP_LEN)
+					usb_stor_dbg(us, "Failed to clear CSW data\n");
+
 				scsi_set_resid(srb, transfer_length);
 				goto skipped_data_phase;
 			}
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 4ed0dc19afe0..45b01df364f7 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -698,6 +698,10 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
+		if (cmdinfo->state & (COMMAND_INFLIGHT | DATA_IN_URB_INFLIGHT |
+				DATA_OUT_URB_INFLIGHT))
+			goto out;
+
 		set_host_byte(cmnd, DID_NO_CONNECT);
 		scsi_done(cmnd);
 		goto zombie;
@@ -711,6 +715,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 		uas_add_work(cmnd);
 	}
 
+out:
 	devinfo->cmnd[idx] = cmnd;
 zombie:
 	spin_unlock_irqrestore(&devinfo->lock, flags);
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index dfa5276a5a43..47f50d7a385c 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -938,7 +938,7 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
 UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
 		"Novatek",
 		"NTK96550-based camera",
-		USB_SC_SCSI, USB_PR_BULK, NULL,
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BULK_IGNORE_TAG ),
 
 /*
diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..8ae900c8c132 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 35ded4330431..8f7f50acb6d6 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_net_virtqueue *tnvq,
 				    unsigned int *out_num, unsigned int *in_num,
-				    struct msghdr *msghdr, bool *busyloop_intr)
+				    struct msghdr *msghdr, bool *busyloop_intr,
+				    unsigned int *ndesc)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_virtqueue *rvq = &rnvq->vq;
 	struct vhost_virtqueue *tvq = &tnvq->vq;
 
-	int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
-				  out_num, in_num, NULL, NULL);
+	int r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+				    out_num, in_num, NULL, NULL, ndesc);
 
 	if (r == tvq->num && tvq->busyloop_timeout) {
 		/* Flush batched packets first */
@@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
 
-		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
-				      out_num, in_num, NULL, NULL);
+		r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
+					out_num, in_num, NULL, NULL, ndesc);
 	}
 
 	return r;
@@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *net,
 		       struct vhost_net_virtqueue *nvq,
 		       struct msghdr *msg,
 		       unsigned int *out, unsigned int *in,
-		       size_t *len, bool *busyloop_intr)
+		       size_t *len, bool *busyloop_intr,
+		       unsigned int *ndesc)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
 	int ret;
 
-	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, busyloop_intr);
+	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
+				       busyloop_intr, ndesc);
 
 	if (ret < 0 || ret == vq->num)
 		return ret;
@@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
+	unsigned int ndesc = 0;
 
 	do {
 		bool busyloop_intr = false;
@@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
 		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
-				   &busyloop_intr);
+				   &busyloop_intr, &ndesc);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
@@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 				goto done;
 			} else if (unlikely(err != -ENOSPC)) {
 				vhost_tx_batch(net, nvq, sock, &msg);
-				vhost_discard_vq_desc(vq, 1);
+				vhost_discard_vq_desc(vq, 1, ndesc);
 				vhost_net_enable_vq(net, vq);
 				break;
 			}
@@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		err = sock->ops->sendmsg(sock, &msg, len);
 		if (unlikely(err < 0)) {
 			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
-				vhost_discard_vq_desc(vq, 1);
+				vhost_discard_vq_desc(vq, 1, ndesc);
 				vhost_net_enable_vq(net, vq);
 				break;
 			}
@@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 	int err;
 	struct vhost_net_ubuf_ref *ubufs;
 	struct ubuf_info_msgzc *ubuf;
+	unsigned int ndesc = 0;
 	bool zcopy_used;
 	int sent_pkts = 0;
 
@@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 
 		busyloop_intr = false;
 		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
-				   &busyloop_intr);
+				   &busyloop_intr, &ndesc);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
@@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
 			}
 			if (retry) {
-				vhost_discard_vq_desc(vq, 1);
+				vhost_discard_vq_desc(vq, 1, ndesc);
 				vhost_net_enable_vq(net, vq);
 				break;
 			}
@@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
 		       unsigned *iovcount,
 		       struct vhost_log *log,
 		       unsigned *log_num,
-		       unsigned int quota)
+		       unsigned int quota,
+		       unsigned int *ndesc)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
-	unsigned int out, in;
+	unsigned int out, in, desc_num, n = 0;
 	int seg = 0;
 	int headcount = 0;
 	unsigned d;
@@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
 			r = -ENOBUFS;
 			goto err;
 		}
-		r = vhost_get_vq_desc(vq, vq->iov + seg,
-				      ARRAY_SIZE(vq->iov) - seg, &out,
-				      &in, log, log_num);
+		r = vhost_get_vq_desc_n(vq, vq->iov + seg,
+					ARRAY_SIZE(vq->iov) - seg, &out,
+					&in, log, log_num, &desc_num);
 		if (unlikely(r < 0))
 			goto err;
 
@@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
 		++headcount;
 		datalen -= len;
 		seg += in;
+		n += desc_num;
 	}
 
 	*iovcount = seg;
@@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
 		nheads[0] = headcount;
 	}
 
+	*ndesc = n;
+
 	return headcount;
 err:
-	vhost_discard_vq_desc(vq, headcount);
+	vhost_discard_vq_desc(vq, headcount, n);
 	return r;
 }
 
@@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *net)
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
+	unsigned int ndesc;
 
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vhost_vq_get_backend(vq);
@@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
 		headcount = get_rx_bufs(nvq, vq->heads + count,
 					vq->nheads + count,
 					vhost_len, &in, vq_log, &log,
-					likely(mergeable) ? UIO_MAXIOV : 1);
+					likely(mergeable) ? UIO_MAXIOV : 1,
+					&ndesc);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
@@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *net)
 		if (unlikely(err != sock_len)) {
 			pr_debug("Discarded rx packet: "
 				 " len %d, expected %zd\n", err, sock_len);
-			vhost_discard_vq_desc(vq, headcount);
+			vhost_discard_vq_desc(vq, headcount, ndesc);
 			continue;
 		}
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
@@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *net)
 		    copy_to_iter(&num_buffers, sizeof num_buffers,
 				 &fixup) != sizeof num_buffers) {
 			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
+			vhost_discard_vq_desc(vq, headcount, ndesc);
 			goto out;
 		}
 		nvq->done_idx += headcount;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8570fdf2e14a..a78226b37739 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2792,18 +2792,34 @@ static int get_indirect(struct vhost_virtqueue *vq,
 	return 0;
 }
 
-/* This looks in the virtqueue and for the first available buffer, and converts
- * it to an iovec for convenient access.  Since descriptors consist of some
- * number of output then some number of input descriptors, it's actually two
- * iovecs, but we pack them into one and note how many of each there were.
+/**
+ * vhost_get_vq_desc_n - Fetch the next available descriptor chain and build iovecs
+ * @vq: target virtqueue
+ * @iov: array that receives the scatter/gather segments
+ * @iov_size: capacity of @iov in elements
+ * @out_num: the number of output segments
+ * @in_num: the number of input segments
+ * @log: optional array to record addr/len for each writable segment; NULL if unused
+ * @log_num: optional output; number of entries written to @log when provided
+ * @ndesc: optional output; number of descriptors consumed from the available ring
+ *         (useful for rollback via vhost_discard_vq_desc)
  *
- * This function returns the descriptor number found, or vq->num (which is
- * never a valid descriptor number) if none was found.  A negative code is
- * returned on error. */
-int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
+ * Extracts one available descriptor chain from @vq and translates guest addresses
+ * into host iovecs.
+ *
+ * On success, advances @vq->last_avail_idx by 1 and @vq->next_avail_head by the
+ * number of descriptors consumed (also stored via @ndesc when non-NULL).
+ *
+ * Return:
+ * - head index in [0, @vq->num) on success;
+ * - @vq->num if no descriptor is currently available;
+ * - negative errno on failure
+ */
+int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
+			struct iovec iov[], unsigned int iov_size,
+			unsigned int *out_num, unsigned int *in_num,
+			struct vhost_log *log, unsigned int *log_num,
+			unsigned int *ndesc)
 {
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 	struct vring_desc desc;
@@ -2921,17 +2937,49 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	vq->last_avail_idx++;
 	vq->next_avail_head += c;
 
+	if (ndesc)
+		*ndesc = c;
+
 	/* Assume notifications from guest are disabled at this point,
 	 * if they aren't we would need to update avail_event index. */
 	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
 	return head;
 }
+EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
+
+/* This looks in the virtqueue and for the first available buffer, and converts
+ * it to an iovec for convenient access.  Since descriptors consist of some
+ * number of output then some number of input descriptors, it's actually two
+ * iovecs, but we pack them into one and note how many of each there were.
+ *
+ * This function returns the descriptor number found, or vq->num (which is
+ * never a valid descriptor number) if none was found.  A negative code is
+ * returned on error.
+ */
+int vhost_get_vq_desc(struct vhost_virtqueue *vq,
+		      struct iovec iov[], unsigned int iov_size,
+		      unsigned int *out_num, unsigned int *in_num,
+		      struct vhost_log *log, unsigned int *log_num)
+{
+	return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in_num,
+				   log, log_num, NULL);
+}
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
-/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
-void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
+/**
+ * vhost_discard_vq_desc - Reverse the effect of vhost_get_vq_desc_n()
+ * @vq: target virtqueue
+ * @nbufs: number of buffers to roll back
+ * @ndesc: number of descriptors to roll back
+ *
+ * Rewinds the internal consumer cursors after a failed attempt to use buffers
+ * returned by vhost_get_vq_desc_n().
+ */
+void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int nbufs,
+			   unsigned int ndesc)
 {
-	vq->last_avail_idx -= n;
+	vq->next_avail_head -= ndesc;
+	vq->last_avail_idx -= nbufs;
 }
 EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 621a6d9a8791..b49f08e4a1b4 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -230,7 +230,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct iovec iov[], unsigned int iov_size,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num);
-void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
+
+int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
+			struct iovec iov[], unsigned int iov_size,
+			unsigned int *out_num, unsigned int *in_num,
+			struct vhost_log *log, unsigned int *log_num,
+			unsigned int *ndesc);
+
+void vhost_discard_vq_desc(struct vhost_virtqueue *, int nbuf,
+			   unsigned int ndesc);
 
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 451d262767f8..38c9b749ddf9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -66,6 +66,7 @@
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/panic.h>
+#include <linux/pci.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
@@ -78,6 +79,7 @@
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
 #include <linux/uaccess.h>
+#include <linux/vga_switcheroo.h>
 #include <asm/irq.h>
 
 #include "fbcon.h"
@@ -2906,6 +2908,9 @@ void fbcon_fb_unregistered(struct fb_info *info)
 
 	console_lock();
 
+	if (info->device && dev_is_pci(info->device))
+		vga_switcheroo_client_fb_set(to_pci_dev(info->device), NULL);
+
 	fbcon_registered_fb[info->node] = NULL;
 	fbcon_num_registered_fb--;
 
@@ -3039,6 +3044,10 @@ static int do_fb_registered(struct fb_info *info)
 		}
 	}
 
+	/* Set the fb info for vga_switcheroo clients. Does nothing otherwise. */
+	if (info->device && dev_is_pci(info->device))
+		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
+
 	return ret;
 }
 
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index d9b6fa1088b7..71c10a05cebe 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -140,7 +140,9 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cell->name = kmalloc(1 + namelen + 1, GFP_KERNEL);
+	/* Allocate the cell name and the key name in one go. */
+	cell->name = kmalloc(1 + namelen + 1 +
+			     4 + namelen + 1, GFP_KERNEL);
 	if (!cell->name) {
 		kfree(cell);
 		return ERR_PTR(-ENOMEM);
@@ -151,7 +153,11 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->name_len = namelen;
 	for (i = 0; i < namelen; i++)
 		cell->name[i] = tolower(name[i]);
-	cell->name[i] = 0;
+	cell->name[i++] = 0;
+
+	cell->key_desc = cell->name + i;
+	memcpy(cell->key_desc, "afs@", 4);
+	memcpy(cell->key_desc + 4, cell->name, cell->name_len + 1);
 
 	cell->net = net;
 	refcount_set(&cell->ref, 1);
@@ -710,33 +716,6 @@ void afs_set_cell_timer(struct afs_cell *cell, unsigned int delay_secs)
 	timer_reduce(&cell->management_timer, jiffies + delay_secs * HZ);
 }
 
-/*
- * Allocate a key to use as a placeholder for anonymous user security.
- */
-static int afs_alloc_anon_key(struct afs_cell *cell)
-{
-	struct key *key;
-	char keyname[4 + AFS_MAXCELLNAME + 1], *cp, *dp;
-
-	/* Create a key to represent an anonymous user. */
-	memcpy(keyname, "afs@", 4);
-	dp = keyname + 4;
-	cp = cell->name;
-	do {
-		*dp++ = tolower(*cp);
-	} while (*cp++);
-
-	key = rxrpc_get_null_key(keyname);
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
-	cell->anonymous_key = key;
-
-	_debug("anon key %p{%x}",
-	       cell->anonymous_key, key_serial(cell->anonymous_key));
-	return 0;
-}
-
 /*
  * Activate a cell.
  */
@@ -746,12 +725,6 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 	struct afs_cell *pcell;
 	int ret;
 
-	if (!cell->anonymous_key) {
-		ret = afs_alloc_anon_key(cell);
-		if (ret < 0)
-			return ret;
-	}
-
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 87828d685293..470e6eef8bd4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -413,6 +413,7 @@ struct afs_cell {
 
 	u8			name_len;	/* Length of name */
 	char			*name;		/* Cell name, case-flattened and NUL-padded */
+	char			*key_desc;	/* Authentication key description */
 };
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..55ddce94af03 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -16,6 +16,31 @@
 
 static DEFINE_HASHTABLE(afs_permits_cache, 10);
 static DEFINE_SPINLOCK(afs_permits_lock);
+static DEFINE_MUTEX(afs_key_lock);
+
+/*
+ * Allocate a key to use as a placeholder for anonymous user security.
+ */
+static int afs_alloc_anon_key(struct afs_cell *cell)
+{
+	struct key *key;
+
+	mutex_lock(&afs_key_lock);
+	key = cell->anonymous_key;
+	if (!key) {
+		key = rxrpc_get_null_key(cell->key_desc);
+		if (!IS_ERR(key))
+			cell->anonymous_key = key;
+	}
+	mutex_unlock(&afs_key_lock);
+
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	_debug("anon key %p{%x}",
+	       cell->anonymous_key, key_serial(cell->anonymous_key));
+	return 0;
+}
 
 /*
  * get a key
@@ -23,11 +48,12 @@ static DEFINE_SPINLOCK(afs_permits_lock);
 struct key *afs_request_key(struct afs_cell *cell)
 {
 	struct key *key;
+	int ret;
 
-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 
-	_debug("key %s", cell->anonymous_key->description);
-	key = request_key_net(&key_type_rxrpc, cell->anonymous_key->description,
+	_debug("key %s", cell->key_desc);
+	key = request_key_net(&key_type_rxrpc, cell->key_desc,
 			      cell->net->net, NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
@@ -35,6 +61,12 @@ struct key *afs_request_key(struct afs_cell *cell)
 			return key;
 		}
 
+		if (!cell->anonymous_key) {
+			ret = afs_alloc_anon_key(cell);
+			if (ret < 0)
+				return ERR_PTR(ret);
+		}
+
 		/* act as anonymous user */
 		_leave(" = {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
@@ -52,11 +84,10 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 {
 	struct key *key;
 
-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 
-	_debug("key %s", cell->anonymous_key->description);
-	key = request_key_net_rcu(&key_type_rxrpc,
-				  cell->anonymous_key->description,
+	_debug("key %s", cell->key_desc);
+	key = request_key_net_rcu(&key_type_rxrpc, cell->key_desc,
 				  cell->net->net);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
@@ -65,6 +96,8 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 		}
 
 		/* act as anonymous user */
+		if (!cell->anonymous_key)
+			return NULL; /* Need to allocate */
 		_leave(" = {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
 	} else {
@@ -408,7 +441,7 @@ int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (mask & MAY_NOT_BLOCK) {
 		key = afs_request_key_rcu(vnode->volume->cell);
-		if (IS_ERR(key))
+		if (IS_ERR_OR_NULL(key))
 			return -ECHILD;
 
 		ret = -ECHILD;
diff --git a/fs/namespace.c b/fs/namespace.c
index fd988bc759bd..e059c2c9867f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5901,6 +5901,8 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 
 	if (kreq->mnt_ns_id) {
 		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
+		if (!mnt_ns)
+			return ERR_PTR(-ENOENT);
 	} else if (kreq->mnt_ns_fd) {
 		struct ns_common *ns;
 
@@ -5916,13 +5918,12 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 			return ERR_PTR(-EINVAL);
 
 		mnt_ns = to_mnt_ns(ns);
+		refcount_inc(&mnt_ns->passive);
 	} else {
 		mnt_ns = current->nsproxy->mnt_ns;
+		refcount_inc(&mnt_ns->passive);
 	}
-	if (!mnt_ns)
-		return ERR_PTR(-ENOENT);
 
-	refcount_inc(&mnt_ns->passive);
 	return mnt_ns;
 }
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 41033bac96cb..ab652164ffc9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1234,9 +1234,9 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
 		goto err;
 	if (trap)
 		goto err_unlock;
-	if (work && work->d_parent != workdir)
+	if (work && (work->d_parent != workdir || d_unhashed(work)))
 		goto err_unlock;
-	if (upper && upper->d_parent != upperdir)
+	if (upper && (upper->d_parent != upperdir || d_unhashed(upper)))
 		goto err_unlock;
 
 	return 0;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d65ab7e4b1c2..da5df364a2b3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4455,6 +4455,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 
 out:
 	kfree(ctx->username);
+	kfree(ctx->domainname);
 	kfree_sensitive(ctx->password);
 	kfree(origin_fullpath);
 	kfree(ctx);
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 5eb66a399002..4f33e6a39797 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -174,5 +174,6 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 				  size_t size, bool cyclic);
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer);
 void iio_dma_buffer_unlock_queue(struct iio_buffer *buffer);
+struct device *iio_dma_buffer_get_dma_dev(struct iio_buffer *buffer);
 
 #endif
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index e72552e026f3..8d770ced66b2 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -50,6 +50,7 @@ struct sg_table;
  * @enqueue_dmabuf:	called from userspace via ioctl to queue this DMABUF
  *			object to this buffer. Requires a valid DMABUF fd, that
  *			was previouly attached to this buffer.
+ * @get_dma_dev:	called to get the DMA channel associated with this buffer.
  * @lock_queue:		called when the core needs to lock the buffer queue;
  *                      it is used when enqueueing DMABUF objects.
  * @unlock_queue:       used to unlock a previously locked buffer queue
@@ -90,6 +91,7 @@ struct iio_buffer_access_funcs {
 			      struct iio_dma_buffer_block *block,
 			      struct dma_fence *fence, struct sg_table *sgt,
 			      size_t size, bool cyclic);
+	struct device * (*get_dma_dev)(struct iio_buffer *buffer);
 	void (*lock_queue)(struct iio_buffer *buffer);
 	void (*unlock_queue)(struct iio_buffer *buffer);
 
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 4c1a91b07de3..e1555e06e7e5 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -77,6 +77,16 @@ struct cmdq_pkt {
 	size_t			buf_size; /* real buffer size */
 };
 
+/**
+ * cmdq_get_shift_pa() - get the shift bits of physical address
+ * @chan: mailbox channel
+ *
+ * GCE can only fetch the command buffer address from a 32-bit register.
+ * Some SOCs support more than 32-bit command buffer address for GCE, which
+ * requires some shift bits to make the address fit into the 32-bit register.
+ *
+ * Return: the shift bits of physical address
+ */
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
 
 #endif /* __MTK_CMDQ_MAILBOX_H__ */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 3aaf19e77558..8285b19a25e0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -376,6 +376,9 @@ struct usb_gadget_ops {
  *	can handle. The UDC must support this and all slower speeds and lower
  *	number of lanes.
  * @state: the state we are now (attached, suspended, configured, etc)
+ * @state_lock: Spinlock protecting the `state` and `teardown` members.
+ * @teardown: True if the device is undergoing teardown, used to prevent
+ *	new work from being scheduled during cleanup.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -451,6 +454,8 @@ struct usb_gadget {
 	enum usb_ssp_rate		max_ssp_rate;
 
 	enum usb_device_state		state;
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..75dabb763c65 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
-			    int vlan_hlen)
+			    int vlan_hlen,
+			    bool has_data_valid)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					       has_data_valid, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8d78cb2b9f1a..b020ce30929e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -748,7 +748,6 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
-	__u8		remote_id;
 
 	unsigned int	sent;
 
@@ -856,11 +855,12 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb);
 #else
 static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
@@ -868,23 +868,30 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
-static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+static inline int sco_recv_scodata(struct hci_dev *hdev, u16 handle,
+				   struct sk_buff *skb)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+	     u16 flags);
 #else
 static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
 {
 	return 0;
 }
-static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
-			    u16 flags)
+
+static inline int iso_recv(struct hci_dev *hdev, u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
diff --git a/io_uring/net.c b/io_uring/net.c
index d69f2afa4f7a..1f35f01661e7 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1542,8 +1542,10 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 		int ret;
 
-		ret = io_import_reg_vec(ITER_SOURCE, &kmsg->msg.msg_iter, req,
-					&kmsg->vec, uvec_segs, issue_flags);
+		sr->notif->buf_index = req->buf_index;
+		ret = io_import_reg_vec(ITER_SOURCE, &kmsg->msg.msg_iter,
+					sr->notif, &kmsg->vec, uvec_segs,
+					issue_flags);
 		if (unlikely(ret))
 			return ret;
 		req->flags &= ~REQ_F_IMPORT_BUFFER;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 24c359d9c879..95f37028032d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -486,6 +486,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		case PCI_P2PDMA_MAP_BUS_ADDR:
 			sg->dma_address = pci_p2pdma_bus_addr_map(&p2pdma_state,
 					sg_phys(sg));
+			sg_dma_len(sg) = sg->length;
 			sg_dma_mark_bus_address(sg);
 			continue;
 		default:
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 08e0943b54da..4790da895203 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3073,8 +3073,10 @@ static int __init tk_aux_sysfs_init(void)
 		char id[2] = { [0] = '0' + i, };
 		struct kobject *clk = kobject_create_and_add(id, auxo);
 
-		if (!clk)
+		if (!clk) {
+			ret = -ENOMEM;
 			goto err_clean;
+		}
 
 		ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
 		if (ret)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eb256378e65b..63016bc83f2c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8781,8 +8781,18 @@ static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 	put_snapshot_map(iter->tr);
 }
 
+static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Trace buffer mappings require the complete buffer including
+	 * the meta page. Partial mappings are not supported.
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct tracing_buffers_vmops = {
 	.close		= tracing_buffers_mmap_close,
+	.may_split      = tracing_buffers_may_split,
 };
 
 static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5e1ee566841..5d63ee72c1f6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3626,6 +3626,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
 
+	/*
+	 * Folios that just got truncated cannot get split. Signal to the
+	 * caller that there was a race.
+	 *
+	 * TODO: this will also currently refuse shmem folios that are in the
+	 * swapcache.
+	 */
+	if (!is_anon && !folio->mapping)
+		return -EBUSY;
+
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
@@ -3666,18 +3676,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
diff --git a/mm/memfd.c b/mm/memfd.c
index bbe679895ef6..de3115b0dd09 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,9 +96,36 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 						    NULL,
 						    gfp_mask);
 		if (folio) {
+			u32 hash;
+
+			/*
+			 * Zero the folio to prevent information leaks to userspace.
+			 * Use folio_zero_user() which is optimized for huge/gigantic
+			 * pages. Pass 0 as addr_hint since this is not a faulting path
+			 *  and we don't have a user virtual address yet.
+			 */
+			folio_zero_user(folio, 0);
+
+			/*
+			 * Mark the folio uptodate before adding to page cache,
+			 * as required by filemap.c and other hugetlb paths.
+			 */
+			__folio_mark_uptodate(folio);
+
+			/*
+			 * Serialize hugepage allocation and instantiation to prevent
+			 * races with concurrent allocations, as required by all other
+			 * callers of hugetlb_add_to_page_cache().
+			 */
+			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
+
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
 			if (err) {
 				folio_put(folio);
 				goto err_unresv;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ad438a4d0e68..73065d75d0e1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1866,10 +1866,8 @@ swp_entry_t get_swap_page_of_type(int type)
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
 			offset = cluster_alloc_swap_entry(si, 0, 1);
-			if (offset) {
+			if (offset)
 				entry = swp_entry(si->type, offset);
-				atomic_long_dec(&nr_swap_pages);
-			}
 		}
 		put_swap_device(si);
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 55e0722fd066..057ec1a5230d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3804,13 +3804,14 @@ static void hci_tx_work(struct work_struct *work)
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3822,36 +3823,27 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.acl_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (conn) {
-		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
-
-		/* Send to upper protocol */
-		l2cap_recv_acldata(conn, skb, flags);
-		return;
-	} else {
+	err = l2cap_recv_acldata(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "SCO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3863,34 +3855,28 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.sco_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
+	hci_skb_pkt_status(skb) = flags & 0x03;
 
-	if (conn) {
-		/* Send to upper protocol */
-		hci_skb_pkt_status(skb) = flags & 0x03;
-		sco_recv_scodata(conn, skb);
-		return;
-	} else {
+	err = sco_recv_scodata(hdev, handle, skb);
+	if (err == -ENOENT)
 		bt_dev_err_ratelimited(hdev, "SCO packet for unknown connection handle %d",
 				       handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "SCO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_iso_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ISO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3900,22 +3886,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (!conn) {
+	err = iso_recv(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
 			   handle);
-		goto drop;
-	}
-
-	/* Send to upper protocol */
-	iso_recv(conn, skb, flags);
-	return;
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static bool hci_req_is_complete(struct hci_dev *hdev)
@@ -4093,7 +4070,7 @@ static void hci_rx_work(struct work_struct *work)
 	}
 }
 
-static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
@@ -4105,16 +4082,19 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!hdev->sent_cmd) {
 		skb_queue_head(&hdev->cmd_q, skb);
 		queue_work(hdev->workqueue, &hdev->cmd_work);
-		return;
+		return -EINVAL;
 	}
 
 	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
 		err = hci_send_frame(hdev, skb);
 		if (err < 0) {
 			hci_cmd_sync_cancel_sync(hdev, -err);
-			return;
+			return err;
 		}
 		atomic_dec(&hdev->cmd_cnt);
+	} else {
+		err = -ENODATA;
+		kfree_skb(skb);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4122,12 +4102,15 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
+
+	return err;
 }
 
 static void hci_cmd_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
 	struct sk_buff *skb;
+	int err;
 
 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
 	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
@@ -4138,7 +4121,9 @@ static void hci_cmd_work(struct work_struct *work)
 		if (!skb)
 			return;
 
-		hci_send_cmd_sync(hdev, skb);
+		err = hci_send_cmd_sync(hdev, skb);
+		if (err)
+			return;
 
 		rcu_read_lock();
 		if (test_bit(HCI_RESET, &hdev->flags) ||
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..ad19022ae127 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1311,7 +1311,9 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
+		hci_dev_unlock(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3d98cb6291da..616c2fef91d2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2314,14 +2314,31 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	iso_conn_del(hcon, bt_to_errno(reason));
 }
 
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct hci_conn *hcon;
+	struct iso_conn *conn;
 	struct skb_shared_hwtstamps *hwts;
 	__u16 pb, ts, len, sn;
 
-	if (!conn)
-		goto drop;
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2377,7 +2394,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			hci_skb_pkt_seqnum(skb) = sn;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2455,6 +2472,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35c57657bcf4..07b493331fd7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7510,13 +7510,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 	return c;
 }
 
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
+		       struct sk_buff *skb, u16 flags)
 {
+	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
 	int len;
 
-	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
-	hci_dev_lock(hcon->hdev);
+	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
 
 	conn = hcon->l2cap_data;
 
@@ -7524,12 +7535,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn) {
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
@@ -7643,6 +7655,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..298c2a9ab4df 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1458,22 +1458,39 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	sco_conn_del(hcon, bt_to_errno(reason));
 }
 
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct hci_conn *hcon;
+	struct sco_conn *conn;
 
-	if (!conn)
-		goto drop;
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = sco_conn_hold_unless_zero(hcon->sco_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	BT_DBG("conn %p len %u", conn, skb->len);
 
-	if (skb->len) {
+	if (skb->len)
 		sco_recv_frame(conn, skb);
-		return;
-	}
+	else
+		kfree_skb(skb);
 
-drop:
-	kfree_skb(skb);
+	sco_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb sco_cb = {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 45512b2ba951..3a1ce04a7a53 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
-	u32 passkey;
+	u32 passkey = 0;
 	int err;
 
 	bt_dev_dbg(hcon->hdev, "conn %p", conn);
@@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		/* Only Just-Works pairing requires extra checks */
-		if (smp->method != JUST_WORKS)
-			goto mackey_and_ltk;
-
-		/* If there already exists long term key in local host, leave
-		 * the decision to user space since the remote device could
-		 * be legitimate or malicious.
-		 */
-		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role)) {
-			/* Set passkey to 0. The value can be any number since
-			 * it'll be ignored anyway.
-			 */
-			passkey = 0;
-			confirm_hint = 1;
-			goto confirm;
-		}
 	}
 
 mackey_and_ltk:
@@ -2226,11 +2208,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	confirm_hint = 0;
-
-confirm:
-	if (smp->method == JUST_WORKS)
-		confirm_hint = 1;
+	/* Always require user confirmation for Just-Works pairing to prevent
+	 * impersonation attacks, or in case of a legitimate device that is
+	 * repairing use the confirmation as acknowledgment to proceed with the
+	 * creation of new keys.
+	 */
+	confirm_hint = smp->method == JUST_WORKS ? 1 : 0;
 
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index b71b1635916e..a21c157daf7d 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -631,6 +631,7 @@ static int handle_auth_session_key(struct ceph_auth_client *ac, u64 global_id,
 
 	/* connection secret */
 	ceph_decode_32_safe(p, end, len, e_inval);
+	ceph_decode_need(p, end, len, e_inval);
 	dout("%s connection secret blob len %d\n", __func__, len);
 	if (len > 0) {
 		dp = *p + ceph_x_encrypt_offset();
@@ -648,6 +649,7 @@ static int handle_auth_session_key(struct ceph_auth_client *ac, u64 global_id,
 
 	/* service tickets */
 	ceph_decode_32_safe(p, end, len, e_inval);
+	ceph_decode_need(p, end, len, e_inval);
 	dout("%s service tickets blob len %d\n", __func__, len);
 	if (len > 0) {
 		ret = ceph_x_proc_ticket_reply(ac, &th->session_key,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55..285e981730e5 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -785,42 +785,53 @@ void ceph_reset_client_addr(struct ceph_client *client)
 }
 EXPORT_SYMBOL(ceph_reset_client_addr);
 
-/*
- * true if we have the mon map (and have thus joined the cluster)
- */
-static bool have_mon_and_osd_map(struct ceph_client *client)
-{
-	return client->monc.monmap && client->monc.monmap->epoch &&
-	       client->osdc.osdmap && client->osdc.osdmap->epoch;
-}
-
 /*
  * mount: join the ceph cluster, and open root directory.
  */
 int __ceph_open_session(struct ceph_client *client, unsigned long started)
 {
-	unsigned long timeout = client->options->mount_timeout;
-	long err;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	long timeout = ceph_timeout_jiffies(client->options->mount_timeout);
+	bool have_monmap, have_osdmap;
+	int err;
 
 	/* open session, and wait for mon and osd maps */
 	err = ceph_monc_open_session(&client->monc);
 	if (err < 0)
 		return err;
 
-	while (!have_mon_and_osd_map(client)) {
-		if (timeout && time_after_eq(jiffies, started + timeout))
-			return -ETIMEDOUT;
+	add_wait_queue(&client->auth_wq, &wait);
+	for (;;) {
+		mutex_lock(&client->monc.mutex);
+		err = client->auth_err;
+		have_monmap = client->monc.monmap && client->monc.monmap->epoch;
+		mutex_unlock(&client->monc.mutex);
+
+		down_read(&client->osdc.lock);
+		have_osdmap = client->osdc.osdmap && client->osdc.osdmap->epoch;
+		up_read(&client->osdc.lock);
+
+		if (err || (have_monmap && have_osdmap))
+			break;
+
+		if (signal_pending(current)) {
+			err = -ERESTARTSYS;
+			break;
+		}
+
+		if (!timeout) {
+			err = -ETIMEDOUT;
+			break;
+		}
 
 		/* wait */
 		dout("mount waiting for mon_map\n");
-		err = wait_event_interruptible_timeout(client->auth_wq,
-			have_mon_and_osd_map(client) || (client->auth_err < 0),
-			ceph_timeout_jiffies(timeout));
-		if (err < 0)
-			return err;
-		if (client->auth_err < 0)
-			return client->auth_err;
+		timeout = wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
 	}
+	remove_wait_queue(&client->auth_wq, &wait);
+
+	if (err)
+		return err;
 
 	pr_info("client%llu fsid %pU\n", ceph_client_gid(client),
 		&client->fsid);
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 2110439f8a24..83c270bce63c 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -36,8 +36,9 @@ static int monmap_show(struct seq_file *s, void *p)
 	int i;
 	struct ceph_client *client = s->private;
 
+	mutex_lock(&client->monc.mutex);
 	if (client->monc.monmap == NULL)
-		return 0;
+		goto out_unlock;
 
 	seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
 	for (i = 0; i < client->monc.monmap->num_mon; i++) {
@@ -48,6 +49,9 @@ static int monmap_show(struct seq_file *s, void *p)
 			   ENTITY_NAME(inst->name),
 			   ceph_pr_addr(&inst->addr));
 	}
+
+out_unlock:
+	mutex_unlock(&client->monc.mutex);
 	return 0;
 }
 
@@ -56,13 +60,14 @@ static int osdmap_show(struct seq_file *s, void *p)
 	int i;
 	struct ceph_client *client = s->private;
 	struct ceph_osd_client *osdc = &client->osdc;
-	struct ceph_osdmap *map = osdc->osdmap;
+	struct ceph_osdmap *map;
 	struct rb_node *n;
 
+	down_read(&osdc->lock);
+	map = osdc->osdmap;
 	if (map == NULL)
-		return 0;
+		goto out_unlock;
 
-	down_read(&osdc->lock);
 	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
 			osdc->epoch_barrier, map->flags);
 
@@ -131,6 +136,7 @@ static int osdmap_show(struct seq_file *s, void *p)
 		seq_printf(s, "]\n");
 	}
 
+out_unlock:
 	up_read(&osdc->lock);
 	return 0;
 }
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 5483b4eed94e..295907c0eef3 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1087,13 +1087,16 @@ static int decrypt_control_remainder(struct ceph_connection *con)
 static int process_v2_sparse_read(struct ceph_connection *con,
 				  struct page **pages, int spos)
 {
-	struct ceph_msg_data_cursor *cursor = &con->v2.in_cursor;
+	struct ceph_msg_data_cursor cursor;
 	int ret;
 
+	ceph_msg_data_cursor_init(&cursor, con->in_msg,
+				  con->in_msg->sparse_read_total);
+
 	for (;;) {
 		char *buf = NULL;
 
-		ret = con->ops->sparse_read(con, cursor, &buf);
+		ret = con->ops->sparse_read(con, &cursor, &buf);
 		if (ret <= 0)
 			return ret;
 
@@ -1111,11 +1114,11 @@ static int process_v2_sparse_read(struct ceph_connection *con,
 			} else {
 				struct bio_vec bv;
 
-				get_bvec_at(cursor, &bv);
+				get_bvec_at(&cursor, &bv);
 				len = min_t(int, len, bv.bv_len);
 				memcpy_page(bv.bv_page, bv.bv_offset,
 					    spage, soff, len);
-				ceph_msg_data_advance(cursor, len);
+				ceph_msg_data_advance(&cursor, len);
 			}
 			spos += len;
 			ret -= len;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 295098873861..d245fa508e1c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1504,8 +1504,6 @@ static int decode_new_primary_temp(void **p, void *end,
 
 u32 ceph_get_primary_affinity(struct ceph_osdmap *map, int osd)
 {
-	BUG_ON(osd >= map->max_osd);
-
 	if (!map->osd_primary_affinity)
 		return CEPH_OSD_DEFAULT_PRIMARY_AFFINITY;
 
@@ -1514,8 +1512,6 @@ u32 ceph_get_primary_affinity(struct ceph_osdmap *map, int osd)
 
 static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
 {
-	BUG_ON(osd >= map->max_osd);
-
 	if (!map->osd_primary_affinity) {
 		int i;
 
@@ -1577,6 +1573,8 @@ static int decode_new_primary_affinity(void **p, void *end,
 
 		ceph_decode_32_safe(p, end, osd, e_inval);
 		ceph_decode_32_safe(p, end, aff, e_inval);
+		if (osd >= map->max_osd)
+			goto e_inval;
 
 		ret = set_primary_affinity(map, osd, aff);
 		if (ret)
@@ -1879,7 +1877,9 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 		ceph_decode_need(p, end, 2*sizeof(u32), e_inval);
 		osd = ceph_decode_32(p);
 		w = ceph_decode_32(p);
-		BUG_ON(osd >= map->max_osd);
+		if (osd >= map->max_osd)
+			goto e_inval;
+
 		osdmap_info(map, "osd%d weight 0x%x %s\n", osd, w,
 			    w == CEPH_OSD_IN ? "(in)" :
 			    (w == CEPH_OSD_OUT ? "(out)" : ""));
@@ -1905,13 +1905,15 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 		u32 xorstate;
 
 		osd = ceph_decode_32(p);
+		if (osd >= map->max_osd)
+			goto e_inval;
+
 		if (struct_v >= 5)
 			xorstate = ceph_decode_32(p);
 		else
 			xorstate = ceph_decode_8(p);
 		if (xorstate == 0)
 			xorstate = CEPH_OSD_UP;
-		BUG_ON(osd >= map->max_osd);
 		if ((map->osd_state[osd] & CEPH_OSD_UP) &&
 		    (xorstate & CEPH_OSD_UP))
 			osdmap_info(map, "osd%d down\n", osd);
@@ -1937,7 +1939,9 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 		struct ceph_entity_addr addr;
 
 		osd = ceph_decode_32(p);
-		BUG_ON(osd >= map->max_osd);
+		if (osd >= map->max_osd)
+			goto e_inval;
+
 		if (struct_v >= 7)
 			ret = ceph_decode_entity_addrvec(p, end, msgr2, &addr);
 		else
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 4d314e062ba9..2ac4011a953f 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -623,6 +623,7 @@ static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 
 	skb->protocol = htons(ETH_P_MCTP);
 	skb->pkt_type = PACKET_OUTGOING;
+	skb->dev = dst->dev->dev;
 
 	if (skb->len > dst->mtu) {
 		kfree_skb(skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bcc94d03da21..8afa269b4d15 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2637,7 +2637,7 @@ static void __mptcp_retrans(struct sock *sk)
 		}
 
 		if (!mptcp_send_head(sk))
-			return;
+			goto clear_scheduled;
 
 		goto reset_timer;
 	}
@@ -2668,7 +2668,7 @@ static void __mptcp_retrans(struct sock *sk)
 			if (__mptcp_check_fallback(msk)) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				return;
+				goto clear_scheduled;
 			}
 
 			while (info.sent < info.limit) {
@@ -2700,6 +2700,15 @@ static void __mptcp_retrans(struct sock *sk)
 
 	if (!mptcp_rtx_timer_pending(sk))
 		mptcp_reset_rtx_timer(sk);
+
+clear_scheduled:
+	/* If no rtx data was available or in case of fallback, there
+	 * could be left-over scheduled subflows; clear them all
+	 * or later xmit could use bad ones
+	 */
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->scheduled))
+			mptcp_subflow_set_scheduled(subflow, false);
 }
 
 /* schedule the timeout timer for the relevant event: either close timeout
@@ -2761,6 +2770,12 @@ static void mptcp_do_fastclose(struct sock *sk)
 			goto unlock;
 
 		subflow->send_fastclose = 1;
+
+		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
+		 * issue in __tcp_select_window(), see tcp_disconnect().
+		 */
+		inet_csk(ssk)->icsk_ack.rcv_mss = TCP_MIN_MSS;
+
 		tcp_send_active_reset(ssk, ssk->sk_allocation,
 				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 unlock:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72e34bd2d925..78fc25e88d7c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,20 +36,13 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
-struct xsk_addr_node {
-	u64 addr;
-	struct list_head addr_node;
-};
-
-struct xsk_addr_head {
+struct xsk_addrs {
 	u32 num_descs;
-	struct list_head addrs_list;
+	u64 addrs[MAX_SKB_FRAGS + 1];
 };
 
 static struct kmem_cache *xsk_tx_generic_cache;
 
-#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -558,29 +551,68 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	return ret;
 }
 
+static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
+{
+	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+}
+
+static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
+{
+	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
+}
+
+static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+{
+	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+}
+
+static void xsk_inc_num_desc(struct sk_buff *skb)
+{
+	struct xsk_addrs *xsk_addr;
+
+	if (!xsk_skb_destructor_is_addr(skb)) {
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		xsk_addr->num_descs++;
+	}
+}
+
+static u32 xsk_get_num_desc(struct sk_buff *skb)
+{
+	struct xsk_addrs *xsk_addr;
+
+	if (xsk_skb_destructor_is_addr(skb))
+		return 1;
+
+	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+
+	return xsk_addr->num_descs;
+}
+
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 				      struct sk_buff *skb)
 {
-	struct xsk_addr_node *pos, *tmp;
+	u32 num_descs = xsk_get_num_desc(skb);
+	struct xsk_addrs *xsk_addr;
 	u32 descs_processed = 0;
 	unsigned long flags;
-	u32 idx;
+	u32 idx, i;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	xskq_prod_write_addr(pool->cq, idx,
-			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
-	descs_processed++;
+	if (unlikely(num_descs > 1)) {
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 
-	if (unlikely(XSKCB(skb)->num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+		for (i = 0; i < num_descs; i++) {
 			xskq_prod_write_addr(pool->cq, idx + descs_processed,
-					     pos->addr);
+					     xsk_addr->addrs[i]);
 			descs_processed++;
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
+	} else {
+		xskq_prod_write_addr(pool->cq, idx,
+				     xsk_skb_destructor_get_addr(skb));
+		descs_processed++;
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
@@ -595,16 +627,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static void xsk_inc_num_desc(struct sk_buff *skb)
-{
-	XSKCB(skb)->num_descs++;
-}
-
-static u32 xsk_get_num_desc(struct sk_buff *skb)
-{
-	return XSKCB(skb)->num_descs;
-}
-
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
@@ -618,25 +640,25 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			      u64 addr)
 {
-	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
-	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
-	XSKCB(skb)->num_descs = 0;
-	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
+	skb->dev = xs->dev;
+	skb->priority = READ_ONCE(xs->sk.sk_priority);
+	skb->mark = READ_ONCE(xs->sk.sk_mark);
+	skb->destructor = xsk_destruct_skb;
+	xsk_skb_destructor_set_addr(skb, addr);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addr_node *pos, *tmp;
+	struct xsk_addrs *xsk_addr;
 
 	if (unlikely(num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
-		}
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
 	}
 
 	skb->destructor = sock_wfree;
@@ -657,7 +679,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
-	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -673,18 +694,28 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_set_destructor_arg(skb, desc->addr);
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	} else {
-		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-		if (!xsk_addr)
-			return ERR_PTR(-ENOMEM);
+		struct xsk_addrs *xsk_addr;
+
+		if (xsk_skb_destructor_is_addr(skb)) {
+			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
+						     GFP_KERNEL);
+			if (!xsk_addr)
+				return ERR_PTR(-ENOMEM);
+
+			xsk_addr->num_descs = 1;
+			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
+			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+		} else {
+			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		}
 
 		/* in case of -EOVERFLOW that could happen below,
 		 * xsk_consume_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
-		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 	}
 
 	addr = desc->addr;
@@ -757,13 +788,28 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_set_destructor_arg(skb, desc->addr);
+			xsk_skb_init_misc(skb, xs, desc->addr);
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addr_node *xsk_addr;
+			struct xsk_addrs *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
+			if (xsk_skb_destructor_is_addr(skb)) {
+				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
+							     GFP_KERNEL);
+				if (!xsk_addr) {
+					err = -ENOMEM;
+					goto free_err;
+				}
+
+				xsk_addr->num_descs = 1;
+				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
+				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+			} else {
+				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+			}
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -775,13 +821,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-			if (!xsk_addr) {
-				__free_page(page);
-				err = -ENOMEM;
-				goto free_err;
-			}
-
 			vaddr = kmap_local_page(page);
 			memcpy(vaddr, buffer, len);
 			kunmap_local(vaddr);
@@ -789,8 +828,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 
-			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 
 		if (first_frag && desc->options & XDP_TX_METADATA) {
@@ -826,14 +864,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 				skb->skb_mstamp_ns = meta->request.launch_time;
+			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 		}
 	}
 
-	skb->dev = dev;
-	skb->priority = READ_ONCE(xs->sk.sk_priority);
-	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	skb->destructor = xsk_destruct_skb;
-	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 	xsk_inc_num_desc(skb);
 
 	return skb;
@@ -1891,7 +1925,7 @@ static int __init xsk_init(void)
 		goto out_pernet;
 
 	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
-						 sizeof(struct xsk_addr_node),
+						 sizeof(struct xsk_addrs),
 						 0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!xsk_tx_generic_cache) {
 		err = -ENOMEM;
diff --git a/sound/hda/codecs/cirrus/cs420x.c b/sound/hda/codecs/cirrus/cs420x.c
index 823220d5cada..13f5f1711fa4 100644
--- a/sound/hda/codecs/cirrus/cs420x.c
+++ b/sound/hda/codecs/cirrus/cs420x.c
@@ -585,6 +585,7 @@ static const struct hda_quirk cs4208_mac_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x6c00, "MacMini 7,1", CS4208_MACMINI),
 	SND_PCI_QUIRK(0x106b, 0x7100, "MacBookAir 6,1", CS4208_MBA6),
 	SND_PCI_QUIRK(0x106b, 0x7200, "MacBookAir 6,2", CS4208_MBA6),
+	SND_PCI_QUIRK(0x106b, 0x7800, "MacPro 6,1", CS4208_MACMINI),
 	SND_PCI_QUIRK(0x106b, 0x7b00, "MacBookPro 12,1", CS4208_MBP11),
 	{} /* terminator */
 };
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4a35f962527e..b04f52adb1f4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2028,6 +2028,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x249c, 0x9326): /* M2Tech Young MkIII */
 	case USB_ID(0x2616, 0x0106): /* PS Audio NuWave DAC */
 	case USB_ID(0x2622, 0x0041): /* Audiolab M-DAC+ */
+	case USB_ID(0x2622, 0x0061): /* LEAK Stereo 230 */
 	case USB_ID(0x278b, 0x5100): /* Rotel RC-1590 */
 	case USB_ID(0x27f7, 0x3002): /* W4S DAC-2v2SE */
 	case USB_ID(0x29a2, 0x0086): /* Mutec MC3+ USB */
@@ -2411,6 +2412,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x25ce, /* Mytek devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2622, /* IAG Limited devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x278b, /* Rotel? */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x292b, /* Gustard/Ess based devices */

