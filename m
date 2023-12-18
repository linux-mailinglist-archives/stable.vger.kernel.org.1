Return-Path: <stable+bounces-7391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5424817254
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6276028355A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363942384;
	Mon, 18 Dec 2023 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tc9PW+BL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2AD37860;
	Mon, 18 Dec 2023 14:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB516C433C7;
	Mon, 18 Dec 2023 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908345;
	bh=JXLGUQ/Fxw1p+M3nYT0Wjsc8QimF82Rq7ARfb/z3/bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc9PW+BLFJLTnatTgRDtPwciZH3ahPOtRvt85ek5kqh+XKJQ7uPtIqD2tnTE7oV/1
	 zNQpde0zfGDqYwGtnIHv1FAyidsr3cMlFgIv77yLENPk+UrraGo5wjNGv0gzBLb5v9
	 G0D9BacWP47aeqgDs1GWWyWZu6upCkSkemEUehjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ignat Korchagin <ignat@cloudflare.com>,
	Baoquan He <bhe@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 142/166] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
Date: Mon, 18 Dec 2023 14:51:48 +0100
Message-ID: <20231218135111.465433417@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

From: Ignat Korchagin <ignat@cloudflare.com>

commit c41bd2514184d75db087fe4c1221237fb7922875 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Kconfig             |    4 ++--
 arch/riscv/kernel/crash_core.c |    4 +++-
 kernel/Kconfig.kexec           |    1 -
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -669,7 +669,7 @@ config RISCV_BOOT_SPINWAIT
 	  If unsure what to do here, say N.
 
 config ARCH_SUPPORTS_KEXEC
-	def_bool MMU
+	def_bool y
 
 config ARCH_SELECTS_KEXEC
 	def_bool y
@@ -677,7 +677,7 @@ config ARCH_SELECTS_KEXEC
 	select HOTPLUG_CPU if SMP
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool 64BIT && MMU
+	def_bool 64BIT
 
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
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
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,7 +94,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
 	help



