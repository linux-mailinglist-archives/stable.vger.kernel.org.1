Return-Path: <stable+bounces-155009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CBBAE168E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC1D17D0C4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183723ABA3;
	Fri, 20 Jun 2025 08:44:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD11235048
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409043; cv=none; b=taxxV+DMKSNtUt/gVBCsdt/Ne0YjF0PiLXDAxNRF+RFqegXTHzZSdNoX8p2W+slHsuE8lltc40NPtQPkomn0s2cL/ZwT2LX4Tt7ns8Nd7Dhtz4GWlmnRWhe5bKM5RGqZQu55vK6ohO9WJKlOdRr43R4ZMBVy0Yg+3PSOAy2YJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409043; c=relaxed/simple;
	bh=zsC/JIIOpJrKx6P2RAUN/GEPsiry2hOOR4Vx0VGBV8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPJqv1FSG+reBXGgTww+WhPluyzN9eivrwYHCeNsJ50DMwvu+nwIGoZtinbtsSV82ooQLQfkC4qg8Q8q6Kgh7vj2bD7z8ssJsyl3E4ehX2ceyn9t26MJ90KUHOUsJ/Dd6pvwE6ZeY5suad58qcIEvsqZfODivVXO+wfkLxHEM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [198.18.0.1] (unknown [223.104.40.26])
	by APP-03 (Coremail) with SMTP id rQCowAD3R1A5H1VoYa65Bw--.3280S2;
	Fri, 20 Jun 2025 16:43:38 +0800 (CST)
Message-ID: <da8bcae6-a6e2-4da2-8547-08ed2e35c55f@iscas.ac.cn>
Date: Fri, 20 Jun 2025 16:43:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 Alexandre Ghiti <alex@ghiti.fr>, ajones@ventanamicro.com,
 Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
 Charlie Jenkins <charlie@rivosinc.com>, jesse@rivosinc.com, dlan@gentoo.org,
 si.yanteng@linux.dev, research_trasio@irq.a4lg.com, stable@vger.kernel.org
References: <mhng-FC7E1D2C-D4E1-490E-9363-508518B62FE5@palmerdabbelt-mac>
Content-Language: en-US
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
In-Reply-To: <mhng-FC7E1D2C-D4E1-490E-9363-508518B62FE5@palmerdabbelt-mac>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3R1A5H1VoYa65Bw--.3280S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4xGr4fAF45ury3Xw1kKrg_yoW7KFyxpF
	WDCrsYqFW5Jr4xWa4UKw1kXFy0qas5Gw43GFn2k3y5Zr17Jryaqr9aqrs2vrn8CrWvvw1r
	Ar4YgFW5Zw42yF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkQB_DUUUU
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/


Hi Palmer,
On 2025/6/11 06:25, Palmer Dabbelt wrote:
> On Wed, 28 May 2025 07:28:19 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
>> The riscv_hwprobe vDSO data is populated by init_hwprobe_vdso_data(),
>> an arch_initcall_sync. However, underlying data for some keys, like
>> RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF, is determined asynchronously.
>>
>> Specifically, the per_cpu(vector_misaligned_access, cpu) values are set
>> by the vec_check_unaligned_access_speed_all_cpus kthread. This kthread
>> is spawned by an earlier arch_initcall (check_unaligned_access_all_cpus)
>> and may complete its benchmark *after* init_hwprobe_vdso_data() has
>> already populated the vDSO with default/stale values.
>
> IIUC there's another race here: we don't ensure these complete before
> allowing userspace to see the values, so if these took so long to probe
> userspace started to make hwprobe() calls before they got scheduled we'd
> be providing the wrong answer.
>
> Unless I'm just missing something, though -- I thought we'd looked at that
> case?
>
Thanks for the review. You're right, my current patch doesn't fix the race
condition with userspace.

The robust solution here is to use the kernel's `completion`. I've tested
this approach: the async probing thread calls `complete()` when finished,
and `init_hwprobe_vdso_data()` blocks on `wait_for_completion()`. This
guarantees the vDSO data is finalized before userspace can access it.

>> So, refresh the vDSO data for specified keys (e.g.,
>> MISALIGNED_VECTOR_PERF) ensuring it reflects the final boot-time values.
>>
>> Test by comparing vDSO and syscall results for affected keys
>> (e.g., MISALIGNED_VECTOR_PERF), which now match their final
>> boot-time values.
>
> Wouldn't all the other keys we probe via workqueue be racy as well?
>
The completion mechanism is easily reusable. If this approach is accepted,
I will then identify other potential probe keys and integrate them into
this synchronization logic.

And here is my tested code:

diff --git a/arch/riscv/include/asm/hwprobe.h 
b/arch/riscv/include/asm/hwprobe.h
index 7fe0a379474ae2c6..87af186d92e75ddb 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct 
riscv_hwprobe *pair,

      return pair->value == other_pair->value;
  }
-
+#ifdef CONFIG_MMU
+void riscv_hwprobe_register_async_probe(void);
+void riscv_hwprobe_complete_async_probe(void);
+#else
+inline void riscv_hwprobe_register_async_probe(void) {}
+inline void riscv_hwprobe_complete_async_probe(void) {}
+#endif
  #endif
diff --git a/arch/riscv/kernel/sys_hwprobe.c 
b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2beba57..96ce1479e835534e 100644
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
@@ -467,6 +469,32 @@ static int do_riscv_hwprobe(struct riscv_hwprobe 
__user *pairs,

  #ifdef CONFIG_MMU

+/* Framework for synchronizing asynchronous boot-time probes */
+static DECLARE_COMPLETION(boot_probes_done);
+static atomic_t pending_boot_probes = ATOMIC_INIT(1);
+
+void riscv_hwprobe_register_async_probe(void)
+{
+    atomic_inc(&pending_boot_probes);
+}
+
+void riscv_hwprobe_complete_async_probe(void)
+{
+    if (atomic_dec_and_test(&pending_boot_probes))
+        complete(&boot_probes_done);
+}
+
+static void __init wait_for_all_boot_probes(void)
+{
+    if (atomic_dec_and_test(&pending_boot_probes))
+        return;
+
+    pr_info("riscv: waiting for hwprobe asynchronous probes to 
complete...\n");
+ wait_for_completion(&boot_probes_done);
+    pr_info("riscv: hwprobe asynchronous probes completed.\n");
+}
+
+
  static int __init init_hwprobe_vdso_data(void)
  {
      struct vdso_arch_data *avd = vdso_k_arch_data;
@@ -474,6 +502,8 @@ static int __init init_hwprobe_vdso_data(void)
      struct riscv_hwprobe pair;
      int key;

+    wait_for_all_boot_probes();
+
      /*
       * Initialize vDSO data with the answers for the "all CPUs" case, to
       * save a syscall in the common case.
diff --git a/arch/riscv/kernel/unaligned_access_speed.c 
b/arch/riscv/kernel/unaligned_access_speed.c
index ae2068425fbcd207..57e4169ab58fb9bc 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -379,6 +380,7 @@ static void check_vector_unaligned_access(struct 
work_struct *work __always_unus
  static int __init vec_check_unaligned_access_speed_all_cpus(void 
*unused __always_unused)
  {
  schedule_on_each_cpu(check_vector_unaligned_access);
+    riscv_hwprobe_complete_async_probe();

      return 0;
  }
@@ -473,8 +475,12 @@ static int __init check_unaligned_access_all_cpus(void)
  per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
      } else if (!check_vector_unaligned_access_emulated_all_cpus() &&
IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
- kthread_run(vec_check_unaligned_access_speed_all_cpus,
-                NULL, "vec_check_unaligned_access_speed_all_cpus");
+ riscv_hwprobe_register_async_probe();
+ if(IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
+                NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
+                pr_warn("Failed to create vec_unalign_check kthread\n");
+ riscv_hwprobe_complete_async_probe();
+            }
      }

      /*


