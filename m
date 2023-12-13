Return-Path: <stable+bounces-6545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEC810787
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2460A1F21AFA
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C86A5E;
	Wed, 13 Dec 2023 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jOCUB3Vb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363FEB8;
	Wed, 13 Dec 2023 01:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34186C433C8;
	Wed, 13 Dec 2023 01:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702430442;
	bh=OmOuBdXlTmofdiQGAvEYe2YDCxhlyOmbYR7+6VkopwE=;
	h=Date:To:From:Subject:From;
	b=jOCUB3VbIiVqk78WcMTX36nlb5OpGyp+SDEOuPO+R0SIZzZQCX5/nCeN5e8jkzNFN
	 aoK73G7FLrrfKpUi43jiucgJBYaOtL2KLxlXtFLOkhD8TE/HRshTO61SV+0uhJQGmF
	 /AiN287eC4wzoqQVc6tD10aZyam6jsq1g0vXv6FM=
Date: Tue, 12 Dec 2023 17:20:41 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,bhe@redhat.com,agordeev@linux.ibm.com,ignat@cloudflare.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch removed from -mm tree
Message-Id: <20231213012042.34186C433C8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
has been removed from the -mm tree.  Its filename was
     kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
Date: Wed, 29 Nov 2023 22:04:09 +0000

In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
required CONFIG_KEXEC.

However, it was not enough at least for arm64 platforms.  While further
testing the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP
is unavailable in menuconfig.  This is because CONFIG_CRASH_DUMP still
depends on the new CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit
91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec") and on
arm64 CONFIG_ARCH_SUPPORTS_KEXEC requires CONFIG_PM_SLEEP_SMP=y, which in
turn requires either CONFIG_SUSPEND=y or CONFIG_HIBERNATION=y neither of
which are set in our config.

Given that we already established that CONFIG_KEXEC (which is a switch for
kexec system call itself) is not required for CONFIG_CRASH_DUMP drop
CONFIG_ARCH_SUPPORTS_KEXEC dependency as well.  The arm64 kernel builds
just fine with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and
CONFIG_KEXEC_FILE=n after f8ff23429c62 ("kernel/Kconfig.kexec: drop select
of KEXEC for CRASH_DUMP") and this patch are applied given that the
necessary shared bits are included via CONFIG_KEXEC_CORE dependency.

[bhe@redhat.com: don't export some symbols when CONFIG_MMU=n]
  Link: https://lkml.kernel.org/r/ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv
[bhe@redhat.com: riscv, kexec: fix dependency of two items]
  Link: https://lkml.kernel.org/r/ZW04G/SKnhbE5mnX@MiWiFi-R3L-srv
Link: https://lkml.kernel.org/r/20231129220409.55006-1-ignat@cloudflare.com
Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: <stable@vger.kernel.org> # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Cc: <stable@vger.kernel.org> # 6.6+
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/riscv/Kconfig             |    4 ++--
 arch/riscv/kernel/crash_core.c |    4 +++-
 kernel/Kconfig.kexec           |    1 -
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/riscv/Kconfig~kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump
+++ a/arch/riscv/Kconfig
@@ -685,7 +685,7 @@ config RISCV_BOOT_SPINWAIT
 	  If unsure what to do here, say N.
 
 config ARCH_SUPPORTS_KEXEC
-	def_bool MMU
+	def_bool y
 
 config ARCH_SELECTS_KEXEC
 	def_bool y
@@ -693,7 +693,7 @@ config ARCH_SELECTS_KEXEC
 	select HOTPLUG_CPU if SMP
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool 64BIT && MMU
+	def_bool 64BIT
 
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
--- a/arch/riscv/kernel/crash_core.c~kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump
+++ a/arch/riscv/kernel/crash_core.c
@@ -5,18 +5,20 @@
 
 void arch_crash_save_vmcoreinfo(void)
 {
-	VMCOREINFO_NUMBER(VA_BITS);
 	VMCOREINFO_NUMBER(phys_ram_base);
 
 	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+#ifdef CONFIG_MMU
+	VMCOREINFO_NUMBER(VA_BITS);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
 #ifdef CONFIG_64BIT
 	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
 #endif
+#endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
 	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
 						kernel_map.va_kernel_pa_offset);
--- a/kernel/Kconfig.kexec~kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump
+++ a/kernel/Kconfig.kexec
@@ -94,7 +94,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
 	help
_

Patches currently in -mm which might be from ignat@cloudflare.com are



