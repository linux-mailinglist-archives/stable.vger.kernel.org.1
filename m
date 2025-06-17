Return-Path: <stable+bounces-154572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C7ADDC80
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B011189DA8A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BAF28B4EF;
	Tue, 17 Jun 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOruS72u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7C2063E7
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189136; cv=none; b=Leq4Q1GdUOmx7Lx3BcHSpspGBc1VPFbKojgm/NdHT02bM89020lqwkH3GmDhNawgt+DmN2Sfy4Vl3TDwMjDPAW6e4aSLpSZg6Nj6lK6gcNyTsWSDwMmA6Se2uts+idAzsN5iAmzlsA04QPCxCeq1gqLrTpOYui7iMvildfirMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189136; c=relaxed/simple;
	bh=uF2mLZ0S/smZ4TcyhKqa7VUUo+LqGV1tE+Uxr9jm72k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrnjuta1+o+qXgKs9V8QsYbBoNpF41Q65mwdG78aGTt5F8+Ew0ajbjjrVUJ1XKeLU9KvoE+JbGsmVpVNk6pivMaGZmsRcuv8utb13QW6ZPi9Pb7vCC3xBV1KXRxR7mh1MlrDcnQ1i+O4W2v7RpNhQbsWUdznpfQltNAk8RM3Sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOruS72u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88363C4CEF0;
	Tue, 17 Jun 2025 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750189135;
	bh=uF2mLZ0S/smZ4TcyhKqa7VUUo+LqGV1tE+Uxr9jm72k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOruS72u03LjF30kcoxlXp5pswKoVV3lpE5fnqOp0FHuEezxmkWqf3bNEQOM1qkUS
	 M+YjsBZ9f1+Zt4qtyG9//TqrW/mpf0doXyeQwfa/KXzKy2kwI9JEbV52IEw8d/PING
	 rDhsplZIonFd3170BoPusSPOPQ8EQayVm0BKufEyc5xyBEt2hPFOFuiKTFUnf1ygfp
	 BZmzHpGYdSldIjOTJ5FUTAzN4yy0vlRKmHTlMuVamHQF8b5v525Y9w7QCodGTIlZp6
	 cjncLgn82Xef/UgXpU1HOo6VSu5XRh+Q983bYapqQPWgOLlf+UMuhlG8dMeXx3t1Me
	 O8WpZgtH/pRJA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 6.6.y 1/2] scripts: clean up IA-64 code
Date: Tue, 17 Jun 2025 15:38:52 -0400
Message-ID: <20250617193853.388270-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2024021932-lavish-expel-58e5@gregkh>
References: <2024021932-lavish-expel-58e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 0df8e97085946dd79c06720678a845778b6d6bf8 ]

A little more janitorial work after commit cf8e8658100d ("arch: Remove
Itanium (IA-64) architecture").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 scripts/checkstack.pl        |  3 ---
 scripts/gdb/linux/tasks.py   | 15 +++------------
 scripts/head-object-list.txt |  1 -
 scripts/kconfig/mconf.c      |  2 +-
 scripts/kconfig/nconf.c      |  2 +-
 scripts/package/kernel.spec  |  6 ------
 scripts/package/mkdebian     |  2 +-
 scripts/recordmcount.c       |  1 -
 scripts/recordmcount.pl      |  7 -------
 scripts/xz_wrap.sh           |  1 -
 10 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index f27d552aec43..aad423c5181a 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -68,9 +68,6 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		#    2f60:    48 81 ec e8 05 00 00       sub    $0x5e8,%rsp
 		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%(e|r)sp$/o;
 		$dre = qr/^.*[as][du][db]    (%.*),\%(e|r)sp$/o;
-	} elsif ($arch eq 'ia64') {
-		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
-		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
 	} elsif ($arch eq 'm68k') {
 		#    2b6c:       4e56 fb70       linkw %fp,#-1168
 		#  1df770:       defc ffe4       addaw #-28,%sp
diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index 17ec19e9b5bf..5be53b372a69 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -86,21 +86,12 @@ LxPs()
 
 thread_info_type = utils.CachedType("struct thread_info")
 
-ia64_task_size = None
-
 
 def get_thread_info(task):
     thread_info_ptr_type = thread_info_type.get_type().pointer()
-    if utils.is_target_arch("ia64"):
-        global ia64_task_size
-        if ia64_task_size is None:
-            ia64_task_size = gdb.parse_and_eval("sizeof(struct task_struct)")
-        thread_info_addr = task.address + ia64_task_size
-        thread_info = thread_info_addr.cast(thread_info_ptr_type)
-    else:
-        if task.type.fields()[0].type == thread_info_type.get_type():
-            return task['thread_info']
-        thread_info = task['stack'].cast(thread_info_ptr_type)
+    if task.type.fields()[0].type == thread_info_type.get_type():
+        return task['thread_info']
+    thread_info = task['stack'].cast(thread_info_ptr_type)
     return thread_info.dereference()
 
 
diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index 26359968744e..890f69005bab 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -17,7 +17,6 @@ arch/arm/kernel/head-nommu.o
 arch/arm/kernel/head.o
 arch/csky/kernel/head.o
 arch/hexagon/kernel/head.o
-arch/ia64/kernel/head.o
 arch/loongarch/kernel/head.o
 arch/m68k/68000/head.o
 arch/m68k/coldfire/head.o
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index eccc87a441e7..3795c36a9181 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -247,7 +247,7 @@ search_help[] =
 	"      -> PCI support (PCI [=y])\n"
 	"(1)     -> PCI access mode (<choice> [=y])\n"
 	"  Defined at drivers/pci/Kconfig:47\n"
-	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC\n"
 	"  Selects: LIBCRC32\n"
 	"  Selected by: BAR [=n]\n"
 	"-----------------------------------------------------------------\n"
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 143a2c351d57..8cd72fe25974 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -216,7 +216,7 @@ search_help[] =
 "Symbol: FOO [ = m]\n"
 "Prompt: Foo bus is used to drive the bar HW\n"
 "Defined at drivers/pci/Kconfig:47\n"
-"Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+"Depends on: X86_LOCAL_APIC && X86_IO_APIC\n"
 "Location:\n"
 "  -> Bus options (PCI, PCMCIA, EISA, ISA)\n"
 "    -> PCI support (PCI [ = y])\n"
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..89298983a169 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -56,13 +56,7 @@ patch -p1 < %{SOURCE2}
 
 %install
 mkdir -p %{buildroot}/boot
-%ifarch ia64
-mkdir -p %{buildroot}/boot/efi
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
-ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
-%else
 cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
-%endif
 %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 5044224cf671..c1a36da85e84 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -26,7 +26,7 @@ set_debarch() {
 
 	# Attempt to find the correct Debian architecture
 	case "$UTS_MACHINE" in
-	i386|ia64|alpha|m68k|riscv*)
+	i386|alpha|m68k|riscv*)
 		debarch="$UTS_MACHINE" ;;
 	x86_64)
 		debarch=amd64 ;;
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 40ae6b2c7a6d..3e4f54799cc0 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -590,7 +590,6 @@ static int do_file(char const *const fname)
 		ideal_nop = ideal_nop4_arm64;
 		is_fake_mcount64 = arm64_is_fake_mcount;
 		break;
-	case EM_IA_64:	reltype = R_IA64_IMM64; break;
 	case EM_MIPS:	/* reltype: e_class    */ break;
 	case EM_LOONGARCH:	/* reltype: e_class    */ break;
 	case EM_PPC:	reltype = R_PPC_ADDR32; break;
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 6a4645a57976..f84df9e383fd 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -275,13 +275,6 @@ if ($arch eq "x86_64") {
     $section_type = '%progbits';
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_AARCH64_CALL26\\s+_mcount\$";
     $type = ".quad";
-} elsif ($arch eq "ia64") {
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-    $type = "data8";
-
-    if ($is_module eq "0") {
-	$cc .= " -mconstant-gp";
-    }
 } elsif ($arch eq "sparc64") {
     # In the objdump output there are giblets like:
     # 0000000000000000 <igmp_net_exit-0x18>:
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index 76e9cbcfbeab..d06baf626abe 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -15,7 +15,6 @@ LZMA2OPTS=
 case $SRCARCH in
 	x86)            BCJ=--x86 ;;
 	powerpc)        BCJ=--powerpc ;;
-	ia64)           BCJ=--ia64; LZMA2OPTS=pb=4 ;;
 	arm)            BCJ=--arm ;;
 	sparc)          BCJ=--sparc ;;
 esac
-- 
2.49.0


