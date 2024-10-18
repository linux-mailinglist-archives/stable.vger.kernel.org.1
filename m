Return-Path: <stable+bounces-86732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426619A3392
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA590B23A25
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 04:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFF15C156;
	Fri, 18 Oct 2024 04:00:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF620E31C;
	Fri, 18 Oct 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224035; cv=none; b=XQazbPZvO1zBBte4l0p269VNk8loRgt5knN3Q8I3X7+tdGDdlujl6zLAUdfRP+9cUmVYsBYeyNL5wGH4dcb1Vqjrk6Fb+PYXP1H3EKNQjdMF23VQdNY9wj7igFLkVifiNbDOWTfP2vGJmlmoq0L98ToeFlOxMPaclZ0mODfYI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224035; c=relaxed/simple;
	bh=NGz6KlkJSWDi/bWhwwnxcjNUC/FuKAov70R8NlezG6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Soj7c8k54QCy2ryUe+qw93rMPWZB3GzOp6pLWaA2nPIjaXltDIi19baLX7q8u7O1W8qjU6sr5vKbbq0Spza9sDYOiZQYOh1FYtZbq5R+MXeumSFRQHm3xcZ1KefPVs1jSqZzPA1TCZb1TeJ43SfheH3N8hFbM0L23nDbIqRT6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE04C4CEC3;
	Fri, 18 Oct 2024 04:00:31 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Kanglong Wang <wangkanglong@loongson.cn>
Subject: [PATCH] LoongArch: Make KASAN usable for variable cpu_vabits
Date: Fri, 18 Oct 2024 12:00:24 +0800
Message-ID: <20241018040024.1060903-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, KASAN on LoongArch assume the CPU VA bits is 48, which is
true for Loongson-3 series, but not for Loongson-2 series (only 40 or
lower), this patch fix that issue and make KASAN usable for variable
cpu_vabits.

1. Define XRANGE_SHADOW_SHIFT which means valid address length from
   VA_BITS to min(cpu_vabits, VA_BITS).
2. In kasan_mem_to_shadow() let DMW addresses which exceed XRANGE_SIZE
   to return kasan_early_shadow_page.

Cc: stable@vger.kernel.org
Signed-off-by: Kanglong Wang <wangkanglong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/kasan.h | 2 +-
 arch/loongarch/mm/kasan_init.c     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index cd6084f4e153..c6bce5fbff57 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -16,7 +16,7 @@
 #define XRANGE_SHIFT (48)
 
 /* Valid address length */
-#define XRANGE_SHADOW_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
+#define XRANGE_SHADOW_SHIFT	min(cpu_vabits, VA_BITS)
 /* Used for taking out the valid address */
 #define XRANGE_SHADOW_MASK	GENMASK_ULL(XRANGE_SHADOW_SHIFT - 1, 0)
 /* One segment whole address space size */
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 427d6b1aec09..e5ecc8c12034 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -48,6 +48,10 @@ void *kasan_mem_to_shadow(const void *addr)
 			return (void *)(kasan_early_shadow_page);
 
 		maddr &= XRANGE_SHADOW_MASK;
+
+		if (maddr >= XRANGE_SIZE)
+			return (void *)(kasan_early_shadow_page);
+
 		switch (xrange) {
 		case XKPRANGE_CC_SEG:
 			offset = XKPRANGE_CC_SHADOW_OFFSET;
-- 
2.43.5


