Return-Path: <stable+bounces-152364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26415AD482D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A6D7A8682
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E4192B8C;
	Wed, 11 Jun 2025 01:47:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4F1B960;
	Wed, 11 Jun 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606429; cv=none; b=B26IBzDNzXnMt0HDyxOBnBiy+sXq69XF+FIl8++Kyvo5cbNHzvupSyMv5cIvVUMmEw3bLfmBPej+Eo+aNpDZ9x57Gtn5j7tl2vbaJttHvUEBaCn5sEDfLrX305pSaCeayLrMes+D+iLWGQ5/HfIzuQNPApYihZWSzM9GJlnfvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606429; c=relaxed/simple;
	bh=lsSQXQJCZUyyRujFjdyDewDv8eRT7lULwGOQ1CdN5hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8KdiFxCHfYegKxo1gXOLyhubEbsS0eFzppUBSjrTOSiYNFnEDy6Eg15Tf9xdXtAAkbrmYm7fE2yVPgrXWyUYV8Awj7iXR1zwW7N+VpY4+5+Du5L3NZfZlC9MH249W6wJWj0MPROb87G5uhS0CPzPoHIHWFxyW04kTvb4VX+5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxnOIY4EhopkITAQ--.11960S3;
	Wed, 11 Jun 2025 09:47:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCx7MQL4Eho0EoVAQ--.65102S4;
	Wed, 11 Jun 2025 09:47:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xianglai Li <lixianglai@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/9] LoongArch: KVM: INTC: Check interrupt route from physical cpu
Date: Wed, 11 Jun 2025 09:46:44 +0800
Message-Id: <20250611014651.3042734-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250611014651.3042734-1-maobibo@loongson.cn>
References: <20250611014651.3042734-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7MQL4Eho0EoVAQ--.65102S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With eiointc interrupt controller, physical cpu id is set for irq
route. However function kvm_get_vcpu() is used to get destination vCPU
when delivering irq. With API kvm_get_vcpu(), logical cpu is used.

With API kvm_get_vcpu_by_cpuid(), vCPU can be searched from physical
cpu id.

Cc: stable@vger.kernel.org
Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write functions")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index d2c521b0e923..0b648c56b0c3 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -9,7 +9,8 @@
 
 static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 {
-	int ipnum, cpu, irq_index, irq_mask, irq;
+	int ipnum, cpu, irq_index, irq_mask, irq, cpuid;
+	struct kvm_vcpu *vcpu;
 
 	for (irq = 0; irq < EIOINTC_IRQS; irq++) {
 		ipnum = s->ipmap.reg_u8[irq / 32];
@@ -20,7 +21,12 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 		irq_index = irq / 32;
 		irq_mask = BIT(irq & 0x1f);
 
-		cpu = s->coremap.reg_u8[irq];
+		cpuid = s->coremap.reg_u8[irq];
+		vcpu = kvm_get_vcpu_by_cpuid(s->kvm, cpuid);
+		if (vcpu == NULL)
+			continue;
+
+		cpu = vcpu->vcpu_id;
 		if (!!(s->coreisr.reg_u32[cpu][irq_index] & irq_mask))
 			set_bit(irq, s->sw_coreisr[cpu][ipnum]);
 		else
@@ -68,17 +74,23 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
 					int irq, u64 val, u32 len, bool notify)
 {
-	int i, cpu;
+	int i, cpu, cpuid;
+	struct kvm_vcpu *vcpu;
 
 	for (i = 0; i < len; i++) {
-		cpu = val & 0xff;
+		cpuid = val & 0xff;
 		val = val >> 8;
 
 		if (!(s->status & BIT(EIOINTC_ENABLE_CPU_ENCODE))) {
-			cpu = ffs(cpu) - 1;
-			cpu = (cpu >= 4) ? 0 : cpu;
+			cpuid = ffs(cpuid) - 1;
+			cpuid = (cpuid >= 4) ? 0 : cpuid;
 		}
 
+		vcpu = kvm_get_vcpu_by_cpuid(s->kvm, cpuid);
+		if (vcpu == NULL)
+			continue;
+
+		cpu = vcpu->vcpu_id;
 		if (s->sw_coremap[irq + i] == cpu)
 			continue;
 
-- 
2.39.3


