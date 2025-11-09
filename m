Return-Path: <stable+bounces-192797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71DC43747
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02EC6348354
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A71C6FEC;
	Sun,  9 Nov 2025 02:32:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A11A23B6;
	Sun,  9 Nov 2025 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655567; cv=none; b=Q7J68AfjJxXOXNSPBCo/GuhcWjBvHqcO6lKv+HPYqOA5OsDYTtW4h6w/Cs2b1ornJirrEwwpX0aBsXd1c+UvGQqsaqbGDqm9b7RevczToQgUOu7rH2P1L/EYzmgOuXsmmwea3wxGEJjoOF7jKpRZsAPgxwaX39HKUeX8I07AAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655567; c=relaxed/simple;
	bh=yP0wUqwDv+VrvJrRl4MeGRT5eX9vSWFZy6msvm4MXXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaHtlX6n558eU2qvVgrMhYsiPPF0mbhxJyMx+ZbD8bd4t2CrFY3ec78nRj/jjwAr3aVTsGvgflepNPOrfLwgyABjvTS52ZA+1UlkYc8VgOW2va0wsrbV6Nh5yaQnrw7jQ0YqXqDWluAWHuD5pjsT3Ko4XawXTZ5BWix7GcO+cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8Dx_tJK_Q9p7NcgAA--.6063S3;
	Sun, 09 Nov 2025 10:32:42 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJAxleQ4_Q9pqzAsAQ--.2346S2;
	Sun, 09 Nov 2025 10:32:41 +0800 (CST)
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
Subject: [PATCH] LoongArch: Consolidate early_ioremap()/ioremap_prot()
Date: Sun,  9 Nov 2025 10:32:14 +0800
Message-ID: <20251109023214.355231-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleQ4_Q9pqzAsAQ--.2346S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5tFyrur1kAr1rJFyUXFc_yoW8ury8pF
	92kr1kJFs8Kr1xGFykJFy7Wr1UtFnrKFWIqFW2kF9xu3Wjvr18ZrWkCr90vFyUXa95KFWr
	XrZ3Wa43CF4UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

1. Use phys_addr_t instead of u64, which can work for both 32/64 bits.
2. Check whether the input physical address is above TO_PHYS_MASK (and
   return NULL if yes) for the DMW version.

Note: In theory early_ioremap() also need the TO_PHYS_MASK checking, but
the UEFI BIOS pass some DMW virtual addresses.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/io.h | 5 ++++-
 arch/loongarch/mm/ioremap.c     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index eaff72b38dc8..0130185e0349 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -14,7 +14,7 @@
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
 
-extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
+extern void __init __iomem *early_ioremap(phys_addr_t phys_addr, unsigned long size);
 extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 
 #define early_memremap early_ioremap
@@ -25,6 +25,9 @@ extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 					 pgprot_t prot)
 {
+	if (offset > TO_PHYS_MASK)
+		return NULL;
+
 	switch (pgprot_val(prot) & _CACHE_MASK) {
 	case _CACHE_CC:
 		return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
index df949a3d0f34..27c336959fe8 100644
--- a/arch/loongarch/mm/ioremap.c
+++ b/arch/loongarch/mm/ioremap.c
@@ -6,7 +6,7 @@
 #include <asm/io.h>
 #include <asm-generic/early_ioremap.h>
 
-void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size)
+void __init __iomem *early_ioremap(phys_addr_t phys_addr, unsigned long size)
 {
 	return ((void __iomem *)TO_CACHE(phys_addr));
 }
-- 
2.47.3


