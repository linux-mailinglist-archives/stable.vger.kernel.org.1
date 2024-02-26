Return-Path: <stable+bounces-23632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A176F867130
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C291F2DC3E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842D1CD2F;
	Mon, 26 Feb 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUJGkPfn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1A1F933
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942860; cv=none; b=rOvfCnmU0rI7+wzj5zwk1+eB3tgg+Sx/X1r3dQ6i7G11kT7DRshXEKrn0r3mLVTe3UdmEQjXYJ8pr0QKcDnDUw/7jnud1OlfjZpnfxi4MHCJuue5lFZPXEsKj+HyrkZwlXPqwFuVDM88FD+iPwMYbC7tGKHdr5+r7wj3k/S/tkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942860; c=relaxed/simple;
	bh=jrTHlPQ/UfqR7Dvaw8zd32KZuTSrXc7mS7Ig8G73LBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RMngcirmU4ynsvXV8HdkWikZhWz0IOlqNYHNCRkLPrp3mQa8+JlF7ZRljzDOBzAUdOFe4yma3p7Fu+AWXmEDhdBtJ2bCbsAeefd6uO6wV6+sQYMRy8hoBQ3onqvjlg0mKDrKVTXsjA3QihTd2fLhj9OcVYZKRzdfI+Dj/v8IZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUJGkPfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A43C433F1;
	Mon, 26 Feb 2024 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942860;
	bh=jrTHlPQ/UfqR7Dvaw8zd32KZuTSrXc7mS7Ig8G73LBI=;
	h=Subject:To:Cc:From:Date:From;
	b=nUJGkPfnhv/lbN2VNQIjaZ9tqeoj5V5Iw1rr4JLAH237RgsOLlTdB5qFVEhHUoQ/I
	 Tp2owKAVT2lVGfXjgmXmJWSQDQf9S9tOykqgb9BBftkL2ffcCDGE5j2PvO3z4q1R8b
	 Vo6p8JT1LYqQvntf3O45QFrxLyrv4ftnzB48CfTc=
Subject: FAILED: patch "[PATCH] LoongArch: Update cpu_sibling_map when disabling nonboot CPUs" failed to apply to 6.1-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:20:57 +0100
Message-ID: <2024022657-dash-dividers-8bff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 752cd08da320a667a833803a8fd6bb266114cce5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022657-dash-dividers-8bff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

752cd08da320 ("LoongArch: Update cpu_sibling_map when disabling nonboot CPUs")
f6f0c9a74a48 ("LoongArch: Add SMT (Simultaneous Multi-Threading) support")
366bb35a8e48 ("LoongArch: Add suspend (ACPI S3) support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 752cd08da320a667a833803a8fd6bb266114cce5 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 23 Feb 2024 14:36:31 +0800
Subject: [PATCH] LoongArch: Update cpu_sibling_map when disabling nonboot CPUs

Update cpu_sibling_map when disabling nonboot CPUs by defining & calling
clear_cpu_sibling_map(), otherwise we get such errors on SMT systems:

jump label: negative count!
WARNING: CPU: 6 PID: 45 at kernel/jump_label.c:263 __static_key_slow_dec_cpuslocked+0xec/0x100
CPU: 6 PID: 45 Comm: cpuhp/6 Not tainted 6.8.0-rc5+ #1340
pc 90000000004c302c ra 90000000004c302c tp 90000001005bc000 sp 90000001005bfd20
a0 000000000000001b a1 900000000224c278 a2 90000001005bfb58 a3 900000000224c280
a4 900000000224c278 a5 90000001005bfb50 a6 0000000000000001 a7 0000000000000001
t0 ce87a4763eb5234a t1 ce87a4763eb5234a t2 0000000000000000 t3 0000000000000000
t4 0000000000000006 t5 0000000000000000 t6 0000000000000064 t7 0000000000001964
t8 000000000009ebf6 u0 9000000001f2a068 s9 0000000000000000 s0 900000000246a2d8
s1 ffffffffffffffff s2 ffffffffffffffff s3 90000000021518c0 s4 0000000000000040
s5 9000000002151058 s6 9000000009828e40 s7 00000000000000b4 s8 0000000000000006
   ra: 90000000004c302c __static_key_slow_dec_cpuslocked+0xec/0x100
  ERA: 90000000004c302c __static_key_slow_dec_cpuslocked+0xec/0x100
 CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
 PRMD: 00000004 (PPLV0 +PIE -PWE)
 EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
 ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
 PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
CPU: 6 PID: 45 Comm: cpuhp/6 Not tainted 6.8.0-rc5+ #1340
Stack : 0000000000000000 900000000203f258 900000000179afc8 90000001005bc000
        90000001005bf980 0000000000000000 90000001005bf988 9000000001fe0be0
        900000000224c280 900000000224c278 90000001005bf8c0 0000000000000001
        0000000000000001 ce87a4763eb5234a 0000000007f38000 90000001003f8cc0
        0000000000000000 0000000000000006 0000000000000000 4c206e6f73676e6f
        6f4c203a656d616e 000000000009ec99 0000000007f38000 0000000000000000
        900000000214b000 9000000001fe0be0 0000000000000004 0000000000000000
        0000000000000107 0000000000000009 ffffffffffafdabe 00000000000000b4
        0000000000000006 90000000004c302c 9000000000224528 00005555939a0c7c
        00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
        ...
Call Trace:
[<9000000000224528>] show_stack+0x48/0x1a0
[<900000000179afc8>] dump_stack_lvl+0x78/0xa0
[<9000000000263ed0>] __warn+0x90/0x1a0
[<90000000017419b8>] report_bug+0x1b8/0x280
[<900000000179c564>] do_bp+0x264/0x420
[<90000000004c302c>] __static_key_slow_dec_cpuslocked+0xec/0x100
[<90000000002b4d7c>] sched_cpu_deactivate+0x2fc/0x300
[<9000000000266498>] cpuhp_invoke_callback+0x178/0x8a0
[<9000000000267f70>] cpuhp_thread_fun+0xf0/0x240
[<90000000002a117c>] smpboot_thread_fn+0x1dc/0x2e0
[<900000000029a720>] kthread+0x140/0x160
[<9000000000222288>] ret_from_kernel_thread+0xc/0xa4

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 87b7190fe48e..aabee0b280fe 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -88,6 +88,73 @@ void show_ipi_list(struct seq_file *p, int prec)
 	}
 }
 
+static inline void set_cpu_core_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_core_setup_map);
+
+	for_each_cpu(i, &cpu_core_setup_map) {
+		if (cpu_data[cpu].package == cpu_data[i].package) {
+			cpumask_set_cpu(i, &cpu_core_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_core_map[i]);
+		}
+	}
+}
+
+static inline void set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
+
+	for_each_cpu(i, &cpu_sibling_setup_map) {
+		if (cpus_are_siblings(cpu, i)) {
+			cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
+		}
+	}
+}
+
+static inline void clear_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	for_each_cpu(i, &cpu_sibling_setup_map) {
+		if (cpus_are_siblings(cpu, i)) {
+			cpumask_clear_cpu(i, &cpu_sibling_map[cpu]);
+			cpumask_clear_cpu(cpu, &cpu_sibling_map[i]);
+		}
+	}
+
+	cpumask_clear_cpu(cpu, &cpu_sibling_setup_map);
+}
+
+/*
+ * Calculate a new cpu_foreign_map mask whenever a
+ * new cpu appears or disappears.
+ */
+void calculate_cpu_foreign_map(void)
+{
+	int i, k, core_present;
+	cpumask_t temp_foreign_map;
+
+	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
+	for_each_online_cpu(i) {
+		core_present = 0;
+		for_each_cpu(k, &temp_foreign_map)
+			if (cpus_are_siblings(i, k))
+				core_present = 1;
+		if (!core_present)
+			cpumask_set_cpu(i, &temp_foreign_map);
+	}
+
+	for_each_online_cpu(i)
+		cpumask_andnot(&cpu_foreign_map[i],
+			       &temp_foreign_map, &cpu_sibling_map[i]);
+}
+
 /* Send mailbox buffer via Mail_Send */
 static void csr_mail_send(uint64_t data, int cpu, int mailbox)
 {
@@ -303,6 +370,7 @@ int loongson_cpu_disable(void)
 	numa_remove_cpu(cpu);
 #endif
 	set_cpu_online(cpu, false);
+	clear_cpu_sibling_map(cpu);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
 	irq_migrate_all_off_this_cpu();
@@ -380,59 +448,6 @@ static int __init ipi_pm_init(void)
 core_initcall(ipi_pm_init);
 #endif
 
-static inline void set_cpu_sibling_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
-
-	for_each_cpu(i, &cpu_sibling_setup_map) {
-		if (cpus_are_siblings(cpu, i)) {
-			cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
-			cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
-		}
-	}
-}
-
-static inline void set_cpu_core_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_core_setup_map);
-
-	for_each_cpu(i, &cpu_core_setup_map) {
-		if (cpu_data[cpu].package == cpu_data[i].package) {
-			cpumask_set_cpu(i, &cpu_core_map[cpu]);
-			cpumask_set_cpu(cpu, &cpu_core_map[i]);
-		}
-	}
-}
-
-/*
- * Calculate a new cpu_foreign_map mask whenever a
- * new cpu appears or disappears.
- */
-void calculate_cpu_foreign_map(void)
-{
-	int i, k, core_present;
-	cpumask_t temp_foreign_map;
-
-	/* Re-calculate the mask */
-	cpumask_clear(&temp_foreign_map);
-	for_each_online_cpu(i) {
-		core_present = 0;
-		for_each_cpu(k, &temp_foreign_map)
-			if (cpus_are_siblings(i, k))
-				core_present = 1;
-		if (!core_present)
-			cpumask_set_cpu(i, &temp_foreign_map);
-	}
-
-	for_each_online_cpu(i)
-		cpumask_andnot(&cpu_foreign_map[i],
-			       &temp_foreign_map, &cpu_sibling_map[i]);
-}
-
 /* Preload SMP state for boot cpu */
 void smp_prepare_boot_cpu(void)
 {


