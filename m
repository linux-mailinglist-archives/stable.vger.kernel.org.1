Return-Path: <stable+bounces-179179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4EAB5122C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED11616B0AB
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A293115A2;
	Wed, 10 Sep 2025 09:10:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB5F30C35B;
	Wed, 10 Sep 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495453; cv=none; b=ABfqaYEx+XlBgALQLAySkNz5N5PTrm4Sofk6vuFiRSnXWcF74uba1vJK9c3CIHL6syqJZfGhEMRQEENhMACJQrS7g+4bn383P85+Q3kDJE46AWIPfuDMBYcA8nhYL0F5RtWz3d/VsTOYTuBGSqrUAI9D57bYUbSetmGCV4MvLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495453; c=relaxed/simple;
	bh=nN0dkOHatWi3Kgddu96dR8RKHH0WVA7ud+zi9dAXztE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIJTb2KCkvLWXJjmOMGf3QYe+OS3I/TGSl6sdE9uQCWTxm0A4Igs/bDCLmTS5hxapERwBfWvl4V8xQCbY1TtzJhU9nFAd+W6ts5vN/Y2eywzEo0WZLetG+zec/9Z7hcdGu1ZTx+p3Bd1zHzyDiVFLpWOjKIWYFq4eXuLSBX3e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8AxSNGYQMFoVr8IAA--.18861S3;
	Wed, 10 Sep 2025 17:10:48 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAxz8OTQMFo18eLAA--.52768S2;
	Wed, 10 Sep 2025 17:10:47 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
Date: Wed, 10 Sep 2025 17:10:33 +0800
Message-ID: <20250910091033.725716-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxz8OTQMFo18eLAA--.52768S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr18CF1rJryxJF43XF17XFc_yoW8GryUpF
	yDCrWkGrZrGr1fCa4jy397uryUtFs5CrWIgFWUt3W8ZF1qva4UXr4kKr1DWFyYgayFqFWx
	ZFnag34DZa4Yv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
the -mstrict-align flag. However, ACPI structures are packed by default
so will cause unaligned accesses.

To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.h to
align ACPI structures if ARCH_STRICT_ALIGN enabled.

Cc: stable@vger.kernel.org
Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Suggested-by: Xi Ruoyao <xry111@xry111.site>
Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Modify asm/acenv.h instead of Makefile.

 arch/loongarch/include/asm/acenv.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
index 52f298f7293b..483c955f2ae5 100644
--- a/arch/loongarch/include/asm/acenv.h
+++ b/arch/loongarch/include/asm/acenv.h
@@ -10,9 +10,8 @@
 #ifndef _ASM_LOONGARCH_ACENV_H
 #define _ASM_LOONGARCH_ACENV_H
 
-/*
- * This header is required by ACPI core, but we have nothing to fill in
- * right now. Will be updated later when needed.
- */
+#ifdef CONFIG_ARCH_STRICT_ALIGN
+#define ACPI_MISALIGNMENT_NOT_SUPPORTED
+#endif /* CONFIG_ARCH_STRICT_ALIGN */
 
 #endif /* _ASM_LOONGARCH_ACENV_H */
-- 
2.47.3


