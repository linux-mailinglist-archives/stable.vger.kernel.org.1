Return-Path: <stable+bounces-192796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F6C43735
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 03:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B35E3474E9
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 02:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3641A23B6;
	Sun,  9 Nov 2025 02:32:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59144944F;
	Sun,  9 Nov 2025 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655531; cv=none; b=nnbemNRag0Nf70K5+EO5rHsHzUeK3d6Oh39QXp+P7aX+oKzlWKfc3CqpzrEUK/Uzqv0uPEi1ElP7eeoQw3xKeqBor6UCeueYU408TYYjaQDMI/nDAa0RNKYQsLv8FtxPqD+n701aaZMNpbI8f10JZJq1nNl1J8ouuScgVDTZS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655531; c=relaxed/simple;
	bh=+OlPW1AdN85L2JeJwK1sgOjpmR2yyqTYsWYoymCotZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O83KhjVQPUsKfulbylHcsUlLK1plEo5HCtJvGpXzmeZXYo8C5pmoThvJF5UkBmrHhJay5+S091Ygd69tjXo+qW5bCoFpIV9r2B+HZKVtN4IXf7FRsiPfKkwQuN2icpuFfCu9Xc0UtfKIyn+1gM9YgjNT7BDqjD7WcMPhPsk5QNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8CxbNIl_Q9p0NcgAA--.6263S3;
	Sun, 09 Nov 2025 10:32:05 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJAxleQT_Q9pdzAsAQ--.2345S2;
	Sun, 09 Nov 2025 10:32:04 +0800 (CST)
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
Subject: [PATCH] LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY
Date: Sun,  9 Nov 2025 10:31:36 +0800
Message-ID: <20251109023136.355207-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleQT_Q9pdzAsAQ--.2345S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr13Aryftw1kuF45CFykWFX_yoWkAFc_Zr
	1xCw4UWr4kAayjkw1jyw4fWF15Za1IqF4Yka4I9rZ3AF15Ar1xCwsxJas8ZrZ0g3y3Krsx
	Z3y7GFnIkr1jkosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Now we use virtual addresses to fill CSR_MERRENTRY/CSR_TLBRENTRY, but
hardware hope physical addresses. Now it works well because the high
bits are ignored above PA_BITS (48 bits), but explicitly use physical
addresses can avoid potential bugs. So fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 3d9be6ca7ec5..da5926fead4a 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -1131,8 +1131,8 @@ static void configure_exception_vector(void)
 	tlbrentry = (unsigned long)exception_handlers + 80*VECSIZE;
 
 	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
-	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+	csr_write64(__pa(eentry), LOONGARCH_CSR_MERRENTRY);
+	csr_write64(__pa(tlbrentry), LOONGARCH_CSR_TLBRENTRY);
 }
 
 void per_cpu_trap_init(int cpu)
-- 
2.47.3


