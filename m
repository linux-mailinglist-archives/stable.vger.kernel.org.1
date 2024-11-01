Return-Path: <stable+bounces-89462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D39B8862
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A23282930
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF552F88;
	Fri,  1 Nov 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTONAg4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C623CF73;
	Fri,  1 Nov 2024 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424404; cv=none; b=rLYmewPq5RNgB6PBY8rBk/6HzmYzEwWFcFk47opyfzvaHOjtVWli4JwEtUH9fZwd4jvypbTMJAZh7+jKRD94q6Nf1Jjc3QzhROY9oPEHP8FZ3nGI2ABxZmfb9bx8SJszePNgPWso2YcaEZ0YAhcco2Fp0M2Zs3kOvZBUAe73D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424404; c=relaxed/simple;
	bh=HITZHM3wj0nzwyZZnjTFFu9B4RqETBiDZRaXGi7yBF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4Qen55UAm1zlbHa/De++zeWU5CCBo8cfvCLieHZbNHKucgTBRgFZKK/PzBS4tS2JYaOlLQ21mljxC12o4Xa9jEaBJY0JBWuVQRNdY0rf0uLFzcmacGXxbaprCCf/UIuA21oMrVga3uTHS8uVeLYQP8NlQCtyCqmWRJN95Y0Q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTONAg4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9880C4CED1;
	Fri,  1 Nov 2024 01:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424403;
	bh=HITZHM3wj0nzwyZZnjTFFu9B4RqETBiDZRaXGi7yBF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTONAg4YBEdeGXD23CXfeo9kYvSRpb03mkwgiYbAsHibmKfQmepFQl2Aucgjfd0BH
	 F+O2/iBNKcXokTTZgK4A2WnqwqvGAql5nBVgIoJ5yWvuiCLXGKx+KYjxSfE0976MeU
	 dterx3QtQMxBBrZtMf1MudOn41AWAScRPG2vLsRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.115
Date: Fri,  1 Nov 2024 02:26:17 +0100
Message-ID: <2024110117-eccentric-drearily-d70b@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110117-wince-enjoyer-47d7@gregkh>
References: <2024110117-wince-enjoyer-47d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
index f46c66bc6b2d..fe02773a490a 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
@@ -102,21 +102,21 @@ properties:
     default: 2
 
   interrupts:
-    anyOf:
-      - minItems: 1
-        items:
-          - description: TX interrupt
-          - description: RX interrupt
-      - items:
-          - description: common/combined interrupt
+    minItems: 1
+    maxItems: 2
 
   interrupt-names:
     oneOf:
-      - minItems: 1
+      - description: TX interrupt
+        const: tx
+      - description: RX interrupt
+        const: rx
+      - description: TX and RX interrupts
         items:
           - const: tx
           - const: rx
-      - const: common
+      - description: Common/combined interrupt
+        const: common
 
   fck_parent:
     $ref: /schemas/types.yaml#/definitions/string
diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
index 64f7236ff10b..870f933e4a1a 100644
--- a/Documentation/networking/driver.rst
+++ b/Documentation/networking/driver.rst
@@ -4,15 +4,19 @@
 Softnet Driver Issues
 =====================
 
-Transmit path guidelines:
+Transmit path guidelines
+========================
 
-1) The ndo_start_xmit method must not return NETDEV_TX_BUSY under
-   any normal circumstances.  It is considered a hard error unless
-   there is no way your device can tell ahead of time when its
-   transmit function will become busy.
+Stop queues in advance
+----------------------
 
-   Instead it must maintain the queue properly.  For example,
-   for a driver implementing scatter-gather this means::
+The ndo_start_xmit method must not return NETDEV_TX_BUSY under
+any normal circumstances.  It is considered a hard error unless
+there is no way your device can tell ahead of time when its
+transmit function will become busy.
+
+Instead it must maintain the queue properly.  For example,
+for a driver implementing scatter-gather this means::
 
 	static netdev_tx_t drv_hard_start_xmit(struct sk_buff *skb,
 					       struct net_device *dev)
@@ -42,56 +46,79 @@ Transmit path guidelines:
 		return NETDEV_TX_OK;
 	}
 
-   And then at the end of your TX reclamation event handling::
+And then at the end of your TX reclamation event handling::
 
 	if (netif_queue_stopped(dp->dev) &&
 	    TX_BUFFS_AVAIL(dp) > (MAX_SKB_FRAGS + 1))
 		netif_wake_queue(dp->dev);
 
-   For a non-scatter-gather supporting card, the three tests simply become::
+For a non-scatter-gather supporting card, the three tests simply become::
 
 		/* This is a hard error log it. */
 		if (TX_BUFFS_AVAIL(dp) <= 0)
 
-   and::
+and::
 
 		if (TX_BUFFS_AVAIL(dp) == 0)
 
-   and::
+and::
 
 	if (netif_queue_stopped(dp->dev) &&
 	    TX_BUFFS_AVAIL(dp) > 0)
 		netif_wake_queue(dp->dev);
 
-2) An ndo_start_xmit method must not modify the shared parts of a
-   cloned SKB.
+Lockless queue stop / wake helper macros
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/net/netdev_queues.h
+   :doc: Lockless queue stopping / waking helpers.
+
+No exclusive ownership
+----------------------
+
+An ndo_start_xmit method must not modify the shared parts of a
+cloned SKB.
+
+Timely completions
+------------------
 
-3) Do not forget that once you return NETDEV_TX_OK from your
-   ndo_start_xmit method, it is your driver's responsibility to free
-   up the SKB and in some finite amount of time.
+Do not forget that once you return NETDEV_TX_OK from your
+ndo_start_xmit method, it is your driver's responsibility to free
+up the SKB and in some finite amount of time.
 
-   For example, this means that it is not allowed for your TX
-   mitigation scheme to let TX packets "hang out" in the TX
-   ring unreclaimed forever if no new TX packets are sent.
-   This error can deadlock sockets waiting for send buffer room
-   to be freed up.
+For example, this means that it is not allowed for your TX
+mitigation scheme to let TX packets "hang out" in the TX
+ring unreclaimed forever if no new TX packets are sent.
+This error can deadlock sockets waiting for send buffer room
+to be freed up.
 
-   If you return NETDEV_TX_BUSY from the ndo_start_xmit method, you
-   must not keep any reference to that SKB and you must not attempt
-   to free it up.
+If you return NETDEV_TX_BUSY from the ndo_start_xmit method, you
+must not keep any reference to that SKB and you must not attempt
+to free it up.
 
-Probing guidelines:
+Probing guidelines
+==================
+
+Address validation
+------------------
+
+Any hardware layer address you obtain for your device should
+be verified.  For example, for ethernet check it with
+linux/etherdevice.h:is_valid_ether_addr()
+
+Close/stop guidelines
+=====================
 
-1) Any hardware layer address you obtain for your device should
-   be verified.  For example, for ethernet check it with
-   linux/etherdevice.h:is_valid_ether_addr()
+Quiescence
+----------
 
-Close/stop guidelines:
+After the ndo_stop routine has been called, the hardware must
+not receive or transmit any data.  All in flight packets must
+be aborted. If necessary, poll or wait for completion of
+any reset commands.
 
-1) After the ndo_stop routine has been called, the hardware must
-   not receive or transmit any data.  All in flight packets must
-   be aborted. If necessary, poll or wait for completion of
-   any reset commands.
+Auto-close
+----------
 
-2) The ndo_stop routine will be called by unregister_netdevice
-   if device is still UP.
+The ndo_stop routine will be called by unregister_netdevice
+if device is still UP.
diff --git a/Makefile b/Makefile
index 23782d82c76f..1982ced2f43a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 114
+SUBLEVEL = 115
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
index cf84e69fced8..4b2f63e0ae7c 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -76,7 +76,7 @@ &gpio {
 };
 
 &hdmi {
-	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index c9496539c335..85a30ebae19f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=--no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X --pic-veneer
 
 ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
index 315eef654e39..014b02897f8e 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -10,21 +10,19 @@
 #include <asm/insn.h>
 #include <asm/probes.h>
 
-#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
-
-#define UPROBE_SWBP_INSN	BRK64_OPCODE_UPROBES
+#define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
 #define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
-#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+#define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE
 
-typedef u32 uprobe_opcode_t;
+typedef __le32 uprobe_opcode_t;
 
 struct arch_uprobe_task {
 };
 
 struct arch_uprobe {
 	union {
-		u8 insn[MAX_UINSN_BYTES];
-		u8 ixol[MAX_UINSN_BYTES];
+		__le32 insn;
+		__le32 ixol;
 	};
 	struct arch_probe_insn api;
 	bool simulate;
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..a2f137a595fc 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 
 	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
@@ -108,7 +108,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	if (!auprobe->simulate)
 		return false;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index de94515fb17c..cf7e10587fb0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -750,6 +750,9 @@ static int kvm_vcpu_suspend(struct kvm_vcpu *vcpu)
 static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 {
 	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+			return -EIO;
+
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
 			kvm_vcpu_sleep(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 39c24e5ea8cd..059d00c17d26 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -494,10 +494,10 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 out:
 	mutex_unlock(&kvm->arch.config_lock);
 out_slots:
-	mutex_unlock(&kvm->slots_lock);
-
 	if (ret)
-		kvm_vgic_destroy(kvm);
+		kvm_vm_dead(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
 
 	return ret;
 }
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fa3171f56327..f4ba3638b76a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -78,6 +78,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index ed0910e8b856..e703615ca706 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -25,6 +25,10 @@ struct loongson_board_info {
 	const char *board_vendor;
 };
 
+/*
+ * The "core" of cores_per_node and cores_per_package stands for a
+ * logical core, which means in a SMT system it stands for a thread.
+ */
 struct loongson_system_configuration {
 	int nr_cpus;
 	int nr_nodes;
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 53f284a96182..bbac81dd7378 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -81,6 +81,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 #ifdef CONFIG_FLATMEM
 
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 7b2cd37641e2..89e6b222c2f2 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,9 +91,16 @@ static inline bool loongarch_vdso_hres_capable(void)
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return get_vdso_data();
+	return (const struct vdso_data *)get_vdso_data();
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return (const struct vdso_data *)(get_vdso_data() + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE);
+}
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 3b55d32a0619..5a12309d9fb5 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -16,10 +16,33 @@ struct vdso_pcpu_data {
 
 struct loongarch_vdso_data {
 	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_data data[CS_BASES]; /* Arch-independent data */
 };
 
-#define VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+/*
+ * The layout of vvar:
+ *
+ *                      high
+ * +---------------------+--------------------------+
+ * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
+ * +---------------------+--------------------------+
+ * |  time-ns vdso data  |        PAGE_SIZE         |
+ * +---------------------+--------------------------+
+ * |  generic vdso data  |        PAGE_SIZE         |
+ * +---------------------+--------------------------+
+ *                      low
+ */
+#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
+
+enum vvar_pages {
+	VVAR_GENERIC_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_LOONGARCH_PAGES_START,
+	VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DATA_PAGES - 1,
+	VVAR_NR_PAGES,
+};
+
+#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
 
 static inline unsigned long get_vdso_base(void)
 {
@@ -34,10 +57,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const struct vdso_data *get_vdso_data(void)
+static inline unsigned long get_vdso_data(void)
 {
-	return (const struct vdso_data *)(get_vdso_base()
-			- VDSO_DATA_SIZE + SMP_CACHE_BYTES * NR_CPUS);
+	return get_vdso_base() - VVAR_SIZE;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 1259bc312979..4561bc81c063 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -271,13 +271,15 @@ unsigned long stack_top(void)
 {
 	unsigned long top = TASK_SIZE & PAGE_MASK;
 
-	/* Space for the VDSO & data page */
-	top -= PAGE_ALIGN(current->thread.vdso->size);
-	top -= PAGE_SIZE;
-
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
+	if (current->thread.vdso) {
+		/* Space for the VDSO & data page */
+		top -= PAGE_ALIGN(current->thread.vdso->size);
+		top -= VVAR_SIZE;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	return top;
 }
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index ae436def7ee9..b00e885d9845 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -49,6 +49,7 @@
 #define SMBIOS_FREQHIGH_OFFSET		0x17
 #define SMBIOS_FREQLOW_MASK		0xFF
 #define SMBIOS_CORE_PACKAGE_OFFSET	0x23
+#define SMBIOS_THREAD_PACKAGE_OFFSET	0x25
 #define LOONGSON_EFI_ENABLE		(1 << 3)
 
 struct screen_info screen_info __section(".data");
@@ -115,7 +116,7 @@ static void __init parse_cpu_table(const struct dmi_header *dm)
 	cpu_clock_freq = freq_temp * 1000000;
 
 	loongson_sysconf.cpuname = (void *)dmi_string_parse(dm, dmi_data[16]);
-	loongson_sysconf.cores_per_package = *(dmi_data + SMBIOS_CORE_PACKAGE_OFFSET);
+	loongson_sysconf.cores_per_package = *(dmi_data + SMBIOS_THREAD_PACKAGE_OFFSET);
 
 	pr_info("CpuClock = %llu\n", cpu_clock_freq);
 }
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 8c9826062652..59aa9dd466e8 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/page.h>
@@ -26,12 +27,17 @@ extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
 static union {
-	u8 page[VDSO_DATA_SIZE];
+	u8 page[PAGE_SIZE];
+	struct vdso_data data[CS_BASES];
+} generic_vdso_data __page_aligned_data;
+
+static union {
+	u8 page[LOONGARCH_VDSO_DATA_SIZE];
 	struct loongarch_vdso_data vdata;
 } loongarch_vdso_data __page_aligned_data;
 
 static struct page *vdso_pages[] = { NULL };
-struct vdso_data *vdso_data = loongarch_vdso_data.vdata.data;
+struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
@@ -41,6 +47,43 @@ static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struc
 	return 0;
 }
 
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	unsigned long pfn;
+	struct page *timens_page = find_timens_vvar_page(vma);
+
+	switch (vmf->pgoff) {
+	case VVAR_GENERIC_PAGE_OFFSET:
+		if (!timens_page)
+			pfn = sym_to_pfn(vdso_data);
+		else
+			pfn = page_to_pfn(timens_page);
+		break;
+#ifdef CONFIG_TIME_NS
+	case VVAR_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace specific
+		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
+		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+		else
+			pfn = sym_to_pfn(vdso_data);
+		break;
+#endif /* CONFIG_TIME_NS */
+	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
+		pfn = sym_to_pfn(&loongarch_vdso_data) + vmf->pgoff - VVAR_LOONGARCH_PAGES_START;
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
 	.size = PAGE_SIZE,
@@ -51,6 +94,7 @@ struct loongarch_vdso_info vdso_info = {
 	},
 	.data_mapping = {
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	.offset_sigreturn = vdso_offset_sigreturn,
 };
@@ -73,6 +117,37 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_TIME_NS
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page);
+}
+
+/*
+ * The vvar mapping contains data for a specific time namespace, so when a
+ * task changes namespace we must unmap its vvar data for the old namespace.
+ * Subsequent faults will map in data for the new namespace.
+ *
+ * For more details see timens_setup_vdso_data().
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+#endif
+
 static unsigned long vdso_base(void)
 {
 	unsigned long base = STACK_TOP;
@@ -88,7 +163,7 @@ static unsigned long vdso_base(void)
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	int ret;
-	unsigned long vvar_size, size, data_addr, vdso_addr;
+	unsigned long size, data_addr, vdso_addr;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct loongarch_vdso_info *info = current->thread.vdso;
@@ -100,32 +175,23 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * Determine total area size. This includes the VDSO data itself
 	 * and the data pages.
 	 */
-	vvar_size = VDSO_DATA_SIZE;
-	size = vvar_size + info->size;
+	size = VVAR_SIZE + info->size;
 
 	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(data_addr)) {
 		ret = data_addr;
 		goto out;
 	}
-	vdso_addr = data_addr + VDSO_DATA_SIZE;
 
-	vma = _install_special_mapping(mm, data_addr, vvar_size,
-				       VM_READ | VM_MAYREAD,
+	vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
+				       VM_READ | VM_MAYREAD | VM_PFNMAP,
 				       &info->data_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
 	}
 
-	/* Map VDSO data page. */
-	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
-			      vvar_size, PAGE_READONLY);
-	if (ret)
-		goto out;
-
-	/* Map VDSO code page. */
+	vdso_addr = data_addr + VVAR_SIZE;
 	vma = _install_special_mapping(mm, vdso_addr, info->size,
 				       VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 				       &info->code_mapping);
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index e02e775f5360..9e445be39763 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,7 @@ static __always_inline int read_cpu_id(void)
 
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
+	return (struct vdso_pcpu_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_START * PAGE_SIZE);
 }
 
 extern
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 4c4ac563326b..66ee5f00ec54 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -542,8 +542,8 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
 		jmp_offset = ninsns_rvoff(8);
 		emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
-		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 0) :
-		     rv_sc_w(RV_REG_T3, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 1) :
+		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
 		jmp_offset = ninsns_rvoff(-6);
 		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
 		emit(rv_fence(0x3, 0x3), ctx);
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index b9da71632827..ea340b901839 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -75,6 +75,7 @@ struct perf_sf_sde_regs {
 #define SAMPLE_FREQ_MODE(hwc)	(SAMPL_FLAGS(hwc) & PERF_CPUM_SF_FREQ_MODE)
 
 #define perf_arch_fetch_caller_regs(regs, __ip) do {			\
+	(regs)->psw.mask = 0;						\
 	(regs)->psw.addr = (__ip);					\
 	(regs)->gprs[15] = (unsigned long)__builtin_frame_address(0) -	\
 		offsetof(struct stack_frame, back_chain);		\
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b9324ca2eb94..b3961f1016ea 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -272,18 +272,19 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 		goto no_pdev;
 
 	switch (ccdf->pec) {
-	case 0x003a: /* Service Action or Error Recovery Successful */
+	case 0x002a: /* Error event concerns FMB */
+	case 0x002b:
+	case 0x002c:
+		break;
+	case 0x0040: /* Service Action or Error Recovery Failed */
+	case 0x003b:
+		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
+		break;
+	default: /* PCI function left in the error state attempt to recover */
 		ers_res = zpci_event_attempt_error_recovery(pdev);
 		if (ers_res != PCI_ERS_RESULT_RECOVERED)
 			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
 		break;
-	default:
-		/*
-		 * Mark as frozen not permanently failed because the device
-		 * could be subsequently recovered by the platform.
-		 */
-		zpci_event_io_failure(pdev, pci_channel_io_frozen);
-		break;
 	}
 	pci_dev_put(pdev);
 no_pdev:
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 84f23327caed..d2cb96738ff6 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -27,10 +27,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -40,16 +40,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -63,7 +68,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5d4d78c9a787..974f30d38c79 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -62,8 +62,12 @@ static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
 	u64 pdpte;
 	int ret;
 
+	/*
+	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
+	 * nCR3[4:0] when loading PDPTEs from memory.
+	 */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
-				       offset_in_page(cr3) + index * 8, 8);
+				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
 	if (ret)
 		return 0;
 	return pdpte;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index bfce6343a577..8e797782cfe3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3117,10 +3117,12 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void
-bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
-		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
+static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
+					 struct bfq_io_cq *bic,
+					 struct bfq_queue *bfqq)
 {
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+
 	bfq_log_bfqq(bfqd, bfqq, "merging with queue %lu",
 		(unsigned long)new_bfqq->pid);
 	/* Save weight raising and idle window of the merged queues */
@@ -3214,6 +3216,8 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	bfq_reassign_last_bfqq(bfqq, new_bfqq);
 
 	bfq_release_process_ref(bfqd, bfqq);
+
+	return new_bfqq;
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -3249,14 +3253,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 		 * fulfilled, i.e., bic can be redirected to new_bfqq
 		 * and bfqq can be put.
 		 */
-		bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq,
-				new_bfqq);
-		/*
-		 * If we get here, bio will be queued into new_queue,
-		 * so use new_bfqq to decide whether bio and rq can be
-		 * merged.
-		 */
-		bfqq = new_bfqq;
+		while (bfqq != new_bfqq)
+			bfqq = bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq);
 
 		/*
 		 * Change also bqfd->bio_bfqq, as
@@ -5616,9 +5614,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * state before killing it.
 	 */
 	bfqq->bic = bic;
-	bfq_merge_bfqqs(bfqd, bic, bfqq, new_bfqq);
-
-	return new_bfqq;
+	return bfq_merge_bfqqs(bfqd, bic, bfqq);
 }
 
 /*
@@ -6066,6 +6062,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
+		struct bfq_queue *old_bfqq = bfqq;
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
@@ -6081,18 +6078,18 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * then complete the merge and redirect it to
 		 * new_bfqq.
 		 */
-		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq)
-			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
-					bfqq, new_bfqq);
+		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq) {
+			while (bfqq != new_bfqq)
+				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
+		}
 
-		bfq_clear_bfqq_just_created(bfqq);
+		bfq_clear_bfqq_just_created(old_bfqq);
 		/*
 		 * rq is about to be enqueued into new_bfqq,
 		 * release rq reference on bfqq
 		 */
-		bfq_put_queue(bfqq);
+		bfq_put_queue(old_bfqq);
 		rq->elv.priv[1] = new_bfqq;
-		bfqq = new_bfqq;
 	}
 
 	bfq_update_io_thinktime(bfqd, bfqq);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1f9b9a4c38c7..000a7a7e5d49 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -121,6 +121,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Samsung galaxybook2 ,initial _LID device notification returns
+		 * lid closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 12296d85a719..3d9326172af4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,9 @@
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/topology.h>
+#include <linux/dmi.h>
+#include <linux/units.h>
+#include <asm/unaligned.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -1664,3 +1667,116 @@ unsigned int cppc_get_transition_latency(int cpu_num)
 	return latency_ns;
 }
 EXPORT_SYMBOL_GPL(cppc_get_transition_latency);
+
+/* Minimum struct length needed for the DMI processor entry we want */
+#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
+
+/* Offset in the DMI processor structure for the max frequency */
+#define DMI_PROCESSOR_MAX_SPEED		0x14
+
+/* Callback function used to retrieve the max frequency from DMI */
+static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	u16 *mhz = (u16 *)private;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR &&
+	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
+		u16 val = (u16)get_unaligned((const u16 *)
+				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
+		*mhz = val > *mhz ? val : *mhz;
+	}
+}
+
+/* Look up the max frequency in DMI */
+static u64 cppc_get_dmi_max_khz(void)
+{
+	u16 mhz = 0;
+
+	dmi_walk(cppc_find_dmi_mhz, &mhz);
+
+	/*
+	 * Real stupid fallback value, just in case there is no
+	 * actual value set.
+	 */
+	mhz = mhz ? mhz : 1;
+
+	return KHZ_PER_MHZ * mhz;
+}
+
+/*
+ * If CPPC lowest_freq and nominal_freq registers are exposed then we can
+ * use them to convert perf to freq and vice versa. The conversion is
+ * extrapolated as an affine function passing by the 2 points:
+ *  - (Low perf, Low freq)
+ *  - (Nominal perf, Nominal freq)
+ */
+unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64 mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		/* Avoid special case when nominal_freq is equal to lowest_freq */
+		if (caps->lowest_freq == caps->nominal_freq) {
+			mul = caps->nominal_freq;
+			div = caps->nominal_perf;
+		} else {
+			mul = caps->nominal_freq - caps->lowest_freq;
+			div = caps->nominal_perf - caps->lowest_perf;
+		}
+		mul *= KHZ_PER_MHZ;
+		offset = caps->nominal_freq * KHZ_PER_MHZ -
+			 div64_u64(caps->nominal_perf * mul, div);
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = max_khz;
+		div = caps->highest_perf;
+	}
+
+	retval = offset + div64_u64(perf * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_to_khz);
+
+unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64 mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		/* Avoid special case when nominal_freq is equal to lowest_freq */
+		if (caps->lowest_freq == caps->nominal_freq) {
+			mul = caps->nominal_perf;
+			div = caps->nominal_freq;
+		} else {
+			mul = caps->nominal_perf - caps->lowest_perf;
+			div = caps->nominal_freq - caps->lowest_freq;
+		}
+		/*
+		 * We don't need to convert to kHz for computing offset and can
+		 * directly use nominal_freq and lowest_freq as the div64_u64
+		 * will remove the frequency unit.
+		 */
+		offset = caps->nominal_perf -
+			 div64_u64(caps->nominal_freq * mul, div);
+		/* But we need it for computing the perf level. */
+		div *= KHZ_PER_MHZ;
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = caps->highest_perf;
+		div = max_khz;
+	}
+
+	retval = offset + div64_u64(freq * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_khz_to_perf);
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 3d4c4620f9f9..dd0261fd12d6 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -52,7 +52,7 @@ struct prm_context_buffer {
 static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
-	guid_t guid;
+	efi_guid_t guid;
 	void *handler_addr;
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
@@ -72,17 +72,21 @@ struct prm_module_info {
 	struct prm_handler_info handlers[];
 };
 
-static u64 efi_pa_va_lookup(u64 pa)
+static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+
 	return 0;
 }
 
@@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
-		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
-		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		th->handler_addr =
+			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+
+		th->static_data_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+
+		th->acpi_param_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -253,6 +263,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
+		if (!handler->handler_addr ||
+		    !handler->static_data_buffer_addr ||
+		    !handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
+
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
 		context.reserved = 0x0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 059354382a39..d57bc814dec4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -502,6 +502,13 @@ static const struct dmi_system_id tongfang_gm_rg[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
+	{
+		/* LG Electronics 16T90SP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8791a88c7741..0050242d382e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/dmi.h>
 #include <linux/irq_work.h>
 #include <linux/kthread.h>
 #include <linux/time.h>
@@ -27,12 +26,6 @@
 
 #include <acpi/cppc_acpi.h>
 
-/* Minimum struct length needed for the DMI processor entry we want */
-#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
-
-/* Offset in the DMI processor structure for the max frequency */
-#define DMI_PROCESSOR_MAX_SPEED		0x14
-
 /*
  * This list contains information parsed from per CPU ACPI _CPC and _PSD
  * structures: e.g. the highest and lowest supported performance, capabilities,
@@ -288,97 +281,9 @@ static inline void cppc_freq_invariance_exit(void)
 }
 #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
 
-/* Callback function used to retrieve the max frequency from DMI */
-static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
-{
-	const u8 *dmi_data = (const u8 *)dm;
-	u16 *mhz = (u16 *)private;
-
-	if (dm->type == DMI_ENTRY_PROCESSOR &&
-	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
-		u16 val = (u16)get_unaligned((const u16 *)
-				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
-		*mhz = val > *mhz ? val : *mhz;
-	}
-}
-
-/* Look up the max frequency in DMI */
-static u64 cppc_get_dmi_max_khz(void)
-{
-	u16 mhz = 0;
-
-	dmi_walk(cppc_find_dmi_mhz, &mhz);
-
-	/*
-	 * Real stupid fallback value, just in case there is no
-	 * actual value set.
-	 */
-	mhz = mhz ? mhz : 1;
-
-	return (1000 * mhz);
-}
-
-/*
- * If CPPC lowest_freq and nominal_freq registers are exposed then we can
- * use them to convert perf to freq and vice versa. The conversion is
- * extrapolated as an affine function passing by the 2 points:
- *  - (Low perf, Low freq)
- *  - (Nominal perf, Nominal perf)
- */
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
-					     unsigned int perf)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64 mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_freq - caps->lowest_freq;
-		div = caps->nominal_perf - caps->lowest_perf;
-		offset = caps->nominal_freq - div64_u64(caps->nominal_perf * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = max_khz;
-		div = caps->highest_perf;
-	}
-
-	retval = offset + div64_u64(perf * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
-static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
-					     unsigned int freq)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64  mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_perf - caps->lowest_perf;
-		div = caps->nominal_freq - caps->lowest_freq;
-		offset = caps->nominal_perf - div64_u64(caps->nominal_freq * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = caps->highest_perf;
-		div = max_khz;
-	}
-
-	retval = offset + div64_u64(freq * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
-
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
@@ -386,7 +291,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret = 0;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	/* Return if it is exactly the same perf */
 	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
 		return ret;
@@ -414,7 +319,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 
@@ -527,7 +432,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	min_step = min_cap / CPPC_EM_CAP_STEP;
 	max_step = max_cap / CPPC_EM_CAP_STEP;
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, *KHz);
 	step = perf_prev / perf_step;
 
 	if (step > max_step)
@@ -547,8 +452,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 			perf = step * perf_step;
 	}
 
-	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	*KHz = cppc_perf_to_khz(perf_caps, perf);
+	perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 	step_check = perf_check / perf_step;
 
 	/*
@@ -558,8 +463,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	 */
 	while ((*KHz == prev_freq) || (step_check != step)) {
 		perf++;
-		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+		*KHz = cppc_perf_to_khz(perf_caps, perf);
+		perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 		step_check = perf_check / perf_step;
 	}
 
@@ -588,7 +493,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, KHz);
 	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
 	step = perf_prev / perf_step;
 
@@ -676,10 +581,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
-	/* Convert the lowest and nominal freq from MHz to KHz */
-	cpu_data->perf_caps.lowest_freq *= 1000;
-	cpu_data->perf_caps.nominal_freq *= 1000;
-
 	list_add(&cpu_data->node, &cpu_data_list);
 
 	return cpu_data;
@@ -721,20 +622,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->nominal_perf);
+	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
+	policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
-	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->nominal_perf);
+	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -770,7 +667,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_perf);
+	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -865,7 +762,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
@@ -880,11 +777,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	}
 
 	if (state)
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->highest_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->nominal_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
@@ -944,7 +839,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret < 0)
 		return -EIO;
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
 }
 
 static void cppc_check_hisi_workaround(void)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index e32bd990800d..d967fba2e85e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -107,6 +107,7 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
+	union acpi_object *obj;
 	union acpi_object atif_arg_elements[2];
 	struct acpi_object_list atif_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -129,16 +130,24 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 
 	status = acpi_evaluate_object(atif->handle, NULL, &atif_arg,
 				      &buffer);
+	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail only if calling the method fails and ATIF is supported */
+	/* Fail if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
-		kfree(buffer.pointer);
+		kfree(obj);
 		return NULL;
 	}
 
-	return buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		DRM_DEBUG_DRIVER("bad object returned from ATIF: %d\n",
+				 obj->type);
+		kfree(obj);
+		return NULL;
+	}
+
+	return obj;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9a4cbfbd5d9e..3feb792c210d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1038,8 +1038,10 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 
 	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
+	if (r) {
+		amdgpu_mes_unlock(&adev->mes);
 		goto clean_up_memory;
+	}
 
 	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
 
@@ -1072,7 +1074,6 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	amdgpu_ring_fini(ring);
 clean_up_memory:
 	kfree(ring);
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 67287ad07226..e83ad362e06f 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -818,6 +818,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1bf41a82cd0f..ba8f2ba04629 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1106,21 +1106,20 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 
-		if (!dpu_enc->hw_pp[i]) {
+		phys->hw_pp = dpu_enc->hw_pp[i];
+		if (!phys->hw_pp) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no pp block assigned at idx: %d\n", i);
 			return;
 		}
 
-		if (!hw_ctl[i]) {
+		phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
+		if (!phys->hw_ctl) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no ctl block assigned at idx: %d\n", i);
 			return;
 		}
 
-		phys->hw_pp = dpu_enc->hw_pp[i];
-		phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[i]);
-
 		phys->cached_mode = crtc_state->adjusted_mode;
 		if (phys->ops.atomic_mode_set)
 			phys->ops.atomic_mode_set(phys, crtc_state, conn_state);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index ce58d97818bc..e05c3ccf07f8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -61,6 +61,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_CMD;
 	intf_cfg.stream_sel = cmd_enc->stream_sel;
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
+	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
 	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
 
 	/* setup which pp blk will connect to this intf */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 2baade1cd487..aba2488c32fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -276,7 +276,8 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_VID;
 	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
-	if (phys_enc->hw_pp->merge_3d)
+	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
+	if (intf_cfg.mode_3d && phys_enc->hw_pp->merge_3d)
 		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
 
 	spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index add72bbc28b1..4d55e3cf570f 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -26,7 +26,7 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	end_addr = base_addr + aligned_len;
 
 	if (!(*reg))
-		*reg = kzalloc(len_padded, GFP_KERNEL);
+		*reg = kvzalloc(len_padded, GFP_KERNEL);
 
 	if (*reg)
 		dump_addr = *reg;
@@ -48,20 +48,21 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	}
 }
 
-static void msm_disp_state_print_regs(u32 **reg, u32 len, void __iomem *base_addr,
-		struct drm_printer *p)
+static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
+		void __iomem *base_addr, struct drm_printer *p)
 {
 	int i;
-	u32 *dump_addr = NULL;
 	void __iomem *addr;
 	u32 num_rows;
 
+	if (!dump_addr) {
+		drm_printf(p, "Registers not stored\n");
+		return;
+	}
+
 	addr = base_addr;
 	num_rows = len / REG_DUMP_ALIGN;
 
-	if (*reg)
-		dump_addr = *reg;
-
 	for (i = 0; i < num_rows; i++) {
 		drm_printf(p, "0x%lx : %08x %08x %08x %08x\n",
 				(unsigned long)(addr - base_addr),
@@ -89,7 +90,7 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
 
 	list_for_each_entry_safe(block, tmp, &state->blocks, node) {
 		drm_printf(p, "====================%s================\n", block->name);
-		msm_disp_state_print_regs(&block->state, block->size, block->base_addr, p);
+		msm_disp_state_print_regs(block->state, block->size, block->base_addr, p);
 	}
 
 	drm_printf(p, "===================dpu drm state================\n");
@@ -161,7 +162,7 @@ void msm_disp_state_free(void *data)
 
 	list_for_each_entry_safe(block, tmp, &disp_state->blocks, node) {
 		list_del(&block->node);
-		kfree(block->state);
+		kvfree(block->state);
 		kfree(block);
 	}
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 034ad810fd65..88843505d89c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -576,7 +576,7 @@ static unsigned long dsi_get_pclk_rate(struct msm_dsi_host *msm_host, bool is_bo
 	struct drm_display_mode *mode = msm_host->mode;
 	unsigned long pclk_rate;
 
-	pclk_rate = mode->clock * 1000;
+	pclk_rate = mode->clock * 1000u;
 
 	/*
 	 * For bonded DSI mode, the current DRM mode has the complete width of the
diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
index 8c041d7ce4f1..87dccaecc3e5 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
@@ -139,7 +139,15 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 		flags |= VBOX_MOUSE_POINTER_VISIBLE;
 	}
 
-	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len, HGSMI_CH_VBVA,
+	/*
+	 * The 4 extra bytes come from switching struct vbva_mouse_pointer_shape
+	 * from having a 4 bytes fixed array at the end to using a proper VLA
+	 * at the end. These 4 extra bytes were not subtracted from sizeof(*p)
+	 * before the switch to the VLA, so this way the behavior is unchanged.
+	 * Chances are these 4 extra bytes are not necessary but they are kept
+	 * to avoid regressions.
+	 */
+	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len + 4, HGSMI_CH_VBVA,
 			       VBVA_MOUSE_POINTER_SHAPE);
 	if (!p)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
index f60d82504da0..79ec8481de0e 100644
--- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
+++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
@@ -351,10 +351,8 @@ struct vbva_mouse_pointer_shape {
 	 * Bytes in the gap between the AND and the XOR mask are undefined.
 	 * XOR mask scanlines have no gap between them and size of XOR mask is:
 	 * xor_len = width * 4 * height.
-	 *
-	 * Preallocate 4 bytes for accessing actual data as p->data.
 	 */
-	u8 data[4];
+	u8 data[];
 } __packed;
 
 /* pointer is visible */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index e98fde90f4e0..2f775679a507 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1028,6 +1028,10 @@ static int vmw_stdu_connector_atomic_check(struct drm_connector *conn,
 	struct drm_crtc_state *new_crtc_state;
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
+
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
+
 	du = vmw_connector_to_stdu(conn);
 
 	if (!conn_state->crtc)
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 6e4d10a7cd32..4d91747b2027 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1245,7 +1245,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
 static int bma400_tap_event_en(struct bma400_data *data,
 			       enum iio_event_direction dir, int state)
 {
-	unsigned int mask, field_value;
+	unsigned int mask;
+	unsigned int field_value = 0;
 	int ret;
 
 	/*
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index f3702f36436c..023997786ce0 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -71,25 +71,26 @@ config ADMV1014
 	  module will be called admv1014.
 
 config ADMV4420
-       tristate "Analog Devices ADMV4420 K Band Downconverter"
-       depends on SPI
-       help
-         Say yes here to build support for Analog Devices K Band
-         Downconverter with integrated Fractional-N PLL and VCO.
+	tristate "Analog Devices ADMV4420 K Band Downconverter"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices K Band
+	  Downconverter with integrated Fractional-N PLL and VCO.
 
-         To compile this driver as a module, choose M here: the
-         module will be called admv4420.
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv4420.
 
 config ADRF6780
-        tristate "Analog Devices ADRF6780 Microwave Upconverter"
-        depends on SPI
-        depends on COMMON_CLK
-        help
-          Say yes here to build support for Analog Devices ADRF6780
-          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
-
-          To compile this driver as a module, choose M here: the
-          module will be called adrf6780.
+	tristate "Analog Devices ADRF6780 Microwave Upconverter"
+	depends on SPI
+	depends on COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices ADRF6780
+	  5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adrf6780.
 
 endmenu
 endmenu
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 4f1a845f9be6..57a3dae87f65 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -169,7 +169,7 @@ struct bnxt_qplib_swqe {
 			};
 			u32		q_key;
 			u32		dst_qp;
-			u16		avid;
+			u32		avid;
 		} send;
 
 		/* Send Raw Ethernet and QP1 */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 75e0c42f6f42..14c9af41faa6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -249,7 +249,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 81b0c5e879f9..203350c6e00f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -244,6 +244,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			sginfo.pgsize = npde * pg_size;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
@@ -255,22 +257,9 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_0].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_1].pg_map_arr;
-			if (hwq_attr->type == HWQ_TYPE_MR) {
-			/* For MR it is expected that we supply only 1 contigous
-			 * page i.e only 1 entry in the PDL that will contain
-			 * all the PBLs for the user supplied memory region
-			 */
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[0][i] = src_phys_ptr[i] |
-						flag;
-			} else {
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
-						src_phys_ptr[i] |
-						PTU_PDE_VALID;
-			}
+			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[0][i] = src_phys_ptr[i] | flag;
+
 			/* Alloc or init PTEs */
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_2],
 					 hwq_attr->sginfo);
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b3757c6a0457..8d753e6e0c71 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2086,7 +2086,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 	err = -ENOMEM;
 	if (n->dev->flags & IFF_LOOPBACK) {
 		if (iptype == 4)
-			pdev = ip_dev_find(&init_net, *(__be32 *)peer_ip);
+			pdev = __ip_dev_find(&init_net, *(__be32 *)peer_ip, false);
 		else if (IS_ENABLED(CONFIG_IPV6))
 			for_each_netdev(&init_net, pdev) {
 				if (ipv6_chk_addr(&init_net,
@@ -2101,12 +2101,12 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 			err = -ENODEV;
 			goto out;
 		}
+		if (is_vlan_dev(pdev))
+			pdev = vlan_dev_real_dev(pdev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t) {
-			dev_put(pdev);
+		if (!ep->l2t)
 			goto out;
-		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = ((struct port_info *)netdev_priv(pdev))->smt_idx;
@@ -2119,7 +2119,6 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		ep->rss_qid = cdev->rdev.lldi.rxq_ids[
 			cxgb4_port_idx(pdev) * step];
 		set_tcp_window(ep, (struct port_info *)netdev_priv(pdev));
-		dev_put(pdev);
 	} else {
 		pdev = get_real_dev(n->dev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 8817864154af..691b9ed7f759 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3584,7 +3584,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
 /**
  * irdma_accept - registered call for connection to be accepted
  * @cm_id: cm information for passive connection
- * @conn_param: accpet parameters
+ * @conn_param: accept parameters
  */
 int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 {
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index fd6c260d5857..33c099e5efc5 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -68,6 +68,8 @@ MODULE_LICENSE("Dual BSD/GPL");
 static u64 srpt_service_guid;
 static DEFINE_SPINLOCK(srpt_dev_lock);	/* Protects srpt_dev_list. */
 static LIST_HEAD(srpt_dev_list);	/* List of srpt_device structures. */
+static DEFINE_MUTEX(srpt_mc_mutex);	/* Protects srpt_memory_caches. */
+static DEFINE_XARRAY(srpt_memory_caches); /* See also srpt_memory_cache_entry */
 
 static unsigned srp_max_req_size = DEFAULT_MAX_REQ_SIZE;
 module_param(srp_max_req_size, int, 0444);
@@ -105,6 +107,63 @@ static void srpt_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void srpt_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void srpt_process_wait_list(struct srpt_rdma_ch *ch);
 
+/* Type of the entries in srpt_memory_caches. */
+struct srpt_memory_cache_entry {
+	refcount_t ref;
+	struct kmem_cache *c;
+};
+
+static struct kmem_cache *srpt_cache_get(unsigned int object_size)
+{
+	struct srpt_memory_cache_entry *e;
+	char name[32];
+	void *res;
+
+	guard(mutex)(&srpt_mc_mutex);
+	e = xa_load(&srpt_memory_caches, object_size);
+	if (e) {
+		refcount_inc(&e->ref);
+		return e->c;
+	}
+	snprintf(name, sizeof(name), "srpt-%u", object_size);
+	e = kmalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return NULL;
+	refcount_set(&e->ref, 1);
+	e->c = kmem_cache_create(name, object_size, /*align=*/512, 0, NULL);
+	if (!e->c)
+		goto free_entry;
+	res = xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL);
+	if (xa_is_err(res))
+		goto destroy_cache;
+	return e->c;
+
+destroy_cache:
+	kmem_cache_destroy(e->c);
+
+free_entry:
+	kfree(e);
+	return NULL;
+}
+
+static void srpt_cache_put(struct kmem_cache *c)
+{
+	struct srpt_memory_cache_entry *e = NULL;
+	unsigned long object_size;
+
+	guard(mutex)(&srpt_mc_mutex);
+	xa_for_each(&srpt_memory_caches, object_size, e)
+		if (e->c == c)
+			break;
+	if (WARN_ON_ONCE(!e))
+		return;
+	if (!refcount_dec_and_test(&e->ref))
+		return;
+	WARN_ON_ONCE(xa_erase(&srpt_memory_caches, object_size) != e);
+	kmem_cache_destroy(e->c);
+	kfree(e);
+}
+
 /*
  * The only allowed channel state changes are those that change the channel
  * state into a state with a higher numerical value. Hence the new > prev test.
@@ -2119,13 +2178,13 @@ static void srpt_release_channel_work(struct work_struct *w)
 			     ch->sport->sdev, ch->rq_size,
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
 
-	kmem_cache_destroy(ch->rsp_buf_cache);
+	srpt_cache_put(ch->rsp_buf_cache);
 
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_recv_ring,
 			     sdev, ch->rq_size,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
 
-	kmem_cache_destroy(ch->req_buf_cache);
+	srpt_cache_put(ch->req_buf_cache);
 
 	kref_put(&ch->kref, srpt_free_ch);
 }
@@ -2245,8 +2304,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
 	ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;
 
-	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
-					      512, 0, NULL);
+	ch->rsp_buf_cache = srpt_cache_get(ch->max_rsp_size);
 	if (!ch->rsp_buf_cache)
 		goto free_ch;
 
@@ -2280,8 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		alignment_offset = round_up(imm_data_offset, 512) -
 			imm_data_offset;
 		req_sz = alignment_offset + imm_data_offset + srp_max_req_size;
-		ch->req_buf_cache = kmem_cache_create("srpt-req-buf", req_sz,
-						      512, 0, NULL);
+		ch->req_buf_cache = srpt_cache_get(req_sz);
 		if (!ch->req_buf_cache)
 			goto free_rsp_ring;
 
@@ -2478,7 +2535,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
 
 free_recv_cache:
-	kmem_cache_destroy(ch->req_buf_cache);
+	srpt_cache_put(ch->req_buf_cache);
 
 free_rsp_ring:
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
@@ -2486,7 +2543,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
 
 free_rsp_cache:
-	kmem_cache_destroy(ch->rsp_buf_cache);
+	srpt_cache_put(ch->rsp_buf_cache);
 
 free_ch:
 	if (rdma_cm_id)
@@ -3055,7 +3112,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
 	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
 			     sdev->srq_size, sdev->req_buf_cache,
 			     DMA_FROM_DEVICE);
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
 	sdev->srq = NULL;
 }
 
@@ -3082,8 +3139,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
 		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
 
-	sdev->req_buf_cache = kmem_cache_create("srpt-srq-req-buf",
-						srp_max_req_size, 0, 0, NULL);
+	sdev->req_buf_cache = srpt_cache_get(srp_max_req_size);
 	if (!sdev->req_buf_cache)
 		goto free_srq;
 
@@ -3105,7 +3161,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	return 0;
 
 free_cache:
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
 
 free_srq:
 	ib_destroy_srq(srq);
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 70279ca7e627..5df559252c6e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -18,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
 #define IRQC_IRQ_START			1
 #define IRQC_IRQ_COUNT			8
@@ -55,12 +57,30 @@
 #define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
 #define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
 
-struct rzg2l_irqc_priv {
-	void __iomem *base;
-	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
-	raw_spinlock_t lock;
+/**
+ * struct rzg2l_irqc_reg_cache - registers cache (necessary for suspend/resume)
+ * @iitsr: IITSR register
+ * @titsr: TITSR registers
+ */
+struct rzg2l_irqc_reg_cache {
+	u32	iitsr;
+	u32	titsr[2];
 };
 
+/**
+ * struct rzg2l_irqc_priv - IRQ controller private data structure
+ * @base:	Controller's base address
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ * @cache:	Registers cache for suspend/resume
+ */
+static struct rzg2l_irqc_priv {
+	void __iomem			*base;
+	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t			lock;
+	struct rzg2l_irqc_reg_cache	cache;
+} *rzg2l_irqc_data;
+
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 {
 	return data->domain->host_data;
@@ -276,6 +296,38 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
 
+static int rzg2l_irqc_irq_suspend(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+
+	cache->iitsr = readl_relaxed(base + IITSR);
+	for (u8 i = 0; i < 2; i++)
+		cache->titsr[i] = readl_relaxed(base + TITSR(i));
+
+	return 0;
+}
+
+static void rzg2l_irqc_irq_resume(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (u8 i = 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + TITSR(i));
+	writel_relaxed(cache->iitsr, base + IITSR);
+}
+
+static struct syscore_ops rzg2l_irqc_syscore_ops = {
+	.suspend	= rzg2l_irqc_irq_suspend,
+	.resume		= rzg2l_irqc_irq_resume,
+};
+
 static const struct irq_chip irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
@@ -357,13 +409,12 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 {
+	struct platform_device *pdev = of_find_device_by_node(node);
+	struct device *dev __free(put_device) = pdev ? &pdev->dev : NULL;
 	struct irq_domain *irq_domain, *parent_domain;
-	struct platform_device *pdev;
 	struct reset_control *resetn;
-	struct rzg2l_irqc_priv *priv;
 	int ret;
 
-	pdev = of_find_device_by_node(node);
 	if (!pdev)
 		return -ENODEV;
 
@@ -373,15 +424,15 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	rzg2l_irqc_data = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
+	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
-	priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(rzg2l_irqc_data->base))
+		return PTR_ERR(rzg2l_irqc_data->base);
 
-	ret = rzg2l_irqc_parse_interrupts(priv, node);
+	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
@@ -404,17 +455,30 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 		goto pm_disable;
 	}
 
-	raw_spin_lock_init(&priv->lock);
+	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
 	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
 					      node, &rzg2l_irqc_domain_ops,
-					      priv);
+					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
 		goto pm_put;
 	}
 
+	register_syscore_ops(&rzg2l_irqc_syscore_ops);
+
+	/*
+	 * Prevent the cleanup function from invoking put_device by assigning
+	 * NULL to dev.
+	 *
+	 * make coccicheck will complain about missing put_device calls, but
+	 * those are false positives, as dev will be automatically "put" via
+	 * __free_put_device on the failing path.
+	 * On the successful path we don't actually want to "put" dev.
+	 */
+	dev = NULL;
+
 	return 0;
 
 pm_put:
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index f79cf716c541..553f577c25a6 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1728,6 +1728,7 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 	ptr = shift / 8;
 	shift %= 8;
 	mask >>= ptr * 8;
+	ptr <<= 8;
 
 	err = mv88e6393x_port_policy_read(chip, port, ptr, &reg);
 	if (err)
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index aa0d2f3aaeaa..f7a44d8541a0 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -484,7 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 
 	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
 		dev->stats.tx_errors++;
-		goto out;
+		goto len_error;
 	}
 
 	/* Save skb pointer. */
@@ -575,6 +575,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 map_error:
 	if (net_ratelimit())
 		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
+len_error:
 	dev_kfree_skb(skb);
 out:
 	return err;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 425d6ccd5413..1693f6c60efc 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1348,6 +1348,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
 		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
 			  skb->data, skb_len);
 		ret = NETDEV_TX_OK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a9e4e6464a04..b0a85c9b952b 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1382,10 +1382,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1394,7 +1392,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1408,6 +1406,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 72d3b5328ebb..54c83e66bf78 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -1011,6 +1011,7 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 	if(skb->len > XMIT_BUFF_SIZE)
 	{
 		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
+		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 392d9b0da0d7..4f3c1187a6e8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -336,6 +336,51 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
 	return new_pkts;
 }
 
+/**
+ * octep_oq_next_pkt() - Move to the next packet in Rx queue.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @buff_info: Current packet buffer info.
+ * @read_idx: Current packet index in the ring.
+ * @desc_used: Current packet descriptor number.
+ *
+ * Free the resources associated with a packet.
+ * Increment packet index in the ring and packet descriptor number.
+ */
+static void octep_oq_next_pkt(struct octep_oq *oq,
+			      struct octep_rx_buffer *buff_info,
+			      u32 *read_idx, u32 *desc_used)
+{
+	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+		       PAGE_SIZE, DMA_FROM_DEVICE);
+	buff_info->page = NULL;
+	(*read_idx)++;
+	(*desc_used)++;
+	if (*read_idx == oq->max_count)
+		*read_idx = 0;
+}
+
+/**
+ * octep_oq_drop_rx() - Free the resources associated with a packet.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @buff_info: Current packet buffer info.
+ * @read_idx: Current packet index in the ring.
+ * @desc_used: Current packet descriptor number.
+ *
+ */
+static void octep_oq_drop_rx(struct octep_oq *oq,
+			     struct octep_rx_buffer *buff_info,
+			     u32 *read_idx, u32 *desc_used)
+{
+	int data_len = buff_info->len - oq->max_single_buffer_size;
+
+	while (data_len > 0) {
+		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
+		data_len -= oq->buffer_size;
+	};
+}
+
 /**
  * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -365,10 +410,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
 		buff_info = (struct octep_rx_buffer *)&oq->buff_info[read_idx];
-		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-			       PAGE_SIZE, DMA_FROM_DEVICE);
 		resp_hw = page_address(buff_info->page);
-		buff_info->page = NULL;
 
 		/* Swap the length field that is in Big-Endian to CPU */
 		buff_info->len = be64_to_cpu(resp_hw->length);
@@ -390,36 +432,33 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			 */
 			data_offset = OCTEP_OQ_RESP_HW_SIZE;
 		}
+
+		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
+
+		skb = build_skb((void *)resp_hw, PAGE_SIZE);
+		if (!skb) {
+			octep_oq_drop_rx(oq, buff_info,
+					 &read_idx, &desc_used);
+			oq->stats.alloc_failures++;
+			continue;
+		}
+		skb_reserve(skb, data_offset);
+
 		rx_bytes += buff_info->len;
 
 		if (buff_info->len <= oq->max_single_buffer_size) {
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
 		} else {
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
 			 */
 			skb_put(skb, oq->max_single_buffer_size);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
-
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
 			while (data_len) {
-				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-					       PAGE_SIZE, DMA_FROM_DEVICE);
 				buff_info = (struct octep_rx_buffer *)
 					    &oq->buff_info[read_idx];
 				if (data_len < oq->buffer_size) {
@@ -434,11 +473,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 						buff_info->page, 0,
 						buff_info->len,
 						buff_info->len);
-				buff_info->page = NULL;
-				read_idx++;
-				desc_used++;
-				if (read_idx == oq->max_count)
-					read_idx = 0;
+
+				octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 			}
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 7ed0eb9bd4ed..95a8ccd18a4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2279,7 +2279,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
 		if (!(cfg & BIT_ULL(12)))
 			continue;
-		bmap |= (1 << i);
+		bmap |= BIT_ULL(i);
 		cfg &= ~BIT_ULL(12);
 		rvu_write64(rvu, blkaddr,
 			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
@@ -2300,7 +2300,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 
 	/* Set NIX_AF_TL3_TL2_LINKX_CFG[ENA] for the TL3/TL2 queue */
 	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
-		if (!(bmap & (1 << i)))
+		if (!(bmap & BIT_ULL(i)))
 			continue;
 		cfg = rvu_read64(rvu, blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 465d2adbf3c0..4a1eb6cd699c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1570,7 +1570,6 @@ static void clean_debug_files(struct mlx5_core_dev *dev)
 	if (!mlx5_debugfs_root)
 		return;
 
-	mlx5_cmdif_debugfs_cleanup(dev);
 	debugfs_remove_recursive(dbg->dbg_root);
 }
 
@@ -1585,8 +1584,6 @@ static void create_debugfs_files(struct mlx5_core_dev *dev)
 	debugfs_create_file("out_len", 0600, dbg->dbg_root, dev, &olfops);
 	debugfs_create_u8("status", 0600, dbg->dbg_root, &dbg->status);
 	debugfs_create_file("run", 0200, dbg->dbg_root, dev, &fops);
-
-	mlx5_cmdif_debugfs_init(dev);
 }
 
 void mlx5_cmd_allowed_opcode(struct mlx5_core_dev *dev, u16 opcode)
@@ -1758,6 +1755,10 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 	}
 }
 
+#define MLX5_MAX_MANAGE_PAGES_CMD_ENT 1
+#define MLX5_CMD_MASK ((1UL << (cmd->vars.max_reg_cmds + \
+			   MLX5_MAX_MANAGE_PAGES_CMD_ENT)) - 1)
+
 static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;
@@ -1769,7 +1770,7 @@ static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 	/* wait for pending handlers to complete */
 	mlx5_eq_synchronize_cmd_irq(dev);
 	spin_lock_irqsave(&dev->cmd.alloc_lock, flags);
-	vector = ~dev->cmd.vars.bitmask & ((1ul << (1 << dev->cmd.vars.log_sz)) - 1);
+	vector = ~dev->cmd.vars.bitmask & MLX5_CMD_MASK;
 	if (!vector)
 		goto no_trig;
 
@@ -2215,20 +2216,10 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	int size = sizeof(struct mlx5_cmd_prot_block);
 	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
-	u32 cmd_h, cmd_l;
-	u16 cmd_if_rev;
+	u32 cmd_l;
 	int err;
 	int i;
 
-	memset(cmd, 0, sizeof(*cmd));
-	cmd_if_rev = cmdif_rev(dev);
-	if (cmd_if_rev != CMD_IF_REV) {
-		mlx5_core_err(dev,
-			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
-			      CMD_IF_REV, cmd_if_rev);
-		return -EINVAL;
-	}
-
 	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
 	if (!cmd->pool)
 		return -ENOMEM;
@@ -2237,39 +2228,84 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_free_pool;
 
+	cmd_l = (u32)(cmd->dma);
+	if (cmd_l & 0xfff) {
+		mlx5_core_err(dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_cmd_page;
+	}
+	cmd->checksum_disabled = 1;
+
+	spin_lock_init(&cmd->alloc_lock);
+	spin_lock_init(&cmd->token_lock);
+	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
+		spin_lock_init(&cmd->stats[i].lock);
+
+	create_msg_cache(dev);
+
+	set_wqname(dev);
+	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
+	if (!cmd->wq) {
+		mlx5_core_err(dev, "failed to create command workqueue\n");
+		err = -ENOMEM;
+		goto err_cache;
+	}
+
+	mlx5_cmdif_debugfs_init(dev);
+
+	return 0;
+
+err_cache:
+	destroy_msg_cache(dev);
+err_cmd_page:
+	free_cmd_page(dev, cmd);
+err_free_pool:
+	dma_pool_destroy(cmd->pool);
+	return err;
+}
+
+void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_cmd *cmd = &dev->cmd;
+
+	mlx5_cmdif_debugfs_cleanup(dev);
+	destroy_workqueue(cmd->wq);
+	destroy_msg_cache(dev);
+	free_cmd_page(dev, cmd);
+	dma_pool_destroy(cmd->pool);
+}
+
+int mlx5_cmd_enable(struct mlx5_core_dev *dev)
+{
+	struct mlx5_cmd *cmd = &dev->cmd;
+	u32 cmd_h, cmd_l;
+
+	memset(&cmd->vars, 0, sizeof(cmd->vars));
+	cmd->vars.cmdif_rev = cmdif_rev(dev);
+	if (cmd->vars.cmdif_rev != CMD_IF_REV) {
+		mlx5_core_err(dev,
+			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
+			      CMD_IF_REV, cmd->vars.cmdif_rev);
+		return -EINVAL;
+	}
+
 	cmd_l = ioread32be(&dev->iseg->cmdq_addr_l_sz) & 0xff;
 	cmd->vars.log_sz = cmd_l >> 4 & 0xf;
 	cmd->vars.log_stride = cmd_l & 0xf;
 	if (1 << cmd->vars.log_sz > MLX5_MAX_COMMANDS) {
 		mlx5_core_err(dev, "firmware reports too many outstanding commands %d\n",
 			      1 << cmd->vars.log_sz);
-		err = -EINVAL;
-		goto err_free_page;
+		return -EINVAL;
 	}
 
 	if (cmd->vars.log_sz + cmd->vars.log_stride > MLX5_ADAPTER_PAGE_SHIFT) {
 		mlx5_core_err(dev, "command queue size overflow\n");
-		err = -EINVAL;
-		goto err_free_page;
+		return -EINVAL;
 	}
 
 	cmd->state = MLX5_CMDIF_STATE_DOWN;
-	cmd->checksum_disabled = 1;
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
-	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
-
-	cmd->vars.cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
-	if (cmd->vars.cmdif_rev > CMD_IF_REV) {
-		mlx5_core_err(dev, "driver does not support command interface version. driver %d, firmware %d\n",
-			      CMD_IF_REV, cmd->vars.cmdif_rev);
-		err = -EOPNOTSUPP;
-		goto err_free_page;
-	}
-
-	spin_lock_init(&cmd->alloc_lock);
-	spin_lock_init(&cmd->token_lock);
-	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
-		spin_lock_init(&cmd->stats[i].lock);
+	cmd->vars.bitmask = MLX5_CMD_MASK;
 
 	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
 	sema_init(&cmd->vars.pages_sem, 1);
@@ -2277,11 +2313,8 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 
 	cmd_h = (u32)((u64)(cmd->dma) >> 32);
 	cmd_l = (u32)(cmd->dma);
-	if (cmd_l & 0xfff) {
-		mlx5_core_err(dev, "invalid command queue address\n");
-		err = -ENOMEM;
-		goto err_free_page;
-	}
+	if (WARN_ON(cmd_l & 0xfff))
+		return -EINVAL;
 
 	iowrite32be(cmd_h, &dev->iseg->cmdq_addr_h);
 	iowrite32be(cmd_l, &dev->iseg->cmdq_addr_l_sz);
@@ -2294,40 +2327,17 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	cmd->mode = CMD_MODE_POLLING;
 	cmd->allowed_opcode = CMD_ALLOWED_OPCODE_ALL;
 
-	create_msg_cache(dev);
-
-	set_wqname(dev);
-	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
-	if (!cmd->wq) {
-		mlx5_core_err(dev, "failed to create command workqueue\n");
-		err = -ENOMEM;
-		goto err_cache;
-	}
-
 	create_debugfs_files(dev);
 
 	return 0;
-
-err_cache:
-	destroy_msg_cache(dev);
-
-err_free_page:
-	free_cmd_page(dev, cmd);
-
-err_free_pool:
-	dma_pool_destroy(cmd->pool);
-	return err;
 }
 
-void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
+void mlx5_cmd_disable(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;
 
 	clean_debug_files(dev);
-	destroy_workqueue(cmd->wq);
-	destroy_msg_cache(dev);
-	free_cmd_page(dev, cmd);
-	dma_pool_destroy(cmd->pool);
+	flush_workqueue(cmd->wq);
 }
 
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 48939c72b592..9ba825df9be0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1279,7 +1279,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	}
 
 	if (err)
-		goto abort;
+		goto err_esw_enable;
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
@@ -1293,7 +1293,8 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	return 0;
 
-abort:
+err_esw_enable:
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_esw_acls_ns_cleanup(esw);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 825ad7663fa4..de7baa1a1e16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1114,7 +1114,7 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 		return err;
 	}
 
-	err = mlx5_cmd_init(dev);
+	err = mlx5_cmd_enable(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed initializing command interface, aborting\n");
 		return err;
@@ -1168,7 +1168,7 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 	mlx5_stop_health_poll(dev, boot);
 err_cmd_cleanup:
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
+	mlx5_cmd_disable(dev);
 
 	return err;
 }
@@ -1179,7 +1179,7 @@ static void mlx5_function_disable(struct mlx5_core_dev *dev, bool boot)
 	mlx5_core_disable_hca(dev, 0);
 	mlx5_stop_health_poll(dev, boot);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
+	mlx5_cmd_disable(dev);
 }
 
 static int mlx5_function_open(struct mlx5_core_dev *dev)
@@ -1644,6 +1644,12 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 						mlx5_debugfs_root);
 	INIT_LIST_HEAD(&priv->traps);
 
+	err = mlx5_cmd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "Failed initializing cmdif SW structs, aborting\n");
+		goto err_cmd_init;
+	}
+
 	err = mlx5_tout_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed initializing timeouts, aborting\n");
@@ -1689,6 +1695,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 err_health_init:
 	mlx5_tout_cleanup(dev);
 err_timeout_init:
+	mlx5_cmd_cleanup(dev);
+err_cmd_init:
 	debugfs_remove(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
@@ -1711,6 +1719,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	mlx5_pagealloc_cleanup(dev);
 	mlx5_health_cleanup(dev);
 	mlx5_tout_cleanup(dev);
+	mlx5_cmd_cleanup(dev);
 	debugfs_remove_recursive(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 0b560e97a356..7d90f311b856 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -177,6 +177,8 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev);
 int mlx5_query_board_id(struct mlx5_core_dev *dev);
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
+int mlx5_cmd_enable(struct mlx5_core_dev *dev);
+void mlx5_cmd_disable(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
 			enum mlx5_cmdif_state cmdif_state);
 int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 8b35e14fba3a..a74e33bf0302 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4617,7 +4617,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
 
-	if (unlikely(status & SYSErr)) {
+	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
+	if (unlikely(status & SYSErr &&
+	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
 		rtl8169_pcierr_interrupt(tp->dev);
 		goto out;
 	}
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 756ac4a07f60..705010ea1d56 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1689,20 +1689,19 @@ static int ravb_get_ts_info(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
 
-	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
-		SOF_TIMESTAMPING_TX_HARDWARE |
-		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
-	info->rx_filters =
-		(1 << HWTSTAMP_FILTER_NONE) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-		(1 << HWTSTAMP_FILTER_ALL);
-	if (hw_info->gptp || hw_info->ccc_gac)
+	if (hw_info->gptp || hw_info->ccc_gac) {
+		info->so_timestamping =
+			SOF_TIMESTAMPING_TX_SOFTWARE |
+			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_RX_HARDWARE |
+			SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
+		info->rx_filters =
+			(1 << HWTSTAMP_FILTER_NONE) |
+			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			(1 << HWTSTAMP_FILTER_ALL);
 		info->phc_index = ptp_clock_index(priv->ptp.clock);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0b6f0908f3e1..ce0dd78826af 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -844,6 +844,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (net_ratelimit())
 			netdev_err(ndev, "TX DMA mapping error\n");
 		ndev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	desc_set_phys_addr(lp, phys, cur_p);
@@ -864,6 +865,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
 					      true, NULL, 0);
+			dev_kfree_skb_any(skb);
 			return NETDEV_TX_OK;
 		}
 		desc_set_phys_addr(lp, phys, cur_p);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1b7405539984..2fba5dfd9cd0 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2791,6 +2791,31 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+/* Set VF's namespace same as the synthetic NIC */
+static void netvsc_event_set_vf_ns(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct net_device *vf_netdev;
+	int ret;
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (!vf_netdev)
+		return;
+
+	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
+					       "eth%d");
+		if (ret)
+			netdev_err(vf_netdev,
+				   "Cannot move to same namespace as %s: %d\n",
+				   ndev->name, ret);
+		else
+			netdev_info(vf_netdev,
+				    "Moved VF to namespace with: %s\n",
+				    ndev->name);
+	}
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2803,6 +2828,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
+	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
+		netvsc_event_set_vf_ns(event_dev);
+		return NOTIFY_DONE;
+	}
+
 	ret = check_dev_is_matching_vf(event_dev);
 	if (ret != 0)
 		return NOTIFY_DONE;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 8a8fd74110e2..3a19d6f0e0dd 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -151,19 +151,6 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
-static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
-{
-	struct macsec_rx_sa *sa = NULL;
-	int an;
-
-	for (an = 0; an < MACSEC_NUM_AN; an++)	{
-		sa = macsec_rxsa_get(rx_sc->sa[an]);
-		if (sa)
-			break;
-	}
-	return sa;
-}
-
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -1210,15 +1197,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
-		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
 			DEV_STATS_INC(secy->netdev, rx_errors);
-			if (active_rx_sa)
-				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1228,8 +1212,6 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
-		if (active_rx_sa)
-			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index f3fa4bd12116..cdf7a70d6659 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -836,7 +836,8 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 	nsim_dev = nsim_trap_data->nsim_dev;
 
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 1);
+		queue_delayed_work(system_unbound_wq,
+				   &nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
 
@@ -848,11 +849,12 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 			continue;
 
 		nsim_dev_trap_report(nsim_dev_port);
+		cond_resched();
 	}
 	devl_unlock(priv_to_devlink(nsim_dev));
-
-	schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
-			      msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
+	queue_delayed_work(system_unbound_wq,
+			   &nsim_dev->trap_data->trap_report_dw,
+			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 }
 
 static int nsim_dev_traps_init(struct devlink *devlink)
@@ -907,8 +909,9 @@ static int nsim_dev_traps_init(struct devlink *devlink)
 
 	INIT_DELAYED_WORK(&nsim_dev->trap_data->trap_report_dw,
 			  nsim_dev_trap_report_work);
-	schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
-			      msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
+	queue_delayed_work(system_unbound_wq,
+			   &nsim_dev->trap_data->trap_report_dw,
+			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 
 	return 0;
 
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 57411ee1d837..317357c43c9a 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -40,8 +40,8 @@
 /* Control Register 2 bits */
 #define DP83822_FX_ENABLE	BIT(14)
 
-#define DP83822_HW_RESET	BIT(15)
-#define DP83822_SW_RESET	BIT(14)
+#define DP83822_SW_RESET	BIT(15)
+#define DP83822_DIG_RESTART	BIT(14)
 
 /* PHY STS bits */
 #define DP83822_PHYSTS_DUPLEX			BIT(2)
diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index 40ce8abe6999..6019811920a4 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -815,7 +815,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 				return HS_TIMEOUT;
 			}
 		}
-		break;
+		fallthrough;
 
 	case PLIP_PK_LENGTH_LSB:
 		if (plip_send(nibble_timeout, dev,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index bd0b807db751..ae1282487b02 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1766,7 +1766,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		// can rename the link if it knows better.
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
 		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     (net->dev_addr [0] & 0x02) == 0))
+		     /* somebody touched it*/
+		     !is_zero_ether_addr(net->dev_addr)))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
@@ -1869,6 +1870,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	 * may trigger an error resubmitting itself and, worse,
 	 * schedule a timer. So we kill it all just in case.
 	 */
+	usbnet_mark_going_away(dev);
 	cancel_work_sync(&dev->kevent);
 	del_timer_sync(&dev->delay);
 	free_percpu(net->tstats);
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 62e9f7d6c9fe..7089cb103885 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -994,7 +994,7 @@ static const struct nla_policy wwan_rtnl_policy[IFLA_WWAN_MAX + 1] = {
 
 static struct rtnl_link_ops wwan_rtnl_link_ops __read_mostly = {
 	.kind = "wwan",
-	.maxtype = __IFLA_WWAN_MAX,
+	.maxtype = IFLA_WWAN_MAX,
 	.alloc = wwan_rtnl_alloc,
 	.validate = wwan_rtnl_validate,
 	.newlink = wwan_rtnl_newlink,
diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 502783a7adb1..24fd7ffadda9 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/*Speaker Mute*/
 	{ KE_KEY, 0x109, { KEY_MUTE} },
 
+	/* S2Idle screen off */
+	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
+
+	/* Leaving S4 or S2Idle suspend */
+	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
+
+	/* Entering S2Idle suspend */
+	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index b2406a595be9..3ef90211c51a 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -524,6 +524,7 @@ static int __init sysman_init(void)
 	int ret = 0;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 612c3b59dd5b..0ca53db7a90e 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -166,7 +166,7 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
 				     DEV_PM_QOS_MAX_FREQUENCY,
 				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
-	if (ret) {
+	if (ret < 0) {
 		pr_err("Failed to add QoS request: %d\n", ret);
 		goto out_dtpm_unregister;
 	}
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index d73c4c2ed4e1..443d6bae19d1 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -13,7 +13,7 @@
 #include <linux/pps_kernel.h>
 #include <linux/bug.h>
 
-static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
+static void pps_tty_dcd_change(struct tty_struct *tty, bool active)
 {
 	struct pps_device *pps;
 	struct pps_event_time ts;
@@ -29,11 +29,11 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 		return;
 
 	/* Now do the PPS event report */
-	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
+	pps_event(pps, &ts, active ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
 	dev_dbg(pps->dev, "PPS %s at %lu\n",
-			status ? "assert" : "clear", jiffies);
+			active ? "assert" : "clear", jiffies);
 }
 
 static int (*alias_n_tty_open)(struct tty_struct *tty);
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 13558cbd9b82..7be48bfbd42e 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -733,7 +733,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 
 	dev->queues = kcalloc(nr_cpu_ids, sizeof(*dev->queues), GFP_KERNEL);
 	if (!dev->queues) {
-		dev->transport->free_device(dev);
+		hba->backend->ops->free_device(dev);
 		return NULL;
 	}
 
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 2940559c3086..adf68323d0d6 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2130,7 +2130,7 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	}
 
 	ret = genlmsg_multicast_allns(&tcmu_genl_family, skb, 0,
-				      TCMU_MCGRP_CONFIG, GFP_KERNEL);
+				      TCMU_MCGRP_CONFIG);
 
 	/* Wait during an add as the listener may not be up yet */
 	if (ret == 0 ||
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5acbab0512b8..94e0781e00e8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -801,7 +801,22 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
-	uart_handle_cts_change(&sport->port, !!usr1);
+	/*
+	 * Update sport->old_status here, so any follow-up calls to
+	 * imx_uart_mctrl_check() will be able to recognize that RTS
+	 * state changed since last imx_uart_mctrl_check() call.
+	 *
+	 * In case RTS has been detected as asserted here and later on
+	 * deasserted by the time imx_uart_mctrl_check() was called,
+	 * imx_uart_mctrl_check() can detect the RTS state change and
+	 * trigger uart_handle_cts_change() to unblock the port for
+	 * further TX transfers.
+	 */
+	if (usr1 & USR1_RTSS)
+		sport->old_status |= TIOCM_CTS;
+	else
+		sport->old_status &= ~TIOCM_CTS;
+	uart_handle_cts_change(&sport->port, usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	return IRQ_HANDLED;
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5d8660fed081..67803242a70c 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -250,7 +250,7 @@ static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 	cts = (rx & MAX3100_CTS) > 0;
 	if (s->cts != cts) {
 		s->cts = cts;
-		uart_handle_cts_change(&s->port, cts ? TIOCM_CTS : 0);
+		uart_handle_cts_change(&s->port, cts);
 	}
 
 	return ret;
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d409ef388721..4eb8d372f619 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -843,8 +843,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 
 		if (ists & MAX310X_IRQ_CTS_BIT) {
 			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-			uart_handle_cts_change(port,
-					       !!(lsr & MAX310X_LSR_CTS_BIT));
+			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 58e857fb8dee..19a53801ff9e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -339,14 +339,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty) {
-			uport->cons->cflag = tty->termios.c_cflag;
-			uport->cons->ispeed = tty->termios.c_ispeed;
-			uport->cons->ospeed = tty->termios.c_ospeed;
-		}
+		if (uport) {
+			if (uart_console(uport) && tty) {
+				uport->cons->cflag = tty->termios.c_cflag;
+				uport->cons->ispeed = tty->termios.c_ispeed;
+				uport->cons->ospeed = tty->termios.c_ospeed;
+			}
 
-		if (!tty || C_HUPCL(tty))
-			uart_port_dtr_rts(uport, 0);
+			if (!tty || C_HUPCL(tty))
+				uart_port_dtr_rts(uport, 0);
+		}
 
 		uart_port_shutdown(port);
 	}
@@ -3290,11 +3292,11 @@ EXPORT_SYMBOL(uart_match_port);
 /**
  * uart_handle_dcd_change - handle a change of carrier detect state
  * @uport: uart_port structure for the open port
- * @status: new carrier detect status, nonzero if active
+ * @active: new carrier detect status
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
+void uart_handle_dcd_change(struct uart_port *uport, bool active)
 {
 	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
@@ -3306,7 +3308,7 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 		ld = tty_ldisc_ref(tty);
 		if (ld) {
 			if (ld->ops->dcd_change)
-				ld->ops->dcd_change(tty, status);
+				ld->ops->dcd_change(tty, active);
 			tty_ldisc_deref(ld);
 		}
 	}
@@ -3314,7 +3316,7 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 	uport->icount.dcd++;
 
 	if (uart_dcd_enabled(uport)) {
-		if (status)
+		if (active)
 			wake_up_interruptible(&port->open_wait);
 		else if (tty)
 			tty_hangup(tty);
@@ -3325,11 +3327,11 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 /**
  * uart_handle_cts_change - handle a change of clear-to-send state
  * @uport: uart_port structure for the open port
- * @status: new clear to send status, nonzero if active
+ * @active: new clear-to-send status
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
+void uart_handle_cts_change(struct uart_port *uport, bool active)
 {
 	lockdep_assert_held_once(&uport->lock);
 
@@ -3337,13 +3339,13 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 
 	if (uart_softcts_mode(uport)) {
 		if (uport->hw_stopped) {
-			if (status) {
+			if (active) {
 				uport->hw_stopped = 0;
 				uport->ops->start_tx(uport);
 				uart_write_wakeup(uport);
 			}
 		} else {
-			if (!status) {
+			if (!active) {
 				uport->hw_stopped = 1;
 				uport->ops->stop_tx(uport);
 			}
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 1938ba5e98c0..f0408a4d91ec 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -89,10 +89,10 @@ static int receive_chars_getchar(struct uart_port *port)
 
 		if (c == CON_HUP) {
 			hung_up = 1;
-			uart_handle_dcd_change(port, 0);
+			uart_handle_dcd_change(port, false);
 		} else if (hung_up) {
 			hung_up = 0;
-			uart_handle_dcd_change(port, 1);
+			uart_handle_dcd_change(port, true);
 		}
 
 		if (port->state == NULL) {
@@ -135,7 +135,7 @@ static int receive_chars_read(struct uart_port *port)
 				bytes_read = 1;
 			} else if (stat == CON_HUP) {
 				hung_up = 1;
-				uart_handle_dcd_change(port, 0);
+				uart_handle_dcd_change(port, false);
 				continue;
 			} else {
 				/* HV_EWOULDBLOCK, etc.  */
@@ -145,7 +145,7 @@ static int receive_chars_read(struct uart_port *port)
 
 		if (hung_up) {
 			hung_up = 0;
-			uart_handle_dcd_change(port, 1);
+			uart_handle_dcd_change(port, true);
 		}
 
 		if (port->sysrq != 0 &&  *con_read_page) {
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c191716896fc..22edd8d451da 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2131,6 +2131,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 
+	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+			    DWC3_GUSB2PHYCFG_SUSPHY) ||
+			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+			    DWC3_GUSB3PIPECTL_SUSPHY);
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -2178,6 +2183,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	return 0;
 }
 
@@ -2240,6 +2254,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e733835c4122..1b496c8e7b80 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1118,6 +1118,8 @@ struct dwc3_scratchpad_array {
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1341,6 +1343,7 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 	unsigned		suspended:1;
+	unsigned		susphy_state:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index f10e43a948fd..db66242b2918 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -490,6 +490,46 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+/**
+ * usb_func_wakeup - sends function wake notification to the host.
+ * @func: function that sends the remote wakeup notification.
+ *
+ * Applicable to devices operating at enhanced superspeed when usb
+ * functions are put in function suspend state and armed for function
+ * remote wakeup. On completion, function wake notification is sent. If
+ * the device is in low power state it tries to bring the device to active
+ * state before sending the wake notification. Since it is a synchronous
+ * call, caller must take care of not calling it in interrupt context.
+ * For devices operating at lower speeds  returns negative errno.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_func_wakeup(struct usb_function *func)
+{
+	struct usb_gadget	*gadget = func->config->cdev->gadget;
+	int			id;
+
+	if (!gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
+
+	if (!func->func_wakeup_armed) {
+		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
+		return -EINVAL;
+	}
+
+	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
+		if (func->config->interface[id] == func)
+			break;
+
+	if (id == MAX_CONFIG_INTERFACES) {
+		ERROR(func->config->cdev, "Invalid function\n");
+		return -EINVAL;
+	}
+
+	return gadget->ops->func_wakeup(gadget, id);
+}
+EXPORT_SYMBOL_GPL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 0219cd79493a..b3dc5f5164f4 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2042,7 +2042,7 @@ static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = snprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -2052,7 +2052,7 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 					  const char *page, size_t len)	\
 {									\
 	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret = 0;							\
+	int ret = len;							\
 									\
 	mutex_lock(&opts->lock);					\
 	if (opts->refcnt) {						\
@@ -2060,8 +2060,11 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 		goto end;						\
 	}								\
 									\
-	ret = snprintf(opts->name, min(sizeof(opts->name), len),	\
-			"%s", page);					\
+	if (len && page[len - 1] == '\n')				\
+		len--;							\
+									\
+	scnprintf(opts->name, min(sizeof(opts->name), len + 1),		\
+		  "%s", page);						\
 									\
 end:									\
 	mutex_unlock(&opts->lock);					\
@@ -2178,7 +2181,7 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->req_number = UAC2_DEF_REQ_NUM;
 	opts->fb_max = FBACK_FAST_MAX;
 
-	snprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
+	scnprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
 
 	return &opts->func_inst;
 }
diff --git a/drivers/usb/host/xhci-caps.h b/drivers/usb/host/xhci-caps.h
new file mode 100644
index 000000000000..9e94cebf4a56
--- /dev/null
+++ b/drivers/usb/host/xhci-caps.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* hc_capbase bitmasks */
+/* bits 7:0 - how long is the Capabilities register */
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+/* bits 31:16	*/
+#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define HCS_SLOTS_MASK		0xff
+/* bits 8:18, Max Interrupters */
+#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
+/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+
+/* HCSPARAMS2 - hcs_params2 - bitmasks */
+/* bits 0:3, frames or uframes that SW needs to queue transactions
+ * ahead of the HW to meet periodic deadlines */
+#define HCS_IST(p)		(((p) >> 0) & 0xf)
+/* bits 4:7, max number of Event Ring segments */
+#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
+/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
+/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
+/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
+#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
+
+/* HCSPARAMS3 - hcs_params3 - bitmasks */
+/* bits 0:7, Max U1 to U0 latency for the roothub ports */
+#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
+/* bits 16:31, Max U2 to U0 latency for the roothub ports */
+#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
+
+/* HCCPARAMS - hcc_params - bitmasks */
+/* true: HC can use 64-bit address pointers */
+#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
+/* true: HC can do bandwidth negotiation */
+#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
+/* true: HC uses 64-byte Device Context structures
+ * FIXME 64-byte context structures aren't supported yet.
+ */
+#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
+/* true: HC has port power switches */
+#define HCC_PPC(p)		((p) & (1 << 3))
+/* true: HC has port indicators */
+#define HCS_INDICATOR(p)	((p) & (1 << 4))
+/* true: HC has Light HC Reset Capability */
+#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
+/* true: HC supports latency tolerance messaging */
+#define HCC_LTC(p)		((p) & (1 << 6))
+/* true: no secondary Stream ID Support */
+#define HCC_NSS(p)		((p) & (1 << 7))
+/* true: HC supports Stopped - Short Packet */
+#define HCC_SPC(p)		((p) & (1 << 9))
+/* true: HC has Contiguous Frame ID Capability */
+#define HCC_CFC(p)		((p) & (1 << 11))
+/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
+#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
+/* Extended Capabilities pointer from PCI base - section 5.3.6 */
+#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
+
+#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
+
+/* db_off bitmask - bits 0:1 reserved */
+#define	DBOFF_MASK	(~0x3)
+
+/* run_regs_off bitmask - bits 0:4 reserved */
+#define	RTSOFF_MASK	(~0x1f)
+
+/* HCCPARAMS2 - hcc_params2 - bitmasks */
+/* true: HC supports U3 entry Capability */
+#define	HCC2_U3C(p)		((p) & (1 << 0))
+/* true: HC supports Configure endpoint command Max exit latency too large */
+#define	HCC2_CMC(p)		((p) & (1 << 1))
+/* true: HC supports Force Save context Capability */
+#define	HCC2_FSC(p)		((p) & (1 << 2))
+/* true: HC supports Compliance Transition Capability */
+#define	HCC2_CTC(p)		((p) & (1 << 3))
+/* true: HC support Large ESIT payload Capability > 48k */
+#define	HCC2_LEC(p)		((p) & (1 << 4))
+/* true: HC support Configuration Information Capability */
+#define	HCC2_CIC(p)		((p) & (1 << 5))
+/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
+#define	HCC2_ETC(p)		((p) & (1 << 6))
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index ca04192fdab1..caeadfb8760b 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -108,7 +108,7 @@ struct dbc_port {
 	struct tasklet_struct		push;
 
 	struct list_head		write_pool;
-	struct kfifo			write_fifo;
+	unsigned int			tx_boundary;
 
 	bool				registered;
 };
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d3acc0829ee5..6dd7e8c8eed0 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -25,16 +25,26 @@ static inline struct dbc_port *dbc_to_port(struct xhci_dbc *dbc)
 }
 
 static unsigned int
-dbc_send_packet(struct dbc_port *port, char *packet, unsigned int size)
+dbc_kfifo_to_req(struct dbc_port *port, char *packet)
 {
-	unsigned int		len;
-
-	len = kfifo_len(&port->write_fifo);
-	if (len < size)
-		size = len;
-	if (size != 0)
-		size = kfifo_out(&port->write_fifo, packet, size);
-	return size;
+	unsigned int	len;
+
+	len = kfifo_len(&port->port.xmit_fifo);
+
+	if (len == 0)
+		return 0;
+
+	len = min(len, DBC_MAX_PACKET);
+
+	if (port->tx_boundary)
+		len = min(port->tx_boundary, len);
+
+	len = kfifo_out(&port->port.xmit_fifo, packet, len);
+
+	if (port->tx_boundary)
+		port->tx_boundary -= len;
+
+	return len;
 }
 
 static int dbc_start_tx(struct dbc_port *port)
@@ -49,7 +59,7 @@ static int dbc_start_tx(struct dbc_port *port)
 
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
-		len = dbc_send_packet(port, req->buf, DBC_MAX_PACKET);
+		len = dbc_kfifo_to_req(port, req->buf);
 		if (len == 0)
 			break;
 		do_tty_wake = true;
@@ -214,14 +224,32 @@ static int dbc_tty_write(struct tty_struct *tty,
 {
 	struct dbc_port		*port = tty->driver_data;
 	unsigned long		flags;
+	unsigned int		written = 0;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	if (count)
-		count = kfifo_in(&port->write_fifo, buf, count);
-	dbc_start_tx(port);
+
+	/*
+	 * Treat tty write as one usb transfer. Make sure the writes are turned
+	 * into TRB request having the same size boundaries as the tty writes.
+	 * Don't add data to kfifo before previous write is turned into TRBs
+	 */
+	if (port->tx_boundary) {
+		spin_unlock_irqrestore(&port->port_lock, flags);
+		return 0;
+	}
+
+	if (count) {
+		written = kfifo_in(&port->port.xmit_fifo, buf, count);
+
+		if (written == count)
+			port->tx_boundary = kfifo_len(&port->port.xmit_fifo);
+
+		dbc_start_tx(port);
+	}
+
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
-	return count;
+	return written;
 }
 
 static int dbc_tty_put_char(struct tty_struct *tty, unsigned char ch)
@@ -231,7 +259,7 @@ static int dbc_tty_put_char(struct tty_struct *tty, unsigned char ch)
 	int			status;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	status = kfifo_put(&port->write_fifo, ch);
+	status = kfifo_put(&port->port.xmit_fifo, ch);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return status;
@@ -254,7 +282,11 @@ static unsigned int dbc_tty_write_room(struct tty_struct *tty)
 	unsigned int		room;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	room = kfifo_avail(&port->write_fifo);
+	room = kfifo_avail(&port->port.xmit_fifo);
+
+	if (port->tx_boundary)
+		room = 0;
+
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return room;
@@ -267,7 +299,7 @@ static unsigned int dbc_tty_chars_in_buffer(struct tty_struct *tty)
 	unsigned int		chars;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	chars = kfifo_len(&port->write_fifo);
+	chars = kfifo_len(&port->port.xmit_fifo);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return chars;
@@ -425,7 +457,8 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 		goto err_idr;
 	}
 
-	ret = kfifo_alloc(&port->write_fifo, DBC_WRITE_BUF_SIZE, GFP_KERNEL);
+	ret = kfifo_alloc(&port->port.xmit_fifo, DBC_WRITE_BUF_SIZE,
+			  GFP_KERNEL);
 	if (ret)
 		goto err_exit_port;
 
@@ -454,7 +487,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 	xhci_dbc_free_requests(&port->read_pool);
 	xhci_dbc_free_requests(&port->write_pool);
 err_free_fifo:
-	kfifo_free(&port->write_fifo);
+	kfifo_free(&port->port.xmit_fifo);
 err_exit_port:
 	idr_remove(&dbc_tty_minors, port->minor);
 err_idr:
@@ -479,7 +512,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	idr_remove(&dbc_tty_minors, port->minor);
 	mutex_unlock(&dbc_tty_minors_lock);
 
-	kfifo_free(&port->write_fifo);
+	kfifo_free(&port->port.xmit_fifo);
 	xhci_dbc_free_requests(&port->read_pool);
 	xhci_dbc_free_requests(&port->read_queue);
 	xhci_dbc_free_requests(&port->write_pool);
diff --git a/drivers/usb/host/xhci-port.h b/drivers/usb/host/xhci-port.h
new file mode 100644
index 000000000000..f19efb966d18
--- /dev/null
+++ b/drivers/usb/host/xhci-port.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
+/* true: device connected */
+#define PORT_CONNECT	(1 << 0)
+/* true: port enabled */
+#define PORT_PE		(1 << 1)
+/* bit 2 reserved and zeroed */
+/* true: port has an over-current condition */
+#define PORT_OC		(1 << 3)
+/* true: port reset signaling asserted */
+#define PORT_RESET	(1 << 4)
+/* Port Link State - bits 5:8
+ * A read gives the current link PM state of the port,
+ * a write with Link State Write Strobe set sets the link state.
+ */
+#define PORT_PLS_MASK	(0xf << 5)
+#define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
+#define XDEV_U2		(0x2 << 5)
+#define XDEV_U3		(0x3 << 5)
+#define XDEV_DISABLED	(0x4 << 5)
+#define XDEV_RXDETECT	(0x5 << 5)
+#define XDEV_INACTIVE	(0x6 << 5)
+#define XDEV_POLLING	(0x7 << 5)
+#define XDEV_RECOVERY	(0x8 << 5)
+#define XDEV_HOT_RESET	(0x9 << 5)
+#define XDEV_COMP_MODE	(0xa << 5)
+#define XDEV_TEST_MODE	(0xb << 5)
+#define XDEV_RESUME	(0xf << 5)
+
+/* true: port has power (see HCC_PPC) */
+#define PORT_POWER	(1 << 9)
+/* bits 10:13 indicate device speed:
+ * 0 - undefined speed - port hasn't be initialized by a reset yet
+ * 1 - full speed
+ * 2 - low speed
+ * 3 - high speed
+ * 4 - super speed
+ * 5-15 reserved
+ */
+#define DEV_SPEED_MASK		(0xf << 10)
+#define	XDEV_FS			(0x1 << 10)
+#define	XDEV_LS			(0x2 << 10)
+#define	XDEV_HS			(0x3 << 10)
+#define	XDEV_SS			(0x4 << 10)
+#define	XDEV_SSP		(0x5 << 10)
+#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
+#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
+#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
+#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
+#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
+#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
+#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
+
+/* Bits 20:23 in the Slot Context are the speed for the device */
+#define	SLOT_SPEED_FS		(XDEV_FS << 10)
+#define	SLOT_SPEED_LS		(XDEV_LS << 10)
+#define	SLOT_SPEED_HS		(XDEV_HS << 10)
+#define	SLOT_SPEED_SS		(XDEV_SS << 10)
+#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
+/* Port Indicator Control */
+#define PORT_LED_OFF	(0 << 14)
+#define PORT_LED_AMBER	(1 << 14)
+#define PORT_LED_GREEN	(2 << 14)
+#define PORT_LED_MASK	(3 << 14)
+/* Port Link State Write Strobe - set this when changing link state */
+#define PORT_LINK_STROBE	(1 << 16)
+/* true: connect status change */
+#define PORT_CSC	(1 << 17)
+/* true: port enable change */
+#define PORT_PEC	(1 << 18)
+/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
+ * into an enabled state, and the device into the default state.  A "warm" reset
+ * also resets the link, forcing the device through the link training sequence.
+ * SW can also look at the Port Reset register to see when warm reset is done.
+ */
+#define PORT_WRC	(1 << 19)
+/* true: over-current change */
+#define PORT_OCC	(1 << 20)
+/* true: reset change - 1 to 0 transition of PORT_RESET */
+#define PORT_RC		(1 << 21)
+/* port link status change - set on some port link state transitions:
+ *  Transition				Reason
+ *  ------------------------------------------------------------------------------
+ *  - U3 to Resume			Wakeup signaling from a device
+ *  - Resume to Recovery to U0		USB 3.0 device resume
+ *  - Resume to U0			USB 2.0 device resume
+ *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
+ *  - U3 to U0				Software resume of USB 2.0 device complete
+ *  - U2 to U0				L1 resume of USB 2.1 device complete
+ *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
+ *  - U0 to disabled			L1 entry error with USB 2.1 device
+ *  - Any state to inactive		Error on USB 3.0 port
+ */
+#define PORT_PLC	(1 << 22)
+/* port configure error change - port failed to configure its link partner */
+#define PORT_CEC	(1 << 23)
+#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
+				 PORT_RC | PORT_PLC | PORT_CEC)
+
+
+/* Cold Attach Status - xHC can set this bit to report device attached during
+ * Sx state. Warm port reset should be perfomed to clear this bit and move port
+ * to connected state.
+ */
+#define PORT_CAS	(1 << 24)
+/* wake on connect (enable) */
+#define PORT_WKCONN_E	(1 << 25)
+/* wake on disconnect (enable) */
+#define PORT_WKDISC_E	(1 << 26)
+/* wake on over-current (enable) */
+#define PORT_WKOC_E	(1 << 27)
+/* bits 28:29 reserved */
+/* true: device is non-removable - for USB 3.0 roothub emulation */
+#define PORT_DEV_REMOVE	(1 << 30)
+/* Initiate a warm port reset - complete when PORT_WRC is '1' */
+#define PORT_WR		(1 << 31)
+
+/* We mark duplicate entries with -1 */
+#define DUPLICATE_ENTRY ((u8)(-1))
+
+/* Port Power Management Status and Control - port_power_base bitmasks */
+/* Inactivity timer value for transitions into U1, in microseconds.
+ * Timeout can be up to 127us.  0xFF means an infinite timeout.
+ */
+#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
+#define PORT_U1_TIMEOUT_MASK	0xff
+/* Inactivity timer value for transitions into U2 */
+#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
+#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
+/* Bits 24:31 for port testing */
+
+/* USB2 Protocol PORTSPMSC */
+#define	PORT_L1S_MASK		7
+#define	PORT_L1S_SUCCESS	1
+#define	PORT_RWE		(1 << 3)
+#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
+#define	PORT_HIRD_MASK		(0xf << 4)
+#define	PORT_L1DS_MASK		(0xff << 8)
+#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
+#define	PORT_HLE		(1 << 16)
+#define PORT_TEST_MODE_SHIFT	28
+
+/* USB3 Protocol PORTLI  Port Link Information */
+#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
+#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
+
+/* USB2 Protocol PORTHLPMC */
+#define PORT_HIRDM(p)((p) & 3)
+#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
+#define PORT_BESLD(p)(((p) & 0xf) << 10)
+
+/* use 512 microseconds as USB2 LPM L1 default timeout. */
+#define XHCI_L1_TIMEOUT		512
+
+/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
+ * Safe to use with mixed HIRD and BESL systems (host and device) and is used
+ * by other operating systems.
+ *
+ * XHCI 1.0 errata 8/14/12 Table 13 notes:
+ * "Software should choose xHC BESL/BESLD field values that do not violate a
+ * device's resume latency requirements,
+ * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
+ * or not program values < '4' if BLC = '0' and a BESL device is attached.
+ */
+#define XHCI_DEFAULT_BESL	4
+
+/*
+ * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
+ * to complete link training. usually link trainig completes much faster
+ * so check status 10 times with 36ms sleep in places we need to wait for
+ * polling to complete.
+ */
+#define XHCI_PORT_POLLING_LFPS_TIME  36
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index bd725a4adbc8..0b526edf636f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -23,6 +23,9 @@
 #include	"xhci-ext-caps.h"
 #include "pci-quirks.h"
 
+#include "xhci-port.h"
+#include "xhci-caps.h"
+
 /* max buffer size for trace and debug messages */
 #define XHCI_MSG_MAX		500
 
@@ -63,90 +66,6 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-/* hc_capbase bitmasks */
-/* bits 7:0 - how long is the Capabilities register */
-#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
-/* bits 31:16	*/
-#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
-
-/* HCSPARAMS1 - hcs_params1 - bitmasks */
-/* bits 0:7, Max Device Slots */
-#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
-#define HCS_SLOTS_MASK		0xff
-/* bits 8:18, Max Interrupters */
-#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
-/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
-#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
-
-/* HCSPARAMS2 - hcs_params2 - bitmasks */
-/* bits 0:3, frames or uframes that SW needs to queue transactions
- * ahead of the HW to meet periodic deadlines */
-#define HCS_IST(p)		(((p) >> 0) & 0xf)
-/* bits 4:7, max number of Event Ring segments */
-#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
-/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
-/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
-/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
-#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
-
-/* HCSPARAMS3 - hcs_params3 - bitmasks */
-/* bits 0:7, Max U1 to U0 latency for the roothub ports */
-#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
-/* bits 16:31, Max U2 to U0 latency for the roothub ports */
-#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
-
-/* HCCPARAMS - hcc_params - bitmasks */
-/* true: HC can use 64-bit address pointers */
-#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
-/* true: HC can do bandwidth negotiation */
-#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
-/* true: HC uses 64-byte Device Context structures
- * FIXME 64-byte context structures aren't supported yet.
- */
-#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
-/* true: HC has port power switches */
-#define HCC_PPC(p)		((p) & (1 << 3))
-/* true: HC has port indicators */
-#define HCS_INDICATOR(p)	((p) & (1 << 4))
-/* true: HC has Light HC Reset Capability */
-#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
-/* true: HC supports latency tolerance messaging */
-#define HCC_LTC(p)		((p) & (1 << 6))
-/* true: no secondary Stream ID Support */
-#define HCC_NSS(p)		((p) & (1 << 7))
-/* true: HC supports Stopped - Short Packet */
-#define HCC_SPC(p)		((p) & (1 << 9))
-/* true: HC has Contiguous Frame ID Capability */
-#define HCC_CFC(p)		((p) & (1 << 11))
-/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
-#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
-/* Extended Capabilities pointer from PCI base - section 5.3.6 */
-#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
-
-#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
-
-/* db_off bitmask - bits 0:1 reserved */
-#define	DBOFF_MASK	(~0x3)
-
-/* run_regs_off bitmask - bits 0:4 reserved */
-#define	RTSOFF_MASK	(~0x1f)
-
-/* HCCPARAMS2 - hcc_params2 - bitmasks */
-/* true: HC supports U3 entry Capability */
-#define	HCC2_U3C(p)		((p) & (1 << 0))
-/* true: HC supports Configure endpoint command Max exit latency too large */
-#define	HCC2_CMC(p)		((p) & (1 << 1))
-/* true: HC supports Force Save context Capability */
-#define	HCC2_FSC(p)		((p) & (1 << 2))
-/* true: HC supports Compliance Transition Capability */
-#define	HCC2_CTC(p)		((p) & (1 << 3))
-/* true: HC support Large ESIT payload Capability > 48k */
-#define	HCC2_LEC(p)		((p) & (1 << 4))
-/* true: HC support Configuration Information Capability */
-#define	HCC2_CIC(p)		((p) & (1 << 5))
-/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
-#define	HCC2_ETC(p)		((p) & (1 << 6))
-
 /* Number of registers per port */
 #define	NUM_PORT_REGS	4
 
@@ -292,181 +211,6 @@ struct xhci_op_regs {
 #define CONFIG_CIE		(1 << 9)
 /* bits 10:31 - reserved and should be preserved */
 
-/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
-/* true: device connected */
-#define PORT_CONNECT	(1 << 0)
-/* true: port enabled */
-#define PORT_PE		(1 << 1)
-/* bit 2 reserved and zeroed */
-/* true: port has an over-current condition */
-#define PORT_OC		(1 << 3)
-/* true: port reset signaling asserted */
-#define PORT_RESET	(1 << 4)
-/* Port Link State - bits 5:8
- * A read gives the current link PM state of the port,
- * a write with Link State Write Strobe set sets the link state.
- */
-#define PORT_PLS_MASK	(0xf << 5)
-#define XDEV_U0		(0x0 << 5)
-#define XDEV_U1		(0x1 << 5)
-#define XDEV_U2		(0x2 << 5)
-#define XDEV_U3		(0x3 << 5)
-#define XDEV_DISABLED	(0x4 << 5)
-#define XDEV_RXDETECT	(0x5 << 5)
-#define XDEV_INACTIVE	(0x6 << 5)
-#define XDEV_POLLING	(0x7 << 5)
-#define XDEV_RECOVERY	(0x8 << 5)
-#define XDEV_HOT_RESET	(0x9 << 5)
-#define XDEV_COMP_MODE	(0xa << 5)
-#define XDEV_TEST_MODE	(0xb << 5)
-#define XDEV_RESUME	(0xf << 5)
-
-/* true: port has power (see HCC_PPC) */
-#define PORT_POWER	(1 << 9)
-/* bits 10:13 indicate device speed:
- * 0 - undefined speed - port hasn't be initialized by a reset yet
- * 1 - full speed
- * 2 - low speed
- * 3 - high speed
- * 4 - super speed
- * 5-15 reserved
- */
-#define DEV_SPEED_MASK		(0xf << 10)
-#define	XDEV_FS			(0x1 << 10)
-#define	XDEV_LS			(0x2 << 10)
-#define	XDEV_HS			(0x3 << 10)
-#define	XDEV_SS			(0x4 << 10)
-#define	XDEV_SSP		(0x5 << 10)
-#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
-#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
-#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
-#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
-#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
-#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
-#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
-#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
-
-/* Bits 20:23 in the Slot Context are the speed for the device */
-#define	SLOT_SPEED_FS		(XDEV_FS << 10)
-#define	SLOT_SPEED_LS		(XDEV_LS << 10)
-#define	SLOT_SPEED_HS		(XDEV_HS << 10)
-#define	SLOT_SPEED_SS		(XDEV_SS << 10)
-#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
-/* Port Indicator Control */
-#define PORT_LED_OFF	(0 << 14)
-#define PORT_LED_AMBER	(1 << 14)
-#define PORT_LED_GREEN	(2 << 14)
-#define PORT_LED_MASK	(3 << 14)
-/* Port Link State Write Strobe - set this when changing link state */
-#define PORT_LINK_STROBE	(1 << 16)
-/* true: connect status change */
-#define PORT_CSC	(1 << 17)
-/* true: port enable change */
-#define PORT_PEC	(1 << 18)
-/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
- * into an enabled state, and the device into the default state.  A "warm" reset
- * also resets the link, forcing the device through the link training sequence.
- * SW can also look at the Port Reset register to see when warm reset is done.
- */
-#define PORT_WRC	(1 << 19)
-/* true: over-current change */
-#define PORT_OCC	(1 << 20)
-/* true: reset change - 1 to 0 transition of PORT_RESET */
-#define PORT_RC		(1 << 21)
-/* port link status change - set on some port link state transitions:
- *  Transition				Reason
- *  ------------------------------------------------------------------------------
- *  - U3 to Resume			Wakeup signaling from a device
- *  - Resume to Recovery to U0		USB 3.0 device resume
- *  - Resume to U0			USB 2.0 device resume
- *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
- *  - U3 to U0				Software resume of USB 2.0 device complete
- *  - U2 to U0				L1 resume of USB 2.1 device complete
- *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
- *  - U0 to disabled			L1 entry error with USB 2.1 device
- *  - Any state to inactive		Error on USB 3.0 port
- */
-#define PORT_PLC	(1 << 22)
-/* port configure error change - port failed to configure its link partner */
-#define PORT_CEC	(1 << 23)
-#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
-				 PORT_RC | PORT_PLC | PORT_CEC)
-
-
-/* Cold Attach Status - xHC can set this bit to report device attached during
- * Sx state. Warm port reset should be perfomed to clear this bit and move port
- * to connected state.
- */
-#define PORT_CAS	(1 << 24)
-/* wake on connect (enable) */
-#define PORT_WKCONN_E	(1 << 25)
-/* wake on disconnect (enable) */
-#define PORT_WKDISC_E	(1 << 26)
-/* wake on over-current (enable) */
-#define PORT_WKOC_E	(1 << 27)
-/* bits 28:29 reserved */
-/* true: device is non-removable - for USB 3.0 roothub emulation */
-#define PORT_DEV_REMOVE	(1 << 30)
-/* Initiate a warm port reset - complete when PORT_WRC is '1' */
-#define PORT_WR		(1 << 31)
-
-/* We mark duplicate entries with -1 */
-#define DUPLICATE_ENTRY ((u8)(-1))
-
-/* Port Power Management Status and Control - port_power_base bitmasks */
-/* Inactivity timer value for transitions into U1, in microseconds.
- * Timeout can be up to 127us.  0xFF means an infinite timeout.
- */
-#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
-#define PORT_U1_TIMEOUT_MASK	0xff
-/* Inactivity timer value for transitions into U2 */
-#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
-#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
-/* Bits 24:31 for port testing */
-
-/* USB2 Protocol PORTSPMSC */
-#define	PORT_L1S_MASK		7
-#define	PORT_L1S_SUCCESS	1
-#define	PORT_RWE		(1 << 3)
-#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
-#define	PORT_HIRD_MASK		(0xf << 4)
-#define	PORT_L1DS_MASK		(0xff << 8)
-#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
-#define	PORT_HLE		(1 << 16)
-#define PORT_TEST_MODE_SHIFT	28
-
-/* USB3 Protocol PORTLI  Port Link Information */
-#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
-#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
-
-/* USB2 Protocol PORTHLPMC */
-#define PORT_HIRDM(p)((p) & 3)
-#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
-#define PORT_BESLD(p)(((p) & 0xf) << 10)
-
-/* use 512 microseconds as USB2 LPM L1 default timeout. */
-#define XHCI_L1_TIMEOUT		512
-
-/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
- * Safe to use with mixed HIRD and BESL systems (host and device) and is used
- * by other operating systems.
- *
- * XHCI 1.0 errata 8/14/12 Table 13 notes:
- * "Software should choose xHC BESL/BESLD field values that do not violate a
- * device's resume latency requirements,
- * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
- * or not program values < '4' if BLC = '0' and a BESL device is attached.
- */
-#define XHCI_DEFAULT_BESL	4
-
-/*
- * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
- * to complete link training. usually link trainig completes much faster
- * so check status 10 times with 36ms sleep in places we need to wait for
- * polling to complete.
- */
-#define XHCI_PORT_POLLING_LFPS_TIME  36
-
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index ce83f558fe44..3d44e181dbb5 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -503,6 +503,7 @@ static void typec_altmode_release(struct device *dev)
 		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
+	put_device(alt->adev.dev.parent);
 	kfree(alt);
 }
 
@@ -552,6 +553,8 @@ typec_register_altmode(struct device *parent,
 	alt->adev.dev.type = &typec_altmode_dev_type;
 	dev_set_name(&alt->adev.dev, "%s.%u", dev_name(parent), id);
 
+	get_device(alt->adev.dev.parent);
+
 	/* Link partners and plugs with the ports */
 	if (!is_port)
 		typec_altmode_set_partner(alt);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e9a0b27e1c4f..0dcf7fecaf55 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3562,6 +3562,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	spin_lock(&cache->lock);
 	if (cache->ro)
 		space_info->bytes_readonly += num_bytes;
+	else if (btrfs_is_zoned(cache->fs_info))
+		space_info->bytes_zone_unusable += num_bytes;
 	cache->reserved -= num_bytes;
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index fdab48c1abb8..4572cf55b401 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -341,8 +341,8 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 			return di;
 	}
 	/* Adjust return code if the key was not found in the next leaf. */
-	if (ret > 0)
-		ret = 0;
+	if (ret >= 0)
+		ret = -ENOENT;
 
 	return ERR_PTR(ret);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 894887640c43..a79da940f5b2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4532,11 +4532,8 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
 		di = btrfs_search_dir_index_item(root, path, dir_ino, &fname.disk_name);
-		if (IS_ERR_OR_NULL(di)) {
-			if (!di)
-				ret = -ENOENT;
-			else
-				ret = PTR_ERR(di);
+		if (IS_ERR(di)) {
+			ret = PTR_ERR(di);
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
diff --git a/fs/exec.c b/fs/exec.c
index 65d3ebc24fd3..a42c9b8b070d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -141,13 +141,11 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Check do_open_execat() for an explanation.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	fsnotify_open(file);
@@ -927,16 +925,16 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
-		goto out;
+		return file;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * In the past the regular type check was here. It moved to may_open() in
+	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
+	 * an invariant that all non-regular files error out before we get here.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	err = deny_write_access(file);
@@ -946,7 +944,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (name->name[0] != '\0')
 		fsnotify_open(file);
 
-out:
 	return file;
 
 exit:
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 384aa6dfdb95..a6b1d748df16 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -187,7 +187,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag || bmp->db_numag >= MAXAG) {
+	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 7d31833e68d1..19bc8eea2b35 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -77,7 +77,8 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 	const unsigned long clear_bits =
 		(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 		 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+		 BIT(BH_Delay));
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -409,7 +410,8 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+			 BIT(BH_Delay));
 
 		bh = head = page_buffers(page);
 		do {
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 1351fb02e140..7ab452710572 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -193,8 +193,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
-	u32 t32, off, asize;
+	u32 t32, off, asize, prev_type;
 	u16 t16;
+	u64 data_size, alloc_size, tot_size;
 
 	if (!attr) {
 		u32 total = le32_to_cpu(rec->total);
@@ -213,6 +214,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (!is_rec_inuse(rec))
 			return NULL;
 
+		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
 		/* Check if input attr inside record. */
@@ -226,6 +228,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
+		/* Overflow check. */
+		if (off + asize < off)
+			return NULL;
+
+		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -245,7 +252,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
-	if ((t32 & 0xf) || (t32 > 0x100))
+	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+		return NULL;
+
+	/* attributes in record must be ordered by type */
+	if (t32 < prev_type)
 		return NULL;
 
 	/* Check overflow and boundary. */
@@ -254,16 +265,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
+		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
 
 		t16 = le16_to_cpu(attr->res.data_off);
-
 		if (t16 > asize)
 			return NULL;
 
-		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
 			return NULL;
 
 		if (attr->name_len &&
@@ -274,21 +284,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}
 
-	/* Check some nonresident fields. */
-	if (attr->name_len &&
-	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-		    le16_to_cpu(attr->nres.run_off)) {
+	/* Check nonresident fields. */
+	if (attr->non_res != 1)
 		return NULL;
-	}
 
-	if (attr->nres.svcn || !is_attr_ext(attr)) {
+	t16 = le16_to_cpu(attr->nres.run_off);
+	if (t16 > asize)
+		return NULL;
+
+	t32 = sizeof(short) * attr->name_len;
+	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+		return NULL;
+
+	/* Check start/end vcn. */
+	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+		return NULL;
+
+	data_size = le64_to_cpu(attr->nres.data_size);
+	if (le64_to_cpu(attr->nres.valid_size) > data_size)
+		return NULL;
+
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (data_size > alloc_size)
+		return NULL;
+
+	t32 = mi->sbi->cluster_mask;
+	if (alloc_size & t32)
+		return NULL;
+
+	if (!attr->nres.svcn && is_attr_ext(attr)) {
+		/* First segment of sparse/compressed attribute */
+		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+			return NULL;
+
+		tot_size = le64_to_cpu(attr->nres.total_size);
+		if (tot_size & t32)
+			return NULL;
+
+		if (tot_size > alloc_size)
+			return NULL;
+	} else {
 		if (asize + 8 < SIZEOF_NONRESIDENT)
 			return NULL;
 
 		if (attr->nres.c_unit)
 			return NULL;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-		return NULL;
+	}
 
 	return attr;
 }
diff --git a/fs/open.c b/fs/open.c
index 0d63c94e1c5e..2f8845488798 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1361,6 +1361,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
 
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 992ac7d20e5e..9975711236b2 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3131,6 +3131,15 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		return rc;
 
 	if (indatalen) {
+		unsigned int len;
+
+		if (WARN_ON_ONCE(smb3_encryption_required(tcon) &&
+				 (check_add_overflow(total_len - 1,
+						     ALIGN(indatalen, 8), &len) ||
+				  len > MAX_CIFS_SMALL_BUFFER_SIZE))) {
+			cifs_small_buf_release(req);
+			return -EIO;
+		}
 		/*
 		 * indatalen is usually small at a couple of bytes max, so
 		 * just allocate through generic pool
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 77471e33ccf7..d7d6ccd0af06 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1838,6 +1838,7 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	struct extent_position nepos;
 	struct kernel_lb_addr neloc;
 	int ver, adsize;
+	int err = 0;
 
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -1882,10 +1883,12 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	if (epos->offset + adsize > sb->s_blocksize) {
 		struct kernel_lb_addr cp_loc;
 		uint32_t cp_len;
-		int cp_type;
+		int8_t cp_type;
 
 		epos->offset -= adsize;
-		cp_type = udf_current_aext(inode, epos, &cp_loc, &cp_len, 0);
+		err = udf_current_aext(inode, epos, &cp_loc, &cp_len, &cp_type, 0);
+		if (err <= 0)
+			goto err_out;
 		cp_len |= ((uint32_t)cp_type) << 30;
 
 		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
@@ -1900,6 +1903,9 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	*epos = nepos;
 
 	return 0;
+err_out:
+	brelse(bh);
+	return err;
 }
 
 /*
@@ -2050,9 +2056,12 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 {
 	int8_t etype;
 	unsigned int indirections = 0;
+	int ret = 0;
 
-	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
-	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
+	while ((ret = udf_current_aext(inode, epos, eloc, elen,
+				       &etype, inc)) > 0) {
+		if (etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+			break;
 		udf_pblk_t block;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
@@ -2073,14 +2082,17 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		}
 	}
 
-	return etype;
+	return ret > 0 ? etype : -1;
 }
 
-int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
-			struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+/*
+ * Returns 1 on success, -errno on error, 0 on hit EOF.
+ */
+int udf_current_aext(struct inode *inode, struct extent_position *epos,
+		     struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		     int inc)
 {
 	int alen;
-	int8_t etype;
 	uint8_t *ptr;
 	struct short_ad *sad;
 	struct long_ad *lad;
@@ -2095,20 +2107,23 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		alen = udf_file_entry_alloc_offset(inode) +
 							iinfo->i_lenAlloc;
 	} else {
+		struct allocExtDesc *header =
+			(struct allocExtDesc *)epos->bh->b_data;
+
 		if (!epos->offset)
 			epos->offset = sizeof(struct allocExtDesc);
 		ptr = epos->bh->b_data + epos->offset;
-		alen = sizeof(struct allocExtDesc) +
-			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
-							lengthAllocDescs);
+		if (check_add_overflow(sizeof(struct allocExtDesc),
+				le32_to_cpu(header->lengthAllocDescs), &alen))
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
 	case ICBTAG_FLAG_AD_SHORT:
 		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
 		if (!sad)
-			return -1;
-		etype = le32_to_cpu(sad->extLength) >> 30;
+			return 0;
+		*etype = le32_to_cpu(sad->extLength) >> 30;
 		eloc->logicalBlockNum = le32_to_cpu(sad->extPosition);
 		eloc->partitionReferenceNum =
 				iinfo->i_location.partitionReferenceNum;
@@ -2117,17 +2132,17 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	case ICBTAG_FLAG_AD_LONG:
 		lad = udf_get_filelongad(ptr, alen, &epos->offset, inc);
 		if (!lad)
-			return -1;
-		etype = le32_to_cpu(lad->extLength) >> 30;
+			return 0;
+		*etype = le32_to_cpu(lad->extLength) >> 30;
 		*eloc = lelb_to_cpu(lad->extLocation);
 		*elen = le32_to_cpu(lad->extLength) & UDF_EXTENT_LENGTH_MASK;
 		break;
 	default:
 		udf_debug("alloc_type = %u unsupported\n", iinfo->i_alloc_type);
-		return -1;
+		return -EINVAL;
 	}
 
-	return etype;
+	return 1;
 }
 
 static int udf_insert_aext(struct inode *inode, struct extent_position epos,
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 036ebd892b85..f0de6e106ce6 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -192,6 +192,7 @@ int udf_truncate_extents(struct inode *inode)
 	loff_t byte_offset;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int ret = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -221,8 +222,8 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		lenalloc -= sizeof(struct allocExtDesc);
 
-	while ((etype = udf_current_aext(inode, &epos, &eloc,
-					 &elen, 0)) != -1) {
+	while ((ret = udf_current_aext(inode, &epos, &eloc,
+				       &elen, &etype, 0)) > 0) {
 		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 			udf_write_aext(inode, &epos, &neloc, nelen, 0);
 			if (indirect_ext_len) {
@@ -257,6 +258,11 @@ int udf_truncate_extents(struct inode *inode)
 		}
 	}
 
+	if (ret < 0) {
+		brelse(epos.bh);
+		return ret;
+	}
+
 	if (indirect_ext_len) {
 		BUG_ON(!epos.bh);
 		udf_free_blocks(sb, NULL, &epos.block, 0, indirect_ext_len);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d35aa42bb577..1d19434d4a47 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -174,8 +174,9 @@ extern void udf_write_aext(struct inode *, struct extent_position *,
 extern int8_t udf_delete_aext(struct inode *, struct extent_position);
 extern int8_t udf_next_aext(struct inode *, struct extent_position *,
 			    struct kernel_lb_addr *, uint32_t *, int);
-extern int8_t udf_current_aext(struct inode *, struct extent_position *,
-			       struct kernel_lb_addr *, uint32_t *, int);
+extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
+			    struct kernel_lb_addr *eloc, uint32_t *elen,
+			    int8_t *etype, int inc);
 extern void udf_update_extra_perms(struct inode *inode, umode_t mode);
 
 /* misc.c */
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index b097bd57b2e4..2d1ec0e6ee01 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -143,6 +143,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc(void);
+extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
+extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0373e0935990..fbbd0df1106b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3274,6 +3274,13 @@ static inline void netif_tx_wake_all_queues(struct net_device *dev)
 
 static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_queue)
 {
+	/* Paired with READ_ONCE() from dev_watchdog() */
+	WRITE_ONCE(dev_queue->trans_start, jiffies);
+
+	/* This barrier is paired with smp_mb() from dev_watchdog() */
+	smp_mb__before_atomic();
+
+	/* Must be an atomic op see netif_txq_try_stop() */
 	set_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state);
 }
 
@@ -3389,6 +3396,12 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 	if (likely(dql_avail(&dev_queue->dql) >= 0))
 		return;
 
+	/* Paired with READ_ONCE() from dev_watchdog() */
+	WRITE_ONCE(dev_queue->trans_start, jiffies);
+
+	/* This barrier is paired with smp_mb() from dev_watchdog() */
+	smp_mb__before_atomic();
+
 	set_bit(__QUEUE_STATE_STACK_XOFF, &dev_queue->state);
 
 	/*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 1c9b3f27f2d3..5a83db0ac763 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -890,10 +890,8 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  * The following are helper functions for the low level drivers.
  */
 
-extern void uart_handle_dcd_change(struct uart_port *uport,
-		unsigned int status);
-extern void uart_handle_cts_change(struct uart_port *uport,
-		unsigned int status);
+extern void uart_handle_dcd_change(struct uart_port *uport, bool active);
+extern void uart_handle_cts_change(struct uart_port *uport, bool active);
 
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index dcb61ec11424..49dc172dedc7 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -170,7 +170,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	send, please arise a tasklet or workqueue to do the real data transfer.
  *	Do not send data in this hook, it may lead to a deadlock.
  *
- * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, unsigned int status)``
+ * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, bool active)``
  *
  *	Tells the discipline that the DCD pin has changed its status. Used
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
@@ -238,7 +238,7 @@ struct tty_ldisc_ops {
 	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
 			       const char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *tty);
-	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
+	void	(*dcd_change)(struct tty_struct *tty, bool active);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count);
 	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 9783b9107d76..d759208e0a6c 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -149,6 +149,9 @@ struct usb_os_desc_table {
  *	GetStatus() request when the recipient is Interface.
  * @func_suspend: callback to be called when
  *	SetFeature(FUNCTION_SUSPEND) is reseived
+ * @func_suspended: Indicates whether the function is in function suspend state.
+ * @func_wakeup_armed: Indicates whether the function is armed by the host for
+ *	wakeup signaling.
  *
  * A single USB function uses one or more interfaces, and should in most
  * cases support operation at both full and high speeds.  Each function is
@@ -219,6 +222,8 @@ struct usb_function {
 	int			(*get_status)(struct usb_function *);
 	int			(*func_suspend)(struct usb_function *,
 						u8 suspend_opt);
+	bool			func_suspended;
+	bool			func_wakeup_armed;
 	/* private: */
 	/* internals */
 	struct list_head		list;
@@ -240,6 +245,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 5bec668b41dc..705b76f8dddb 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -309,6 +309,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*func_wakeup)(struct usb_gadget *gadget, int intf_id);
 	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index c7f1dd34ea47..41fc7f12971a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -383,6 +383,7 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index b9e5a22ae3ff..b39d06bbb839 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -355,13 +355,12 @@ static inline int genlmsg_multicast(const struct genl_family *family,
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: offset of multicast group in groups array
- * @flags: allocation flags
  *
  * This function must hold the RTNL or rcu_read_lock().
  */
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags);
+			    unsigned int group);
 
 /**
  * genlmsg_unicast - unicast a netlink message
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
new file mode 100644
index 000000000000..5236d78bbdeb
--- /dev/null
+++ b/include/net/netdev_queues.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NET_QUEUES_H
+#define _LINUX_NET_QUEUES_H
+
+#include <linux/netdevice.h>
+
+/**
+ * DOC: Lockless queue stopping / waking helpers.
+ *
+ * The netif_txq_maybe_stop() and __netif_txq_completed_wake()
+ * macros are designed to safely implement stopping
+ * and waking netdev queues without full lock protection.
+ *
+ * We assume that there can be no concurrent stop attempts and no concurrent
+ * wake attempts. The try-stop should happen from the xmit handler,
+ * while wake up should be triggered from NAPI poll context.
+ * The two may run concurrently (single producer, single consumer).
+ *
+ * The try-stop side is expected to run from the xmit handler and therefore
+ * it does not reschedule Tx (netif_tx_start_queue() instead of
+ * netif_tx_wake_queue()). Uses of the ``stop`` macros outside of the xmit
+ * handler may lead to xmit queue being enabled but not run.
+ * The waking side does not have similar context restrictions.
+ *
+ * The macros guarantee that rings will not remain stopped if there's
+ * space available, but they do *not* prevent false wake ups when
+ * the ring is full! Drivers should check for ring full at the start
+ * for the xmit handler.
+ *
+ * All descriptor ring indexes (and other relevant shared state) must
+ * be updated before invoking the macros.
+ */
+
+#define netif_txq_try_stop(txq, get_desc, start_thrs)			\
+	({								\
+		int _res;						\
+									\
+		netif_tx_stop_queue(txq);				\
+		/* Producer index and stop bit must be visible		\
+		 * to consumer before we recheck.			\
+		 * Pairs with a barrier in __netif_txq_maybe_wake().	\
+		 */							\
+		smp_mb__after_atomic();					\
+									\
+		/* We need to check again in a case another		\
+		 * CPU has just made room available.			\
+		 */							\
+		_res = 0;						\
+		if (unlikely(get_desc >= start_thrs)) {			\
+			netif_tx_start_queue(txq);			\
+			_res = -1;					\
+		}							\
+		_res;							\
+	})								\
+
+/**
+ * netif_txq_maybe_stop() - locklessly stop a Tx queue, if needed
+ * @txq:	struct netdev_queue to stop/start
+ * @get_desc:	get current number of free descriptors (see requirements below!)
+ * @stop_thrs:	minimal number of available descriptors for queue to be left
+ *		enabled
+ * @start_thrs:	minimal number of descriptors to re-enable the queue, can be
+ *		equal to @stop_thrs or higher to avoid frequent waking
+ *
+ * All arguments may be evaluated multiple times, beware of side effects.
+ * @get_desc must be a formula or a function call, it must always
+ * return up-to-date information when evaluated!
+ * Expected to be used from ndo_start_xmit, see the comment on top of the file.
+ *
+ * Returns:
+ *	 0 if the queue was stopped
+ *	 1 if the queue was left enabled
+ *	-1 if the queue was re-enabled (raced with waking)
+ */
+#define netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs)	\
+	({								\
+		int _res;						\
+									\
+		_res = 1;						\
+		if (unlikely(get_desc < stop_thrs))			\
+			_res = netif_txq_try_stop(txq, get_desc, start_thrs); \
+		_res;							\
+	})								\
+
+
+/**
+ * __netif_txq_maybe_wake() - locklessly wake a Tx queue, if needed
+ * @txq:	struct netdev_queue to stop/start
+ * @get_desc:	get current number of free descriptors (see requirements below!)
+ * @start_thrs:	minimal number of descriptors to re-enable the queue
+ * @down_cond:	down condition, predicate indicating that the queue should
+ *		not be woken up even if descriptors are available
+ *
+ * All arguments may be evaluated multiple times.
+ * @get_desc must be a formula or a function call, it must always
+ * return up-to-date information when evaluated!
+ *
+ * Returns:
+ *	 0 if the queue was woken up
+ *	 1 if the queue was already enabled (or disabled but @down_cond is true)
+ *	-1 if the queue was left unchanged (@start_thrs not reached)
+ */
+#define __netif_txq_maybe_wake(txq, get_desc, start_thrs, down_cond)	\
+	({								\
+		int _res;						\
+									\
+		_res = -1;						\
+		if (likely(get_desc > start_thrs)) {			\
+			/* Make sure that anybody stopping the queue after \
+			 * this sees the new next_to_clean.		\
+			 */						\
+			smp_mb();					\
+			_res = 1;					\
+			if (unlikely(netif_tx_queue_stopped(txq)) &&	\
+			    !(down_cond)) {				\
+				netif_tx_wake_queue(txq);		\
+				_res = 0;				\
+			}						\
+		}							\
+		_res;							\
+	})
+
+#define netif_txq_maybe_wake(txq, get_desc, start_thrs)		\
+	__netif_txq_maybe_wake(txq, get_desc, start_thrs, false)
+
+/* subqueue variants follow */
+
+#define netif_subqueue_try_stop(dev, idx, get_desc, start_thrs)		\
+	({								\
+		struct netdev_queue *txq;				\
+									\
+		txq = netdev_get_tx_queue(dev, idx);			\
+		netif_txq_try_stop(txq, get_desc, start_thrs);		\
+	})
+
+#define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
+	({								\
+		struct netdev_queue *txq;				\
+									\
+		txq = netdev_get_tx_queue(dev, idx);			\
+		netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs); \
+	})
+
+#endif
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 5b9c2c535702..bf670929622d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -326,20 +326,25 @@ struct xfrm_if_cb {
 void xfrm_if_register_cb(const struct xfrm_if_cb *ifcb);
 void xfrm_if_unregister_cb(void);
 
+struct xfrm_dst_lookup_params {
+	struct net *net;
+	int tos;
+	int oif;
+	xfrm_address_t *saddr;
+	xfrm_address_t *daddr;
+	u32 mark;
+	__u8 ipproto;
+	union flowi_uli uli;
+};
+
 struct net_device;
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
 	struct dst_ops		*dst_ops;
-	struct dst_entry	*(*dst_lookup)(struct net *net,
-					       int tos, int oif,
-					       const xfrm_address_t *saddr,
-					       const xfrm_address_t *daddr,
-					       u32 mark);
-	int			(*get_saddr)(struct net *net, int oif,
-					     xfrm_address_t *saddr,
-					     xfrm_address_t *daddr,
-					     u32 mark);
+	struct dst_entry	*(*dst_lookup)(const struct xfrm_dst_lookup_params *params);
+	int			(*get_saddr)(xfrm_address_t *saddr,
+					     const struct xfrm_dst_lookup_params *params);
 	int			(*fill_dst)(struct xfrm_dst *xdst,
 					    struct net_device *dev,
 					    const struct flowi *fl);
@@ -1659,10 +1664,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark);
+struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lookup_params *params);
 
 struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 58c7fc75da75..667f49a64a50 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5717,11 +5717,6 @@ enum {
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
 };
 
-/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
-enum {
-	BPF_F_INGRESS			= (1ULL << 0),
-};
-
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
 enum {
 	BPF_F_TUNINFO_IPV6		= (1ULL << 0),
@@ -5865,10 +5860,12 @@ enum {
 	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
 };
 
-/* Flags for bpf_redirect_map helper */
+/* Flags for bpf_redirect and bpf_redirect_map helpers */
 enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
+	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
+	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
+	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
+#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
 };
 
 #define __bpf_md_ptr(type, name)	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c684a0e1c4b..9f9996cdb6e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7987,6 +7987,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!type) {
 		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
 			relo_idx, relo->type_id);
+		kfree(specs);
 		return -EINVAL;
 	}
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index e051cbb07dac..9699c30c3dc4 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -326,9 +326,11 @@ static int dev_map_hash_get_next_key(struct bpf_map *map, void *key,
 
 static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 				struct xdp_frame **frames, int n,
-				struct net_device *dev)
+				struct net_device *tx_dev,
+				struct net_device *rx_dev)
 {
-	struct xdp_txq_info txq = { .dev = dev };
+	struct xdp_txq_info txq = { .dev = tx_dev };
+	struct xdp_rxq_info rxq = { .dev = rx_dev };
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
@@ -339,6 +341,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		switch (act) {
@@ -353,7 +356,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 			bpf_warn_invalid_xdp_action(NULL, xdp_prog, act);
 			fallthrough;
 		case XDP_ABORTED:
-			trace_xdp_exception(dev, xdp_prog, act);
+			trace_xdp_exception(tx_dev, xdp_prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame_rx_napi(xdpf);
@@ -381,7 +384,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	}
 
 	if (bq->xdp_prog) {
-		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
+		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev, bq->dev_rx);
 		if (!to_send)
 			goto out;
 	}
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index a1911391a864..af75c54eb84f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -37,7 +37,7 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
-	spinlock_t spinlock ____cacheline_aligned_in_smp;
+	raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
 	 * the spinlock that is used for kernel-producer ring buffers. This is
@@ -170,7 +170,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	if (!rb)
 		return NULL;
 
-	spin_lock_init(&rb->spinlock);
+	raw_spin_lock_init(&rb->spinlock);
 	atomic_set(&rb->busy, 0);
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
@@ -407,10 +407,10 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 
 	if (in_nmi()) {
-		if (!spin_trylock_irqsave(&rb->spinlock, flags))
+		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
 			return NULL;
 	} else {
-		spin_lock_irqsave(&rb->spinlock, flags);
+		raw_spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
 	pend_pos = rb->pending_pos;
@@ -436,7 +436,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	 */
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
-		spin_unlock_irqrestore(&rb->spinlock, flags);
+		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
 
@@ -448,7 +448,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
-	spin_unlock_irqrestore(&rb->spinlock, flags);
+	raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..f7ef58090c7d 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -119,7 +119,7 @@ static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *co
 		rcu_read_lock();
 		pid = find_pid_ns(common->pid, common->ns);
 		if (pid) {
-			task = get_pid_task(pid, PIDTYPE_TGID);
+			task = get_pid_task(pid, PIDTYPE_PID);
 			*tid = common->pid;
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb4073781a3c..bb54f1f4fafb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1924,10 +1924,16 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 		b->module = mod;
 		b->offset = offset;
 
+		/* sort() reorders entries by value, so b may no longer point
+		 * to the right entry after this
+		 */
 		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 		     kfunc_btf_cmp_by_off, NULL);
+	} else {
+		btf = b->btf;
 	}
-	return b->btf;
+
+	return btf;
 }
 
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 8127673bfc45..05e73d209aa8 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -290,6 +290,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	struct posix_clock_desc cd;
 	int err;
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
@@ -299,9 +302,6 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
-	if (!timespec64_valid_strict(ts))
-		return -EINVAL;
-
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3fdde232eaa9..583961a9e539 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2179,8 +2179,6 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
-	if (ret == -ENOENT)
-		goto unlock;
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index eef9806bb9b1..ba48b5e270e1 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -265,7 +265,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		}
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
-	} else if (len > MAX_EVENT_NAME_LEN) {
+	} else if (len >= MAX_EVENT_NAME_LEN) {
 		trace_probe_log_err(offset, EVENT_TOO_LONG);
 		return -EINVAL;
 	}
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0c70172555b4..4c3bd0516038 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -177,6 +177,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	BT_DBG("parent %p, sk %p", parent, sk);
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a660c428e220..38f542665f19 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -745,8 +745,7 @@ static int __init bnep_init(void)
 	if (flt[0])
 		BT_INFO("BNEP filters: %s", flt);
 
-	bnep_sock_init();
-	return 0;
+	return bnep_sock_init();
 }
 
 static void __exit bnep_exit(void)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b61abddc7bd4..27efca5dc7bb 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -68,6 +68,16 @@ struct iso_pinfo {
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *iso_sock_hold(struct iso_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&iso_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void iso_sock_timeout(struct work_struct *work)
 {
 	struct iso_conn *conn = container_of(work, struct iso_conn,
@@ -75,9 +85,7 @@ static void iso_sock_timeout(struct work_struct *work)
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -184,9 +192,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	iso_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (sk) {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 92ea01f9def3..ad5afde17213 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -77,6 +77,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -88,9 +98,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -195,9 +203,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 6f65c6eb0d90..3f3286cf438e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2416,9 +2416,9 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 
 /* Internal, non-exposed redirect flags. */
 enum {
-	BPF_F_NEIGH	= (1ULL << 1),
-	BPF_F_PEER	= (1ULL << 2),
-	BPF_F_NEXTHOP	= (1ULL << 3),
+	BPF_F_NEIGH	= (1ULL << 16),
+	BPF_F_PEER	= (1ULL << 17),
+	BPF_F_NEXTHOP	= (1ULL << 18),
 #define BPF_F_REDIRECT_INTERNAL	(BPF_F_NEIGH | BPF_F_PEER | BPF_F_NEXTHOP)
 };
 
@@ -2428,6 +2428,8 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	struct sk_buff *clone;
 	int ret;
 
+	BUILD_BUG_ON(BPF_F_REDIRECT_INTERNAL & BPF_F_REDIRECT_FLAGS);
+
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f07778c34098..430ca93ba939 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -276,17 +276,19 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	/* Account for reference dev->ip_ptr (below) */
 	refcount_set(&in_dev->refcnt, 1);
 
-	err = devinet_sysctl_register(in_dev);
-	if (err) {
-		in_dev->dead = 1;
-		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
-		in_dev_put(in_dev);
-		in_dev = NULL;
-		goto out;
+	if (dev != blackhole_netdev) {
+		err = devinet_sysctl_register(in_dev);
+		if (err) {
+			in_dev->dead = 1;
+			neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+			in_dev_put(in_dev);
+			in_dev = NULL;
+			goto out;
+		}
+		ip_mc_init_dev(in_dev);
+		if (dev->flags & IFF_UP)
+			ip_mc_up(in_dev);
 	}
-	ip_mc_init_dev(in_dev);
-	if (dev->flags & IFF_UP)
-		ip_mc_up(in_dev);
 
 	/* we can receive as soon as ip_ptr is set -- do this last */
 	rcu_assign_pointer(dev->ip_ptr, in_dev);
@@ -331,6 +333,19 @@ static void inetdev_destroy(struct in_device *in_dev)
 	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
 }
 
+static int __init inet_blackhole_dev_init(void)
+{
+	int err = 0;
+
+	rtnl_lock();
+	if (!inetdev_init(blackhole_netdev))
+		err = -ENOMEM;
+	rtnl_unlock();
+
+	return err;
+}
+late_initcall(inet_blackhole_dev_init);
+
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
 	const struct in_ifaddr *ifa;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index c267c5e066e9..569186f741fb 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -977,21 +977,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -1084,7 +1094,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
 		}
 
@@ -1110,7 +1120,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	reqsk_put(req);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 3d0dfa6cf9f9..76f3f38b110f 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -17,47 +17,43 @@
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
-					    int tos, int oif,
-					    const xfrm_address_t *saddr,
-					    const xfrm_address_t *daddr,
-					    u32 mark)
+static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
+					    const struct xfrm_dst_lookup_params *params)
 {
 	struct rtable *rt;
 
 	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = daddr->a4;
-	fl4->flowi4_tos = tos;
-	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl4->flowi4_mark = mark;
-	if (saddr)
-		fl4->saddr = saddr->a4;
-
-	rt = __ip_route_output_key(net, fl4);
+	fl4->daddr = params->daddr->a4;
+	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							    params->oif);
+	fl4->flowi4_mark = params->mark;
+	if (params->saddr)
+		fl4->saddr = params->saddr->a4;
+	fl4->flowi4_proto = params->ipproto;
+	fl4->uli = params->uli;
+
+	rt = __ip_route_output_key(params->net, fl4);
 	if (!IS_ERR(rt))
 		return &rt->dst;
 
 	return ERR_CAST(rt);
 }
 
-static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm4_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
+	return __xfrm4_dst_lookup(&fl4, params);
 }
 
-static int xfrm4_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm4_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct flowi4 fl4;
 
-	dst = __xfrm4_dst_lookup(net, &fl4, 0, oif, NULL, daddr, mark);
+	dst = __xfrm4_dst_lookup(&fl4, params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index b7b5dbf5d037..8c1092ff3fe2 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -23,23 +23,24 @@
 #include <net/ip6_route.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi6 fl6;
 	struct dst_entry *dst;
 	int err;
 
 	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl6.flowi6_mark = mark;
-	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
-	if (saddr)
-		memcpy(&fl6.saddr, saddr, sizeof(fl6.saddr));
+	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							   params->oif);
+	fl6.flowi6_mark = params->mark;
+	memcpy(&fl6.daddr, params->daddr, sizeof(fl6.daddr));
+	if (params->saddr)
+		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
 
-	dst = ip6_route_output(net, NULL, &fl6);
+	fl6.flowi4_proto = params->ipproto;
+	fl6.uli = params->uli;
+
+	dst = ip6_route_output(params->net, NULL, &fl6);
 
 	err = dst->error;
 	if (dst->error) {
@@ -50,15 +51,14 @@ static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
 	return dst;
 }
 
-static int xfrm6_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm6_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
 
-	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
+	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
@@ -68,7 +68,8 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
+	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+			   &saddr->in6);
 	dst_release(dst);
 	return 0;
 }
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index a901fd14fe3b..e27e00cb16c6 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -115,7 +115,7 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -143,7 +143,7 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index d80abd6ccaf8..6dcf4bc7e30b 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -79,7 +79,7 @@ static struct xt_target nflog_tg_reg[] __read_mostly = {
 	{
 		.name       = "NFLOG",
 		.revision   = 0,
-		.family     = NFPROTO_IPV4,
+		.family     = NFPROTO_IPV6,
 		.checkentry = nflog_tg_check,
 		.destroy    = nflog_tg_destroy,
 		.target     = nflog_tg,
diff --git a/net/netfilter/xt_TRACE.c b/net/netfilter/xt_TRACE.c
index f3fa4f11348c..a642ff09fc8e 100644
--- a/net/netfilter/xt_TRACE.c
+++ b/net/netfilter/xt_TRACE.c
@@ -49,6 +49,7 @@ static struct xt_target trace_tg_reg[] __read_mostly = {
 		.target		= trace_tg,
 		.checkentry	= trace_tg_check,
 		.destroy	= trace_tg_destroy,
+		.me		= THIS_MODULE,
 	},
 #endif
 };
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index f76fe04fc9a4..65b965ca40ea 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -62,7 +62,7 @@ static struct xt_target mark_tg_reg[] __read_mostly = {
 	{
 		.name           = "MARK",
 		.revision       = 2,
-		.family         = NFPROTO_IPV4,
+		.family         = NFPROTO_IPV6,
 		.target         = mark_tg,
 		.targetsize     = sizeof(struct xt_mark_tginfo2),
 		.me             = THIS_MODULE,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 505d3b910cc2..fd3c1f1ca6ea 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1147,15 +1147,11 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (!family->netnsok) {
+	if (!family->netnsok)
 		genlmsg_multicast_netns(&genl_ctrl, &init_net, msg, 0,
 					0, GFP_KERNEL);
-	} else {
-		rcu_read_lock();
-		genlmsg_multicast_allns(&genl_ctrl, msg, 0,
-					0, GFP_ATOMIC);
-		rcu_read_unlock();
-	}
+	else
+		genlmsg_multicast_allns(&genl_ctrl, msg, 0, 0);
 
 	return 0;
 }
@@ -1500,23 +1496,23 @@ static int __init genl_init(void)
 
 core_initcall(genl_init);
 
-static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
-			 gfp_t flags)
+static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group)
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
 	bool delivered = false;
 	int err;
 
+	rcu_read_lock();
 	for_each_net_rcu(net) {
 		if (prev) {
-			tmp = skb_clone(skb, flags);
+			tmp = skb_clone(skb, GFP_ATOMIC);
 			if (!tmp) {
 				err = -ENOMEM;
 				goto error;
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
-					      portid, group, flags);
+					      portid, group, GFP_ATOMIC);
 			if (!err)
 				delivered = true;
 			else if (err != -ESRCH)
@@ -1525,27 +1521,31 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 
 		prev = net;
 	}
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, GFP_ATOMIC);
+
+	rcu_read_unlock();
 
-	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
 		return err;
 	return delivered ? 0 : -ESRCH;
  error:
+	rcu_read_unlock();
+
 	kfree_skb(skb);
 	return err;
 }
 
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags)
+			    unsigned int group)
 {
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return -EINVAL;
 
 	group = family->mcgrp_offset + group;
-	return genlmsg_mcast(skb, portid, group, flags);
+	return genlmsg_mcast(skb, portid, group);
 }
 EXPORT_SYMBOL(genlmsg_multicast_allns);
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 5a361deb804a..05bd1e9bca36 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1493,8 +1493,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 			bool skip_sw = tc_skip_sw(fl_flags);
 			bool skip_hw = tc_skip_hw(fl_flags);
 
-			if (tc_act_bind(act->tcfa_flags))
+			if (tc_act_bind(act->tcfa_flags)) {
+				/* Action is created by classifier and is not
+				 * standalone. Check that the user did not set
+				 * any action flags different than the
+				 * classifier flags, and inherit the flags from
+				 * the classifier for the compatibility case
+				 * where no flags were specified at all.
+				 */
+				if ((tc_act_skip_sw(act->tcfa_flags) && !skip_sw) ||
+				    (tc_act_skip_hw(act->tcfa_flags) && !skip_hw)) {
+					NL_SET_ERR_MSG(extack,
+						       "Mismatch between action and filter offload flags");
+					err = -EINVAL;
+					goto err;
+				}
+				if (skip_sw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_SW;
+				if (skip_hw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_HW;
 				continue;
+			}
+
+			/* Action is standalone */
 			if (skip_sw != tc_act_skip_sw(act->tcfa_flags) ||
 			    skip_hw != tc_act_skip_hw(act->tcfa_flags)) {
 				NL_SET_ERR_MSG(extack,
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6ab9359c1706..b51af871a621 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -505,19 +505,28 @@ static void dev_watchdog(struct timer_list *t)
 			unsigned int timedout_ms = 0;
 			unsigned int i;
 			unsigned long trans_start;
+			unsigned long oldest_start = jiffies;
 
 			for (i = 0; i < dev->num_tx_queues; i++) {
 				struct netdev_queue *txq;
 
 				txq = netdev_get_tx_queue(dev, i);
+				if (!netif_xmit_stopped(txq))
+					continue;
+
+				/* Paired with WRITE_ONCE() + smp_mb...() in
+				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
+				 */
+				smp_mb();
 				trans_start = READ_ONCE(txq->trans_start);
-				if (netif_xmit_stopped(txq) &&
-				    time_after(jiffies, (trans_start +
-							 dev->watchdog_timeo))) {
+
+				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
 					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
 					atomic_long_inc(&txq->trans_timeout);
 					break;
 				}
+				if (time_after(oldest_start, trans_start))
+					oldest_start = trans_start;
 			}
 
 			if (unlikely(timedout_ms)) {
@@ -530,7 +539,7 @@ static void dev_watchdog(struct timer_list *t)
 				netif_unfreeze_queues(dev);
 			}
 			if (!mod_timer(&dev->watchdog_timer,
-				       round_jiffies(jiffies +
+				       round_jiffies(oldest_start +
 						     dev->watchdog_timeo)))
 				release = false;
 		}
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 07f6f5343dd7..212fef2b72f5 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1681,7 +1681,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 21b8bf23e4ee..399314cfab90 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -749,7 +749,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
 
 	write_lock(&sn->pnetids_ndev.lock);
 	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
-		if (smc_pnet_match(pnetid, pe->pnetid)) {
+		if (smc_pnet_match(pnetid, pi->pnetid)) {
 			refcount_inc(&pi->refcnt);
 			kfree(pe);
 			goto unlock;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4df7a285a7de..3e1c4e23484d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17616,10 +17616,8 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
@@ -18237,10 +18235,8 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 21269e8f2db4..2535ee034a5c 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -248,6 +248,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
+		struct xfrm_dst_lookup_params params;
+
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
 			saddr = &x->props.saddr;
 			daddr = &x->id.daddr;
@@ -256,9 +258,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 			daddr = &x->props.saddr;
 		}
 
-		dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
-					x->props.family,
-					xfrm_smark_get(0, x));
+		memset(&params, 0, sizeof(params));
+		params.net = net;
+		params.saddr = saddr;
+		params.daddr = daddr;
+		params.mark = xfrm_smark_get(0, x);
+		dst = __xfrm_dst_lookup(x->props.family, &params);
 		if (IS_ERR(dst))
 			return 0;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5fddde2d5bc4..a022f4984687 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -251,10 +251,8 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
 	return rcu_dereference(xfrm_if_cb);
 }
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark)
+struct dst_entry *__xfrm_dst_lookup(int family,
+				    const struct xfrm_dst_lookup_params *params)
 {
 	const struct xfrm_policy_afinfo *afinfo;
 	struct dst_entry *dst;
@@ -263,7 +261,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
+	dst = afinfo->dst_lookup(params);
 
 	rcu_read_unlock();
 
@@ -277,6 +275,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
 {
+	struct xfrm_dst_lookup_params params;
 	struct net *net = xs_net(x);
 	xfrm_address_t *saddr = &x->props.saddr;
 	xfrm_address_t *daddr = &x->id.daddr;
@@ -291,7 +290,29 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
+	params.net = net;
+	params.saddr = saddr;
+	params.daddr = daddr;
+	params.tos = tos;
+	params.oif = oif;
+	params.mark = mark;
+	params.ipproto = x->id.proto;
+	if (x->encap) {
+		switch (x->encap->encap_type) {
+		case UDP_ENCAP_ESPINUDP:
+			params.ipproto = IPPROTO_UDP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		case TCP_ENCAP_ESPINTCP:
+			params.ipproto = IPPROTO_TCP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		}
+	}
+
+	dst = __xfrm_dst_lookup(family, &params);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
@@ -2346,15 +2367,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
 }
 
 static int
-xfrm_get_saddr(struct net *net, int oif, xfrm_address_t *local,
-	       xfrm_address_t *remote, unsigned short family, u32 mark)
+xfrm_get_saddr(unsigned short family, xfrm_address_t *saddr,
+	       const struct xfrm_dst_lookup_params *params)
 {
 	int err;
 	const struct xfrm_policy_afinfo *afinfo = xfrm_policy_get_afinfo(family);
 
 	if (unlikely(afinfo == NULL))
 		return -EINVAL;
-	err = afinfo->get_saddr(net, oif, local, remote, mark);
+	err = afinfo->get_saddr(saddr, params);
 	rcu_read_unlock();
 	return err;
 }
@@ -2383,9 +2404,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 			remote = &tmpl->id.daddr;
 			local = &tmpl->saddr;
 			if (xfrm_addr_any(local, tmpl->encap_family)) {
-				error = xfrm_get_saddr(net, fl->flowi_oif,
-						       &tmp, remote,
-						       tmpl->encap_family, 0);
+				struct xfrm_dst_lookup_params params;
+
+				memset(&params, 0, sizeof(params));
+				params.net = net;
+				params.oif = fl->flowi_oif;
+				params.daddr = remote;
+				error = xfrm_get_saddr(tmpl->encap_family, &tmp,
+						       &params);
 				if (error)
 					goto fail;
 				local = &tmp;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 0cc4ed29e901..2f6e0513dee5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -176,6 +176,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct netlink_ext_ack *extack)
 {
 	int err;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -196,7 +197,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 
@@ -978,7 +982,9 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	memcpy(ap, auth, sizeof(struct xfrm_algo_auth));
+	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
+	ap->alg_key_len = auth->alg_key_len;
+	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
 		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
 	else
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a00d19139436..ab804d4ea911 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -621,6 +621,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
 	mutex_lock(&fsi->state->policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -629,26 +636,21 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -657,13 +659,12 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	}
 
 	selinux_policy_commit(fsi->state, &load_state);
-
 	length = count;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->state->policy_mutex);
 	vfree(data);
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 842fe127c537..b5b3b4d177aa 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -172,6 +172,9 @@ static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
 			step = max(step, amdtp_syt_intervals[i]);
 	}
 
+	if (step == 0)
+		return -EINVAL;
+
 	t.min = roundup(s->min, step);
 	t.max = rounddown(s->max, step);
 	t.integer = 1;
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index e41316e2e983..892223d9e64a 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1411,8 +1411,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		kctrl = snd_hda_gen_add_kctl(&spec->gen, "Line Out Playback Volume",
 					     &cs42l42_dac_volume_mixer);
 		/* Update Line Out kcontrol template */
-		kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
-				       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
+		if (kctrl)
+			kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
+					       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
 		cs8409_enable_ur(codec, 0);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c8a3f6499c2..a8bc95ffa41a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3854,20 +3854,18 @@ static void alc_default_init(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
 
-	if (hp_pin_sense)
-		msleep(100);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(75);
+	}
 }
 
 static void alc_default_shutup(struct hda_codec *codec)
@@ -3883,22 +3881,20 @@ static void alc_default_shutup(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
-
-	if (!spec->no_shutup_pins)
 		snd_hda_codec_write(codec, hp_pin, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	if (hp_pin_sense)
-		msleep(100);
+		msleep(75);
 
+		if (!spec->no_shutup_pins)
+			snd_hda_codec_write(codec, hp_pin, 0,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
 	alc_auto_setup_eapd(codec, false);
 	alc_shutup_pins(codec);
 }
@@ -7287,6 +7283,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+	ALC255_FIXUP_PREDATOR_SUBWOOFER,
 	ALC299_FIXUP_PREDATOR_SPK,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
 	ALC289_FIXUP_DELL_SPK2,
@@ -8607,6 +8604,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC255_FIXUP_PREDATOR_SUBWOOFER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x17, 0x90170151 }, /* use as internal speaker (LFE) */
+			{ 0x1b, 0x90170152 } /* use as internal speaker (back) */
+		}
+	},
 	[ALC299_FIXUP_PREDATOR_SPK] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9539,6 +9543,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1166, "Acer Veriton N4640G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x1167, "Acer Veriton N6640G", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x1025, 0x1177, "Acer Predator G9-593", ALC255_FIXUP_PREDATOR_SUBWOOFER),
+	SND_PCI_QUIRK(0x1025, 0x1178, "Acer Predator G9-593", ALC255_FIXUP_PREDATOR_SUBWOOFER),
 	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 1639f3b66fac..aa45c472994e 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -909,7 +909,7 @@ static const struct reg_default rx_defaults[] = {
 	{ CDC_RX_BCL_VBAT_PK_EST2, 0x01 },
 	{ CDC_RX_BCL_VBAT_PK_EST3, 0x40 },
 	{ CDC_RX_BCL_VBAT_RF_PROC1, 0x2A },
-	{ CDC_RX_BCL_VBAT_RF_PROC1, 0x00 },
+	{ CDC_RX_BCL_VBAT_RF_PROC2, 0x00 },
 	{ CDC_RX_BCL_VBAT_TAC1, 0x00 },
 	{ CDC_RX_BCL_VBAT_TAC2, 0x18 },
 	{ CDC_RX_BCL_VBAT_TAC3, 0x18 },
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index cf1cd0460ad9..4b155e49cbfc 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -604,6 +604,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
+	/* Set to avoid channel swap */
+	val_cr4 |= FSL_SAI_CR4_FCONT;
+
 	/* Set to output mode to avoid tri-stated data pins */
 	if (tx)
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
@@ -690,7 +693,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
-			   FSL_SAI_CR4_CHMOD_MASK,
+			   FSL_SAI_CR4_CHMOD_MASK | FSL_SAI_CR4_FCONT_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b4d616a44023..e2799f39a81e 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -137,6 +137,7 @@
 
 /* SAI Transmit and Receive Configuration 4 Register */
 
+#define FSL_SAI_CR4_FCONT_MASK	BIT(28)
 #define FSL_SAI_CR4_FCONT	BIT(28)
 #define FSL_SAI_CR4_FCOMB_SHIFT BIT(26)
 #define FSL_SAI_CR4_FCOMB_SOFT  BIT(27)
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 4387cca893c5..b6314e924c8f 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1236,6 +1236,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	/* Allocation for i2sctl regmap fields */
 	drvdata->i2sctl = devm_kzalloc(&pdev->dev, sizeof(struct lpaif_i2sctl),
 					GFP_KERNEL);
+	if (!drvdata->i2sctl)
+		return -ENOMEM;
 
 	/* Initialize bitfields for dai I2SCTL register */
 	ret = lpass_cpu_init_i2sctl_bitfields(dev, drvdata->i2sctl,
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 9626a9ef78c2..41be09a07ca7 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -153,6 +153,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{.compatible = "qcom,sm8250-sndcard"},
+	{.compatible = "qcom,qrb4210-rb2-sndcard"},
 	{.compatible = "qcom,qrb5165-rb5-sndcard"},
 	{}
 };
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b57fbf8fff4..b09205d92511 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -171,7 +171,7 @@ $(OUTPUT)/%:%.c
 ifeq ($(SRCARCH),x86)
 LLD := lld
 else
-LLD := ld
+LLD := $(shell command -v $(LD))
 endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds

