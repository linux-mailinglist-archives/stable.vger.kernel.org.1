Return-Path: <stable+bounces-58111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E060D9282AD
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2190B24AB0
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593D13BC02;
	Fri,  5 Jul 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsA8BIMh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DA14533E;
	Fri,  5 Jul 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164626; cv=none; b=JPWWckypbTa7oVTC3DGTdJg9ehrjU6TZhZ0yic4FdIRQ7Svy+xJHGSXVqxED8WyxxYwMnEdj1eMVx5TmPzqeozNaeQZOXm/c503nprIrF+DG2yBZnyhN9U8zVE0KsFvGxaaWOFWH9tFqZi7Hnb/enP+Kch4y8hAxQQAcIyIaeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164626; c=relaxed/simple;
	bh=uMZnUDbUAVTvu1c0gVYLx2xFlZ2rf5Ekntmvv8mZ/RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6k+HGcdDcmDgOCpp7jdhoENEnwUv6SZDBNF718k1lYuBsaB2Mtex6F/fsexbzANqfDMcwRIQW4RltRw+H27oRebJeNJbkd4+mHD9zYRUqVgeqNJeKcumc7wSIw9qbhxIpjvoTyS1hx5NXLX59LJLuWbstyS4rWf8m6cTjDJ694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsA8BIMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1D2C4AF07;
	Fri,  5 Jul 2024 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720164626;
	bh=uMZnUDbUAVTvu1c0gVYLx2xFlZ2rf5Ekntmvv8mZ/RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsA8BIMhrpkedSo6u0JYJT954eHg3BwiTdzN+raN/MZSTwwH8UgTQYwBhVfvn2Jv7
	 107nkQSD25Lija9c9YijZce1/m8FEp7yMBl2GlCFf4Hfdz4usNF5JzBC47pV2sxfDX
	 e15ayI9dZnGVPw65Ju9KkJhZOJ/FHrLVS5hYvS+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.279
Date: Fri,  5 Jul 2024 09:30:13 +0200
Message-ID: <2024070511-smilingly-handsaw-40cb@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024070510-superbowl-bony-e5ce@gregkh>
References: <2024070510-superbowl-bony-e5ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index f99e767caa24..960147052d12 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 278
+SUBLEVEL = 279
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 77fc11e593ad..9297788c0c43 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -64,7 +64,7 @@
 &keypad {
 	samsung,keypad-num-rows = <2>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index c6678c120cbd..7b2dceb47c44 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -431,7 +431,7 @@
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index e70fb6e601f0..087e1f99ba32 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -43,7 +43,7 @@
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 1ac9deb3bd39..055687d3153f 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -124,6 +124,7 @@
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 522d3ef72df5..03244871474e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -43,7 +43,7 @@
 		vddrf-supply = <&vreg_l1_1p3>;
 		vddch0-supply = <&vdd_ch0_3p3>;
 
-		local-bd-address = [ 02 00 00 00 5a ad ];
+		local-bd-address = [ 00 00 00 00 00 00 ];
 
 		max-speed = <3200000>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index fd86188010b2..45f40cfaca4f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -686,6 +686,7 @@
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -697,6 +698,7 @@
 		clocks = <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
 		dmas = <&dmac_bus 6>, <&dmac_bus 7>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -710,6 +712,7 @@
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_8ch_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
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
index 36fbedcbd518..4ef8842100b3 100644
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
index e016bf6fae1e..eb84763062ee 100644
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
index 0826c4ed8377..c4a6dad1e605 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -403,7 +403,7 @@ long plpar_hcall_norets(unsigned long opcode, ...);
  * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
 #define PLPAR_HCALL_BUFSIZE 4
-long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
@@ -417,7 +417,7 @@ long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
  * plpar_hcall, but plpar_hcall_raw works in real mode and does not
  * calculate hypervisor call statistics.
  */
-long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
@@ -428,8 +428,8 @@ long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
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
index daba2d2a02a0..e86516ff8f4b 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -542,12 +542,12 @@ __do_out_asm(_rec_outl, "stwbrx")
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
@@ -563,12 +563,12 @@ __do_out_asm(_rec_outl, "stwbrx")
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
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c8cc7537fb2..8235655e0322 100644
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
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c4bc01da820e..e3b5de7b9598 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -166,7 +166,14 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
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
 
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 36a585b80d9e..d4352ae0deb3 100644
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
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index c08521194b29..817e4c944572 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -43,7 +43,6 @@ acpi_ex_system_memory_space_handler(u32 function,
 	struct acpi_mem_space_context *mem_info = region_context;
 	u32 length;
 	acpi_size map_length;
-	acpi_size page_boundary_map_length;
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -120,26 +119,8 @@ acpi_ex_system_memory_space_handler(u32 function,
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
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e2cf9859c67b..d1d279107a72 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6194,8 +6194,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
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
@@ -6227,8 +6229,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 
  err_out:
 	devres_release_group(dev, NULL);
- err_free:
-	kfree(host);
 	return NULL;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6fb31f489452..60de73c67991 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1273,8 +1273,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 4ce270513695..d108202d2ec1 100644
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
@@ -241,9 +239,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
+				   &len, 3000);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			goto error;
 		}
@@ -278,7 +276,7 @@ static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
 }
 
 static int ath3k_get_version(struct usb_device *udev,
-			struct ath3k_version *version)
+			     struct ath3k_version *version)
 {
 	int ret, pipe = 0;
 	struct ath3k_version *buf;
@@ -300,7 +298,7 @@ static int ath3k_get_version(struct usb_device *udev,
 }
 
 static int ath3k_load_fwfile(struct usb_device *udev,
-		const struct firmware *firmware)
+			     const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -341,8 +339,8 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
-		if (err || (len != size)) {
+				   &len, 3000);
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			kfree(send_buf);
 			return err;
@@ -461,7 +459,6 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	switch (fw_version.ref_clock) {
-
 	case ATH3K_XTAL_FREQ_26M:
 		clk_value = 26;
 		break;
@@ -477,7 +474,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
+		 le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -492,7 +489,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 }
 
 static int ath3k_probe(struct usb_interface *intf,
-			const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	const struct firmware *firmware;
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -541,10 +538,10 @@ static int ath3k_probe(struct usb_interface *intf,
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
 
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f1d149e32839..2fa06eaff50d 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -947,8 +947,8 @@ static int axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
+	of_dma_controller_free(pdev->dev.of_node);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index a6a6dc432db8..de1ac910464e 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1446,6 +1446,7 @@ module_init(ioat_init_module);
 static void __exit ioat_exit_module(void)
 {
 	pci_unregister_driver(&ioat_pci_driver);
+	kmem_cache_destroy(ioat_sed_cache);
 	kmem_cache_destroy(ioat_cache);
 }
 module_exit(ioat_exit_module);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ae414045a750..370065e7bd3a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1230,7 +1230,7 @@ config GPIO_TPS68470
 	  drivers are loaded.
 
 config GPIO_TQMX86
-	tristate "TQ-Systems QTMX86 GPIO"
+	tristate "TQ-Systems TQMx86 GPIO"
 	depends on MFD_TQMX86 || COMPILE_TEST
 	depends on HAS_IOPORT_MAP
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 576cb2d0708f..ae5c3080ec3c 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
index 6eb6f05c1136..56e15f5bc822 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -163,6 +163,8 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
 
 	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
 		if (table[i].ulSupportedSCLK != 0) {
+			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
+				continue;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
 				table[i].usVoltageID;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 6718777c826d..5d2013f1c072 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -635,6 +635,12 @@ void enc1_stream_encoder_set_mst_bandwidth(
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
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 31527fb66b5c..c6c4847c6904 100644
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
index b12ae3a4c5f1..695dba0f018f 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -203,9 +203,12 @@ EXPORT_SYMBOL(drm_panel_bridge_remove);
 
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
index 46fc472be306..8deafa5b5c0e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -301,6 +301,7 @@ static int vidi_get_modes(struct drm_connector *connector)
 	struct vidi_context *ctx = ctx_from_connector(connector);
 	struct edid *edid;
 	int edid_len;
+	int count;
 
 	/*
 	 * the edid data comes from user side and it would be set
@@ -320,7 +321,11 @@ static int vidi_get_modes(struct drm_connector *connector)
 
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
index 0e2e1dfcd9ce..579a9b1b8137 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -876,11 +876,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
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
@@ -895,6 +895,9 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	kfree(edid);
 
 	return ret;
+
+no_edid:
+	return drm_add_modes_noedid(connector, 640, 480);
 }
 
 static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 03466f04c741..a4e6fbcbc282 100644
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
index e8789e460a16..58daabb48073 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -307,10 +307,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	msleep(5);
 
 	/* And reset it */
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 	msleep(20);
 
-	gpiod_set_value(ctx->reset, 0);
+	gpiod_set_value_cansleep(ctx->reset, 0);
 	msleep(20);
 
 	for (i = 0; i < ARRAY_SIZE(ili9881c_init); i++) {
@@ -367,7 +367,7 @@ static int ili9881c_unprepare(struct drm_panel *panel)
 
 	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
 	regulator_disable(ctx->power);
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 
 	return 0;
 }
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
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 67dbe6fda9a1..5412031fb67c 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e0820feb7e19..2462be8c4ae6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1439,7 +1439,6 @@ static void implement(const struct hid_device *hid, u8 *report,
 			hid_warn(hid,
 				 "%s() called with too large value %d (n: %d)! (%s)\n",
 				 __func__, value, n, current->comm);
-			WARN_ON(1);
 			value &= m;
 		}
 	}
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 0c2aa9024b87..be19f299f9ec 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1213,8 +1213,10 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 */
 		msleep(50);
 
-		if (retval)
+		if (retval) {
+			kfree(dj_report);
 			return retval;
+		}
 	}
 
 	/*
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1671f6f9ea80..48f9b1fbcbda 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -283,10 +283,23 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 PAGE_SIZE, &recvlen, &requestid);
+	/*
+	 * Drain the ring buffer and use the last packet to update
+	 * host_ts
+	 */
+	while (1) {
+		int ret = vmbus_recvpacket(channel, time_txf_buf,
+					   HV_HYP_PAGE_SIZE, &recvlen,
+					   &requestid);
+		if (ret) {
+			pr_warn_once("TimeSync IC pkt recv failed (Err: %d)\n",
+				     ret);
+			break;
+		}
+
+		if (!recvlen)
+			break;
 
-	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 486621f37bb5..c15c9c2daf17 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -294,11 +294,36 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
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
 		/* Rocket Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c19),
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
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1c3595c8a761..f107a512210f 100644
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
index c31b8eabb894..8349bc8e98c9 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -159,6 +159,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val, 11);
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
index ccde4c65ff93..e2427c3a9dbd 100644
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
@@ -334,10 +335,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
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
 
@@ -360,9 +361,9 @@ static u32 bme680_compensate_press(struct bme680_data *data,
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
@@ -380,7 +381,7 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var3 = ((press_comp >> 8) * (press_comp >> 8) *
 			(press_comp >> 8) * calib->par_p10) >> 17;
 
-	press_comp += (var1 + var2 + var3 + (calib->par_p7 << 7)) >> 4;
+	press_comp += (var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4;
 
 	return press_comp;
 }
@@ -406,7 +407,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
 	var3 = var1 * var2;
-	var4 = calib->par_h6 << 7;
+	var4 = (s32)calib->par_h6 << 7;
 	var4 = (var4 + ((temp_scaled * calib->par_h7) / 100)) >> 4;
 	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
 	var6 = (var4 * var5) >> 1;
@@ -524,6 +525,43 @@ static u8 bme680_oversampling_to_reg(u8 val)
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
@@ -614,6 +652,10 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       (u8 *) &tmp, 3);
 	if (ret < 0) {
@@ -670,7 +712,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
@@ -730,6 +772,10 @@ static int bme680_read_gas(struct bme680_data *data,
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
index 87a51a85a642..75025be02dd2 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -157,7 +157,6 @@ static void ad5592r_gpio_cleanup(struct ad5592r_state *st)
 static int ad5592r_reset(struct ad5592r_state *st)
 {
 	struct gpio_desc *gpio;
-	struct iio_dev *iio_dev = iio_priv_to_dev(st);
 
 	gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
@@ -167,10 +166,10 @@ static int ad5592r_reset(struct ad5592r_state *st)
 		udelay(1);
 		gpiod_set_value(gpio, 1);
 	} else {
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 		/* Writing this magic value resets the device */
 		st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
-		mutex_unlock(&iio_dev->mlock);
+		mutex_unlock(&st->lock);
 	}
 
 	udelay(250);
@@ -198,7 +197,6 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 	const struct ad5592r_rw_ops *ops = st->ops;
 	int ret;
 	unsigned i;
-	struct iio_dev *iio_dev = iio_priv_to_dev(st);
 	u8 pulldown = 0, tristate = 0, dac = 0, adc = 0;
 	u16 read_back;
 
@@ -248,7 +246,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 		}
 	}
 
-	mutex_lock(&iio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	/* Pull down unused pins to GND */
 	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
@@ -286,7 +284,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 		ret = -EIO;
 
 err_unlock:
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -315,11 +313,11 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 		if (!chan->output)
 			return -EINVAL;
 
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = st->ops->write_dac(st, chan->channel, val);
 		if (!ret)
 			st->cached_dac[chan->channel] = val;
-		mutex_unlock(&iio_dev->mlock);
+		mutex_unlock(&st->lock);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_VOLTAGE) {
@@ -334,12 +332,12 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 			else
 				return -EINVAL;
 
-			mutex_lock(&iio_dev->mlock);
+			mutex_lock(&st->lock);
 
 			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
 						&st->cached_gp_ctrl);
 			if (ret < 0) {
-				mutex_unlock(&iio_dev->mlock);
+				mutex_unlock(&st->lock);
 				return ret;
 			}
 
@@ -361,7 +359,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 
 			ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
 						 st->cached_gp_ctrl);
-			mutex_unlock(&iio_dev->mlock);
+			mutex_unlock(&st->lock);
 
 			return ret;
 		}
@@ -379,11 +377,11 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 {
 	struct ad5592r_state *st = iio_priv(iio_dev);
 	u16 read_val;
-	int ret;
+	int ret, mult;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 
 		if (!chan->output) {
 			ret = st->ops->read_adc(st, chan->channel, &read_val);
@@ -416,29 +414,27 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
-		} else {
-			int mult;
+			return IIO_VAL_INT_PLUS_NANO;
+		}
 
-			mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 
-			if (chan->output)
-				mult = !!(st->cached_gp_ctrl &
-					AD5592R_REG_CTRL_DAC_RANGE);
-			else
-				mult = !!(st->cached_gp_ctrl &
-					AD5592R_REG_CTRL_ADC_RANGE);
+		if (chan->output)
+			mult = !!(st->cached_gp_ctrl &
+				AD5592R_REG_CTRL_DAC_RANGE);
+		else
+			mult = !!(st->cached_gp_ctrl &
+				AD5592R_REG_CTRL_ADC_RANGE);
 
-			*val *= ++mult;
+		*val *= ++mult;
 
-			*val2 = chan->scan_type.realbits;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
-		}
+		*val2 = chan->scan_type.realbits;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = ad5592r_get_vref(st);
 
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 
 		if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
 			*val = (-34365 * 25) / ret;
@@ -451,7 +447,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 	}
 
 unlock:
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -626,6 +622,8 @@ int ad5592r_probe(struct device *dev, const char *name,
 	iio_dev->info = &ad5592r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
+	mutex_init(&st->lock);
+
 	ad5592r_init_scales(st, ad5592r_get_vref(st));
 
 	ret = ad5592r_reset(st);
diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
index 4774e4cd9c11..23dac2f1ff8a 100644
--- a/drivers/iio/dac/ad5592r-base.h
+++ b/drivers/iio/dac/ad5592r-base.h
@@ -52,6 +52,7 @@ struct ad5592r_state {
 	struct regulator *reg;
 	struct gpio_chip gpiochip;
 	struct mutex gpio_lock;	/* Protect cached gpio_out, gpio_val, etc. */
+	struct mutex lock;
 	unsigned int num_channels;
 	const struct ad5592r_rw_ops *ops;
 	int scale_avail[2][2];
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 0e16a9980c6a..45fdb9bdf08d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1358,19 +1358,19 @@ static int input_print_modalias_bits(char *buf, int size,
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
@@ -1379,8 +1379,49 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 
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
@@ -1396,12 +1437,25 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
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
@@ -1409,7 +1463,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1584,6 +1640,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
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
@@ -1593,9 +1666,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
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
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 15e25f712f39..0abb714fdbf1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1410,8 +1410,17 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	return 0;
 }
 
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
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
 	free_ppr_log(iommu);
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d4d903a9dc31..ba91c6f8fe1d 100644
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
index d7233f223865..8cd9830b97a3 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -379,8 +379,10 @@ static int mei_me_pci_resume(struct device *device)
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
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 892c10950c81..390caef1bdab 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1376,7 +1376,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 
 	ret = pci_read_config_byte(chip->pdev, 0xAE, &scratch);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * Turn PMOS on [bit 0], set over current detection to 2.4 V
@@ -1387,7 +1387,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 	else
 		scratch &= ~0x47;
 
-	return pci_write_config_byte(chip->pdev, 0xAE, scratch);
+	ret = pci_write_config_byte(chip->pdev, 0xAE, scratch);
+
+fail:
+	return pcibios_err_to_errno(ret);
 }
 
 static int jmicron_probe(struct sdhci_pci_chip *chip)
@@ -2303,7 +2306,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
@@ -2312,7 +2315,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d97451bbd28..4004e4e7b622 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2141,26 +2141,29 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 
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
index f18c6cfe8ff5..a38d0de5f765 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -132,6 +132,105 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2G14AC", 0x20,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD", 0xb5,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4GE4AD", 0xb7,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G14AC", 0xa0,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD", 0xa4,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AD", 0xa6,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AC", 0xa2,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G14AC", 0x90,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1G24AD", 0x94,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AD", 0x96,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AC", 0x92,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static int macronix_spinand_detect(struct spinand_device *spinand)
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
index ba2dc01e0f6b..5b398608f297 100644
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
index f3f2e71431ac..07334f83ccfe 100644
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
index ad0d070f7f17..5f5766b1f3b7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1945,11 +1945,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *net_dev, int n,
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
 
@@ -1959,16 +1962,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
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
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index facbbd3fac66..363c4ab05990 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4433,7 +4433,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 
 		/* Verify if UDP port is being offloaded by HW */
 		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
-			return features;
+			return vxlan_features_check(skb, features);
 
 #if IS_ENABLED(CONFIG_GENEVE)
 		/* Support Geneve offload for default UDP port */
@@ -4454,7 +4454,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
 	features = vlan_features_check(skb, features);
-	features = vxlan_features_check(skb, features);
 
 #ifdef CONFIG_MLX5_EN_IPSEC
 	if (mlx5e_ipsec_feature_check(skb, netdev, features))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 13e86f0b42f5..43e4bc222cfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -337,6 +337,10 @@ int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			return -EACCES;
+		}
 
 		cond_resched();
 	} while (!time_after(jiffies, end));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index f628887d8af8..d4ad0e4192bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -250,6 +250,10 @@ void mlx5_error_sw_reset(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			goto unlock;
+		}
 
 		msleep(20);
 	} while (!time_after(jiffies, end));
@@ -322,6 +326,10 @@ static int mlx5_health_try_recover(struct mlx5_core_dev *dev)
 				      "health recovery flow aborted, PCI reads still not working\n");
 			return -EIO;
 		}
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for PCI\n");
+			return -EACCES;
+		}
 		msleep(100);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 6b774e0c2766..d0b595ba6110 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -74,6 +74,10 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
 			ret = -EBUSY;
 			goto pci_unlock;
 		}
+		if (pci_channel_offline(dev->pdev)) {
+			ret = -EACCES;
+			goto pci_unlock;
+		}
 
 		/* Check if semaphore is already locked */
 		ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index e7d868da6a38..7adad91617d8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -205,10 +205,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
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
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index caaa51a70cbd..d46c2ae817be 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1149,6 +1149,19 @@ static struct phy_driver ksphy_driver[] = {
 	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= kszphy_resume,
+}, {
+	.phy_id		= PHY_ID_LAN8814,
+	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	.name		= "Microchip INDY Gigabit Quad PHY",
+	.driver_data	= &ksz9021_type,
+	.probe		= kszphy_probe,
+	.soft_reset	= genphy_soft_reset,
+	.read_status	= ksz9031_read_status,
+	.get_sset_count	= kszphy_get_sset_count,
+	.get_strings	= kszphy_get_strings,
+	.get_stats	= kszphy_get_stats,
+	.suspend	= genphy_suspend,
+	.resume		= kszphy_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ9131,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -1221,6 +1234,8 @@ static struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_KSZ8081, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8873MLL, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ886X, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9477, MICREL_PHY_ID_MASK },
+	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ }
 };
 
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c6159b521e06..4d86341fc8b4 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -345,7 +345,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 	}
 }
 
@@ -1532,6 +1533,7 @@ static int ax88179_link_reset(struct usbnet *dev)
 			 GMII_PHY_PHYSR, 2, &tmp16);
 
 	if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
+		netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 		return 0;
 	} else if (GMII_PHY_PHYSR_GIGA == (tmp16 & GMII_PHY_PHYSR_SMASK)) {
 		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
@@ -1569,6 +1571,8 @@ static int ax88179_link_reset(struct usbnet *dev)
 
 	netif_carrier_on(dev->net);
 
+	netdev_info(dev->net, "ax88179 - Link status is: 1\n");
+
 	return 0;
 }
 
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 491625c1c308..387091cb9134 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -798,7 +798,8 @@ static int rtl8150_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *ecmd)
 {
 	rtl8150_t *dev = netdev_priv(netdev);
-	short lpa, bmcr;
+	short lpa = 0;
+	short bmcr = 0;
 	u32 supported;
 
 	supported = (SUPPORTED_10baseT_Half |
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4faf3275b1f6..ef8770093c48 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3157,8 +3157,16 @@ static int virtnet_probe(struct virtio_device *vdev)
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
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 8808a6540b19..ce11fb2b0556 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1323,6 +1323,10 @@ static bool vxlan_snoop(struct net_device *dev,
 	struct vxlan_fdb *f;
 	u32 ifindex = 0;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(src_mac))
+		return true;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
 	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 1848b957dc5c..9e63230da1ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1669,8 +1669,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
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
index c5b08a68f6fa..27bd9ed48bec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -197,20 +197,10 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
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
index 428642e66658..c5b48261fae3 100644
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
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d7ab669b1b0d..8f2886ed89d1 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -130,10 +130,8 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 
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
index 64c89b23e99f..deafd229ef8b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2626,6 +2626,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
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
index 44802e501794..1d8324e220fc 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1090,8 +1090,8 @@ static struct pinctrl *create_pinctrl(struct device *dev,
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
index 9388d6fac7d4..7f2e854e0386 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -661,23 +661,68 @@ static  struct rockchip_mux_recalced_data rk3128_mux_recalced_data[] = {
 
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
 
@@ -2190,8 +2235,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 
 	if (ret) {
 		/* revert the already done pin settings */
-		for (cnt--; cnt >= 0; cnt--)
+		for (cnt--; cnt >= 0; cnt--) {
+			bank = pin_to_bank(info, pins[cnt]);
 			rockchip_set_mux(bank, pins[cnt] - bank->pin_base, 0);
+		}
 
 		return ret;
 	}
@@ -3724,7 +3771,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     IOMUX_WIDTH_3BIT,
+			     0,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 87bd6c072ac2..37c4807f15c6 100644
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
index 359b08596d9e..4b20ff6f687b 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -337,6 +337,9 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 
 	prd = div;
 
+	if (!prd)
+		return -EINVAL;
+
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5c50e7add577..a01a769b2f2d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3074,6 +3074,7 @@ struct regmap *regulator_get_regmap(struct regulator *regulator)
 
 	return map ? map : ERR_PTR(-EOPNOTSUPP);
 }
+EXPORT_SYMBOL_GPL(regulator_get_regmap);
 
 /**
  * regulator_get_hardware_vsel_register - get the HW voltage selector register
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 04fa7337cb1e..35c97bc660bd 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7089,6 +7089,12 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
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
@@ -7106,6 +7112,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
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
@@ -7384,6 +7397,12 @@ _base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER *ioc)
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
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 7dbfb4cde124..ea58b4a9404f 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -479,7 +479,7 @@ static const struct uart_ops mcf_uart_ops = {
 	.verify_port	= mcf_verify_port,
 };
 
-static struct mcf_uart mcf_ports[4];
+static struct mcf_uart mcf_ports[10];
 
 #define	MCF_MAXPORTS	ARRAY_SIZE(mcf_ports)
 
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 892e27cddb0f..8fb47f73cc7a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -489,16 +489,28 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 	return false;
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
@@ -533,9 +545,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 
 	mutex_unlock(&s->efr_lock);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -550,7 +563,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 5d41f85a7445..51d42c69fb5e 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1135,6 +1135,7 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
+	struct usb_endpoint_descriptor *in, *out;
 	int ret;
 
 	/* instance init */
@@ -1181,6 +1182,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
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
index 98022584f709..bc925394e881 100644
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
index 1cf4f4bee019..53658162b148 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -827,6 +827,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	int ret = io_data->req->status ? io_data->req->status :
 					 io_data->req->actual;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
+	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
 		mm_segment_t oldfs = get_fs();
@@ -843,7 +844,10 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
 
+	spin_lock_irqsave(&io_data->ffs->eps_lock, flags);
 	usb_ep_free_request(io_data->ep, io_data->req);
+	io_data->req = NULL;
+	spin_unlock_irqrestore(&io_data->ffs->eps_lock, flags);
 
 	if (io_data->read)
 		kfree(io_data->to_free);
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index dd5eb6202fe1..1e9ac31cd9cf 100644
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
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index aa4c21a12de7..c2fa705b230a 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -33,6 +33,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -256,6 +257,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
index 35372f3e3b57..90fb2db48094 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2343,9 +2343,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
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
 		    (ep_ring->err_count++ > MAX_SOFT_RETRY) ||
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
index cfe0b586eadd..3ca8840c663a 100644
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
index 97e50ad89924..23b24ec79527 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1692,6 +1692,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1705,6 +1706,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1721,6 +1723,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_page) {
 		lock_page(bd_page);
+		wait_on_page_writeback(bd_page);
 		clear_page_dirty_for_io(bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6fea3f46a9e3..7294d5b3d80f 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1940,6 +1940,8 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 
 	inode_lock(inode);
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
 	/*
 	 * This prevents concurrent writes on other nodes
 	 */
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index ba574fade6f0..34b84eb299e8 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -558,7 +558,7 @@ static int __ocfs2_mknod_locked(struct inode *dir,
 	fe->i_last_eb_blk = 0;
 	strcpy(fe->i_signature, OCFS2_INODE_SIGNATURE);
 	fe->i_flags |= cpu_to_le32(OCFS2_VALID_FL);
-	ktime_get_real_ts64(&ts);
+	ktime_get_coarse_real_ts64(&ts);
 	fe->i_atime = fe->i_ctime = fe->i_mtime =
 		cpu_to_le64(ts.tv_sec);
 	fe->i_mtime_nsec = fe->i_ctime_nsec = fe->i_atime_nsec =
diff --git a/fs/open.c b/fs/open.c
index 484b300f3e02..f1c2ec6790bb 100644
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
index b1102a31a108..80d904368613 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -374,6 +374,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c4c389c7e1b4..fd4604000669 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -567,7 +567,7 @@ asmlinkage long compat_sys_fstatfs(unsigned int fd,
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
 asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
-asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+asmlinkage long compat_sys_ftruncate(unsigned int, compat_off_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
 asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
 				  int flags, umode_t mode);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6ca3fb2873d7..9246521bd627 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1006,7 +1006,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 75f880c25bb8..416ee6dd2574 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -27,6 +27,7 @@
 #define PHY_ID_KSZ8061		0x00221570
 #define PHY_ID_KSZ9031		0x00221620
 #define PHY_ID_KSZ9131		0x00221640
+#define PHY_ID_LAN8814		0x00221660
 
 #define PHY_ID_KSZ886X		0x00221430
 #define PHY_ID_KSZ8863		0x00221435
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index dd2801c28b99..bdd628c8182f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -69,8 +69,8 @@ enum {
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
index 1cd5caa567cf..7edc6de9e88c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -129,6 +129,15 @@ enum pci_interrupt_pin {
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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 36d57654f178..ba26a905cab1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -422,7 +422,7 @@ asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 				struct statfs64 __user *buf);
 asmlinkage long sys_truncate(const char __user *path, long length);
-asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
+asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
 asmlinkage long sys_truncate64(const char __user *path, loff_t length);
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 26983d26af19..6ba83a54dda7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1451,18 +1451,46 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
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
index cf314ce2fd17..4f77e2f8e1ca 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -467,6 +467,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
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
diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index b0f8e87235bd..14a3aacfca4a 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,17 +20,17 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 576af248a539..2347dda682ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4760,6 +4760,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -4800,11 +4801,23 @@ int perf_event_release_kernel(struct perf_event *event)
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
index 0f8a7af5d591..88e128c1221b 100644
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
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca1eab1..aef4d01c4f61 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1291,7 +1291,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	preempt_disable();
 	pipe_count = p->rtort_pipe_count;
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
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
 
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index d8765c952fab..4692c87d4b69 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -69,4 +69,5 @@ static void __exit preemptirq_delay_exit(void)
 
 module_init(preemptirq_delay_init)
 module_exit(preemptirq_delay_exit)
+MODULE_DESCRIPTION("Preempt / IRQ disable delay thread to test latency tracers");
 MODULE_LICENSE("GPL v2");
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 38613487fb1b..d7e31bec8cb8 100644
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
@@ -1345,6 +1372,8 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		if (hlist_empty(head))
+			continue;
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8709c4506343..2eea802a9cb2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5334,13 +5334,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
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
index 42fb83605d4c..009c5a67cfbd 100644
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
index feb946c954b6..b37465af47e4 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -71,7 +71,7 @@ struct net_dm_hw_entries {
 };
 
 struct per_cpu_dm_data {
-	spinlock_t		lock;	/* Protects 'skb', 'hw_entries' and
+	raw_spinlock_t		lock;	/* Protects 'skb', 'hw_entries' and
 					 * 'send_timer'
 					 */
 	union {
@@ -165,9 +165,9 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
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
@@ -222,7 +222,7 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 
 	local_irq_save(flags);
 	data = this_cpu_ptr(&dm_cpu_data);
-	spin_lock(&data->lock);
+	raw_spin_lock(&data->lock);
 	dskb = data->skb;
 
 	if (!dskb)
@@ -256,7 +256,7 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 	}
 
 out:
-	spin_unlock_irqrestore(&data->lock, flags);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb, void *location)
@@ -315,9 +315,9 @@ net_dm_hw_reset_per_cpu_data(struct per_cpu_dm_data *hw_data)
 		mod_timer(&hw_data->send_timer, jiffies + HZ / 10);
 	}
 
-	spin_lock_irqsave(&hw_data->lock, flags);
+	raw_spin_lock_irqsave(&hw_data->lock, flags);
 	swap(hw_data->hw_entries, hw_entries);
-	spin_unlock_irqrestore(&hw_data->lock, flags);
+	raw_spin_unlock_irqrestore(&hw_data->lock, flags);
 
 	return hw_entries;
 }
@@ -445,7 +445,7 @@ net_dm_hw_summary_probe(struct sk_buff *skb,
 	int i;
 
 	hw_data = this_cpu_ptr(&dm_hw_cpu_data);
-	spin_lock_irqsave(&hw_data->lock, flags);
+	raw_spin_lock_irqsave(&hw_data->lock, flags);
 	hw_entries = hw_data->hw_entries;
 
 	if (!hw_entries)
@@ -474,7 +474,7 @@ net_dm_hw_summary_probe(struct sk_buff *skb,
 	}
 
 out:
-	spin_unlock_irqrestore(&hw_data->lock, flags);
+	raw_spin_unlock_irqrestore(&hw_data->lock, flags);
 }
 
 static const struct net_dm_alert_ops net_dm_alert_summary_ops = {
@@ -1592,7 +1592,7 @@ static struct notifier_block dropmon_net_notifier = {
 
 static void __net_dm_cpu_data_init(struct per_cpu_dm_data *data)
 {
-	spin_lock_init(&data->lock);
+	raw_spin_lock_init(&data->lock);
 	skb_queue_head_init(&data->drop_queue);
 	u64_stats_init(&data->stats.syncp);
 }
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 5827de79610b..c94179d30d42 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -664,11 +664,16 @@ EXPORT_SYMBOL_GPL(__put_net);
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
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 2b68a93adfa8..a8359770fd93 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3172,7 +3172,8 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->getsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
 
@@ -3213,7 +3214,8 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->setsockopt(sk, level, optname, optval, optlen);
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d7ebee3c048d..d0293d051637 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -553,22 +553,27 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
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
 
 	if (!inet_sk(sk)->inet_num && inet_autobind(sk))
 		return -EAGAIN;
-	return sk->sk_prot->connect(sk, uaddr, addr_len);
+	return prot->connect(sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -731,10 +736,11 @@ EXPORT_SYMBOL(inet_stream_connect);
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
 
@@ -815,12 +821,15 @@ ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
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
index 42eaad5e515f..39a6f0d34208 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2015,12 +2015,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
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
index 9a4a3f6d9cb0..a878b8b6e0b9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2258,6 +2258,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2269,7 +2273,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		/* fall through */
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
@@ -3204,8 +3208,9 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, char __user *optval,
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
@@ -3729,8 +3734,9 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
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
index a5fc9444c728..7ee0bfea9de1 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -441,11 +441,14 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
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
@@ -554,6 +557,7 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
+	const struct proto *prot;
 
 	switch (cmd) {
 	case SIOCADDRT:
@@ -568,9 +572,11 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, (void __user *) arg);
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
@@ -582,11 +588,14 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_sendmsg(struct sock *, struct msghdr *,
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
 
@@ -596,13 +605,16 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
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
index 3afc32fe9b07..ef1df9d662d6 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -907,6 +907,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 	if (!fib6_nh->rt6i_pcpu)
 		return;
 
+	rcu_read_lock();
 	/* release the reference to this fib entry from
 	 * all of its cached pcpu routes
 	 */
@@ -915,7 +916,9 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 		struct rt6_info *pcpu_rt;
 
 		ppcpu_rt = per_cpu_ptr(fib6_nh->rt6i_pcpu, cpu);
-		pcpu_rt = *ppcpu_rt;
+
+		/* Paired with xchg() in rt6_get_pcpu_route() */
+		pcpu_rt = READ_ONCE(*ppcpu_rt);
 
 		/* only dropping the 'from' reference if the cached route
 		 * is using 'match'. The cached pcpu_rt->from only changes
@@ -929,6 +932,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 			fib6_info_release(from);
 		}
 	}
+	rcu_read_unlock();
 }
 
 struct fib6_nh_pcpu_arg {
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 86c550d63543..1ceb6de0152f 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -222,8 +222,10 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
@@ -236,7 +238,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
index 3917755351ad..2e91a563139a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -649,6 +649,8 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 	rcu_read_lock_bh();
 	last_probe = READ_ONCE(fib6_nh->last_probe);
 	idev = __in6_dev_get(dev);
+	if (!idev)
+		goto out;
 	neigh = __ipv6_neigh_lookup_noref(dev, nh_gw);
 	if (neigh) {
 		if (neigh->nud_state & NUD_VALID)
@@ -1416,6 +1418,7 @@ static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 		struct rt6_info *prev, **p;
 
 		p = this_cpu_ptr(res->nh->rt6i_pcpu);
+		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
 		prev = xchg(p, NULL);
 		if (prev) {
 			dst_dev_put(&prev->dst);
@@ -3505,7 +3508,7 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	if (!dev)
 		goto out;
 
-	if (idev->cnf.disable_ipv6) {
+	if (!idev || idev->cnf.disable_ipv6) {
 		NL_SET_ERR_MSG(extack, "IPv6 is disabled on nexthop device");
 		err = -EACCES;
 		goto out;
@@ -6141,12 +6144,12 @@ int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
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
index b626e0b62a54..185b9db0b575 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -308,9 +308,8 @@ static int seg6_input(struct sk_buff *skb)
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
 
 	skb_dst_drop(skb);
 
@@ -318,14 +317,13 @@ static int seg6_input(struct sk_buff *skb)
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
@@ -347,9 +345,9 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -369,9 +367,9 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
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
index 7cb622d300aa..81b7ef21180b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -236,7 +236,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		sin.sin_port = usin->sin6_port;
 		sin.sin_addr.s_addr = usin->sin6_addr.s6_addr32[3];
 
-		icsk->icsk_af_ops = &ipv6_mapped;
+		/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+		WRITE_ONCE(icsk->icsk_af_ops, &ipv6_mapped);
 		sk->sk_backlog_rcv = tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		tp->af_specific = &tcp_sock_ipv6_mapped_specific;
@@ -246,7 +247,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
-			icsk->icsk_af_ops = &ipv6_specific;
+			/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+			WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
 			sk->sk_backlog_rcv = tcp_v6_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 			tp->af_specific = &tcp_sock_ipv6_specific;
@@ -1228,7 +1230,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	 */
 
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL, NULL);
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
@@ -1239,6 +1240,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
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
index 8b5b8cc93ff8..f0364649186b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -565,7 +565,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -673,23 +673,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
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
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 7e27e5201c54..55926927c297 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -725,10 +725,23 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
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
index e330036e02ea..67cefa213722 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1326,7 +1326,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	skb_queue_head_init(&pending);
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
-	spin_lock(&sta->ps_lock);
+	spin_lock_bh(&sta->ps_lock);
 	/* Send all buffered frames to the station */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		int count = skb_queue_len(&pending), tmp;
@@ -1355,7 +1355,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	 */
 	clear_sta_flag(sta, WLAN_STA_PSPOLL);
 	clear_sta_flag(sta, WLAN_STA_UAPSD);
-	spin_unlock(&sta->ps_lock);
+	spin_unlock_bh(&sta->ps_lock);
 
 	atomic_dec(&ps->num_sta_ps);
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 544106475d4f..83fa95ecaad4 100644
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
@@ -985,7 +986,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 		if (!list)
 			goto cleanup;
 		/* nfnl mutex is held, both lists are valid */
-		tmp = ip_set_dereference(inst->ip_set_list);
+		tmp = ip_set_dereference(inst);
 		memcpy(list, tmp, sizeof(struct ip_set *) * inst->ip_set_max);
 		rcu_assign_pointer(inst->ip_set_list, list);
 		/* Make sure all current packets have passed through */
@@ -1024,23 +1025,50 @@ ip_set_setname_policy[IPSET_ATTR_CMD_MAX + 1] = {
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
@@ -1056,11 +1084,10 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
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
@@ -1068,8 +1095,6 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 	 * without holding the lock.
 	 */
 	if (!attr[IPSET_ATTR_SETNAME]) {
-		/* Must wait for flush to be really finished in list:set */
-		rcu_barrier();
 		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
@@ -1080,15 +1105,7 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
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
@@ -1107,12 +1124,12 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
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
@@ -2223,30 +2240,25 @@ ip_set_net_init(struct net *net)
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
index 64cc3e2131f3..9f4f0126d6ed 100644
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
index 8131d858f38d..ddbb0f4bff42 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -553,7 +553,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 
 static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
-						   u8 genmask)
+						   int family, u8 genmask)
 {
 	struct nftables_pernet *nft_net;
 	struct nft_table *table;
@@ -561,6 +561,7 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 	nft_net = net_generic(net, nf_tables_net_id);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
+		    table->family == family &&
 		    nft_active_genmask(table, genmask))
 			return table;
 	}
@@ -1243,7 +1244,7 @@ static int nf_tables_deltable(struct net *net, struct sock *nlsk,
 
 	if (nla[NFTA_TABLE_HANDLE]) {
 		attr = nla[NFTA_TABLE_HANDLE];
-		table = nft_table_lookup_byhandle(net, attr, genmask);
+		table = nft_table_lookup_byhandle(net, attr, family, genmask);
 	} else {
 		attr = nla[NFTA_TABLE_NAME];
 		table = nft_table_lookup(net, attr, family, genmask);
@@ -4300,8 +4301,7 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
 	    nft_data_dump(skb, NFTA_SET_ELEM_DATA, nft_set_ext_data(ext),
-			  set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE,
-			  set->dlen) < 0)
+			  nft_set_datatype(set), set->dlen) < 0)
 		goto nla_put_failure;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPR) &&
@@ -8047,6 +8047,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 
 		return 0;
 	default:
+		if (type != NFT_DATA_VALUE)
+			return -EINVAL;
+
 		if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
 			return -EINVAL;
 		if (len == 0)
@@ -8055,8 +8058,6 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		    FIELD_SIZEOF(struct nft_regs, data))
 			return -ERANGE;
 
-		if (data != NULL && type != NFT_DATA_VALUE)
-			return -EINVAL;
 		return 0;
 	}
 }
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 670dd146fb2b..ca268293cfa1 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -33,6 +33,14 @@ static unsigned int optlen(const u8 *opt, unsigned int offset)
 		return opt[offset + 1];
 }
 
+static int nft_skb_copy_to_reg(const struct sk_buff *skb, int offset, u32 *dest, unsigned int len)
+{
+	if (len % NFT_REG32_SIZE)
+		dest[len / NFT_REG32_SIZE] = 0;
+
+	return skb_copy_bits(skb, offset, dest, len);
+}
+
 static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -54,8 +62,7 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -151,8 +158,7 @@ static void nft_exthdr_ipv4_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -208,7 +214,8 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 			*dest = 1;
 		} else {
-			dest[priv->len / NFT_REG32_SIZE] = 0;
+			if (priv->len % NFT_REG32_SIZE)
+				dest[priv->len / NFT_REG32_SIZE] = 0;
 			memcpy(dest, opt + offset, priv->len);
 		}
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index e0ffd463a132..6d49b82d598a 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -98,7 +98,8 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
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
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index db1c0139f99c..52394e45bac5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -479,6 +479,9 @@ EXPORT_SYMBOL(tcf_idr_cleanup);
  * its reference and bind counters, and return 1. Otherwise insert temporary
  * error pointer (to prevent concurrent users from inserting actions with same
  * index) and return 0.
+ *
+ * May return -EAGAIN for binding actions in case of a parallel add/delete on
+ * the requested index.
  */
 
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
@@ -487,43 +490,60 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
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
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 1330ad224931..b822d3e74637 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -186,7 +186,7 @@ static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt->bands = qdisc_dev(sch)->real_num_tx_queues;
 
-	removed = kmalloc(sizeof(*removed) * (q->max_bands - q->bands),
+	removed = kmalloc(sizeof(*removed) * (q->max_bands - qopt->bands),
 			  GFP_KERNEL);
 	if (!removed)
 		return -ENOMEM;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e4c4d23a1b53..7b896be009d5 100644
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
index 4d3cf146f50a..a1aa4f3d7e50 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1849,8 +1849,10 @@ static int gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
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
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e8bad973285e..ae6aae983b8c 100644
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
@@ -449,9 +443,9 @@ static int unix_dgram_peer_wake_me(struct sock *sk, struct sock *other)
 	return 0;
 }
 
-static int unix_writable(const struct sock *sk)
+static int unix_writable(const struct sock *sk, unsigned char state)
 {
-	return sk->sk_state != TCP_LISTEN &&
+	return state != TCP_LISTEN &&
 	       (refcount_read(&sk->sk_wmem_alloc) << 2) <= sk->sk_sndbuf;
 }
 
@@ -460,7 +454,7 @@ static void unix_write_space(struct sock *sk)
 	struct socket_wq *wq;
 
 	rcu_read_lock();
-	if (unix_writable(sk)) {
+	if (unix_writable(sk, READ_ONCE(sk->sk_state))) {
 		wq = rcu_dereference(sk->sk_wq);
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible_sync_poll(&wq->wait,
@@ -807,7 +801,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
 
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
-	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
+	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
@@ -1301,7 +1295,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (other->sk_shutdown & RCV_SHUTDOWN)
 		goto out_unlock;
 
-	if (unix_recvq_full(other)) {
+	if (unix_recvq_full_lockless(other)) {
 		err = -EAGAIN;
 		if (!timeo)
 			goto out_unlock;
@@ -1881,7 +1875,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_err;
 
 	if (msg->msg_namelen) {
-		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
+		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
 		err = -ENOTCONN;
@@ -2083,7 +2077,7 @@ static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err)
 		return err;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	if (msg->msg_namelen)
@@ -2097,7 +2091,7 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	return unix_dgram_recvmsg(sock, msg, size, flags);
@@ -2293,7 +2287,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	size_t size = state->size;
 	unsigned int last_len;
 
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -2579,7 +2573,7 @@ long unix_inq_len(struct sock *sk)
 	struct sk_buff *skb;
 	long amount = 0;
 
-	if (sk->sk_state == TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN)
 		return -EINVAL;
 
 	spin_lock(&sk->sk_receive_queue.lock);
@@ -2678,12 +2672,14 @@ static int unix_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
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
@@ -2699,14 +2695,14 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 
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
@@ -2717,12 +2713,14 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
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
@@ -2739,19 +2737,14 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
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
index 0c7bd1f2c55c..0cd1cb269ab5 100644
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
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index db663e7d17a4..c7f7335bbf86 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -494,6 +494,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
+
 	cpu_np = of_parse_phandle(np, "audio-cpu", 0);
 	/* Give a chance to old DT binding */
 	if (!cpu_np)
@@ -606,7 +608,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		 codec_dev->name);
 
 	/* Initialize sound card */
-	priv->pdev = pdev;
 	priv->card.dev = &pdev->dev;
 	priv->card.name = priv->name;
 	priv->card.dai_link = priv->dai_link;
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 0541071f454b..dc40b5c5d501 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -75,12 +75,16 @@ struct davinci_mcasp_ruledata {
 
 struct davinci_mcasp {
 	struct snd_dmaengine_dai_dma_data dma_data[2];
+	struct davinci_mcasp_pdata *pdata;
 	void __iomem *base;
 	u32 fifo_base;
 	struct device *dev;
 	struct snd_pcm_substream *substreams[2];
 	unsigned int dai_fmt;
 
+	/* Audio can not be enabled due to missing parameter(s) */
+	bool	missing_audio_param;
+
 	/* McASP specific data */
 	int	tdm_slots;
 	u32	tdm_mask[2];
@@ -93,7 +97,6 @@ struct davinci_mcasp {
 	u8	bclk_div;
 	int	streams;
 	u32	irq_request[2];
-	int	dma_request[2];
 
 	int	sysclk_freq;
 	bool	bclk_master;
@@ -1723,50 +1726,58 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
 	return ret;
 }
 
-static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
-						struct platform_device *pdev)
+static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
 {
+#ifdef CONFIG_OF_GPIO
+	if (mcasp->dev->of_node &&
+	    of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
+		return true;
+#endif
+
+	return false;
+}
+
+static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
+				    struct platform_device *pdev)
+{
+	const struct of_device_id *match = of_match_device(mcasp_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct davinci_mcasp_pdata *pdata = NULL;
-	const struct of_device_id *match =
-			of_match_device(mcasp_dt_ids, &pdev->dev);
-	struct of_phandle_args dma_spec;
-
 	const u32 *of_serial_dir32;
 	u32 val;
-	int i, ret = 0;
+	int i;
 
 	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
 		pdata->dismod = DISMOD_LOW;
-		return pdata;
+		goto out;
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
 				     GFP_KERNEL);
-		if (!pdata) {
-			ret = -ENOMEM;
-			return pdata;
-		}
+		if (!pdata)
+			return -ENOMEM;
 	} else {
-		/* control shouldn't reach here. something is wrong */
-		ret = -EINVAL;
-		goto nodata;
+		dev_err(&pdev->dev, "No compatible match found\n");
+		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np, "op-mode", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "op-mode", &val) == 0) {
 		pdata->op_mode = val;
+	} else {
+		mcasp->missing_audio_param = true;
+		goto out;
+	}
 
-	ret = of_property_read_u32(np, "tdm-slots", &val);
-	if (ret >= 0) {
+	if (of_property_read_u32(np, "tdm-slots", &val) == 0) {
 		if (val < 2 || val > 32) {
-			dev_err(&pdev->dev,
-				"tdm-slots must be in rage [2-32]\n");
-			ret = -EINVAL;
-			goto nodata;
+			dev_err(&pdev->dev, "tdm-slots must be in rage [2-32]\n");
+			return -EINVAL;
 		}
 
 		pdata->tdm_slots = val;
+	} else if (pdata->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		mcasp->missing_audio_param = true;
+		goto out;
 	}
 
 	of_serial_dir32 = of_get_property(np, "serial-dir", &val);
@@ -1775,61 +1786,29 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		u8 *of_serial_dir = devm_kzalloc(&pdev->dev,
 						 (sizeof(*of_serial_dir) * val),
 						 GFP_KERNEL);
-		if (!of_serial_dir) {
-			ret = -ENOMEM;
-			goto nodata;
-		}
+		if (!of_serial_dir)
+			return -ENOMEM;
 
 		for (i = 0; i < val; i++)
 			of_serial_dir[i] = be32_to_cpup(&of_serial_dir32[i]);
 
 		pdata->num_serializer = val;
 		pdata->serial_dir = of_serial_dir;
+	} else {
+		mcasp->missing_audio_param = true;
+		goto out;
 	}
 
-	ret = of_property_match_string(np, "dma-names", "tx");
-	if (ret < 0)
-		goto nodata;
-
-	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
-					 &dma_spec);
-	if (ret < 0)
-		goto nodata;
-
-	pdata->tx_dma_channel = dma_spec.args[0];
-
-	/* RX is not valid in DIT mode */
-	if (pdata->op_mode != DAVINCI_MCASP_DIT_MODE) {
-		ret = of_property_match_string(np, "dma-names", "rx");
-		if (ret < 0)
-			goto nodata;
-
-		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
-						 &dma_spec);
-		if (ret < 0)
-			goto nodata;
-
-		pdata->rx_dma_channel = dma_spec.args[0];
-	}
-
-	ret = of_property_read_u32(np, "tx-num-evt", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "tx-num-evt", &val) == 0)
 		pdata->txnumevt = val;
 
-	ret = of_property_read_u32(np, "rx-num-evt", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "rx-num-evt", &val) == 0)
 		pdata->rxnumevt = val;
 
-	ret = of_property_read_u32(np, "sram-size-playback", &val);
-	if (ret >= 0)
-		pdata->sram_size_playback = val;
-
-	ret = of_property_read_u32(np, "sram-size-capture", &val);
-	if (ret >= 0)
-		pdata->sram_size_capture = val;
+	if (of_property_read_u32(np, "auxclk-fs-ratio", &val) == 0)
+		mcasp->auxclk_fs_ratio = val;
 
-	ret = of_property_read_u32(np, "dismod", &val);
-	if (ret >= 0) {
+	if (of_property_read_u32(np, "dismod", &val) == 0) {
 		if (val == 0 || val == 2 || val == 3) {
 			pdata->dismod = DISMOD_VAL(val);
 		} else {
@@ -1840,15 +1819,50 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		pdata->dismod = DISMOD_LOW;
 	}
 
-	return  pdata;
+out:
+	mcasp->pdata = pdata;
+
+	if (mcasp->missing_audio_param) {
+		if (davinci_mcasp_have_gpiochip(mcasp)) {
+			dev_dbg(&pdev->dev, "Missing DT parameter(s) for audio\n");
+			return 0;
+		}
 
-nodata:
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error populating platform data, err %d\n",
-			ret);
-		pdata = NULL;
+		dev_err(&pdev->dev, "Insufficient DT parameter(s)\n");
+		return -ENODEV;
 	}
-	return  pdata;
+
+	mcasp->op_mode = pdata->op_mode;
+	/* sanity check for tdm slots parameter */
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		if (pdata->tdm_slots < 2) {
+			dev_warn(&pdev->dev, "invalid tdm slots: %d\n",
+				 pdata->tdm_slots);
+			mcasp->tdm_slots = 2;
+		} else if (pdata->tdm_slots > 32) {
+			dev_warn(&pdev->dev, "invalid tdm slots: %d\n",
+				 pdata->tdm_slots);
+			mcasp->tdm_slots = 32;
+		} else {
+			mcasp->tdm_slots = pdata->tdm_slots;
+		}
+	}
+
+	mcasp->num_serializer = pdata->num_serializer;
+#ifdef CONFIG_PM
+	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
+						mcasp->num_serializer, sizeof(u32),
+						GFP_KERNEL);
+	if (!mcasp->context.xrsr_regs)
+		return -ENOMEM;
+#endif
+	mcasp->serial_dir = pdata->serial_dir;
+	mcasp->version = pdata->version;
+	mcasp->txnumevt = pdata->txnumevt;
+	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dismod = pdata->dismod;
+
+	return 0;
 }
 
 enum {
@@ -2064,7 +2078,7 @@ static const struct gpio_chip davinci_mcasp_template_chip = {
 
 static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 {
-	if (!of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
+	if (!davinci_mcasp_have_gpiochip(mcasp))
 		return 0;
 
 	mcasp->gpio_chip = davinci_mcasp_template_chip;
@@ -2084,30 +2098,12 @@ static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 }
 #endif /* CONFIG_GPIOLIB */
 
-static int davinci_mcasp_get_dt_params(struct davinci_mcasp *mcasp)
-{
-	struct device_node *np = mcasp->dev->of_node;
-	int ret;
-	u32 val;
-
-	if (!np)
-		return 0;
-
-	ret = of_property_read_u32(np, "auxclk-fs-ratio", &val);
-	if (ret >= 0)
-		mcasp->auxclk_fs_ratio = val;
-
-	return 0;
-}
-
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
-	struct resource *mem, *res, *dat;
-	struct davinci_mcasp_pdata *pdata;
+	struct resource *mem, *dat;
 	struct davinci_mcasp *mcasp;
 	char *irq_name;
-	int *dma;
 	int irq;
 	int ret;
 
@@ -2121,12 +2117,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!mcasp)
 		return	-ENOMEM;
 
-	pdata = davinci_mcasp_set_pdata_from_of(pdev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
 	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!mem) {
 		dev_warn(mcasp->dev,
@@ -2142,44 +2132,25 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (IS_ERR(mcasp->base))
 		return PTR_ERR(mcasp->base);
 
+	dev_set_drvdata(&pdev->dev, mcasp);
 	pm_runtime_enable(&pdev->dev);
 
-	mcasp->op_mode = pdata->op_mode;
-	/* sanity check for tdm slots parameter */
-	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
-		if (pdata->tdm_slots < 2) {
-			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
-				pdata->tdm_slots);
-			mcasp->tdm_slots = 2;
-		} else if (pdata->tdm_slots > 32) {
-			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
-				pdata->tdm_slots);
-			mcasp->tdm_slots = 32;
-		} else {
-			mcasp->tdm_slots = pdata->tdm_slots;
-		}
-	}
-
-	mcasp->num_serializer = pdata->num_serializer;
-#ifdef CONFIG_PM
-	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
-					mcasp->num_serializer, sizeof(u32),
-					GFP_KERNEL);
-	if (!mcasp->context.xrsr_regs) {
-		ret = -ENOMEM;
+	mcasp->dev = &pdev->dev;
+	ret = davinci_mcasp_get_config(mcasp, pdev);
+	if (ret)
 		goto err;
-	}
-#endif
-	mcasp->serial_dir = pdata->serial_dir;
-	mcasp->version = pdata->version;
-	mcasp->txnumevt = pdata->txnumevt;
-	mcasp->rxnumevt = pdata->rxnumevt;
-	mcasp->dismod = pdata->dismod;
 
-	mcasp->dev = &pdev->dev;
+	/* All PINS as McASP */
+	pm_runtime_get_sync(mcasp->dev);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	pm_runtime_put(mcasp->dev);
+
+	/* Skip audio related setup code if the configuration is not adequat */
+	if (mcasp->missing_audio_param)
+		goto no_audio;
 
-	irq = platform_get_irq_byname(pdev, "common");
-	if (irq >= 0) {
+	irq = platform_get_irq_byname_optional(pdev, "common");
+	if (irq > 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
 					  dev_name(&pdev->dev));
 		if (!irq_name) {
@@ -2199,8 +2170,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE] = ROVRN;
 	}
 
-	irq = platform_get_irq_byname(pdev, "rx");
-	if (irq >= 0) {
+	irq = platform_get_irq_byname_optional(pdev, "rx");
+	if (irq > 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx",
 					  dev_name(&pdev->dev));
 		if (!irq_name) {
@@ -2218,8 +2189,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE] = ROVRN;
 	}
 
-	irq = platform_get_irq_byname(pdev, "tx");
-	if (irq >= 0) {
+	irq = platform_get_irq_byname_optional(pdev, "tx");
+	if (irq > 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx",
 					  dev_name(&pdev->dev));
 		if (!irq_name) {
@@ -2242,45 +2213,22 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->dat_port = true;
 
 	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_data->filter_data = "tx";
 	if (dat)
 		dma_data->addr = dat->start;
 	else
-		dma_data->addr = mem->start + davinci_mcasp_txdma_offset(pdata);
+		dma_data->addr = mem->start + davinci_mcasp_txdma_offset(mcasp->pdata);
 
-	dma = &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res)
-		*dma = res->start;
-	else
-		*dma = pdata->tx_dma_channel;
-
-	/* dmaengine filter data for DT and non-DT boot */
-	if (pdev->dev.of_node)
-		dma_data->filter_data = "tx";
-	else
-		dma_data->filter_data = dma;
 
 	/* RX is not valid in DIT mode */
 	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
 		dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+		dma_data->filter_data = "rx";
 		if (dat)
 			dma_data->addr = dat->start;
 		else
 			dma_data->addr =
-				mem->start + davinci_mcasp_rxdma_offset(pdata);
-
-		dma = &mcasp->dma_request[SNDRV_PCM_STREAM_CAPTURE];
-		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-		if (res)
-			*dma = res->start;
-		else
-			*dma = pdata->rx_dma_channel;
-
-		/* dmaengine filter data for DT and non-DT boot */
-		if (pdev->dev.of_node)
-			dma_data->filter_data = "rx";
-		else
-			dma_data->filter_data = dma;
+				mem->start + davinci_mcasp_rxdma_offset(mcasp->pdata);
 	}
 
 	if (mcasp->version < MCASP_VERSION_3) {
@@ -2320,30 +2268,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	dev_set_drvdata(&pdev->dev, mcasp);
-
 	mcasp_reparent_fck(pdev);
 
-	/* All PINS as McASP */
-	pm_runtime_get_sync(mcasp->dev);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
-	pm_runtime_put(mcasp->dev);
-
-	ret = davinci_mcasp_init_gpiochip(mcasp);
-	if (ret)
-		goto err;
-
-	ret = davinci_mcasp_get_dt_params(mcasp);
-	if (ret)
-		return -EINVAL;
-
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					&davinci_mcasp_component,
-					&davinci_mcasp_dai[pdata->op_mode], 1);
-
-	if (ret != 0)
-		goto err;
-
 	ret = davinci_mcasp_get_dma_type(mcasp);
 	switch (ret) {
 	case PCM_EDMA:
@@ -2364,8 +2290,20 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	return 0;
+	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
+					      &davinci_mcasp_dai[mcasp->op_mode], 1);
 
+	if (ret != 0)
+		goto err;
+
+no_audio:
+	ret = davinci_mcasp_init_gpiochip(mcasp);
+	if (ret) {
+		dev_err(&pdev->dev, "gpiochip registration failed: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
 err:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index dcc6a925a03e..a3c9804b3ef1 100644
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
index 3ff236719b6e..c50677721a2e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -31,7 +31,8 @@ find_dot_func() {
 	fi
 
 	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
-		if grep -s $f available_filter_functions; then
+		cnt=`grep -s $f available_filter_functions | wc -l`;
+		if [ $cnt -eq 1 ]; then
 			echo $f
 			break
 		fi
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index bcec71250873..e056cfc487e0 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -32,7 +32,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	FILE *cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -43,7 +43,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -61,14 +61,14 @@ int prereq(void)
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
@@ -77,15 +77,17 @@ int prereq(void)
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
@@ -93,18 +95,23 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
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
 
@@ -113,82 +120,80 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
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
 	unsigned long mem_fragmentable = 0;
 
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
 
 	mem_fragmentable = mem_free * 0.8 / 1024;
 
@@ -224,7 +229,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return 0;
+		return ksft_exit_pass();
 
-	return -1;
+	return ksft_exit_fail();
 }

