Return-Path: <stable+bounces-12846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57F8378A1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C4F1C273B4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91171420D1;
	Tue, 23 Jan 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ySCpBDGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873041420CE;
	Tue, 23 Jan 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968167; cv=none; b=MP1LPAeM2u14LTfZ+EwvnYOGw9ixkMc62F+v3Ep+PSuvFZaD/gUosS4jFOh//dMqxGwvvGF/Xxr8rA9eguBJ1wwa1HwV9U+HTJoXcAK2YxYAcsAST4lA0m+2nAiCcO+UwRk+ny/CYNjm4dC3CfHDxYo7YFfW99WuNoWcNM8xx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968167; c=relaxed/simple;
	bh=Jf5Sa3QmJnYdPi7L9Q4W0QMwlej00mVsgKUW3AVAoZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ+a55j5kG/ZWKOAfszMBh3hcBiLEFzbKstRRRCjcjF+IIh71xPSvr5P69WrcDwssYFvuYZWrBzpUs7wUuj+gnAeAWXsYxM03S/f8yh7aKJqnFVM+3eu8ad7AQr4clSZG/tpJWxcD6F1+NsrReFeZO6CZ/ySjlkZLc2wzTb+z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ySCpBDGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D87FC433C7;
	Tue, 23 Jan 2024 00:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968167;
	bh=Jf5Sa3QmJnYdPi7L9Q4W0QMwlej00mVsgKUW3AVAoZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ySCpBDGMytQQ+2X2Swyp4JuGCDD+vhbf+yjAZVnccg4Ef4SYM3CLLtjZGd07bOoj3
	 zi4ntpMGP9hRXF7K8GdcH91pYw5JqW/+kfHDzTrNpstvO770JJU0m+AVMIJbm9kjo5
	 jAkE+lSZuUc4fnnSZZY+StqYI7fQAEGxUrQs096M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/148] powerpc: remove redundant default n from Kconfig-s
Date: Mon, 22 Jan 2024 15:56:26 -0800
Message-ID: <20240122235713.622834298@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

[ Upstream commit 719736e1cc12b2fc28eba2122893a449eee66d08 ]

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:

        config FOO
                bool

        config FOO
                bool
                default n

    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: 4a74197b65e6 ("powerpc/44x: select I2C for CURRITUCK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig                   | 14 --------------
 arch/powerpc/Kconfig.debug             |  6 ------
 arch/powerpc/platforms/40x/Kconfig     |  9 ---------
 arch/powerpc/platforms/44x/Kconfig     | 22 ----------------------
 arch/powerpc/platforms/82xx/Kconfig    |  1 -
 arch/powerpc/platforms/Kconfig         | 21 ---------------------
 arch/powerpc/platforms/Kconfig.cputype |  4 ----
 arch/powerpc/platforms/cell/Kconfig    |  3 ---
 arch/powerpc/platforms/maple/Kconfig   |  1 -
 arch/powerpc/platforms/pasemi/Kconfig  |  1 -
 arch/powerpc/platforms/powernv/Kconfig |  1 -
 arch/powerpc/platforms/ps3/Kconfig     |  2 --
 arch/powerpc/platforms/pseries/Kconfig |  2 --
 arch/powerpc/sysdev/Kconfig            |  5 -----
 arch/powerpc/sysdev/xive/Kconfig       |  3 ---
 15 files changed, 95 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3be56d857d57..f6279728a416 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -288,12 +288,10 @@ config ARCH_MAY_HAVE_PC_FDC
 
 config PPC_UDBG_16550
 	bool
-	default n
 
 config GENERIC_TBSYNC
 	bool
 	default y if PPC32 && SMP
-	default n
 
 config AUDIT_ARCH
 	bool
@@ -312,13 +310,11 @@ config EPAPR_BOOT
 	bool
 	help
 	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
-	default n
 
 config DEFAULT_UIMAGE
 	bool
 	help
 	  Used to allow a board to specify it wants a uImage built by default
-	default n
 
 config ARCH_HIBERNATION_POSSIBLE
 	bool
@@ -332,11 +328,9 @@ config ARCH_SUSPEND_POSSIBLE
 
 config PPC_DCR_NATIVE
 	bool
-	default n
 
 config PPC_DCR_MMIO
 	bool
-	default n
 
 config PPC_DCR
 	bool
@@ -347,7 +341,6 @@ config PPC_OF_PLATFORM_PCI
 	bool
 	depends on PCI
 	depends on PPC64 # not supported on 32 bits yet
-	default n
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	depends on PPC32 || PPC_BOOK3S_64
@@ -450,14 +443,12 @@ config PPC_TRANSACTIONAL_MEM
        depends on SMP
        select ALTIVEC
        select VSX
-       default n
        ---help---
          Support user-mode Transactional Memory on POWERPC.
 
 config LD_HEAD_STUB_CATCH
 	bool "Reserve 256 bytes to cope with linker stubs in HEAD text" if EXPERT
 	depends on PPC64
-	default n
 	help
 	  Very large kernels can cause linker branch stubs to be generated by
 	  code in head_64.S, which moves the head text sections out of their
@@ -560,7 +551,6 @@ config RELOCATABLE
 config RELOCATABLE_TEST
 	bool "Test relocatable kernel"
 	depends on (PPC64 && RELOCATABLE)
-	default n
 	help
 	  This runs the relocatable kernel at the address it was initially
 	  loaded at, which tends to be non-zero and therefore test the
@@ -772,7 +762,6 @@ config PPC_SUBPAGE_PROT
 
 config PPC_COPRO_BASE
 	bool
-	default n
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -895,7 +884,6 @@ config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
 	default y if 40x || 44x
-	default n
 
 config EISA
 	bool
@@ -992,7 +980,6 @@ source "drivers/pcmcia/Kconfig"
 
 config HAS_RAPIDIO
 	bool
-	default n
 
 config RAPIDIO
 	tristate "RapidIO support"
@@ -1028,7 +1015,6 @@ endmenu
 
 config NONSTATIC_KERNEL
 	bool
-	default n
 
 menu "Advanced setup"
 	depends on PPC32
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 1f54bb93b5cc..356a9e6da385 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -2,7 +2,6 @@
 
 config PPC_DISABLE_WERROR
 	bool "Don't build arch/powerpc code with -Werror"
-	default n
 	help
 	  This option tells the compiler NOT to build the code under
 	  arch/powerpc with the -Werror flag (which means warnings
@@ -56,7 +55,6 @@ config PPC_EMULATED_STATS
 config CODE_PATCHING_SELFTEST
 	bool "Run self-tests of the code-patching code"
 	depends on DEBUG_KERNEL
-	default n
 
 config JUMP_LABEL_FEATURE_CHECKS
 	bool "Enable use of jump label for cpu/mmu_has_feature()"
@@ -70,7 +68,6 @@ config JUMP_LABEL_FEATURE_CHECKS
 config JUMP_LABEL_FEATURE_CHECK_DEBUG
 	bool "Do extra check on feature fixup calls"
 	depends on DEBUG_KERNEL && JUMP_LABEL_FEATURE_CHECKS
-	default n
 	help
 	  This tries to catch incorrect usage of cpu_has_feature() and
 	  mmu_has_feature() in the code.
@@ -80,16 +77,13 @@ config JUMP_LABEL_FEATURE_CHECK_DEBUG
 config FTR_FIXUP_SELFTEST
 	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
-	default n
 
 config MSI_BITMAP_SELFTEST
 	bool "Run self-tests of the MSI bitmap code"
 	depends on DEBUG_KERNEL
-	default n
 
 config PPC_IRQ_SOFT_MASK_DEBUG
 	bool "Include extra checks for powerpc irq soft masking"
-	default n
 
 config XMON
 	bool "Include xmon kernel debugger"
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 60254a321a91..2a9d66254ffc 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -2,7 +2,6 @@
 config ACADIA
 	bool "Acadia"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	select 405EZ
 	help
@@ -11,7 +10,6 @@ config ACADIA
 config EP405
 	bool "EP405/EP405PC"
 	depends on 40x
-	default n
 	select 405GP
 	select PCI
 	help
@@ -20,7 +18,6 @@ config EP405
 config HOTFOOT
         bool "Hotfoot"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	select PCI
         help
@@ -29,7 +26,6 @@ config HOTFOOT
 config KILAUEA
 	bool "Kilauea"
 	depends on 40x
-	default n
 	select 405EX
 	select PPC40x_SIMPLE
 	select PPC4xx_PCI_EXPRESS
@@ -41,7 +37,6 @@ config KILAUEA
 config MAKALU
 	bool "Makalu"
 	depends on 40x
-	default n
 	select 405EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
@@ -62,7 +57,6 @@ config WALNUT
 config XILINX_VIRTEX_GENERIC_BOARD
 	bool "Generic Xilinx Virtex board"
 	depends on 40x
-	default n
 	select XILINX_VIRTEX_II_PRO
 	select XILINX_VIRTEX_4_FX
 	select XILINX_INTC
@@ -80,7 +74,6 @@ config XILINX_VIRTEX_GENERIC_BOARD
 config OBS600
 	bool "OpenBlockS 600"
 	depends on 40x
-	default n
 	select 405EX
 	select PPC40x_SIMPLE
 	help
@@ -90,7 +83,6 @@ config OBS600
 config PPC40x_SIMPLE
 	bool "Simple PowerPC 40x board support"
 	depends on 40x
-	default n
 	help
 	  This option enables the simple PowerPC 40x platform support.
 
@@ -156,7 +148,6 @@ config IBM405_ERR51
 config APM8018X
 	bool "APM8018X"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	help
 	  This option enables support for the AppliedMicro APM8018X evaluation
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index a6011422b861..f024efd5a4c2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -2,7 +2,6 @@
 config PPC_47x
 	bool "Support for 47x variant"
 	depends on 44x
-	default n
 	select MPIC
 	help
 	  This option enables support for the 47x family of processors and is
@@ -11,7 +10,6 @@ config PPC_47x
 config BAMBOO
 	bool "Bamboo"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
@@ -21,7 +19,6 @@ config BAMBOO
 config BLUESTONE
 	bool "Bluestone"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select APM821xx
 	select PCI_MSI
@@ -44,7 +41,6 @@ config EBONY
 config SAM440EP
         bool "Sam440ep"
 	depends on 44x
-        default n
         select 440EP
         select PCI
         help
@@ -53,7 +49,6 @@ config SAM440EP
 config SEQUOIA
 	bool "Sequoia"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EPX
 	help
@@ -62,7 +57,6 @@ config SEQUOIA
 config TAISHAN
 	bool "Taishan"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440GX
 	select PCI
@@ -73,7 +67,6 @@ config TAISHAN
 config KATMAI
 	bool "Katmai"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440SPe
 	select PCI
@@ -86,7 +79,6 @@ config KATMAI
 config RAINIER
 	bool "Rainier"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440GRX
 	select PCI
@@ -96,7 +88,6 @@ config RAINIER
 config WARP
 	bool "PIKA Warp"
 	depends on 44x
-	default n
 	select 440EP
 	help
 	  This option enables support for the PIKA Warp(tm) Appliance. The Warp
@@ -109,7 +100,6 @@ config WARP
 config ARCHES
 	bool "Arches"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
@@ -120,7 +110,6 @@ config ARCHES
 config CANYONLANDS
 	bool "Canyonlands"
 	depends on 44x
-	default n
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
@@ -134,7 +123,6 @@ config CANYONLANDS
 config GLACIER
 	bool "Glacier"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
@@ -147,7 +135,6 @@ config GLACIER
 config REDWOOD
 	bool "Redwood"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460SX
 	select PCI
@@ -160,7 +147,6 @@ config REDWOOD
 config EIGER
 	bool "Eiger"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460SX
 	select PCI
@@ -172,7 +158,6 @@ config EIGER
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
@@ -182,7 +167,6 @@ config YOSEMITE
 config ISS4xx
 	bool "ISS 4xx Simulator"
 	depends on (44x || 40x)
-	default n
 	select 405GP if 40x
 	select 440GP if 44x && !PPC_47x
 	select PPC_FPU
@@ -193,7 +177,6 @@ config ISS4xx
 config CURRITUCK
 	bool "IBM Currituck (476fpe) Support"
 	depends on PPC_47x
-	default n
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
@@ -203,7 +186,6 @@ config CURRITUCK
 config FSP2
 	bool "IBM FSP2 (476fpe) Support"
 	depends on PPC_47x
-	default n
 	select 476FPE
 	select IBM_EMAC_EMAC4 if IBM_EMAC
 	select IBM_EMAC_RGMII if IBM_EMAC
@@ -215,7 +197,6 @@ config FSP2
 config AKEBONO
 	bool "IBM Akebono (476gtr) Support"
 	depends on PPC_47x
-	default n
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
@@ -241,7 +222,6 @@ config AKEBONO
 config ICON
 	bool "Icon"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440SPe
 	select PCI
@@ -252,7 +232,6 @@ config ICON
 config XILINX_VIRTEX440_GENERIC_BOARD
 	bool "Generic Xilinx Virtex 5 FXT board support"
 	depends on 44x
-	default n
 	select XILINX_VIRTEX_5_FXT
 	select XILINX_INTC
 	help
@@ -280,7 +259,6 @@ config XILINX_ML510
 config PPC44x_SIMPLE
 	bool "Simple PowerPC 44x board support"
 	depends on 44x
-	default n
 	help
 	  This option enables the simple PowerPC 44x platform support.
 
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 6e04099361b9..1947a88bc69f 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -51,7 +51,6 @@ endif
 
 config PQ2ADS
 	bool
-	default n
 
 config 8260
 	bool
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 9914544e6677..1002d4752646 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -23,7 +23,6 @@ source "arch/powerpc/platforms/amigaone/Kconfig"
 
 config KVM_GUEST
 	bool "KVM Guest support"
-	default n
 	select EPAPR_PARAVIRT
 	---help---
 	  This option enables various optimizations for running under the KVM
@@ -34,7 +33,6 @@ config KVM_GUEST
 
 config EPAPR_PARAVIRT
 	bool "ePAPR para-virtualization support"
-	default n
 	help
 	  Enables ePAPR para-virtualization support for guests.
 
@@ -74,7 +72,6 @@ config PPC_DT_CPU_FTRS
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
 	depends on PPC_RTAS
-	default n
 
 config PPC_SMP_MUXED_IPI
 	bool
@@ -86,16 +83,13 @@ config PPC_SMP_MUXED_IPI
 
 config IPIC
 	bool
-	default n
 
 config MPIC
 	bool
-	default n
 
 config MPIC_TIMER
 	bool "MPIC Global Timer"
 	depends on MPIC && FSL_SOC
-	default n
 	help
 	  The MPIC global timer is a hardware timer inside the
 	  Freescale PIC complying with OpenPIC standard. When the
@@ -107,7 +101,6 @@ config MPIC_TIMER
 config FSL_MPIC_TIMER_WAKEUP
 	tristate "Freescale MPIC global timer wakeup driver"
 	depends on FSL_SOC &&  MPIC_TIMER && PM
-	default n
 	help
 	  The driver provides a way to wake up the system by MPIC
 	  timer.
@@ -115,43 +108,35 @@ config FSL_MPIC_TIMER_WAKEUP
 
 config PPC_EPAPR_HV_PIC
 	bool
-	default n
 	select EPAPR_PARAVIRT
 
 config MPIC_WEIRD
 	bool
-	default n
 
 config MPIC_MSGR
 	bool "MPIC message register support"
 	depends on MPIC
-	default n
 	help
 	  Enables support for the MPIC message registers.  These
 	  registers are used for inter-processor communication.
 
 config PPC_I8259
 	bool
-	default n
 
 config U3_DART
 	bool
 	depends on PPC64
-	default n
 
 config PPC_RTAS
 	bool
-	default n
 
 config RTAS_ERROR_LOGGING
 	bool
 	depends on PPC_RTAS
-	default n
 
 config PPC_RTAS_DAEMON
 	bool
 	depends on PPC_RTAS
-	default n
 
 config RTAS_PROC
 	bool "Proc interface to RTAS"
@@ -164,11 +149,9 @@ config RTAS_FLASH
 
 config MMIO_NVRAM
 	bool
-	default n
 
 config MPIC_U3_HT_IRQS
 	bool
-	default n
 
 config MPIC_BROKEN_REGREAD
 	bool
@@ -187,15 +170,12 @@ config EEH
 
 config PPC_MPC106
 	bool
-	default n
 
 config PPC_970_NAP
 	bool
-	default n
 
 config PPC_P7_NAP
 	bool
-	default n
 
 config PPC_INDIRECT_PIO
 	bool
@@ -289,7 +269,6 @@ config CPM2
 
 config FSL_ULI1575
 	bool
-	default n
 	select GENERIC_ISA_DMA
 	help
 	  Supports for the ULI1575 PCIe south bridge that exists on some
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 67ad128a9a3d..287054778b07 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC64
 	bool "64-bit kernel"
-	default n
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
@@ -368,7 +367,6 @@ config PPC_MM_SLICES
 	bool
 	default y if PPC_BOOK3S_64
 	default y if PPC_8xx && HUGETLB_PAGE
-	default n
 
 config PPC_HAVE_PMU_SUPPORT
        bool
@@ -382,7 +380,6 @@ config PPC_PERF_CTRS
 config FORCE_SMP
 	# Allow platforms to force SMP=y by selecting this
 	bool
-	default n
 	select SMP
 
 config SMP
@@ -423,7 +420,6 @@ config CHECK_CACHE_COHERENCY
 
 config PPC_DOORBELL
 	bool
-	default n
 
 endmenu
 
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 741a8fa8a3e6..3ad42075f1f4 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_CELL
 	bool
-	default n
 
 config PPC_CELL_COMMON
 	bool
@@ -22,7 +21,6 @@ config PPC_CELL_NATIVE
 	select IBM_EMAC_RGMII if IBM_EMAC
 	select IBM_EMAC_ZMII if IBM_EMAC #test only
 	select IBM_EMAC_TAH if IBM_EMAC  #test only
-	default n
 
 config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
@@ -55,7 +53,6 @@ config SPU_FS
 
 config SPU_BASE
 	bool
-	default n
 	select PPC_COPRO_BASE
 
 config CBE_RAS
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
index 376d0be36b66..2601fac50354 100644
--- a/arch/powerpc/platforms/maple/Kconfig
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -13,7 +13,6 @@ config PPC_MAPLE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select ATA_NONSTANDARD if ATA
-	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
 	  For more information, refer to <http://www.970eval.com>
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index d458a791d35b..98e3bc22bebc 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -2,7 +2,6 @@
 config PPC_PASEMI
 	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "PA Semi SoC-based platforms"
-	default n
 	select MPIC
 	select PCI
 	select PPC_UDBG_16550
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index f8dc98d3dc01..05ee7b65d40f 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -35,7 +35,6 @@ config OPAL_PRD
 config PPC_MEMTRACE
 	bool "Enable removal of RAM from kernel mappings for tracing"
 	depends on PPC_POWERNV && MEMORY_HOTREMOVE
-	default n
 	help
 	  Enabling this option allows for the removal of memory (RAM)
 	  from the kernel mappings to be used for hardware tracing.
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 6f7525555b19..24864b8aaf5d 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -49,7 +49,6 @@ config PS3_HTAB_SIZE
 config PS3_DYNAMIC_DMA
 	depends on PPC_PS3
 	bool "PS3 Platform dynamic DMA page table management"
-	default n
 	help
 	  This option will enable kernel support to take advantage of the
 	  per device dynamic DMA page table management provided by the Cell
@@ -89,7 +88,6 @@ config PS3_SYS_MANAGER
 config PS3_REPOSITORY_WRITE
 	bool "PS3 Repository write support" if PS3_ADVANCED
 	depends on PPC_PS3
-	default n
 	help
 	  Enables support for writing to the PS3 System Repository.
 
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 0c698fd6d491..39032d9b316c 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -28,7 +28,6 @@ config PPC_PSERIES
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
-	default n
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
@@ -99,7 +98,6 @@ config PPC_SMLPAR
 	bool "Support for shared-memory logical partitions"
 	depends on PPC_PSERIES
 	select LPARCFG
-	default n
 	help
 	  Select this option to enable shared memory partition support.
 	  With this option a system running in an LPAR can be given more
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index bcef2ac56479..e0dbec780fe9 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,19 +6,16 @@
 config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
-	default n
 
 config PPC4xx_HSTA_MSI
 	bool
 	depends on PCI_MSI
 	depends on PCI && 4xx
-	default n
 
 config PPC4xx_MSI
 	bool
 	depends on PCI_MSI
 	depends on PCI && 4xx
-	default n
 
 config PPC_MSI_BITMAP
 	bool
@@ -37,11 +34,9 @@ config PPC_SCOM
 config SCOM_DEBUGFS
 	bool "Expose SCOM controllers via debugfs"
 	depends on PPC_SCOM && DEBUG_FS
-	default n
 
 config GE_FPGA
 	bool
-	default n
 
 config FSL_CORENET_RCPM
 	bool
diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
index 70ee976e1de0..785c292d104b 100644
--- a/arch/powerpc/sysdev/xive/Kconfig
+++ b/arch/powerpc/sysdev/xive/Kconfig
@@ -1,17 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_XIVE
 	bool
-	default n
 	select PPC_SMP_MUXED_IPI
 	select HARDIRQS_SW_RESEND
 
 config PPC_XIVE_NATIVE
 	bool
-	default n
 	select PPC_XIVE
 	depends on PPC_POWERNV
 
 config PPC_XIVE_SPAPR
 	bool
-	default n
 	select PPC_XIVE
-- 
2.43.0




