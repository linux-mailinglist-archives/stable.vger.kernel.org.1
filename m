Return-Path: <stable+bounces-144385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C751AB6E56
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23411BA2B0A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316C1A4F0A;
	Wed, 14 May 2025 14:47:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00A186E20;
	Wed, 14 May 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234028; cv=none; b=RPhh/7FRY9MLWg1O1Em93+Uk4Uz1BFl+20PM0CHb/pQIEDdHjtmwjKdqpGmPHEW/MQBZP4rR5OeuJKBxFda8i+TbXoqJCYjiksluvZVmm5Z08kYocOWyilNpVG2Rj0woGt0ok8ZABLd3URempkOgkV0mpmt4Hdfelits/QVcTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234028; c=relaxed/simple;
	bh=6fEQeP6TUDzlobvmkS1WrL/Rzys4yqsPWMlZIiFtHxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InOPdjX1APhFvXjz1fZ96MRWcxSWxiKPbRO6CW6bwAckqFk7mq/vT/UKZI1R5uKpsH51EINFBODt+2WePkPtoi/2ValDp8ofvXN41dDzeqARxj7LO/ODeLRGrX/WAP/VdBcKzNyffAnreiBhOLVXBIjUUw2pXjHUE6McCkqJuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8Bx367mrCRoM__mAA--.30260S3;
	Wed, 14 May 2025 22:47:02 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMCxLBvhrCRo1vnRAA--.19452S2;
	Wed, 14 May 2025 22:47:01 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH] LoongArch: Save and restore CSR.CNTC for hibernation
Date: Wed, 14 May 2025 22:46:43 +0800
Message-ID: <20250514144643.1620870-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLBvhrCRo1vnRAA--.19452S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4kKw13Gw48tw18Zw1xCrX_yoW8tF1xpF
	WDArWDKr40k3Z7Ja9xt3yDZr98Jrn5C3W3Wa1qy348Cwn3Xr45Zr4kKwnYqF4Yq3yrAa10
	vFW8Cw1aqa17W3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Save and restore CSR.CNTC for hibernation which is similar to suspend.

For host this is unnecessary because sched clock is ensured continuous,
but for kvm guest sched clock isn't enough because rdtime.d should also
be continuous.

Host::rdtime.d = Host::CSR.CNTC + counter
Guest::rdtime.d = Host::CSR.CNTC + Host::CSR.GCNTC + Guest::CSR.CNTC + counter

so,

Guest::rdtime.d = Host::rdtime.d + Host::CSR.GCNTC + Guest::CSR.CNTC

To ensure Guest::rdtime.d continuous, Host::rdtime.d should be at first
continuous, while Host::CSR.GCNTC / Guest::CSR.CNTC is maintained by KVM.

Cc: stable@vger.kernel.org
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/time.c     | 2 +-
 arch/loongarch/power/hibernate.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index e2d3bfeb6366..bc75a3a69fc8 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -111,7 +111,7 @@ static unsigned long __init get_loops_per_jiffy(void)
 	return lpj;
 }
 
-static long init_offset __nosavedata;
+static long init_offset;
 
 void save_counter(void)
 {
diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
index 1e0590542f98..e7b7346592cb 100644
--- a/arch/loongarch/power/hibernate.c
+++ b/arch/loongarch/power/hibernate.c
@@ -2,6 +2,7 @@
 #include <asm/fpu.h>
 #include <asm/loongson.h>
 #include <asm/sections.h>
+#include <asm/time.h>
 #include <asm/tlbflush.h>
 #include <linux/suspend.h>
 
@@ -14,6 +15,7 @@ struct pt_regs saved_regs;
 
 void save_processor_state(void)
 {
+	save_counter();
 	saved_crmd = csr_read32(LOONGARCH_CSR_CRMD);
 	saved_prmd = csr_read32(LOONGARCH_CSR_PRMD);
 	saved_euen = csr_read32(LOONGARCH_CSR_EUEN);
@@ -26,6 +28,7 @@ void save_processor_state(void)
 
 void restore_processor_state(void)
 {
+	sync_counter();
 	csr_write32(saved_crmd, LOONGARCH_CSR_CRMD);
 	csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
 	csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
-- 
2.47.1


