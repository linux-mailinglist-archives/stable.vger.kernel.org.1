Return-Path: <stable+bounces-167044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86481B20BC2
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F959167355
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E922DFB6;
	Mon, 11 Aug 2025 14:22:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945B22DFA6
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922146; cv=none; b=LSqaL5PAhr5+WoAnipd+hNpSCAPenRguPXoYyHpAUNLhBCGnGf6eiKU3r8xay3Sp9aD+pdsyOXx42dGxhBs7lEMBJ+sPw8BgnH0pIGBI6I2IcGjjpMyyWG5MWazc0Ja81mUOZSLVQ8rvej5oplMx1fcl5NYUTg/IAAC+CaAobt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922146; c=relaxed/simple;
	bh=yXeKgYAA8gb4UKWGQ0DYx/R4/HbuqJJIr1ypHV77L7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsuLwwzYmPp4aLMGSpr/35Ax1dAGDUWK/65CzI5rciwa27vpb5etUyzzVotUYS4oTA3nk3jDH6a0h19LpyzASQetttrYCKRODvhM4FnuZi3KIm9RPBfd5JIhgK/kCJWX0v318tuuH0PtMyyFL7LT7BRAroUY6WeiedIfoxiqyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dev-suse (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3ilt5_JloVGvrCg--.50264S2;
	Mon, 11 Aug 2025 22:21:46 +0800 (CST)
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Olof Johansson <olof@lixom.net>,
	Yixun Lan <dlan@gentoo.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Tsukasa OI <research_trasio@irq.a4lg.com>,
	stable@vger.kernel.org,
	Jingwei Wang <wangjingwei@iscas.ac.cn>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v8] riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot
Date: Mon, 11 Aug 2025 22:20:06 +0800
Message-ID: <20250811142035.105820-1-wangjingwei@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3ilt5_JloVGvrCg--.50264S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kr17Wr1ktw4DGFWrAF45trb_yoWDXw4rpF
	Wqkrs5XFZ5JryxCaykKw1kZF10g3Z5Gw13tF4DKry5Zr47Jr13A3sagrsxAr4qyrWv93W0
	vFs0gFWak39rAr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRFkskUUUUU=
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

The hwprobe vDSO data for some keys, like MISALIGNED_VECTOR_PERF,
is determined by an asynchronous kthread. This can create a race
condition where the kthread finishes after the vDSO data has
already been populated, causing userspace to read stale values.

To fix this race, a new 'ready' flag is added to the vDSO data,
initialized to 'false' during arch_initcall_sync. This flag is
checked by both the vDSO's user-space code and the riscv_hwprobe
syscall. The syscall serves as a one-time gate, using a completion
to wait for any pending probes before populating the data and
setting the flag to 'true', thus ensuring userspace reads fresh
values on its first request.

Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Co-developed-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
---
Changes in v8:
	- Based on feedback from Alexandre, reverted the initcall back to
	  arch_initcall_sync since the DO_ONCE logic makes a late init redundant.
	- Added the required Reviewed-by and Signed-off-by tags and fixed minor 
	  formatting nits.

Changes in v7:
	- Refined the on-demand synchronization by using the DO_ONCE_SLEEPABLE
	  macro.
	- Fixed a build error for nommu configs and addressed several coding
	  style issues reported by the CI.

Changes in v6:
	- Based on Palmer's feedback, reworked the synchronization to be on-demand,
	  deferring the wait until the first hwprobe syscall via a 'ready' flag.
	  This avoids the boot-time regression from v5's approach.

Changes in v5:
	- Reworked the synchronization logic to a robust "sentinel-count"
	  pattern based on feedback from Alexandre.
	- Fixed a "multiple definition" linker error for nommu builds by changing
	  the header-file stub functions to `static inline`, as pointed out by Olof.
	- Updated the commit message to better explain the rationale for moving
	  the vDSO initialization to `late_initcall`.

Changes in v4:
	- Reworked the synchronization mechanism based on feedback from Palmer
	  and Alexandre.
	- Instead of a post-hoc refresh, this version introduces a robust
	  completion-based framework using an atomic counter to ensure async
	  probes are finished before populating the vDSO.
	- Moved the vdso data initialization to a late_initcall to avoid
	  impacting boot time.

Changes in v3:
	- Retained existing blank line.

Changes in v2:
	- Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
	- Updated commit message to provide a high-level summary.
	- Added Fixes tag for commit e7c9d66e313b.

v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingwei@iscas.ac.cn/T/#u

 arch/riscv/include/asm/hwprobe.h           |  7 +++
 arch/riscv/include/asm/vdso/arch_data.h    |  6 ++
 arch/riscv/kernel/sys_hwprobe.c            | 70 ++++++++++++++++++----
 arch/riscv/kernel/unaligned_access_speed.c |  9 ++-
 arch/riscv/kernel/vdso/hwprobe.c           |  2 +-
 5 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 7fe0a379474ae2c6..5fe10724d307dc99 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -41,4 +41,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
 	return pair->value == other_pair->value;
 }
 
+#ifdef CONFIG_MMU
+void riscv_hwprobe_register_async_probe(void);
+void riscv_hwprobe_complete_async_probe(void);
+#else
+static inline void riscv_hwprobe_register_async_probe(void) {}
+static inline void riscv_hwprobe_complete_async_probe(void) {}
+#endif
 #endif
diff --git a/arch/riscv/include/asm/vdso/arch_data.h b/arch/riscv/include/asm/vdso/arch_data.h
index da57a3786f7a53c8..88b37af55175129b 100644
--- a/arch/riscv/include/asm/vdso/arch_data.h
+++ b/arch/riscv/include/asm/vdso/arch_data.h
@@ -12,6 +12,12 @@ struct vdso_arch_data {
 
 	/* Boolean indicating all CPUs have the same static hwprobe values. */
 	__u8 homogeneous_cpus;
+
+	/*
+	 * A gate to check and see if the hwprobe data is actually ready, as
+	 * probing is deferred to avoid boot slowdowns.
+	 */
+	__u8 ready;
 };
 
 #endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2beba57..44201160b9c43177 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -5,6 +5,9 @@
  * more details.
  */
 #include <linux/syscalls.h>
+#include <linux/completion.h>
+#include <linux/atomic.h>
+#include <linux/once.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
@@ -452,28 +455,32 @@ static int hwprobe_get_cpus(struct riscv_hwprobe __user *pairs,
 	return 0;
 }
 
-static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
-			    size_t pair_count, size_t cpusetsize,
-			    unsigned long __user *cpus_user,
-			    unsigned int flags)
-{
-	if (flags & RISCV_HWPROBE_WHICH_CPUS)
-		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
-					cpus_user, flags);
+#ifdef CONFIG_MMU
 
-	return hwprobe_get_values(pairs, pair_count, cpusetsize,
-				  cpus_user, flags);
+static DECLARE_COMPLETION(boot_probes_done);
+static atomic_t pending_boot_probes = ATOMIC_INIT(1);
+
+void riscv_hwprobe_register_async_probe(void)
+{
+	atomic_inc(&pending_boot_probes);
 }
 
-#ifdef CONFIG_MMU
+void riscv_hwprobe_complete_async_probe(void)
+{
+	if (atomic_dec_and_test(&pending_boot_probes))
+		complete(&boot_probes_done);
+}
 
-static int __init init_hwprobe_vdso_data(void)
+static int complete_hwprobe_vdso_data(void)
 {
 	struct vdso_arch_data *avd = vdso_k_arch_data;
 	u64 id_bitsmash = 0;
 	struct riscv_hwprobe pair;
 	int key;
 
+	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
+		wait_for_completion(&boot_probes_done);
+
 	/*
 	 * Initialize vDSO data with the answers for the "all CPUs" case, to
 	 * save a syscall in the common case.
@@ -501,13 +508,52 @@ static int __init init_hwprobe_vdso_data(void)
 	 * vDSO should defer to the kernel for exotic cpu masks.
 	 */
 	avd->homogeneous_cpus = id_bitsmash != 0 && id_bitsmash != -1;
+
+	/*
+	 * Make sure all the VDSO values are visible before we look at them.
+	 * This pairs with the implicit "no speculativly visible accesses"
+	 * barrier in the VDSO hwprobe code.
+	 */
+	smp_wmb();
+	avd->ready = true;
+	return 0;
+}
+
+static int __init init_hwprobe_vdso_data(void)
+{
+	struct vdso_arch_data *avd = vdso_k_arch_data;
+
+	/*
+	 * Prevent the vDSO cached values from being used, as they're not ready
+	 * yet.
+	 */
+	avd->ready = false;
 	return 0;
 }
 
 arch_initcall_sync(init_hwprobe_vdso_data);
 
+#else
+
+static int complete_hwprobe_vdso_data(void) { return 0; }
+
 #endif /* CONFIG_MMU */
 
+static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
+			    size_t pair_count, size_t cpusetsize,
+			    unsigned long __user *cpus_user,
+			    unsigned int flags)
+{
+	DO_ONCE_SLEEPABLE(complete_hwprobe_vdso_data);
+
+	if (flags & RISCV_HWPROBE_WHICH_CPUS)
+		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
+					cpus_user, flags);
+
+	return hwprobe_get_values(pairs, pair_count, cpusetsize,
+				cpus_user, flags);
+}
+
 SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
 		size_t, pair_count, size_t, cpusetsize, unsigned long __user *,
 		cpus, unsigned int, flags)
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index ae2068425fbcd207..aa912c62fb70ba0e 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -379,6 +379,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
 {
 	schedule_on_each_cpu(check_vector_unaligned_access);
+	riscv_hwprobe_complete_async_probe();
 
 	return 0;
 }
@@ -473,8 +474,12 @@ static int __init check_unaligned_access_all_cpus(void)
 			per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
 	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
 		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
-		kthread_run(vec_check_unaligned_access_speed_all_cpus,
-			    NULL, "vec_check_unaligned_access_speed_all_cpus");
+		riscv_hwprobe_register_async_probe();
+		if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
+			   NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
+			pr_warn("Failed to create vec_unalign_check kthread\n");
+			riscv_hwprobe_complete_async_probe();
+		}
 	}
 
 	/*
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
index 2ddeba6c68dda09b..bf77b4c1d2d8e803 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -27,7 +27,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
 	 * homogeneous, then this function can handle requests for arbitrary
 	 * masks.
 	 */
-	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus))
+	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus) || unlikely(!avd->ready))
 		return riscv_hwprobe(pairs, pair_count, cpusetsize, cpus, flags);
 
 	/* This is something we can handle, fill out the pairs. */
-- 
2.50.1


