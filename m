Return-Path: <stable+bounces-139770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D0AA9F22
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B916AE0D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD427F745;
	Mon,  5 May 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnUgiA4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2425C80A;
	Mon,  5 May 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483302; cv=none; b=u9Nq62MXfyw7q43tptHUn7Oz/1SG42dWm5BL/XnTbyAOCajA7Dg9cRj/7jsqbXRFlHNWkpXumtY4OOofG1lTATy/C5wSNHgn2Hl7BWqTvPdat5lJfPLc5W7R7y5eUbutc7JpmWaRkFQS6VGIfgt/bfVv4osNvWhzyyMNemgM8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483302; c=relaxed/simple;
	bh=wpBIFCI3plvLmkr5lp9oDV+SY9kVX4hB/sSW423ynQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r30OrgZajheYBE4SyTrthjftBwYQF+aKtW1WNFVe7Q2NEnWHi2NFdOqOUku2TwoJUCC5ilPDAI+F1qscYZCaCh/KbzzQwK5D8GvuGFbI6+3K0A7hz01ZsxHKVygwYex8QuawX+CAJSYyn3jeLYQAsNZcx1j1skgunYJjdYcI0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnUgiA4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF564C4CEE4;
	Mon,  5 May 2025 22:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483302;
	bh=wpBIFCI3plvLmkr5lp9oDV+SY9kVX4hB/sSW423ynQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnUgiA4wKXuYknr3HUjjNOwu1pb2CzrctKJSBeF/o6y4sKLeTJBAN3w7XL/34GqpS
	 dmQHTvpqF1SlY/iLMX7oqb6+uMStz2bpaF9nEOuvleb+Sjg4FTaHVItMfG0e78KWQV
	 iBXPMufWMSGwzU9txdLiUQYkOCJbXT0zWTyreKc5gPTYK6cUCpz87eSCf1NophF16c
	 +HRQ3RFlwqahk8wj8bH/HBNVIkevy+S1a+dtGTYW8IZxrffGObC3oxPgFI0VfcWykD
	 kmWrHUAznTKexm90bk9tXtMzFD57mAh+QA4V26NflXfEccti+2skbeOBIKeJnlx3md
	 FpeL32+NHAVMw==
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
	arnd@arndb.de,
	bjorn@rivosinc.com,
	vincenzo.frascino@arm.com,
	stuart.menefy@codasip.com,
	david@redhat.com,
	akpm@linux-foundation.org,
	libang.li@antgroup.com,
	abrestic@rivosinc.com,
	anshuman.khandual@arm.com,
	yongxuan.wang@sifive.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 023/642] riscv: Allow NOMMU kernels to access all of RAM
Date: Mon,  5 May 2025 18:03:59 -0400
Message-Id: <20250505221419.2672473-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 125f5ecd95652..6409fd78ae6fa 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -24,12 +24,9 @@
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
@@ -39,6 +36,9 @@
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
+#else
+#define PAGE_OFFSET		((unsigned long)phys_ram_base)
+#endif /* CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
 
@@ -95,11 +95,7 @@ typedef struct page *pgtable_t;
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
index 050fdc49b5ad7..eb7b25ef556ec 100644
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


