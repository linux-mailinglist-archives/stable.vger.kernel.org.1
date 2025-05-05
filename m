Return-Path: <stable+bounces-141339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F90AAB2CA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B0F3B3143
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39E137A293;
	Tue,  6 May 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HViPDxfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB028032F;
	Mon,  5 May 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485824; cv=none; b=GIUUOENVkGsMmkHSdRUxR92IKRwoZpQtrfnr9DpJxJy8TDX4wyMtJoaYVfdg+oD7JIQ3G1oxd7WQpPIsjy7BM7AbncllWhw/ZAq4ok6XeIabD+Kl+i5tTe9Pfapuf3BAwD2sqmAQWYdlOCbqgZFxASeYipgKgyDMmxXDttIcT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485824; c=relaxed/simple;
	bh=9DI2HHnmjUxdW4QLwVgpY8p3vKpqr9H6QE5nZNsdzMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaOcIpHC+nbZjPBbHTxINeTXJ+DEHL/deAIQIMtoz984E3lKyA1KNZw5yUYGbuKl4AksCj4+2+wA6Zs6Gegma64nHQOPnrfWKqCDfmdJm+vOPliQoJuufag8RazUpmweVZg4al8GoRqWyE/JqwQ+OcMvh4o5yuFWwaXMhkD6Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HViPDxfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E971FC4CEE4;
	Mon,  5 May 2025 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485824;
	bh=9DI2HHnmjUxdW4QLwVgpY8p3vKpqr9H6QE5nZNsdzMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HViPDxfI069hmYjymkGcnFDTKIb4MI/G86S5TtX8n6baTzyS9QTWOw3DzZ9r6pBYM
	 ZewILBl8RC+GrZ3hyaM70qtTKqV5VLvuKtHug4Qa2gz+YlciYSTQ+dLGpqflJdT2dT
	 Hxj0sO5FaCGRI8S1RLc4dHGmvFgRDffexdAoyIC/3mWC0/u07r00A0/GD3LOCc99It
	 u/Pc3iXzC2U+Jqq/hKyrWpf3PEgPBpI6BumsjqB/25vOyir/pcFTu25DNLJjeYeUtd
	 /ao36HULowz5n+eADWP+miCK/8yGpMGUVAoC3LWPnLYVYl0+PIwJp3wF5ly0/5TjlJ
	 zS3T+HdKUa7hA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	namcao@linutronix.de,
	bjorn@rivosinc.com,
	vincenzo.frascino@arm.com,
	stuart.menefy@codasip.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	akpm@linux-foundation.org,
	libang.li@antgroup.com,
	abrestic@rivosinc.com,
	anshuman.khandual@arm.com,
	yongxuan.wang@sifive.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 016/294] riscv: Allow NOMMU kernels to access all of RAM
Date: Mon,  5 May 2025 18:51:56 -0400
Message-Id: <20250505225634.2688578-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 2c0391b29b27f315c1b4c29ffde66f50b29fab99 ]

NOMMU kernels currently cannot access memory below the kernel link
address. Remove this restriction by setting PAGE_OFFSET to the actual
start of RAM, as determined from the devicetree. The kernel link address
must be a constant, so keep using CONFIG_PAGE_OFFSET for that purpose.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>
Link: https://lore.kernel.org/r/20241026171441.3047904-3-samuel.holland@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/page.h    | 12 ++++--------
 arch/riscv/include/asm/pgtable.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 4d1f58848129e..dbb9d0d0f405e 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -26,12 +26,9 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
-#ifdef CONFIG_64BIT
 #ifdef CONFIG_MMU
+#ifdef CONFIG_64BIT
 #define PAGE_OFFSET		kernel_map.page_offset
-#else
-#define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
-#endif
 /*
  * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
  * define the PAGE_OFFSET value for SV48 and SV39.
@@ -41,6 +38,9 @@
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
+#else
+#define PAGE_OFFSET		((unsigned long)phys_ram_base)
+#endif /* CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
 
@@ -97,11 +97,7 @@ typedef struct page *pgtable_t;
 #define MIN_MEMBLOCK_ADDR      0
 #endif
 
-#ifdef CONFIG_MMU
 #define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
-#else
-#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
-#endif /* CONFIG_MMU */
 
 struct kernel_mapping {
 	unsigned long page_offset;
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f540b2625714d..332a6bf72b1d5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -12,7 +12,7 @@
 #include <asm/pgtable-bits.h>
 
 #ifndef CONFIG_MMU
-#define KERNEL_LINK_ADDR	PAGE_OFFSET
+#define KERNEL_LINK_ADDR	_AC(CONFIG_PAGE_OFFSET, UL)
 #define KERN_VIRT_SIZE		(UL(-1))
 #else
 
-- 
2.39.5


