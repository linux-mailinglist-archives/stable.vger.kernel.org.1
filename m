Return-Path: <stable+bounces-160259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB9AFA0A4
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CA6189EB13
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97521898F8;
	Sat,  5 Jul 2025 15:11:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE561FCE
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751728262; cv=none; b=KvnBwzmdSiSjaUHYex03bR3+vnZp/JJAiYh8yAqyT2fYLfO2RPFaULd/pZJGqLx3piQotEvz5mJ+AbxbAEx1II8enugMAyK80F/kzk2Yg47ilaiYNRux4LjtkIi+n+/eHWZArhtz+FawUoNCwyWY2440bEmu2BlBsQSXf4ZPKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751728262; c=relaxed/simple;
	bh=tPDtEea8WOojBqx49kMOzttcKfe+MrHSToUOUdEzVa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8DrJpyEpkVrjEuaaZky7KRCnuvA21WA+BU4jb01zC+nZoDgg9Kgf4FOCFYrgM7sa6OWjszGo4ey8I7E3q/bTFVPna4lKrY15HDfmFZjMdc9qRGos5MSBAnhLzBSAzuwXPBop11/7sHARKQ9xuJzynDFEA+M2txnNnVLP6aK4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dev-suse (unknown [223.72.70.63])
	by APP-01 (Coremail) with SMTP id qwCowAAXBqplQGlo3O5BAQ--.5908S2;
	Sat, 05 Jul 2025 23:10:30 +0800 (CST)
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
Subject: [PATCH v5] riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot
Date: Sat,  5 Jul 2025 23:08:28 +0800
Message-ID: <20250705150952.29461-1-wangjingwei@iscas.ac.cn>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXBqplQGlo3O5BAQ--.5908S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF43ury8KFyfCrykuF4rZrb_yoWxGFWxpF
	WqkrsYqFy5JF4xWa9rKw1kZF10g3Z5Gr43GFsFk345ZryfAr13Jr9aqrsxAr1DtrZYva40
	vF45WFWYk3y2yrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sRE2Q6tUUUUU==
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

The hwprobe vDSO data for some keys, like MISALIGNED_VECTOR_PERF,
is determined by an asynchronous kthread. This can create a race
condition where the kthread finishes after the vDSO data has
already been populated, causing userspace to read stale values.

To fix this, a completion-based framework is introduced to robustly
synchronize the async probes with the vDSO data population. The
waiting function, init_hwprobe_vdso_data(), now blocks on
wait_for_completion() until all probes signal they are done.

Furthermore, to prevent this potential blocking from impacting boot
performance, the initialization is deferred to late_initcall. This
is safe as the data is only required by userspace (which starts
much later) and moves the synchronization delay off the critical
boot path.

Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: stable@vger.kernel.org
Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
---
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

 arch/riscv/include/asm/hwprobe.h           |  8 +++++++-
 arch/riscv/kernel/sys_hwprobe.c            | 20 +++++++++++++++++++-
 arch/riscv/kernel/unaligned_access_speed.c |  9 +++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 7fe0a379474ae2c6..3b2888126e659ea1 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
 
 	return pair->value == other_pair->value;
 }
-
+#ifdef CONFIG_MMU
+void riscv_hwprobe_register_async_probe(void);
+void riscv_hwprobe_complete_async_probe(void);
+#else
+static inline void riscv_hwprobe_register_async_probe(void) {}
+static inline void riscv_hwprobe_complete_async_probe(void) {}
+#endif
 #endif
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2beba57..ee02aeb03e7bd3d8 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -5,6 +5,8 @@
  * more details.
  */
 #include <linux/syscalls.h>
+#include <linux/completion.h>
+#include <linux/atomic.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
@@ -467,6 +469,20 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
 
 #ifdef CONFIG_MMU
 
+static DECLARE_COMPLETION(boot_probes_done);
+static atomic_t pending_boot_probes = ATOMIC_INIT(1);
+
+void riscv_hwprobe_register_async_probe(void)
+{
+	atomic_inc(&pending_boot_probes);
+}
+
+void riscv_hwprobe_complete_async_probe(void)
+{
+	if (atomic_dec_and_test(&pending_boot_probes))
+		complete(&boot_probes_done);
+}
+
 static int __init init_hwprobe_vdso_data(void)
 {
 	struct vdso_arch_data *avd = vdso_k_arch_data;
@@ -474,6 +490,8 @@ static int __init init_hwprobe_vdso_data(void)
 	struct riscv_hwprobe pair;
 	int key;
 
+	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
+		wait_for_completion(&boot_probes_done);
 	/*
 	 * Initialize vDSO data with the answers for the "all CPUs" case, to
 	 * save a syscall in the common case.
@@ -504,7 +522,7 @@ static int __init init_hwprobe_vdso_data(void)
 	return 0;
 }
 
-arch_initcall_sync(init_hwprobe_vdso_data);
+late_initcall(init_hwprobe_vdso_data);
 
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index ae2068425fbcd207..4b8ad2673b0f7470 100644
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
+				NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
+			pr_warn("Failed to create vec_unalign_check kthread\n");
+			riscv_hwprobe_complete_async_probe();
+		}
 	}
 
 	/*
-- 
2.50.0


