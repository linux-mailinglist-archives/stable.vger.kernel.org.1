Return-Path: <stable+bounces-192698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D4C3F3E3
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE3B4E26FF
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F528030E;
	Fri,  7 Nov 2025 09:49:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761C21767A;
	Fri,  7 Nov 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508946; cv=none; b=ftVR3Yq6mZtR0Nsp4+euhyhQQqwHlapkob8l0f55UN2gw8t26/K6pz5eOS4projCK7c0VP8R2yfMoLHF08uXO/IHFMrPDF6toMwboTGSY4Scblfh3KImoxwPUd+H/lCTCFUm9R/nmtbqjLYKXC/8irTFLqoUz1q4mHT2m0qgCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508946; c=relaxed/simple;
	bh=fe75sjK0pOyoToV9r2FlNemCMcnmSJDfSY8eP+vAGEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAIywHWg4V+YCWeqZhpdftXk+nAjee3q3xTX8Yhv2WNXmk3XYg3gCCeFkiKKq892alFwSbwQo+Z1cDdDJH6DaRO6rSLrZK7VRwv6sGltKAB26dXAWwIUZ9fwzEPZKWPqttzGX9PKohQnQuxtVCBnrIfWPE8NWI2TlvmKnaX34eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8BxT_CKwA1p10EgAA--.4017S3;
	Fri, 07 Nov 2025 17:48:58 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJDxK8F8wA1pz7wqAQ--.21331S2;
	Fri, 07 Nov 2025 17:48:57 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Use correct accessor to read FWPC/MWPC
Date: Fri,  7 Nov 2025 17:48:36 +0800
Message-ID: <20251107094836.3093983-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxK8F8wA1pz7wqAQ--.21331S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw4rKF1fCF45tr15GF1Dtwc_yoW8JF47pr
	srAr95GFW5Kas7CFZ3tr13ur4YqFs7u34ava48K39FvF1DX3y3Wr95Jr9IqFy5G3yrXw4F
	qFsI9r4S9a1jvwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07j8a9-UUUUU=

CSR.FWPC and CSR.MWPC are 32bit registers, so use csr_read32() rather
than csr_read64() to read the values of FWPC/MWPC.

Cc: stable@vger.kernel.org
Fixes: edffa33c7bb5a73 ("LoongArch: Add hardware breakpoints/watchpoints support")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/hw_breakpoint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/include/asm/hw_breakpoint.h
index 13b2462f3d8c..5faa97a87a9e 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -134,13 +134,13 @@ static inline void hw_breakpoint_thread_switch(struct task_struct *next)
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-	return csr_read64(LOONGARCH_CSR_FWPC) & CSR_FWPC_NUM;
+	return csr_read32(LOONGARCH_CSR_FWPC) & CSR_FWPC_NUM;
 }
 
 /* Determine number of WRP registers available. */
 static inline int get_num_wrps(void)
 {
-	return csr_read64(LOONGARCH_CSR_MWPC) & CSR_MWPC_NUM;
+	return csr_read32(LOONGARCH_CSR_MWPC) & CSR_MWPC_NUM;
 }
 
 #endif	/* __KERNEL__ */
-- 
2.47.3


