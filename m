Return-Path: <stable+bounces-58113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039769282B4
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02571C24408
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D32145355;
	Fri,  5 Jul 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="laEzRU7+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34813B5BB;
	Fri,  5 Jul 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164642; cv=none; b=mKDjuSAAGUXXbcKv0O1v3jVWo+HAK6vYvt25CNxISt0ohycI1uNwBvnNg4JZGBnXj1y77aaRKqNR5SfAC8Os0lIZKWU6DOLZqrWsQP2ai3yUA6RhCf6VG/+lb04l/pm81yimAm35Ekle5b5rwKlXG39mBqAPq+YryHsEq2rnEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164642; c=relaxed/simple;
	bh=nQnW+8dZN4Yq0jeQQVU7XFtFYr1GoL6bFPUgwhcEspQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej09t3n3hQbDOJGbXVTJKLiaJfSYSl7qxPsj5Tg2PkU3Qo1sPK17XlTPSBp1w7hQeBfMAKN5bo8gMFyryZbRLDznR55SMtNbG10UgrAtoHAT3t1+KcT3VRbBR4mf6SGdOZYlL8Zrs2jWXnXkCDZAL+npKgO/m/YvcKN8KbqjB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=laEzRU7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20527C4AF0A;
	Fri,  5 Jul 2024 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720164642;
	bh=nQnW+8dZN4Yq0jeQQVU7XFtFYr1GoL6bFPUgwhcEspQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laEzRU7+Tq1OzAS9dt3RJxhTXy8vDWHQMp2ir1/ybGt8VhkGzTGhJfbyL11xIPFAF
	 3ulBaAZGwbIPvyNt995Xybsuz6RIBYG0eMko3VEJdBttzj+/T3hldCYKZzp1PjV4C1
	 tDcJcCMX/YsJy172AwH37z8HXnovFeZkAvo6Xuzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.221
Date: Fri,  5 Jul 2024 09:30:29 +0200
Message-ID: <2024070529-dense-zen-7f3c@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024070528-easily-guru-a612@gregkh>
References: <2024070528-easily-guru-a612@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
index b386e4128a79..d3e01d8c043c 100644
--- a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
+++ b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
@@ -22,7 +22,7 @@ description: |
   google,cros-ec-spi or google,cros-ec-i2c.
 
 allOf:
-  - $ref: i2c-controller.yaml#
+  - $ref: /schemas/i2c/i2c-controller.yaml#
 
 properties:
   compatible:
diff --git a/Makefile b/Makefile
index 9304408d8ace..b0e22161cd55 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 220
+SUBLEVEL = 221
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index c5609afa6101..a6622a0d9b58 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -84,7 +84,7 @@ eeprom@52 {
 &keypad {
 	samsung,keypad-num-rows = <2>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e2d76ea4404e..7138bf291437 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -447,7 +447,7 @@ buck9_reg: BUCK9 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index 49971203a8aa..6e6bef907a72 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -65,7 +65,7 @@ cooling_map1: map1 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index bbc3bff50856..75ea8e03bef0 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -124,6 +124,7 @@ hdmi: hdmi@10116000 {
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 3746f23dc3df..bc4df59df3f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -687,6 +687,7 @@ spdif: spdif@ff880000 {
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -698,6 +699,7 @@ i2s_2ch: i2s-2ch@ff890000 {
 		clocks = <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
 		dmas = <&dmac_bus 6>, <&dmac_bus 7>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -711,6 +713,7 @@ i2s_8ch: i2s-8ch@ff898000 {
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_8ch_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 912b83e784bb..48ee1fe3aca4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -410,6 +410,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
 #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
+#define KVM_ARM64_VCPU_IN_WFI		(1 << 8) /* WFI instruction trapped */
 
 #define vcpu_has_sve(vcpu) (system_supports_sve() && \
 			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 107f08e03b9f..2f120f254e26 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -840,7 +840,7 @@ __SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SYSCALL(__NR_io_pgetevents_time64, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4d63fcd7574b..afe8be2fef88 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -332,13 +332,15 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 	 */
 	preempt_disable();
 	kvm_vgic_vmcr_sync(vcpu);
-	vgic_v4_put(vcpu, true);
+	vcpu->arch.flags |= KVM_ARM64_VCPU_IN_WFI;
+	vgic_v4_put(vcpu);
 	preempt_enable();
 }
 
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
+	vcpu->arch.flags &= ~KVM_ARM64_VCPU_IN_WFI;
 	vgic_v4_load(vcpu);
 	preempt_enable();
 }
@@ -649,7 +651,7 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9cdf39a94a63..29c12bf9601a 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -682,7 +682,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index b5fa73c9fd35..cdfaaeabbb7d 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -310,14 +310,15 @@ void vgic_v4_teardown(struct kvm *kvm)
 	its_vm->vpes = NULL;
 }
 
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
+int vgic_v4_put(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
 	if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
 		return 0;
 
-	return its_make_vpe_non_resident(vpe, need_db);
+	return its_make_vpe_non_resident(vpe,
+			vcpu->arch.flags & KVM_ARM64_VCPU_IN_WFI);
 }
 
 int vgic_v4_load(struct kvm_vcpu *vcpu)
@@ -328,6 +329,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (!vgic_supports_direct_msis(vcpu->kvm) || vpe->resident)
 		return 0;
 
+	if (vcpu->arch.flags & KVM_ARM64_VCPU_IN_WFI)
+		return 0;
+
 	/*
 	 * Before making the VPE resident, make sure the redistributor
 	 * corresponding to our current CPU expects us here. See the
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index ba4018929733..3594062a1bba 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -7,6 +7,7 @@
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/hexagon/include/asm/syscalls.h b/arch/hexagon/include/asm/syscalls.h
new file mode 100644
index 000000000000..40f2d08bec92
--- /dev/null
+++ b/arch/hexagon/include/asm/syscalls.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm-generic/syscalls.h>
+
+asmlinkage long sys_hexagon_fadvise64_64(int fd, int advice,
+	                                  u32 a2, u32 a3, u32 a4, u32 a5);
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index 432c4db1b623..21ae22306b5d 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -36,5 +36,6 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/kernel/syscalltab.c b/arch/hexagon/kernel/syscalltab.c
index 0fadd582cfc7..5d98bdc494ec 100644
--- a/arch/hexagon/kernel/syscalltab.c
+++ b/arch/hexagon/kernel/syscalltab.c
@@ -14,6 +14,13 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
+SYSCALL_DEFINE6(hexagon_fadvise64_64, int, fd, int, advice,
+		SC_ARG64(offset), SC_ARG64(len))
+{
+	return ksys_fadvise64_64(fd, SC_VAL64(loff_t, offset), SC_VAL64(loff_t, len), advice);
+}
+#define sys_fadvise64_64 sys_hexagon_fadvise64_64
+
 void *sys_call_table[__NR_syscalls] = {
 #include <asm/unistd.h>
 };
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 16063081d61e..ac75797739d2 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -110,7 +110,8 @@ static void bcm6358_quirks(void)
 	 * RAC flush causes kernel panics on BCM6358 when booting from TP1
 	 * because the bootloader is not initializing it properly.
 	 */
-	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31));
+	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31)) ||
+				  !!BMIPS_GET_CBR();
 }
 
 static void bcm6368_quirks(void)
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 32817c954435..67fc2d9b7cb1 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -354,7 +354,7 @@
 412	n32	utimensat_time64		sys_utimensat
 413	n32	pselect6_time64			compat_sys_pselect6_time64
 414	n32	ppoll_time64			compat_sys_ppoll_time64
-416	n32	io_pgetevents_time64		sys_io_pgetevents
+416	n32	io_pgetevents_time64		compat_sys_io_pgetevents_time64
 417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
 418	n32	mq_timedsend_time64		sys_mq_timedsend
 419	n32	mq_timedreceive_time64		sys_mq_timedreceive
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 29f5f28cf5ce..6036af4f30e2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -403,7 +403,7 @@
 412	o32	utimensat_time64		sys_utimensat			sys_utimensat
 413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	o32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/mips/pci/ops-rc32434.c b/arch/mips/pci/ops-rc32434.c
index 874ed6df9768..34b9323bdabb 100644
--- a/arch/mips/pci/ops-rc32434.c
+++ b/arch/mips/pci/ops-rc32434.c
@@ -112,8 +112,8 @@ static int read_config_dword(struct pci_bus *bus, unsigned int devfn,
 	 * gives them time to settle
 	 */
 	if (where == PCI_VENDOR_ID) {
-		if (ret == 0xffffffff || ret == 0x00000000 ||
-		    ret == 0x0000ffff || ret == 0xffff0000) {
+		if (*val == 0xffffffff || *val == 0x00000000 ||
+		    *val == 0x0000ffff || *val == 0xffff0000) {
 			if (delay > 4)
 				return 0;
 			delay *= 2;
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100644
new mode 100755
index d919a0d813a1..38de2a9c3cf1
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -230,12 +230,18 @@ static inline uint64_t __cvmx_pcie_build_config_addr(int pcie_port, int bus,
 {
 	union cvmx_pcie_address pcie_addr;
 	union cvmx_pciercx_cfg006 pciercx_cfg006;
+	union cvmx_pciercx_cfg032 pciercx_cfg032;
 
 	pciercx_cfg006.u32 =
 	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG006(pcie_port));
 	if ((bus <= pciercx_cfg006.s.pbnum) && (dev != 0))
 		return 0;
 
+	pciercx_cfg032.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
+	if ((pciercx_cfg032.s.dlla == 0) || (pciercx_cfg032.s.lt == 1))
+		return 0;
+
 	pcie_addr.u64 = 0;
 	pcie_addr.config.upper = 2;
 	pcie_addr.config.io = 1;
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index dfe9254ee74b..e9c70f9a2f50 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -108,7 +108,7 @@
 95	common	fchown			sys_fchown
 96	common	getpriority		sys_getpriority
 97	common	setpriority		sys_setpriority
-98	common	recv			sys_recv
+98	common	recv			sys_recv			compat_sys_recv
 99	common	statfs			sys_statfs			compat_sys_statfs
 100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101	common	stat64			sys_stat64
@@ -135,7 +135,7 @@
 120	common	clone			sys_clone_wrapper
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
-123	common	recvfrom		sys_recvfrom
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 124	32	adjtimex		sys_adjtimex_time32
 124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 1a60188f74ad..f3b46a0fa708 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -453,7 +453,7 @@ long plpar_hcall_norets_notrace(unsigned long opcode, ...);
  * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
 #define PLPAR_HCALL_BUFSIZE 4
-long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
@@ -467,7 +467,7 @@ long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
  * plpar_hcall, but plpar_hcall_raw works in real mode and does not
  * calculate hypervisor call statistics.
  */
-long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
@@ -478,8 +478,8 @@ long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
  * PLPAR_HCALL9_BUFSIZE to size the return argument buffer.
  */
 #define PLPAR_HCALL9_BUFSIZE 9
-long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
-long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall9(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
+long plpar_hcall9_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
 
 struct hvcall_mpp_data {
 	unsigned long entitled_mem;
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 0182b291248a..058d21f493fa 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -541,12 +541,12 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_inw(port)		_rec_inw(port)
 #define __do_inl(port)		_rec_inl(port)
 #else /* CONFIG_PPC32 */
-#define __do_outb(val, port)	writeb(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_outw(val, port)	writew(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_outl(val, port)	writel(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_inb(port)		readb((PCI_IO_ADDR)_IO_BASE + port);
-#define __do_inw(port)		readw((PCI_IO_ADDR)_IO_BASE + port);
-#define __do_inl(port)		readl((PCI_IO_ADDR)_IO_BASE + port);
+#define __do_outb(val, port)	writeb(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_outw(val, port)	writew(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_outl(val, port)	writel(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_inb(port)		readb((PCI_IO_ADDR)(_IO_BASE + port));
+#define __do_inw(port)		readw((PCI_IO_ADDR)(_IO_BASE + port));
+#define __do_inl(port)		readl((PCI_IO_ADDR)(_IO_BASE + port));
 #endif /* !CONFIG_PPC32 */
 
 #ifdef CONFIG_EEH
@@ -562,12 +562,12 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_writesw(a, b, n)	_outsw(PCI_FIX_ADDR(a),(b),(n))
 #define __do_writesl(a, b, n)	_outsl(PCI_FIX_ADDR(a),(b),(n))
 
-#define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_insl(p, b, n)	readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_outsb(p, b, n)	writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
-#define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
-#define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
+#define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_insl(p, b, n)	readsl((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_outsb(p, b, n)	writesb((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
+#define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
+#define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
 
 #define __do_memset_io(addr, c, n)	\
 				_memset_io(PCI_FIX_ADDR(addr), c, n)
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 6b808bcdecd5..6df110c1254e 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -186,9 +186,20 @@ do {								\
 		:						\
 		: label)
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #ifdef __powerpc64__
-#define __put_user_asm2_goto(x, ptr, label)			\
-	__put_user_asm_goto(x, ptr, label, "std")
+#define __put_user_asm2_goto(x, addr, label)			\
+	asm goto ("1: std%U1%X1 %0,%1	# put_user\n"		\
+		EX_TABLE(1b, %l2)				\
+		:						\
+		: "r" (x), DS_FORM_CONSTRAINT (*addr)		\
+		:						\
+		: label)
 #else /* __powerpc64__ */
 #define __put_user_asm2_goto(x, addr, label)			\
 	asm_volatile_goto(					\
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1275daec7fec..59f550062bb7 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -503,7 +503,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 28c168000483..b846233b81dc 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -418,7 +418,7 @@
 412	32	utimensat_time64	-				sys_utimensat
 413	32	pselect6_time64		-				compat_sys_pselect6_time64
 414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				sys_io_pgetevents
+416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64	-				sys_mq_timedsend
 419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index a45f0f31fe51..a3d308f2043e 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -18,224 +18,3 @@ sys32_mmap2:
 	sethi		%hi(sys_mmap), %g1
 	jmpl		%g1 + %lo(sys_mmap), %g0
 	 sllx		%o5, 12, %o5
-
-	.align		32
-	.globl		sys32_socketcall
-sys32_socketcall:	/* %o0=call, %o1=args */
-	cmp		%o0, 1
-	bl,pn		%xcc, do_einval
-	 cmp		%o0, 18
-	bg,pn		%xcc, do_einval
-	 sub		%o0, 1, %o0
-	sllx		%o0, 5, %o0
-	sethi		%hi(__socketcall_table_begin), %g2
-	or		%g2, %lo(__socketcall_table_begin), %g2
-	jmpl		%g2 + %o0, %g0
-	 nop
-do_einval:
-	retl
-	 mov		-EINVAL, %o0
-
-	.align		32
-__socketcall_table_begin:
-
-	/* Each entry is exactly 32 bytes. */
-do_sys_socket: /* sys_socket(int, int, int) */
-1:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socket), %g1
-2:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_socket), %g0
-3:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_bind: /* sys_bind(int fd, struct sockaddr *, int) */
-4:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_bind), %g1
-5:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_bind), %g0
-6:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_connect: /* sys_connect(int, struct sockaddr *, int) */
-7:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_connect), %g1
-8:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_connect), %g0
-9:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_listen: /* sys_listen(int, int) */
-10:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_listen), %g1
-	jmpl		%g1 + %lo(sys_listen), %g0
-11:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_accept: /* sys_accept(int, struct sockaddr *, int *) */
-12:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept), %g1
-13:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_accept), %g0
-14:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getsockname: /* sys_getsockname(int, struct sockaddr *, int *) */
-15:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockname), %g1
-16:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getsockname), %g0
-17:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getpeername: /* sys_getpeername(int, struct sockaddr *, int *) */
-18:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getpeername), %g1
-19:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getpeername), %g0
-20:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_socketpair: /* sys_socketpair(int, int, int, int *) */
-21:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socketpair), %g1
-22:	ldswa		[%o1 + 0x8] %asi, %o2
-23:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_socketpair), %g0
-24:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_send: /* sys_send(int, void *, size_t, unsigned int) */
-25:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_send), %g1
-26:	lduwa		[%o1 + 0x8] %asi, %o2
-27:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_send), %g0
-28:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_recv: /* sys_recv(int, void *, size_t, unsigned int) */
-29:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recv), %g1
-30:	lduwa		[%o1 + 0x8] %asi, %o2
-31:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_recv), %g0
-32:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_sendto: /* sys_sendto(int, u32, compat_size_t, unsigned int, u32, int) */
-33:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_sendto), %g1
-34:	lduwa		[%o1 + 0x8] %asi, %o2
-35:	lduwa		[%o1 + 0xc] %asi, %o3
-36:	lduwa		[%o1 + 0x10] %asi, %o4
-37:	ldswa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_sendto), %g0
-38:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_recvfrom: /* sys_recvfrom(int, u32, compat_size_t, unsigned int, u32, u32) */
-39:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recvfrom), %g1
-40:	lduwa		[%o1 + 0x8] %asi, %o2
-41:	lduwa		[%o1 + 0xc] %asi, %o3
-42:	lduwa		[%o1 + 0x10] %asi, %o4
-43:	lduwa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_recvfrom), %g0
-44:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_shutdown: /* sys_shutdown(int, int) */
-45:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_shutdown), %g1
-	jmpl		%g1 + %lo(sys_shutdown), %g0
-46:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_setsockopt: /* sys_setsockopt(int, int, int, char *, int) */
-47:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_setsockopt), %g1
-48:	ldswa		[%o1 + 0x8] %asi, %o2
-49:	lduwa		[%o1 + 0xc] %asi, %o3
-50:	ldswa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_setsockopt), %g0
-51:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_getsockopt: /* sys_getsockopt(int, int, int, u32, u32) */
-52:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockopt), %g1
-53:	ldswa		[%o1 + 0x8] %asi, %o2
-54:	lduwa		[%o1 + 0xc] %asi, %o3
-55:	lduwa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_getsockopt), %g0
-56:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_sendmsg: /* compat_sys_sendmsg(int, struct compat_msghdr *, unsigned int) */
-57:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_sendmsg), %g1
-58:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_sendmsg), %g0
-59:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_recvmsg: /* compat_sys_recvmsg(int, struct compat_msghdr *, unsigned int) */
-60:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_recvmsg), %g1
-61:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_recvmsg), %g0
-62:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_accept4: /* sys_accept4(int, struct sockaddr *, int *, int) */
-63:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept4), %g1
-64:	lduwa		[%o1 + 0x8] %asi, %o2
-65:	ldswa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_accept4), %g0
-66:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-
-	.section	__ex_table,"a"
-	.align		4
-	.word		1b, __retl_efault, 2b, __retl_efault
-	.word		3b, __retl_efault, 4b, __retl_efault
-	.word		5b, __retl_efault, 6b, __retl_efault
-	.word		7b, __retl_efault, 8b, __retl_efault
-	.word		9b, __retl_efault, 10b, __retl_efault
-	.word		11b, __retl_efault, 12b, __retl_efault
-	.word		13b, __retl_efault, 14b, __retl_efault
-	.word		15b, __retl_efault, 16b, __retl_efault
-	.word		17b, __retl_efault, 18b, __retl_efault
-	.word		19b, __retl_efault, 20b, __retl_efault
-	.word		21b, __retl_efault, 22b, __retl_efault
-	.word		23b, __retl_efault, 24b, __retl_efault
-	.word		25b, __retl_efault, 26b, __retl_efault
-	.word		27b, __retl_efault, 28b, __retl_efault
-	.word		29b, __retl_efault, 30b, __retl_efault
-	.word		31b, __retl_efault, 32b, __retl_efault
-	.word		33b, __retl_efault, 34b, __retl_efault
-	.word		35b, __retl_efault, 36b, __retl_efault
-	.word		37b, __retl_efault, 38b, __retl_efault
-	.word		39b, __retl_efault, 40b, __retl_efault
-	.word		41b, __retl_efault, 42b, __retl_efault
-	.word		43b, __retl_efault, 44b, __retl_efault
-	.word		45b, __retl_efault, 46b, __retl_efault
-	.word		47b, __retl_efault, 48b, __retl_efault
-	.word		49b, __retl_efault, 50b, __retl_efault
-	.word		51b, __retl_efault, 52b, __retl_efault
-	.word		53b, __retl_efault, 54b, __retl_efault
-	.word		55b, __retl_efault, 56b, __retl_efault
-	.word		57b, __retl_efault, 58b, __retl_efault
-	.word		59b, __retl_efault, 60b, __retl_efault
-	.word		61b, __retl_efault, 62b, __retl_efault
-	.word		63b, __retl_efault, 64b, __retl_efault
-	.word		65b, __retl_efault, 66b, __retl_efault
-	.previous
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 78160260991b..e38a5773d85e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -117,7 +117,7 @@
 90	common	dup2			sys_dup2
 91	32	setfsuid32		sys_setfsuid
 92	common	fcntl			sys_fcntl			compat_sys_fcntl
-93	common	select			sys_select
+93	common	select			sys_select			compat_sys_select
 94	32	setfsgid32		sys_setfsgid
 95	common	fsync			sys_fsync
 96	common	setpriority		sys_setpriority
@@ -155,7 +155,7 @@
 123	32	fchown			sys_fchown16
 123	64	fchown			sys_fchown
 124	common	fchmod			sys_fchmod
-125	common	recvfrom		sys_recvfrom
+125	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 126	32	setreuid		sys_setreuid16
 126	64	setreuid		sys_setreuid
 127	32	setregid		sys_setregid16
@@ -247,7 +247,7 @@
 204	32	readdir			sys_old_readdir			compat_sys_old_readdir
 204	64	readdir			sys_nis_syscall
 205	common	readahead		sys_readahead			compat_sys_readahead
-206	common	socketcall		sys_socketcall			sys32_socketcall
+206	common	socketcall		sys_socketcall			compat_sys_socketcall
 207	common	syslog			sys_syslog
 208	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
 209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
@@ -461,7 +461,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..bad983312060 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fcede9e3b..e8e3dbe7f173 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -2,6 +2,39 @@
 #ifndef _ASM_X86_CPU_DEVICE_ID
 #define _ASM_X86_CPU_DEVICE_ID
 
+/*
+ * Can't use <linux/bitfield.h> because it generates expressions that
+ * cannot be used in structure initializers. Bitfield construction
+ * here must match the union in struct cpuinfo_86:
+ *	union {
+ *		struct {
+ *			__u8	x86_model;
+ *			__u8	x86;
+ *			__u8	x86_vendor;
+ *			__u8	x86_reserved;
+ *		};
+ *		__u32		x86_vfm;
+ *	};
+ */
+#define VFM_MODEL_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_VENDOR_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_MODEL_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_VENDOR_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
+
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_model) << VFM_MODEL_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_vendor) << VFM_VENDOR_BIT)		\
+)
+
 /*
  * Declare drivers belonging to specific x86 CPUs
  * Similar in spirit to pci_device_id and related PCI functions
@@ -20,6 +53,9 @@
 #define X86_CENTAUR_FAM6_C7_D		0xd
 #define X86_CENTAUR_FAM6_NANO		0xf
 
+/* x86_cpu_id::flags */
+#define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
+
 #define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
@@ -46,6 +82,18 @@
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
+	.driver_data	= (unsigned long) _data				\
+}
+
+#define X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
+						    _steppings, _feature, _data) { \
+	.vendor		= _vendor,					\
+	.family		= _family,					\
+	.model		= _model,					\
+	.steppings	= _steppings,					\
+	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -164,6 +212,56 @@
 	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
 						     steppings, X86_FEATURE_ANY, data)
 
+/**
+ * X86_MATCH_VFM - Match encoded vendor/family/model
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * Stepping and feature are set to wildcards
+ */
+#define X86_MATCH_VFM(vfm, data)			\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @steppings:	Bitmask of steppings to match
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * feature is set to wildcard
+ */
+#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		steppings, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * Steppings is set to wildcard
+ */
+#define X86_MATCH_VFM_FEATURE(vfm, feature, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, feature, data)
+
 /*
  * Match specific microcode revisions.
  *
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..7c675832712d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -382,4 +382,15 @@ static inline void efi_fake_memmap_early(void)
 }
 #endif
 
+extern int __init efi_memmap_alloc(unsigned int num_entries,
+				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
+
+extern int __init efi_memmap_install(struct efi_memory_map_data *data);
+extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
+					 struct range *range);
+extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
+				     void *buf, struct efi_mem_range *mem);
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 18f6b7c4bd79..16cd56627574 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -164,7 +164,14 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 int amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index ad6776081e60..ae71b8ef909c 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -39,9 +39,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	const struct x86_cpu_id *m;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	for (m = match;
-	     m->vendor | m->family | m->model | m->steppings | m->feature;
-	     m++) {
+	for (m = match; m->flags & X86_CPU_ID_FLAG_ENTRY_VALID; m++) {
 		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
 			continue;
 		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..52e1f3f0b361 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -27,25 +27,7 @@
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	unsigned long pc = instruction_pointer(regs);
-
-	if (!user_mode(regs) && in_lock_functions(pc)) {
-#ifdef CONFIG_FRAME_POINTER
-		return *(unsigned long *)(regs->bp + sizeof(long));
-#else
-		unsigned long *sp = (unsigned long *)regs->sp;
-		/*
-		 * Return address is either directly at stack pointer
-		 * or above a saved flags. Eflags has bits 22-31 zero,
-		 * kernel addresses don't.
-		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
-#endif
-	}
-	return pc;
+	return instruction_pointer(regs);
 }
 EXPORT_SYMBOL(profile_pc);
 
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 84b09c230cbd..196f61fdbf28 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,6 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
+				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e705cb06..41229bcbe0d9 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -234,9 +234,11 @@ int __init efi_memblock_x86_reserve_range(void)
 	data.desc_size		= e->efi_memdesc_size;
 	data.desc_version	= e->efi_memdesc_version;
 
-	rv = efi_memmap_init_early(&data);
-	if (rv)
-		return rv;
+	if (!efi_enabled(EFI_PARAVIRT)) {
+		rv = efi_memmap_init_early(&data);
+		if (rv)
+			return rv;
+	}
 
 	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
new file mode 100644
index 000000000000..872d310c426e
--- /dev/null
+++ b/arch/x86/platform/efi/memmap.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common EFI memory map functions.
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+
+static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
+{
+	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
+}
+
+static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct page *p = alloc_pages(GFP_KERNEL, order);
+
+	if (!p)
+		return 0;
+
+	return PFN_PHYS(page_to_pfn(p));
+}
+
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+/**
+ * efi_memmap_alloc - Allocate memory for the EFI memory map
+ * @num_entries: Number of entries in the allocated map.
+ * @data: efi memmap installation parameters
+ *
+ * Depending on whether mm_init() has already been invoked or not,
+ * either memblock or "normal" page allocation is used.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_alloc(unsigned int num_entries,
+		struct efi_memory_map_data *data)
+{
+	/* Expect allocation parameters are zero initialized */
+	WARN_ON(data->phys_map || data->size);
+
+	data->size = num_entries * efi.memmap.desc_size;
+	data->desc_version = efi.memmap.desc_version;
+	data->desc_size = efi.memmap.desc_size;
+	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
+	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	if (slab_is_available()) {
+		data->flags |= EFI_MEMMAP_SLAB;
+		data->phys_map = __efi_memmap_alloc_late(data->size);
+	} else {
+		data->flags |= EFI_MEMMAP_MEMBLOCK;
+		data->phys_map = __efi_memmap_alloc_early(data->size);
+	}
+
+	if (!data->phys_map)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * efi_memmap_install - Install a new EFI memory map in efi.memmap
+ * @ctx: map allocation parameters (address, size, flags)
+ *
+ * Unlike efi_memmap_init_*(), this function does not allow the caller
+ * to switch from early to late mappings. It simply uses the existing
+ * mapping function and installs the new memmap.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_install(struct efi_memory_map_data *data)
+{
+	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
+	unsigned long flags = efi.memmap.flags;
+	u64 phys = efi.memmap.phys_map;
+	int ret;
+
+	efi_memmap_unmap();
+
+	if (efi_enabled(EFI_PARAVIRT))
+		return 0;
+
+	ret = __efi_memmap_init(data);
+	if (ret)
+		return ret;
+
+	__efi_memmap_free(phys, size, flags);
+	return 0;
+}
+
+/**
+ * efi_memmap_split_count - Count number of additional EFI memmap entries
+ * @md: EFI memory descriptor to split
+ * @range: Address range (start, end) to split around
+ *
+ * Returns the number of additional EFI memmap entries required to
+ * accommodate @range.
+ */
+int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
+{
+	u64 m_start, m_end;
+	u64 start, end;
+	int count = 0;
+
+	start = md->phys_addr;
+	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+	/* modifying range */
+	m_start = range->start;
+	m_end = range->end;
+
+	if (m_start <= start) {
+		/* split into 2 parts */
+		if (start < m_end && m_end < end)
+			count++;
+	}
+
+	if (start < m_start && m_start < end) {
+		/* split into 3 parts */
+		if (m_end < end)
+			count += 2;
+		/* split into 2 parts */
+		if (end <= m_end)
+			count++;
+	}
+
+	return count;
+}
+
+/**
+ * efi_memmap_insert - Insert a memory region in an EFI memmap
+ * @old_memmap: The existing EFI memory map structure
+ * @buf: Address of buffer to store new map
+ * @mem: Memory map entry to insert
+ *
+ * It is suggested that you call efi_memmap_split_count() first
+ * to see how large @buf needs to be.
+ */
+void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
+			      struct efi_mem_range *mem)
+{
+	u64 m_start, m_end, m_attr;
+	efi_memory_desc_t *md;
+	u64 start, end;
+	void *old, *new;
+
+	/* modifying range */
+	m_start = mem->range.start;
+	m_end = mem->range.end;
+	m_attr = mem->attribute;
+
+	/*
+	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
+	 * units. Ensure that the region described by 'mem' is aligned
+	 * correctly.
+	 */
+	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
+	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
+		WARN_ON(1);
+		return;
+	}
+
+	for (old = old_memmap->map, new = buf;
+	     old < old_memmap->map_end;
+	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
+
+		/* copy original EFI memory descriptor */
+		memcpy(new, old, old_memmap->desc_size);
+		md = new;
+		start = md->phys_addr;
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (m_start <= start && end <= m_end)
+			md->attribute |= m_attr;
+
+		if (m_start <= start &&
+		    (start < m_end && m_end < end)) {
+			/* first part */
+			md->attribute |= m_attr;
+			md->num_pages = (m_end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) && m_end < end) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* middle part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->attribute |= m_attr;
+			md->phys_addr = m_start;
+			md->num_pages = (m_end - m_start + 1) >>
+				EFI_PAGE_SHIFT;
+			/* last part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - m_end) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) &&
+		    (end <= m_end)) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_start;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			md->attribute |= m_attr;
+		}
+	}
+}
diff --git a/block/ioctl.c b/block/ioctl.c
index bc97698e0e8a..11e692741f17 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -32,7 +32,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(bdev, p.pno);
 
-	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+	if (p.start < 0 || p.length <= 0 || LLONG_MAX - p.length < p.start)
 		return -EINVAL;
 	/* Check that the partition is aligned to the block size */
 	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 4914dbc44517..5bbbd015de5a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -44,7 +44,6 @@ acpi_ex_system_memory_space_handler(u32 function,
 	struct acpi_mem_mapping *mm = mem_info->cur_mm;
 	u32 length;
 	acpi_size map_length;
-	acpi_size page_boundary_map_length;
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -138,26 +137,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 		map_length = (acpi_size)
 		    ((mem_info->address + mem_info->length) - address);
 
-		/*
-		 * If mapping the entire remaining portion of the region will cross
-		 * a page boundary, just map up to the page boundary, do not cross.
-		 * On some systems, crossing a page boundary while mapping regions
-		 * can cause warnings if the pages have different attributes
-		 * due to resource management.
-		 *
-		 * This has the added benefit of constraining a single mapping to
-		 * one page, which is similar to the original code that used a 4k
-		 * maximum window.
-		 */
-		page_boundary_map_length = (acpi_size)
-		    (ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address);
-		if (page_boundary_map_length == 0) {
-			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
-		}
-
-		if (map_length > page_boundary_map_length) {
-			map_length = page_boundary_map_length;
-		}
+		if (map_length > ACPI_DEFAULT_PAGE_SIZE)
+			map_length = ACPI_DEFAULT_PAGE_SIZE;
 
 		/* Create a new mapping starting at the address given */
 
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 66e53df75865..4c38846fea96 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1346,6 +1346,9 @@ bool acpi_storage_d3(struct device *dev)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u8 val;
 
+	if (force_storage_d3())
+		return true;
+
 	if (!adev)
 		return false;
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 125e4901c9b4..f6c929787c9e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -237,6 +237,15 @@ static inline int suspend_nvs_save(void) { return 0; }
 static inline void suspend_nvs_restore(void) {}
 #endif
 
+#ifdef CONFIG_X86
+bool force_storage_d3(void);
+#else
+static inline bool force_storage_d3(void)
+{
+	return false;
+}
+#endif
+
 /*--------------------------------------------------------------------------
 				Device properties
   -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a5cb9e1d48bc..338e1f44906a 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -341,6 +341,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo Slim 7 16ARH7 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82UX"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Lenovo ThinkPad X131e (3371 AMD version) */
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 3f9a162be84e..aa4f233373af 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -177,3 +177,37 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 
 	return ret;
 }
+
+/*
+ * AMD systems from Renoir onwards *require* that the NVME controller
+ * is put into D3 over a Modern Standby / suspend-to-idle cycle.
+ *
+ * This is "typically" accomplished using the `StorageD3Enable`
+ * property in the _DSD that is checked via the `acpi_storage_d3` function
+ * but some OEM systems still don't have it in their BIOS.
+ *
+ * The Microsoft documentation for StorageD3Enable mentioned that Windows has
+ * a hardcoded allowlist for D3 support as well as a registry key to override
+ * the BIOS, which has been used for these cases.
+ *
+ * This allows quirking on Linux in a similar fashion.
+ *
+ * Cezanne systems shouldn't *normally* need this as the BIOS includes
+ * StorageD3Enable.  But for two reasons we have added it.
+ * 1) The BIOS on a number of Dell systems have ambiguity
+ *    between the same value used for _ADR on ACPI nodes GPP1.DEV0 and GPP1.NVME.
+ *    GPP1.NVME is needed to get StorageD3Enable node set properly.
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=216440
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
+ * 2) On at least one HP system StorageD3Enable is missing on the second NVME
+ *    disk in the system.
+ * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
+ *    NVME device.
+ */
+bool force_storage_d3(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
+	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
+}
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 55a07dbe1d8a..04b53bb7a692 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1893,8 +1893,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
-	if (!host)
-		return -ENOMEM;
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_rm_sysfs_file;
+	}
 	host->private_data = hpriv;
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
@@ -1947,11 +1949,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	rc = ahci_pci_reset_controller(host);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	ahci_pci_init_controller(host);
 	ahci_pci_print_info(host);
@@ -1960,10 +1962,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = ahci_host_activate(host, &ahci_sht);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
+
+err_rm_sysfs_file:
+	sysfs_remove_file_from_group(&pdev->dev.kobj,
+				     &dev_attr_remapped_nvme.attr, NULL);
+	return rc;
 }
 
 static void ahci_shutdown_one(struct pci_dev *pdev)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 702b8e061b36..3717ed6fcccc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5420,8 +5420,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	if (!host)
 		return NULL;
 
-	if (!devres_open_group(dev, NULL, GFP_KERNEL))
-		goto err_free;
+	if (!devres_open_group(dev, NULL, GFP_KERNEL)) {
+		kfree(host);
+		return NULL;
+	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
 	if (!dr)
@@ -5453,8 +5455,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 
  err_out:
 	devres_release_group(dev, NULL);
- err_free:
-	kfree(host);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(ata_host_alloc);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2c978941b488..b13a60de5a86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2008,8 +2008,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 41220ce59659..2bad11424734 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -81,7 +81,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
 		dev->zone_max_open = dev->zone_max_active;
 		pr_info("changed the maximum number of open zones to %u\n",
-			dev->nr_zones);
+			dev->zone_max_open);
 	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_open = 0;
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 759d7828931d..56ada48104f0 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2008-2009 Atheros Communications Inc.
  */
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -129,7 +128,6 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
  * for AR3012
  */
 static const struct usb_device_id ath3k_blist_tbl[] = {
-
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
@@ -203,7 +201,7 @@ static inline void ath3k_log_failed_loading(int err, int len, int size,
 #define TIMEGAP_USEC_MAX	100
 
 static int ath3k_load_firmware(struct usb_device *udev,
-				const struct firmware *firmware)
+			       const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -238,9 +236,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
+				   &len, 3000);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			goto error;
 		}
@@ -263,7 +261,7 @@ static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
 }
 
 static int ath3k_get_version(struct usb_device *udev,
-			struct ath3k_version *version)
+			     struct ath3k_version *version)
 {
 	return usb_control_msg_recv(udev, 0, ATH3K_GETVERSION,
 				    USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
@@ -272,7 +270,7 @@ static int ath3k_get_version(struct usb_device *udev,
 }
 
 static int ath3k_load_fwfile(struct usb_device *udev,
-		const struct firmware *firmware)
+			     const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -311,8 +309,8 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
-		if (err || (len != size)) {
+				   &len, 3000);
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			kfree(send_buf);
 			return err;
@@ -426,7 +424,6 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	switch (fw_version.ref_clock) {
-
 	case ATH3K_XTAL_FREQ_26M:
 		clk_value = 26;
 		break;
@@ -442,7 +439,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
+		 le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -457,7 +454,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 }
 
 static int ath3k_probe(struct usb_interface *intf,
-			const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	const struct firmware *firmware;
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -506,10 +503,10 @@ static int ath3k_probe(struct usb_interface *intf,
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			BT_ERR("Firmware file \"%s\" not found",
-							ATH3K_FIRMWARE);
+			       ATH3K_FIRMWARE);
 		else
 			BT_ERR("Firmware file \"%s\" request failed (err=%d)",
-							ATH3K_FIRMWARE, ret);
+			       ATH3K_FIRMWARE, ret);
 		return ret;
 	}
 
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 65df9ef5b5bc..634399881929 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -349,6 +350,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
+	struct clk *clk;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -388,6 +390,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+
 	err = counter_register(&priv->counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5161b73c30c4..e91aeec71c81 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1020,8 +1020,8 @@ static int axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
+	of_dma_controller_free(pdev->dev.of_node);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 191b59279007..2a47b9053bad 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -15,7 +15,6 @@
 #include <linux/workqueue.h>
 #include <linux/prefetch.h>
 #include <linux/dca.h>
-#include <linux/aer.h>
 #include <linux/sizes.h>
 #include "dma.h"
 #include "registers.h"
@@ -535,18 +534,6 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
 	return err;
 }
 
-static int ioat_register(struct ioatdma_device *ioat_dma)
-{
-	int err = dma_async_device_register(&ioat_dma->dma_dev);
-
-	if (err) {
-		ioat_disable_interrupts(ioat_dma);
-		dma_pool_destroy(ioat_dma->completion_pool);
-	}
-
-	return err;
-}
-
 static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
 {
 	struct dma_device *dma = &ioat_dma->dma_dev;
@@ -1181,9 +1168,9 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
 	}
 
-	err = ioat_register(ioat_dma);
+	err = dma_async_device_register(&ioat_dma->dma_dev);
 	if (err)
-		return err;
+		goto err_disable_interrupts;
 
 	ioat_kobject_add(ioat_dma, &ioat_ktype);
 
@@ -1191,21 +1178,30 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
 
 	/* disable relaxed ordering */
-	err = pcie_capability_read_word(pdev, IOAT_DEVCTRL_OFFSET, &val16);
-	if (err)
-		return pcibios_err_to_errno(err);
+	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
+	if (err) {
+		err = pcibios_err_to_errno(err);
+		goto err_disable_interrupts;
+	}
 
 	/* clear relaxed ordering enable */
-	val16 &= ~IOAT_DEVCTRL_ROE;
-	err = pcie_capability_write_word(pdev, IOAT_DEVCTRL_OFFSET, val16);
-	if (err)
-		return pcibios_err_to_errno(err);
+	val16 &= ~PCI_EXP_DEVCTL_RELAX_EN;
+	err = pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, val16);
+	if (err) {
+		err = pcibios_err_to_errno(err);
+		goto err_disable_interrupts;
+	}
 
 	if (ioat_dma->cap & IOAT_CAP_DPS)
 		writeb(ioat_pending_level + 1,
 		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);
 
 	return 0;
+
+err_disable_interrupts:
+	ioat_disable_interrupts(ioat_dma);
+	dma_pool_destroy(ioat_dma->completion_pool);
+	return err;
 }
 
 static void ioat_shutdown(struct pci_dev *pdev)
@@ -1350,6 +1346,8 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	void __iomem * const *iomap;
 	struct device *dev = &pdev->dev;
 	struct ioatdma_device *device;
+	unsigned int i;
+	u8 version;
 	int err;
 
 	err = pcim_enable_device(pdev);
@@ -1363,15 +1361,13 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!iomap)
 		return -ENOMEM;
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (err)
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	version = readb(iomap[IOAT_MMIO_BAR] + IOAT_VER_OFFSET);
+	if (version < IOAT_VER_3_0)
+		return -ENODEV;
 
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
@@ -1381,22 +1377,19 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, device);
 
-	device->version = readb(device->reg_base + IOAT_VER_OFFSET);
+	device->version = version;
 	if (device->version >= IOAT_VER_3_4)
 		ioat_dca_enabled = 0;
-	if (device->version >= IOAT_VER_3_0) {
-		if (is_skx_ioat(pdev))
-			device->version = IOAT_VER_3_2;
-		err = ioat3_dma_probe(device, ioat_dca_enabled);
-
-		if (device->version >= IOAT_VER_3_3)
-			pci_enable_pcie_error_reporting(pdev);
-	} else
-		return -ENODEV;
 
+	if (is_skx_ioat(pdev))
+		device->version = IOAT_VER_3_2;
+
+	err = ioat3_dma_probe(device, ioat_dca_enabled);
 	if (err) {
+		for (i = 0; i < IOAT_MAX_CHANS; i++)
+			kfree(device->idx[i]);
+		kfree(device);
 		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
-		pci_disable_pcie_error_reporting(pdev);
 		return -ENODEV;
 	}
 
@@ -1419,7 +1412,6 @@ static void ioat_remove(struct pci_dev *pdev)
 		device->dca = NULL;
 	}
 
-	pci_disable_pcie_error_reporting(pdev);
 	ioat_dma_remove(device);
 }
 
@@ -1458,6 +1450,7 @@ module_init(ioat_init_module);
 static void __exit ioat_exit_module(void)
 {
 	pci_unregister_driver(&ioat_pci_driver);
+	kmem_cache_destroy(ioat_sed_cache);
 	kmem_cache_destroy(ioat_cache);
 }
 module_exit(ioat_exit_module);
diff --git a/drivers/dma/ioat/registers.h b/drivers/dma/ioat/registers.h
index f55a5f92f185..54cf0ad39887 100644
--- a/drivers/dma/ioat/registers.h
+++ b/drivers/dma/ioat/registers.h
@@ -14,13 +14,6 @@
 #define IOAT_PCI_CHANERR_INT_OFFSET		0x180
 #define IOAT_PCI_CHANERRMASK_INT_OFFSET		0x184
 
-/* PCIe config registers */
-
-/* EXPCAPID + N */
-#define IOAT_DEVCTRL_OFFSET			0x8
-/* relaxed ordering enable */
-#define IOAT_DEVCTRL_ROE			0x10
-
 /* MMIO Device Registers */
 #define IOAT_CHANCNT_OFFSET			0x00	/*  8-bit */
 
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index e901f8564ca0..0ec83ba58097 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -30,11 +30,13 @@ static __initconst const char name[][22] = {
 
 static __initconst const struct {
 	const char	path[17];
+	u8		paravirt;
 	const char	params[PARAMCOUNT][26];
 } dt_params[] = {
 	{
 #ifdef CONFIG_XEN    //  <-------17------>
 		.path = "/hypervisor/uefi",
+		.paravirt = 1,
 		.params = {
 			[SYSTAB] = "xen,uefi-system-table",
 			[MMBASE] = "xen,uefi-mmap-start",
@@ -121,6 +123,8 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 			pr_err("Can't find property '%s' in DT!\n", pname);
 			return 0;
 		}
+		if (dt_params[i].paravirt)
+			set_bit(EFI_PARAVIRT, &efi.flags);
 		return systab;
 	}
 notfound:
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883dc788..77dd20f9df31 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -9,83 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/io.h>
-#include <asm/early_ioremap.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
-static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
-{
-	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
-}
-
-static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-{
-	unsigned int order = get_order(size);
-	struct page *p = alloc_pages(GFP_KERNEL, order);
-
-	if (!p)
-		return 0;
-
-	return PFN_PHYS(page_to_pfn(p));
-}
-
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
-}
-
-static void __init efi_memmap_free(void)
-{
-	__efi_memmap_free(efi.memmap.phys_map,
-			efi.memmap.desc_size * efi.memmap.nr_map,
-			efi.memmap.flags);
-}
-
-/**
- * efi_memmap_alloc - Allocate memory for the EFI memory map
- * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
- *
- * Depending on whether mm_init() has already been invoked or not,
- * either memblock or "normal" page allocation is used.
- *
- * Returns the physical address of the allocated memory map on
- * success, zero on failure.
- */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
-{
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
-
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
-}
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
 
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
@@ -102,14 +30,11 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
 
-	if (efi_enabled(EFI_PARAVIRT))
-		return 0;
-
 	phys_map = data->phys_map;
 
 	if (data->flags & EFI_MEMMAP_LATE)
@@ -122,9 +47,6 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	/* NOP if data->flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB) == 0 */
-	efi_memmap_free();
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
@@ -221,158 +143,3 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
 	return __efi_memmap_init(&data);
 }
-
-/**
- * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
- *
- * Unlike efi_memmap_init_*(), this function does not allow the caller
- * to switch from early to late mappings. It simply uses the existing
- * mapping function and installs the new memmap.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_install(struct efi_memory_map_data *data)
-{
-	efi_memmap_unmap();
-
-	return __efi_memmap_init(data);
-}
-
-/**
- * efi_memmap_split_count - Count number of additional EFI memmap entries
- * @md: EFI memory descriptor to split
- * @range: Address range (start, end) to split around
- *
- * Returns the number of additional EFI memmap entries required to
- * accomodate @range.
- */
-int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
-{
-	u64 m_start, m_end;
-	u64 start, end;
-	int count = 0;
-
-	start = md->phys_addr;
-	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-	/* modifying range */
-	m_start = range->start;
-	m_end = range->end;
-
-	if (m_start <= start) {
-		/* split into 2 parts */
-		if (start < m_end && m_end < end)
-			count++;
-	}
-
-	if (start < m_start && m_start < end) {
-		/* split into 3 parts */
-		if (m_end < end)
-			count += 2;
-		/* split into 2 parts */
-		if (end <= m_end)
-			count++;
-	}
-
-	return count;
-}
-
-/**
- * efi_memmap_insert - Insert a memory region in an EFI memmap
- * @old_memmap: The existing EFI memory map structure
- * @buf: Address of buffer to store new map
- * @mem: Memory map entry to insert
- *
- * It is suggested that you call efi_memmap_split_count() first
- * to see how large @buf needs to be.
- */
-void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
-			      struct efi_mem_range *mem)
-{
-	u64 m_start, m_end, m_attr;
-	efi_memory_desc_t *md;
-	u64 start, end;
-	void *old, *new;
-
-	/* modifying range */
-	m_start = mem->range.start;
-	m_end = mem->range.end;
-	m_attr = mem->attribute;
-
-	/*
-	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
-	 * units. Ensure that the region described by 'mem' is aligned
-	 * correctly.
-	 */
-	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
-	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
-		WARN_ON(1);
-		return;
-	}
-
-	for (old = old_memmap->map, new = buf;
-	     old < old_memmap->map_end;
-	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
-
-		/* copy original EFI memory descriptor */
-		memcpy(new, old, old_memmap->desc_size);
-		md = new;
-		start = md->phys_addr;
-		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-		if (m_start <= start && end <= m_end)
-			md->attribute |= m_attr;
-
-		if (m_start <= start &&
-		    (start < m_end && m_end < end)) {
-			/* first part */
-			md->attribute |= m_attr;
-			md->num_pages = (m_end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) && m_end < end) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* middle part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->attribute |= m_attr;
-			md->phys_addr = m_start;
-			md->num_pages = (m_end - m_start + 1) >>
-				EFI_PAGE_SHIFT;
-			/* last part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - m_end) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) &&
-		    (end <= m_end)) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_start;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			md->attribute |= m_attr;
-		}
-	}
-}
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 39f3e1366409..b7811dbe0ec2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1335,7 +1335,7 @@ config GPIO_TPS68470
 	  drivers are loaded.
 
 config GPIO_TQMX86
-	tristate "TQ-Systems QTMX86 GPIO"
+	tristate "TQ-Systems TQMx86 GPIO"
 	depends on MFD_TQMX86 || COMPILE_TEST
 	depends on HAS_IOPORT_MAP
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 80597e90de9c..33623bcfc886 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -227,6 +227,11 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	else
 		nirq = DIV_ROUND_UP(ngpio, 16);
 
+	if (nirq > MAX_INT_PER_BANK) {
+		dev_err(dev, "Too many IRQs!\n");
+		return -EINVAL;
+	}
+
 	chips = devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
 	if (!chips)
 		return -ENOMEM;
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 0f5d17f343f1..70c52544ec80 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -27,16 +27,20 @@
 #define TQMX86_GPIIC	3	/* GPI Interrupt Configuration Register */
 #define TQMX86_GPIIS	4	/* GPI Interrupt Status Register */
 
+#define TQMX86_GPII_NONE	0
 #define TQMX86_GPII_FALLING	BIT(0)
 #define TQMX86_GPII_RISING	BIT(1)
 #define TQMX86_GPII_MASK	(BIT(0) | BIT(1))
 #define TQMX86_GPII_BITS	2
+/* Stored in irq_type with GPII bits */
+#define TQMX86_INT_UNMASKED	BIT(2)
 
 struct tqmx86_gpio_data {
 	struct gpio_chip	chip;
 	struct irq_chip		irq_chip;
 	void __iomem		*io_base;
 	int			irq;
+	/* Lock must be held for accessing output and irq_type fields */
 	raw_spinlock_t		spinlock;
 	u8			irq_type[TQMX86_NGPI];
 };
@@ -107,20 +111,30 @@ static int tqmx86_gpio_get_direction(struct gpio_chip *chip,
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
+static void tqmx86_gpio_irq_config(struct tqmx86_gpio_data *gpio, int offset)
+	__must_hold(&gpio->spinlock)
+{
+	u8 type = TQMX86_GPII_NONE, gpiic;
+
+	if (gpio->irq_type[offset] & TQMX86_INT_UNMASKED)
+		type = gpio->irq_type[offset] & TQMX86_GPII_MASK;
+
+	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
+	gpiic &= ~(TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS));
+	gpiic |= type << (offset * TQMX86_GPII_BITS);
+	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+}
+
 static void tqmx86_gpio_irq_mask(struct irq_data *data)
 {
 	unsigned int offset = (data->hwirq - TQMX86_NGPO);
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(
 		irq_data_get_irq_chip_data(data));
 	unsigned long flags;
-	u8 gpiic, mask;
-
-	mask = TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS);
 
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~mask;
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] &= ~TQMX86_INT_UNMASKED;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 }
 
@@ -130,15 +144,10 @@ static void tqmx86_gpio_irq_unmask(struct irq_data *data)
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(
 		irq_data_get_irq_chip_data(data));
 	unsigned long flags;
-	u8 gpiic, mask;
-
-	mask = TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS);
 
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~mask;
-	gpiic |= gpio->irq_type[offset] << (offset * TQMX86_GPII_BITS);
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] |= TQMX86_INT_UNMASKED;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 }
 
@@ -149,7 +158,7 @@ static int tqmx86_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned int offset = (data->hwirq - TQMX86_NGPO);
 	unsigned int edge_type = type & IRQF_TRIGGER_MASK;
 	unsigned long flags;
-	u8 new_type, gpiic;
+	u8 new_type;
 
 	switch (edge_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -165,13 +174,10 @@ static int tqmx86_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 		return -EINVAL; /* not supported */
 	}
 
-	gpio->irq_type[offset] = new_type;
-
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~((TQMX86_GPII_MASK) << (offset * TQMX86_GPII_BITS));
-	gpiic |= new_type << (offset * TQMX86_GPII_BITS);
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] &= ~TQMX86_GPII_MASK;
+	gpio->irq_type[offset] |= new_type;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 
 	return 0;
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 40d0196d8bdc..95861916deff 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -83,6 +83,10 @@ struct linehandle_state {
 	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
 	GPIOHANDLE_REQUEST_OPEN_SOURCE)
 
+#define GPIOHANDLE_REQUEST_DIRECTION_FLAGS \
+	(GPIOHANDLE_REQUEST_INPUT | \
+	 GPIOHANDLE_REQUEST_OUTPUT)
+
 static int linehandle_validate_flags(u32 flags)
 {
 	/* Return an error if an unknown flag is set */
@@ -163,21 +167,21 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	if (ret)
 		return ret;
 
+	/* Lines must be reconfigured explicitly as input or output. */
+	if (!(lflags & GPIOHANDLE_REQUEST_DIRECTION_FLAGS))
+		return -EINVAL;
+
 	for (i = 0; i < lh->num_descs; i++) {
 		desc = lh->descs[i];
-		linehandle_flags_to_desc_flags(gcnf.flags, &desc->flags);
+		linehandle_flags_to_desc_flags(lflags, &desc->flags);
 
-		/*
-		 * Lines have to be requested explicitly for input
-		 * or output, else the line will be treated "as is".
-		 */
 		if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
 			int val = !!gcnf.default_values[i];
 
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
-		} else if (lflags & GPIOHANDLE_REQUEST_INPUT) {
+		} else {
 			ret = gpiod_direction_input(desc);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f70fcadf1ee5..a4a6b99bddba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -633,6 +633,12 @@ void enc1_stream_encoder_set_throttled_vcp_size(
 				x),
 			26));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 26) {
+		x += 1;
+		y = 0;
+	}
+
 	REG_SET_2(DP_MSE_RATE_CNTL, 0,
 		DP_MSE_RATE_X, x,
 		DP_MSE_RATE_Y, y);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 6eb6f05c1136..56e15f5bc822 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -163,6 +163,8 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
 
 	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
 		if (table[i].ulSupportedSCLK != 0) {
+			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
+				continue;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
 				table[i].usVoltageID;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 1e922703e26b..7cc891c091f8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -259,7 +259,7 @@ komeda_component_get_avail_scaler(struct komeda_component *c,
 	u32 avail_scalers;
 
 	pipe_st = komeda_pipeline_get_state(c->pipeline, state);
-	if (!pipe_st)
+	if (IS_ERR_OR_NULL(pipe_st))
 		return NULL;
 
 	avail_scalers = (pipe_st->active_comps & KOMEDA_PIPELINE_SCALERS) ^
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index c916f4b8907e..35a6d9c4e081 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -252,9 +252,12 @@ EXPORT_SYMBOL(drm_panel_bridge_remove);
 
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
-	struct drm_bridge **bridge = res;
+	struct drm_bridge *bridge = *(struct drm_bridge **)res;
 
-	drm_panel_bridge_remove(*bridge);
+	if (!bridge)
+		return;
+
+	drm_bridge_remove(bridge);
 }
 
 /**
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e1ffe8a28b64..d87ab8ecb023 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -308,6 +308,7 @@ static int vidi_get_modes(struct drm_connector *connector)
 	struct vidi_context *ctx = ctx_from_connector(connector);
 	struct edid *edid;
 	int edid_len;
+	int count;
 
 	/*
 	 * the edid data comes from user side and it would be set
@@ -327,7 +328,11 @@ static int vidi_get_modes(struct drm_connector *connector)
 
 	drm_connector_update_edid_property(connector, edid);
 
-	return drm_add_edid_modes(connector, edid);
+	count = drm_add_edid_modes(connector, edid);
+
+	kfree(edid);
+
+	return count;
 }
 
 static const struct drm_connector_helper_funcs vidi_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 576fcf180716..d8579c7c15fd 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -878,11 +878,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return 0;
+		goto no_edid;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return 0;
+		goto no_edid;
 
 	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
@@ -897,6 +897,9 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	kfree(edid);
 
 	return ret;
+
+no_edid:
+	return drm_add_modes_noedid(connector, 640, 480);
 }
 
 static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
index cd71631bef0c..ddf76a4e4fa2 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
@@ -309,6 +309,7 @@ void i915_vma_revoke_fence(struct i915_vma *vma)
 		return;
 
 	GEM_BUG_ON(fence->vma != vma);
+	i915_active_wait(&fence->active);
 	GEM_BUG_ON(!i915_active_is_idle(&fence->active));
 	GEM_BUG_ON(atomic_read(&fence->pin_count));
 
diff --git a/drivers/gpu/drm/lima/lima_bcast.c b/drivers/gpu/drm/lima/lima_bcast.c
index fbc43f243c54..6d000504e1a4 100644
--- a/drivers/gpu/drm/lima/lima_bcast.c
+++ b/drivers/gpu/drm/lima/lima_bcast.c
@@ -43,6 +43,18 @@ void lima_bcast_suspend(struct lima_ip *ip)
 
 }
 
+int lima_bcast_mask_irq(struct lima_ip *ip)
+{
+	bcast_write(LIMA_BCAST_BROADCAST_MASK, 0);
+	bcast_write(LIMA_BCAST_INTERRUPT_MASK, 0);
+	return 0;
+}
+
+int lima_bcast_reset(struct lima_ip *ip)
+{
+	return lima_bcast_hw_init(ip);
+}
+
 int lima_bcast_init(struct lima_ip *ip)
 {
 	int i;
diff --git a/drivers/gpu/drm/lima/lima_bcast.h b/drivers/gpu/drm/lima/lima_bcast.h
index 465ee587bceb..cd08841e4787 100644
--- a/drivers/gpu/drm/lima/lima_bcast.h
+++ b/drivers/gpu/drm/lima/lima_bcast.h
@@ -13,4 +13,7 @@ void lima_bcast_fini(struct lima_ip *ip);
 
 void lima_bcast_enable(struct lima_device *dev, int num_pp);
 
+int lima_bcast_mask_irq(struct lima_ip *ip);
+int lima_bcast_reset(struct lima_ip *ip);
+
 #endif
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 8dd501b7a3d0..6cf46b653e81 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -212,6 +212,13 @@ static void lima_gp_task_mmu_error(struct lima_sched_pipe *pipe)
 	lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_gp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	struct lima_ip *ip = pipe->processor[0];
+
+	gp_write(LIMA_GP_INT_MASK, 0);
+}
+
 static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
 {
 	struct lima_ip *ip = pipe->processor[0];
@@ -344,6 +351,7 @@ int lima_gp_pipe_init(struct lima_device *dev)
 	pipe->task_error = lima_gp_task_error;
 	pipe->task_mmu_error = lima_gp_task_mmu_error;
 	pipe->task_recover = lima_gp_task_recover;
+	pipe->task_mask_irq = lima_gp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index a5c95bed08c0..54b208a4a768 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -408,6 +408,9 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 
 		lima_pp_hard_reset(ip);
 	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_reset(pipe->bcast_processor);
 }
 
 static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
@@ -416,6 +419,20 @@ static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
 		lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_pp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	int i;
+
+	for (i = 0; i < pipe->num_processor; i++) {
+		struct lima_ip *ip = pipe->processor[i];
+
+		pp_write(LIMA_PP_INT_MASK, 0);
+	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_mask_irq(pipe->bcast_processor);
+}
+
 static struct kmem_cache *lima_pp_task_slab;
 static int lima_pp_task_slab_refcnt;
 
@@ -447,6 +464,7 @@ int lima_pp_pipe_init(struct lima_device *dev)
 	pipe->task_fini = lima_pp_task_fini;
 	pipe->task_error = lima_pp_task_error;
 	pipe->task_mmu_error = lima_pp_task_mmu_error;
+	pipe->task_mask_irq = lima_pp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index f6e7a88a56f1..290f875c2859 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -419,6 +419,13 @@ static void lima_sched_timedout_job(struct drm_sched_job *job)
 	struct lima_sched_task *task = to_lima_task(job);
 	struct lima_device *ldev = pipe->ldev;
 
+	/*
+	 * The task might still finish while this timeout handler runs.
+	 * To prevent a race condition on its completion, mask all irqs
+	 * on the running core until the next hard reset completes.
+	 */
+	pipe->task_mask_irq(pipe);
+
 	if (!pipe->error)
 		DRM_ERROR("lima job timeout\n");
 
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 90f03c48ef4a..f8bbfa69baea 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -83,6 +83,7 @@ struct lima_sched_pipe {
 	void (*task_error)(struct lima_sched_pipe *pipe);
 	void (*task_mmu_error)(struct lima_sched_pipe *pipe);
 	int (*task_recover)(struct lima_sched_pipe *pipe);
+	void (*task_mask_irq)(struct lima_sched_pipe *pipe);
 
 	struct work_struct recover_work;
 };
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index be28e7bd7490..1da9d1e89f91 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -208,6 +208,8 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
+		if (!mode)
+			continue;
 
 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *
@@ -257,6 +259,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 		if (modes[i].hdisplay == output_mode->hdisplay &&
 		    modes[i].vdisplay == output_mode->vdisplay) {
 			mode = drm_mode_duplicate(encoder->dev, output_mode);
+			if (!mode)
+				continue;
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		} else {
@@ -264,6 +268,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 					    modes[i].vdisplay, 60, false,
 					    (output_mode->flags &
 					     DRM_MODE_FLAG_INTERLACE), false);
+			if (!mode)
+				continue;
 		}
 
 		/* CVT modes are sometimes unsuitable... */
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 534dd7414d42..917cb322bab1 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -506,10 +506,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	msleep(5);
 
 	/* And reset it */
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 	msleep(20);
 
-	gpiod_set_value(ctx->reset, 0);
+	gpiod_set_value_cansleep(ctx->reset, 0);
 	msleep(20);
 
 	for (i = 0; i < ctx->desc->init_length; i++) {
@@ -564,7 +564,7 @@ static int ili9881c_unprepare(struct drm_panel *panel)
 
 	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
 	regulator_disable(ctx->power);
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7797aad592a1..07b59021008e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2438,6 +2438,7 @@ static const struct display_timing koe_tx26d202vm0bwa_timing = {
 	.vfront_porch = { 3, 5, 10 },
 	.vback_porch = { 2, 5, 10 },
 	.vsync_len = { 5, 5, 5 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
 static const struct panel_desc koe_tx26d202vm0bwa = {
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index a813c00f109b..26fd45ea14cd 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -132,7 +132,6 @@ extern int radeon_cik_support;
 /* RADEON_IB_POOL_SIZE must be a power of 2 */
 #define RADEON_IB_POOL_SIZE			16
 #define RADEON_DEBUGFS_MAX_COMPONENTS		32
-#define RADEONFB_CONN_LIMIT			4
 #define RADEON_BIOS_NUM_SCRATCH			8
 
 /* internal ring indices */
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 07d23a1e62a0..8643eebe9e24 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -685,7 +685,7 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
 
-	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
+	radeon_crtc = kzalloc(sizeof(*radeon_crtc), GFP_KERNEL);
 	if (radeon_crtc == NULL)
 		return;
 
@@ -711,12 +711,6 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	dev->mode_config.cursor_width = radeon_crtc->max_cursor_width;
 	dev->mode_config.cursor_height = radeon_crtc->max_cursor_height;
 
-#if 0
-	radeon_crtc->mode_set.crtc = &radeon_crtc->base;
-	radeon_crtc->mode_set.connectors = (struct drm_connector **)(radeon_crtc + 1);
-	radeon_crtc->mode_set.num_connectors = 0;
-#endif
-
 	if (rdev->is_atom_bios && (ASIC_IS_AVIVO(rdev) || radeon_r4xx_atom))
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/sumo_dpm.c
index 45d04996adf5..a80e2edb7c0f 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -1621,6 +1621,8 @@ void sumo_construct_vid_mapping_table(struct radeon_device *rdev,
 
 	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
 		if (table[i].ulSupportedSCLK != 0) {
+			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
+				continue;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
 				table[i].usVoltageID;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bdb7a5e96560..25a9c72cca80 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -752,13 +752,6 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 				vmw_read(dev_priv,
 					 SVGA_REG_SUGGESTED_GBOBJECT_MEM_SIZE_KB);
 
-		/*
-		 * Workaround for low memory 2D VMs to compensate for the
-		 * allocation taken by fbdev
-		 */
-		if (!(dev_priv->capabilities & SVGA_CAP_3D))
-			mem_size *= 3;
-
 		dev_priv->max_mob_pages = mem_size * 1024 / PAGE_SIZE;
 		dev_priv->prim_bb_mem =
 			vmw_read(dev_priv,
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef..52ef6be9d449 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 476967ab6294..5281d693b32d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1446,7 +1446,6 @@ static void implement(const struct hid_device *hid, u8 *report,
 			hid_warn(hid,
 				 "%s() called with too large value %d (n: %d)! (%s)\n",
 				 __func__, value, n, current->comm);
-			WARN_ON(1);
 			value &= m;
 		}
 	}
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0732fe6c7a85..9f3f7588fe46 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -765,6 +765,7 @@
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
+#define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
 #define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index f4d79ec82679..bda9150aa372 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1218,8 +1218,10 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 */
 		msleep(50);
 
-		if (retval)
+		if (retval) {
+			kfree(dj_report);
 			return retval;
+		}
 	}
 
 	/*
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8dcd636daf27..e7b047421f3d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1998,6 +1998,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
 
+	/* Logitech devices */
+	{ .driver_data = MT_CLS_NSMU,
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_LOGITECH,
+			USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 7f13687267fd..eba0dd541fa2 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -294,6 +294,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
@@ -304,6 +309,26 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa76f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Granite Rapids */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Granite Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Sapphire Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Lunar Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
index d6eeea5166c0..131a67d9d4a6 100644
--- a/drivers/i2c/busses/i2c-at91-slave.c
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -106,8 +106,7 @@ static int at91_unreg_slave(struct i2c_client *slave)
 
 static u32 at91_twi_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+	return I2C_FUNC_SLAVE;
 }
 
 static const struct i2c_algorithm at91_twi_algorithm_slave = {
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0d15f4c1e9f7..5b54a9b9ed1a 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -232,7 +232,7 @@ static const struct i2c_algorithm i2c_dw_algo = {
 
 void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 {
-	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+	dev->functionality = I2C_FUNC_SLAVE;
 
 	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
 			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 71e26aa6bd8f..5e2e8bd2d055 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -443,8 +443,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
 
 	/* Init the device */
-	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
+	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a8ec3efd659e..90b9ac589e90 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val, 11);
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 6b9627bfebb0..4fd74e2847f0 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -223,11 +223,11 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, 0, 12, 'S'),
+	AD9467_CHAN(0, 0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
-	AD9467_CHAN(0, 0, 16, 'S'),
+	AD9467_CHAN(0, 0, 16, 's'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl[] = {
diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 4edc5d21cb9f..f959252a4fe6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,7 +54,9 @@
 #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
 
 #define BME680_REG_MEAS_STAT_0			0x1D
+#define   BME680_NEW_DATA_BIT			BIT(7)
 #define   BME680_GAS_MEAS_BIT			BIT(6)
+#define   BME680_MEAS_BIT			BIT(5)
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6ea99e4cbf92..2216577b1005 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/log2.h>
@@ -38,7 +39,7 @@ struct bme680_calib {
 	s8  par_h3;
 	s8  par_h4;
 	s8  par_h5;
-	s8  par_h6;
+	u8  par_h6;
 	s8  par_h7;
 	s8  par_gh1;
 	s16 par_gh2;
@@ -342,10 +343,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	if (!calib->par_t2)
 		bme680_read_calib(data, calib);
 
-	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
+	var1 = (adc_temp >> 3) - ((s32)calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
-	var3 = (var3 * (calib->par_t3 << 4)) >> 14;
+	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
 	data->t_fine = var2 + var3;
 	calc_temp = (data->t_fine * 5 + 128) >> 8;
 
@@ -368,9 +369,9 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var1 = (data->t_fine >> 1) - 64000;
 	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * calib->par_p6) >> 2;
 	var2 = var2 + (var1 * calib->par_p5 << 1);
-	var2 = (var2 >> 2) + (calib->par_p4 << 16);
+	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
 	var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
-			(calib->par_p3 << 5)) >> 3) +
+			((s32)calib->par_p3 << 5)) >> 3) +
 			((calib->par_p2 * var1) >> 1);
 	var1 = var1 >> 18;
 	var1 = ((32768 + var1) * calib->par_p1) >> 15;
@@ -388,7 +389,7 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var3 = ((press_comp >> 8) * (press_comp >> 8) *
 			(press_comp >> 8) * calib->par_p10) >> 17;
 
-	press_comp += (var1 + var2 + var3 + (calib->par_p7 << 7)) >> 4;
+	press_comp += (var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4;
 
 	return press_comp;
 }
@@ -414,7 +415,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
 	var3 = var1 * var2;
-	var4 = calib->par_h6 << 7;
+	var4 = (s32)calib->par_h6 << 7;
 	var4 = (var4 + ((temp_scaled * calib->par_h7) / 100)) >> 4;
 	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
 	var6 = (var4 * var5) >> 1;
@@ -532,6 +533,43 @@ static u8 bme680_oversampling_to_reg(u8 val)
 	return ilog2(val) + 1;
 }
 
+/*
+ * Taken from Bosch BME680 API:
+ * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
+ */
+static int bme680_wait_for_eoc(struct bme680_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int check;
+	int ret;
+	/*
+	 * (Sum of oversampling ratios * time per oversampling) +
+	 * TPH measurement + gas measurement + wait transition from forced mode
+	 * + heater duration
+	 */
+	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
+			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   (477 * 5) + 1000 + (data->heater_dur * 1000);
+
+	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
+	if (ret) {
+		dev_err(dev, "failed to read measurement status register.\n");
+		return ret;
+	}
+	if (check & BME680_MEAS_BIT) {
+		dev_err(dev, "Device measurement cycle incomplete.\n");
+		return -EBUSY;
+	}
+	if (!(check & BME680_NEW_DATA_BIT)) {
+		dev_err(dev, "No new data available from the device.\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -622,6 +660,10 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -678,7 +720,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
@@ -738,6 +780,10 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 987264410278..520a3748befa 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -411,7 +411,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_NANO;
 		}
 
 		mutex_lock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 3441b0d61c5d..cef76c1c40f3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -128,10 +128,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index aee7b9ff4bf4..608d07115a36 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -128,10 +128,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index e2f720eec1e1..56ce0fea00e9 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -225,12 +225,15 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	int err;
 	struct mlx5_srq_attr in = {};
 	__u32 max_srq_wqes = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
-
-	/* Sanity check SRQ size before proceeding */
-	if (init_attr->attr.max_wr >= max_srq_wqes) {
-		mlx5_ib_dbg(dev, "max_wr %d, cap %d\n",
-			    init_attr->attr.max_wr,
-			    max_srq_wqes);
+	__u32 max_sge_sz =  MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
+			    sizeof(struct mlx5_wqe_data_seg);
+
+	/* Sanity check SRQ and sge size before proceeding */
+	if (init_attr->attr.max_wr >= max_srq_wqes ||
+	    init_attr->attr.max_sge > max_sge_sz) {
+		mlx5_ib_dbg(dev, "max_wr %d,wr_cap %d,max_sge %d, sge_cap:%d\n",
+			    init_attr->attr.max_wr, max_srq_wqes,
+			    init_attr->attr.max_sge, max_sge_sz);
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 49504dcd5dc6..9190aa18263e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1356,19 +1356,19 @@ static int input_print_modalias_bits(char *buf, int size,
 				     char name, unsigned long *bm,
 				     unsigned int min_bit, unsigned int max_bit)
 {
-	int len = 0, i;
+	int bit = min_bit;
+	int len = 0;
 
 	len += snprintf(buf, max(size, 0), "%c", name);
-	for (i = min_bit; i < max_bit; i++)
-		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+	for_each_set_bit_from(bit, bm, max_bit)
+		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
 	return len;
 }
 
-static int input_print_modalias(char *buf, int size, struct input_dev *id,
-				int add_cr)
+static int input_print_modalias_parts(char *buf, int size, int full_len,
+				      struct input_dev *id)
 {
-	int len;
+	int len, klen, remainder, space;
 
 	len = snprintf(buf, max(size, 0),
 		       "input:b%04Xv%04Xp%04Xe%04X-",
@@ -1377,8 +1377,49 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
-	len += input_print_modalias_bits(buf + len, size - len,
+
+	/*
+	 * Calculate the remaining space in the buffer making sure we
+	 * have place for the terminating 0.
+	 */
+	space = max(size - (len + 1), 0);
+
+	klen = input_print_modalias_bits(buf + len, size - len,
 				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	len += klen;
+
+	/*
+	 * If we have more data than we can fit in the buffer, check
+	 * if we can trim key data to fit in the rest. We will indicate
+	 * that key data is incomplete by adding "+" sign at the end, like
+	 * this: * "k1,2,3,45,+,".
+	 *
+	 * Note that we shortest key info (if present) is "k+," so we
+	 * can only try to trim if key data is longer than that.
+	 */
+	if (full_len && size < full_len + 1 && klen > 3) {
+		remainder = full_len - len;
+		/*
+		 * We can only trim if we have space for the remainder
+		 * and also for at least "k+," which is 3 more characters.
+		 */
+		if (remainder <= space - 3) {
+			int i;
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (i = size - 1 - remainder - 3; i >= 0; i--) {
+				if (buf[i] == 'k' || buf[i] == ',') {
+					strcpy(buf + i + 1, "+,");
+					len = i + 3; /* Not counting '\0' */
+					break;
+				}
+			}
+		}
+	}
+
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1394,12 +1435,25 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'w', id->swbit, 0, SW_MAX);
 
-	if (add_cr)
-		len += snprintf(buf + len, max(size - len, 0), "\n");
-
 	return len;
 }
 
+static int input_print_modalias(char *buf, int size, struct input_dev *id)
+{
+	int full_len;
+
+	/*
+	 * Printing is done in 2 passes: first one figures out total length
+	 * needed for the modalias string, second one will try to trim key
+	 * data in case when buffer is too small for the entire modalias.
+	 * If the buffer is too small regardless, it will fill as much as it
+	 * can (without trimming key data) into the buffer and leave it to
+	 * the caller to figure out what to do with the result.
+	 */
+	full_len = input_print_modalias_parts(NULL, 0, 0, id);
+	return input_print_modalias_parts(buf, size, full_len, id);
+}
+
 static ssize_t input_dev_show_modalias(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -1407,7 +1461,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1582,6 +1638,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 	return 0;
 }
 
+/*
+ * This is a pretty gross hack. When building uevent data the driver core
+ * may try adding more environment variables to kobj_uevent_env without
+ * telling us, so we have no idea how much of the buffer we can use to
+ * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
+ * reduce amount of memory we will use for the modalias environment variable.
+ *
+ * The potential additions are:
+ *
+ * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
+ * HOME=/ (6 bytes)
+ * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
+ *
+ * 68 bytes total. Allow extra buffer - 96 bytes
+ */
+#define UEVENT_ENV_EXTRA_LEN	96
+
 static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 					 struct input_dev *dev)
 {
@@ -1591,9 +1664,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 		return -ENOMEM;
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
-				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
-	if (len >= (sizeof(env->buf) - env->buflen))
+				   (int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN,
+				   dev);
+	if (len >= ((int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN))
 		return -ENOMEM;
 
 	env->buflen += len;
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index f437eefec94a..9452a12ddb09 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -231,8 +231,8 @@ static int ili251x_read_touch_data(struct i2c_client *client, u8 *data)
 	if (!error && data[0] == 2) {
 		error = i2c_master_recv(client, data + ILI251X_DATA_SIZE1,
 					ILI251X_DATA_SIZE2);
-		if (error >= 0 && error != ILI251X_DATA_SIZE2)
-			error = -EIO;
+		if (error >= 0)
+			error = error == ILI251X_DATA_SIZE2 ? 0 : -EIO;
 	}
 
 	return error;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4a8791e037b8..c4b1a652c2c7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -435,6 +435,11 @@ extern bool amd_iommu_irq_remap;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* Make iterating over all pci segment easier */
+#define for_each_pci_segment(pci_seg) \
+	list_for_each_entry((pci_seg), &amd_iommu_pci_seg_list, list)
+#define for_each_pci_segment_safe(pci_seg, next) \
+	list_for_each_entry_safe((pci_seg), (next), &amd_iommu_pci_seg_list, list)
 /*
  * Make iterating over all IOMMUs easier
  */
@@ -494,6 +499,17 @@ struct domain_pgtable {
 	u64 *root;
 };
 
+/*
+ * This structure contains information about one PCI segment in the system.
+ */
+struct amd_iommu_pci_seg {
+	/* List with all PCI segments in the system */
+	struct list_head list;
+
+	/* PCI segment number */
+	u16 id;
+};
+
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
@@ -545,7 +561,7 @@ struct amd_iommu {
 	u16 cap_ptr;
 
 	/* pci domain of this IOMMU */
-	u16 pci_seg;
+	struct amd_iommu_pci_seg *pci_seg;
 
 	/* start of exclusion range of that IOMMU */
 	u64 exclusion_start;
@@ -676,6 +692,12 @@ extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
 extern struct list_head acpihid_map;
 
+/*
+ * List with all PCI segments in the system. This list is not locked because
+ * it is only written at driver initialization time
+ */
+extern struct list_head amd_iommu_pci_seg_list;
+
 /*
  * List with all IOMMUs in the system. This list is not locked because it is
  * only written and read at driver initialization or suspend time
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 91cc3a5643ca..917ee5a67e78 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -165,6 +165,7 @@ LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
 bool amd_iommu_unmap_flush;		/* if true, flush on every unmap */
 
+LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
@@ -1456,8 +1457,54 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	return 0;
 }
 
+/* Allocate PCI segment data structure */
+static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	pci_seg = kzalloc(sizeof(struct amd_iommu_pci_seg), GFP_KERNEL);
+	if (pci_seg == NULL)
+		return NULL;
+
+	pci_seg->id = id;
+	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
+
+	return pci_seg;
+}
+
+static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == id)
+			return pci_seg;
+	}
+
+	return alloc_pci_segment(id);
+}
+
+static void __init free_pci_segments(void)
+{
+	struct amd_iommu_pci_seg *pci_seg, *next;
+
+	for_each_pci_segment_safe(pci_seg, next) {
+		list_del(&pci_seg->list);
+		kfree(pci_seg);
+	}
+}
+
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev) {
+		iommu_device_unregister(&iommu->iommu);
+		iommu_device_sysfs_remove(&iommu->iommu);
+	}
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_sysfs(iommu);
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
@@ -1542,8 +1589,14 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
  */
 static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 {
+	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
+	pci_seg = get_pci_segment(h->pci_seg);
+	if (pci_seg == NULL)
+		return -ENOMEM;
+	iommu->pci_seg = pci_seg;
+
 	raw_spin_lock_init(&iommu->lock);
 	iommu->cmd_sem_val = 0;
 
@@ -1564,7 +1617,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	 */
 	iommu->devid   = h->devid;
 	iommu->cap_ptr = h->cap_ptr;
-	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
 
 	switch (h->type) {
@@ -2511,6 +2563,7 @@ static void __init free_iommu_resources(void)
 	amd_iommu_dev_table = NULL;
 
 	free_iommu_all();
+	free_pci_segments();
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 982c42c87310..9ac7b37290eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2925,7 +2925,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 67a2c47f4201..f006c780dd4b 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -54,7 +54,7 @@ void bch_dump_bucket(struct btree_keys *b)
 int __bch_count_data(struct btree_keys *b)
 {
 	unsigned int ret = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k;
 
 	if (b->ops->is_extents)
@@ -67,7 +67,7 @@ void __bch_check_keys(struct btree_keys *b, const char *fmt, ...)
 {
 	va_list args;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	const char *err;
 
 	for_each_key(b, k, &iter) {
@@ -877,7 +877,7 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	unsigned int status = BTREE_INSERT_STATUS_NO_INSERT;
 	struct bset *i = bset_tree_last(b)->data;
 	struct bkey *m, *prev = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey preceding_key_on_stack = ZERO_KEY;
 	struct bkey *preceding_key_p = &preceding_key_on_stack;
 
@@ -893,9 +893,9 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	else
 		preceding_key(k, &preceding_key_p);
 
-	m = bch_btree_iter_init(b, &iter, preceding_key_p);
+	m = bch_btree_iter_stack_init(b, &iter, preceding_key_p);
 
-	if (b->ops->insert_fixup(b, k, &iter, replace_key))
+	if (b->ops->insert_fixup(b, k, &iter.iter, replace_key))
 		return status;
 
 	status = BTREE_INSERT_STATUS_INSERT;
@@ -1096,33 +1096,33 @@ void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 				 btree_iter_cmp));
 }
 
-static struct bkey *__bch_btree_iter_init(struct btree_keys *b,
-					  struct btree_iter *iter,
-					  struct bkey *search,
-					  struct bset_tree *start)
+static struct bkey *__bch_btree_iter_stack_init(struct btree_keys *b,
+						struct btree_iter_stack *iter,
+						struct bkey *search,
+						struct bset_tree *start)
 {
 	struct bkey *ret = NULL;
 
-	iter->size = ARRAY_SIZE(iter->data);
-	iter->used = 0;
+	iter->iter.size = ARRAY_SIZE(iter->stack_data);
+	iter->iter.used = 0;
 
 #ifdef CONFIG_BCACHE_DEBUG
-	iter->b = b;
+	iter->iter.b = b;
 #endif
 
 	for (; start <= bset_tree_last(b); start++) {
 		ret = bch_bset_search(b, start, search);
-		bch_btree_iter_push(iter, ret, bset_bkey_last(start->data));
+		bch_btree_iter_push(&iter->iter, ret, bset_bkey_last(start->data));
 	}
 
 	return ret;
 }
 
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				 struct btree_iter_stack *iter,
 				 struct bkey *search)
 {
-	return __bch_btree_iter_init(b, iter, search, b->set);
+	return __bch_btree_iter_stack_init(b, iter, search, b->set);
 }
 
 static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
@@ -1289,10 +1289,10 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 			    struct bset_sort_state *state)
 {
 	size_t order = b->page_order, keys = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	int oldsize = bch_count_data(b);
 
-	__bch_btree_iter_init(b, &iter, NULL, &b->set[start]);
+	__bch_btree_iter_stack_init(b, &iter, NULL, &b->set[start]);
 
 	if (start) {
 		unsigned int i;
@@ -1303,7 +1303,7 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 		order = get_order(__set_bytes(b->set->data, keys));
 	}
 
-	__btree_sort(b, &iter, start, order, false, state);
+	__btree_sort(b, &iter.iter, start, order, false, state);
 
 	EBUG_ON(oldsize >= 0 && bch_count_data(b) != oldsize);
 }
@@ -1319,11 +1319,11 @@ void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 			 struct bset_sort_state *state)
 {
 	uint64_t start_time = local_clock();
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
-	bch_btree_iter_init(b, &iter, NULL);
+	bch_btree_iter_stack_init(b, &iter, NULL);
 
-	btree_mergesort(b, new->set->data, &iter, false, true);
+	btree_mergesort(b, new->set->data, &iter.iter, false, true);
 
 	bch_time_stats_update(&state->time, start_time);
 
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index a50dcfda656f..2ed6dbd35d6e 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -321,7 +321,14 @@ struct btree_iter {
 #endif
 	struct btree_iter_set {
 		struct bkey *k, *end;
-	} data[MAX_BSETS];
+	} data[];
+};
+
+/* Fixed-size btree_iter that can be allocated on the stack */
+
+struct btree_iter_stack {
+	struct btree_iter iter;
+	struct btree_iter_set stack_data[MAX_BSETS];
 };
 
 typedef bool (*ptr_filter_fn)(struct btree_keys *b, const struct bkey *k);
@@ -333,9 +340,9 @@ struct bkey *bch_btree_iter_next_filter(struct btree_iter *iter,
 
 void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 			 struct bkey *end);
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
-				 struct bkey *search);
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				       struct btree_iter_stack *iter,
+				       struct bkey *search);
 
 struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 			       const struct bkey *search);
@@ -350,13 +357,14 @@ static inline struct bkey *bch_bset_search(struct btree_keys *b,
 	return search ? __bch_bset_search(b, t, search) : t->data->start;
 }
 
-#define for_each_key_filter(b, k, iter, filter)				\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next_filter((iter), (b), filter));)
+#define for_each_key_filter(b, k, stack_iter, filter)                      \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL);           \
+	     ((k) = bch_btree_iter_next_filter(&((stack_iter)->iter), (b), \
+					       filter));)
 
-#define for_each_key(b, k, iter)					\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next(iter));)
+#define for_each_key(b, k, stack_iter)                           \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL); \
+	     ((k) = bch_btree_iter_next(&((stack_iter)->iter)));)
 
 /* Sorting */
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 1a1a9554474a..2768b4b4302d 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1283,7 +1283,7 @@ static bool btree_gc_mark_node(struct btree *b, struct gc_stat *gc)
 	uint8_t stale = 0;
 	unsigned int keys = 0, good_keys = 0;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bset_tree *t;
 
 	gc->nodes++;
@@ -1544,7 +1544,7 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 static unsigned int btree_gc_count_keys(struct btree *b)
 {
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	unsigned int ret = 0;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_bad)
@@ -1585,17 +1585,18 @@ static int btree_gc_recurse(struct btree *b, struct btree_op *op,
 	int ret = 0;
 	bool should_rewrite;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct gc_merge_info r[GC_MERGE_NODES];
 	struct gc_merge_info *i, *last = r + ARRAY_SIZE(r) - 1;
 
-	bch_btree_iter_init(&b->keys, &iter, &b->c->gc_done);
+	bch_btree_iter_stack_init(&b->keys, &iter, &b->c->gc_done);
 
 	for (i = r; i < r + ARRAY_SIZE(r); i++)
 		i->b = ERR_PTR(-EINTR);
 
 	while (1) {
-		k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad);
+		k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad);
 		if (k) {
 			r->b = bch_btree_node_get(b->c, op, k, b->level - 1,
 						  true, b);
@@ -1885,7 +1886,7 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 {
 	int ret = 0;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_invalid)
 		bch_initial_mark_key(b->c, b->level, k);
@@ -1893,10 +1894,10 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 	bch_initial_mark_key(b->c, b->level + 1, &b->key);
 
 	if (b->level) {
-		bch_btree_iter_init(&b->keys, &iter, NULL);
+		bch_btree_iter_stack_init(&b->keys, &iter, NULL);
 
 		do {
-			k = bch_btree_iter_next_filter(&iter, &b->keys,
+			k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad);
 			if (k) {
 				btree_node_prefetch(b, k);
@@ -1924,7 +1925,7 @@ static int bch_btree_check_thread(void *arg)
 	struct btree_check_info *info = arg;
 	struct btree_check_state *check_state = info->state;
 	struct cache_set *c = check_state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
@@ -1933,8 +1934,8 @@ static int bch_btree_check_thread(void *arg)
 	ret = 0;
 
 	/* root node keys are checked before thread created */
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -1952,7 +1953,7 @@ static int bch_btree_check_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -2025,7 +2026,7 @@ int bch_btree_check(struct cache_set *c)
 	int ret = 0;
 	int i;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct btree_check_state check_state;
 
 	/* check and mark root node keys */
@@ -2521,11 +2522,11 @@ static int bch_btree_map_nodes_recurse(struct btree *b, struct btree_op *op,
 
 	if (b->level) {
 		struct bkey *k;
-		struct btree_iter iter;
+		struct btree_iter_stack iter;
 
-		bch_btree_iter_init(&b->keys, &iter, from);
+		bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-		while ((k = bch_btree_iter_next_filter(&iter, &b->keys,
+		while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad))) {
 			ret = bcache_btree(map_nodes_recurse, k, b,
 				    op, from, fn, flags);
@@ -2554,11 +2555,12 @@ int bch_btree_map_keys_recurse(struct btree *b, struct btree_op *op,
 {
 	int ret = MAP_CONTINUE;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
-	bch_btree_iter_init(&b->keys, &iter, from);
+	bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-	while ((k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad))) {
+	while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad))) {
 		ret = !b->level
 			? fn(op, b, k)
 			: bcache_btree(map_keys_recurse, k,
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 04ddaa4bbd77..14336fd54102 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1939,8 +1939,9 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	INIT_LIST_HEAD(&c->btree_cache_freed);
 	INIT_LIST_HEAD(&c->data_buckets);
 
-	iter_size = ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size + 1) *
-		sizeof(struct btree_iter_set);
+	iter_size = sizeof(struct btree_iter) +
+		    ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size) *
+			    sizeof(struct btree_iter_set);
 
 	c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL);
 	if (!c->devices)
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index ca3e2f000cd4..a31108625f46 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -639,7 +639,7 @@ static unsigned int bch_root_usage(struct cache_set *c)
 	unsigned int bytes = 0;
 	struct bkey *k;
 	struct btree *b;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
 	goto lock_root;
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 8e3f5f004c39..9a2aac59f6bc 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -852,15 +852,15 @@ static int bch_dirty_init_thread(void *arg)
 	struct dirty_init_thrd_info *info = arg;
 	struct bch_dirty_init_state *state = info->state;
 	struct cache_set *c = state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
 	prev_idx = 0;
 
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -874,7 +874,7 @@ static int bch_dirty_init_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -923,7 +923,7 @@ void bch_sectors_dirty_init(struct bcache_device *d)
 	int i;
 	struct btree *b = NULL;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct sectors_dirty_init op;
 	struct cache_set *c = d->c;
 	struct bch_dirty_init_state state;
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 23a0c209744d..661588fc64f6 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -974,7 +974,7 @@ int dvb_usercopy(struct file *file,
 		     int (*func)(struct file *file,
 		     unsigned int cmd, void *arg))
 {
-	char    sbuf[128];
+	char    sbuf[128] = {};
 	void    *mbuf = NULL;
 	void    *parg = NULL;
 	int     err  = -EINVAL;
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 188d847662ff..7b8e92bcaa98 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -400,8 +400,10 @@ static int mei_me_pci_resume(struct device *device)
 	}
 
 	err = mei_restart(dev);
-	if (err)
+	if (err) {
+		free_irq(pdev->irq, dev);
 		return err;
+	}
 
 	/* Start timer if stopped in suspend */
 	schedule_delayed_work(&dev->timer_work, HZ);
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index e3436abf39f4..5b7ef47f4c11 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -9,6 +9,7 @@
 #include <linux/vmw_vmci_api.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
@@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event_msg)
 {
 	struct vmci_subscription *cur;
 	struct list_head *subscriber_list;
+	u32 sanitized_event, max_vmci_event;
 
 	rcu_read_lock();
-	subscriber_list = &subscriber_array[event_msg->event_data.event];
+	max_vmci_event = ARRAY_SIZE(subscriber_array);
+	sanitized_event = array_index_nospec(event_msg->event_data.event, max_vmci_event);
+	subscriber_list = &subscriber_array[sanitized_event];
 	list_for_each_entry_rcu(cur, subscriber_list, node) {
 		cur->callback(cur->id, &event_msg->event_data,
 			      cur->callback_data);
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 647928ab00a3..77258948440f 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1347,7 +1347,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static int davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1404,7 +1404,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove		= __exit_p(davinci_mmcsd_remove),
+	.remove		= davinci_mmcsd_remove,
 	.id_table	= davinci_mmc_devtype,
 };
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 8b02fe3916d1..7e5dab385518 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1380,7 +1380,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 
 	ret = pci_read_config_byte(chip->pdev, 0xAE, &scratch);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * Turn PMOS on [bit 0], set over current detection to 2.4 V
@@ -1391,7 +1391,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 	else
 		scratch &= ~0x47;
 
-	return pci_write_config_byte(chip->pdev, 0xAE, scratch);
+	ret = pci_write_config_byte(chip->pdev, 0xAE, scratch);
+
+fail:
+	return pcibios_err_to_errno(ret);
 }
 
 static int jmicron_probe(struct sdhci_pci_chip *chip)
@@ -2308,7 +2311,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
@@ -2317,7 +2320,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bad01cc6823f..9091930f5859 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2488,26 +2488,29 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
-	unsigned long flags;
+	bool allow_invert = false;
 	int is_readonly;
 
-	spin_lock_irqsave(&host->lock, flags);
-
-	if (host->flags & SDHCI_DEVICE_DEAD)
+	if (host->flags & SDHCI_DEVICE_DEAD) {
 		is_readonly = 0;
-	else if (host->ops->get_ro)
+	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	else if (mmc_can_gpio_ro(host->mmc))
+	} else if (mmc_can_gpio_ro(host->mmc)) {
 		is_readonly = mmc_gpio_get_ro(host->mmc);
-	else
+		/* Do not invert twice */
+		allow_invert = !(host->mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+	} else {
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
+		allow_invert = true;
+	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	if (is_readonly >= 0 &&
+	    allow_invert &&
+	    (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT))
+		is_readonly = !is_readonly;
 
-	/* This quirk needs to be replaced by a callback-function later */
-	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
-		!is_readonly : is_readonly;
+	return is_readonly;
 }
 
 #define SAMPLE_COUNT	5
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 8bd3f6bf9b10..be6bdedc9b61 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -159,6 +159,118 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     0 /*SPINAND_HAS_QE_BIT*/,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+
+	SPINAND_INFO("MX35LF2G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G14AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x90),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G24AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 4f3bcc59a638..3351be651473 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -102,7 +102,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			offset -= master->erasesize;
 		}
 	} else {
-		offset = directory * master->erasesize;
+		offset = (unsigned long) directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			offset += master->erasesize;
 			if (offset == master->size)
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f42f2f4e4b60..535b64155320 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -206,10 +206,8 @@ static int ksz9477_reset_switch(struct ksz_device *dev)
 			   SPI_AUTO_EDGE_DETECTION, 0);
 
 	/* default configuration */
-	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
-	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
-	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
-	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
+	ksz_write8(dev, REG_SW_LUE_CTRL_1,
+		   SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER);
 
 	/* disable interrupts */
 	ksz_write32(dev, REG_SW_INT_MASK__4, SWITCH_INT_MASK);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 600de587d7a9..e70b9ccca380 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -272,13 +272,12 @@ lio_vf_rep_copy_packet(struct octeon_device *oct,
 				pg_info->page_offset;
 			memcpy(skb->data, va, MIN_SKB_SIZE);
 			skb_put(skb, MIN_SKB_SIZE);
+			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+					pg_info->page,
+					pg_info->page_offset + MIN_SKB_SIZE,
+					len - MIN_SKB_SIZE,
+					LIO_RXBUFFER_SZ);
 		}
-
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				pg_info->page,
-				pg_info->page_offset + MIN_SKB_SIZE,
-				len - MIN_SKB_SIZE,
-				LIO_RXBUFFER_SZ);
 	} else {
 		struct octeon_skb_page_info *pg_info =
 			((struct octeon_skb_page_info *)(skb->cb));
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 07ba0438f965..fa202fea537f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2383,11 +2383,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *net_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev = priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err = 0;
 
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues = dpaa2_eth_queue_count(priv);
 	netdev_queues = (net_dev->num_tc ? : 1) * num_queues;
 
@@ -2397,16 +2400,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i = 0; i < netdev_queues; i++) {
 		fq = &priv->fq[i % num_queues];
 
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
 
-		err = netif_set_xps_queue(net_dev, &xps_mask, i);
+		err = netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
 
+	free_cpumask_var(xps_mask);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a4ab3e7efa5e..f8275534205a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2513,6 +2513,9 @@ static int hns3_alloc_ring_buffers(struct hns3_enet_ring *ring)
 		ret = hns3_alloc_and_attach_buffer(ring, i);
 		if (ret)
 			goto out_buffer_fail;
+
+		if (!(i % HNS3_RESCHED_BD_NUM))
+			cond_resched();
 	}
 
 	return 0;
@@ -3946,6 +3949,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 		}
 
 		u64_stats_init(&priv->ring[i].syncp);
+		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 54d02ea4aaa7..669cd30b9871 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -182,6 +182,8 @@ enum hns3_nic_state {
 
 #define HNS3_RING_EN_B				0
 
+#define HNS3_RESCHED_BD_NUM			1024
+
 enum hns3_pkt_l2t_type {
 	HNS3_L2_TYPE_UNICAST,
 	HNS3_L2_TYPE_MULTICAST,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f1834853872d..aeb8bb3c549a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4393,7 +4393,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 
 		/* Verify if UDP port is being offloaded by HW */
 		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
-			return features;
+			return vxlan_features_check(skb, features);
 
 #if IS_ENABLED(CONFIG_GENEVE)
 		/* Support Geneve offload for default UDP port */
@@ -4414,7 +4414,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
 	features = vlan_features_check(skb, features);
-	features = vxlan_features_check(skb, features);
 
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (mlx5e_ipsec_feature_check(skb, netdev, features))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a37ca4b1e566..324ef6990e9a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -272,10 +272,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 	if (ret)
 		return ret;
 
-	if (qcq->napi.poll)
-		napi_enable(&qcq->napi);
-
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		napi_enable(&qcq->napi);
 		irq_set_affinity_hint(qcq->intr.vector,
 				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index 66229b300c5a..c205d3f03696 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -110,10 +110,8 @@ qcaspi_info_show(struct seq_file *s, void *what)
 
 	seq_printf(s, "IRQ              : %d\n",
 		   qca->spi_dev->irq);
-	seq_printf(s, "INTR REQ         : %u\n",
-		   qca->intr_req);
-	seq_printf(s, "INTR SVC         : %u\n",
-		   qca->intr_svc);
+	seq_printf(s, "INTR             : %lx\n",
+		   qca->intr);
 
 	seq_printf(s, "SPI max speed    : %lu\n",
 		   (unsigned long)qca->spi_dev->max_speed_hz);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index ffa1846f5b4c..f6bc5a273477 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -49,6 +49,8 @@
 
 #define MAX_DMA_BURST_LEN 5000
 
+#define SPI_INTR 0
+
 /*   Modules parameters     */
 #define QCASPI_CLK_SPEED_MIN 1000000
 #define QCASPI_CLK_SPEED_MAX 16000000
@@ -585,14 +587,14 @@ qcaspi_spi_thread(void *data)
 			continue;
 		}
 
-		if ((qca->intr_req == qca->intr_svc) &&
+		if (!test_bit(SPI_INTR, &qca->intr) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
 
-		netdev_dbg(qca->net_dev, "have work to do. int: %d, tx_skb: %p\n",
-			   qca->intr_req - qca->intr_svc,
+		netdev_dbg(qca->net_dev, "have work to do. int: %lu, tx_skb: %p\n",
+			   qca->intr,
 			   qca->txr.skb[qca->txr.head]);
 
 		qcaspi_qca7k_sync(qca, QCASPI_EVENT_UPDATE);
@@ -606,8 +608,7 @@ qcaspi_spi_thread(void *data)
 			msleep(QCASPI_QCA7K_REBOOT_TIME_MS);
 		}
 
-		if (qca->intr_svc != qca->intr_req) {
-			qca->intr_svc = qca->intr_req;
+		if (test_and_clear_bit(SPI_INTR, &qca->intr)) {
 			start_spi_intr_handling(qca, &intr_cause);
 
 			if (intr_cause & SPI_INT_CPU_ON) {
@@ -669,7 +670,7 @@ qcaspi_intr_handler(int irq, void *data)
 {
 	struct qcaspi *qca = data;
 
-	qca->intr_req++;
+	set_bit(SPI_INTR, &qca->intr);
 	if (qca->spi_thread &&
 	    qca->spi_thread->state != TASK_RUNNING)
 		wake_up_process(qca->spi_thread);
@@ -686,8 +687,7 @@ qcaspi_netdev_open(struct net_device *dev)
 	if (!qca)
 		return -EINVAL;
 
-	qca->intr_req = 1;
-	qca->intr_svc = 0;
+	set_bit(SPI_INTR, &qca->intr);
 	qca->sync = QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);
 
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index d13a67e20d65..8d4767e9b914 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -92,8 +92,7 @@ struct qcaspi {
 	struct qcafrm_handle frm_handle;
 	struct sk_buff *rx_skb;
 
-	unsigned int intr_req;
-	unsigned int intr_svc;
+	unsigned long intr;
 	u16 reset_count;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c29d43c5f450..d24eb5ee152a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4247,13 +4247,12 @@ static bool rtl8169_tso_csum_v2(struct rtl8169_private *tp,
 	return true;
 }
 
-static bool rtl_tx_slots_avail(struct rtl8169_private *tp,
-			       unsigned int nr_frags)
+static bool rtl_tx_slots_avail(struct rtl8169_private *tp)
 {
 	unsigned int slots_avail = tp->dirty_tx + NUM_TX_DESC - tp->cur_tx;
 
 	/* A skbuff with nr_frags needs nr_frags+1 entries in the tx queue */
-	return slots_avail > nr_frags;
+	return slots_avail > MAX_SKB_FRAGS;
 }
 
 /* Versions RTL8102e and from RTL8168c onwards support csum_v2 */
@@ -4279,24 +4278,19 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
-	txd_first = tp->TxDescArray + entry;
-
-	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
+	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
 		goto err_stop_0;
 	}
 
-	if (unlikely(le32_to_cpu(txd_first->opts1) & DescOwn))
-		goto err_stop_0;
-
 	opts[1] = rtl8169_tx_vlan_tag(skb);
 	opts[0] = 0;
 
@@ -4309,6 +4303,9 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				    entry, false)))
 		goto err_dma_0;
 
+	txd_first = tp->TxDescArray + entry;
+
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
@@ -4331,22 +4328,15 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	/* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
 	smp_wmb();
 
-	tp->cur_tx += frags + 1;
+	WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
 
-	stop_queue = !rtl_tx_slots_avail(tp, MAX_SKB_FRAGS);
+	stop_queue = !rtl_tx_slots_avail(tp);
 	if (unlikely(stop_queue)) {
 		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
 		 * not miss a ring update when it notices a stopped queue.
 		 */
 		smp_wmb();
 		netif_stop_queue(dev);
-		door_bell = true;
-	}
-
-	if (door_bell)
-		rtl8169_doorbell(tp);
-
-	if (unlikely(stop_queue)) {
 		/* Sync with rtl_tx:
 		 * - publish queue status and cur_tx ring index (write barrier)
 		 * - refresh dirty_tx ring index (read barrier).
@@ -4354,11 +4344,15 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 		 * status and forget to wake up queue, a racing rtl_tx thread
 		 * can't.
 		 */
-		smp_mb();
-		if (rtl_tx_slots_avail(tp, MAX_SKB_FRAGS))
+		smp_mb__after_atomic();
+		if (rtl_tx_slots_avail(tp))
 			netif_start_queue(dev);
+		door_bell = true;
 	}
 
+	if (door_bell)
+		rtl8169_doorbell(tp);
+
 	return NETDEV_TX_OK;
 
 err_dma_1:
@@ -4469,12 +4463,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		   int budget)
 {
-	unsigned int dirty_tx, tx_left, bytes_compl = 0, pkts_compl = 0;
+	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
 
 	dirty_tx = tp->dirty_tx;
-	smp_rmb();
 
-	for (tx_left = tp->cur_tx - dirty_tx; tx_left > 0; tx_left--) {
+	while (READ_ONCE(tp->cur_tx) != dirty_tx) {
 		unsigned int entry = dirty_tx % NUM_TX_DESC;
 		struct sk_buff *skb = tp->tx_skb[entry].skb;
 		u32 status;
@@ -4498,7 +4491,6 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 
 		rtl_inc_priv_stats(&tp->tx_stats, pkts_compl, bytes_compl);
 
-		tp->dirty_tx = dirty_tx;
 		/* Sync with rtl8169_start_xmit:
 		 * - publish dirty_tx ring index (write barrier)
 		 * - refresh cur_tx ring index and queue status (read barrier)
@@ -4506,11 +4498,9 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 * a racing xmit thread can only have a right view of the
 		 * ring status.
 		 */
-		smp_mb();
-		if (netif_queue_stopped(dev) &&
-		    rtl_tx_slots_avail(tp, MAX_SKB_FRAGS)) {
+		smp_store_mb(tp->dirty_tx, dirty_tx);
+		if (netif_queue_stopped(dev) && rtl_tx_slots_avail(tp))
 			netif_wake_queue(dev);
-		}
 		/*
 		 * 8168 hack: TxPoll requests are lost when the Tx packets are
 		 * too close. Let's kick an extra TxPoll request when a burst
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 43165c662740..4da1a80de722 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -310,10 +310,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 			struct tc_cbs_qopt_offload *qopt)
 {
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
+	s64 port_transmit_rate_kbps;
 	u32 queue = qopt->queue;
-	u32 ptr, speed_div;
 	u32 mode_to_use;
 	u64 value;
+	u32 ptr;
 	int ret;
 
 	/* Queue 0 is not AVB capable */
@@ -322,30 +323,30 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
-	/* Port Transmit Rate and Speed Divider */
-	switch (priv->speed) {
-	case SPEED_10000:
-		ptr = 32;
-		speed_div = 10000000;
-		break;
-	case SPEED_5000:
-		ptr = 32;
-		speed_div = 5000000;
-		break;
-	case SPEED_2500:
-		ptr = 8;
-		speed_div = 2500000;
-		break;
-	case SPEED_1000:
-		ptr = 8;
-		speed_div = 1000000;
-		break;
-	case SPEED_100:
-		ptr = 4;
-		speed_div = 100000;
-		break;
-	default:
-		return -EOPNOTSUPP;
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
+	if (qopt->enable) {
+		/* Port Transmit Rate and Speed Divider */
+		switch (div_s64(port_transmit_rate_kbps, 1000)) {
+		case SPEED_10000:
+		case SPEED_5000:
+			ptr = 32;
+			break;
+		case SPEED_2500:
+		case SPEED_1000:
+			ptr = 8;
+			break;
+		case SPEED_100:
+			ptr = 4;
+			break;
+		default:
+			netdev_err(priv->dev,
+				   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
+				   port_transmit_rate_kbps);
+			return -EINVAL;
+		}
+	} else {
+		ptr = 0;
 	}
 
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
@@ -365,10 +366,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	}
 
 	/* Final adjustments for HW */
-	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
+	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
-	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
+	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
 	value = qopt->hicredit * 1024ll * 8;
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b7616f161d6..b68682006c06 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1410,6 +1410,7 @@ static struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_KSZ8081, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8873MLL, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ886X, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9477, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ }
 };
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6a5f40f11db3..d08990437f3e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1952,8 +1952,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 
 	/* Handle remove event globally, it resets this state machine */
 	if (event == SFP_E_REMOVE) {
-		if (sfp->sm_mod_state > SFP_MOD_PROBE)
-			sfp_sm_mod_remove(sfp);
+		sfp_sm_mod_remove(sfp);
 		sfp_sm_mod_next(sfp, SFP_MOD_EMPTY, 0);
 		return;
 	}
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index da4a2427b005..29a04b059c11 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -346,7 +346,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 	}
 }
 
@@ -1638,6 +1639,7 @@ static int ax88179_link_reset(struct usbnet *dev)
 			 GMII_PHY_PHYSR, 2, &tmp16);
 
 	if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
+		netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 		return 0;
 	} else if (GMII_PHY_PHYSR_GIGA == (tmp16 & GMII_PHY_PHYSR_SMASK)) {
 		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
@@ -1675,6 +1677,8 @@ static int ax88179_link_reset(struct usbnet *dev)
 
 	netif_carrier_on(dev->net);
 
+	netdev_info(dev->net, "ax88179 - Link status is: 1\n");
+
 	return 0;
 }
 
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index bf8a60533f3e..d128b4ac7c9f 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -778,7 +778,8 @@ static int rtl8150_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *ecmd)
 {
 	rtl8150_t *dev = netdev_priv(netdev);
-	short lpa, bmcr;
+	short lpa = 0;
+	short bmcr = 0;
 	u32 supported;
 
 	supported = (SUPPORTED_10baseT_Half |
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4029c56dfcf0..f7ed99561c19 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3112,8 +3112,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
 		/* (!csum && gso) case will be fixed by register_netdev() */
 	}
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
-		dev->features |= NETIF_F_RXCSUM;
+
+	/* 1. With VIRTIO_NET_F_GUEST_CSUM negotiation, the driver doesn't
+	 * need to calculate checksums for partially checksummed packets,
+	 * as they're considered valid by the upper layer.
+	 * 2. Without VIRTIO_NET_F_GUEST_CSUM negotiation, the driver only
+	 * receives fully checksummed packets. The device may assist in
+	 * validating these packets' checksums, so the driver won't have to.
+	 */
+	dev->features |= NETIF_F_RXCSUM;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_GRO_HW;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3096769e718e..ec67d2eb05ec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1492,6 +1492,10 @@ static bool vxlan_snoop(struct net_device *dev,
 	struct vxlan_fdb *f;
 	u32 ifindex = 0;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(src_mac))
+		return true;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
 	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f02a308a9ffc..34654f710d8a 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -171,8 +171,10 @@ struct ath_common {
 	unsigned int clockrate;
 
 	spinlock_t cc_lock;
-	struct ath_cycle_counters cc_ani;
-	struct ath_cycle_counters cc_survey;
+	struct_group(cc,
+		struct ath_cycle_counters cc_ani;
+		struct ath_cycle_counters cc_survey;
+	);
 
 	struct ath_regulatory regulatory;
 	struct ath_regulatory reg_world_copy;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index b2cfc483515c..c5904d81d000 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -135,8 +135,7 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (power_mode != ATH9K_PM_AWAKE) {
 		spin_lock(&common->cc_lock);
 		ath_hw_cycle_counters_update(common);
-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+		memset(&common->cc, 0, sizeof(common->cc));
 		spin_unlock(&common->cc_lock);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ab84ac3f8f03..bf00c2fede74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1699,8 +1699,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_dbg_tlv_free(drv->trans);
 #endif
+	iwl_dbg_tlv_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54b28f0932e2..793208d99b5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -196,20 +196,10 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mfu_assert_dump_notif *mfu_dump_notif = (void *)pkt->data;
-	__le32 *dump_data = mfu_dump_notif->data;
-	int n_words = le32_to_cpu(mfu_dump_notif->data_size) / sizeof(__le32);
-	int i;
 
 	if (mfu_dump_notif->index_num == 0)
 		IWL_INFO(mvm, "MFUART assert id 0x%x occurred\n",
 			 le32_to_cpu(mfu_dump_notif->assert_id));
-
-	for (i = 0; i < n_words; i++)
-		IWL_DEBUG_INFO(mvm,
-			       "MFUART assert dump, dword %u: 0x%08x\n",
-			       le16_to_cpu(mfu_dump_notif->index_num) *
-			       n_words + i,
-			       le32_to_cpu(dump_data[i]));
 }
 
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 32104c9f8f5e..d59a47637d12 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -133,13 +133,8 @@ enum {
 
 #define LINK_QUAL_AGG_FRAME_LIMIT_DEF	(63)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MAX	(63)
-/*
- * FIXME - various places in firmware API still use u8,
- * e.g. LQ command and SCD config command.
- * This should be 256 instead.
- */
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(255)
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(255)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(64)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(64)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MIN	(0)
 
 #define LQ_SIZE		2	/* 2 mode tables:  "Active" and "Search" */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 17b992526694..a9df48c75155 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1354,7 +1354,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-		else if (params->ssids && params->ssids[0].ssid_len)
+		else if (params->n_ssids && params->ssids[0].ssid_len)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 		else
@@ -1456,7 +1456,7 @@ iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
 	if (IWL_MVM_ADWELL_MAX_BUDGET)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-	else if (params->ssids && params->ssids[0].ssid_len)
+	else if (params->n_ssids && params->ssids[0].ssid_len)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 	else
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index af0c7d74b3f5..ffe6d243c764 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
@@ -1359,7 +1359,7 @@ u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel_all); place++) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
 			if (channel_all[place] == chnl)
 				return place - 13;
 		}
@@ -2417,7 +2417,7 @@ static bool _rtl92d_is_legal_5g_channel(struct ieee80211_hw *hw, u8 channel)
 
 	int i;
 
-	for (i = 0; i < sizeof(channel5g); i++)
+	for (i = 0; i < ARRAY_SIZE(channel5g); i++)
 		if (channel == channel5g[i])
 			return true;
 	return false;
@@ -2681,9 +2681,8 @@ void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
 	u8 i;
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"settings regs %d default regs %d\n",
-		(int)(sizeof(rtlphy->iqk_matrix) /
-		      sizeof(struct iqk_matrix_regs)),
+		"settings regs %zu default regs %d\n",
+		ARRAY_SIZE(rtlphy->iqk_matrix),
 		IQK_MATRIX_REG_NUM);
 	/* 0xe94, 0xe9c, 0xea4, 0xeac, 0xeb4, 0xebc, 0xec4, 0xecc */
 	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
@@ -2850,16 +2849,14 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 	case BAND_ON_5G:
 		/* Get first channel error when change between
 		 * 5G and 2.4G band. */
-		if (channel <= 14)
+		if (WARN_ONCE(channel <= 14, "rtl8192de: 5G but channel<=14\n"))
 			return 0;
-		WARN_ONCE((channel <= 14), "rtl8192de: 5G but channel<=14\n");
 		break;
 	case BAND_ON_2_4G:
 		/* Get first channel error when change between
 		 * 5G and 2.4G band. */
-		if (channel > 14)
+		if (WARN_ONCE(channel > 14, "rtl8192de: 2G but channel>14\n"))
 			return 0;
-		WARN_ONCE((channel > 14), "rtl8192de: 2G but channel>14\n");
 		break;
 	default:
 		WARN_ONCE(true, "rtl8192de: Invalid WirelessMode(%#x)!!\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index a89e232d6963..c997d8bfda97 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -108,7 +108,6 @@
 #define	CHANNEL_GROUP_IDX_5GM		6
 #define	CHANNEL_GROUP_IDX_5GH		9
 #define	CHANNEL_GROUP_MAX_5G		9
-#define CHANNEL_MAX_NUMBER_2G		14
 #define AVG_THERMAL_NUM			8
 #define AVG_THERMAL_NUM_88E		4
 #define AVG_THERMAL_NUM_8723BE		4
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index dba8bdc3fc94..d1b72b704c31 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -131,10 +131,8 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 
 	/* All functions share the same vendor ID with function 0 */
 	if (fn == 0) {
-		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
-			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
-
-		rockchip_pcie_write(rockchip, vid_regs,
+		rockchip_pcie_write(rockchip,
+				    hdr->vendorid | hdr->subsys_vendor_id << 16,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1631109b142..530ced8f7abd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2840,6 +2840,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
+		 */
+		.ident = "Hewlett-Packard HP Pavilion 17 Notebook PC/1972",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BOARD_NAME, "1972"),
+			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
+		},
+	},
 #endif
 	{ }
 };
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ee99dc56c544..3d44d6f48cc4 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1092,8 +1092,8 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 		 * an -EPROBE_DEFER later, as that is the worst case.
 		 */
 		if (ret == -EPROBE_DEFER) {
-			pinctrl_free(p, false);
 			mutex_unlock(&pinctrl_maps_mutex);
+			pinctrl_free(p, false);
 			return ERR_PTR(ret);
 		}
 	}
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2a454098eaaa..02b41f1bafe7 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -35,6 +35,7 @@
 
 #include "core.h"
 #include "pinconf.h"
+#include "pinctrl-rockchip.h"
 
 /* GPIO control registers */
 #define GPIO_SWPORT_DR		0x00
@@ -50,21 +51,6 @@
 #define GPIO_EXT_PORT		0x50
 #define GPIO_LS_SYNC		0x60
 
-enum rockchip_pinctrl_type {
-	PX30,
-	RV1108,
-	RK2928,
-	RK3066B,
-	RK3128,
-	RK3188,
-	RK3288,
-	RK3308,
-	RK3368,
-	RK3399,
-	RK3568,
-};
-
-
 /**
  * Generate a bitmask for setting a value (v) with a write mask bit in hiword
  * register 31:16 area.
@@ -82,103 +68,6 @@ enum rockchip_pinctrl_type {
 #define IOMUX_WIDTH_3BIT	BIT(4)
 #define IOMUX_WIDTH_2BIT	BIT(5)
 
-/**
- * struct rockchip_iomux
- * @type: iomux variant using IOMUX_* constants
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following iomux registers.
- */
-struct rockchip_iomux {
-	int				type;
-	int				offset;
-};
-
-/*
- * enum type index corresponding to rockchip_perpin_drv_list arrays index.
- */
-enum rockchip_pin_drv_type {
-	DRV_TYPE_IO_DEFAULT = 0,
-	DRV_TYPE_IO_1V8_OR_3V0,
-	DRV_TYPE_IO_1V8_ONLY,
-	DRV_TYPE_IO_1V8_3V0_AUTO,
-	DRV_TYPE_IO_3V3_ONLY,
-	DRV_TYPE_MAX
-};
-
-/*
- * enum type index corresponding to rockchip_pull_list arrays index.
- */
-enum rockchip_pin_pull_type {
-	PULL_TYPE_IO_DEFAULT = 0,
-	PULL_TYPE_IO_1V8_ONLY,
-	PULL_TYPE_MAX
-};
-
-/**
- * struct rockchip_drv
- * @drv_type: drive strength variant using rockchip_perpin_drv_type
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following drive strength
- *	    registers. if used chips own cal_drv func instead to calculate
- *	    registers offset, the variant could be ignored.
- */
-struct rockchip_drv {
-	enum rockchip_pin_drv_type	drv_type;
-	int				offset;
-};
-
-/**
- * struct rockchip_pin_bank
- * @reg_base: register base of the gpio bank
- * @regmap_pull: optional separate register for additional pull settings
- * @clk: clock of the gpio bank
- * @irq: interrupt of the gpio bank
- * @saved_masks: Saved content of GPIO_INTEN at suspend time.
- * @pin_base: first pin number
- * @nr_pins: number of pins in this bank
- * @name: name of the bank
- * @bank_num: number of the bank, to account for holes
- * @iomux: array describing the 4 iomux sources of the bank
- * @drv: array describing the 4 drive strength sources of the bank
- * @pull_type: array describing the 4 pull type sources of the bank
- * @valid: is all necessary information present
- * @of_node: dt node of this bank
- * @drvdata: common pinctrl basedata
- * @domain: irqdomain of the gpio bank
- * @gpio_chip: gpiolib chip
- * @grange: gpio range
- * @slock: spinlock for the gpio bank
- * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
- * @recalced_mask: bit mask to indicate a need to recalulate the mask
- * @route_mask: bits describing the routing pins of per bank
- */
-struct rockchip_pin_bank {
-	void __iomem			*reg_base;
-	struct regmap			*regmap_pull;
-	struct clk			*clk;
-	int				irq;
-	u32				saved_masks;
-	u32				pin_base;
-	u8				nr_pins;
-	char				*name;
-	u8				bank_num;
-	struct rockchip_iomux		iomux[4];
-	struct rockchip_drv		drv[4];
-	enum rockchip_pin_pull_type	pull_type[4];
-	bool				valid;
-	struct device_node		*of_node;
-	struct rockchip_pinctrl		*drvdata;
-	struct irq_domain		*domain;
-	struct gpio_chip		gpio_chip;
-	struct pinctrl_gpio_range	grange;
-	raw_spinlock_t			slock;
-	u32				toggle_edge_mode;
-	u32				recalced_mask;
-	u32				route_mask;
-};
-
 #define PIN_BANK(id, pins, label)			\
 	{						\
 		.bank_num	= id,			\
@@ -318,119 +207,6 @@ struct rockchip_pin_bank {
 #define RK_MUXROUTE_PMU(ID, PIN, FUNC, REG, VAL)	\
 	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROCKCHIP_ROUTE_PMU)
 
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @num: bank number.
- * @pin: pin number.
- * @bit: index at register.
- * @reg: register offset.
- * @mask: mask bit
- */
-struct rockchip_mux_recalced_data {
-	u8 num;
-	u8 pin;
-	u32 reg;
-	u8 bit;
-	u8 mask;
-};
-
-enum rockchip_mux_route_location {
-	ROCKCHIP_ROUTE_SAME = 0,
-	ROCKCHIP_ROUTE_PMU,
-	ROCKCHIP_ROUTE_GRF,
-};
-
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @bank_num: bank number.
- * @pin: index at register or used to calc index.
- * @func: the min pin.
- * @route_location: the mux route location (same, pmu, grf).
- * @route_offset: the max pin.
- * @route_val: the register offset.
- */
-struct rockchip_mux_route_data {
-	u8 bank_num;
-	u8 pin;
-	u8 func;
-	enum rockchip_mux_route_location route_location;
-	u32 route_offset;
-	u32 route_val;
-};
-
-struct rockchip_pin_ctrl {
-	struct rockchip_pin_bank	*pin_banks;
-	u32				nr_banks;
-	u32				nr_pins;
-	char				*label;
-	enum rockchip_pinctrl_type	type;
-	int				grf_mux_offset;
-	int				pmu_mux_offset;
-	int				grf_drv_offset;
-	int				pmu_drv_offset;
-	struct rockchip_mux_recalced_data *iomux_recalced;
-	u32				niomux_recalced;
-	struct rockchip_mux_route_data *iomux_routes;
-	u32				niomux_routes;
-
-	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-};
-
-struct rockchip_pin_config {
-	unsigned int		func;
-	unsigned long		*configs;
-	unsigned int		nconfigs;
-};
-
-/**
- * struct rockchip_pin_group: represent group of pins of a pinmux function.
- * @name: name of the pin group, used to lookup the group.
- * @pins: the pins included in this group.
- * @npins: number of pins included in this group.
- * @data: local pin configuration
- */
-struct rockchip_pin_group {
-	const char			*name;
-	unsigned int			npins;
-	unsigned int			*pins;
-	struct rockchip_pin_config	*data;
-};
-
-/**
- * struct rockchip_pmx_func: represent a pin function.
- * @name: name of the pin function, used to lookup the function.
- * @groups: one or more names of pin groups that provide this function.
- * @ngroups: number of groups included in @groups.
- */
-struct rockchip_pmx_func {
-	const char		*name;
-	const char		**groups;
-	u8			ngroups;
-};
-
-struct rockchip_pinctrl {
-	struct regmap			*regmap_base;
-	int				reg_size;
-	struct regmap			*regmap_pull;
-	struct regmap			*regmap_pmu;
-	struct device			*dev;
-	struct rockchip_pin_ctrl	*ctrl;
-	struct pinctrl_desc		pctl;
-	struct pinctrl_dev		*pctl_dev;
-	struct rockchip_pin_group	*groups;
-	unsigned int			ngroups;
-	struct rockchip_pmx_func	*functions;
-	unsigned int			nfunctions;
-};
-
 static struct regmap_config rockchip_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -800,23 +576,68 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
 
 static struct rockchip_mux_recalced_data rk3328_mux_recalced_data[] = {
 	{
-		.num = 2,
-		.pin = 12,
-		.reg = 0x24,
-		.bit = 8,
-		.mask = 0x3
-	}, {
+		/* gpio2_b7_sel */
 		.num = 2,
 		.pin = 15,
 		.reg = 0x28,
 		.bit = 0,
 		.mask = 0x7
 	}, {
+		/* gpio2_c7_sel */
 		.num = 2,
 		.pin = 23,
 		.reg = 0x30,
 		.bit = 14,
 		.mask = 0x3
+	}, {
+		/* gpio3_b1_sel */
+		.num = 3,
+		.pin = 9,
+		.reg = 0x44,
+		.bit = 2,
+		.mask = 0x3
+	}, {
+		/* gpio3_b2_sel */
+		.num = 3,
+		.pin = 10,
+		.reg = 0x44,
+		.bit = 4,
+		.mask = 0x3
+	}, {
+		/* gpio3_b3_sel */
+		.num = 3,
+		.pin = 11,
+		.reg = 0x44,
+		.bit = 6,
+		.mask = 0x3
+	}, {
+		/* gpio3_b4_sel */
+		.num = 3,
+		.pin = 12,
+		.reg = 0x44,
+		.bit = 8,
+		.mask = 0x3
+	}, {
+		/* gpio3_b5_sel */
+		.num = 3,
+		.pin = 13,
+		.reg = 0x44,
+		.bit = 10,
+		.mask = 0x3
+	}, {
+		/* gpio3_b6_sel */
+		.num = 3,
+		.pin = 14,
+		.reg = 0x44,
+		.bit = 12,
+		.mask = 0x3
+	}, {
+		/* gpio3_b7_sel */
+		.num = 3,
+		.pin = 15,
+		.reg = 0x44,
+		.bit = 14,
+		.mask = 0x3
 	},
 };
 
@@ -2043,6 +1864,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -2097,6 +1919,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -2308,8 +2131,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 
 	if (ret) {
 		/* revert the already done pin settings */
-		for (cnt--; cnt >= 0; cnt--)
+		for (cnt--; cnt >= 0; cnt--) {
+			bank = pin_to_bank(info, pins[cnt]);
 			rockchip_set_mux(bank, pins[cnt] - bank->pin_base, 0);
+		}
 
 		return ret;
 	}
@@ -2418,6 +2243,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -3882,7 +3708,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     IOMUX_WIDTH_3BIT,
+			     0,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
@@ -3896,7 +3722,7 @@ static struct rockchip_pin_ctrl rk3328_pin_ctrl = {
 		.pin_banks		= rk3328_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk3328_pin_banks),
 		.label			= "RK3328-GPIO",
-		.type			= RK3288,
+		.type			= RK3328,
 		.grf_mux_offset		= 0x0,
 		.iomux_recalced		= rk3328_mux_recalced_data,
 		.niomux_recalced	= ARRAY_SIZE(rk3328_mux_recalced_data),
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
new file mode 100644
index 000000000000..7263db68d0ef
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021 Rockchip Electronics Co. Ltd.
+ *
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * With some ideas taken from pinctrl-samsung:
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2012 Linaro Ltd
+ *		https://www.linaro.org
+ *
+ * and pinctrl-at91:
+ * Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ */
+
+#ifndef _PINCTRL_ROCKCHIP_H
+#define _PINCTRL_ROCKCHIP_H
+
+enum rockchip_pinctrl_type {
+	PX30,
+	RV1108,
+	RK2928,
+	RK3066B,
+	RK3128,
+	RK3188,
+	RK3288,
+	RK3308,
+	RK3328,
+	RK3368,
+	RK3399,
+	RK3568,
+};
+
+/**
+ * struct rockchip_iomux
+ * @type: iomux variant using IOMUX_* constants
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following iomux registers.
+ */
+struct rockchip_iomux {
+	int type;
+	int offset;
+};
+
+/*
+ * enum type index corresponding to rockchip_perpin_drv_list arrays index.
+ */
+enum rockchip_pin_drv_type {
+	DRV_TYPE_IO_DEFAULT = 0,
+	DRV_TYPE_IO_1V8_OR_3V0,
+	DRV_TYPE_IO_1V8_ONLY,
+	DRV_TYPE_IO_1V8_3V0_AUTO,
+	DRV_TYPE_IO_3V3_ONLY,
+	DRV_TYPE_MAX
+};
+
+/*
+ * enum type index corresponding to rockchip_pull_list arrays index.
+ */
+enum rockchip_pin_pull_type {
+	PULL_TYPE_IO_DEFAULT = 0,
+	PULL_TYPE_IO_1V8_ONLY,
+	PULL_TYPE_MAX
+};
+
+/**
+ * struct rockchip_drv
+ * @drv_type: drive strength variant using rockchip_perpin_drv_type
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following drive strength
+ *	    registers. if used chips own cal_drv func instead to calculate
+ *	    registers offset, the variant could be ignored.
+ */
+struct rockchip_drv {
+	enum rockchip_pin_drv_type	drv_type;
+	int				offset;
+};
+
+/**
+ * struct rockchip_pin_bank
+ * @reg_base: register base of the gpio bank
+ * @regmap_pull: optional separate register for additional pull settings
+ * @clk: clock of the gpio bank
+ * @irq: interrupt of the gpio bank
+ * @saved_masks: Saved content of GPIO_INTEN at suspend time.
+ * @pin_base: first pin number
+ * @nr_pins: number of pins in this bank
+ * @name: name of the bank
+ * @bank_num: number of the bank, to account for holes
+ * @iomux: array describing the 4 iomux sources of the bank
+ * @drv: array describing the 4 drive strength sources of the bank
+ * @pull_type: array describing the 4 pull type sources of the bank
+ * @valid: is all necessary information present
+ * @of_node: dt node of this bank
+ * @drvdata: common pinctrl basedata
+ * @domain: irqdomain of the gpio bank
+ * @gpio_chip: gpiolib chip
+ * @grange: gpio range
+ * @slock: spinlock for the gpio bank
+ * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
+ * @recalced_mask: bit mask to indicate a need to recalulate the mask
+ * @route_mask: bits describing the routing pins of per bank
+ */
+struct rockchip_pin_bank {
+	void __iomem			*reg_base;
+	struct regmap			*regmap_pull;
+	struct clk			*clk;
+	int				irq;
+	u32				saved_masks;
+	u32				pin_base;
+	u8				nr_pins;
+	char				*name;
+	u8				bank_num;
+	struct rockchip_iomux		iomux[4];
+	struct rockchip_drv		drv[4];
+	enum rockchip_pin_pull_type	pull_type[4];
+	bool				valid;
+	struct device_node		*of_node;
+	struct rockchip_pinctrl		*drvdata;
+	struct irq_domain		*domain;
+	struct gpio_chip		gpio_chip;
+	struct pinctrl_gpio_range	grange;
+	raw_spinlock_t			slock;
+	u32				toggle_edge_mode;
+	u32				recalced_mask;
+	u32				route_mask;
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @num: bank number.
+ * @pin: pin number.
+ * @bit: index at register.
+ * @reg: register offset.
+ * @mask: mask bit
+ */
+struct rockchip_mux_recalced_data {
+	u8 num;
+	u8 pin;
+	u32 reg;
+	u8 bit;
+	u8 mask;
+};
+
+enum rockchip_mux_route_location {
+	ROCKCHIP_ROUTE_SAME = 0,
+	ROCKCHIP_ROUTE_PMU,
+	ROCKCHIP_ROUTE_GRF,
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @bank_num: bank number.
+ * @pin: index at register or used to calc index.
+ * @func: the min pin.
+ * @route_location: the mux route location (same, pmu, grf).
+ * @route_offset: the max pin.
+ * @route_val: the register offset.
+ */
+struct rockchip_mux_route_data {
+	u8 bank_num;
+	u8 pin;
+	u8 func;
+	enum rockchip_mux_route_location route_location;
+	u32 route_offset;
+	u32 route_val;
+};
+
+struct rockchip_pin_ctrl {
+	struct rockchip_pin_bank	*pin_banks;
+	u32				nr_banks;
+	u32				nr_pins;
+	char				*label;
+	enum rockchip_pinctrl_type	type;
+	int				grf_mux_offset;
+	int				pmu_mux_offset;
+	int				grf_drv_offset;
+	int				pmu_drv_offset;
+	struct rockchip_mux_recalced_data *iomux_recalced;
+	u32				niomux_recalced;
+	struct rockchip_mux_route_data *iomux_routes;
+	u32				niomux_routes;
+
+	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+};
+
+struct rockchip_pin_config {
+	unsigned int		func;
+	unsigned long		*configs;
+	unsigned int		nconfigs;
+};
+
+/**
+ * struct rockchip_pin_group: represent group of pins of a pinmux function.
+ * @name: name of the pin group, used to lookup the group.
+ * @pins: the pins included in this group.
+ * @npins: number of pins included in this group.
+ * @data: local pin configuration
+ */
+struct rockchip_pin_group {
+	const char			*name;
+	unsigned int			npins;
+	unsigned int			*pins;
+	struct rockchip_pin_config	*data;
+};
+
+/**
+ * struct rockchip_pmx_func: represent a pin function.
+ * @name: name of the pin function, used to lookup the function.
+ * @groups: one or more names of pin groups that provide this function.
+ * @ngroups: number of groups included in @groups.
+ */
+struct rockchip_pmx_func {
+	const char		*name;
+	const char		**groups;
+	u8			ngroups;
+};
+
+struct rockchip_pinctrl {
+	struct regmap			*regmap_base;
+	int				reg_size;
+	struct regmap			*regmap_pull;
+	struct regmap			*regmap_pmu;
+	struct device			*dev;
+	struct rockchip_pin_ctrl	*ctrl;
+	struct pinctrl_desc		pctl;
+	struct pinctrl_dev		*pctl_dev;
+	struct rockchip_pin_group	*groups;
+	unsigned int			ngroups;
+	struct rockchip_pmx_func	*functions;
+	unsigned int			nfunctions;
+};
+
+#endif
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 0a4f02e4ae7b..d7ee1eb9ca88 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -711,16 +712,22 @@ static int cros_usbpd_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
 			 cros_usbpd_charger_resume);
 
+static const struct platform_device_id cros_usbpd_charger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_charger_id);
+
 static struct platform_driver cros_usbpd_charger_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_usbpd_charger_pm_ops,
 	},
-	.probe = cros_usbpd_charger_probe
+	.probe = cros_usbpd_charger_probe,
+	.id_table = cros_usbpd_charger_id,
 };
 
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
-MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 9311f3d09c8f..8eb902fe73a9 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -84,7 +84,8 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	}
 
 	if (info->verify(info, pin, func, chan)) {
-		pr_err("driver cannot use function %u on pin %u\n", func, chan);
+		pr_err("driver cannot use function %u and channel %u on pin %u\n",
+		       func, chan, pin);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 69b7bc604946..3e5f1b622af8 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -340,6 +340,9 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 
 	prd = div;
 
+	if (!prd)
+		return -EINVAL;
+
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2d1a23b9eae3..7082cffdd10e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3185,6 +3185,7 @@ struct regmap *regulator_get_regmap(struct regulator *regulator)
 
 	return map ? map : ERR_PTR(-EOPNOTSUPP);
 }
+EXPORT_SYMBOL_GPL(regulator_get_regmap);
 
 /**
  * regulator_get_hardware_vsel_register - get the HW voltage selector register
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index f92a18c06d80..48b45fd94437 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -429,7 +429,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct mbox_client *client = &kproc->client;
 	struct device *dev = kproc->dev;
-	struct k3_r5_core *core;
+	struct k3_r5_core *core0, *core;
 	u32 boot_addr;
 	int ret;
 
@@ -478,6 +478,16 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 				goto unroll_core_run;
 		}
 	} else {
+		/* do not allow core 1 to start before core 0 */
+		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
+					 elem);
+		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not start core 1 before core 0\n",
+				__func__);
+			ret = -EPERM;
+			goto put_mbox;
+		}
+
 		ret = k3_r5_core_run(core);
 		if (ret)
 			goto put_mbox;
@@ -518,7 +528,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct device *dev = kproc->dev;
+	struct k3_r5_core *core1, *core = kproc->core;
 	int ret;
 
 	/* halt all applicable cores */
@@ -531,6 +542,16 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 			}
 		}
 	} else {
+		/* do not allow core 0 to stop before core 1 */
+		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
+					elem);
+		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not stop core 0 before core 1\n",
+				__func__);
+			ret = -EPERM;
+			goto out;
+		}
+
 		ret = k3_r5_core_halt(core);
 		if (ret)
 			goto out;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 105d781d0cac..2803b475dae6 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7440,6 +7440,12 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pd_handles_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pd_handles_sz++;
+	/*
+	 * pd_handles_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory touch may occur.
+	 */
+	ioc->pd_handles_sz = ALIGN(ioc->pd_handles_sz, sizeof(unsigned long));
+
 	ioc->pd_handles = kzalloc(ioc->pd_handles_sz,
 	    GFP_KERNEL);
 	if (!ioc->pd_handles) {
@@ -7457,6 +7463,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pend_os_device_add_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pend_os_device_add_sz++;
+
+	/*
+	 * pend_os_device_add_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory may occur.
+	 */
+	ioc->pend_os_device_add_sz = ALIGN(ioc->pend_os_device_add_sz,
+					   sizeof(unsigned long));
 	ioc->pend_os_device_add = kzalloc(ioc->pend_os_device_add_sz,
 	    GFP_KERNEL);
 	if (!ioc->pend_os_device_add) {
@@ -7747,6 +7760,12 @@ _base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER *ioc)
 		if (ioc->facts.MaxDevHandle % 8)
 			pd_handles_sz++;
 
+		/*
+		 * pd_handles should have, at least, the minimal room for
+		 * set_bit()/test_bit(), otherwise out-of-memory touch may
+		 * occur.
+		 */
+		pd_handles_sz = ALIGN(pd_handles_sz, sizeof(unsigned long));
 		pd_handles = krealloc(ioc->pd_handles, pd_handles_sz,
 		    GFP_KERNEL);
 		if (!pd_handles) {
diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index 42f5afb60055..6e724f47ab9e 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -120,15 +120,11 @@ static ssize_t
 qedi_dbg_do_not_recover_cmd_read(struct file *filp, char __user *buffer,
 				 size_t count, loff_t *ppos)
 {
-	size_t cnt = 0;
-
-	if (*ppos)
-		return 0;
+	char buf[64];
+	int len;
 
-	cnt = sprintf(buffer, "do_not_recover=%d\n", qedi_do_not_recover);
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	len = sprintf(buf, "do_not_recover=%d\n", qedi_do_not_recover);
+	return simple_read_from_buffer(buffer, count, ppos, buf, len);
 }
 
 static int
diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index a33ec7eaf23d..17984a7bffba 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -114,6 +114,18 @@ static const struct of_device_id ti_sci_pm_domain_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
 
+static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32 idx)
+{
+	struct ti_sci_pm_domain *pd;
+
+	list_for_each_entry(pd, &pd_provider->pd_list, node) {
+		if (pd->idx == idx)
+			return true;
+	}
+
+	return false;
+}
+
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -153,8 +165,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
-				if (args.args[0] > max_id)
+				if (args.args[0] > max_id) {
 					max_id = args.args[0];
+				} else {
+					if (ti_sci_pm_idx_exists(pd_provider, args.args[0])) {
+						index++;
+						continue;
+					}
+				}
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 				if (!pd)
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index ef3f95fefab5..6634709e646c 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -14,7 +14,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/suspend.h>
@@ -151,7 +150,6 @@ static irqreturn_t wkup_m3_txev_handler(int irq, void *ipc_data)
 static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 {
 	struct device *dev = m3_ipc->dev;
-	mbox_msg_t dummy_msg = 0;
 	int ret;
 
 	if (!m3_ipc->mbox) {
@@ -167,7 +165,7 @@ static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 	 * the RX callback to avoid multiple interrupts being received
 	 * by the CM3.
 	 */
-	ret = mbox_send_message(m3_ipc->mbox, &dummy_msg);
+	ret = mbox_send_message(m3_ipc->mbox, NULL);
 	if (ret < 0) {
 		dev_err(dev, "%s: mbox_send_message() failed: %d\n",
 			__func__, ret);
@@ -189,7 +187,6 @@ static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 static int wkup_m3_ping_noirq(struct wkup_m3_ipc *m3_ipc)
 {
 	struct device *dev = m3_ipc->dev;
-	mbox_msg_t dummy_msg = 0;
 	int ret;
 
 	if (!m3_ipc->mbox) {
@@ -198,7 +195,7 @@ static int wkup_m3_ping_noirq(struct wkup_m3_ipc *m3_ipc)
 		return -EIO;
 	}
 
-	ret = mbox_send_message(m3_ipc->mbox, &dummy_msg);
+	ret = mbox_send_message(m3_ipc->mbox, NULL);
 	if (ret < 0) {
 		dev_err(dev, "%s: mbox_send_message() failed: %d\n",
 			__func__, ret);
diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 29f226503668..eee3dcf96ee7 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 7c28d2752a4c..3d09f8f30e02 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -41,8 +41,50 @@
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
 
+#define PCI_VENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO        0x0340
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A      0x0341
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B      0x0342
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS           0x0350
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A         0x0351
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B         0x0352
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS           0x0353
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A        0x0354
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B        0x0355
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO      0x0360
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A    0x0361
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B    0x0362
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP             0x0370
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232         0x0371
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485         0x0372
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP           0x0373
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP           0x0374
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP           0x0375
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS      0x0376
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT   0x0380
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT  0x0381
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO        0x0382
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO    0x0392
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP        0x03A0
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232    0x03A1
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485    0x03A2
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS 0x03A3
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XEG001               0x0602
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_BASE           0x1000
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_2              0x1002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_4              0x1004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_8              0x1008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_12             0x100C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_16             0x1010
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X          0x110c
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X          0x110d
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16                 0x1110
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
+#define PCI_DEVICE_ID_EXAR_XR17V252		0x0252
+#define PCI_DEVICE_ID_EXAR_XR17V254		0x0254
+#define PCI_DEVICE_ID_EXAR_XR17V258		0x0258
 
 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 25765ebb756a..ff461d0a9acc 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -164,6 +164,10 @@ static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
 	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
+/* Timeout low and High */
+#define UART_OMAP_TO_L                 0x26
+#define UART_OMAP_TO_H                 0x27
+
 /*
  * Called on runtime PM resume path from omap8250_restore_regs(), and
  * omap8250_set_mctrl().
@@ -647,13 +651,25 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 	/*
 	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
-	 * FIFO has been drained, in which case a dummy read of RX FIFO
-	 * is required to clear RX TIMEOUT condition.
+	 * FIFO has been drained or erroneously.
+	 * So apply solution of Errata i2310 as mentioned in
+	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
 	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
 	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
-		serial_port_in(port, UART_RX);
+		unsigned char efr2, timeout_h, timeout_l;
+
+		efr2 = serial_in(up, UART_OMAP_EFR2);
+		timeout_h = serial_in(up, UART_OMAP_TO_H);
+		timeout_l = serial_in(up, UART_OMAP_TO_L);
+		serial_out(up, UART_OMAP_TO_H, 0xFF);
+		serial_out(up, UART_OMAP_TO_L, 0xFF);
+		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
+		serial_in(up, UART_IIR);
+		serial_out(up, UART_OMAP_EFR2, efr2);
+		serial_out(up, UART_OMAP_TO_H, timeout_h);
+		serial_out(up, UART_OMAP_TO_L, timeout_l);
 	}
 
 	/* Stop processing interrupts on input overrun */
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 33ca98bfa5b3..0780f5d7be62 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 09c88c48fb7b..b90bb745277d 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -479,7 +479,7 @@ static const struct uart_ops mcf_uart_ops = {
 	.verify_port	= mcf_verify_port,
 };
 
-static struct mcf_uart mcf_ports[4];
+static struct mcf_uart mcf_ports[10];
 
 #define	MCF_MAXPORTS	ARRAY_SIZE(mcf_ports)
 
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d751f8ce5cf6..4ea52426acf9 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -490,16 +490,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+/*
+ * Configure programmable baud rate generator (divisor) according to the
+ * desired baud rate.
+ *
+ * From the datasheet, the divisor is computed according to:
+ *
+ *              XTAL1 input frequency
+ *             -----------------------
+ *                    prescaler
+ * divisor = ---------------------------
+ *            baud-rate x sampling-rate
+ */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	u8 lcr;
-	u8 prescaler = 0;
+	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
-	if (div > 0xffff) {
-		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
-		div /= 4;
+	if (div >= BIT(16)) {
+		prescaler = 4;
+		div /= prescaler;
 	}
 
 	/* In an amazing feat of design, the Enhanced Features Register shares
@@ -534,9 +546,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 
 	mutex_unlock(&s->efr_lock);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -551,7 +564,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index e62a770a5d3b..1d2c736dbf6a 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1134,6 +1134,7 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
+	struct usb_endpoint_descriptor *in, *out;
 	int ret;
 
 	/* instance init */
@@ -1180,6 +1181,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 		goto fail;
 	}
 
+	if (usb_endpoint_xfer_int(&cmd_ep->desc))
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						NULL, NULL, &in, &out);
+	else
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						&in, &out, NULL, NULL);
+
+	if (ret) {
+		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	if ((cmd_ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 			== USB_ENDPOINT_XFER_INT) {
 		usb_fill_int_urb(instance->rcv_urb,
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 80332b6a1963..aa91d561a0ac 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -252,14 +252,14 @@ static void wdm_int_callback(struct urb *urb)
 			dev_err(&desc->intf->dev, "Stall on int endpoint\n");
 			goto sw; /* halt is cleared in work */
 		default:
-			dev_err(&desc->intf->dev,
+			dev_err_ratelimited(&desc->intf->dev,
 				"nonzero urb status received: %d\n", status);
 			break;
 		}
 	}
 
 	if (urb->actual_length < sizeof(struct usb_cdc_notification)) {
-		dev_err(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
+		dev_err_ratelimited(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
 			urb->actual_length);
 		goto exit;
 	}
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index ad7df99f09a4..592c79a04d64 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -827,6 +827,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	int ret = io_data->req->status ? io_data->req->status :
 					 io_data->req->actual;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
+	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
 		kthread_use_mm(io_data->mm);
@@ -839,7 +840,10 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
 
+	spin_lock_irqsave(&io_data->ffs->eps_lock, flags);
 	usb_ep_free_request(io_data->ep, io_data->req);
+	io_data->req = NULL;
+	spin_unlock_irqrestore(&io_data->ffs->eps_lock, flags);
 
 	if (io_data->read)
 		kfree(io_data->to_free);
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index c13bb29a160e..a31f2fe5d984 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -208,6 +208,7 @@ static inline struct usb_endpoint_descriptor *ep_desc(struct usb_gadget *gadget,
 					struct usb_endpoint_descriptor *ss)
 {
 	switch (gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		return ss;
 	case USB_SPEED_HIGH:
@@ -445,11 +446,8 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	mutex_lock(&dev->lock_printer_io);
 	spin_lock_irqsave(&dev->lock, flags);
 
-	if (dev->interface < 0) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		mutex_unlock(&dev->lock_printer_io);
-		return -ENODEV;
-	}
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	/* We will use this flag later to check if a printer reset happened
 	 * after we turn interrupts back on.
@@ -457,6 +455,9 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	dev->reset_printer = 0;
 
 	setup_rx_reqs(dev);
+	/* this dropped the lock - need to retest */
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	bytes_copied = 0;
 	current_rx_req = dev->current_rx_req;
@@ -490,6 +491,8 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		wait_event_interruptible(dev->rx_wait,
 				(likely(!list_empty(&dev->rx_buffers))));
 		spin_lock_irqsave(&dev->lock, flags);
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	/* We have data to return then copy it to the caller's buffer.*/
@@ -533,6 +536,9 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			return -EAGAIN;
 		}
 
+		if (dev->interface < 0)
+			goto out_disabled;
+
 		/* If we not returning all the data left in this RX request
 		 * buffer then adjust the amount of data left in the buffer.
 		 * Othewise if we are done with this RX request buffer then
@@ -562,6 +568,11 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		return bytes_copied;
 	else
 		return -EAGAIN;
+
+out_disabled:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	mutex_unlock(&dev->lock_printer_io);
+	return -ENODEV;
 }
 
 static ssize_t
@@ -582,11 +593,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	mutex_lock(&dev->lock_printer_io);
 	spin_lock_irqsave(&dev->lock, flags);
 
-	if (dev->interface < 0) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		mutex_unlock(&dev->lock_printer_io);
-		return -ENODEV;
-	}
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	/* Check if a printer reset happens while we have interrupts on */
 	dev->reset_printer = 0;
@@ -609,6 +617,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		wait_event_interruptible(dev->tx_wait,
 				(likely(!list_empty(&dev->tx_reqs))));
 		spin_lock_irqsave(&dev->lock, flags);
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	while (likely(!list_empty(&dev->tx_reqs)) && len) {
@@ -658,6 +668,9 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			return -EAGAIN;
 		}
 
+		if (dev->interface < 0)
+			goto out_disabled;
+
 		list_add(&req->list, &dev->tx_reqs_active);
 
 		/* here, we unlock, and only unlock, to avoid deadlock. */
@@ -671,6 +684,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			mutex_unlock(&dev->lock_printer_io);
 			return -EAGAIN;
 		}
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -682,6 +697,11 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		return bytes_copied;
 	else
 		return -EAGAIN;
+
+out_disabled:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	mutex_unlock(&dev->lock_printer_io);
+	return -ENODEV;
 }
 
 static int
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 53f832787350..88f223b975d3 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -35,6 +35,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -270,6 +271,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
+	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
+			pdev->device == PCI_DEVICE_ID_EJ188) {
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4fa387e447f0..fbb7a5b51ef4 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2386,9 +2386,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		ep_trb_len	= 0;
-		remaining	= 0;
-		break;
+		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
 		    (ep->err_count++ > MAX_SOFT_RETRY) ||
diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 0be8efcda15d..d972c0962939 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -677,7 +677,7 @@ static int uss720_probe(struct usb_interface *intf,
 	struct parport_uss720_private *priv;
 	struct parport *pp;
 	unsigned char reg;
-	int i;
+	int ret;
 
 	dev_dbg(&intf->dev, "probe: vendor id 0x%x, device id 0x%x\n",
 		le16_to_cpu(usbdev->descriptor.idVendor),
@@ -688,8 +688,8 @@ static int uss720_probe(struct usb_interface *intf,
 		usb_put_dev(usbdev);
 		return -ENODEV;
 	}
-	i = usb_set_interface(usbdev, intf->altsetting->desc.bInterfaceNumber, 2);
-	dev_dbg(&intf->dev, "set interface result %d\n", i);
+	ret = usb_set_interface(usbdev, intf->altsetting->desc.bInterfaceNumber, 2);
+	dev_dbg(&intf->dev, "set interface result %d\n", ret);
 
 	interface = intf->cur_altsetting;
 
@@ -725,12 +725,18 @@ static int uss720_probe(struct usb_interface *intf,
 	set_1284_register(pp, 7, 0x00, GFP_KERNEL);
 	set_1284_register(pp, 6, 0x30, GFP_KERNEL);  /* PS/2 mode */
 	set_1284_register(pp, 2, 0x0c, GFP_KERNEL);
-	/* debugging */
-	get_1284_register(pp, 0, &reg, GFP_KERNEL);
+
+	/* The Belkin F5U002 Rev 2 P80453-B USB parallel port adapter shares the
+	 * device ID 050d:0002 with some other device that works with this
+	 * driver, but it itself does not. Detect and handle the bad cable
+	 * here. */
+	ret = get_1284_register(pp, 0, &reg, GFP_KERNEL);
 	dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
+	if (ret < 0)
+		return ret;
 
-	i = usb_find_last_int_in_endpoint(interface, &epd);
-	if (!i) {
+	ret = usb_find_last_int_in_endpoint(interface, &epd);
+	if (!ret) {
 		dev_dbg(&intf->dev, "epaddr %d interval %d\n",
 				epd->bEndpointAddress, epd->bInterval);
 	}
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 1c023c0091c4..ad336daa9344 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -556,7 +556,7 @@ static int da8xx_probe(struct platform_device *pdev)
 	ret = of_platform_populate(pdev->dev.of_node, NULL,
 				   da8xx_auxdata_lookup, &pdev->dev);
 	if (ret)
-		return ret;
+		goto err_unregister_phy;
 
 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
 			ARRAY_SIZE(musb_resources));
@@ -582,9 +582,13 @@ static int da8xx_probe(struct platform_device *pdev)
 	ret = PTR_ERR_OR_ZERO(glue->musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		usb_phy_generic_unregister(glue->usb_phy);
+		goto err_unregister_phy;
 	}
 
+	return 0;
+
+err_unregister_phy:
+	usb_phy_generic_unregister(glue->usb_phy);
 	return ret;
 }
 
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index dcc4778d1ae9..17fe35083f04 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -105,6 +105,8 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
+
+	bool media_initialized;
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08) {
+	if (status[0] & 0x08 || !info->media_initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
-		alauda_init_media(us);
-
+		rc = alauda_init_media(us);
+		if (rc == USB_STOR_TRANSPORT_GOOD)
+			info->media_initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 019f0925fa73..c484c145c5d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4442,19 +4442,11 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				      struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
 	int ret = 0;
 
-	delayed_refs = &trans->delayed_refs;
-
 	spin_lock(&delayed_refs->lock);
-	if (atomic_read(&delayed_refs->num_entries) == 0) {
-		spin_unlock(&delayed_refs->lock);
-		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
-	}
-
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index d659eb70df76..adb324234b44 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -154,6 +154,7 @@ smb2_find_smb_ses_unlocked(struct TCP_Server_Info *server, __u64 ses_id)
 	list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
 		if (ses->Suid != ses_id)
 			continue;
+		++ses->ses_count;
 		return ses;
 	}
 
@@ -205,7 +206,14 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __u64 ses_id, __u32  tid)
 		return NULL;
 	}
 	tcon = smb2_find_smb_sess_tcon_unlocked(ses, tid);
+	if (!tcon) {
+		spin_unlock(&cifs_tcp_ses_lock);
+		cifs_put_smb_ses(ses);
+		return NULL;
+	}
 	spin_unlock(&cifs_tcp_ses_lock);
+	/* tcon already has a ref to ses, so we don't need ses anymore */
+	cifs_put_smb_ses(ses);
 
 	return tcon;
 }
@@ -239,7 +247,7 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		if (rc) {
 			cifs_server_dbg(VFS,
 					"%s: sha256 alloc failed\n", __func__);
-			return rc;
+			goto out;
 		}
 		shash = &sdesc->shash;
 	} else {
@@ -290,6 +298,8 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 out:
 	if (allocate_crypto)
 		cifs_free_hash(&hash, &sdesc);
+	if (ses)
+		cifs_put_smb_ses(ses);
 	return rc;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1281b59da6a2..9fed42e7bb1d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1745,8 +1745,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index db41e7803163..7ae54f78a5b0 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -557,9 +557,11 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
+		int size = min_t(int, EALIST_SIZE(ea_buf->xattr), ea_size);
+
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, ea_size, 1);
+				     ea_buf->xattr, size, 1);
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb854f1f86e2..75334ba10947 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -103,12 +103,8 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
 		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		struct address_space *mapping = page_file_mapping(page);
-
 		if (PageUptodate(page))
 			nfs_readpage_to_fscache(inode, page, 0);
-		else if (!PageError(page) && !PagePrivate(page))
-			generic_error_remove_page(mapping, page);
 		unlock_page(page);
 	}
 	nfs_release_request(req);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 228560f3fd0e..8e84ddccce4b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2888,12 +2888,9 @@ static void
 nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	spin_lock(&nn->client_lock);
 	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
-	put_client_renew_locked(clp);
-	spin_unlock(&nn->client_lock);
+	drop_client(clp);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
@@ -6230,7 +6227,7 @@ deleg_reaper(struct nfsd_net *nn)
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
-		atomic_inc(&clp->cl_rpc_users);
+		kref_get(&clp->cl_nfsdfs.cl_ref);
 		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
 	}
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index db8d62632a5b..ae3323e0708d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -573,7 +573,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 		_fh_update(fhp, exp, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
 		fh_put(fhp);
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	}
 
 	return 0;
@@ -599,7 +599,7 @@ fh_update(struct svc_fh *fhp)
 
 	_fh_update(fhp, fhp->fh_export, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	return 0;
 out_bad:
 	printk(KERN_ERR "fh_update: fh not verified!\n");
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index eb7de9e2a384..552234ef22fe 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -186,19 +186,24 @@ static bool nilfs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *nilfs_get_page(struct inode *dir, unsigned long n)
+static void *nilfs_get_page(struct inode *dir, unsigned long n,
+		struct page **pagep)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
+	void *kaddr;
 
-	if (!IS_ERR(page)) {
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (PageError(page) || !nilfs_check_page(page))
-				goto fail;
-		}
+	if (IS_ERR(page))
+		return page;
+
+	kaddr = kmap(page);
+	if (unlikely(!PageChecked(page))) {
+		if (!nilfs_check_page(page))
+			goto fail;
 	}
-	return page;
+
+	*pagep = page;
+	return kaddr;
 
 fail:
 	nilfs_put_page(page);
@@ -275,14 +280,14 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct nilfs_dir_entry *de;
-		struct page *page = nilfs_get_page(inode, n);
+		struct page *page;
 
-		if (IS_ERR(page)) {
+		kaddr = nilfs_get_page(inode, n, &page);
+		if (IS_ERR(kaddr)) {
 			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
-		kaddr = page_address(page);
 		de = (struct nilfs_dir_entry *)(kaddr + offset);
 		limit = kaddr + nilfs_last_byte(inode, n) -
 			NILFS_DIR_REC_LEN(1);
@@ -345,11 +350,9 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
+		char *kaddr = nilfs_get_page(dir, n, &page);
 
-		page = nilfs_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
+		if (!IS_ERR(kaddr)) {
 			de = (struct nilfs_dir_entry *)kaddr;
 			kaddr += nilfs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
@@ -387,15 +390,11 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = nilfs_get_page(dir, 0);
-	struct nilfs_dir_entry *de = NULL;
+	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = nilfs_next_entry(
-			(struct nilfs_dir_entry *)page_address(page));
-		*p = page;
-	}
-	return de;
+	if (IS_ERR(de))
+		return NULL;
+	return nilfs_next_entry(de);
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
@@ -459,12 +458,11 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *dir_end;
 
-		page = nilfs_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
+		kaddr = nilfs_get_page(dir, n, &page);
+		err = PTR_ERR(kaddr);
+		if (IS_ERR(kaddr))
 			goto out;
 		lock_page(page);
-		kaddr = page_address(page);
 		dir_end = kaddr + nilfs_last_byte(dir, n);
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -627,11 +625,10 @@ int nilfs_empty_dir(struct inode *inode)
 		char *kaddr;
 		struct nilfs_dir_entry *de;
 
-		page = nilfs_get_page(inode, i);
-		if (IS_ERR(page))
-			continue;
+		kaddr = nilfs_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
+			return 0;
 
-		kaddr = page_address(page);
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += nilfs_last_byte(inode, i) - NILFS_DIR_REC_LEN(1);
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2eeae67ad298..02407c524382 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1697,6 +1697,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1710,6 +1711,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1726,6 +1728,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_page) {
 		lock_page(bd_page);
+		wait_on_page_writeback(bd_page);
 		clear_page_dirty_for_io(bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 9b23e74036eb..1a5f23e79f5e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2373,6 +2373,11 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 	}
 
 	list_for_each_entry(ue, &dwc->dw_zero_list, ue_node) {
+		ret = ocfs2_assure_trans_credits(handle, credits);
+		if (ret < 0) {
+			mlog_errno(ret);
+			break;
+		}
 		ret = ocfs2_mark_extent_written(inode, &et, handle,
 						ue->ue_cpos, 1,
 						ue->ue_phys,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index df36d84aedc4..5fd565a6228f 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1940,6 +1940,8 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 
 	inode_lock(inode);
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
 	/*
 	 * This prevents concurrent writes on other nodes
 	 */
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 0534800a472a..dfa6ff2756fb 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -449,6 +449,23 @@ int ocfs2_extend_trans(handle_t *handle, int nblocks)
 	return status;
 }
 
+/*
+ * Make sure handle has at least 'nblocks' credits available. If it does not
+ * have that many credits available, we will try to extend the handle to have
+ * enough credits. If that fails, we will restart transaction to have enough
+ * credits. Similar notes regarding data consistency and locking implications
+ * as for ocfs2_extend_trans() apply here.
+ */
+int ocfs2_assure_trans_credits(handle_t *handle, int nblocks)
+{
+	int old_nblks = jbd2_handle_buffer_credits(handle);
+
+	trace_ocfs2_assure_trans_credits(old_nblks);
+	if (old_nblks >= nblocks)
+		return 0;
+	return ocfs2_extend_trans(handle, nblocks - old_nblks);
+}
+
 /*
  * If we have fewer than thresh credits, extend by OCFS2_MAX_TRANS_DATA.
  * If that fails, restart the transaction & regain write access for the
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index eb7a21bac71e..bc5d77cb3c50 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -244,6 +244,8 @@ handle_t		    *ocfs2_start_trans(struct ocfs2_super *osb,
 int			     ocfs2_commit_trans(struct ocfs2_super *osb,
 						handle_t *handle);
 int			     ocfs2_extend_trans(handle_t *handle, int nblocks);
+int			     ocfs2_assure_trans_credits(handle_t *handle,
+						int nblocks);
 int			     ocfs2_allocate_extend_trans(handle_t *handle,
 						int thresh);
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 5c98813b3dca..7bdda635ca80 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -566,7 +566,7 @@ static int __ocfs2_mknod_locked(struct inode *dir,
 	fe->i_last_eb_blk = 0;
 	strcpy(fe->i_signature, OCFS2_INODE_SIGNATURE);
 	fe->i_flags |= cpu_to_le32(OCFS2_VALID_FL);
-	ktime_get_real_ts64(&ts);
+	ktime_get_coarse_real_ts64(&ts);
 	fe->i_atime = fe->i_ctime = fe->i_mtime =
 		cpu_to_le64(ts.tv_sec);
 	fe->i_mtime_nsec = fe->i_ctime_nsec = fe->i_atime_nsec =
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index dc4bce1649c1..7a9cfd61145a 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -2578,6 +2578,8 @@ DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_commit_cache_end);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_extend_trans);
 
+DEFINE_OCFS2_INT_EVENT(ocfs2_assure_trans_credits);
+
 DEFINE_OCFS2_INT_EVENT(ocfs2_extend_trans_restart);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_allocate_extend_trans);
diff --git a/fs/open.c b/fs/open.c
index d69312a2d434..694110929519 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -200,13 +200,13 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	return error;
 }
 
-SYSCALL_DEFINE2(ftruncate, unsigned int, fd, unsigned long, length)
+SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_ulong_t, length)
+COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 0e4278d4a769..0833676da5f4 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -373,6 +373,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		/* leave now if filled buffer already */
 		if (buflen == 0)
 			return acc;
+
+		cond_resched();
 	}
 
 	list_for_each_entry(m, &vmcore_list, list) {
diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index fce4ad976c8c..26169b1f482c 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -60,13 +60,18 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
 	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
 			src.second);
 	dest->tv_sec -= offset * 60;
-	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
-			src.hundredsOfMicroseconds * 100 + src.microseconds);
+
 	/*
 	 * Sanitize nanosecond field since reportedly some filesystems are
 	 * recorded with bogus sub-second values.
 	 */
-	dest->tv_nsec %= NSEC_PER_SEC;
+	if (src.centiseconds < 100 && src.hundredsOfMicroseconds < 100 &&
+	    src.microseconds < 100) {
+		dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
+			src.hundredsOfMicroseconds * 100 + src.microseconds);
+	} else {
+		dest->tv_nsec = 0;
+	}
 }
 
 void
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index a8d8fdcd3723..92348c085c0c 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -402,6 +402,6 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int irq,
 				 struct kvm_kernel_irq_routing_entry *irq_entry);
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_VGIC_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 14d514233e1d..8dffffe846ce 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -527,7 +527,7 @@ asmlinkage long compat_sys_fstatfs(unsigned int fd,
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
 asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
-asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+asmlinkage long compat_sys_ftruncate(unsigned int, compat_off_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
 asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
 				  int flags, umode_t mode);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 084990390420..2fd321da5c4b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -633,18 +633,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
+extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(struct efi_memory_map_data *data);
-extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
-					 struct range *range);
-extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-				     void *buf, struct efi_mem_range *mem);
 
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e90c267e7f3e..2698dd231298 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1026,7 +1026,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index b48128b717f1..84535b168762 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -21,6 +21,8 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_PC = 2,
 	/* Collecting comparison operands mode. */
 	KCOV_MODE_TRACE_CMP = 3,
+	/* The process owns a KCOV remote reference. */
+	KCOV_MODE_REMOTE = 4,
 };
 
 #define KCOV_IN_CTXSW	(1 << 30)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b08a473cdba..18be4459aaf7 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -669,6 +669,8 @@ struct x86_cpu_id {
 	__u16 model;
 	__u16 steppings;
 	__u16 feature;	/* bit index */
+	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
+	__u16 flags;
 	kernel_ulong_t driver_data;
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f454dd100334..ddf9ae37a2cc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -71,8 +71,8 @@ enum {
 	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
+/* RDMA Provider Type codes for Discovery Log Page entry TSAS
+ * RDMA_PRTYPE field
  */
 enum {
 	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b24a6fbfa0b..30bc462fb196 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -148,6 +148,15 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
+/*
+ * Reading from a device that doesn't respond typically returns ~0.  A
+ * successful read from a device may also return ~0, so you need additional
+ * information to reliably identify errors.
+ */
+#define PCI_ERROR_RESPONSE		(~0ULL)
+#define PCI_SET_ERROR_RESPONSE(val)	(*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
+#define PCI_POSSIBLE_ERROR(val)		((val) == ((typeof(val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1cf7a7799cc0..00303c636a89 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -498,6 +498,7 @@ void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
+const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
@@ -535,16 +536,27 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
 }
 
 /**
- * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
+ * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
  * @rqstp: controlling server RPC transaction context
  *
+ * This function currently assumes the RPC header in rq_arg has
+ * already been decoded. Upon return, xdr->p points to the
+ * location of the upper layer header.
  */
 static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
-	struct kvec *argv = rqstp->rq_arg.head;
+	struct xdr_buf *buf = &rqstp->rq_arg;
+	struct kvec *argv = buf->head;
 
-	xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
+	/*
+	 * svc_getnl() and friends do not keep the xdr_buf's ::len
+	 * field up to date. Refresh that field before initializing
+	 * the argument decoding stream.
+	 */
+	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
+
+	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
 }
 
@@ -567,7 +579,7 @@ static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
 	xdr->end = resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
 	buf->len = resv->iov_len;
 	xdr->page_ptr = buf->pages - 1;
-	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
+	buf->buflen = PAGE_SIZE * (rqstp->rq_page_end - buf->pages);
 	buf->buflen -= rqstp->rq_auth_slack;
 	xdr->rqst = NULL;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1ea422b1a9f1..a96e924c7b45 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -445,7 +445,7 @@ asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 				struct statfs64 __user *buf);
 asmlinkage long sys_truncate(const char __user *path, long length);
-asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
+asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
 asmlinkage long sys_truncate64(const char __user *path, loff_t length);
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 33873266b2bc..9128c0db11f8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1625,18 +1625,46 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 {
 	u16 max_latency;
 
-	if (min > max || min < 6 || max > 3200)
+	if (min > max) {
+		BT_WARN("min %d > max %d", min, max);
 		return -EINVAL;
+	}
+
+	if (min < 6) {
+		BT_WARN("min %d < 6", min);
+		return -EINVAL;
+	}
+
+	if (max > 3200) {
+		BT_WARN("max %d > 3200", max);
+		return -EINVAL;
+	}
+
+	if (to_multiplier < 10) {
+		BT_WARN("to_multiplier %d < 10", to_multiplier);
+		return -EINVAL;
+	}
 
-	if (to_multiplier < 10 || to_multiplier > 3200)
+	if (to_multiplier > 3200) {
+		BT_WARN("to_multiplier %d > 3200", to_multiplier);
 		return -EINVAL;
+	}
 
-	if (max >= to_multiplier * 8)
+	if (max >= to_multiplier * 8) {
+		BT_WARN("max %d >= to_multiplier %d * 8", max, to_multiplier);
 		return -EINVAL;
+	}
 
 	max_latency = (to_multiplier * 4 / max) - 1;
-	if (latency > 499 || latency > max_latency)
+	if (latency > 499) {
+		BT_WARN("latency %d > 499", latency);
 		return -EINVAL;
+	}
+
+	if (latency > max_latency) {
+		BT_WARN("latency %d > max_latency %d", latency, max_latency);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index ab8d84775ca8..2b99ee1303d9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -490,6 +490,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline enum nft_data_types nft_set_datatype(const struct nft_set *set)
+{
+	return set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE;
+}
+
 static inline bool nft_set_gc_is_pending(const struct nft_set *s)
 {
 	return refcount_read(&s->refs) != 1;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 9dab2bc6f187..9e6c10b323b8 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -218,6 +218,9 @@ bool xdp_rxq_info_is_reg(struct xdp_rxq_info *xdp_rxq);
 int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 			       enum xdp_mem_type type, void *allocator);
 void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq);
+int xdp_reg_mem_model(struct xdp_mem_info *mem,
+		      enum xdp_mem_type type, void *allocator);
+void xdp_unreg_mem_model(struct xdp_mem_info *mem);
 
 /* Drivers not supporting XDP metadata can use this helper, which
  * rejects any room expansion for metadata as a result.
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index a50df41634c5..980cb7a74e35 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -78,14 +78,14 @@ TRACE_EVENT(qdisc_destroy,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
 		__string(	kind,		q->ops->id		)
 		__field(	u32,		parent			)
 		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
+		__assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "(null)");
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 56e4a57d2538..5d34deca0f30 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1578,7 +1578,7 @@ TRACE_EVENT(svc_process,
 		__field(u32, vers)
 		__field(u32, proc)
 		__string(service, name)
-		__string(procedure, rqst->rq_procinfo->pc_name)
+		__string(procedure, svc_proc_name(rqst))
 		__string(addr, rqst->rq_xprt ?
 			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
@@ -1588,7 +1588,7 @@ TRACE_EVENT(svc_process,
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
 		__assign_str(service, name);
-		__assign_str(procedure, rqst->rq_procinfo->pc_name);
+		__assign_str(procedure, svc_proc_name(rqst));
 		__assign_str(addr, rqst->rq_xprt ?
 			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
@@ -1854,7 +1854,7 @@ TRACE_EVENT(svc_stats_latency,
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(unsigned long, execute)
-		__string(procedure, rqst->rq_procinfo->pc_name)
+		__string(procedure, svc_proc_name(rqst))
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
@@ -1862,7 +1862,7 @@ TRACE_EVENT(svc_stats_latency,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
 							 rqst->rq_stime));
-		__assign_str(procedure, rqst->rq_procinfo->pc_name);
+		__assign_str(procedure, svc_proc_name(rqst));
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index 4f3d5aaa11f5..de687009bfe5 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,18 +20,18 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..1ff9589ab611 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -805,7 +805,7 @@ __SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SC_COMP(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0b47bed8675..3a191bec69ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5128,6 +5128,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5168,11 +5169,23 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 04880d8fba25..42de79cd1a67 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -19,7 +19,9 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"
 
-#if (__GNUC__ >= 10)
+#if (__GNUC__ >= 14)
+#define GCOV_COUNTERS			9
+#elif (__GNUC__ >= 10)
 #define GCOV_COUNTERS			8
 #elif (__GNUC__ >= 7)
 #define GCOV_COUNTERS			9
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index c1510f0ab3ea..206ab3d41ee7 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -83,12 +83,9 @@ find $cpio_dir -type f -print0 |
 	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
 
 # Create archive and try to normalize metadata for reproducibility.
-# For compatibility with older versions of tar, files are fed to tar
-# pre-sorted, as --sort=name might not be available.
-find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
-    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=0 --group=0 --numeric-owner --no-recursion \
-    -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
+tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
+    -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
 echo $headers_md5 > kernel/kheaders.md5
 echo "$this_file_md5" >> kernel/kheaders.md5
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6b8368be89c8..ec2fd698ebf5 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -635,6 +635,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			return -EINVAL;
 		kcov->mode = mode;
 		t->kcov = kcov;
+	        t->kcov_mode = KCOV_MODE_REMOTE;
 		kcov->t = t;
 		kcov->remote = true;
 		kcov->remote_size = remote_arg->area_size;
diff --git a/kernel/padata.c b/kernel/padata.c
index fdcd78302cd7..471ccbc44541 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -111,7 +111,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 {
 	int i;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	/* Start at 1 because the current task participates in the job. */
 	for (i = 1; i < nworks; ++i) {
 		struct padata_work *pw = padata_work_alloc();
@@ -121,7 +121,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 		padata_work_init(pw, padata_mt_helper, data, 0);
 		list_add(&pw->pw_list, head);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 
 	return i;
 }
@@ -139,12 +139,12 @@ static void __init padata_works_free(struct list_head *works)
 	if (list_empty(works))
 		return;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	list_for_each_entry_safe(cur, next, works, pw_list) {
 		list_del(&cur->pw_list);
 		padata_work_free(cur);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 }
 
 static void padata_parallel_worker(struct work_struct *parallel_work)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 20243682e605..e032b1ce7964 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -221,6 +221,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 */
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
+		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6c1aea48a79a..9f505688291e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1407,7 +1407,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
@@ -2209,11 +2210,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 }
 
 /* IPI handler to get callback posted on desired CPU, if online. */
-static void rcu_torture_barrier1cb(void *rcu_void)
+static int rcu_torture_barrier1cb(void *rcu_void)
 {
 	struct rcu_head *rhp = rcu_void;
 
 	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+	return 0;
 }
 
 /* kthread function to register callbacks used to test RCU barriers. */
@@ -2239,11 +2241,9 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
-					     &rcu, 1)) {
-			// IPI failed, so use direct call from current CPU.
+		if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
 			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		}
+
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index cdecd47e5580..9019299069b1 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -46,8 +46,8 @@ COND_SYSCALL(io_getevents_time32);
 COND_SYSCALL(io_getevents);
 COND_SYSCALL(io_pgetevents_time32);
 COND_SYSCALL(io_pgetevents);
-COND_SYSCALL_COMPAT(io_pgetevents_time32);
 COND_SYSCALL_COMPAT(io_pgetevents);
+COND_SYSCALL_COMPAT(io_pgetevents_time64);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e883d12dcb0d..b13b3e3f6c9f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -177,26 +177,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -220,19 +200,25 @@ static void tick_setup_device(struct tick_device *td,
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
-			 * The boot CPU may be nohz_full, in which case set
-			 * tick_do_timer_boot_cpu so the first housekeeping
-			 * secondary that comes up will take do_timer from
-			 * us.
+			 * The boot CPU may be nohz_full, in which case the
+			 * first housekeeping secondary will take do_timer()
+			 * from it.
 			 */
 			if (tick_nohz_full_cpu(cpu))
 				tick_do_timer_boot_cpu = cpu;
 
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
+		} else if (tick_do_timer_boot_cpu != -1 && !tick_nohz_full_cpu(cpu)) {
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			/*
+			 * The boot CPU will stay in periodic (NOHZ disabled)
+			 * mode until clocksource_done_booting() called after
+			 * smp_init() selects a high resolution clocksource and
+			 * timekeeping_notify() kicks the NOHZ stuff alive.
+			 *
+			 * So this WRITE_ONCE can only race with the READ_ONCE
+			 * check in tick_periodic() but this race is harmless.
+			 */
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 #endif
 		}
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 29db703f6880..467975300ddd 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -824,7 +824,7 @@ config PREEMPTIRQ_DELAY_TEST
 
 config SYNTH_EVENT_GEN_TEST
 	tristate "Test module for in-kernel synthetic event generation"
-	depends on SYNTH_EVENTS
+	depends on SYNTH_EVENTS && m
 	help
           This option creates a test module to check the base
           functionality of in-kernel synthetic event definition and
@@ -837,7 +837,7 @@ config SYNTH_EVENT_GEN_TEST
 
 config KPROBE_EVENT_GEN_TEST
 	tristate "Test module for in-kernel kprobe event generation"
-	depends on KPROBE_EVENTS
+	depends on KPROBE_EVENTS && m
 	help
           This option creates a test module to check the base
           functionality of in-kernel kprobe event definition.
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 312d1a0ca3b6..1a4f2f424996 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -201,4 +201,5 @@ static void __exit preemptirq_delay_exit(void)
 
 module_init(preemptirq_delay_init)
 module_exit(preemptirq_delay_exit)
+MODULE_DESCRIPTION("Preempt / IRQ disable delay thread to test latency tracers");
 MODULE_LICENSE("GPL v2");
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2d38a09459bb..cbebe3aa1f60 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
+#include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -132,6 +133,29 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 	return vlan;
 }
 
+/**
+ * batadv_vlan_id_valid() - check if vlan id is in valid batman-adv encoding
+ * @vid: the VLAN identifier
+ *
+ * Return: true when either no vlan is set or if VLAN is in correct range,
+ *  false otherwise
+ */
+static bool batadv_vlan_id_valid(unsigned short vid)
+{
+	unsigned short non_vlan = vid & ~(BATADV_VLAN_HAS_TAG | VLAN_VID_MASK);
+
+	if (vid == 0)
+		return true;
+
+	if (!(vid & BATADV_VLAN_HAS_TAG))
+		return false;
+
+	if (non_vlan)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_orig_node_vlan_new() - search and possibly create an orig_node_vlan
  *  object
@@ -150,6 +174,9 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 {
 	struct batadv_orig_node_vlan *vlan;
 
+	if (!batadv_vlan_id_valid(vid))
+		return NULL;
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 
 	/* first look if an object for this vid already exists */
@@ -1285,6 +1312,8 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		if (hlist_empty(head))
+			continue;
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da03ca6dd922..9cc034e6074c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5612,13 +5612,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9169ef174ff0..d102efcae65a 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 /* CAN_HDR: #bytes before can_frame data part */
 #define J1939_CAN_HDR (offsetof(struct can_frame, data))
 
-/* CAN_FTR: #bytes beyond data part */
-#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
-		 sizeof(((struct can_frame *)0)->data))
-
 /* lowest layer */
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
@@ -338,7 +334,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	memset(cf, 0, J1939_CAN_HDR);
 
 	/* make it a full can frame again */
-	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+	skb_put_zero(skb, 8 - dlc);
 
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5dcbb0b7d123..478dafc73857 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1577,8 +1577,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
+	int len, ret;
 	pgn_t pgn;
-	int len;
 
 	netdev_dbg(priv->ndev, "%s\n", __func__);
 
@@ -1634,7 +1634,22 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.rx = 0;
 	session->pkt.tx = 0;
 
-	WARN_ON_ONCE(j1939_session_activate(session));
+	ret = j1939_session_activate(session);
+	if (ret) {
+		/* Entering this scope indicates an issue with the J1939 bus.
+		 * Possible scenarios include:
+		 * - A time lapse occurred, and a new session was initiated
+		 *   due to another packet being sent correctly. This could
+		 *   have been caused by too long interrupt, debugger, or being
+		 *   out-scheduled by another task.
+		 * - The bus is receiving numerous erroneous packets, either
+		 *   from a malfunctioning device or during a test scenario.
+		 */
+		netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
+			     __func__, session, skcb.addr.sa, skcb.addr.da);
+		j1939_session_put(session);
+		return NULL;
+	}
 
 	return session;
 }
@@ -1662,6 +1677,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		if (session->transmission)
+			j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 7742ee689141..009b9e22c4e7 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -73,7 +73,7 @@ struct net_dm_hw_entries {
 };
 
 struct per_cpu_dm_data {
-	spinlock_t		lock;	/* Protects 'skb', 'hw_entries' and
+	raw_spinlock_t		lock;	/* Protects 'skb', 'hw_entries' and
 					 * 'send_timer'
 					 */
 	union {
@@ -168,9 +168,9 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 err:
 	mod_timer(&data->send_timer, jiffies + HZ / 10);
 out:
-	spin_lock_irqsave(&data->lock, flags);
+	raw_spin_lock_irqsave(&data->lock, flags);
 	swap(data->skb, skb);
-	spin_unlock_irqrestore(&data->lock, flags);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
 
 	if (skb) {
 		struct nlmsghdr *nlh = (struct nlmsghdr *)skb->data;
@@ -225,7 +225,7 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 
 	local_irq_save(flags);
 	data = this_cpu_ptr(&dm_cpu_data);
-	spin_lock(&data->lock);
+	raw_spin_lock(&data->lock);
 	dskb = data->skb;
 
 	if (!dskb)
@@ -259,7 +259,7 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 	}
 
 out:
-	spin_unlock_irqrestore(&data->lock, flags);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb, void *location)
@@ -318,9 +318,9 @@ net_dm_hw_reset_per_cpu_data(struct per_cpu_dm_data *hw_data)
 		mod_timer(&hw_data->send_timer, jiffies + HZ / 10);
 	}
 
-	spin_lock_irqsave(&hw_data->lock, flags);
+	raw_spin_lock_irqsave(&hw_data->lock, flags);
 	swap(hw_data->hw_entries, hw_entries);
-	spin_unlock_irqrestore(&hw_data->lock, flags);
+	raw_spin_unlock_irqrestore(&hw_data->lock, flags);
 
 	return hw_entries;
 }
@@ -452,7 +452,7 @@ net_dm_hw_trap_summary_probe(void *ignore, const struct devlink *devlink,
 		return;
 
 	hw_data = this_cpu_ptr(&dm_hw_cpu_data);
-	spin_lock_irqsave(&hw_data->lock, flags);
+	raw_spin_lock_irqsave(&hw_data->lock, flags);
 	hw_entries = hw_data->hw_entries;
 
 	if (!hw_entries)
@@ -481,7 +481,7 @@ net_dm_hw_trap_summary_probe(void *ignore, const struct devlink *devlink,
 	}
 
 out:
-	spin_unlock_irqrestore(&hw_data->lock, flags);
+	raw_spin_unlock_irqrestore(&hw_data->lock, flags);
 }
 
 static const struct net_dm_alert_ops net_dm_alert_summary_ops = {
@@ -1669,7 +1669,7 @@ static struct notifier_block dropmon_net_notifier = {
 
 static void __net_dm_cpu_data_init(struct per_cpu_dm_data *data)
 {
-	spin_lock_init(&data->lock);
+	raw_spin_lock_init(&data->lock);
 	skb_queue_head_init(&data->drop_queue);
 	u64_stats_init(&data->stats.syncp);
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 49e4d1535cc8..a3101cdfd47b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -78,6 +78,9 @@
 #include <linux/btf_ids.h>
 #include <net/tls.h>
 
+/* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
+static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
+
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 72cfe5248b76..6192a05ebcce 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -670,11 +670,16 @@ EXPORT_SYMBOL_GPL(__put_net);
  * get_net_ns - increment the refcount of the network namespace
  * @ns: common namespace (net)
  *
- * Returns the net's common namespace.
+ * Returns the net's common namespace or ERR_PTR() if ref is zero.
  */
 struct ns_common *get_net_ns(struct ns_common *ns)
 {
-	return &get_net(container_of(ns, struct net, ns))->ns;
+	struct net *net;
+
+	net = maybe_get_net(container_of(ns, struct net, ns));
+	if (net)
+		return &net->ns;
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(get_net_ns);
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2ad22511b9c6..f76afab9fd8b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -316,7 +316,7 @@ static int netpoll_owner_active(struct net_device *dev)
 	struct napi_struct *napi;
 
 	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
-		if (napi->poll_owner == smp_processor_id())
+		if (READ_ONCE(napi->poll_owner) == smp_processor_id())
 			return 1;
 	}
 	return 0;
diff --git a/net/core/sock.c b/net/core/sock.c
index b4ecd0071e22..d5818a5a86fd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3263,7 +3263,8 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->getsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
 
@@ -3290,7 +3291,8 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->setsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index b8d7fa47d293..fd98d6059007 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -110,26 +110,37 @@ static void mem_allocator_disconnect(void *allocator)
 	mutex_unlock(&mem_id_lock);
 }
 
-void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq)
+void xdp_unreg_mem_model(struct xdp_mem_info *mem)
 {
 	struct xdp_mem_allocator *xa;
-	int id = xdp_rxq->mem.id;
+	int type = mem->type;
+	int id = mem->id;
 
-	if (xdp_rxq->reg_state != REG_STATE_REGISTERED) {
-		WARN(1, "Missing register, driver bug");
-		return;
-	}
+	/* Reset mem info to defaults */
+	mem->id = 0;
+	mem->type = 0;
 
 	if (id == 0)
 		return;
 
-	if (xdp_rxq->mem.type == MEM_TYPE_PAGE_POOL) {
+	if (type == MEM_TYPE_PAGE_POOL) {
 		rcu_read_lock();
 		xa = rhashtable_lookup(mem_id_ht, &id, mem_id_rht_params);
 		page_pool_destroy(xa->page_pool);
 		rcu_read_unlock();
 	}
 }
+EXPORT_SYMBOL_GPL(xdp_unreg_mem_model);
+
+void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq)
+{
+	if (xdp_rxq->reg_state != REG_STATE_REGISTERED) {
+		WARN(1, "Missing register, driver bug");
+		return;
+	}
+
+	xdp_unreg_mem_model(&xdp_rxq->mem);
+}
 EXPORT_SYMBOL_GPL(xdp_rxq_info_unreg_mem_model);
 
 void xdp_rxq_info_unreg(struct xdp_rxq_info *xdp_rxq)
@@ -144,10 +155,6 @@ void xdp_rxq_info_unreg(struct xdp_rxq_info *xdp_rxq)
 
 	xdp_rxq->reg_state = REG_STATE_UNREGISTERED;
 	xdp_rxq->dev = NULL;
-
-	/* Reset mem info to defaults */
-	xdp_rxq->mem.id = 0;
-	xdp_rxq->mem.type = 0;
 }
 EXPORT_SYMBOL_GPL(xdp_rxq_info_unreg);
 
@@ -259,28 +266,24 @@ static bool __is_supported_mem_type(enum xdp_mem_type type)
 	return true;
 }
 
-int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
-			       enum xdp_mem_type type, void *allocator)
+static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
+						     enum xdp_mem_type type,
+						     void *allocator)
 {
 	struct xdp_mem_allocator *xdp_alloc;
 	gfp_t gfp = GFP_KERNEL;
 	int id, errno, ret;
 	void *ptr;
 
-	if (xdp_rxq->reg_state != REG_STATE_REGISTERED) {
-		WARN(1, "Missing register, driver bug");
-		return -EFAULT;
-	}
-
 	if (!__is_supported_mem_type(type))
-		return -EOPNOTSUPP;
+		return ERR_PTR(-EOPNOTSUPP);
 
-	xdp_rxq->mem.type = type;
+	mem->type = type;
 
 	if (!allocator) {
 		if (type == MEM_TYPE_PAGE_POOL)
-			return -EINVAL; /* Setup time check page_pool req */
-		return 0;
+			return ERR_PTR(-EINVAL); /* Setup time check page_pool req */
+		return NULL;
 	}
 
 	/* Delay init of rhashtable to save memory if feature isn't used */
@@ -288,15 +291,13 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		mutex_lock(&mem_id_lock);
 		ret = __mem_id_init_hash_table();
 		mutex_unlock(&mem_id_lock);
-		if (ret < 0) {
-			WARN_ON(1);
-			return ret;
-		}
+		if (ret < 0)
+			return ERR_PTR(ret);
 	}
 
 	xdp_alloc = kzalloc(sizeof(*xdp_alloc), gfp);
 	if (!xdp_alloc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&mem_id_lock);
 	id = __mem_id_cyclic_get(gfp);
@@ -304,15 +305,15 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		errno = id;
 		goto err;
 	}
-	xdp_rxq->mem.id = id;
-	xdp_alloc->mem  = xdp_rxq->mem;
+	mem->id = id;
+	xdp_alloc->mem = *mem;
 	xdp_alloc->allocator = allocator;
 
 	/* Insert allocator into ID lookup table */
 	ptr = rhashtable_insert_slow(mem_id_ht, &id, &xdp_alloc->node);
 	if (IS_ERR(ptr)) {
-		ida_simple_remove(&mem_id_pool, xdp_rxq->mem.id);
-		xdp_rxq->mem.id = 0;
+		ida_simple_remove(&mem_id_pool, mem->id);
+		mem->id = 0;
 		errno = PTR_ERR(ptr);
 		goto err;
 	}
@@ -322,13 +323,44 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 
 	mutex_unlock(&mem_id_lock);
 
-	trace_mem_connect(xdp_alloc, xdp_rxq);
-	return 0;
+	return xdp_alloc;
 err:
 	mutex_unlock(&mem_id_lock);
 	kfree(xdp_alloc);
-	return errno;
+	return ERR_PTR(errno);
 }
+
+int xdp_reg_mem_model(struct xdp_mem_info *mem,
+		      enum xdp_mem_type type, void *allocator)
+{
+	struct xdp_mem_allocator *xdp_alloc;
+
+	xdp_alloc = __xdp_reg_mem_model(mem, type, allocator);
+	if (IS_ERR(xdp_alloc))
+		return PTR_ERR(xdp_alloc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xdp_reg_mem_model);
+
+int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
+			       enum xdp_mem_type type, void *allocator)
+{
+	struct xdp_mem_allocator *xdp_alloc;
+
+	if (xdp_rxq->reg_state != REG_STATE_REGISTERED) {
+		WARN(1, "Missing register, driver bug");
+		return -EFAULT;
+	}
+
+	xdp_alloc = __xdp_reg_mem_model(&xdp_rxq->mem, type, allocator);
+	if (IS_ERR(xdp_alloc))
+		return PTR_ERR(xdp_alloc);
+
+	if (trace_mem_connect_enabled() && xdp_alloc)
+		trace_mem_connect(xdp_alloc, xdp_rxq);
+	return 0;
+}
+
 EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
 
 /* XDP RX runs under NAPI protection, and in different delivery error
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5f1b334e64b3..475a19db3713 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -562,22 +562,27 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 	int err;
 
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
+
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+
 	if (uaddr->sa_family == AF_UNSPEC)
-		return sk->sk_prot->disconnect(sk, flags);
+		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-		err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+		err = prot->pre_connect(sk, uaddr, addr_len);
 		if (err)
 			return err;
 	}
 
 	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
 		return -EAGAIN;
-	return sk->sk_prot->connect(sk, uaddr, addr_len);
+	return prot->connect(sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -740,10 +745,11 @@ EXPORT_SYMBOL(inet_stream_connect);
 int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 		bool kern)
 {
-	struct sock *sk1 = sock->sk;
+	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
-	struct sock *sk2 = sk1->sk_prot->accept(sk1, flags, &err, kern);
 
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		goto do_err;
 
@@ -828,12 +834,15 @@ ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
 		      size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	if (sk->sk_prot->sendpage)
-		return sk->sk_prot->sendpage(sk, page, offset, size, flags);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+	if (prot->sendpage)
+		return prot->sendpage(sk, page, offset, size, flags);
 	return sock_no_sendpage(sock, page, offset, size, flags);
 }
 EXPORT_SYMBOL(inet_sendpage);
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index d4a4160159a9..c5da958e3bbd 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2016,12 +2016,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		 * from there we can determine the new total option length */
 		iter = 0;
 		optlen_new = 0;
-		while (iter < opt->opt.optlen)
-			if (opt->opt.__data[iter] != IPOPT_NOP) {
+		while (iter < opt->opt.optlen) {
+			if (opt->opt.__data[iter] == IPOPT_END) {
+				break;
+			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
+				iter++;
+			} else {
 				iter += opt->opt.__data[iter + 1];
 				optlen_new = iter;
-			} else
-				iter++;
+			}
+		}
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4ed0d303791a..24ebd51c5e0b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2420,6 +2420,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2431,7 +2435,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		fallthrough;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
@@ -3497,8 +3501,9 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (level != SOL_TCP)
-		return icsk->icsk_af_ops->setsockopt(sk, level, optname,
-						     optval, optlen);
+		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
+		return READ_ONCE(icsk->icsk_af_ops)->setsockopt(sk, level, optname,
+								optval, optlen);
 	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(tcp_setsockopt);
@@ -4059,8 +4064,9 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (level != SOL_TCP)
-		return icsk->icsk_af_ops->getsockopt(sk, level, optname,
-						     optval, optlen);
+		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
+		return READ_ONCE(icsk->icsk_af_ops)->getsockopt(sk, level, optname,
+								optval, optlen);
 	return do_tcp_getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(tcp_getsockopt);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 329b3b36688a..32da2b66fa2f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -449,11 +449,14 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 	int err = 0;
 
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
-	if (sk->sk_prot->bind)
-		return sk->sk_prot->bind(sk, uaddr, addr_len);
+	if (prot->bind)
+		return prot->bind(sk, uaddr, addr_len);
 
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
@@ -566,6 +569,7 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
+	const struct proto *prot;
 
 	switch (cmd) {
 	case SIOCADDRT:
@@ -583,9 +587,11 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		if (!sk->sk_prot->ioctl)
+		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+		prot = READ_ONCE(sk->sk_prot);
+		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
-		return sk->sk_prot->ioctl(sk, cmd, arg);
+		return prot->ioctl(sk, cmd, arg);
 	}
 	/*NOTREACHED*/
 	return 0;
@@ -647,11 +653,14 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_sendmsg(struct sock *, struct msghdr *,
 int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	return INDIRECT_CALL_2(sk->sk_prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
 }
 
@@ -661,13 +670,16 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		  int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 	int addr_len = 0;
 	int err;
 
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	err = INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags & MSG_DONTWAIT,
 			      flags & ~MSG_DONTWAIT, &addr_len);
 	if (err >= 0)
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index b79e571e5a86..83f15e930b57 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -959,6 +959,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 	if (!fib6_nh->rt6i_pcpu)
 		return;
 
+	rcu_read_lock();
 	/* release the reference to this fib entry from
 	 * all of its cached pcpu routes
 	 */
@@ -967,7 +968,9 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 		struct rt6_info *pcpu_rt;
 
 		ppcpu_rt = per_cpu_ptr(fib6_nh->rt6i_pcpu, cpu);
-		pcpu_rt = *ppcpu_rt;
+
+		/* Paired with xchg() in rt6_get_pcpu_route() */
+		pcpu_rt = READ_ONCE(*ppcpu_rt);
 
 		/* only dropping the 'from' reference if the cached route
 		 * is using 'match'. The cached pcpu_rt->from only changes
@@ -981,6 +984,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 			fib6_info_release(from);
 		}
 	}
+	rcu_read_unlock();
 }
 
 struct fib6_nh_pcpu_arg {
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 0ac527cd5d56..dbbe53260b00 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -475,8 +475,10 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, &tcp_prot, 1);
 				local_bh_enable();
-				sk->sk_prot = &tcp_prot;
-				icsk->icsk_af_ops = &ipv4_specific;
+				/* Paired with READ_ONCE(sk->sk_prot) in inet6_stream_ops */
+				WRITE_ONCE(sk->sk_prot, &tcp_prot);
+				/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+				WRITE_ONCE(icsk->icsk_af_ops, &ipv4_specific);
 				sk->sk_socket->ops = &inet_stream_ops;
 				sk->sk_family = PF_INET;
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
@@ -489,7 +491,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, prot, 1);
 				local_bh_enable();
-				sk->sk_prot = prot;
+				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
+				WRITE_ONCE(sk->sk_prot, prot);
 				sk->sk_socket->ops = &inet_dgram_ops;
 				sk->sk_family = PF_INET;
 			}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 88f96241ca97..799779475c7d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -632,6 +632,8 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 	rcu_read_lock_bh();
 	last_probe = READ_ONCE(fib6_nh->last_probe);
 	idev = __in6_dev_get(dev);
+	if (!idev)
+		goto out;
 	neigh = __ipv6_neigh_lookup_noref(dev, nh_gw);
 	if (neigh) {
 		if (neigh->nud_state & NUD_VALID)
@@ -1396,6 +1398,7 @@ static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 		struct rt6_info *prev, **p;
 
 		p = this_cpu_ptr(res->nh->rt6i_pcpu);
+		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
 		prev = xchg(p, NULL);
 		if (prev) {
 			dst_dev_put(&prev->dst);
@@ -3487,7 +3490,7 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	if (!dev)
 		goto out;
 
-	if (idev->cnf.disable_ipv6) {
+	if (!idev || idev->cnf.disable_ipv6) {
 		NL_SET_ERR_MSG(extack, "IPv6 is disabled on nexthop device");
 		err = -EACCES;
 		goto out;
@@ -6180,12 +6183,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 	if (!write)
 		return -EINVAL;
 
-	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	if (ret)
 		return ret;
 
+	net = (struct net *)ctl->extra1;
+	delay = net->ipv6.sysctl.flush_delay;
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 40ac23242c37..a73840da34ed 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -325,9 +325,8 @@ static int seg6_input(struct sk_buff *skb)
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
 
 	skb_dst_drop(skb);
 
@@ -335,14 +334,13 @@ static int seg6_input(struct sk_buff *skb)
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
@@ -364,9 +362,9 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -386,9 +384,9 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 79d6f6ea3c54..7e595585d059 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -237,7 +237,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		sin.sin_port = usin->sin6_port;
 		sin.sin_addr.s_addr = usin->sin6_addr.s6_addr32[3];
 
-		icsk->icsk_af_ops = &ipv6_mapped;
+		/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+		WRITE_ONCE(icsk->icsk_af_ops, &ipv6_mapped);
 		if (sk_is_mptcp(sk))
 			mptcpv6_handle_mapped(sk, true);
 		sk->sk_backlog_rcv = tcp_v4_do_rcv;
@@ -249,7 +250,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
-			icsk->icsk_af_ops = &ipv6_specific;
+			/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+			WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
 			if (sk_is_mptcp(sk))
 				mptcpv6_handle_mapped(sk, false);
 			sk->sk_backlog_rcv = tcp_v6_do_rcv;
@@ -1311,7 +1313,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	 */
 
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL, NULL);
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
@@ -1322,6 +1323,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
+	ip6_dst_store(newsk, dst, NULL, NULL);
+
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
 	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 4c3aa97f23fa..7c903e0e446c 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -57,12 +57,18 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
+	struct inet6_dev *idev;
 
 	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
-	dev = ip6_dst_idev(dst)->dev;
+	idev = ip6_dst_idev(dst);
+	if (!idev) {
+		dst_release(dst);
+		return -EHOSTUNREACH;
+	}
+	dev = idev->dev;
 	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
 	dst_release(dst);
 	return 0;
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index ed0dbdbba4d9..06770b77e5d2 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -517,7 +517,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -625,23 +625,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret = 0;
 
 	if (!iucv_path_table)
 		return 0;
 
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret = -EINVAL;
+		goto __free_cpumask;
+	}
 
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
 
 /**
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index cc26f239838b..41413a4588db 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -127,15 +127,21 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 	if (!he_spr_ie_elem)
 		return;
+
+	he_obss_pd->sr_ctrl = he_spr_ie_elem->he_sr_control;
 	data = he_spr_ie_elem->optional;
 
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
-		data++;
+		he_obss_pd->non_srg_max_offset = *data++;
+
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
-		he_obss_pd->max_offset = *data++;
 		he_obss_pd->min_offset = *data++;
+		he_obss_pd->max_offset = *data++;
+		memcpy(he_obss_pd->bss_color_bitmap, data, 8);
+		data += 8;
+		memcpy(he_obss_pd->partial_bssid_bitmap, data, 8);
 		he_obss_pd->enable = true;
 	}
 }
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index d936ef0c17a3..72ecce377d17 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -723,10 +723,23 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
  */
 void mesh_path_flush_pending(struct mesh_path *mpath)
 {
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct mesh_preq_queue *preq, *tmp;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&mpath->frame_queue)) != NULL)
 		mesh_path_discard_frame(mpath->sdata, skb);
+
+	spin_lock_bh(&ifmsh->mesh_preq_queue_lock);
+	list_for_each_entry_safe(preq, tmp, &ifmsh->preq_queue.list, list) {
+		if (ether_addr_equal(mpath->dst, preq->dst)) {
+			list_del(&preq->list);
+			kfree(preq);
+			--ifmsh->preq_queue_len;
+		}
+	}
+	spin_unlock_bh(&ifmsh->mesh_preq_queue_lock);
 }
 
 /**
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 44bd03c6b847..f7637176d719 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1343,7 +1343,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	skb_queue_head_init(&pending);
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
-	spin_lock(&sta->ps_lock);
+	spin_lock_bh(&sta->ps_lock);
 	/* Send all buffered frames to the station */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		int count = skb_queue_len(&pending), tmp;
@@ -1372,7 +1372,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	 */
 	clear_sta_flag(sta, WLAN_STA_PSPOLL);
 	clear_sta_flag(sta, WLAN_STA_UAPSD);
-	spin_unlock(&sta->ps_lock);
+	spin_unlock_bh(&sta->ps_lock);
 
 	atomic_dec(&ps->num_sta_ps);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0d6f3d912891..452c7e21befd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -371,15 +371,12 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
+	int err;
 
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
 		 msk->pm.remote.family);
-	msk->pm.add_addr_accepted++;
 	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
-	    msk->pm.subflows >= msk->pm.subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
 
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
@@ -391,9 +388,16 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	local.family = remote.family;
 
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	err = __mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 
+	if (!err) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
+		    msk->pm.subflows >= msk->pm.subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
+
 	mptcp_pm_announce_addr(msk, &remote, true);
 }
 
@@ -427,10 +431,10 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 		msk->pm.subflows--;
 		WRITE_ONCE(msk->pm.accept_addr, true);
 
-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
-
 		break;
 	}
+
+	__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 }
 
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 36fa456f42ba..a36493bbf895 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2646,6 +2646,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		mptcp_subflow_early_fallback(msk, subflow);
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	atomic64_set(&msk->snd_una, msk->write_seq);
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
diff --git a/net/ncsi/Kconfig b/net/ncsi/Kconfig
index 93309081f5a4..ea1dd32b6b1f 100644
--- a/net/ncsi/Kconfig
+++ b/net/ncsi/Kconfig
@@ -17,3 +17,9 @@ config NCSI_OEM_CMD_GET_MAC
 	help
 	  This allows to get MAC address from NCSI firmware and set them back to
 		controller.
+config NCSI_OEM_CMD_KEEP_PHY
+	bool "Keep PHY Link up"
+	depends on NET_NCSI
+	help
+	  This allows to keep PHY link up and prevents any channel resets during
+	  the host load.
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ec765f2a7569..dea60e25e860 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -78,6 +78,9 @@ enum {
 /* OEM Vendor Manufacture ID */
 #define NCSI_OEM_MFR_MLX_ID             0x8119
 #define NCSI_OEM_MFR_BCM_ID             0x113d
+#define NCSI_OEM_MFR_INTEL_ID           0x157
+/* Intel specific OEM command */
+#define NCSI_OEM_INTEL_CMD_KEEP_PHY     0x20   /* CMD ID for Keep PHY up */
 /* Broadcom specific OEM Command */
 #define NCSI_OEM_BCM_CMD_GMA            0x01   /* CMD ID for Get MAC */
 /* Mellanox specific OEM Command */
@@ -86,6 +89,7 @@ enum {
 #define NCSI_OEM_MLX_CMD_SMAF           0x01   /* CMD ID for Set MC Affinity */
 #define NCSI_OEM_MLX_CMD_SMAF_PARAM     0x07   /* Parameter for SMAF         */
 /* OEM Command payload lengths*/
+#define NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN 7
 #define NCSI_OEM_BCM_CMD_GMA_LEN        12
 #define NCSI_OEM_MLX_CMD_GMA_LEN        8
 #define NCSI_OEM_MLX_CMD_SMAF_LEN        60
@@ -274,6 +278,7 @@ enum {
 	ncsi_dev_state_probe_mlx_gma,
 	ncsi_dev_state_probe_mlx_smaf,
 	ncsi_dev_state_probe_cis,
+	ncsi_dev_state_probe_keep_phy,
 	ncsi_dev_state_probe_gvi,
 	ncsi_dev_state_probe_gc,
 	ncsi_dev_state_probe_gls,
@@ -317,6 +322,7 @@ struct ncsi_dev_priv {
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
+	unsigned int        channel_probe_id;/* Current cahnnel ID during probe */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
 	struct ncsi_request requests[256];   /* Request table              */
@@ -335,6 +341,7 @@ struct ncsi_dev_priv {
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
+	unsigned char       channel_count;     /* Num of channels to probe   */
 };
 
 struct ncsi_cmd_arg {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index ffff8da707b8..bb3248214746 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -510,17 +510,19 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 
 		break;
 	case ncsi_dev_state_suspend_gls:
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_GLS;
 		nca.package = np->id;
+		nca.channel = ndp->channel_probe_id;
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+		ndp->channel_probe_id++;
 
-		nd->state = ncsi_dev_state_suspend_dcnt;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
+			nd->state = ncsi_dev_state_suspend_dcnt;
 		}
 
 		break;
@@ -689,7 +691,30 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
+static int ncsi_oem_keep_phy_intel(struct ncsi_cmd_arg *nca)
+{
+	unsigned char data[NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN];
+	int ret = 0;
+
+	nca->payload = NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN;
+
+	memset(data, 0, NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN);
+	*(unsigned int *)data = ntohl((__force __be32)NCSI_OEM_MFR_INTEL_ID);
+
+	data[4] = NCSI_OEM_INTEL_CMD_KEEP_PHY;
+
+	/* PHY Link up attribute */
+	data[6] = 0x1;
+
+	nca->data = data;
+
+	ret = ncsi_xmit_cmd(nca);
+	if (ret)
+		netdev_err(nca->ndp->ndev.dev,
+			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
+			   nca->type);
+	return ret;
+}
 
 /* NCSI OEM Command APIs */
 static int ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
@@ -804,8 +829,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
 	return nch->handler(nca);
 }
 
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 /* Determine if a given channel from the channel_queue should be used for Tx */
 static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
 			       struct ncsi_channel *nc)
@@ -987,20 +1010,18 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			goto error;
 		}
 
-		nd->state = ncsi_dev_state_config_oem_gma;
+		nd->state = IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
+			  ? ncsi_dev_state_config_oem_gma
+			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
 		nd->state = ncsi_dev_state_config_clear_vids;
-		ret = -1;
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
 		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 		if (ret < 0)
 			schedule_work(&ndp->work);
 
@@ -1298,7 +1319,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
 	struct ncsi_package *np;
-	struct ncsi_channel *nc;
 	struct ncsi_cmd_arg nca;
 	unsigned char index;
 	int ret;
@@ -1352,7 +1372,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		schedule_work(&ndp->work);
 		break;
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 	case ncsi_dev_state_probe_mlx_gma:
 		ndp->pending_req_num = 1;
 
@@ -1377,30 +1396,29 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_cis;
 		break;
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-	case ncsi_dev_state_probe_cis:
-		ndp->pending_req_num = NCSI_RESERVED_CHANNEL;
+	case ncsi_dev_state_probe_keep_phy:
+		ndp->pending_req_num = 1;
 
-		/* Clear initial state */
-		nca.type = NCSI_PKT_CMD_CIS;
+		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = ndp->active_package->id;
-		for (index = 0; index < NCSI_RESERVED_CHANNEL; index++) {
-			nca.channel = index;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
+		nca.channel = 0;
+		ret = ncsi_oem_keep_phy_intel(&nca);
+		if (ret)
+			goto error;
 
 		nd->state = ncsi_dev_state_probe_gvi;
 		break;
+	case ncsi_dev_state_probe_cis:
 	case ncsi_dev_state_probe_gvi:
 	case ncsi_dev_state_probe_gc:
 	case ncsi_dev_state_probe_gls:
 		np = ndp->active_package;
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
-		/* Retrieve version, capability or link status */
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		/* Clear initial state Retrieve version, capability or link status */
+		if (nd->state == ncsi_dev_state_probe_cis)
+			nca.type = NCSI_PKT_CMD_CIS;
+		else if (nd->state == ncsi_dev_state_probe_gvi)
 			nca.type = NCSI_PKT_CMD_GVI;
 		else if (nd->state == ncsi_dev_state_probe_gc)
 			nca.type = NCSI_PKT_CMD_GC;
@@ -1408,19 +1426,29 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_GLS;
 
 		nca.package = np->id;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
+		nca.channel = ndp->channel_probe_id;
+
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
 
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		if (nd->state == ncsi_dev_state_probe_cis) {
+			nd->state = ncsi_dev_state_probe_gvi;
+			if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY) && ndp->channel_probe_id == 0)
+				nd->state = ncsi_dev_state_probe_keep_phy;
+		} else if (nd->state == ncsi_dev_state_probe_gvi) {
 			nd->state = ncsi_dev_state_probe_gc;
-		else if (nd->state == ncsi_dev_state_probe_gc)
+		} else if (nd->state == ncsi_dev_state_probe_gc) {
 			nd->state = ncsi_dev_state_probe_gls;
-		else
+		} else {
+			nd->state = ncsi_dev_state_probe_cis;
+			ndp->channel_probe_id++;
+		}
+
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
 			nd->state = ncsi_dev_state_probe_dp;
+		}
 		break;
 	case ncsi_dev_state_probe_dp:
 		ndp->pending_req_num = 1;
@@ -1721,6 +1749,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		ndp->requests[i].ndp = ndp;
 		timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);
 	}
+	ndp->channel_count = NCSI_RESERVED_CHANNEL;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
@@ -1753,6 +1782,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
 		ndp->package_probe_id = 0;
+		ndp->channel_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
 		schedule_work(&ndp->work);
 		return 0;
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 6a4638811660..960e2cfc1fd2 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -795,12 +795,13 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	struct ncsi_rsp_gc_pkt *rsp;
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_channel *nc;
+	struct ncsi_package *np;
 	size_t size;
 
 	/* Find the channel */
 	rsp = (struct ncsi_rsp_gc_pkt *)skb_network_header(nr->rsp);
 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
-				      NULL, &nc);
+				      &np, &nc);
 	if (!nc)
 		return -ENODEV;
 
@@ -835,6 +836,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	 */
 	nc->vlan_filter.bitmap = U64_MAX;
 	nc->vlan_filter.n_vids = rsp->vlan_cnt;
+	np->ndp->channel_count = rsp->channel_cnt;
 
 	return 0;
 }
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index cc04c4d7956c..bac92369a543 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -53,12 +53,13 @@ MODULE_DESCRIPTION("core IP set support");
 MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 
 /* When the nfnl mutex or ip_set_ref_lock is held: */
-#define ip_set_dereference(p)		\
-	rcu_dereference_protected(p,	\
+#define ip_set_dereference(inst)	\
+	rcu_dereference_protected((inst)->ip_set_list,	\
 		lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET) || \
-		lockdep_is_held(&ip_set_ref_lock))
+		lockdep_is_held(&ip_set_ref_lock) || \
+		(inst)->is_deleted)
 #define ip_set(inst, id)		\
-	ip_set_dereference((inst)->ip_set_list)[id]
+	ip_set_dereference(inst)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
 #define ip_set_dereference_nfnl(p)	\
@@ -1137,7 +1138,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 		if (!list)
 			goto cleanup;
 		/* nfnl mutex is held, both lists are valid */
-		tmp = ip_set_dereference(inst->ip_set_list);
+		tmp = ip_set_dereference(inst);
 		memcpy(list, tmp, sizeof(struct ip_set *) * inst->ip_set_max);
 		rcu_assign_pointer(inst->ip_set_list, list);
 		/* Make sure all current packets have passed through */
@@ -1176,23 +1177,50 @@ ip_set_setname_policy[IPSET_ATTR_CMD_MAX + 1] = {
 				    .len = IPSET_MAXNAMELEN - 1 },
 };
 
+/* In order to return quickly when destroying a single set, it is split
+ * into two stages:
+ * - Cancel garbage collector
+ * - Destroy the set itself via call_rcu()
+ */
+
 static void
-ip_set_destroy_set(struct ip_set *set)
+ip_set_destroy_set_rcu(struct rcu_head *head)
 {
-	pr_debug("set: %s\n",  set->name);
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
 
-	/* Must call it without holding any lock */
 	set->variant->destroy(set);
 	module_put(set->type->me);
 	kfree(set);
 }
 
 static void
-ip_set_destroy_set_rcu(struct rcu_head *head)
+_destroy_all_sets(struct ip_set_net *inst)
 {
-	struct ip_set *set = container_of(head, struct ip_set, rcu);
+	struct ip_set *set;
+	ip_set_id_t i;
+	bool need_wait = false;
 
-	ip_set_destroy_set(set);
+	/* First cancel gc's: set:list sets are flushed as well */
+	for (i = 0; i < inst->ip_set_max; i++) {
+		set = ip_set(inst, i);
+		if (set) {
+			set->variant->cancel_gc(set);
+			if (set->type->features & IPSET_TYPE_NAME)
+				need_wait = true;
+		}
+	}
+	/* Must wait for flush to be really finished  */
+	if (need_wait)
+		rcu_barrier();
+	for (i = 0; i < inst->ip_set_max; i++) {
+		set = ip_set(inst, i);
+		if (set) {
+			ip_set(inst, i) = NULL;
+			set->variant->destroy(set);
+			module_put(set->type->me);
+			kfree(set);
+		}
+	}
 }
 
 static int ip_set_destroy(struct net *net, struct sock *ctnl,
@@ -1208,11 +1236,10 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
 	 * External systems (i.e. xt_set) must call
-	 * ip_set_put|get_nfnl_* functions, that way we
+	 * ip_set_nfnl_get_* functions, that way we
 	 * can safely check references here.
 	 *
 	 * list:set timer can only decrement the reference
@@ -1220,8 +1247,6 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 	 * without holding the lock.
 	 */
 	if (!attr[IPSET_ATTR_SETNAME]) {
-		/* Must wait for flush to be really finished in list:set */
-		rcu_barrier();
 		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
@@ -1232,15 +1257,7 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 		}
 		inst->is_destroyed = true;
 		read_unlock_bh(&ip_set_ref_lock);
-		for (i = 0; i < inst->ip_set_max; i++) {
-			s = ip_set(inst, i);
-			if (s) {
-				ip_set(inst, i) = NULL;
-				/* Must cancel garbage collectors */
-				s->variant->cancel_gc(s);
-				ip_set_destroy_set(s);
-			}
-		}
+		_destroy_all_sets(inst);
 		/* Modified by ip_set_destroy() only, which is serialized */
 		inst->is_destroyed = false;
 	} else {
@@ -1259,12 +1276,12 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
+		/* Must cancel garbage collectors */
+		s->variant->cancel_gc(s);
 		if (features & IPSET_TYPE_NAME) {
 			/* Must wait for flush to be really finished  */
 			rcu_barrier();
 		}
-		/* Must cancel garbage collectors */
-		s->variant->cancel_gc(s);
 		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
@@ -2400,30 +2417,25 @@ ip_set_net_init(struct net *net)
 }
 
 static void __net_exit
-ip_set_net_exit(struct net *net)
+ip_set_net_pre_exit(struct net *net)
 {
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	struct ip_set *set = NULL;
-	ip_set_id_t i;
-
 	inst->is_deleted = true; /* flag for ip_set_nfnl_put */
+}
 
-	nfnl_lock(NFNL_SUBSYS_IPSET);
-	for (i = 0; i < inst->ip_set_max; i++) {
-		set = ip_set(inst, i);
-		if (set) {
-			ip_set(inst, i) = NULL;
-			set->variant->cancel_gc(set);
-			ip_set_destroy_set(set);
-		}
-	}
-	nfnl_unlock(NFNL_SUBSYS_IPSET);
+static void __net_exit
+ip_set_net_exit(struct net *net)
+{
+	struct ip_set_net *inst = ip_set_pernet(net);
+
+	_destroy_all_sets(inst);
 	kvfree(rcu_dereference_protected(inst->ip_set_list, 1));
 }
 
 static struct pernet_operations ip_set_net_ops = {
 	.init	= ip_set_net_init,
+	.pre_exit = ip_set_net_pre_exit,
 	.exit   = ip_set_net_exit,
 	.id	= &ip_set_net_id,
 	.size	= sizeof(struct ip_set_net),
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 6bc7019982b0..e839c356bcb5 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -79,7 +79,7 @@ list_set_kadd(struct ip_set *set, const struct sk_buff *skb,
 	struct set_elem *e;
 	int ret;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -99,7 +99,7 @@ list_set_kdel(struct ip_set *set, const struct sk_buff *skb,
 	struct set_elem *e;
 	int ret;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -188,9 +188,10 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	struct list_set *map = set->data;
 	struct set_adt_elem *d = value;
 	struct set_elem *e, *next, *prev = NULL;
-	int ret;
+	int ret = 0;
 
-	list_for_each_entry(e, &map->members, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -201,6 +202,7 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 
 		if (d->before == 0) {
 			ret = 1;
+			goto out;
 		} else if (d->before > 0) {
 			next = list_next_entry(e, list);
 			ret = !list_is_last(&e->list, &map->members) &&
@@ -208,9 +210,11 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		} else {
 			ret = prev && prev->id == d->refid;
 		}
-		return ret;
+		goto out;
 	}
-	return 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static void
@@ -239,7 +243,7 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 
 	/* Find where to add the new entry */
 	n = prev = next = NULL;
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -316,9 +320,9 @@ list_set_udel(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 {
 	struct list_set *map = set->data;
 	struct set_adt_elem *d = value;
-	struct set_elem *e, *next, *prev = NULL;
+	struct set_elem *e, *n, *next, *prev = NULL;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_safe(e, n, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -424,14 +428,8 @@ static void
 list_set_destroy(struct ip_set *set)
 {
 	struct list_set *map = set->data;
-	struct set_elem *e, *n;
 
-	list_for_each_entry_safe(e, n, &map->members, list) {
-		list_del(&e->list);
-		ip_set_put_byindex(map->net, e->id);
-		ip_set_ext_destroy(set, e);
-		kfree(e);
-	}
+	WARN_ON_ONCE(!list_empty(&map->members));
 	kfree(map);
 
 	set->data = NULL;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f3cb5c920276..f4bbddfbbc24 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -713,7 +713,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 
 static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
-						   u8 genmask)
+						   int family, u8 genmask)
 {
 	struct nftables_pernet *nft_net;
 	struct nft_table *table;
@@ -721,6 +721,7 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 	nft_net = net_generic(net, nf_tables_net_id);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
+		    table->family == family &&
 		    nft_active_genmask(table, genmask))
 			return table;
 	}
@@ -1440,7 +1441,7 @@ static int nf_tables_deltable(struct net *net, struct sock *nlsk,
 
 	if (nla[NFTA_TABLE_HANDLE]) {
 		attr = nla[NFTA_TABLE_HANDLE];
-		table = nft_table_lookup_byhandle(net, attr, genmask);
+		table = nft_table_lookup_byhandle(net, attr, family, genmask);
 	} else {
 		attr = nla[NFTA_TABLE_NAME];
 		table = nft_table_lookup(net, attr, family, genmask);
@@ -4989,8 +4990,7 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
 	    nft_data_dump(skb, NFTA_SET_ELEM_DATA, nft_set_ext_data(ext),
-			  set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE,
-			  set->dlen) < 0)
+			  nft_set_datatype(set), set->dlen) < 0)
 		goto nla_put_failure;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPR) &&
@@ -9336,6 +9336,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 
 		return 0;
 	default:
+		if (type != NFT_DATA_VALUE)
+			return -EINVAL;
+
 		if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
 			return -EINVAL;
 		if (len == 0)
@@ -9344,8 +9347,6 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		    sizeof_field(struct nft_regs, data))
 			return -ERANGE;
 
-		if (data != NULL && type != NFT_DATA_VALUE)
-			return -EINVAL;
 		return 0;
 	}
 }
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 8bc008ff00cb..d2f8131edaf1 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -101,7 +101,8 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 			return -EINVAL;
 
 		err = nft_parse_register_store(ctx, tb[NFTA_LOOKUP_DREG],
-					       &priv->dreg, NULL, set->dtype,
+					       &priv->dreg, NULL,
+					       nft_set_datatype(set),
 					       set->dlen);
 		if (err < 0)
 			return err;
diff --git a/net/netrom/nr_timer.c b/net/netrom/nr_timer.c
index 4e7c968cde2d..5e3ca068f04e 100644
--- a/net/netrom/nr_timer.c
+++ b/net/netrom/nr_timer.c
@@ -121,7 +121,8 @@ static void nr_heartbeat_expiry(struct timer_list *t)
 		   is accepted() it isn't 'dead' so doesn't get removed. */
 		if (sock_flag(sk, SOCK_DESTROY) ||
 		    (sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_DEAD))) {
-			sock_hold(sk);
+			if (sk->sk_state == TCP_LISTEN)
+				sock_hold(sk);
 			bh_unlock_sock(sk);
 			nr_destroy_socket(sk);
 			goto out;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e52f0949305..9bec88fe3505 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3761,28 +3761,30 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	case PACKET_TX_RING:
 	{
 		union tpacket_req_u req_u;
-		int len;
 
+		ret = -EINVAL;
 		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
-			len = sizeof(req_u.req);
+			if (optlen < sizeof(req_u.req))
+				break;
+			ret = copy_from_sockptr(&req_u.req, optval,
+						sizeof(req_u.req)) ?
+						-EINVAL : 0;
 			break;
 		case TPACKET_V3:
 		default:
-			len = sizeof(req_u.req3);
+			if (optlen < sizeof(req_u.req3))
+				break;
+			ret = copy_from_sockptr(&req_u.req3, optval,
+						sizeof(req_u.req3)) ?
+						-EINVAL : 0;
 			break;
 		}
-		if (optlen < len) {
-			ret = -EINVAL;
-		} else {
-			if (copy_from_sockptr(&req_u.req, optval, len))
-				ret = -EFAULT;
-			else
-				ret = packet_set_ring(sk, &req_u, 0,
-						    optname == PACKET_TX_RING);
-		}
+		if (!ret)
+			ret = packet_set_ring(sk, &req_u, 0,
+					      optname == PACKET_TX_RING);
 		release_sock(sk);
 		return ret;
 	}
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 4ab9c2a6f650..bf98bb602a9d 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -507,6 +507,9 @@ EXPORT_SYMBOL(tcf_idr_cleanup);
  * its reference and bind counters, and return 1. Otherwise insert temporary
  * error pointer (to prevent concurrent users from inserting actions with same
  * index) and return 0.
+ *
+ * May return -EAGAIN for binding actions in case of a parallel add/delete on
+ * the requested index.
  */
 
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
@@ -515,43 +518,60 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 	struct tc_action *p;
 	int ret;
+	u32 max;
 
-again:
-	mutex_lock(&idrinfo->lock);
 	if (*index) {
+		rcu_read_lock();
 		p = idr_find(&idrinfo->action_idr, *index);
+
 		if (IS_ERR(p)) {
 			/* This means that another process allocated
 			 * index but did not assign the pointer yet.
 			 */
-			mutex_unlock(&idrinfo->lock);
-			goto again;
+			rcu_read_unlock();
+			return -EAGAIN;
 		}
 
-		if (p) {
-			refcount_inc(&p->tcfa_refcnt);
-			if (bind)
-				atomic_inc(&p->tcfa_bindcnt);
-			*a = p;
-			ret = 1;
-		} else {
-			*a = NULL;
-			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-					    *index, GFP_KERNEL);
-			if (!ret)
-				idr_replace(&idrinfo->action_idr,
-					    ERR_PTR(-EBUSY), *index);
+		if (!p) {
+			/* Empty slot, try to allocate it */
+			max = *index;
+			rcu_read_unlock();
+			goto new;
 		}
+
+		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
+			/* Action was deleted in parallel */
+			rcu_read_unlock();
+			return -EAGAIN;
+		}
+
+		if (bind)
+			atomic_inc(&p->tcfa_bindcnt);
+		*a = p;
+
+		rcu_read_unlock();
+
+		return 1;
 	} else {
+		/* Find a slot */
 		*index = 1;
-		*a = NULL;
-		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-				    UINT_MAX, GFP_KERNEL);
-		if (!ret)
-			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
-				    *index);
+		max = UINT_MAX;
 	}
+
+new:
+	*a = NULL;
+
+	mutex_lock(&idrinfo->lock);
+	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
+			    GFP_KERNEL);
 	mutex_unlock(&idrinfo->lock);
+
+	/* N binds raced for action allocation,
+	 * retry for all the ones that failed.
+	 */
+	if (ret == -ENOSPC && *index == max)
+		ret = -EAGAIN;
+
 	return ret;
 }
 EXPORT_SYMBOL(tcf_idr_check_alloc);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2d41d866de3e..c6d6a6fe9602 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -38,21 +38,26 @@ static struct workqueue_struct *act_ct_wq;
 static struct rhashtable zones_ht;
 static DEFINE_MUTEX(zones_mutex);
 
+struct zones_ht_key {
+	struct net *net;
+	u16 zone;
+};
+
 struct tcf_ct_flow_table {
 	struct rhash_head node; /* In zones tables */
 
 	struct rcu_work rwork;
 	struct nf_flowtable nf_ft;
 	refcount_t ref;
-	u16 zone;
+	struct zones_ht_key key;
 
 	bool dying;
 };
 
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
-	.key_offset = offsetof(struct tcf_ct_flow_table, zone),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, zone),
+	.key_offset = offsetof(struct tcf_ct_flow_table, key),
+	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
 	.automatic_shrinking = true,
 };
 
@@ -275,13 +280,14 @@ static struct nf_flowtable_type flowtable_ct = {
 	.owner		= THIS_MODULE,
 };
 
-static int tcf_ct_flow_table_get(struct tcf_ct_params *params)
+static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)
 {
+	struct zones_ht_key key = { .net = net, .zone = params->zone };
 	struct tcf_ct_flow_table *ct_ft;
 	int err = -ENOMEM;
 
 	mutex_lock(&zones_mutex);
-	ct_ft = rhashtable_lookup_fast(&zones_ht, &params->zone, zones_params);
+	ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params);
 	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref))
 		goto out_unlock;
 
@@ -290,7 +296,7 @@ static int tcf_ct_flow_table_get(struct tcf_ct_params *params)
 		goto err_alloc;
 	refcount_set(&ct_ft->ref, 1);
 
-	ct_ft->zone = params->zone;
+	ct_ft->key = key;
 	err = rhashtable_insert_fast(&zones_ht, &ct_ft->node, zones_params);
 	if (err)
 		goto err_insert;
@@ -300,6 +306,7 @@ static int tcf_ct_flow_table_get(struct tcf_ct_params *params)
 	err = nf_flow_table_init(&ct_ft->nf_ft);
 	if (err)
 		goto err_init;
+	write_pnet(&ct_ft->nf_ft.net, net);
 
 	__module_get(THIS_MODULE);
 out_unlock:
@@ -1291,7 +1298,7 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 	if (err)
 		goto cleanup;
 
-	err = tcf_ct_flow_table_get(params);
+	err = tcf_ct_flow_table_get(net, params);
 	if (err)
 		goto cleanup_params;
 
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 1c6dbcfa89b8..77fd7be3a9cd 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -185,7 +185,7 @@ static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt->bands = qdisc_dev(sch)->real_num_tx_queues;
 
-	removed = kmalloc(sizeof(*removed) * (q->max_bands - q->bands),
+	removed = kmalloc(sizeof(*removed) * (q->max_bands - qopt->bands),
 			  GFP_KERNEL);
 	if (!removed)
 		return -ENOMEM;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2d842f31ec5a..ec6b24edf5f9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -925,16 +925,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 {
 	int i, j;
 
-	if (!qopt && !dev->num_tc) {
-		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
-		return -EINVAL;
-	}
-
-	/* If num_tc is already set, it means that the user already
-	 * configured the mqprio part
-	 */
-	if (dev->num_tc)
+	if (!qopt) {
+		if (!dev->num_tc) {
+			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
+			return -EINVAL;
+		}
 		return 0;
+	}
 
 	/* Verify num_tc is not out of max range */
 	if (qopt->num_tc > TC_MAX_QUEUE) {
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 2ff66a6a7e54..7ce4a6b7cfae 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1855,8 +1855,10 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	offset = (u8 *)p - (u8 *)snd_buf->head[0].iov_base;
 	maj_stat = gss_wrap(ctx->gc_gss_ctx, offset, snd_buf, inpages);
 	/* slack space should prevent this ever happening: */
-	if (unlikely(snd_buf->len > snd_buf->buflen))
+	if (unlikely(snd_buf->len > snd_buf->buflen)) {
+		status = -EIO;
 		goto wrap_failed;
+	}
 	/* We're assuming that when GSS_S_CONTEXT_EXPIRED, the encryption was
 	 * done anyway, so it's safe to put the request on the wire: */
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 26d972c54a59..f8815ae776e6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -845,7 +845,8 @@ void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	svc_release_buffer(rqstp);
-	put_page(rqstp->rq_scratch_page);
+	if (rqstp->rq_scratch_page)
+		put_page(rqstp->rq_scratch_page);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
@@ -1611,6 +1612,21 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_max_payload);
 
+/**
+ * svc_proc_name - Return RPC procedure name in string form
+ * @rqstp: svc_rqst to operate on
+ *
+ * Return value:
+ *   Pointer to a NUL-terminated string
+ */
+const char *svc_proc_name(const struct svc_rqst *rqstp)
+{
+	if (rqstp && rqstp->rq_procinfo)
+		return rqstp->rq_procinfo->pc_name;
+	return "unknown";
+}
+
+
 /**
  * svc_encode_result_payload - mark a range of bytes as a result payload
  * @rqstp: svc_rqst to operate on
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 9e3cfeb82a23..5f6866407be5 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2076,6 +2076,7 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 	} else {
 		n = tipc_node_find_by_id(net, ehdr->id);
 	}
+	skb_dst_force(skb);
 	tipc_crypto_rcv(net, (n) ? n->crypto_rx : NULL, &skb, b);
 	if (!skb)
 		return;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 405bf3e6eb79..e2ff610d2776 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -189,15 +189,9 @@ static inline int unix_may_send(struct sock *sk, struct sock *osk)
 	return unix_peer(osk) == NULL || unix_our_peer(sk, osk);
 }
 
-static inline int unix_recvq_full(const struct sock *sk)
-{
-	return skb_queue_len(&sk->sk_receive_queue) > sk->sk_max_ack_backlog;
-}
-
 static inline int unix_recvq_full_lockless(const struct sock *sk)
 {
-	return skb_queue_len_lockless(&sk->sk_receive_queue) >
-		READ_ONCE(sk->sk_max_ack_backlog);
+	return skb_queue_len_lockless(&sk->sk_receive_queue) > sk->sk_max_ack_backlog;
 }
 
 struct sock *unix_peer_get(struct sock *s)
@@ -447,9 +441,9 @@ static int unix_dgram_peer_wake_me(struct sock *sk, struct sock *other)
 	return 0;
 }
 
-static int unix_writable(const struct sock *sk)
+static int unix_writable(const struct sock *sk, unsigned char state)
 {
-	return sk->sk_state != TCP_LISTEN &&
+	return state != TCP_LISTEN &&
 	       (refcount_read(&sk->sk_wmem_alloc) << 2) <= sk->sk_sndbuf;
 }
 
@@ -458,7 +452,7 @@ static void unix_write_space(struct sock *sk)
 	struct socket_wq *wq;
 
 	rcu_read_lock();
-	if (unix_writable(sk)) {
+	if (unix_writable(sk, READ_ONCE(sk->sk_state))) {
 		wq = rcu_dereference(sk->sk_wq);
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible_sync_poll(&wq->wait,
@@ -815,7 +809,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
 
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
-	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
+	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
@@ -1310,7 +1304,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (other->sk_shutdown & RCV_SHUTDOWN)
 		goto out_unlock;
 
-	if (unix_recvq_full(other)) {
+	if (unix_recvq_full_lockless(other)) {
 		err = -EAGAIN;
 		if (!timeo)
 			goto out_unlock;
@@ -1909,7 +1903,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_err;
 
 	if (msg->msg_namelen) {
-		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
+		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
 		err = -ENOTCONN;
@@ -2112,7 +2106,7 @@ static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err)
 		return err;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	if (msg->msg_namelen)
@@ -2126,7 +2120,7 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	return unix_dgram_recvmsg(sock, msg, size, flags);
@@ -2326,7 +2320,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	size_t size = state->size;
 	unsigned int last_len;
 
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -2614,7 +2608,7 @@ long unix_inq_len(struct sock *sk)
 	struct sk_buff *skb;
 	long amount = 0;
 
-	if (sk->sk_state == TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN)
 		return -EINVAL;
 
 	spin_lock(&sk->sk_receive_queue.lock);
@@ -2713,12 +2707,14 @@ static int unix_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
+	unsigned char state;
 	__poll_t mask;
 	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 	shutdown = READ_ONCE(sk->sk_shutdown);
+	state = READ_ONCE(sk->sk_state);
 
 	/* exceptional events? */
 	if (sk->sk_err)
@@ -2734,14 +2730,14 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 
 	/* Connection-based need to check for termination and startup */
 	if ((sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) &&
-	    sk->sk_state == TCP_CLOSE)
+	    state == TCP_CLOSE)
 		mask |= EPOLLHUP;
 
 	/*
 	 * we set writable also when the other side has shut down the
 	 * connection. This prevents stuck sockets.
 	 */
-	if (unix_writable(sk))
+	if (unix_writable(sk, state))
 		mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
 
 	return mask;
@@ -2752,12 +2748,14 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk, *other;
 	unsigned int writable;
+	unsigned char state;
 	__poll_t mask;
 	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 	shutdown = READ_ONCE(sk->sk_shutdown);
+	state = READ_ONCE(sk->sk_state);
 
 	/* exceptional events? */
 	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
@@ -2774,19 +2772,14 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
-	if (sk->sk_type == SOCK_SEQPACKET) {
-		if (sk->sk_state == TCP_CLOSE)
-			mask |= EPOLLHUP;
-		/* connection hasn't started yet? */
-		if (sk->sk_state == TCP_SYN_SENT)
-			return mask;
-	}
+	if (sk->sk_type == SOCK_SEQPACKET && state == TCP_CLOSE)
+		mask |= EPOLLHUP;
 
 	/* No write status requested, avoid expensive OUT tests. */
 	if (!(poll_requested_events(wait) & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
 		return mask;
 
-	writable = unix_writable(sk);
+	writable = unix_writable(sk, state);
 	if (writable) {
 		unix_state_lock(sk);
 
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 2975e7a061d0..7066a3623410 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -64,7 +64,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 	u32 *buf;
 	int i;
 
-	if (sk->sk_state == TCP_LISTEN) {
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
 		spin_lock(&sk->sk_receive_queue.lock);
 
 		attr = nla_reserve(nlskb, UNIX_DIAG_ICONS,
@@ -102,8 +102,8 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct unix_diag_rqlen rql;
 
-	if (sk->sk_state == TCP_LISTEN) {
-		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
+		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
 		rql.udiag_rqueue = (u32) unix_inq_len(sk);
@@ -135,7 +135,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	rep = nlmsg_data(nlh);
 	rep->udiag_family = AF_UNIX;
 	rep->udiag_type = sk->sk_type;
-	rep->udiag_state = sk->sk_state;
+	rep->udiag_state = READ_ONCE(sk->sk_state);
 	rep->pad = 0;
 	rep->udiag_ino = sk_ino;
 	sock_diag_save_cookie(sk, rep->udiag_cookie);
@@ -164,7 +164,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	    sock_diag_put_meminfo(sk, skb, UNIX_DIAG_MEMINFO))
 		goto out_nlmsg_trim;
 
-	if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, sk->sk_shutdown))
+	if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, READ_ONCE(sk->sk_shutdown)))
 		goto out_nlmsg_trim;
 
 	if ((req->udiag_show & UDIAG_SHOW_UID) &&
@@ -218,7 +218,7 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 				continue;
 			if (num < s_num)
 				goto next;
-			if (!(req->udiag_states & (1 << sk->sk_state)))
+			if (!(req->udiag_states & (1 << READ_ONCE(sk->sk_state))))
 				goto next;
 			if (sk_diag_dump(sk, skb, req, sk_user_ns(skb->sk),
 					 NETLINK_CB(cb->skb).portid,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a817d8e3e4b3..7503c7dd71ab 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -58,7 +58,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_period = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD])
 		out->ftm.burst_period =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
+			nla_get_u16(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
 
 	out->ftm.asap = !!tb[NL80211_PMSR_FTM_REQ_ATTR_ASAP];
 	if (out->ftm.asap && !capa->ftm.asap) {
@@ -77,7 +77,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.num_bursts_exp = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP])
 		out->ftm.num_bursts_exp =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
 
 	if (capa->ftm.max_bursts_exponent >= 0 &&
 	    out->ftm.num_bursts_exp > capa->ftm.max_bursts_exponent) {
@@ -90,7 +90,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_duration = 15;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION])
 		out->ftm.burst_duration =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
 
 	out->ftm.ftms_per_burst = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST])
@@ -109,7 +109,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.ftmr_retries = 3;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES])
 		out->ftm.ftmr_retries =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
 
 	out->ftm.request_lci = !!tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI];
 	if (out->ftm.request_lci && !capa->ftm.request_lci) {
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 50d580d77ae9..e1ac7e40bbaa 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -24,7 +24,7 @@ __dtbs_install: $(dtbs) $(subdirs)
 	@:
 
 quiet_cmd_dtb_install = INSTALL $@
-      cmd_dtb_install = install -D $< $@
+      cmd_dtb_install = install -D -m 0644 $< $@
 
 $(dst)/%.dtb: $(obj)/%.dtb
 	$(call cmd,dtb_install)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4af809493805..5c5a144e707f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9380,6 +9380,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x1c6c, 0x122a, "Positivo N14AP7", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1c6c, 0x1251, "Positivo N14KP6-TG", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_SET_COEF_DEFAULTS),
 	SND_PCI_QUIRK(0x1d05, 0x1096, "TongFang GMxMRxx", ALC269_FIXUP_NO_SHUTUP),
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 9a756d0a6032..c876f111d8b0 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -538,6 +538,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
+
 	cpu_np = of_parse_phandle(np, "audio-cpu", 0);
 	/* Give a chance to old DT binding */
 	if (!cpu_np)
@@ -718,7 +720,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize sound card */
-	priv->pdev = pdev;
 	priv->card.dev = &pdev->dev;
 	priv->card.owner = THIS_MODULE;
 	ret = snd_soc_of_parse_card_name(&priv->card, "model");
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f36a0fda1b6a..25bf73a7e7bf 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -216,6 +216,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Transcend Gaming Laptop"),
+		},
+		.driver_data = (void *)(RT711_JD2),
+	},
+
 	/* LunarLake devices */
 	{
 		.callback = sof_sdw_quirk_cb,
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 9ebc711afa6b..18b2d8492656 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -697,7 +697,6 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 	struct snd_soundfont *sf;
 	struct soundfont_sample_info sample_info;
 	struct snd_sf_sample *sp;
-	long off;
 
 	/* patch must be opened */
 	if ((sf = sflist->currsf) == NULL)
@@ -706,12 +705,16 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 	if (is_special_type(sf->type))
 		return -EINVAL;
 
+	if (count < (long)sizeof(sample_info)) {
+		return -EINVAL;
+	}
 	if (copy_from_user(&sample_info, data, sizeof(sample_info)))
 		return -EFAULT;
+	data += sizeof(sample_info);
+	count -= sizeof(sample_info);
 
-	off = sizeof(sample_info);
-
-	if (sample_info.size != (count-off)/2)
+	// SoundFont uses S16LE samples.
+	if (sample_info.size * 2 != count)
 		return -EINVAL;
 
 	/* Check for dup */
@@ -738,7 +741,7 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 		int  rc;
 		rc = sflist->callback.sample_new
 			(sflist->callback.private_data, sp, sflist->memhdr,
-			 data + off, count - off);
+			 data, count);
 		if (rc < 0) {
 			sf_sample_delete(sflist, sf, sp);
 			return rc;
@@ -951,10 +954,12 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	}
 	if (copy_from_user(&patch, data, sizeof(patch)))
 		return -EFAULT;
-	
 	count -= sizeof(patch);
 	data += sizeof(patch);
 
+	if ((patch.len << (patch.mode & WAVE_16_BITS ? 1 : 0)) != count)
+		return -EINVAL;
+
 	sf = newsf(sflist, SNDRV_SFNT_PAT_TYPE_GUS|SNDRV_SFNT_PAT_SHARED, NULL);
 	if (sf == NULL)
 		return -ENOMEM;
diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
index e4732d3c2998..9d279fa4c36f 100644
--- a/tools/include/asm-generic/hugetlb_encode.h
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -20,15 +20,15 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
index 5701163460ef..955f87c1170d 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <sys/prctl.h>
 #include <sys/utsname.h>
+#include "../../kselftest.h"
 
 #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
 #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
@@ -21,6 +22,9 @@ int main(void)
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (!ptr)
+		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
+
 	if (tbi_enabled)
 		tag = 0x42;
 	ptr = (struct utsname *)SET_TAG(ptr, tag);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index 76ebe4c250f1..a434828bc7ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -58,7 +58,7 @@ static void test_lookup_update(void)
 	int map1_fd, map2_fd, map3_fd, map4_fd, map5_fd, map1_id, map2_id;
 	int outer_arr_fd, outer_hash_fd, outer_arr_dyn_fd;
 	struct test_btf_map_in_map *skel;
-	int err, key = 0, val, i, fd;
+	int err, key = 0, val, i;
 
 	skel = test_btf_map_in_map__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
@@ -135,30 +135,6 @@ static void test_lookup_update(void)
 	CHECK(map1_id == 0, "map1_id", "failed to get ID 1\n");
 	CHECK(map2_id == 0, "map2_id", "failed to get ID 2\n");
 
-	test_btf_map_in_map__destroy(skel);
-	skel = NULL;
-
-	/* we need to either wait for or force synchronize_rcu(), before
-	 * checking for "still exists" condition, otherwise map could still be
-	 * resolvable by ID, causing false positives.
-	 *
-	 * Older kernels (5.8 and earlier) freed map only after two
-	 * synchronize_rcu()s, so trigger two, to be entirely sure.
-	 */
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-
-	fd = bpf_map_get_fd_by_id(map1_id);
-	if (CHECK(fd >= 0, "map1_leak", "inner_map1 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-	fd = bpf_map_get_fd_by_id(map2_id);
-	if (CHECK(fd >= 0, "map2_leak", "inner_map2 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-
 cleanup:
 	test_btf_map_in_map__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7c76b841b17b..21bde60c9523 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -71,7 +71,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l -p "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -92,6 +91,16 @@ verify_data() {
 	fi
 }
 
+wait_for_port() {
+	for i in $(seq 20); do
+		if ip netns exec "${ns2}" ss ${2:--4}OHntl | grep -q "$1"; then
+			return 0
+		fi
+		sleep 0.1
+	done
+	return 1
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -183,6 +192,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -194,6 +204,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 1f6981ef7afa..ba19b81cef39 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -30,7 +30,8 @@ find_dot_func() {
 	fi
 
 	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
-		if grep -s $f available_filter_functions; then
+		cnt=`grep -s $f available_filter_functions | wc -l`;
+		if [ $cnt -eq 1 ]; then
 			echo $f
 			break
 		fi
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 9b420140ba2b..7c260060a1a6 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -33,7 +33,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	FILE *cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -44,7 +44,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -62,14 +62,14 @@ int prereq(void)
 	fd = open("/proc/sys/vm/compact_unevictable_allowed",
 		  O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to open /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, &allowed, sizeof(char)) != sizeof(char)) {
-		perror("Failed to read from\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to read from /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		close(fd);
 		return -1;
 	}
@@ -78,15 +78,17 @@ int prereq(void)
 	if (allowed == '1')
 		return 0;
 
+	ksft_print_msg("Compaction isn't allowed\n");
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 {
-	int fd;
+	unsigned long nr_hugepages_ul;
+	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[10] = {0};
-	char nr_hugepages[10] = {0};
+	char initial_nr_hugepages[20] = {0};
+	char nr_hugepages[20] = {0};
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -94,18 +96,23 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open /proc/sys/vm/nr_hugepages");
+		ksft_test_result_fail("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		perror("Failed to read from /proc/sys/vm/nr_hugepages");
+		ksft_test_result_fail("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		perror("Failed to write 0 to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
@@ -114,82 +121,80 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
 	/* We should have been able to request at least 1/3 rd of the memory in
 	   huge pages */
-	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
-
-	if (compaction_index > 3) {
-		printf("No of huge pages allocated = %d\n",
-		       (atoi(nr_hugepages)));
-		fprintf(stderr, "ERROR: Less that 1/%d of memory is available\n"
-			"as huge pages\n", compaction_index);
+	nr_hugepages_ul = strtoul(nr_hugepages, NULL, 10);
+	if (!nr_hugepages_ul) {
+		ksft_print_msg("ERROR: No memory is available as huge pages\n");
 		goto close_fd;
 	}
-
-	printf("No of huge pages allocated = %d\n",
-	       (atoi(nr_hugepages)));
+	compaction_index = mem_free/(nr_hugepages_ul * hugepage_size);
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
-		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
-	close(fd);
-	return 0;
+	if (compaction_index > 3) {
+		ksft_print_msg("ERROR: Less than 1/%d of memory is available\n"
+			       "as huge pages\n", compaction_index);
+		ksft_test_result_fail("No of huge pages allocated = %d\n", (atoi(nr_hugepages)));
+		goto close_fd;
+	}
+
+	ksft_test_result_pass("Memory compaction succeeded. No of huge pages allocated = %d\n",
+			      (atoi(nr_hugepages)));
+	ret = 0;
 
  close_fd:
 	close(fd);
-	printf("Not OK. Compaction test failed.");
-	return -1;
+	return ret;
 }
 
 
 int main(int argc, char **argv)
 {
 	struct rlimit lim;
-	struct map_list *list, *entry;
+	struct map_list *list = NULL, *entry;
 	size_t page_size, i;
 	void *map = NULL;
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
 
-	if (prereq() != 0) {
-		printf("Either the sysctl compact_unevictable_allowed is not\n"
-		       "set to 1 or couldn't read the proc file.\n"
-		       "Skipping the test\n");
-		return KSFT_SKIP;
-	}
+	ksft_print_header();
+
+	if (prereq() != 0)
+		return ksft_exit_pass();
+
+	ksft_set_plan(1);
 
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
-	if (setrlimit(RLIMIT_MEMLOCK, &lim)) {
-		perror("Failed to set rlimit:\n");
-		return -1;
-	}
+	if (setrlimit(RLIMIT_MEMLOCK, &lim))
+		ksft_exit_fail_msg("Failed to set rlimit: %s\n", strerror(errno));
 
 	page_size = getpagesize();
 
-	list = NULL;
-
-	if (read_memory_info(&mem_free, &hugepage_size) != 0) {
-		printf("ERROR: Cannot read meminfo\n");
-		return -1;
-	}
+	if (read_memory_info(&mem_free, &hugepage_size) != 0)
+		ksft_exit_fail_msg("Failed to get meminfo\n");
 
 	mem_fragmentable_MB = mem_free * 0.8 / 1024;
 
@@ -225,7 +230,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return 0;
+		return ksft_exit_pass();
 
-	return -1;
+	return ksft_exit_fail();
 }

