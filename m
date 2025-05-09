Return-Path: <stable+bounces-142957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2EAB07C1
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B6C3B9D96
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 02:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75A242927;
	Fri,  9 May 2025 02:06:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429462AE96;
	Fri,  9 May 2025 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756402; cv=none; b=XZmfO0p6DzPkKDdavD9hRxj5Fp8/xtD1HZEpQlcPOZZd3upvwr+FNP95qWXLwdlQHi+pXrBvfBbzmUp83SrtC/pWAyZ+PdoxsxC0cdyej//W8MTGdjNgHvycZQWkjyld6Nl7LwpgMX9sXsaEp7bLpGaunPDgFPtZCZX07QbmPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756402; c=relaxed/simple;
	bh=eOG+6uPAgB6kk87jbQU1jozNIa3ia4nGj0etd0Lgu8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qR/O+i8XR+6f7IPb0E+AF9IsbquFzsFDPq4oWGkZn473d8OreZGu2OS4QBL/zoY/nUPQaJbF9/vv7dH41tYja39wfcenTCB4OewlGR2Q/Pgu12oJveTnBC27kemnyjV7O+/QWJRTAzX3W5qyBPx5tM3mt2ssoedumXXCXhHXgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8BxjawlYx1oktPaAA--.63242S3;
	Fri, 09 May 2025 10:06:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMBxLscjYx1owBG_AA--.32426S2;
	Fri, 09 May 2025 10:06:27 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Prevent cond_resched() occurring within kernel-fpu
Date: Fri,  9 May 2025 10:06:26 +0800
Message-Id: <20250509020626.23414-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxLscjYx1owBG_AA--.32426S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryUKFyDXFyxuryDtr15WrX_yoW5Jr4Upr
	yfur95tr4UJa4ava9rJw18Cry5Awn7G34xWa9xG34rA34Yqr18Xwn29r12qF12vFyIyFyS
	vFnYqrWI93W5A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

When CONFIG_PREEMPT_COUNT is not configured (i.e. CONFIG_PREEMPT_NONE/
CONFIG_PREEMPT_VOLUNTARY), preempt_disable() / preempt_enable() merely
acts as a barrier(). However, in these cases cond_resched() can still
trigger a context switch and modify the CSR.EUEN, resulting in do_fpu()
exception being activated within the kernel-fpu critical sections, as
demonstrated in the following path:

dcn32_calculate_wm_and_dlg()
    DC_FP_START()
	dcn32_calculate_wm_and_dlg_fpu()
	    dcn32_find_dummy_latency_index_for_fw_based_mclk_switch()
		dcn32_internal_validate_bw()
		    dcn32_enable_phantom_stream()
			dc_create_stream_for_sink()
			   kzalloc(GFP_KERNEL)
				__kmem_cache_alloc_node()
				    __cond_resched()
    DC_FP_END()

This patch is similar to commit d021985 (x86/fpu: Improve crypto
performance by making kernel-mode FPU reliably usable in softirqs).  It
uses local_bh_disable() instead of preempt_disable() for non-RT kernels
so it can avoid the cond_resched() issue, and also extend the kernel-fpu
application scenarios to the softirq context.

Cc: stable@vger.kernel.org
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/kfpu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
index ec5b28e570c9..4e469b021cf4 100644
--- a/arch/loongarch/kernel/kfpu.c
+++ b/arch/loongarch/kernel/kfpu.c
@@ -18,11 +18,28 @@ static unsigned int euen_mask = CSR_EUEN_FPEN;
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 static DEFINE_PER_CPU(unsigned int, euen_current);
 
+static inline void fpregs_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static inline void fpregs_unlock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+
 void kernel_fpu_begin(void)
 {
 	unsigned int *euen_curr;
 
-	preempt_disable();
+	if (!irqs_disabled())
+		fpregs_lock();
 
 	WARN_ON(this_cpu_read(in_kernel_fpu));
 
@@ -73,7 +90,8 @@ void kernel_fpu_end(void)
 
 	this_cpu_write(in_kernel_fpu, false);
 
-	preempt_enable();
+	if (!irqs_disabled())
+		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
-- 
2.20.1


