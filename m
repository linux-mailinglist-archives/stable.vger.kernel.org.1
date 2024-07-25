Return-Path: <stable+bounces-61364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1093BDCC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963641F22FBD
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740291741FE;
	Thu, 25 Jul 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vYKRDbsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE71741FC;
	Thu, 25 Jul 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895289; cv=none; b=NnbfbamEBY7f1wZo8VoGghyTZ4Z/OAYyqCmhLFVr6b4kllmVgrV+HI6rM98Q7QdupzekEMr9cWilnsD5AaiZfo3aeaw7cvSi7H6pfY2vzGU3kB0JdQDs0laPiObjodOoaTPJUibYLBeWTnbrA51VUmWvY7rPW/yYKeX0MWQlYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895289; c=relaxed/simple;
	bh=CXVGBqxEPrN6hMKY7k65RwCKO72VwYqW+ZWU4fx9hgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkSc0rAYC4RfaLIGnJECJXVYsNM+vVxYYyTDLaC3kMFCIcsPVaaBDoVlsK/tcJtPWbLzlzLd7wxIKsgzCmqdpE0xKuAnzm1b4pERaWKobgvQdU37gMcqVEZvPW31nrHD12CS6UBuQzFt7UET/dp4tfY9mZkfWCK/RJFkVHd0HTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vYKRDbsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD30C116B1;
	Thu, 25 Jul 2024 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721895288;
	bh=CXVGBqxEPrN6hMKY7k65RwCKO72VwYqW+ZWU4fx9hgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vYKRDbskJ4/GnMaUG+bY+N1j0nOeHA6tPc683/Vrfz4a/zbER8Gv+dV7RsWPZWR/O
	 AedDD/bV6vbdugPeGJ3eG4LF1D1duJHRgr1r2bodE04HbjmpC3OQJUCiMUI1JYu6+K
	 Oq0CrP4d3MWjdTqGQj3BMy23HyyijTAb74llvnYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.9.11
Date: Thu, 25 Jul 2024 10:14:33 +0200
Message-ID: <2024072533-strewn-crescent-16c2@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024072533-robin-dealmaker-a3ab@gregkh>
References: <2024072533-robin-dealmaker-a3ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 7964fe134277..6c1303cff159 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -217,7 +217,7 @@ current *struct* is::
 		int (*media_changed)(struct cdrom_device_info *, int);
 		int (*tray_move)(struct cdrom_device_info *, int);
 		int (*lock_door)(struct cdrom_device_info *, int);
-		int (*select_speed)(struct cdrom_device_info *, int);
+		int (*select_speed)(struct cdrom_device_info *, unsigned long);
 		int (*get_last_session) (struct cdrom_device_info *,
 					 struct cdrom_multisession *);
 		int (*get_mcn)(struct cdrom_device_info *, struct cdrom_mcn *);
@@ -396,7 +396,7 @@ action need be taken, and the return value should be 0.
 
 ::
 
-	int select_speed(struct cdrom_device_info *cdi, int speed)
+	int select_speed(struct cdrom_device_info *cdi, unsigned long speed)
 
 Some CD-ROM drives are capable of changing their head-speed. There
 are several reasons for changing the speed of a CD-ROM drive. Badly
diff --git a/Makefile b/Makefile
index 5471f554f95e..46457f645921 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 9
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index dd6ce86d4332..b776e7424fe9 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -462,6 +462,9 @@ static int run_all_insn_set_hw_mode(unsigned int cpu)
 	for (int i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
 		struct insn_emulation *insn = insn_emulations[i];
 		bool enable = READ_ONCE(insn->current_mode) == INSN_HW;
+		if (insn->status == INSN_UNAVAILABLE)
+			continue;
+
 		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
 			pr_warn("CPU[%u] cannot support the emulation of %s",
 				cpu, insn->name);
diff --git a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
index 8aefb0c12672..a34734a6c3ce 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
@@ -44,14 +44,14 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x0>;
 };
 
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x1>;
 };
 
diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
index ed4d32434041..aaf41b565805 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
@@ -43,7 +43,7 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
@@ -58,7 +58,7 @@ phy0: ethernet-phy@0 {
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy1>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
index 74b99bd234cc..ea9e6985d0e9 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
@@ -92,7 +92,7 @@ phy1: ethernet-phy@1 {
 &gmac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy2>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 0352c07c608e..fe76282a353f 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -27,7 +27,7 @@
 17	o32	break				sys_ni_syscall
 # 18 was sys_stat
 18	o32	unused18			sys_ni_syscall
-19	o32	lseek				sys_lseek
+19	o32	lseek				sys_lseek			compat_sys_lseek
 20	o32	getpid				sys_getpid
 21	o32	mount				sys_mount
 22	o32	umount				sys_oldumount
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index e0ce81279624..7d1b50599dd6 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -849,6 +849,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 {
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
+	struct pci_bus *bus = NULL;
 
 	if (pe->type & EEH_PE_PHB)
 		return pe->phb->bus;
@@ -859,9 +860,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
 	/* Retrieve the parent PCI bus of first (top) PCI device */
 	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, entry);
+	pci_lock_rescan_remove();
 	pdev = eeh_dev_to_pci_dev(edev);
 	if (pdev)
-		return pdev->bus;
+		bus = pdev->bus;
+	pci_unlock_rescan_remove();
 
-	return NULL;
+	return bus;
 }
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index b569ebaa590e..3ff3de9a52ac 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -130,14 +130,16 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 	rcu_read_unlock();
 
-	fdput(f);
-
-	if (!found)
+	if (!found) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	table_group = iommu_group_get_iommudata(grp);
-	if (WARN_ON(!table_group))
+	if (WARN_ON(!table_group)) {
+		fdput(f);
 		return -EFAULT;
+	}
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
 		struct iommu_table *tbltmp = table_group->tables[i];
@@ -158,8 +160,10 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			break;
 		}
 	}
-	if (!tbl)
+	if (!tbl) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -170,6 +174,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			/* stit is being destroyed */
 			iommu_tce_table_put(tbl);
 			rcu_read_unlock();
+			fdput(f);
 			return -ENOTTY;
 		}
 		/*
@@ -177,6 +182,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 		 * its KVM reference counter and can return.
 		 */
 		rcu_read_unlock();
+		fdput(f);
 		return 0;
 	}
 	rcu_read_unlock();
@@ -184,6 +190,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
 	if (!stit) {
 		iommu_tce_table_put(tbl);
+		fdput(f);
 		return -ENOMEM;
 	}
 
@@ -192,6 +199,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 
 	list_add_rcu(&stit->next, &stt->iommu_tables);
 
+	fdput(f);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b44de0f0822f..b10a25325238 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -343,8 +343,8 @@ static int alloc_dispatch_log_kmem_cache(void)
 {
 	void (*ctor)(void *) = get_dtl_cache_ctor();
 
-	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, ctor);
+	dtl_cache = kmem_cache_create_usercopy("dtl", DISPATCH_LOG_BYTES,
+						DISPATCH_LOG_BYTES, 0, 0, DISPATCH_LOG_BYTES, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 0d3f00eb0bae..10e311b2759d 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -32,6 +32,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int graph_idx = 0;
 	int level = 0;
 
 	if (regs) {
@@ -68,7 +69,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			pc = regs->ra;
 		} else {
 			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 						   &frame->ra);
 			if (pc == (unsigned long)ret_from_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2d4a35e6dd18..09a87fa222c7 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -145,7 +145,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 						  dev_name(&adev->dev), event,
 						  (u32) ac->state);
 		acpi_notifier_call_chain(adev, event, (u32) ac->state);
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 	}
 }
 
@@ -268,7 +268,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (acpi_ac_get_state(ac))
 		return 0;
 	if (old_state != ac->state)
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 
 	return 0;
 }
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1cec29ab64ce..299ec653388c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1333,10 +1333,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
-	for (i = 0; i < bytes; ++i, ++address, ++value)
+	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
+		if (result < 0)
+			break;
+	}
 
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
@@ -1348,8 +1351,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 94e3c000df2e..dc8164b182dc 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -610,7 +610,7 @@ static void acpi_sbs_callback(void *context)
 	if (sbs->charger_exists) {
 		acpi_ac_get_present(sbs);
 		if (sbs->charger_present != saved_charger_state)
-			kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(sbs->charger);
 	}
 
 	if (sbs->manager_present) {
@@ -622,7 +622,7 @@ static void acpi_sbs_callback(void *context)
 			acpi_battery_read(bat);
 			if (saved_battery_state == bat->present)
 				continue;
-			kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(bat->bat);
 		}
 	}
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..95a468eaa701 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -302,6 +302,21 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+
+	if (mode & FALLOC_FL_ZERO_RANGE)
+		lim.max_write_zeroes_sectors = 0;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		lim.max_hw_discard_sectors = 0;
+		lim.discard_granularity = 0;
+	}
+
+	queue_limits_commit_update(lo->lo_queue, &lim);
+}
+
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
@@ -320,6 +335,14 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
+
+	/*
+	 * We initially configure the limits in a hope that fallocate is
+	 * supported and clear them here if that turns out not to be true.
+	 */
+	if (unlikely(ret == -EOPNOTSUPP))
+		loop_clear_limits(lo, mode);
+
 	return ret;
 }
 
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 620679a0ac38..26e2c22a87e1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1810,8 +1810,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize))
+		return -EINVAL;
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9d0c7e278114..9bfa9a6ad56c 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index d7ab5bd5d4b4..e12bb9abf6b6 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -100,7 +100,6 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 static const struct alpha_pll_config ipq5018_pll_config = {
 	.l = 0x2a,
 	.config_ctl_val = 0x4001075b,
-	.config_ctl_hi_val = 0x304,
 	.main_output_mask = BIT(0),
 	.aux_output_mask = BIT(1),
 	.early_output_mask = BIT(3),
@@ -114,7 +113,6 @@ static const struct alpha_pll_config ipq5018_pll_config = {
 static const struct alpha_pll_config ipq5332_pll_config = {
 	.l = 0x2d,
 	.config_ctl_val = 0x4001075b,
-	.config_ctl_hi_val = 0x304,
 	.main_output_mask = BIT(0),
 	.aux_output_mask = BIT(1),
 	.early_output_mask = BIT(3),
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index ac8c0ef85158..af2c82f7bd90 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -41,6 +41,7 @@ SECTIONS
 	}
 
 	/DISCARD/ : {
+		*(.discard .discard.*)
 		*(.modinfo .init.modinfo)
 	}
 }
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 00ffa168e405..f2f40393e369 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -758,6 +758,8 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	int level;
 
 	if (chip->driver_data & PCA_PCAL) {
+		guard(mutex)(&chip->i2c_lock);
+
 		/* Enable latch on interrupt-enabled inputs */
 		pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip->irq_mask);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d89d6829f1df..b10fdd8b5414 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4187,9 +4187,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_i
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info)
 {
-	int i, j, k, counter, xcc_id, active_cu_number = 0;
-	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
+	int i, j, k, prev_counter, counter, xcc_id, active_cu_number = 0;
+	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0, tmp;
 	unsigned disable_masks[4 * 4];
+	bool is_symmetric_cus;
 
 	if (!adev || !cu_info)
 		return -EINVAL;
@@ -4207,6 +4208,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+		is_symmetric_cus = true;
 		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 				mask = 1;
@@ -4234,6 +4236,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 					ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
 				cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 			}
+			if (i && is_symmetric_cus && prev_counter != counter)
+				is_symmetric_cus = false;
+			prev_counter = counter;
+		}
+		if (is_symmetric_cus) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_RELAUNCH_DISABLE, 1);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_DISPATCH_DISABLE, 1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG, tmp);
 		}
 		gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 					    xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 78a95f8f370b..238abd98072a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -32,7 +32,9 @@
 #include "mp/mp_14_0_2_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -64,6 +66,9 @@ static int psp_v14_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
 		break;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2152e40ee1c2..c29d271579ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11161,6 +11161,49 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
+static void parse_edid_displayid_vrr(struct drm_connector *connector,
+		struct edid *edid)
+{
+	u8 *edid_ext = NULL;
+	int i;
+	int j = 0;
+	u16 min_vfreq;
+	u16 max_vfreq;
+
+	if (edid == NULL || edid->extensions == 0)
+		return;
+
+	/* Find DisplayID extension */
+	for (i = 0; i < edid->extensions; i++) {
+		edid_ext = (void *)(edid + (i + 1));
+		if (edid_ext[0] == DISPLAYID_EXT)
+			break;
+	}
+
+	if (edid_ext == NULL)
+		return;
+
+	while (j < EDID_LENGTH) {
+		/* Get dynamic video timing range from DisplayID if available */
+		if (EDID_LENGTH - j > 13 && edid_ext[j] == 0x25	&&
+		    (edid_ext[j+1] & 0xFE) == 0 && (edid_ext[j+2] == 9)) {
+			min_vfreq = edid_ext[j+9];
+			if (edid_ext[j+1] & 7)
+				max_vfreq = edid_ext[j+10] + ((edid_ext[j+11] & 3) << 8);
+			else
+				max_vfreq = edid_ext[j+10];
+
+			if (max_vfreq && min_vfreq) {
+				connector->display_info.monitor_range.max_vfreq = max_vfreq;
+				connector->display_info.monitor_range.min_vfreq = min_vfreq;
+
+				return;
+			}
+		}
+		j++;
+	}
+}
+
 static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			  struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -11282,6 +11325,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module)
 		goto update;
 
+	/* Some eDP panels only have the refresh rate range info in DisplayID */
+	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
+	     connector->display_info.monitor_range.max_vfreq == 0))
+		parse_edid_displayid_vrr(connector, edid);
+
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
@@ -11289,9 +11337,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (is_dp_capable_without_timing_msa(adev->dm.dc,
 						     amdgpu_dm_connector)) {
 			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
-				freesync_capable = true;
 				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
 				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
 			} else {
 				edid_check_required = edid->version > 1 ||
 						      (edid->version == 1 &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 6c84b0fa40f4..0782a34689a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3364,6 +3364,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
 							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
+
+					v->cursor_bw_pre[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0] * mode_lib->vba.CursorBPP[k][0] /
+							8.0 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * v->VRatioPreY[i][j][k];
 				}
 
 				{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 53e40d3c48d4..6716696df771 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -177,7 +177,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 34.0,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index b3ffab77cf88..40ca38dd1b23 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -215,7 +215,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 34,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index a20f28a5d2e7..3af759dca6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -233,6 +233,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
+		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
 		break;
 
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index b72ed3e78df0..bb4e812248ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -294,7 +294,7 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = (unsigned int)in_ctx->v20.dml_core_ctx.mp.DCFCLKDeepSleep * 1000;
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
-	if (in_ctx->v20.dml_core_ctx.ms.support.FCLKChangeSupport[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx] == dml_fclock_change_unsupported)
+	if (in_ctx->v20.dml_core_ctx.ms.support.FCLKChangeSupport[0] == dml_fclock_change_unsupported)
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = false;
 	else
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 2e8e6c9875f6..f83ace2d7ec3 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -477,31 +477,30 @@ typedef struct _ATOM_PPLIB_STATE_V2
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
-    //how many states we have 
-    UCHAR ucNumEntries;
-    
-    ATOM_PPLIB_STATE_V2 states[1];
+	//how many states we have
+	UCHAR ucNumEntries;
+
+	ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
 }StateArray;
 
 
 typedef struct _ClockInfoArray{
-    //how many clock levels we have
-    UCHAR ucNumEntries;
-    
-    //sizeof(ATOM_PPLIB_CLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    UCHAR clockInfo[];
+	//how many clock levels we have
+	UCHAR ucNumEntries;
+
+	//sizeof(ATOM_PPLIB_CLOCK_INFO)
+	UCHAR ucEntrySize;
+
+	UCHAR clockInfo[];
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
+	//how many non-clock levels we have. normally should be same as number of states
+	UCHAR ucNumEntries;
+	//sizeof(ATOM_PPLIB_NONCLOCK_INFO)
+	UCHAR ucEntrySize;
 
-    //how many non-clock levels we have. normally should be same as number of states
-    UCHAR ucNumEntries;
-    //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
+	ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
@@ -513,8 +512,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
@@ -529,8 +530,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Limit_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Limit_Table;
 
 union _ATOM_PPLIB_CAC_Leakage_Record
@@ -553,8 +556,10 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPLIB_CAC_Leakage_Record;
 
 typedef struct _ATOM_PPLIB_CAC_Leakage_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_CAC_Leakage_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_CAC_Leakage_Table;
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
@@ -568,8 +573,10 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_PhaseSheddingLimits_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_PhaseSheddingLimits_Table;
 
 typedef struct _VCEClockInfo{
@@ -580,8 +587,8 @@ typedef struct _VCEClockInfo{
 }VCEClockInfo;
 
 typedef struct _VCEClockInfoArray{
-    UCHAR ucNumEntries;
-    VCEClockInfo entries[1];
+	UCHAR ucNumEntries;
+	VCEClockInfo entries[] __counted_by(ucNumEntries);
 }VCEClockInfoArray;
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
@@ -592,8 +599,8 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_VCE_State_Record
@@ -604,8 +611,8 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
 
 typedef struct _ATOM_PPLIB_VCE_State_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_State_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_State_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_State_Table;
 
 
@@ -626,8 +633,8 @@ typedef struct _UVDClockInfo{
 }UVDClockInfo;
 
 typedef struct _UVDClockInfoArray{
-    UCHAR ucNumEntries;
-    UVDClockInfo entries[1];
+	UCHAR ucNumEntries;
+	UVDClockInfo entries[] __counted_by(ucNumEntries);
 }UVDClockInfoArray;
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
@@ -638,8 +645,8 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_UVD_Table
@@ -657,8 +664,8 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
+	UCHAR numEntries;
+	ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table
@@ -675,8 +682,8 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Record
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_ACP_Table
@@ -743,9 +750,9 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
 } ATOM_PPLIB_VQ_Budgeting_Record;
 
 typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
-    UCHAR revid;
-    UCHAR numEntries;
-    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
+	UCHAR revid;
+	UCHAR numEntries;
+	ATOM_PPLIB_VQ_Budgeting_Record entries[] __counted_by(numEntries);
 } ATOM_PPLIB_VQ_Budgeting_Table;
 
 #pragma pack()
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 65333141b1c1..5a2247018229 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -323,6 +323,18 @@ static int smu_dpm_set_umsch_mm_enable(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_set_mall_enable(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->ppt_funcs->set_mall_enable)
+		return 0;
+
+	ret = smu->ppt_funcs->set_mall_enable(smu);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -1785,6 +1797,7 @@ static int smu_hw_init(void *handle)
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
+		smu_set_mall_enable(smu);
 		smu_set_gfx_cgpg(smu, true);
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1fa81575788c..8667e8c9d7e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1391,6 +1391,11 @@ struct pptable_funcs {
 	 */
 	int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enable);
 
+	/**
+	 * @set_mall_enable: Init MALL power gating control.
+	 */
+	int (*set_mall_enable)(struct smu_context *smu);
+
 	/**
 	 * @notify_rlc_state: Notify RLC power state to SMU.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
index c4dc5881d8df..e7f5ef49049f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -106,8 +106,8 @@
 #define PPSMC_MSG_DisableLSdma                  0x35 ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x36 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x37 ///<
-#define PPSMC_MSG_AllocMALLCache                0x38 ///< Allocating MALL Cache
-#define PPSMC_MSG_ReleaseMALLCache              0x39 ///< Releasing MALL Cache
+#define PPSMC_MSG_MALLPowerController           0x38 ///< Set MALL control
+#define PPSMC_MSG_MALLPowerState                0x39 ///< Enter/Exit MALL PG
 #define PPSMC_Message_Count                     0x3A ///< Total number of PPSMC messages
 /** @}*/
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index af427cc7dbb8..4a7404856b96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -272,7 +272,9 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
+	__SMU_DUMMY_MAP(MALLPowerController), \
+	__SMU_DUMMY_MAP(MALLPowerState),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 63399c00cc28..20f3861b5eea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -52,6 +52,19 @@
 #define mmMP1_SMN_C2PMSG_90			0x029a
 #define mmMP1_SMN_C2PMSG_90_BASE_IDX		    0
 
+/* MALLPowerController message arguments (Defines for the Cache mode control) */
+#define SMU_MALL_PMFW_CONTROL 0
+#define SMU_MALL_DRIVER_CONTROL 1
+
+/*
+ * MALLPowerState message arguments
+ * (Defines for the Allocate/Release Cache mode if in driver mode)
+ */
+#define SMU_MALL_EXIT_PG 0
+#define SMU_MALL_ENTER_PG 1
+
+#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -66,6 +79,12 @@
 	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	| \
 	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
 
+enum smu_mall_pg_config {
+	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON = 1,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF = 2,
+};
+
 static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,				1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,			1),
@@ -113,6 +132,8 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownUmsch,                 PPSMC_MSG_PowerDownUmsch,			1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(MALLPowerController,            PPSMC_MSG_MALLPowerController,		1),
+	MSG_MAP(MALLPowerState,                 PPSMC_MSG_MALLPowerState,			1),
 };
 
 static struct cmn2asic_mapping smu_v14_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -1417,6 +1438,57 @@ static int smu_v14_0_common_get_dpm_table(struct smu_context *smu, struct dpm_cl
 	return 0;
 }
 
+static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, enum smu_mall_pg_config pg_config)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (pg_config == SMU_MALL_PG_CONFIG_PMFW_CONTROL) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
+								SMU_MALL_PMFW_CONTROL, NULL);
+		if (ret) {
+			dev_err(adev->dev, "Init MALL PMFW CONTROL Failure\n");
+			return ret;
+		}
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
+								SMU_MALL_DRIVER_CONTROL, NULL);
+		if (ret) {
+			dev_err(adev->dev, "Init MALL Driver CONTROL Failure\n");
+			return ret;
+		}
+
+		if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
+									SMU_MALL_EXIT_PG, NULL);
+			if (ret) {
+				dev_err(adev->dev, "EXIT MALL PG Failure\n");
+				return ret;
+			}
+		} else if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
+									SMU_MALL_ENTER_PG, NULL);
+			if (ret) {
+				dev_err(adev->dev, "Enter MALL PG Failure\n");
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
+{
+	enum smu_mall_pg_config pg_config = SMU_MALL_PG_CONFIG_DEFAULT;
+	int ret = 0;
+
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		ret = smu_v14_0_1_init_mall_power_gating(smu, pg_config);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1448,6 +1520,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
+	.set_mall_enable = smu_v14_0_common_set_mall_enable,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 426bbee2d9f5..5db52d6c5c35 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index f48c4343f469..3e6d4c6aa877 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -285,7 +285,6 @@ struct platform_driver dp_driver = {
 	.remove_new	= exynos_dp_remove,
 	.driver		= {
 		.name	= "exynos-dp",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&exynos_dp_pm_ops),
 		.of_match_table = exynos_dp_match,
 	},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 74832c213092..0b570e194079 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -950,6 +950,13 @@ static void mtk_drm_remove(struct platform_device *pdev)
 		of_node_put(private->comp_node[i]);
 }
 
+static void mtk_drm_shutdown(struct platform_device *pdev)
+{
+	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(private->drm);
+}
+
 static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
@@ -981,6 +988,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove_new = mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3fec3acdaf28..27225d1fe8d2 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index e83c3e52251d..0250d5f00bf1 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -171,6 +171,13 @@ static void shmob_drm_remove(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 }
 
+static void shmob_drm_shutdown(struct platform_device *pdev)
+{
+	struct shmob_drm_device *sdev = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(&sdev->ddev);
+}
+
 static int shmob_drm_probe(struct platform_device *pdev)
 {
 	struct shmob_drm_platform_data *pdata = pdev->dev.platform_data;
@@ -273,6 +280,7 @@ static const struct of_device_id shmob_drm_of_table[] __maybe_unused = {
 static struct platform_driver shmob_drm_platform_driver = {
 	.probe		= shmob_drm_probe,
 	.remove_new	= shmob_drm_remove,
+	.shutdown	= shmob_drm_shutdown,
 	.driver		= {
 		.name	= "shmob-drm",
 		.of_match_table = of_match_ptr(shmob_drm_of_table),
diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index faddae3d6ac2..6f1ac940cbae 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select MAPPING_DIRTY_HELPERS
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7dd83ec74f8a..5302bfd527d8 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -974,6 +974,8 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_CAMERA_ACCESS_ENABLE] = "CameraAccessEnable",
 	[KEY_CAMERA_ACCESS_DISABLE] = "CameraAccessDisable",
 	[KEY_CAMERA_ACCESS_TOGGLE] = "CameraAccessToggle",
+	[KEY_ACCESSIBILITY] = "Accessibility",
+	[KEY_DO_NOT_DISTURB] = "DoNotDisturb",
 	[KEY_DICTATE] = "Dictate",
 	[KEY_MICMUTE] = "MicrophoneMute",
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 68b0f39deaa9..8eb073dea359 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -421,6 +421,8 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
 #define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8
 #define I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN 0x2C82
+#define I2C_DEVICE_ID_ASUS_UX3402_TOUCHSCREEN 0x2F2C
+#define I2C_DEVICE_ID_ASUS_UX6404_TOUCHSCREEN 0x4116
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index e03d300d2bac..c9094a4f281e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -377,6 +377,10 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_UX3402_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_UX6404_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
@@ -833,9 +837,18 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 		}
 
+		if ((usage->hid & 0xf0) == 0x90) { /* SystemControl*/
+			switch (usage->hid & 0xf) {
+			case 0xb: map_key_clear(KEY_DO_NOT_DISTURB); break;
+			default: goto ignore;
+			}
+			break;
+		}
+
 		if ((usage->hid & 0xf0) == 0xa0) {	/* SystemControl */
 			switch (usage->hid & 0xf) {
 			case 0x9: map_key_clear(KEY_MICMUTE); break;
+			case 0xa: map_key_clear(KEY_ACCESSIBILITY); break;
 			default: goto ignore;
 			}
 			break;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6fadaddb2b90..3a5af0909233 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -209,6 +209,7 @@ static const struct xpad_device {
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
 	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", 0, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 4e38229404b4..b4723ea395eb 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1476,16 +1476,47 @@ static void elantech_disconnect(struct psmouse *psmouse)
 	psmouse->private = NULL;
 }
 
+/*
+ * Some hw_version 4 models fail to properly activate absolute mode on
+ * resume without going through disable/enable cycle.
+ */
+static const struct dmi_system_id elantech_needs_reenable[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Lenovo N24 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "81AF"),
+		},
+	},
+#endif
+	{ }
+};
+
 /*
  * Put the touchpad back into absolute mode when reconnecting
  */
 static int elantech_reconnect(struct psmouse *psmouse)
 {
+	int err;
+
 	psmouse_reset(psmouse);
 
 	if (elantech_detect(psmouse, 0))
 		return -1;
 
+	if (dmi_check_system(elantech_needs_reenable)) {
+		err = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE);
+		if (err)
+			psmouse_warn(psmouse, "failed to deactivate mouse on %s: %d\n",
+				     psmouse->ps2dev.serio->phys, err);
+
+		err = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+		if (err)
+			psmouse_warn(psmouse, "failed to reactivate mouse on %s: %d\n",
+				     psmouse->ps2dev.serio->phys, err);
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad back into absolute mode.\n");
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index dfc6c581873b..5b50475ec414 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -76,7 +76,7 @@ static inline void i8042_write_command(int val)
 #define SERIO_QUIRK_PROBE_DEFER		BIT(5)
 #define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
 #define SERIO_QUIRK_RESET_NEVER		BIT(7)
-#define SERIO_QUIRK_DIECT		BIT(8)
+#define SERIO_QUIRK_DIRECT		BIT(8)
 #define SERIO_QUIRK_DUMBKBD		BIT(9)
 #define SERIO_QUIRK_NOLOOP		BIT(10)
 #define SERIO_QUIRK_NOTIMEOUT		BIT(11)
@@ -1332,6 +1332,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * The Ayaneo Kun is a handheld device where some the buttons
+		 * are handled by an AT keyboard. The keyboard is usually
+		 * detected as raw, but sometimes, usually after a cold boot,
+		 * it is detected as translated. Make sure that the keyboard
+		 * is always in raw mode.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DIRECT)
+	},
 	{ }
 };
 
@@ -1655,7 +1669,7 @@ static void __init i8042_check_quirks(void)
 		if (quirks & SERIO_QUIRK_RESET_NEVER)
 			i8042_reset = I8042_RESET_NEVER;
 	}
-	if (quirks & SERIO_QUIRK_DIECT)
+	if (quirks & SERIO_QUIRK_DIRECT)
 		i8042_direct = true;
 	if (quirks & SERIO_QUIRK_DUMBKBD)
 		i8042_dumbkbd = true;
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index d2bbb436a77d..4d13db13b9e5 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1111,6 +1111,16 @@ static const struct of_device_id ads7846_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, ads7846_dt_ids);
 
+static const struct spi_device_id ads7846_spi_ids[] = {
+	{ "tsc2046", 7846 },
+	{ "ads7843", 7843 },
+	{ "ads7845", 7845 },
+	{ "ads7846", 7846 },
+	{ "ads7873", 7873 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, ads7846_spi_ids);
+
 static const struct ads7846_platform_data *ads7846_get_props(struct device *dev)
 {
 	struct ads7846_platform_data *pdata;
@@ -1386,10 +1396,10 @@ static struct spi_driver ads7846_driver = {
 	},
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
+	.id_table	= ads7846_spi_ids,
 };
 
 module_spi_driver(ads7846_driver);
 
 MODULE_DESCRIPTION("ADS7846 TouchScreen Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:ads7846");
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 62f562ad5026..050fa9ca4ec9 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -71,7 +71,6 @@ struct silead_ts_data {
 	struct regulator_bulk_data regulators[2];
 	char fw_name[64];
 	struct touchscreen_properties prop;
-	u32 max_fingers;
 	u32 chip_id;
 	struct input_mt_pos pos[SILEAD_MAX_FINGERS];
 	int slots[SILEAD_MAX_FINGERS];
@@ -136,7 +135,7 @@ static int silead_ts_request_input_dev(struct silead_ts_data *data)
 	touchscreen_parse_properties(data->input, true, &data->prop);
 	silead_apply_efi_fw_min_max(data);
 
-	input_mt_init_slots(data->input, data->max_fingers,
+	input_mt_init_slots(data->input, SILEAD_MAX_FINGERS,
 			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED |
 			    INPUT_MT_TRACK);
 
@@ -256,10 +255,10 @@ static void silead_ts_read_data(struct i2c_client *client)
 		return;
 	}
 
-	if (buf[0] > data->max_fingers) {
+	if (buf[0] > SILEAD_MAX_FINGERS) {
 		dev_warn(dev, "More touches reported then supported %d > %d\n",
-			 buf[0], data->max_fingers);
-		buf[0] = data->max_fingers;
+			 buf[0], SILEAD_MAX_FINGERS);
+		buf[0] = SILEAD_MAX_FINGERS;
 	}
 
 	if (silead_ts_handle_pen_data(data, buf))
@@ -315,7 +314,6 @@ static void silead_ts_read_data(struct i2c_client *client)
 
 static int silead_ts_init(struct i2c_client *client)
 {
-	struct silead_ts_data *data = i2c_get_clientdata(client);
 	int error;
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET,
@@ -325,7 +323,7 @@ static int silead_ts_init(struct i2c_client *client)
 	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_TOUCH_NR,
-					data->max_fingers);
+					  SILEAD_MAX_FINGERS);
 	if (error)
 		goto i2c_write_err;
 	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
@@ -591,13 +589,6 @@ static void silead_ts_read_props(struct i2c_client *client)
 	const char *str;
 	int error;
 
-	error = device_property_read_u32(dev, "silead,max-fingers",
-					 &data->max_fingers);
-	if (error) {
-		dev_dbg(dev, "Max fingers read error %d\n", error);
-		data->max_fingers = 5; /* Most devices handle up-to 5 fingers */
-	}
-
 	error = device_property_read_string(dev, "firmware-name", &str);
 	if (!error)
 		snprintf(data->fw_name, sizeof(data->fw_name),
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 79e6f3c1341f..40c3fe26f76d 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -329,7 +329,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index ffc3e9329250..024169461cad 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -295,7 +295,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 722bb724361c..664baedfe7d1 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2478,6 +2478,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
 
 	tx_buff = &tx_pool->tx_buff[bufidx];
+
+	/* Sanity checks on our free map to make sure it points to an index
+	 * that is not being occupied by another skb. If skb memory is
+	 * not freed then we see congestion control kick in and halt tx.
+	 */
+	if (unlikely(tx_buff->skb)) {
+		dev_warn_ratelimited(dev, "TX free map points to untracked skb (%s %d idx=%d)\n",
+				     skb_is_gso(skb) ? "tso_pool" : "tx_pool",
+				     queue_num, bufidx);
+		dev_kfree_skb_any(tx_buff->skb);
+	}
+
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index cebc79a710ec..6340e5e61a7d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6906,6 +6906,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
 	device_set_node(&dev->dev, port_fwnode);
+	dev->dev_port = port->id;
 
 	port->pcs_gmac.ops = &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_gmac.neg_mode = true;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a85ac039d779..87d5776e3b88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -648,14 +648,14 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL4) {
 		parent = schq_list[NIX_TXSCH_LVL_TL3][prio];
 		req->reg[0] = NIX_AF_TL4X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL4X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
 	} else if (lvl == NIX_TXSCH_LVL_TL3) {
 		parent = schq_list[NIX_TXSCH_LVL_TL2][prio];
 		req->reg[0] = NIX_AF_TL3X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL3X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
@@ -670,11 +670,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL2) {
 		parent = schq_list[NIX_TXSCH_LVL_TL1][prio];
 		req->reg[0] = NIX_AF_TL2X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
-		req->regval[1] = TXSCH_TL1_DFLT_RR_PRIO << 24 | dwrr_val;
+		req->regval[1] = (u64)hw->txschq_aggr_lvl_rr_prio << 24 | dwrr_val;
 
 		if (lvl == hw->txschq_link_cfg_lvl) {
 			req->num_regs++;
@@ -698,7 +698,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
-		req->regval[1] = (TXSCH_TL1_DFLT_RR_PRIO << 1);
+		req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 1;
 
 		req->num_regs++;
 		req->reg[2] = NIX_AF_TL1X_CIR(schq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 45a32e4b49d1..e3aee6e36215 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -139,33 +139,34 @@
 #define	NIX_LF_CINTX_ENA_W1C(a)		(NIX_LFBASE | 0xD50 | (a) << 12)
 
 /* NIX AF transmit scheduler registers */
-#define NIX_AF_SMQX_CFG(a)		(0x700 | (a) << 16)
-#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (a) << 16)
-#define NIX_AF_TL1X_CIR(a)		(0xC20 | (a) << 16)
-#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (a) << 16)
-#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (a) << 16)
-#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (a) << 16)
-#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (a) << 16)
-#define NIX_AF_TL2X_CIR(a)              (0xE20 | (a) << 16)
-#define NIX_AF_TL2X_PIR(a)              (0xE30 | (a) << 16)
-#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (a) << 16)
-#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (a) << 16)
-#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (a) << 16)
-#define NIX_AF_TL3X_CIR(a)		(0x1020 | (a) << 16)
-#define NIX_AF_TL3X_PIR(a)		(0x1030 | (a) << 16)
-#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (a) << 16)
-#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (a) << 16)
-#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (a) << 16)
-#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (a) << 16)
-#define NIX_AF_TL4X_CIR(a)		(0x1220 | (a) << 16)
-#define NIX_AF_TL4X_PIR(a)		(0x1230 | (a) << 16)
-#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (a) << 16)
-#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (a) << 16)
-#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (a) << 16)
-#define NIX_AF_MDQX_CIR(a)		(0x1420 | (a) << 16)
-#define NIX_AF_MDQX_PIR(a)		(0x1430 | (a) << 16)
-#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (a) << 16)
-#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (a) << 16 | (b) << 3)
+#define NIX_AF_SMQX_CFG(a)		(0x700 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SDP_LINK_CFG(a)	(0xB10 | (u64)(a) << 16)
+#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (u64)(a) << 16)
+#define NIX_AF_TL1X_CIR(a)		(0xC20 | (u64)(a) << 16)
+#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (u64)(a) << 16)
+#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (u64)(a) << 16)
+#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_CIR(a)		(0xE20 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PIR(a)		(0xE30 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (u64)(a) << 16)
+#define NIX_AF_TL3X_CIR(a)		(0x1020 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PIR(a)		(0x1030 | (u64)(a) << 16)
+#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (u64)(a) << 16)
+#define NIX_AF_TL4X_CIR(a)		(0x1220 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PIR(a)		(0x1230 | (u64)(a) << 16)
+#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (u64)(a) << 16)
+#define NIX_AF_MDQX_CIR(a)		(0x1420 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PIR(a)		(0x1430 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (u64)(a) << 16)
+#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (u64)(a) << 16 | (b) << 3)
 
 /* LMT LF registers */
 #define LMT_LFBASE			BIT_ULL(RVU_FUNC_BLKADDR_SHIFT)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 04a49b9b545f..0ca9f2ffd932 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -510,7 +510,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_poll *cq_poll)
 {
-	struct dim_sample dim_sample;
+	struct dim_sample dim_sample = { 0 };
 	u64 rx_frames, rx_bytes;
 	u64 tx_frames, tx_bytes;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 6cddb4da85b7..4995a2d54d7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -153,7 +153,6 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		num_regs++;
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
-
 	} else if (level == NIX_TXSCH_LVL_TL4) {
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL3) {
@@ -176,7 +175,7 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		/* check if node is root */
 		if (node->qid == OTX2_QOS_QID_INNER && !node->parent) {
 			cfg->reg[num_regs] = NIX_AF_TL2X_SCHEDULE(node->schq);
-			cfg->regval[num_regs] =  TXSCH_TL1_DFLT_RR_PRIO << 24 |
+			cfg->regval[num_regs] =  (u64)hw->txschq_aggr_lvl_rr_prio << 24 |
 						 mtu_to_dwrr_weight(pfvf,
 								    pfvf->tx_max_pktlen);
 			num_regs++;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index a5469cf5cf67..befbca01bfe3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1380,6 +1380,8 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3000, 0)},	/* Telit FN912 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3001, 0)},	/* Telit FN912 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 52518a47554e..6f16b5b33f0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -595,6 +595,12 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 					 void *_data)
 {
 	struct wowlan_key_gtk_type_iter *data = _data;
+	__le32 *cipher = NULL;
+
+	if (key->keyidx == 4 || key->keyidx == 5)
+		cipher = &data->kek_kck_cmd->igtk_cipher;
+	if (key->keyidx == 6 || key->keyidx == 7)
+		cipher = &data->kek_kck_cmd->bigtk_cipher;
 
 	switch (key->cipher) {
 	default:
@@ -606,10 +612,13 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 		return;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
 		return;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_CCM);
 		return;
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (!sta)
@@ -2182,7 +2191,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 out:
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-				    WOWLAN_GET_STATUSES, 0) < 10) {
+				    WOWLAN_GET_STATUSES,
+				    IWL_FW_CMD_VER_UNKNOWN) < 10) {
 		mvmvif->seqno_valid = true;
 		/* +0x10 because the set API expects next-to-use, not last-used */
 		mvmvif->seqno = status->non_qos_seq_ctr + 0x10;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5f6b16d3fc8a..81bc0878a61c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -651,7 +651,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_KEK_KCK_MATERIAL,
-				  IWL_FW_CMD_VER_UNKNOWN) == 3)
+				  IWL_FW_CMD_VER_UNKNOWN) >= 3)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
@@ -1115,6 +1115,39 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 }
 
+static void iwl_mvm_cleanup_sta_iterator(void *data, struct ieee80211_sta *sta)
+{
+	struct iwl_mvm *mvm = data;
+	struct iwl_mvm_sta *mvm_sta;
+	struct ieee80211_vif *vif;
+	int link_id;
+
+	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	vif = mvm_sta->vif;
+
+	if (!sta->valid_links)
+		return;
+
+	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++) {
+		struct iwl_mvm_link_sta *mvm_link_sta;
+
+		mvm_link_sta =
+			rcu_dereference_check(mvm_sta->link[link_id],
+					      lockdep_is_held(&mvm->mutex));
+		if (mvm_link_sta && !(vif->active_links & BIT(link_id))) {
+			/*
+			 * We have a link STA but the link is inactive in
+			 * mac80211. This will happen if we failed to
+			 * deactivate the link but mac80211 roll back the
+			 * deactivation of the link.
+			 * Delete the stale data to avoid issues later on.
+			 */
+			iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
+						  link_id, false);
+		}
+	}
+}
+
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 {
 	iwl_mvm_stop_device(mvm);
@@ -1137,6 +1170,10 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	 */
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
+	/* cleanup stations as links may be gone after restart */
+	ieee80211_iterate_stations_atomic(mvm->hw,
+					  iwl_mvm_cleanup_sta_iterator, mvm);
+
 	mvm->p2p_device_vif = NULL;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
@@ -6127,7 +6164,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		.len[0] = sizeof(cmd),
 		.data[1] = data,
 		.len[1] = size,
-		.flags = sync ? 0 : CMD_ASYNC,
+		.flags = CMD_SEND_IN_RFKILL | (sync ? 0 : CMD_ASYNC),
 	};
 	int ret;
 
@@ -6152,11 +6189,9 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	if (sync) {
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
-					 READ_ONCE(mvm->queue_sync_state) == 0 ||
-					 iwl_mvm_is_radio_hw_killed(mvm),
+					 READ_ONCE(mvm->queue_sync_state) == 0,
 					 SYNC_RX_QUEUE_TIMEOUT);
-		WARN_ONCE(!ret && !iwl_mvm_is_radio_hw_killed(mvm),
-			  "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
+		WARN_ONCE(!ret, "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
 			  mvm->queue_sync_state,
 			  mvm->queue_sync_cookie);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 36dc291d98dd..dbe668db7ce3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -515,11 +515,11 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
 }
 
-static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
-				      struct iwl_mvm_sta *mvm_sta,
-				      struct iwl_mvm_link_sta *mvm_sta_link,
-				      unsigned int link_id,
-				      bool is_in_fw)
+void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+			       struct iwl_mvm_sta *mvm_sta,
+			       struct iwl_mvm_link_sta *mvm_sta_link,
+			       unsigned int link_id,
+			       bool is_in_fw)
 {
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
 			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
@@ -1012,7 +1012,8 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 
 		cmd.modify.tid = cpu_to_le32(data->tid);
 
-		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_SEND_IN_RFKILL,
+					   sizeof(cmd), &cmd);
 		data->sta_mask = new_sta_mask;
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index a93981cb9714..7f5685a4838c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1854,12 +1854,10 @@ static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 	bool rfkill_safe_init_done = READ_ONCE(mvm->rfkill_safe_init_done);
 	bool unified = iwl_mvm_has_unified_ucode(mvm);
 
-	if (state) {
+	if (state)
 		set_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
-		wake_up(&mvm->rx_sync_waitq);
-	} else {
+	else
 		clear_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
-	}
 
 	iwl_mvm_set_rfkill_state(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 525d8efcc147..aa5fa6c657c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1717,7 +1717,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 				break;
 		}
 
-		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE) {
+		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE &&
+		    !WARN_ONCE(!is_valid_ether_addr(scan_6ghz_params[j].bssid),
+			       "scan: invalid BSSID at index %u, index_b=%u\n",
+			       j, idex_b)) {
 			memcpy(&pp->bssid_array[idex_b++],
 			       scan_6ghz_params[j].bssid, ETH_ALEN);
 		}
@@ -3251,10 +3254,11 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   0, sizeof(cmd), &cmd);
+				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 491c449fd431..908d0bc474da 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2836,7 +2836,12 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		.action = start ? cpu_to_le32(IWL_RX_BAID_ACTION_ADD) :
 				  cpu_to_le32(IWL_RX_BAID_ACTION_REMOVE),
 	};
-	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD),
+		.flags = CMD_SEND_IN_RFKILL,
+		.len[0] = sizeof(cmd),
+		.data[0] = &cmd,
+	};
 	int ret;
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
@@ -2848,7 +2853,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
 		baid = -EIO;
-	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1) == 1) {
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, hcmd.id, 1) == 1) {
 		cmd.remove_v1.baid = cpu_to_le32(baid);
 		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
@@ -2857,8 +2862,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
-	ret = iwl_mvm_send_cmd_pdu_status(mvm, cmd_id, sizeof(cmd),
-					  &cmd, &baid);
+	ret = iwl_mvm_send_cmd_status(mvm, &hcmd, &baid);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index b3450569864e..7dd8f7f4b449 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -638,6 +638,11 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+			       struct iwl_mvm_sta *mvm_sta,
+			       struct iwl_mvm_link_sta *mvm_sta_link,
+			       unsigned int link_id,
+			       bool is_in_fw);
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id);
 int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d513fd27589d..36f30594b671 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..f6416f8553f0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d7bcc6d51e84..3f2b0d41e481 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,7 +503,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 06f0c587f343..4ff460ba2826 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -957,6 +957,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..ee76491e8b12 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -332,7 +332,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		pr_debug("%s: ctrl %d qid %d nvme status %x error loc %d\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
-	req->cqe->result.u64 = 0;
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
@@ -515,8 +514,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	req->cqe->result.u64 = 0;
-
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index b23f4cf840bd..f6714453b8bb 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -226,9 +226,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -304,9 +301,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18..c94203ce65bb 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -25,6 +25,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 
+#include "of_private.h"
+
 /**
  * irq_of_parse_and_map - Parse and map an interrupt into linux virq space
  * @dev: Device node of the device whose interrupt is to be mapped
@@ -79,7 +81,8 @@ EXPORT_SYMBOL_GPL(of_irq_find_parent);
 /*
  * These interrupt controllers abuse interrupt-map for unspeakable
  * reasons and rely on the core code to *ignore* it (the drivers do
- * their own parsing of the property).
+ * their own parsing of the property). The PAsemi entry covers a
+ * non-sensical interrupt-map that is better left ignored.
  *
  * If you think of adding to the list for something *new*, think
  * again. There is a high chance that you will be sent back to the
@@ -93,9 +96,61 @@ static const char * const of_irq_imap_abusers[] = {
 	"fsl,ls1043a-extirq",
 	"fsl,ls1088a-extirq",
 	"renesas,rza1-irqc",
+	"pasemi,rootbus",
 	NULL,
 };
 
+const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_phandle_args *out_irq)
+{
+	u32 intsize, addrsize;
+	struct device_node *np;
+
+	/* Get the interrupt parent */
+	if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
+		np = of_node_get(of_irq_dflt_pic);
+	else
+		np = of_find_node_by_phandle(be32_to_cpup(imap));
+	imap++;
+
+	/* Check if not found */
+	if (!np) {
+		pr_debug(" -> imap parent not found !\n");
+		return NULL;
+	}
+
+	/* Get #interrupt-cells and #address-cells of new parent */
+	if (of_property_read_u32(np, "#interrupt-cells",
+					&intsize)) {
+		pr_debug(" -> parent lacks #interrupt-cells!\n");
+		of_node_put(np);
+		return NULL;
+	}
+	if (of_property_read_u32(np, "#address-cells",
+					&addrsize))
+		addrsize = 0;
+
+	pr_debug(" -> intsize=%d, addrsize=%d\n",
+		intsize, addrsize);
+
+	/* Check for malformed properties */
+	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS)
+		|| (len < (addrsize + intsize))) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	pr_debug(" -> imaplen=%d\n", len);
+
+	imap += addrsize + intsize;
+
+	out_irq->np = np;
+	for (int i = 0; i < intsize; i++)
+		out_irq->args[i] = be32_to_cpup(imap - intsize + i);
+	out_irq->args_count = intsize;
+
+	return imap;
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
@@ -112,12 +167,12 @@ static const char * const of_irq_imap_abusers[] = {
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
+	struct device_node *ipar, *tnode, *old = NULL;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, *imap, *imask, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
-	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
-	int imaplen, match, i, rc = -EINVAL;
+	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	u32 intsize = 1, addrsize;
+	int i, rc = -EINVAL;
 
 #ifdef DEBUG
 	of_print_phandle_args("of_irq_parse_raw: ", out_irq);
@@ -176,6 +231,9 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
+		int imaplen, match;
+		const __be32 *imap, *oldimap, *imask;
+		struct device_node *newpar;
 		/*
 		 * Now check if cursor is an interrupt-controller and
 		 * if it is then we are done, unless there is an
@@ -216,7 +274,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		/* Parse interrupt-map */
 		match = 0;
-		while (imaplen > (addrsize + intsize + 1) && !match) {
+		while (imaplen > (addrsize + intsize + 1)) {
 			/* Compare specifiers */
 			match = 1;
 			for (i = 0; i < (addrsize + intsize); i++, imaplen--)
@@ -224,74 +282,31 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
 
-			/* Get the interrupt parent */
-			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
-				newpar = of_node_get(of_irq_dflt_pic);
-			else
-				newpar = of_find_node_by_phandle(be32_to_cpup(imap));
-			imap++;
-			--imaplen;
-
-			/* Check if not found */
-			if (newpar == NULL) {
-				pr_debug(" -> imap parent not found !\n");
+			oldimap = imap;
+			imap = of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
+			if (!imap)
 				goto fail;
-			}
-
-			if (!of_device_is_available(newpar))
-				match = 0;
-
-			/* Get #interrupt-cells and #address-cells of new
-			 * parent
-			 */
-			if (of_property_read_u32(newpar, "#interrupt-cells",
-						 &newintsize)) {
-				pr_debug(" -> parent lacks #interrupt-cells!\n");
-				goto fail;
-			}
-			if (of_property_read_u32(newpar, "#address-cells",
-						 &newaddrsize))
-				newaddrsize = 0;
 
-			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
-			    newintsize, newaddrsize);
-
-			/* Check for malformed properties */
-			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS)
-			    || (imaplen < (newaddrsize + newintsize))) {
-				rc = -EFAULT;
-				goto fail;
-			}
-
-			imap += newaddrsize + newintsize;
-			imaplen -= newaddrsize + newintsize;
+			match &= of_device_is_available(out_irq->np);
+			if (match)
+				break;
 
+			of_node_put(out_irq->np);
+			imaplen -= imap - oldimap;
 			pr_debug(" -> imaplen=%d\n", imaplen);
 		}
-		if (!match) {
-			if (intc) {
-				/*
-				 * The PASEMI Nemo is a known offender, so
-				 * let's only warn for anyone else.
-				 */
-				WARN(!IS_ENABLED(CONFIG_PPC_PASEMI),
-				     "%pOF interrupt-map failed, using interrupt-controller\n",
-				     ipar);
-				return 0;
-			}
-
+		if (!match)
 			goto fail;
-		}
 
 		/*
 		 * Successfully parsed an interrupt-map translation; copy new
 		 * interrupt specifier into the out_irq structure
 		 */
-		match_array = imap - newaddrsize - newintsize;
-		for (i = 0; i < newintsize; i++)
-			out_irq->args[i] = be32_to_cpup(imap - newintsize + i);
-		out_irq->args_count = intsize = newintsize;
-		addrsize = newaddrsize;
+		match_array = oldimap + 1;
+
+		newpar = out_irq->np;
+		intsize = out_irq->args_count;
+		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
@@ -300,7 +315,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	skiplevel:
 		/* Iterate again with new parent */
-		out_irq->np = newpar;
 		pr_debug(" -> new parent: %pOF\n", newpar);
 		of_node_put(ipar);
 		ipar = newpar;
@@ -310,7 +324,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
  fail:
 	of_node_put(ipar);
-	of_node_put(newpar);
 
 	return rc;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 485483524b7f..b0609de49c7c 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,6 +158,9 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
+const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len,
+				       struct of_phandle_args *out_irq);
+
 struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index e6dc857aac3f..e06c7b2aac5c 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -229,7 +229,13 @@ static void __exit amiga_parallel_remove(struct platform_device *pdev)
 	parport_put_port(port);
 }
 
-static struct platform_driver amiga_parallel_driver = {
+/*
+ * amiga_parallel_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_parallel_driver __refdata = {
 	.remove_new = __exit_p(amiga_parallel_remove),
 	.driver   = {
 		.name	= "amiga-parallel",
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3e44d2fb8bf8..6d3fdf3a688d 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -634,7 +634,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 3ef655591424..abe7be602f84 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1198,6 +1198,7 @@ static int nvsw_sn2201_config_pre_init(struct nvsw_sn2201 *nvsw_sn2201)
 static int nvsw_sn2201_probe(struct platform_device *pdev)
 {
 	struct nvsw_sn2201 *nvsw_sn2201;
+	int ret;
 
 	nvsw_sn2201 = devm_kzalloc(&pdev->dev, sizeof(*nvsw_sn2201), GFP_KERNEL);
 	if (!nvsw_sn2201)
@@ -1205,8 +1206,10 @@ static int nvsw_sn2201_probe(struct platform_device *pdev)
 
 	nvsw_sn2201->dev = &pdev->dev;
 	platform_set_drvdata(pdev, nvsw_sn2201);
-	platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
+	ret = platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
 				      ARRAY_SIZE(nvsw_sn2201_lpc_io_resources));
+	if (ret)
+		return ret;
 
 	nvsw_sn2201->main_mux_deferred_nr = NVSW_SN2201_MAIN_MUX_DEFER_NR;
 	nvsw_sn2201->main_mux_devs = nvsw_sn2201_main_mux_brdinfo;
diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 1927be901108..272d32a95e21 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -907,16 +907,44 @@ static int hsmp_plat_dev_register(void)
 	return ret;
 }
 
+/*
+ * This check is only needed for backward compatibility of previous platforms.
+ * All new platforms are expected to support ACPI based probing.
+ */
+static bool legacy_hsmp_support(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
+	switch (boot_cpu_data.x86) {
+	case 0x19:
+		switch (boot_cpu_data.x86_model) {
+		case 0x00 ... 0x1F:
+		case 0x30 ... 0x3F:
+		case 0x90 ... 0x9F:
+		case 0xA0 ... 0xAF:
+			return true;
+		default:
+			return false;
+		}
+	case 0x1A:
+		switch (boot_cpu_data.x86_model) {
+		case 0x00 ... 0x1F:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static int __init hsmp_plt_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD || boot_cpu_data.x86 < 0x19) {
-		pr_err("HSMP is not supported on Family:%x model:%x\n",
-		       boot_cpu_data.x86, boot_cpu_data.x86_model);
-		return ret;
-	}
-
 	/*
 	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
@@ -930,7 +958,15 @@ static int __init hsmp_plt_init(void)
 		return ret;
 
 	if (!plat_dev.is_acpi_device) {
-		ret = hsmp_plat_dev_register();
+		if (legacy_hsmp_support()) {
+			/* Not ACPI device, but supports HSMP, register a plat_dev */
+			ret = hsmp_plat_dev_register();
+		} else {
+			/* Not ACPI, Does not support HSMP */
+			pr_info("HSMP is not supported on Family:%x model:%x\n",
+				boot_cpu_data.x86, boot_cpu_data.x86_model);
+			ret = -ENODEV;
+		}
 		if (ret)
 			platform_driver_unregister(&amd_hsmp_driver);
 	}
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index e714ee6298dd..78c48a1f9c68 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -39,8 +39,6 @@ MODULE_LICENSE("GPL");
 #define WMI_METHOD_WMBB "2B4F501A-BD3C-4394-8DCF-00A7D2BC8210"
 #define WMI_EVENT_GUID  WMI_EVENT_GUID0
 
-#define WMAB_METHOD     "\\XINI.WMAB"
-#define WMBB_METHOD     "\\XINI.WMBB"
 #define SB_GGOV_METHOD  "\\_SB.GGOV"
 #define GOV_TLED        0x2020008
 #define WM_GET          1
@@ -74,7 +72,7 @@ static u32 inited;
 
 static int battery_limit_use_wmbb;
 static struct led_classdev kbd_backlight;
-static enum led_brightness get_kbd_backlight_level(void);
+static enum led_brightness get_kbd_backlight_level(struct device *dev);
 
 static const struct key_entry wmi_keymap[] = {
 	{KE_KEY, 0x70, {KEY_F15} },	 /* LG control panel (F1) */
@@ -84,7 +82,6 @@ static const struct key_entry wmi_keymap[] = {
 					  * this key both sends an event and
 					  * changes backlight level.
 					  */
-	{KE_KEY, 0x80, {KEY_RFKILL} },
 	{KE_END, 0}
 };
 
@@ -128,11 +125,10 @@ static int ggov(u32 arg0)
 	return res;
 }
 
-static union acpi_object *lg_wmab(u32 method, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmab(struct device *dev, u32 method, u32 arg1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
@@ -143,29 +139,22 @@ static union acpi_object *lg_wmab(u32 method, u32 arg1, u32 arg2)
 	args[2].type = ACPI_TYPE_INTEGER;
 	args[2].integer.value = arg2;
 
-	status = acpi_get_handle(NULL, (acpi_string) WMAB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count = 3;
 	arg.pointer = args;
 
-	status = acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "WMAB", &arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMAB: call failed.\n");
 		return NULL;
 	}
 
 	return buffer.pointer;
 }
 
-static union acpi_object *lg_wmbb(u32 method_id, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmbb(struct device *dev, u32 method_id, u32 arg1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	u8 buf[32];
@@ -181,18 +170,12 @@ static union acpi_object *lg_wmbb(u32 method_id, u32 arg1, u32 arg2)
 	args[2].buffer.length = 32;
 	args[2].buffer.pointer = buf;
 
-	status = acpi_get_handle(NULL, (acpi_string)WMBB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count = 3;
 	arg.pointer = args;
 
-	status = acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "WMBB", &arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMBB: call failed.\n");
 		return NULL;
 	}
 
@@ -223,7 +206,7 @@ static void wmi_notify(u32 value, void *context)
 
 		if (eventcode == 0x10000000) {
 			led_classdev_notify_brightness_hw_changed(
-				&kbd_backlight, get_kbd_backlight_level());
+				&kbd_backlight, get_kbd_backlight_level(kbd_backlight.dev->parent));
 		} else {
 			key = sparse_keymap_entry_from_scancode(
 				wmi_input_dev, eventcode);
@@ -272,14 +255,7 @@ static void wmi_input_setup(void)
 
 static void acpi_notify(struct acpi_device *device, u32 event)
 {
-	struct key_entry *key;
-
 	acpi_handle_debug(device->handle, "notify: %d\n", event);
-	if (inited & INIT_SPARSE_KEYMAP) {
-		key = sparse_keymap_entry_from_scancode(wmi_input_dev, 0x80);
-		if (key && key->type == KE_KEY)
-			sparse_keymap_report_entry(wmi_input_dev, key, 1, true);
-	}
 }
 
 static ssize_t fan_mode_store(struct device *dev,
@@ -295,7 +271,7 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -306,9 +282,9 @@ static ssize_t fan_mode_store(struct device *dev,
 
 	m = r->integer.value;
 	kfree(r);
-	r = lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
 	kfree(r);
-	r = lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
 	kfree(r);
 
 	return count;
@@ -320,7 +296,7 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -347,7 +323,7 @@ static ssize_t usb_charge_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmbb(WMBB_USB_CHARGE, WM_SET, value);
+	r = lg_wmbb(dev, WMBB_USB_CHARGE, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -361,7 +337,7 @@ static ssize_t usb_charge_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmbb(WMBB_USB_CHARGE, WM_GET, 0);
+	r = lg_wmbb(dev, WMBB_USB_CHARGE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -389,7 +365,7 @@ static ssize_t reader_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_READER_MODE, WM_SET, value);
+	r = lg_wmab(dev, WM_READER_MODE, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -403,7 +379,7 @@ static ssize_t reader_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_READER_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_READER_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -431,7 +407,7 @@ static ssize_t fn_lock_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_FN_LOCK, WM_SET, value);
+	r = lg_wmab(dev, WM_FN_LOCK, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -445,7 +421,7 @@ static ssize_t fn_lock_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_FN_LOCK, WM_GET, 0);
+	r = lg_wmab(dev, WM_FN_LOCK, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -475,9 +451,9 @@ static ssize_t charge_control_end_threshold_store(struct device *dev,
 		union acpi_object *r;
 
 		if (battery_limit_use_wmbb)
-			r = lg_wmbb(WMBB_BATT_LIMIT, WM_SET, value);
+			r = lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_SET, value);
 		else
-			r = lg_wmab(WM_BATT_LIMIT, WM_SET, value);
+			r = lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_SET, value);
 		if (!r)
 			return -EIO;
 
@@ -496,7 +472,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 	union acpi_object *r;
 
 	if (battery_limit_use_wmbb) {
-		r = lg_wmbb(WMBB_BATT_LIMIT, WM_GET, 0);
+		r = lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;
 
@@ -507,7 +483,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 
 		status = r->buffer.pointer[0x10];
 	} else {
-		r = lg_wmab(WM_BATT_LIMIT, WM_GET, 0);
+		r = lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;
 
@@ -586,7 +562,7 @@ static void tpad_led_set(struct led_classdev *cdev,
 {
 	union acpi_object *r;
 
-	r = lg_wmab(WM_TLED, WM_SET, brightness > LED_OFF);
+	r = lg_wmab(cdev->dev->parent, WM_TLED, WM_SET, brightness > LED_OFF);
 	kfree(r);
 }
 
@@ -608,16 +584,16 @@ static void kbd_backlight_set(struct led_classdev *cdev,
 		val = 0;
 	if (brightness >= LED_FULL)
 		val = 0x24;
-	r = lg_wmab(WM_KEY_LIGHT, WM_SET, val);
+	r = lg_wmab(cdev->dev->parent, WM_KEY_LIGHT, WM_SET, val);
 	kfree(r);
 }
 
-static enum led_brightness get_kbd_backlight_level(void)
+static enum led_brightness get_kbd_backlight_level(struct device *dev)
 {
 	union acpi_object *r;
 	int val;
 
-	r = lg_wmab(WM_KEY_LIGHT, WM_GET, 0);
+	r = lg_wmab(dev, WM_KEY_LIGHT, WM_GET, 0);
 
 	if (!r)
 		return LED_OFF;
@@ -645,7 +621,7 @@ static enum led_brightness get_kbd_backlight_level(void)
 
 static enum led_brightness kbd_backlight_get(struct led_classdev *cdev)
 {
-	return get_kbd_backlight_level();
+	return get_kbd_backlight_level(cdev->dev->parent);
 }
 
 static LED_DEVICE(kbd_backlight, 255, LED_BRIGHT_HW_CHANGED);
@@ -672,6 +648,11 @@ static struct platform_driver pf_driver = {
 
 static int acpi_add(struct acpi_device *device)
 {
+	struct platform_device_info pdev_info = {
+		.fwnode = acpi_fwnode_handle(device),
+		.name = PLATFORM_NAME,
+		.id = PLATFORM_DEVID_NONE,
+	};
 	int ret;
 	const char *product;
 	int year = 2017;
@@ -683,9 +664,7 @@ static int acpi_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	pf_device = platform_device_register_simple(PLATFORM_NAME,
-						    PLATFORM_DEVID_NONE,
-						    NULL, 0);
+	pf_device = platform_device_register_full(&pdev_info);
 	if (IS_ERR(pf_device)) {
 		ret = PTR_ERR(pf_device);
 		pf_device = NULL;
@@ -776,7 +755,7 @@ static void acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..01feb6e6787f 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -19,6 +19,7 @@ MODULE_AUTHOR("Alex Hung");
 MODULE_ALIAS("acpi*:HPQ6001:*");
 MODULE_ALIAS("acpi*:WSTADEF:*");
 MODULE_ALIAS("acpi*:AMDI0051:*");
+MODULE_ALIAS("acpi*:LGEX0815:*");
 
 struct wl_button {
 	struct input_dev *input_dev;
@@ -29,6 +30,7 @@ static const struct acpi_device_id wl_ids[] = {
 	{"HPQ6001", 0},
 	{"WSTADEF", 0},
 	{"AMDI0051", 0},
+	{"LGEX0815", 0},
 	{"", 0},
 };
 
diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index e74a0f6a3157..4e80273dfb1e 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -6,6 +6,7 @@
 
 extern struct mutex pnp_lock;
 extern const struct attribute_group *pnp_dev_groups[];
+extern const struct bus_type pnp_bus_type;
 
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d53ee34d398f..fbe29cabcbb8 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1293,6 +1293,7 @@ sclp_init(void)
 fail_unregister_reboot_notifier:
 	unregister_reboot_notifier(&sclp_reboot_notifier);
 fail_init_state_uninitialized:
+	list_del(&sclp_state_change_event.list);
 	sclp_init_state = sclp_init_state_uninitialized;
 	free_page((unsigned long) sclp_read_sccb);
 	free_page((unsigned long) sclp_init_sccb);
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index a226dc1b65d7..4eb0837298d4 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -414,28 +414,40 @@ static char print_alua_state(unsigned char state)
 	}
 }
 
-static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
-					      struct scsi_sense_hdr *sense_hdr)
+static void alua_handle_state_transition(struct scsi_device *sdev)
 {
 	struct alua_dh_data *h = sdev->handler_data;
 	struct alua_port_group *pg;
 
+	rcu_read_lock();
+	pg = rcu_dereference(h->pg);
+	if (pg)
+		pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
+	rcu_read_unlock();
+	alua_check(sdev, false);
+}
+
+static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
+{
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
 		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
 			/*
 			 * LUN Not Accessible - ALUA state transition
 			 */
-			rcu_read_lock();
-			pg = rcu_dereference(h->pg);
-			if (pg)
-				pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
-			rcu_read_unlock();
-			alua_check(sdev, false);
+			alua_handle_state_transition(sdev);
 			return NEEDS_RETRY;
 		}
 		break;
 	case UNIT_ATTENTION:
+		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
+			/*
+			 * LUN Not Accessible - ALUA state transition
+			 */
+			alua_handle_state_transition(sdev);
+			return NEEDS_RETRY;
+		}
 		if (sense_hdr->asc == 0x29 && sense_hdr->ascq == 0x00) {
 			/*
 			 * Power On, Reset, or Bus Device Reset.
@@ -502,7 +514,8 @@ static int alua_tur(struct scsi_device *sdev)
 
 	retval = scsi_test_unit_ready(sdev, ALUA_FAILOVER_TIMEOUT * HZ,
 				      ALUA_FAILOVER_RETRIES, &sense_hdr);
-	if (sense_hdr.sense_key == NOT_READY &&
+	if ((sense_hdr.sense_key == NOT_READY ||
+	     sense_hdr.sense_key == UNIT_ATTENTION) &&
 	    sense_hdr.asc == 0x04 && sense_hdr.ascq == 0x0a)
 		return SCSI_DH_RETRY;
 	else if (retval)
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 3804aef165ad..164086c5824e 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -145,6 +145,20 @@ static inline void sas_fail_probe(struct domain_device *dev, const char *func, i
 		func, dev->parent ? "exp-attached" :
 		"direct-attached",
 		SAS_ADDR(dev->sas_addr), err);
+
+	/*
+	 * If the device probe failed, the expander phy attached address
+	 * needs to be reset so that the phy will not be treated as flutter
+	 * in the next revalidation
+	 */
+	if (dev->parent && !dev_is_expander(dev->dev_type)) {
+		struct sas_phy *phy = dev->phy;
+		struct domain_device *parent = dev->parent;
+		struct ex_phy *ex_phy = &parent->ex_dev.ex_phy[phy->number];
+
+		memset(ex_phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
+	}
+
 	sas_unregister_dev(dev->port, dev);
 }
 
diff --git a/drivers/scsi/qedf/qedf.h b/drivers/scsi/qedf/qedf.h
index 5058e01b65a2..98afdfe63600 100644
--- a/drivers/scsi/qedf/qedf.h
+++ b/drivers/scsi/qedf/qedf.h
@@ -363,6 +363,7 @@ struct qedf_ctx {
 #define QEDF_IN_RECOVERY		5
 #define QEDF_DBG_STOP_IO		6
 #define QEDF_PROBING			8
+#define QEDF_STAG_IN_PROGRESS		9
 	unsigned long flags; /* Miscellaneous state flags */
 	int fipvlan_retries;
 	u8 num_queues;
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index a58353b7b4e8..b97a8712d3f6 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -318,11 +318,18 @@ static struct fc_seq *qedf_elsct_send(struct fc_lport *lport, u32 did,
 	 */
 	if (resp == fc_lport_flogi_resp) {
 		qedf->flogi_cnt++;
+		qedf->flogi_pending++;
+
+		if (test_bit(QEDF_UNLOADING, &qedf->flags)) {
+			QEDF_ERR(&qedf->dbg_ctx, "Driver unloading\n");
+			qedf->flogi_pending = 0;
+		}
+
 		if (qedf->flogi_pending >= QEDF_FLOGI_RETRY_CNT) {
 			schedule_delayed_work(&qedf->stag_work, 2);
 			return NULL;
 		}
-		qedf->flogi_pending++;
+
 		return fc_elsct_send(lport, did, fp, op, qedf_flogi_resp,
 		    arg, timeout);
 	}
@@ -912,13 +919,14 @@ void qedf_ctx_soft_reset(struct fc_lport *lport)
 	struct qedf_ctx *qedf;
 	struct qed_link_output if_link;
 
+	qedf = lport_priv(lport);
+
 	if (lport->vport) {
+		clear_bit(QEDF_STAG_IN_PROGRESS, &qedf->flags);
 		printk_ratelimited("Cannot issue host reset on NPIV port.\n");
 		return;
 	}
 
-	qedf = lport_priv(lport);
-
 	qedf->flogi_pending = 0;
 	/* For host reset, essentially do a soft link up/down */
 	atomic_set(&qedf->link_state, QEDF_LINK_DOWN);
@@ -938,6 +946,7 @@ void qedf_ctx_soft_reset(struct fc_lport *lport)
 	if (!if_link.link_up) {
 		QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_DISC,
 			  "Physical link is not up.\n");
+		clear_bit(QEDF_STAG_IN_PROGRESS, &qedf->flags);
 		return;
 	}
 	/* Flush and wait to make sure link down is processed */
@@ -950,6 +959,7 @@ void qedf_ctx_soft_reset(struct fc_lport *lport)
 		  "Queue link up work.\n");
 	queue_delayed_work(qedf->link_update_wq, &qedf->link_update,
 	    0);
+	clear_bit(QEDF_STAG_IN_PROGRESS, &qedf->flags);
 }
 
 /* Reset the host by gracefully logging out and then logging back in */
@@ -3463,6 +3473,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	}
 
 	/* Start the Slowpath-process */
+	memset(&slowpath_params, 0, sizeof(struct qed_slowpath_params));
 	slowpath_params.int_mode = QED_INT_MODE_MSIX;
 	slowpath_params.drv_major = QEDF_DRIVER_MAJOR_VER;
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
@@ -3721,6 +3732,7 @@ static void __qedf_remove(struct pci_dev *pdev, int mode)
 {
 	struct qedf_ctx *qedf;
 	int rc;
+	int cnt = 0;
 
 	if (!pdev) {
 		QEDF_ERR(NULL, "pdev is NULL.\n");
@@ -3738,6 +3750,17 @@ static void __qedf_remove(struct pci_dev *pdev, int mode)
 		return;
 	}
 
+stag_in_prog:
+	if (test_bit(QEDF_STAG_IN_PROGRESS, &qedf->flags)) {
+		QEDF_ERR(&qedf->dbg_ctx, "Stag in progress, cnt=%d.\n", cnt);
+		cnt++;
+
+		if (cnt < 5) {
+			msleep(500);
+			goto stag_in_prog;
+		}
+	}
+
 	if (mode != QEDF_MODE_RECOVERY)
 		set_bit(QEDF_UNLOADING, &qedf->flags);
 
@@ -3997,6 +4020,24 @@ void qedf_stag_change_work(struct work_struct *work)
 	struct qedf_ctx *qedf =
 	    container_of(work, struct qedf_ctx, stag_work.work);
 
+	if (!qedf) {
+		QEDF_ERR(&qedf->dbg_ctx, "qedf is NULL");
+		return;
+	}
+
+	if (test_bit(QEDF_IN_RECOVERY, &qedf->flags)) {
+		QEDF_ERR(&qedf->dbg_ctx,
+			 "Already is in recovery, hence not calling software context reset.\n");
+		return;
+	}
+
+	if (test_bit(QEDF_UNLOADING, &qedf->flags)) {
+		QEDF_ERR(&qedf->dbg_ctx, "Driver unloading\n");
+		return;
+	}
+
+	set_bit(QEDF_STAG_IN_PROGRESS, &qedf->flags);
+
 	printk_ratelimited("[%s]:[%s:%d]:%d: Performing software context reset.",
 			dev_name(&qedf->pdev->dev), __func__, __LINE__,
 			qedf->dbg_ctx.host_no);
diff --git a/drivers/scsi/sr.h b/drivers/scsi/sr.h
index 1175f2e213b5..dc899277b3a4 100644
--- a/drivers/scsi/sr.h
+++ b/drivers/scsi/sr.h
@@ -65,7 +65,7 @@ int sr_disk_status(struct cdrom_device_info *);
 int sr_get_last_session(struct cdrom_device_info *, struct cdrom_multisession *);
 int sr_get_mcn(struct cdrom_device_info *, struct cdrom_mcn *);
 int sr_reset(struct cdrom_device_info *);
-int sr_select_speed(struct cdrom_device_info *cdi, int speed);
+int sr_select_speed(struct cdrom_device_info *cdi, unsigned long speed);
 int sr_audio_ioctl(struct cdrom_device_info *, unsigned int, void *);
 
 int sr_is_xa(Scsi_CD *);
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 5b0b35e60e61..a0d2556a27bb 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -425,11 +425,14 @@ int sr_reset(struct cdrom_device_info *cdi)
 	return 0;
 }
 
-int sr_select_speed(struct cdrom_device_info *cdi, int speed)
+int sr_select_speed(struct cdrom_device_info *cdi, unsigned long speed)
 {
 	Scsi_CD *cd = cdi->handle;
 	struct packet_command cgc;
 
+	/* avoid exceeding the max speed or overflowing integer bounds */
+	speed = clamp(0, speed, 0xffff / 177);
+
 	if (speed == 0)
 		speed = 0xffff;	/* set to max */
 	else
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index be3998104bfb..f7e8b5efa50e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -984,6 +984,9 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	return ret;
 
 free_dma:
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
@@ -1013,6 +1016,9 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 09b6c1b45f1a..09c676e50fe0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1050,7 +1050,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
 	.fifo_size = 8,
-	.has_dmamode = true,
+	.has_dmamode = false,
 	.dynamic_burst = false,
 	.has_targetmode = false,
 	.devtype = IMX35_CSPI,
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 031b5795d106..a8bb07b38ec6 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -156,6 +156,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	/* supported modes are the same as our parent's */
 	ctlr->mode_bits = spi->controller->mode_bits;
 	ctlr->flags = spi->controller->flags;
+	ctlr->bits_per_word_mask = spi->controller->bits_per_word_mask;
 	ctlr->transfer_one_message = spi_mux_transfer_one_message;
 	ctlr->setup = spi_mux_setup;
 	ctlr->num_chipselect = mux_control_states(priv->mux);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9304fd03bf76..fcc39523d685 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4152,7 +4152,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
-				xfer->tx_nbits != SPI_NBITS_QUAD)
+				xfer->tx_nbits != SPI_NBITS_QUAD &&
+				xfer->tx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
 				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
@@ -4167,7 +4168,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
 				xfer->rx_nbits != SPI_NBITS_DUAL &&
-				xfer->rx_nbits != SPI_NBITS_QUAD)
+				xfer->rx_nbits != SPI_NBITS_QUAD &&
+				xfer->rx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
 				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..c5a3e25c55da 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -660,7 +660,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
-	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION };
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_GET_API_VERSION,
+	};
 	int rc;
 
 	msg_ops->mode_32bit_set(ffa_dev);
@@ -677,7 +679,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	data = (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
+	data = (struct ffa_send_direct_data){
+		.data0 = OPTEE_FFA_GET_OS_VERSION,
+	};
 	rc = msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
@@ -698,7 +702,9 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    unsigned int *rpc_param_count,
 				    unsigned int *max_notif_value)
 {
-	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_EXCHANGE_CAPABILITIES,
+	};
 	int rc;
 
 	rc = ops->msg_ops->sync_send_receive(ffa_dev, &data);
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f..bb1817bd4ff3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -39,6 +39,13 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 
 	filep->private_data = df;
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	return 0;
 
 err_put_registration:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429c6191..ded364588d29 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -286,6 +286,13 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	 */
 	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
 			 "(%s:%d)\n", current->comm, task_pid_nr(current));
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ea36d2139590..680b15ca4fce 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1607,100 +1607,20 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-/* Return 1 on zap and vma_lock acquired, 0 on contention (only with @try) */
-static int vfio_pci_zap_and_vma_lock(struct vfio_pci_core_device *vdev, bool try)
+static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_mmap_vma *mmap_vma, *tmp;
+	struct vfio_device *core_vdev = &vdev->vdev;
+	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
+	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
+	loff_t len = end - start;
 
-	/*
-	 * Lock ordering:
-	 * vma_lock is nested under mmap_lock for vm_ops callback paths.
-	 * The memory_lock semaphore is used by both code paths calling
-	 * into this function to zap vmas and the vm_ops.fault callback
-	 * to protect the memory enable state of the device.
-	 *
-	 * When zapping vmas we need to maintain the mmap_lock => vma_lock
-	 * ordering, which requires using vma_lock to walk vma_list to
-	 * acquire an mm, then dropping vma_lock to get the mmap_lock and
-	 * reacquiring vma_lock.  This logic is derived from similar
-	 * requirements in uverbs_user_mmap_disassociate().
-	 *
-	 * mmap_lock must always be the top-level lock when it is taken.
-	 * Therefore we can only hold the memory_lock write lock when
-	 * vma_list is empty, as we'd need to take mmap_lock to clear
-	 * entries.  vma_list can only be guaranteed empty when holding
-	 * vma_lock, thus memory_lock is nested under vma_lock.
-	 *
-	 * This enables the vm_ops.fault callback to acquire vma_lock,
-	 * followed by memory_lock read lock, while already holding
-	 * mmap_lock without risk of deadlock.
-	 */
-	while (1) {
-		struct mm_struct *mm = NULL;
-
-		if (try) {
-			if (!mutex_trylock(&vdev->vma_lock))
-				return 0;
-		} else {
-			mutex_lock(&vdev->vma_lock);
-		}
-		while (!list_empty(&vdev->vma_list)) {
-			mmap_vma = list_first_entry(&vdev->vma_list,
-						    struct vfio_pci_mmap_vma,
-						    vma_next);
-			mm = mmap_vma->vma->vm_mm;
-			if (mmget_not_zero(mm))
-				break;
-
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-			mm = NULL;
-		}
-		if (!mm)
-			return 1;
-		mutex_unlock(&vdev->vma_lock);
-
-		if (try) {
-			if (!mmap_read_trylock(mm)) {
-				mmput(mm);
-				return 0;
-			}
-		} else {
-			mmap_read_lock(mm);
-		}
-		if (try) {
-			if (!mutex_trylock(&vdev->vma_lock)) {
-				mmap_read_unlock(mm);
-				mmput(mm);
-				return 0;
-			}
-		} else {
-			mutex_lock(&vdev->vma_lock);
-		}
-		list_for_each_entry_safe(mmap_vma, tmp,
-					 &vdev->vma_list, vma_next) {
-			struct vm_area_struct *vma = mmap_vma->vma;
-
-			if (vma->vm_mm != mm)
-				continue;
-
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-
-			zap_vma_ptes(vma, vma->vm_start,
-				     vma->vm_end - vma->vm_start);
-		}
-		mutex_unlock(&vdev->vma_lock);
-		mmap_read_unlock(mm);
-		mmput(mm);
-	}
+	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
-	vfio_pci_zap_and_vma_lock(vdev, false);
 	down_write(&vdev->memory_lock);
-	mutex_unlock(&vdev->vma_lock);
+	vfio_pci_zap_bars(vdev);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
@@ -1722,99 +1642,56 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
 	up_write(&vdev->memory_lock);
 }
 
-/* Caller holds vma_lock */
-static int __vfio_pci_add_vma(struct vfio_pci_core_device *vdev,
-			      struct vm_area_struct *vma)
-{
-	struct vfio_pci_mmap_vma *mmap_vma;
-
-	mmap_vma = kmalloc(sizeof(*mmap_vma), GFP_KERNEL_ACCOUNT);
-	if (!mmap_vma)
-		return -ENOMEM;
-
-	mmap_vma->vma = vma;
-	list_add(&mmap_vma->vma_next, &vdev->vma_list);
-
-	return 0;
-}
-
-/*
- * Zap mmaps on open so that we can fault them in on access and therefore
- * our vma_list only tracks mappings accessed since last zap.
- */
-static void vfio_pci_mmap_open(struct vm_area_struct *vma)
-{
-	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-}
-
-static void vfio_pci_mmap_close(struct vm_area_struct *vma)
+static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 {
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	struct vfio_pci_mmap_vma *mmap_vma;
+	int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	u64 pgoff;
 
-	mutex_lock(&vdev->vma_lock);
-	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
-		if (mmap_vma->vma == vma) {
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-			break;
-		}
-	}
-	mutex_unlock(&vdev->vma_lock);
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
 }
 
 static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	struct vfio_pci_mmap_vma *mmap_vma;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
+	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vma->vm_start;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+
+	pfn = vma_to_pfn(vma);
 
-	mutex_lock(&vdev->vma_lock);
 	down_read(&vdev->memory_lock);
 
-	/*
-	 * Memory region cannot be accessed if the low power feature is engaged
-	 * or memory access is disabled.
-	 */
-	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev)) {
-		ret = VM_FAULT_SIGBUS;
-		goto up_out;
-	}
+	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
+		goto out_unlock;
+
+	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+	if (ret & VM_FAULT_ERROR)
+		goto out_unlock;
 
 	/*
-	 * We populate the whole vma on fault, so we need to test whether
-	 * the vma has already been mapped, such as for concurrent faults
-	 * to the same vma.  io_remap_pfn_range() will trigger a BUG_ON if
-	 * we ask it to fill the same range again.
+	 * Pre-fault the remainder of the vma, abort further insertions and
+	 * supress error if fault is encountered during pre-fault.
 	 */
-	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
-		if (mmap_vma->vma == vma)
-			goto up_out;
-	}
-
-	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot)) {
-		ret = VM_FAULT_SIGBUS;
-		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-		goto up_out;
-	}
+	for (; addr < vma->vm_end; addr += PAGE_SIZE, pfn++) {
+		if (addr == vmf->address)
+			continue;
 
-	if (__vfio_pci_add_vma(vdev, vma)) {
-		ret = VM_FAULT_OOM;
-		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+		if (vmf_insert_pfn(vma, addr, pfn) & VM_FAULT_ERROR)
+			break;
 	}
 
-up_out:
+out_unlock:
 	up_read(&vdev->memory_lock);
-	mutex_unlock(&vdev->vma_lock);
+
 	return ret;
 }
 
 static const struct vm_operations_struct vfio_pci_mmap_ops = {
-	.open = vfio_pci_mmap_open,
-	.close = vfio_pci_mmap_close,
 	.fault = vfio_pci_mmap_fault,
 };
 
@@ -1877,11 +1754,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 
 	vma->vm_private_data = vdev;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/*
-	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
-	 * change vm_flags within the fault handler.  Set them now.
+	 * Set vm_flags now, they should not be changed in the fault handler.
+	 * We want the same flags and page protection (decrypted above) as
+	 * io_remap_pfn_range() would set.
 	 *
 	 * VM_ALLOW_ANY_UNCACHED: The VMA flag is implemented for ARM64,
 	 * allowing KVM stage 2 device mapping attributes to use Normal-NC
@@ -2199,8 +2077,6 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	mutex_init(&vdev->ioeventfds_lock);
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
-	mutex_init(&vdev->vma_lock);
-	INIT_LIST_HEAD(&vdev->vma_list);
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
@@ -2216,7 +2092,6 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
-	mutex_destroy(&vdev->vma_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
@@ -2494,26 +2369,15 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
 	return ret;
 }
 
-/*
- * We need to get memory_lock for each device, but devices can share mmap_lock,
- * therefore we need to zap and hold the vma_lock for each device, and only then
- * get each memory_lock.
- */
 static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 				      struct vfio_pci_group_info *groups,
 				      struct iommufd_ctx *iommufd_ctx)
 {
-	struct vfio_pci_core_device *cur_mem;
-	struct vfio_pci_core_device *cur_vma;
-	struct vfio_pci_core_device *cur;
+	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
-	bool is_mem = true;
 	int ret;
 
 	mutex_lock(&dev_set->lock);
-	cur_mem = list_first_entry(&dev_set->device_list,
-				   struct vfio_pci_core_device,
-				   vdev.dev_set_list);
 
 	pdev = vfio_pci_dev_set_resettable(dev_set);
 	if (!pdev) {
@@ -2530,7 +2394,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	if (ret)
 		goto err_unlock;
 
-	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		bool owned;
 
 		/*
@@ -2554,38 +2418,38 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 		 * Otherwise, reset is not allowed.
 		 */
 		if (iommufd_ctx) {
-			int devid = vfio_iommufd_get_dev_id(&cur_vma->vdev,
+			int devid = vfio_iommufd_get_dev_id(&vdev->vdev,
 							    iommufd_ctx);
 
 			owned = (devid > 0 || devid == -ENOENT);
 		} else {
-			owned = vfio_dev_in_groups(&cur_vma->vdev, groups);
+			owned = vfio_dev_in_groups(&vdev->vdev, groups);
 		}
 
 		if (!owned) {
 			ret = -EINVAL;
-			goto err_undo;
+			break;
 		}
 
 		/*
-		 * Locking multiple devices is prone to deadlock, runaway and
-		 * unwind if we hit contention.
+		 * Take the memory write lock for each device and zap BAR
+		 * mappings to prevent the user accessing the device while in
+		 * reset.  Locking multiple devices is prone to deadlock,
+		 * runaway and unwind if we hit contention.
 		 */
-		if (!vfio_pci_zap_and_vma_lock(cur_vma, true)) {
+		if (!down_write_trylock(&vdev->memory_lock)) {
 			ret = -EBUSY;
-			goto err_undo;
+			break;
 		}
+
+		vfio_pci_zap_bars(vdev);
 	}
-	cur_vma = NULL;
 
-	list_for_each_entry(cur_mem, &dev_set->device_list, vdev.dev_set_list) {
-		if (!down_write_trylock(&cur_mem->memory_lock)) {
-			ret = -EBUSY;
-			goto err_undo;
-		}
-		mutex_unlock(&cur_mem->vma_lock);
+	if (!list_entry_is_head(vdev,
+				&dev_set->device_list, vdev.dev_set_list)) {
+		vdev = list_prev_entry(vdev, vdev.dev_set_list);
+		goto err_undo;
 	}
-	cur_mem = NULL;
 
 	/*
 	 * The pci_reset_bus() will reset all the devices in the bus.
@@ -2596,25 +2460,22 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	 * cause the PCI config space reset without restoring the original
 	 * state (saved locally in 'vdev->pm_save').
 	 */
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
-		vfio_pci_set_power_state(cur, PCI_D0);
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		vfio_pci_set_power_state(vdev, PCI_D0);
 
 	ret = pci_reset_bus(pdev);
 
+	vdev = list_last_entry(&dev_set->device_list,
+			       struct vfio_pci_core_device, vdev.dev_set_list);
+
 err_undo:
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
-		if (cur == cur_mem)
-			is_mem = false;
-		if (cur == cur_vma)
-			break;
-		if (is_mem)
-			up_write(&cur->memory_lock);
-		else
-			mutex_unlock(&cur->vma_lock);
-	}
+	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
+					 vdev.dev_set_list)
+		up_write(&vdev->memory_lock);
+
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		pm_runtime_put(&vdev->pdev->dev);
 
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
-		pm_runtime_put(&cur->pdev->dev);
 err_unlock:
 	mutex_unlock(&dev_set->lock);
 	return ret;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index e97d796a54fb..a5a62d9d963f 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -22,8 +22,10 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -43,9 +45,13 @@
 #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC	"VFIO - User Level meta-driver"
 
+#define VFIO_MAGIC 0x5646494f /* "VFIO" */
+
 static struct vfio {
 	struct class			*device_class;
 	struct ida			device_ida;
+	struct vfsmount			*vfs_mount;
+	int				fs_count;
 } vfio;
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -186,6 +192,8 @@ static void vfio_device_release(struct device *dev)
 	if (device->ops->release)
 		device->ops->release(device);
 
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
 	kvfree(device);
 }
 
@@ -228,6 +236,34 @@ struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(_vfio_alloc_device);
 
+static int vfio_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, VFIO_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type vfio_fs_type = {
+	.name = "vfio",
+	.owner = THIS_MODULE,
+	.init_fs_context = vfio_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static struct inode *vfio_fs_inode_new(void)
+{
+	struct inode *inode;
+	int ret;
+
+	ret = simple_pin_fs(&vfio_fs_type, &vfio.vfs_mount, &vfio.fs_count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	inode = alloc_anon_inode(vfio.vfs_mount->mnt_sb);
+	if (IS_ERR(inode))
+		simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+
+	return inode;
+}
+
 /*
  * Initialize a vfio_device so it can be registered to vfio core.
  */
@@ -246,6 +282,11 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	init_completion(&device->comp);
 	device->dev = dev;
 	device->ops = ops;
+	device->inode = vfio_fs_inode_new();
+	if (IS_ERR(device->inode)) {
+		ret = PTR_ERR(device->inode);
+		goto out_inode;
+	}
 
 	if (ops->init) {
 		ret = ops->init(device);
@@ -260,6 +301,9 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return 0;
 
 out_uninit:
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+out_inode:
 	vfio_release_device_set(device);
 	ida_free(&vfio.device_ida, device->index);
 	return ret;
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 100020ca4658..787ca2892d7a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -89,6 +89,16 @@ enum {
 	BTRFS_INODE_FREE_SPACE_INODE,
 	/* Set when there are no capabilities in XATTs for the inode. */
 	BTRFS_INODE_NO_CAP_XATTR,
+	/*
+	 * Set if an error happened when doing a COW write before submitting a
+	 * bio or during writeback. Used for both buffered writes and direct IO
+	 * writes. This is to signal a fast fsync that it has to wait for
+	 * ordered extents to complete and therefore not log extent maps that
+	 * point to unwritten extents (when an ordered extent completes and it
+	 * has the BTRFS_ORDERED_IOERR flag set, it drops extent maps in its
+	 * range).
+	 */
+	BTRFS_INODE_COW_WRITE_ERROR,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f9d76072398d..97f6133b6eee 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1875,6 +1875,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
+		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags);
 	} else {
 		/*
 		 * Get our ordered extents as soon as possible to avoid doing
@@ -1884,6 +1885,21 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
 						      &ctx.ordered_extents);
 		ret = filemap_fdatawait_range(inode->i_mapping, start, end);
+		if (ret)
+			goto out_release_extents;
+
+		/*
+		 * Check and clear the BTRFS_INODE_COW_WRITE_ERROR now after
+		 * starting and waiting for writeback, because for buffered IO
+		 * it may have been set during the end IO callback
+		 * (end_bbio_data_write() -> btrfs_finish_ordered_extent()) in
+		 * case an error happened and we need to wait for ordered
+		 * extents to complete so that any extent maps that point to
+		 * unwritten locations are dropped and we don't log them.
+		 */
+		if (test_and_clear_bit(BTRFS_INODE_COW_WRITE_ERROR,
+				       &BTRFS_I(inode)->runtime_flags))
+			ret = btrfs_wait_ordered_range(inode, start, len);
 	}
 
 	if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c2a42bcde98e..7dbf4162c75a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -382,6 +382,37 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	ret = can_finish_ordered_extent(ordered, page, file_offset, len, uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
+	/*
+	 * If this is a COW write it means we created new extent maps for the
+	 * range and they point to unwritten locations if we got an error either
+	 * before submitting a bio or during IO.
+	 *
+	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
+	 * are queuing its completion below. During completion, at
+	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
+	 * unwritten extents.
+	 *
+	 * However because completion runs in a work queue we can end up having
+	 * a fast fsync running before that. In the case of direct IO, once we
+	 * unlock the inode the fsync might start, and we queue the completion
+	 * before unlocking the inode. In the case of buffered IO when writeback
+	 * finishes (end_bbio_data_write()) we queue the completion, so if the
+	 * writeback was triggered by a fast fsync, the fsync might start
+	 * logging before ordered extent completion runs in the work queue.
+	 *
+	 * The fast fsync will log file extent items based on the extent maps it
+	 * finds, so if by the time it collects extent maps the ordered extent
+	 * completion didn't happen yet, it will log file extent items that
+	 * point to unwritten extents, resulting in a corruption if a crash
+	 * happens and the log tree is replayed. Note that a fast fsync does not
+	 * wait for completion of ordered extents in order to reduce latency.
+	 *
+	 * Set a flag in the inode so that the next fast fsync will wait for
+	 * ordered extents to complete before starting to log.
+	 */
+	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		set_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
+
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
 	return ret;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4caa078d972a..9af2afb41730 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1351,7 +1351,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1449,9 +1449,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
 
-	btrfs_put_root(quota_root);
 
 out:
+	btrfs_put_root(quota_root);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 8c4fc98ca9ce..aa7ddc09c55f 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -441,7 +441,8 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 	u32 item_size = btrfs_item_size(leaf, slot);
 	unsigned long end, ptr;
 	u64 offset, flags, count;
-	int type, ret;
+	int type;
+	int ret = 0;
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 	flags = btrfs_extent_flags(leaf, ei);
@@ -486,7 +487,11 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 						  key->objectid, key->offset);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
-			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			if (!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
+				btrfs_err(fs_info,
+			  "found extent owner ref without simple quotas enabled");
+				ret = -EINVAL;
+			}
 			break;
 		default:
 			btrfs_err(fs_info, "invalid key type in iref");
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index afd6932f5e89..d7caa3732f07 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,20 +1688,24 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
-					       fs_info, scrub_read_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
-
 			io_stripe.is_scrub = true;
+			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
+			/*
+			 * For RST cases, we need to manually split the bbio to
+			 * follow the RST boundary.
+			 */
 			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-					      &stripe_len, &bioc, &io_stripe,
-					      &mirror);
+					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
-			if (err) {
-				btrfs_bio_end_io(bbio,
-						 errno_to_blk_status(err));
-				return;
+			if (err < 0) {
+				set_bit(i, &stripe->io_error_bitmap);
+				set_bit(i, &stripe->error_bitmap);
+				continue;
 			}
+
+			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+					       fs_info, scrub_read_endio, stripe);
+			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 		}
 
 		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index f449f7340aad..9fb06dc16520 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/namei.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
 /*
@@ -312,19 +313,59 @@ static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
 }
 
 /*
- * Withdraw volumes.
+ * Withdraw fscache volumes.
+ */
+static void cachefiles_withdraw_fscache_volumes(struct cachefiles_cache *cache)
+{
+	struct list_head *cur;
+	struct cachefiles_volume *volume;
+	struct fscache_volume *vcookie;
+
+	_enter("");
+retry:
+	spin_lock(&cache->object_list_lock);
+	list_for_each(cur, &cache->volumes) {
+		volume = list_entry(cur, struct cachefiles_volume, cache_link);
+
+		if (atomic_read(&volume->vcookie->n_accesses) == 0)
+			continue;
+
+		vcookie = fscache_try_get_volume(volume->vcookie,
+						 fscache_volume_get_withdraw);
+		if (vcookie) {
+			spin_unlock(&cache->object_list_lock);
+			fscache_withdraw_volume(vcookie);
+			fscache_put_volume(vcookie, fscache_volume_put_withdraw);
+			goto retry;
+		}
+	}
+	spin_unlock(&cache->object_list_lock);
+
+	_leave("");
+}
+
+/*
+ * Withdraw cachefiles volumes.
  */
 static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 {
 	_enter("");
 
 	for (;;) {
+		struct fscache_volume *vcookie = NULL;
 		struct cachefiles_volume *volume = NULL;
 
 		spin_lock(&cache->object_list_lock);
 		if (!list_empty(&cache->volumes)) {
 			volume = list_first_entry(&cache->volumes,
 						  struct cachefiles_volume, cache_link);
+			vcookie = fscache_try_get_volume(volume->vcookie,
+							 fscache_volume_get_withdraw);
+			if (!vcookie) {
+				spin_unlock(&cache->object_list_lock);
+				cpu_relax();
+				continue;
+			}
 			list_del_init(&volume->cache_link);
 		}
 		spin_unlock(&cache->object_list_lock);
@@ -332,6 +373,7 @@ static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 			break;
 
 		cachefiles_withdraw_volume(volume);
+		fscache_put_volume(vcookie, fscache_volume_put_withdraw);
 	}
 
 	_leave("");
@@ -371,6 +413,7 @@ void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	pr_info("File cache on %s unregistering\n", fscache->name);
 
 	fscache_withdraw_cache(fscache);
+	cachefiles_withdraw_fscache_volumes(cache);
 
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 7e4874f60de1..d0059d36cbd5 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -97,12 +97,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 }
 
 static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
-					 unsigned long arg)
+					 unsigned long id)
 {
 	struct cachefiles_object *object = filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_req *req;
-	unsigned long id;
+	XA_STATE(xas, &cache->reqs, id);
 
 	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
 		return -EINVAL;
@@ -110,10 +110,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
 
-	id = arg;
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
+	    req->object != object) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
 	trace_cachefiles_ondemand_cread(object, id);
 	complete(&req->done);
@@ -142,6 +147,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	unsigned long id;
 	long size;
 	int ret;
+	XA_STATE(xas, &cache->reqs, 0);
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
@@ -165,10 +171,18 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	if (ret)
 		return ret;
 
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	xas.xa_index = id;
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
+	    !req->object->ondemand->ondemand_id) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
+	info = req->object->ondemand;
 	/* fail OPEN request if copen format is invalid */
 	ret = kstrtol(psize, 0, &size);
 	if (ret) {
@@ -188,7 +202,6 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		goto out;
 	}
 
-	info = req->object->ondemand;
 	spin_lock(&info->lock);
 	/*
 	 * The anonymous fd was closed before copen ? Fail the request.
@@ -228,6 +241,11 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	wake_up_all(&cache->daemon_pollwq);
 
 out:
+	spin_lock(&info->lock);
+	/* Need to set object close to avoid reopen status continuing */
+	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED)
+		cachefiles_ondemand_set_object_close(req->object);
+	spin_unlock(&info->lock);
 	complete(&req->done);
 	return ret;
 }
@@ -362,6 +380,20 @@ static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xa
 	return NULL;
 }
 
+static inline bool cachefiles_ondemand_finish_req(struct cachefiles_req *req,
+						  struct xa_state *xas, int err)
+{
+	if (unlikely(!xas || !req))
+		return false;
+
+	if (xa_cmpxchg(xas->xa, xas->xa_index, req, NULL, 0) != req)
+		return false;
+
+	req->error = err;
+	complete(&req->done);
+	return true;
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -425,16 +457,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* Remove error request and CLOSE request has no reply */
-	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
-		xas_reset(&xas);
-		xas_lock(&xas);
-		if (xas_load(&xas) == req) {
-			req->error = ret;
-			complete(&req->done);
-			xas_store(&xas, NULL);
-		}
-		xas_unlock(&xas);
-	}
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE)
+		cachefiles_ondemand_finish_req(req, &xas, ret);
 	cachefiles_req_put(req);
 	return ret ? ret : n;
 }
@@ -539,8 +563,18 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 
 	wake_up_all(&cache->daemon_pollwq);
-	wait_for_completion(&req->done);
-	ret = req->error;
+wait:
+	ret = wait_for_completion_killable(&req->done);
+	if (!ret) {
+		ret = req->error;
+	} else {
+		ret = -EINTR;
+		if (!cachefiles_ondemand_finish_req(req, &xas, ret)) {
+			/* Someone will complete it soon. */
+			cpu_relax();
+			goto wait;
+		}
+	}
 	cachefiles_req_put(req);
 	return ret;
 out:
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 89df0ba8ba5e..781aac4ef274 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -133,7 +133,6 @@ void cachefiles_free_volume(struct fscache_volume *vcookie)
 
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
 {
-	fscache_withdraw_volume(volume->vcookie);
 	cachefiles_set_volume_xattr(volume);
 	__cachefiles_free_volume(volume);
 }
diff --git a/fs/dcache.c b/fs/dcache.c
index 66515fbc9dd7..4c144519aa70 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3035,28 +3035,25 @@ EXPORT_SYMBOL(d_splice_alias);
   
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
-	bool result;
+	bool subdir;
 	unsigned seq;
 
 	if (new_dentry == old_dentry)
 		return true;
 
-	do {
-		/* for restarting inner loop in case of seq retry */
-		seq = read_seqbegin(&rename_lock);
-		/*
-		 * Need rcu_readlock to protect against the d_parent trashing
-		 * due to d_move
-		 */
-		rcu_read_lock();
-		if (d_ancestor(old_dentry, new_dentry))
-			result = true;
-		else
-			result = false;
-		rcu_read_unlock();
-	} while (read_seqretry(&rename_lock, seq));
-
-	return result;
+	/* Access d_parent under rcu as d_move() may change it. */
+	rcu_read_lock();
+	seq = read_seqbegin(&rename_lock);
+	subdir = d_ancestor(old_dentry, new_dentry);
+	 /* Try lockless once... */
+	if (read_seqretry(&rename_lock, seq)) {
+		/* ...else acquire lock for progress even on deep chains. */
+		read_seqlock_excl(&rename_lock);
+		subdir = d_ancestor(old_dentry, new_dentry);
+		read_sequnlock_excl(&rename_lock);
+	}
+	rcu_read_unlock();
+	return subdir;
 }
 EXPORT_SYMBOL(is_subdir);
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..6bd435a565f6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -723,6 +723,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
+	if (err)
+		map->m_llen = 0;
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 	return err;
 }
diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..005841dd3597 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -481,12 +481,12 @@ struct files_struct init_files = {
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
-	unsigned int maxfd = fdt->max_fds;
+	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit > maxfd)
+	if (bitbit >= maxfd)
 		return maxfd;
 	if (bitbit > start)
 		start = bitbit;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..858029b1c173 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
 			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4ac6c8c403c2..248e615270ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,6 +241,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
+	size_t orig_plen = plen;
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -277,7 +278,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
+	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d2ce0849bb53..e6066ddbb3ac 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -811,7 +811,7 @@ static void netfs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(xas);
 				continue;
 			}
@@ -1028,7 +1028,7 @@ static ssize_t netfs_writepages_begin(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		if (!folio_try_get_rcu(folio)) {
+		if (!folio_try_get(folio)) {
 			xas_reset(xas);
 			continue;
 		}
diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cdf991bdd9de..cb75c07b5281 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -27,6 +27,19 @@ struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 	return volume;
 }
 
+struct fscache_volume *fscache_try_get_volume(struct fscache_volume *volume,
+					      enum fscache_volume_trace where)
+{
+	int ref;
+
+	if (!__refcount_inc_not_zero(&volume->ref, &ref))
+		return NULL;
+
+	trace_fscache_volume(volume->debug_id, ref + 1, where);
+	return volume;
+}
+EXPORT_SYMBOL(fscache_try_get_volume);
+
 static void fscache_see_volume(struct fscache_volume *volume,
 			       enum fscache_volume_trace where)
 {
@@ -420,6 +433,7 @@ void fscache_put_volume(struct fscache_volume *volume,
 			fscache_free_volume(volume);
 	}
 }
+EXPORT_SYMBOL(fscache_put_volume);
 
 /*
  * Relinquish a volume representation cookie.
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ec7045d24400..edf9b2a180ca 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -326,8 +326,6 @@ extern const struct seq_operations fscache_volumes_seq_ops;
 
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
-void fscache_put_volume(struct fscache_volume *volume,
-			enum fscache_volume_trace where);
 bool fscache_begin_volume_access(struct fscache_volume *volume,
 				 struct fscache_cookie *cookie,
 				 enum fscache_access_trace why);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bdd6cb33a370..375c08fdcf2f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1625,7 +1625,16 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 	switch (error) {
 	case 1:
 		break;
-	case 0:
+	case -ETIMEDOUT:
+		if (inode && (IS_ROOT(dentry) ||
+			      NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL))
+			error = 1;
+		break;
+	case -ESTALE:
+	case -ENOENT:
+		error = 0;
+		fallthrough;
+	default:
 		/*
 		 * We can't d_drop the root of a disconnected tree:
 		 * its d_hash is on the s_anon list and d_drop() would hide
@@ -1680,18 +1689,8 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
 
 	dir_verifier = nfs_save_change_attribute(dir);
 	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
-	if (ret < 0) {
-		switch (ret) {
-		case -ESTALE:
-		case -ENOENT:
-			ret = 0;
-			break;
-		case -ETIMEDOUT:
-			if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
-				ret = 1;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	/* Request help from readdirplus */
 	nfs_lookup_advise_force_readdirplus(dir, flags);
@@ -1735,7 +1734,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 			 unsigned int flags)
 {
 	struct inode *inode;
-	int error;
+	int error = 0;
 
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode = d_inode(dentry);
@@ -1780,7 +1779,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 out_bad:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
+	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
 
 static int
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3a816c4a6d5e..a691fa10b3e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6289,6 +6289,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 	if (status == 0)
 		nfs_setsecurity(inode, fattr);
 
+	nfs_free_fattr(fattr);
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116..040b6b79c75e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1545,6 +1545,11 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 					continue;
 			} else if (index == prev->wb_index + 1)
 				continue;
+			/*
+			 * We will submit more requests after these. Indicate
+			 * this to the underlying layers.
+			 */
+			desc->pg_moreio = 1;
 			nfs_pageio_complete(desc);
 			break;
 		}
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 0e27a2e4e68b..13818129d268 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
 error:
 	folio_set_error(folio);
 	folio_unlock(folio);
-	return -EIO;
+	return error;
 }
 
 static const char *nfs_get_link(struct dentry *dentry,
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d8ede6826000..612e3398b221 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1409,7 +1409,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	target_tcon = tlink_tcon(smb_file_target->tlink);
 
 	if (src_tcon->ses != target_tcon->ses) {
-		cifs_dbg(VFS, "source and target of copy not on same server\n");
+		cifs_dbg(FYI, "source and target of copy not on same server\n");
 		goto out;
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9be37d0fe724..4784fece4d99 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2753,7 +2753,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(xas);
 				continue;
 			}
@@ -2989,7 +2989,7 @@ static ssize_t cifs_writepages_begin(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		if (!folio_try_get_rcu(folio)) {
+		if (!folio_try_get(folio)) {
 			xas_reset(xas);
 			continue;
 		}
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 202ff9128156..694d2b4a4ad9 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -917,6 +917,40 @@ struct smb2_query_directory_rsp {
 	__u8   Buffer[];
 } __packed;
 
+/* DeviceType Flags */
+#define FILE_DEVICE_CD_ROM              0x00000002
+#define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
+#define FILE_DEVICE_DFS                 0x00000006
+#define FILE_DEVICE_DISK                0x00000007
+#define FILE_DEVICE_DISK_FILE_SYSTEM    0x00000008
+#define FILE_DEVICE_FILE_SYSTEM         0x00000009
+#define FILE_DEVICE_NAMED_PIPE          0x00000011
+#define FILE_DEVICE_NETWORK             0x00000012
+#define FILE_DEVICE_NETWORK_FILE_SYSTEM 0x00000014
+#define FILE_DEVICE_NULL                0x00000015
+#define FILE_DEVICE_PARALLEL_PORT       0x00000016
+#define FILE_DEVICE_PRINTER             0x00000018
+#define FILE_DEVICE_SERIAL_PORT         0x0000001b
+#define FILE_DEVICE_STREAMS             0x0000001e
+#define FILE_DEVICE_TAPE                0x0000001f
+#define FILE_DEVICE_TAPE_FILE_SYSTEM    0x00000020
+#define FILE_DEVICE_VIRTUAL_DISK        0x00000024
+#define FILE_DEVICE_NETWORK_REDIRECTOR  0x00000028
+
+/* Device Characteristics */
+#define FILE_REMOVABLE_MEDIA			0x00000001
+#define FILE_READ_ONLY_DEVICE			0x00000002
+#define FILE_FLOPPY_DISKETTE			0x00000004
+#define FILE_WRITE_ONCE_MEDIA			0x00000008
+#define FILE_REMOTE_DEVICE			0x00000010
+#define FILE_DEVICE_IS_MOUNTED			0x00000020
+#define FILE_VIRTUAL_VOLUME			0x00000040
+#define FILE_DEVICE_SECURE_OPEN			0x00000100
+#define FILE_CHARACTERISTIC_TS_DEVICE		0x00001000
+#define FILE_CHARACTERISTIC_WEBDAV_DEVICE	0x00002000
+#define FILE_PORTABLE_DEVICE			0x00004000
+#define FILE_DEVICE_ALLOW_APPCONTAINER_TRAVERSAL 0x00020000
+
 /*
  * Maximum number of iovs we need for a set-info request.
  * The largest one is rename/hardlink
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7d26fdcebbf9..840c71c66b30 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5323,8 +5323,13 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		info = (struct filesystem_device_info *)rsp->Buffer;
 
-		info->DeviceType = cpu_to_le32(stfs.f_type);
-		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
+		info->DeviceType = cpu_to_le32(FILE_DEVICE_DISK);
+		info->DeviceCharacteristics =
+			cpu_to_le32(FILE_DEVICE_IS_MOUNTED);
+		if (!test_tree_conn_flag(work->tcon,
+					 KSMBD_TREE_CONN_FLAG_WRITABLE))
+			info->DeviceCharacteristics |=
+				cpu_to_le32(FILE_READ_ONLY_DEVICE);
 		rsp->OutputBufferLength = cpu_to_le32(8);
 		break;
 	}
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 98c6fd0b39b6..fdfb61ccf55a 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -77,7 +77,7 @@ struct cdrom_device_ops {
 				      unsigned int clearing, int slot);
 	int (*tray_move) (struct cdrom_device_info *, int);
 	int (*lock_door) (struct cdrom_device_info *, int);
-	int (*select_speed) (struct cdrom_device_info *, int);
+	int (*select_speed) (struct cdrom_device_info *, unsigned long);
 	int (*get_last_session) (struct cdrom_device_info *,
 				 struct cdrom_multisession *);
 	int (*get_mcn) (struct cdrom_device_info *,
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index bdf7f3eddf0a..4c91a019972b 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -19,6 +19,7 @@
 enum fscache_cache_trace;
 enum fscache_cookie_trace;
 enum fscache_access_trace;
+enum fscache_volume_trace;
 
 enum fscache_cache_state {
 	FSCACHE_CACHE_IS_NOT_PRESENT,	/* No cache is present for this name */
@@ -97,6 +98,11 @@ extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
+extern struct fscache_volume *
+fscache_try_get_volume(struct fscache_volume *volume,
+		       enum fscache_volume_trace where);
+extern void fscache_put_volume(struct fscache_volume *volume,
+			       enum fscache_volume_trace where);
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index d7c2d33baa7f..fdd2a75adb03 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -263,54 +263,9 @@ static inline bool folio_try_get(struct folio *folio)
 	return folio_ref_add_unless(folio, 1, 0);
 }
 
-static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
-{
-#ifdef CONFIG_TINY_RCU
-	/*
-	 * The caller guarantees the folio will not be freed from interrupt
-	 * context, so (on !SMP) we only need preemption to be disabled
-	 * and TINY_RCU does that for us.
-	 */
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
-	folio_ref_add(folio, count);
-#else
-	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
-		/* Either the folio has been freed, or will be freed. */
-		return false;
-	}
-#endif
-	return true;
-}
-
-/**
- * folio_try_get_rcu - Attempt to increase the refcount on a folio.
- * @folio: The folio.
- *
- * This is a version of folio_try_get() optimised for non-SMP kernels.
- * If you are still holding the rcu_read_lock() after looking up the
- * page and know that the page cannot have its refcount decreased to
- * zero in interrupt context, you can use this instead of folio_try_get().
- *
- * Example users include get_user_pages_fast() (as pages are not unmapped
- * from interrupt context) and the page cache lookups (as pages are not
- * truncated from interrupt context).  We also know that pages are not
- * frozen in interrupt context for the purposes of splitting or migration.
- *
- * You can also use this function if you're holding a lock that prevents
- * pages being frozen & removed; eg the i_pages lock for the page cache
- * or the mmap_lock or page table lock for page tables.  In this case,
- * it will always succeed, and you could have used a plain folio_get(),
- * but it's sometimes more convenient to have a common function called
- * from both locked and RCU-protected contexts.
- *
- * Return: True if the reference count was successfully incremented.
- */
-static inline bool folio_try_get_rcu(struct folio *folio)
+static inline bool folio_ref_try_add(struct folio *folio, int count)
 {
-	return folio_ref_try_add_rcu(folio, 1);
+	return folio_ref_add_unless(folio, count, 0);
 }
 
 static inline int page_ref_freeze(struct page *page, int count)
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce..314892a6de8a 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -435,8 +435,6 @@ struct pnp_protocol {
 #define protocol_for_each_dev(protocol, dev)	\
 	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
 
-extern const struct bus_type pnp_bus_type;
-
 #if defined(CONFIG_PNP)
 
 /* device management */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 64a4deb18dd0..afe6631da1bc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1089,12 +1089,13 @@ struct spi_transfer {
 	unsigned	dummy_data:1;
 	unsigned	cs_off:1;
 	unsigned	cs_change:1;
-	unsigned	tx_nbits:3;
-	unsigned	rx_nbits:3;
+	unsigned	tx_nbits:4;
+	unsigned	rx_nbits:4;
 	unsigned	timestamped:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */
+#define	SPI_NBITS_OCTAL	0x08 /* 8-bit transfer */
 	u8		bits_per_word;
 	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 8b1a29820409..000a6cab2d31 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -64,6 +64,7 @@ struct vfio_device {
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
 	void (*put_kvm)(struct kvm *kvm);
+	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
 	u8 iommufd_attached:1;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index a2c8b8bba711..f87067438ed4 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -93,8 +93,6 @@ struct vfio_pci_core_device {
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
-	struct mutex		vma_lock;
-	struct list_head	vma_list;
 	struct rw_semaphore	memory_lock;
 };
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 6a9d063e9f47..534c3386e714 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -38,6 +38,8 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u8 event, u32 timeout,
 			     struct sock *sk);
+int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param, u32 timeout);
 
 void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index d70c55f17df7..94dbb23580f2 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -36,6 +36,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	struct dma_chan *chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
+int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream);
 
 int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index a6190aa1b406..f1a73aa83fbb 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -35,12 +35,14 @@ enum fscache_volume_trace {
 	fscache_volume_get_cookie,
 	fscache_volume_get_create_work,
 	fscache_volume_get_hash_collision,
+	fscache_volume_get_withdraw,
 	fscache_volume_free,
 	fscache_volume_new_acquire,
 	fscache_volume_put_cookie,
 	fscache_volume_put_create_work,
 	fscache_volume_put_hash_collision,
 	fscache_volume_put_relinquish,
+	fscache_volume_put_withdraw,
 	fscache_volume_see_create_work,
 	fscache_volume_see_hash_wake,
 	fscache_volume_wait_create_work,
@@ -120,12 +122,14 @@ enum fscache_access_trace {
 	EM(fscache_volume_get_cookie,		"GET cook ")		\
 	EM(fscache_volume_get_create_work,	"GET creat")		\
 	EM(fscache_volume_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_volume_get_withdraw,		"GET withd")            \
 	EM(fscache_volume_free,			"FREE     ")		\
 	EM(fscache_volume_new_acquire,		"NEW acq  ")		\
 	EM(fscache_volume_put_cookie,		"PUT cook ")		\
 	EM(fscache_volume_put_create_work,	"PUT creat")		\
 	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
+	EM(fscache_volume_put_withdraw,		"PUT withd")            \
 	EM(fscache_volume_see_create_work,	"SEE creat")		\
 	EM(fscache_volume_see_hash_wake,	"SEE hwake")		\
 	E_(fscache_volume_wait_create_work,	"WAIT crea")
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 03edf2ccdf6c..a4206723f503 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -618,6 +618,8 @@
 #define KEY_CAMERA_ACCESS_ENABLE	0x24b	/* Enables programmatic access to camera devices. (HUTRR72) */
 #define KEY_CAMERA_ACCESS_DISABLE	0x24c	/* Disables programmatic access to camera devices. (HUTRR72) */
 #define KEY_CAMERA_ACCESS_TOGGLE	0x24d	/* Toggles the current state of the camera access control. (HUTRR72) */
+#define KEY_ACCESSIBILITY		0x24e	/* Toggles the system bound accessibility UI/command (HUTRR116) */
+#define KEY_DO_NOT_DISTURB		0x24f	/* Toggles the system-wide "Do Not Disturb" control (HUTRR94)*/
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
diff --git a/io_uring/register.c b/io_uring/register.c
index 99c37775f974..1ae8491e35ab 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -355,8 +355,10 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	}
 
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
 	}
 
 	if (copy_to_user(arg, new_count, sizeof(new_count)))
@@ -381,8 +383,10 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	return 0;
 err:
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
 	}
 	return ret;
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d2dbe099286b..7634fc32ee05 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -124,6 +124,7 @@ enum wq_internal_consts {
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
 	WQ_NAME_LEN		= 32,
+	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
 };
 
 /*
@@ -2778,6 +2779,26 @@ static void worker_detach_from_pool(struct worker *worker)
 		complete(detach_completion);
 }
 
+static int format_worker_id(char *buf, size_t size, struct worker *worker,
+			    struct worker_pool *pool)
+{
+	if (worker->rescue_wq)
+		return scnprintf(buf, size, "kworker/R-%s",
+				 worker->rescue_wq->name);
+
+	if (pool) {
+		if (pool->cpu >= 0)
+			return scnprintf(buf, size, "kworker/%d:%d%s",
+					 pool->cpu, worker->id,
+					 pool->attrs->nice < 0  ? "H" : "");
+		else
+			return scnprintf(buf, size, "kworker/u%d:%d",
+					 pool->id, worker->id);
+	} else {
+		return scnprintf(buf, size, "kworker/dying");
+	}
+}
+
 /**
  * create_worker - create a new workqueue worker
  * @pool: pool the new worker will belong to
@@ -2794,7 +2815,6 @@ static struct worker *create_worker(struct worker_pool *pool)
 {
 	struct worker *worker;
 	int id;
-	char id_buf[23];
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -2813,17 +2833,14 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker->id = id;
 
 	if (!(pool->flags & POOL_BH)) {
-		if (pool->cpu >= 0)
-			snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
-				 pool->attrs->nice < 0  ? "H" : "");
-		else
-			snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
+		char id_buf[WORKER_ID_LEN];
 
+		format_worker_id(id_buf, sizeof(id_buf), worker, pool);
 		worker->task = kthread_create_on_node(worker_thread, worker,
-					pool->node, "kworker/%s", id_buf);
+						      pool->node, "%s", id_buf);
 		if (IS_ERR(worker->task)) {
 			if (PTR_ERR(worker->task) == -EINTR) {
-				pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
+				pr_err("workqueue: Interrupted when creating a worker thread \"%s\"\n",
 				       id_buf);
 			} else {
 				pr_err_once("workqueue: Failed to create a worker thread: %pe",
@@ -3386,7 +3403,6 @@ static int worker_thread(void *__worker)
 		raw_spin_unlock_irq(&pool->lock);
 		set_pf_worker(false);
 
-		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
@@ -5430,6 +5446,7 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 static int init_rescuer(struct workqueue_struct *wq)
 {
 	struct worker *rescuer;
+	char id_buf[WORKER_ID_LEN];
 	int ret;
 
 	if (!(wq->flags & WQ_MEM_RECLAIM))
@@ -5443,7 +5460,9 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	rescuer->rescue_wq = wq;
-	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
+	format_worker_id(id_buf, sizeof(id_buf), rescuer, NULL);
+
+	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", id_buf);
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
 		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
@@ -6272,19 +6291,15 @@ void show_freezable_workqueues(void)
 /* used to show worker information through /proc/PID/{comm,stat,status} */
 void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 {
-	int off;
-
-	/* always show the actual comm */
-	off = strscpy(buf, task->comm, size);
-	if (off < 0)
-		return;
-
 	/* stabilize PF_WQ_WORKER and worker pool association */
 	mutex_lock(&wq_pool_attach_mutex);
 
 	if (task->flags & PF_WQ_WORKER) {
 		struct worker *worker = kthread_data(task);
 		struct worker_pool *pool = worker->pool;
+		int off;
+
+		off = format_worker_id(buf, size, worker, pool);
 
 		if (pool) {
 			raw_spin_lock_irq(&pool->lock);
@@ -6303,6 +6318,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 			}
 			raw_spin_unlock_irq(&pool->lock);
 		}
+	} else {
+		strscpy(buf, task->comm, size);
 	}
 
 	mutex_unlock(&wq_pool_attach_mutex);
diff --git a/lib/Kconfig b/lib/Kconfig
index 4557bb8a5256..c98e11c7330e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -539,13 +539,7 @@ config CPUMASK_OFFSTACK
 	  stack overflow.
 
 config FORCE_NR_CPUS
-       bool "Set number of CPUs at compile time"
-       depends on SMP && EXPERT && !COMPILE_TEST
-       help
-         Say Yes if you have NR_CPUS set to an actual number of possible
-         CPUs in your system, not to a default value. This forces the core
-         code to rely on compile-time value and optimize kernel routines
-         better.
+	def_bool !SMP
 
 config CPU_RMAP
 	bool
diff --git a/lib/closure.c b/lib/closure.c
index c16540552d61..99380d9b4aa9 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -17,12 +17,18 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
 {
 	int r = flags & CLOSURE_REMAINING_MASK;
 
-	BUG_ON(flags & CLOSURE_GUARD_MASK);
-	BUG_ON(!r && (flags & ~CLOSURE_DESTRUCTOR));
+	if (WARN(flags & CLOSURE_GUARD_MASK,
+		 "closure has guard bits set: %x (%u)",
+		 flags & CLOSURE_GUARD_MASK, (unsigned) __fls(r)))
+		r &= ~CLOSURE_GUARD_MASK;
 
 	if (!r) {
 		smp_acquire__after_ctrl_dep();
 
+		WARN(flags & ~CLOSURE_DESTRUCTOR,
+		     "closure ref hit 0 with incorrect flags set: %x (%u)",
+		     flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
+
 		cl->closure_get_happened = false;
 
 		if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
diff --git a/mm/filemap.c b/mm/filemap.c
index 41bf94f7dbd1..196f70166537 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1823,7 +1823,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto repeat;
 
 	if (unlikely(folio != xas_reload(&xas))) {
@@ -1977,7 +1977,7 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto reset;
 
 	if (unlikely(folio != xas_reload(xas))) {
@@ -2157,7 +2157,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -2289,7 +2289,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -3449,7 +3449,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (folio_test_locked(folio))
 			continue;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			continue;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
diff --git a/mm/gup.c b/mm/gup.c
index 1611e73b1121..ec8570d25a6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -76,7 +76,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
+	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
 	/*
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 24f6b6a5c772..2647458843c5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -63,50 +63,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
-static int hci_scan_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 scan = opt;
-
-	BT_DBG("%s %x", req->hdev->name, scan);
-
-	/* Inquiry and Page scans */
-	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-	return 0;
-}
-
-static int hci_auth_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 auth = opt;
-
-	BT_DBG("%s %x", req->hdev->name, auth);
-
-	/* Authentication */
-	hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
-	return 0;
-}
-
-static int hci_encrypt_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 encrypt = opt;
-
-	BT_DBG("%s %x", req->hdev->name, encrypt);
-
-	/* Encryption */
-	hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
-	return 0;
-}
-
-static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
-{
-	__le16 policy = cpu_to_le16(opt);
-
-	BT_DBG("%s %x", req->hdev->name, policy);
-
-	/* Default link policy */
-	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
-	return 0;
-}
-
 /* Get HCI device by index.
  * Device is held on return. */
 struct hci_dev *hci_dev_get(int index)
@@ -728,6 +684,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 {
 	struct hci_dev *hdev;
 	struct hci_dev_req dr;
+	__le16 policy;
 	int err = 0;
 
 	if (copy_from_user(&dr, arg, sizeof(dr)))
@@ -754,8 +711,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case HCISETAUTH:
-		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+					    1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETENCRYPT:
@@ -766,19 +723,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
-			err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-					   HCI_INIT_TIMEOUT, NULL);
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_WRITE_AUTH_ENABLE,
+						    1, &dr.dev_opt,
+						    HCI_CMD_TIMEOUT);
 			if (err)
 				break;
 		}
 
-		err = hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
+					    1, &dr.dev_opt,
+					    HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETSCAN:
-		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
+					    1, &dr.dev_opt,
+					    HCI_CMD_TIMEOUT);
 
 		/* Ensure that the connectable and discoverable states
 		 * get correctly modified as this was a non-mgmt change.
@@ -788,8 +749,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 
 	case HCISETLINKPOL:
-		err = hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		policy = cpu_to_le16(dr.dev_opt);
+
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
+					    2, &policy,
+					    HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETLINKMODE:
@@ -2744,7 +2708,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->rx_work);
+	cancel_work_sync(&hdev->cmd_work);
+	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
+	cancel_work_sync(&hdev->error_reset);
 
 	hci_cmd_sync_clear(hdev);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7bfa6b59ba87..51f754b6e838 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -280,6 +280,19 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 EXPORT_SYMBOL(__hci_cmd_sync_status);
 
+int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param, u32 timeout)
+{
+	int err;
+
+	hci_req_sync_lock(hdev);
+	err = __hci_cmd_sync_status(hdev, opcode, plen, param, timeout);
+	hci_req_sync_unlock(hdev);
+
+	return err;
+}
+EXPORT_SYMBOL(hci_cmd_sync_status);
+
 static void hci_cmd_sync_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9394a158d1b1..b8ff522589cd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6762,6 +6762,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
@@ -6778,6 +6780,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	}
 
 drop:
+	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 free_skb:
 	kfree_skb(skb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 8645461d45e8..1bc79887a794 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,12 +1485,16 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	sk = chan->data;
+	if (!sk)
+		return -ENXIO;
 
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 0601bad79822..ff7e734e335b 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -58,7 +58,9 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return orig_dst->lwtstate->orig_output(net, sk, skb);
 	}
 
+	local_bh_disable();
 	dst = dst_cache_get(&ilwt->dst_cache);
+	local_bh_enable();
 	if (unlikely(!dst)) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -86,8 +88,11 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected)
+		if (ilwt->connected) {
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 	}
 
 	skb_dst_set(skb, dst);
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index a013b92cbb86..2c83b7586422 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -212,9 +212,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -234,9 +234,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
@@ -268,23 +268,21 @@ static int rpl_input(struct sk_buff *skb)
 		return err;
 	}
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 51dc2d9dd6b8..d0feadfdb46e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2954,8 +2954,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 70c67c860e99..48bf62e92e02 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1841,6 +1841,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_handle_queued_frames(struct ieee80211_local *local);
+
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 			     u64 *cookie, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4eaea0a9975b..0965ad11ec74 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -423,9 +423,9 @@ u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+/* context: requires softirqs disabled */
+void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -450,6 +450,13 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
 	}
 }
 
+static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+{
+	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
+
+	ieee80211_handle_queued_frames(local);
+}
+
 static void ieee80211_restart_work(struct work_struct *work)
 {
 	struct ieee80211_local *local =
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index cbc9b5e40cb3..6d4510221c98 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1776,6 +1776,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 3da1c5c45035..b5f2df61c7f6 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -358,7 +358,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -368,34 +369,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
@@ -744,15 +745,21 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 			local->hw_scan_ies_bufsize *= n_bands;
 		}
 
-		local->hw_scan_req = kmalloc(
-				sizeof(*local->hw_scan_req) +
-				req->n_channels * sizeof(req->channels[0]) +
-				local->hw_scan_ies_bufsize, GFP_KERNEL);
+		local->hw_scan_req = kmalloc(struct_size(local->hw_scan_req,
+							 req.channels,
+							 req->n_channels) +
+					     local->hw_scan_ies_bufsize,
+					     GFP_KERNEL);
 		if (!local->hw_scan_req)
 			return -ENOMEM;
 
 		local->hw_scan_req->req.ssids = req->ssids;
 		local->hw_scan_req->req.n_ssids = req->n_ssids;
+		/* None of the channels are actually set
+		 * up but let UBSAN know the boundaries.
+		 */
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		ies = (u8 *)local->hw_scan_req +
 			sizeof(*local->hw_scan_req) +
 			req->n_channels * sizeof(req->channels[0]);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0da5f6082d15..cd4573723999 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1567,6 +1567,10 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	local_bh_disable();
+	ieee80211_handle_queued_frames(local);
+	local_bh_enable();
+
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 2a6f1ed763c9..6fbed5bb5c3e 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 
 	ieee802154_xmit_complete(&local->hw, skb, false);
 
@@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		if (ret)
 			goto err_wake_netif_queue;
 
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes += len;
+		DEV_STATS_INC(dev, tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
 	} else {
 		local->tx_skb = skb;
 		queue_work(local->workqueue, &local->sync_tx_work);
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..755af47b88b9 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2023 Intel Corporation
+ * Copyright (C) 2018, 2021-2024 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -458,6 +458,10 @@ static inline int rdev_scan(struct cfg80211_registered_device *rdev,
 			    struct cfg80211_scan_request *request)
 {
 	int ret;
+
+	if (WARN_ON_ONCE(!request->n_ssids && request->ssids))
+		return -EINVAL;
+
 	trace_rdev_scan(&rdev->wiphy, request);
 	ret = rdev->ops->scan(&rdev->wiphy, request);
 	trace_rdev_return_int(&rdev->wiphy, ret);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ecea8c08e270..fba5e98bf493 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -812,6 +812,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	LIST_HEAD(coloc_ap_list);
 	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
+	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
 	rdev_req->scan_6ghz = true;
 
@@ -877,10 +878,15 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		spin_unlock_bh(&rdev->bss_lock);
 	}
 
-	request = kzalloc(struct_size(request, channels, n_channels) +
-			  sizeof(*request->scan_6ghz_params) * count +
-			  sizeof(*request->ssids) * rdev_req->n_ssids,
-			  GFP_KERNEL);
+	size = struct_size(request, channels, n_channels);
+	offs_ssids = size;
+	size += sizeof(*request->ssids) * rdev_req->n_ssids;
+	offs_6ghz_params = size;
+	size += sizeof(*request->scan_6ghz_params) * count;
+	offs_ies = size;
+	size += rdev_req->ie_len;
+
+	request = kzalloc(size, GFP_KERNEL);
 	if (!request) {
 		cfg80211_free_coloc_ap_list(&coloc_ap_list);
 		return -ENOMEM;
@@ -888,8 +894,26 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	*request = *rdev_req;
 	request->n_channels = 0;
-	request->scan_6ghz_params =
-		(void *)&request->channels[n_channels];
+	request->n_6ghz_params = 0;
+	if (rdev_req->n_ssids) {
+		/*
+		 * Add the ssids from the parent scan request to the new
+		 * scan request, so the driver would be able to use them
+		 * in its probe requests to discover hidden APs on PSC
+		 * channels.
+		 */
+		request->ssids = (void *)request + offs_ssids;
+		memcpy(request->ssids, rdev_req->ssids,
+		       sizeof(*request->ssids) * request->n_ssids);
+	}
+	request->scan_6ghz_params = (void *)request + offs_6ghz_params;
+
+	if (rdev_req->ie_len) {
+		void *ie = (void *)request + offs_ies;
+
+		memcpy(ie, rdev_req->ie, rdev_req->ie_len);
+		request->ie = ie;
+	}
 
 	/*
 	 * PSC channels should not be scanned in case of direct scan with 1 SSID
@@ -978,17 +1002,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	if (request->n_channels) {
 		struct cfg80211_scan_request *old = rdev->int_scan_req;
-		rdev->int_scan_req = request;
 
-		/*
-		 * Add the ssids from the parent scan request to the new scan
-		 * request, so the driver would be able to use them in its
-		 * probe requests to discover hidden APs on PSC channels.
-		 */
-		request->ssids = (void *)&request->channels[request->n_channels];
-		request->n_ssids = rdev_req->n_ssids;
-		memcpy(request->ssids, rdev_req->ssids, sizeof(*request->ssids) *
-		       request->n_ssids);
+		rdev->int_scan_req = request;
 
 		/*
 		 * If this scan follows a previous scan, save the scan start
@@ -3396,10 +3411,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	wiphy = &rdev->wiphy;
 
 	/* Determine number of channels, needed to allocate creq */
-	if (wreq && wreq->num_channels)
+	if (wreq && wreq->num_channels) {
+		/* Passed from userspace so should be checked */
+		if (unlikely(wreq->num_channels > IW_MAX_FREQUENCIES))
+			return -EINVAL;
 		n_channels = wreq->num_channels;
-	else
+	} else {
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
+	}
 
 	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
 		       n_channels * sizeof(void *),
@@ -3473,8 +3492,10 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			memcpy(creq->ssids[0].ssid, wreq->essid, wreq->essid_len);
 			creq->ssids[0].ssid_len = wreq->essid_len;
 		}
-		if (wreq->scan_type == IW_SCAN_TYPE_PASSIVE)
+		if (wreq->scan_type == IW_SCAN_TYPE_PASSIVE) {
+			creq->ssids = NULL;
 			creq->n_ssids = 0;
+		}
 	}
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++)
diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index a290de36307b..786616755217 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -396,35 +396,6 @@ static struct expr *expr_eliminate_yn(struct expr *e)
 	return e;
 }
 
-/*
- * bool FOO!=n => FOO
- */
-struct expr *expr_trans_bool(struct expr *e)
-{
-	if (!e)
-		return NULL;
-	switch (e->type) {
-	case E_AND:
-	case E_OR:
-	case E_NOT:
-		e->left.expr = expr_trans_bool(e->left.expr);
-		e->right.expr = expr_trans_bool(e->right.expr);
-		break;
-	case E_UNEQUAL:
-		// FOO!=n -> FOO
-		if (e->left.sym->type == S_TRISTATE) {
-			if (e->right.sym == &symbol_no) {
-				e->type = E_SYMBOL;
-				e->right.sym = NULL;
-			}
-		}
-		break;
-	default:
-		;
-	}
-	return e;
-}
-
 /*
  * e1 || e2 -> ?
  */
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 0158f5eac454..f015883519b3 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -288,7 +288,6 @@ void expr_free(struct expr *e);
 void expr_eliminate_eq(struct expr **ep1, struct expr **ep2);
 int expr_eq(struct expr *e1, struct expr *e2);
 tristate expr_calc_value(struct expr *e);
-struct expr *expr_trans_bool(struct expr *e);
 struct expr *expr_eliminate_dups(struct expr *e);
 struct expr *expr_transform(struct expr *e);
 int expr_contains_symbol(struct expr *dep, struct symbol *sym);
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 9709aca3a30f..9e52c7360e55 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -1478,7 +1478,6 @@ int main(int ac, char *av[])
 
 	conf_parse(name);
 	fixup_rootmenu(&rootmenu);
-	conf_read(NULL);
 
 	/* Load the interface and connect signals */
 	init_main_window(glade_file);
@@ -1486,6 +1485,8 @@ int main(int ac, char *av[])
 	init_left_tree();
 	init_right_tree();
 
+	conf_read(NULL);
+
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		display_tree_part();
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 3b822cd110f4..8b48a80e7e16 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -379,8 +379,6 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 				dep = expr_transform(dep);
 				dep = expr_alloc_and(expr_copy(basedep), dep);
 				dep = expr_eliminate_dups(dep);
-				if (menu->sym && menu->sym->type != S_TRISTATE)
-					dep = expr_trans_bool(dep);
 				prop->visible.expr = dep;
 
 				/*
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 494ec0c207fa..e299e8634751 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -349,6 +349,16 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 
+int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	dmaengine_synchronize(prtd->dma_chan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_sync_stop);
+
 /**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
@@ -358,6 +368,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status == DMA_PAUSED)
+		dmaengine_terminate_async(prtd->dma_chan);
 
 	dmaengine_synchronize(prtd->dma_chan);
 	kfree(prtd);
@@ -378,6 +394,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status == DMA_PAUSED)
+		dmaengine_terminate_async(prtd->dma_chan);
 
 	dmaengine_synchronize(prtd->dma_chan);
 	dma_release_channel(prtd->dma_chan);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0b76e76823d2..353ecd960a1f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1775,6 +1775,8 @@ static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,
 			      snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	if (runtime->state != SNDRV_PCM_STATE_SUSPENDED)
+		return -EBADFD;
 	if (!(runtime->info & SNDRV_PCM_INFO_RESUME))
 		return -ENOSYS;
 	runtime->trigger_master = substream;
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index f806636242ee..b6869fe019f2 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -160,6 +160,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	imply SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
@@ -176,6 +177,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	imply SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 4f5e581cdd5f..16cf62f06d2c 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -118,6 +118,10 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38C7", 4, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, 2, -1, 1000, 4500, 24 },
+	{ "17AA38C8", 4, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, 2, -1, 1000, 4500, 24 },
+	{ "17AA38F9", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
+	{ "17AA38FA", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{}
 };
 
@@ -509,6 +513,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
 	{ "CSC3551", "17AA38B7", generic_dsd_config },
+	{ "CSC3551", "17AA38C7", generic_dsd_config },
+	{ "CSC3551", "17AA38C8", generic_dsd_config },
+	{ "CSC3551", "17AA38F9", generic_dsd_config },
+	{ "CSC3551", "17AA38FA", generic_dsd_config },
 	{}
 };
 
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 6b77c38a0e15..e134ede6c5aa 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -735,6 +735,8 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
+	cs35l56->codec = NULL;
+
 	dev_dbg(cs35l56->base.dev, "Unbound\n");
 }
 
@@ -840,6 +842,9 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	cs35l56->suspended = false;
 
+	if (!cs35l56->codec)
+		return 0;
+
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret > 0) {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 98f580e273e4..8a52ed9aa465 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -585,10 +585,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
+	case 0x10ec0285:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
+	case 0x10ec0295:
 	case 0x10ec0298:
 		alc_headset_mic_no_shutup(codec);
 		break;
@@ -10035,6 +10039,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -10538,10 +10543,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38d7, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1760b5d42460..4e3a8ce690a4 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+        {
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index fd02b621da52..d29878af2a80 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -214,6 +214,10 @@ static const struct reg_sequence cs35l56_asp1_defaults[] = {
 	REG_SEQ0(CS35L56_ASP1_FRAME_CONTROL5,	0x00020100),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL1,	0x00000018),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL5,	0x00000018),
+	REG_SEQ0(CS35L56_ASP1TX1_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX2_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX3_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX4_INPUT,		0x00000000),
 };
 
 /*
diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 17bd6b516077..8b2328d5d0c7 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -865,12 +865,16 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 			 * set auto-check mode, then restart jack_detect_work after 400ms.
 			 * Don't report jack status.
 			 */
-			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
-					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
+			regmap_write(es8326->regmap, ES8326_INT_SOURCE, 0x00);
 			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x10, 0x00);
 			es8326_enable_micbias(es8326->component);
 			usleep_range(50000, 70000);
 			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x00);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x10, 0x10);
+			usleep_range(50000, 70000);
+			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
+					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
 			regmap_write(es8326->regmap, ES8326_SYS_BIAS, 0x1f);
 			regmap_update_bits(es8326->regmap, ES8326_HP_DRIVER_REF, 0x0f, 0x08);
 			queue_delayed_work(system_wq, &es8326->jack_detect_work,
diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 65d584c1886e..543a3fa1f5d3 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -68,6 +68,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x200007f:
 	case 0x2000082 ... 0x200008e:
 	case 0x2000090 ... 0x2000094:
+	case 0x3110000:
 	case 0x5300000 ... 0x5300002:
 	case 0x5400002:
 	case 0x5600000 ... 0x5600007:
@@ -125,6 +126,7 @@ static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x2000067:
 	case 0x2000084:
 	case 0x2000086:
+	case 0x3110000:
 		return true;
 	default:
 		return false;
@@ -350,7 +352,7 @@ static int rt722_sdca_interrupt_callback(struct sdw_slave *slave,
 
 	if (status->sdca_cascade && !rt722->disable_irq)
 		mod_delayed_work(system_power_efficient_wq,
-			&rt722->jack_detect_work, msecs_to_jiffies(30));
+			&rt722->jack_detect_work, msecs_to_jiffies(280));
 
 	mutex_unlock(&rt722->disable_irq_lock);
 
diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 42b42903ae9d..691d16ce95a0 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1545,8 +1545,8 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(comp->card->dev);
 	size_t len = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
-	char buf[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int ssp_port, tdm_slot;
+	char *buf;
 
 	/* See parse_link_formatted_string() for dynamic naming when(s). */
 	if (!avs_mach_singular_ssp(mach))
@@ -1557,13 +1557,24 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
 		return 0;
 	tdm_slot = avs_mach_ssp_tdm(mach, ssp_port);
 
+	buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 	avs_ssp_sprint(buf, len, route->source, ssp_port, tdm_slot);
-	strscpy((char *)route->source, buf, len);
+	route->source = buf;
+
+	buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 	avs_ssp_sprint(buf, len, route->sink, ssp_port, tdm_slot);
-	strscpy((char *)route->sink, buf, len);
+	route->sink = buf;
+
 	if (route->control) {
+		buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 		avs_ssp_sprint(buf, len, route->control, ssp_port, tdm_slot);
-		strscpy((char *)route->control, buf, len);
+		route->control = buf;
 	}
 
 	return 0;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b41a1147f1c3..a64d1989e28a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -610,6 +610,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 CESIUM"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 092ca09f3631..7fa75b55c65e 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -318,6 +318,12 @@ static int dmaengine_copy(struct snd_soc_component *component,
 	return 0;
 }
 
+static int dmaengine_pcm_sync_stop(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_sync_stop(substream);
+}
+
 static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
@@ -327,6 +333,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
+	.sync_stop	= dmaengine_pcm_sync_stop,
 };
 
 static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
@@ -339,6 +346,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.pointer	= dmaengine_pcm_pointer,
 	.copy		= dmaengine_copy,
 	.pcm_construct	= dmaengine_pcm_new,
+	.sync_stop	= dmaengine_pcm_sync_stop,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ba4890991f0d..ce22613bf969 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1060,15 +1060,28 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = elem->source;
-		route->sink = elem->sink;
+		route->source = devm_kmemdup(tplg->dev, elem->source,
+					     min(strlen(elem->source),
+						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     GFP_KERNEL);
+		route->sink = devm_kmemdup(tplg->dev, elem->sink,
+					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   GFP_KERNEL);
+		if (!route->source || !route->sink) {
+			ret = -ENOMEM;
+			break;
+		}
 
-		/* set to NULL atm for tplg users */
-		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
-			route->control = NULL;
-		else
-			route->control = elem->control;
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
+			route->control = devm_kmemdup(tplg->dev, elem->control,
+						      min(strlen(elem->control),
+							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      GFP_KERNEL);
+			if (!route->control) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 
 		/* add route dobj to dobj_list */
 		route->dobj.type = SND_SOC_DOBJ_GRAPH;
diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index d7b446f3f973..8b5fbbc777bd 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -254,6 +254,12 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
+	/* Limit the maximum number of periods to not exceed the BDL entries count */
+	if (runtime->hw.periods_max > HDA_DSP_MAX_BDL_ENTRIES)
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIODS,
+					     runtime->hw.periods_min,
+					     HDA_DSP_MAX_BDL_ENTRIES);
+
 	/* Only S16 and S32 supported by HDA hardware when used without DSP */
 	if (sdev->dspless_mode_selected)
 		snd_pcm_hw_constraint_mask64(substream->runtime, SNDRV_PCM_HW_PARAM_FORMAT,
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e693dcb475e4..d1a7d867f6a3 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -485,7 +485,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
 			if (ret < 0) {
 				/* unprepare the source widget */
 				if (widget_ops[widget->id].ipc_unprepare &&
-				    swidget && swidget->prepared) {
+				    swidget && swidget->prepared && swidget->use_count == 0) {
 					widget_ops[widget->id].ipc_unprepare(swidget);
 					swidget->prepared = false;
 				}
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 1e760c315521..2b1ed91a736c 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1472,10 +1472,11 @@ static int davinci_mcasp_hw_rule_min_periodsize(
 {
 	struct snd_interval *period_size = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	u8 numevt = *((u8 *)rule->private);
 	struct snd_interval frames;
 
 	snd_interval_any(&frames);
-	frames.min = 64;
+	frames.min = numevt;
 	frames.integer = 1;
 
 	return snd_interval_refine(period_size, &frames);
@@ -1490,6 +1491,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	u32 max_channels = 0;
 	int i, dir, ret;
 	int tdm_slots = mcasp->tdm_slots;
+	u8 *numevt;
 
 	/* Do not allow more then one stream per direction */
 	if (mcasp->substreams[substream->stream])
@@ -1589,9 +1591,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			 &mcasp->txnumevt :
+			 &mcasp->rxnumevt;
 	snd_pcm_hw_rule_add(substream->runtime, 0,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    davinci_mcasp_hw_rule_min_periodsize, numevt,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 
 	return 0;
diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index 4513b527ab97..ad8925b6481c 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -354,11 +354,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
-	card->name = devm_kasprintf(dev, GFP_KERNEL,
-				    "HDMI %s", dev_name(ad->dssdev));
-	if (!card->name)
-		return -ENOMEM;
-
+	card->name = "HDMI";
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index c519cc89c97f..0a56e22240fc 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -41,6 +41,16 @@ union core_pstate {
 		unsigned res1:31;
 		unsigned en:1;
 	} pstatedef;
+	/* since fam 1Ah: */
+	struct {
+		unsigned fid:12;
+		unsigned res1:2;
+		unsigned vid:8;
+		unsigned iddval:8;
+		unsigned idddiv:2;
+		unsigned res2:31;
+		unsigned en:1;
+	} pstatedef2;
 	unsigned long long val;
 };
 
@@ -48,6 +58,10 @@ static int get_did(union core_pstate pstate)
 {
 	int t;
 
+	/* Fam 1Ah onward do not use did */
+	if (cpupower_cpu_info.family >= 0x1A)
+		return 0;
+
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
 		t = pstate.pstatedef.did;
 	else if (cpupower_cpu_info.family == 0x12)
@@ -61,12 +75,18 @@ static int get_did(union core_pstate pstate)
 static int get_cof(union core_pstate pstate)
 {
 	int t;
-	int fid, did, cof;
+	int fid, did, cof = 0;
 
 	did = get_did(pstate);
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
-		fid = pstate.pstatedef.fid;
-		cof = 200 * fid / did;
+		if (cpupower_cpu_info.family >= 0x1A) {
+			fid = pstate.pstatedef2.fid;
+			if (fid > 0x0f)
+				cof = (fid * 5);
+		} else {
+			fid = pstate.pstatedef.fid;
+			cof = 200 * fid / did;
+		}
 	} else {
 		t = 0x10;
 		fid = pstate.pstate.fid;
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 01f241ea2c67..dec9fd7ebba7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,9 +53,12 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_NET_ACT_SKBMOD=y
+CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_CLS_MATCHALL=y
 CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NET_IPGRE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index bc9841144685..1af9ec1149aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -9,6 +9,8 @@
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 #include "test_tc_link.skel.h"
+
+#include "netlink_helpers.h"
 #include "tc_helpers.h"
 
 void serial_test_tc_links_basic(void)
@@ -1787,6 +1789,65 @@ void serial_test_tc_links_ingress(void)
 	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
 }
 
+struct qdisc_req {
+	struct nlmsghdr  n;
+	struct tcmsg     t;
+	char             buf[1024];
+};
+
+static int qdisc_replace(int ifindex, const char *kind, bool block)
+{
+	struct rtnl_handle rth = { .fd = -1 };
+	struct qdisc_req req;
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
+	req.n.nlmsg_flags = NLM_F_CREATE | NLM_F_REPLACE | NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_NEWQDISC;
+	req.t.tcm_family = AF_UNSPEC;
+	req.t.tcm_ifindex = ifindex;
+	req.t.tcm_parent = 0xfffffff1;
+
+	addattr_l(&req.n, sizeof(req), TCA_KIND, kind, strlen(kind) + 1);
+	if (block)
+		addattr32(&req.n, sizeof(req), TCA_INGRESS_BLOCK, 1);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	return err;
+}
+
+void serial_test_tc_links_dev_chain0(void)
+{
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev foo type veth peer name bar"), "add veth");
+	ifindex = if_nametoindex("foo");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+	err = qdisc_replace(ifindex, "ingress", true);
+	if (!ASSERT_OK(err, "attaching ingress"))
+		goto cleanup;
+	ASSERT_OK(system("tc filter add block 1 matchall action skbmod swap mac"), "add block");
+	err = qdisc_replace(ifindex, "clsact", false);
+	if (!ASSERT_OK(err, "attaching clsact"))
+		goto cleanup;
+	/* Heuristic: kern_sync_rcu() alone does not work; a wait-time of ~5s
+	 * triggered the issue without the fix reliably 100% of the time.
+	 */
+	sleep(5);
+	ASSERT_OK(system("tc filter add dev foo ingress matchall action skbmod swap mac"), "add filter");
+cleanup:
+	ASSERT_OK(system("ip link del dev foo"), "del veth");
+	ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
+	ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
+}
+
 static void test_tc_links_dev_mixed(int target)
 {
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..632ab44737ec 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <stdio.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263..2862aae58b79 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <inttypes.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..994fa3468f17 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5e0e539a323d..8b120718768e 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -531,7 +531,7 @@ class ovsactions(nla):
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
                     actstr = actstr[len(flat_act[0]):]
-                    self["attrs"].append([flat_act[1]])
+                    self["attrs"].append([flat_act[1], True])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b2..5790ab446527 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..d12ff955de0d 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..5b939f59dfa4 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..a4196bbd6e33 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..5b8907bf451d 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -32,7 +32,7 @@ static void *tcheck(void *_args)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+		if (labs(tst.tv_sec - now->tv_sec) > 5) {
 			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
 				args->tst_name, tst.tv_sec, now->tv_sec);
 			return (void *)1UL;
@@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5)
+		if (labs(tst.tv_sec - now->tv_sec) > 5)
 			return pr_fail("%s: unexpected value: %ld (%ld)\n",
 					tst_name, tst.tv_sec, now->tv_sec);
 	}
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..4ae417372e9e 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -55,14 +55,20 @@ static struct vdso_info
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 8a44ff973ee1..27f6fdf11969 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -18,7 +18,7 @@
 
 #include "parse_vdso.h"
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
 	return 0;
 }
 
+/*
+ * The clang build needs this, although gcc does not.
+ * Stolen from lib/string.c.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
 /* ...and two syscalls.  This is x86-specific. */
 static inline long x86_syscall3(long nr, long a0, long a1, long a2)
 {
@@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;

