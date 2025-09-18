Return-Path: <stable+bounces-174305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E03BB362D1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1265B2009B0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DE321457;
	Tue, 26 Aug 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YeRhirXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3527707;
	Tue, 26 Aug 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214037; cv=none; b=N4nskC3lrc1lY4cUEU4Kh1AFaDyIphy5FEVRLjVsbdeOQhvXjO4ihMvDAaFzZKBimqX75aVSJ4NjTZAh+bDWf2o/aHsfIQkauKwedRFH5AKRZtwLzNuM0Uxcu6I+BXIwnxNX2laepaKnWqrpLQYx7YYVi1VRG2KOyx2F1ft/YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214037; c=relaxed/simple;
	bh=0L/yo2uwXtI2iNQheTtcAK5XrWkmV/EWUaxK5Q4A5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnTi1wV3qeHjUKstJu+TNABYKaysfAjyWpppUQbg2pmFoHCE34vqv12MJxI23lIYx1hGwkNKIyvovnxMwJbu/0+C1aswj7xQ6vLbMUhd3moTTqBLAcHyKgdjaL+yRD+6f3WW7fCp20rEByhoQjirBeMgJkbZFq7eIrfx9mRGFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YeRhirXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C287FC4CEF1;
	Tue, 26 Aug 2025 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214037;
	bh=0L/yo2uwXtI2iNQheTtcAK5XrWkmV/EWUaxK5Q4A5aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YeRhirXrXk479DwZqcLmOsUrYoZiMMjUcAQ9XQtcsy/SX8oLmnvGXJseIy2BIPXdr
	 +JbFNSkd/D8E0+f5AeZONYEpUzKoJ9oOI5UEj3pzH97BktIHLSorWvnx40OzwXM2P3
	 0ifHhPIXqM7038VgTCeiORUxXY2VStWV8n7a1bE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kanglong Wang <wangkanglong@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 573/587] LoongArch: Optimize module load time by optimizing PLT/GOT counting
Date: Tue, 26 Aug 2025 13:12:02 +0200
Message-ID: <20250826111007.610661699@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Kanglong Wang <wangkanglong@loongson.cn>

[ Upstream commit 63dbd8fb2af3a89466538599a9acb2d11ef65c06 ]

When enabling CONFIG_KASAN, CONFIG_PREEMPT_VOLUNTARY_BUILD and
CONFIG_PREEMPT_VOLUNTARY at the same time, there will be soft deadlock,
the relevant logs are as follows:

rcu: INFO: rcu_sched self-detected stall on CPU
...
Call Trace:
[<900000000024f9e4>] show_stack+0x5c/0x180
[<90000000002482f4>] dump_stack_lvl+0x94/0xbc
[<9000000000224544>] rcu_dump_cpu_stacks+0x1fc/0x280
[<900000000037ac80>] rcu_sched_clock_irq+0x720/0xf88
[<9000000000396c34>] update_process_times+0xb4/0x150
[<90000000003b2474>] tick_nohz_handler+0xf4/0x250
[<9000000000397e28>] __hrtimer_run_queues+0x1d0/0x428
[<9000000000399b2c>] hrtimer_interrupt+0x214/0x538
[<9000000000253634>] constant_timer_interrupt+0x64/0x80
[<9000000000349938>] __handle_irq_event_percpu+0x78/0x1a0
[<9000000000349a78>] handle_irq_event_percpu+0x18/0x88
[<9000000000354c00>] handle_percpu_irq+0x90/0xf0
[<9000000000348c74>] handle_irq_desc+0x94/0xb8
[<9000000001012b28>] handle_cpu_irq+0x68/0xa0
[<9000000001def8c0>] handle_loongarch_irq+0x30/0x48
[<9000000001def958>] do_vint+0x80/0xd0
[<9000000000268a0c>] kasan_mem_to_shadow.part.0+0x2c/0x2a0
[<90000000006344f4>] __asan_load8+0x4c/0x120
[<900000000025c0d0>] module_frob_arch_sections+0x5c8/0x6b8
[<90000000003895f0>] load_module+0x9e0/0x2958
[<900000000038b770>] __do_sys_init_module+0x208/0x2d0
[<9000000001df0c34>] do_syscall+0x94/0x190
[<900000000024d6fc>] handle_syscall+0xbc/0x158

After analysis, this is because the slow speed of loading the amdgpu
module leads to the long time occupation of the cpu and then the soft
deadlock.

When loading a module, module_frob_arch_sections() tries to figure out
the number of PLTs/GOTs that will be needed to handle all the RELAs. It
will call the count_max_entries() to find in an out-of-order date which
counting algorithm has O(n^2) complexity.

To make it faster, we sort the relocation list by info and addend. That
way, to check for a duplicate relocation, it just needs to compare with
the previous entry. This reduces the complexity of the algorithm to O(n
 log n), as done in commit d4e0340919fb ("arm64/module: Optimize module
load time by optimizing PLT counting"). This gives sinificant reduction
in module load time for modules with large number of relocations.

After applying this patch, the soft deadlock problem has been solved,
and the kernel starts normally without "Call Trace".

Using the default configuration to test some modules, the results are as
follows:

Module              Size
ip_tables           36K
fat                 143K
radeon              2.5MB
amdgpu              16MB

Without this patch:
Module              Module load time (ms)	Count(PLTs/GOTs)
ip_tables           18				59/6
fat                 0				162/14
radeon              54				1221/84
amdgpu              1411			4525/1098

With this patch:
Module              Module load time (ms)	Count(PLTs/GOTs)
ip_tables           18				59/6
fat                 0				162/14
radeon              22				1221/84
amdgpu              45				4525/1098

Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
Signed-off-by: Kanglong Wang <wangkanglong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/module-sections.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index e2f30ff9afde..a43ba7f9f987 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/ftrace.h>
+#include <linux/sort.h>
 
 Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val)
 {
@@ -61,39 +62,38 @@ Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr v
 	return (Elf_Addr)&plt[nr];
 }
 
-static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
-{
-	return x->r_info == y->r_info && x->r_addend == y->r_addend;
-}
+#define cmp_3way(a, b)  ((a) < (b) ? -1 : (a) > (b))
 
-static bool duplicate_rela(const Elf_Rela *rela, int idx)
+static int compare_rela(const void *x, const void *y)
 {
-	int i;
+	int ret;
+	const Elf_Rela *rela_x = x, *rela_y = y;
 
-	for (i = 0; i < idx; i++) {
-		if (is_rela_equal(&rela[i], &rela[idx]))
-			return true;
-	}
+	ret = cmp_3way(rela_x->r_info, rela_y->r_info);
+	if (ret == 0)
+		ret = cmp_3way(rela_x->r_addend, rela_y->r_addend);
 
-	return false;
+	return ret;
 }
 
 static void count_max_entries(Elf_Rela *relas, int num,
 			      unsigned int *plts, unsigned int *gots)
 {
-	unsigned int i, type;
+	unsigned int i;
+
+	sort(relas, num, sizeof(Elf_Rela), compare_rela, NULL);
 
 	for (i = 0; i < num; i++) {
-		type = ELF_R_TYPE(relas[i].r_info);
-		switch (type) {
+		if (i && !compare_rela(&relas[i-1], &relas[i]))
+			continue;
+
+		switch (ELF_R_TYPE(relas[i].r_info)) {
 		case R_LARCH_SOP_PUSH_PLT_PCREL:
 		case R_LARCH_B26:
-			if (!duplicate_rela(relas, i))
-				(*plts)++;
+			(*plts)++;
 			break;
 		case R_LARCH_GOT_PC_HI20:
-			if (!duplicate_rela(relas, i))
-				(*gots)++;
+			(*gots)++;
 			break;
 		default:
 			break; /* Do nothing. */
-- 
2.50.1




