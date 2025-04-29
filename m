Return-Path: <stable+bounces-137411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D078CAA12E8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0647A8951
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C6248879;
	Tue, 29 Apr 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvP6bEFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DB244668;
	Tue, 29 Apr 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945988; cv=none; b=ZgGvagA5MNsBDqShonDQ3lw2UnzPK2nI4BqaXD61S0fN3btk4Hc7a+uwuJ8Z/cpiQV8t5ScpfdSpgVW/x38CTsUYDEOsvJ1hj/NJwq0h7kOnQaswE/LQGIdjgqAiVEgCfgEXRpAIBns8c7BA/spilk8ZmngS2bXoOfyKL2fXhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945988; c=relaxed/simple;
	bh=HRPOBqUSEx58FIzZrU+6mD0su9MIvyWDkmT007rIXRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysc+bZ1/qpquNje1cMOVy9wKvQvmE121jZzgxRRQlo7WJhdOURlu7LtGT3cJfJtcTqULh7nNkAkyk/Mxk3KpSAo6216I9G12fYxR33X3BykVxgJCdyBofhKL6rN7um+jkNZTTC+kDn9MpfnQgh+3zvYNvUagFEgmtd09VGv7Cyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvP6bEFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6171DC4CEE3;
	Tue, 29 Apr 2025 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945987;
	bh=HRPOBqUSEx58FIzZrU+6mD0su9MIvyWDkmT007rIXRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvP6bEFtOYPei/q0ib6bipM9uzdLK3Kz72BYst8aFWefTORSdw/Tg+ryR+SQZruej
	 /JSxEub9RGN11wOoEgSoKugvA32wj6HKrs8ZgU9G2y/ECanY/a2neVVIupJXcl9QY8
	 +cnYCJaobJaBDVwTF31ypyWsVhE/HjdsStouZm3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 086/311] riscv: Replace function-like macro by static inline function
Date: Tue, 29 Apr 2025 18:38:43 +0200
Message-ID: <20250429161124.573368156@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 121f34341d396b666d8a90b24768b40e08ca0d61 ]

The flush_icache_range() function is implemented as a "function-like
macro with unused parameters", which can result in "unused variables"
warnings.

Replace the macro with a static inline function, as advised by
Documentation/process/coding-style.rst.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250419111402.1660267-1-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/cacheflush.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8de73f91bfa37..b59ffeb668d6a 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -34,11 +34,6 @@ static inline void flush_dcache_page(struct page *page)
 	flush_dcache_folio(page_folio(page));
 }
 
-/*
- * RISC-V doesn't have an instruction to flush parts of the instruction cache,
- * so instead we just flush the whole thing.
- */
-#define flush_icache_range(start, end) flush_icache_all()
 #define flush_icache_user_page(vma, pg, addr, len)	\
 do {							\
 	if (vma->vm_flags & VM_EXEC)			\
@@ -78,6 +73,16 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+/*
+ * RISC-V doesn't have an instruction to flush parts of the instruction cache,
+ * so instead we just flush the whole thing.
+ */
+#define flush_icache_range flush_icache_range
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_icache_all();
+}
+
 extern unsigned int riscv_cbom_block_size;
 extern unsigned int riscv_cboz_block_size;
 void riscv_init_cbo_blocksizes(void);
-- 
2.39.5




