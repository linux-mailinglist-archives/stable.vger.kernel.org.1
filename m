Return-Path: <stable+bounces-183590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FDBC3B95
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62B73B8431
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA5BA4A;
	Wed,  8 Oct 2025 07:51:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A61F12E9;
	Wed,  8 Oct 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909860; cv=none; b=LpDTVgI4LkmCKMs21N25pCIdgOTRoq5MnlyHqQVbb2TS7n0bxZs2F4H46D0dSwk4LLRpGCrbHYDnIvBChUrIJoAZKfCuSjtyQ0H2Sq8DXzITUV0AfUHHRUojFYRd+7i8wb5iQyZLddbzqG1qhxh+RnJBrLtEC6ExhtlHLeK1LXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909860; c=relaxed/simple;
	bh=jcE1zGotb3oaZ4oCLRDR6NYwb4QZFGglLycnEneFsh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5qb9XvQ1Yt5pPoNlpAHi2n0TkFp4xuhYeyrK+zQsFKaTCsL9r0rFyHeCODKtkgq7y4tfd92XjAt5kkcXlIEV/GDOOm6bPiNsPqFUFX8/rzqhkbQfL+gfC5WdPeyJdD/DkUp/DT0D1vxC7odiStX0NeDj1hGcyxPt34NisTPAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowAA3kaPLF+ZoUI4EDQ--.32936S3;
	Wed, 08 Oct 2025 15:50:35 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 08 Oct 2025 15:50:16 +0800
Subject: [PATCH 6.6.y 1/2] riscv: mm: Use hint address in mmap if available
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-riscv-mmap-addr-space-6-6-v1-1-9f47574a520f@iscas.ac.cn>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
In-Reply-To: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
To: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
 Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, 
 Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAA3kaPLF+ZoUI4EDQ--.32936S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur43Cr4fKFW7tw4DuFykKrg_yoW5tF1fpa
	sIka93urn7t3W7Kry7Jr1UKF17Gan5KFy2qFW0grWvkFs8uasxWr1vk3W5GFy0vFW09a18
	Z3Wayws5u3W5Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit b5b4287accd702f562a49a60b10dbfaf7d40270f ]

On riscv it is guaranteed that the address returned by mmap is less than
the hint address. Allow mmap to return an address all the way up to
addr, if provided, rather than just up to the lower address space.

This provides a performance benefit as well, allowing mmap to exit after
checking that the address is in range rather than searching for a valid
address.

It is possible to provide an address that uses at most the same number
of bits, however it is significantly more computationally expensive to
provide that number rather than setting the max to be the hint address.
There is the instruction clz/clzw in Zbb that returns the highest set bit
which could be used to performantly implement this, but it would still
be slower than the current implementation. At worst case, half of the
address would not be able to be allocated when a hint address is
provided.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Link: https://lore.kernel.org/r/20240130-use_mmap_hint_address-v3-1-8a655cfa8bcb@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[ Adjust TASK_SIZE64 -> TASK_SIZE in moved lines ]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 arch/riscv/include/asm/processor.h | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 4f6af8c6cfa060380594c6d0e727af6b02d08d70..938aef30dfb42ee477b7c59b5d2afc3871d8004d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,22 +13,16 @@
 
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_64BIT
-#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
-#define STACK_TOP_MAX		TASK_SIZE
-
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
 		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
 	else							\
-		mmap_end = VA_USER_SV39;			\
+		mmap_end = (_addr + len);			\
 	mmap_end;						\
 })
 
@@ -38,17 +32,18 @@
 	typeof(addr) _addr = (addr);				\
 	typeof(base) _base = (base);				\
 	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
 		mmap_base = (_base);				\
-	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
-		mmap_base = VA_USER_SV57 - rnd_gap;		\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_base = VA_USER_SV48 - rnd_gap;		\
 	else							\
-		mmap_base = VA_USER_SV39 - rnd_gap;		\
+		mmap_base = (_addr + len) - rnd_gap;		\
 	mmap_base;						\
 })
 
+#ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
+#define STACK_TOP_MAX		TASK_SIZE
 #else
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE

-- 
2.50.1


