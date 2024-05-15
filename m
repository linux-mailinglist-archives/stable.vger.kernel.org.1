Return-Path: <stable+bounces-45122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B48C604A
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375141C20A2B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C23A29F;
	Wed, 15 May 2024 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v/zOiICb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5c/HVYL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585D381BE;
	Wed, 15 May 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752252; cv=none; b=uVrmJj+58jxVDTwcUajtRhjLDVzJ9IH/xNtw8co3eNtrOsJraV3KxCOCo48In1lIYolPAgPk9Bodh107Bd6BD2deyItlSy2xJEunHu0sAQcsSYlFeff2PN8KHIW2Tznq7GTC9wDwPXIO12jYiZttwOaaO7MqgoIUn/c7XXXjpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752252; c=relaxed/simple;
	bh=aa+fecx7tcAUfdVgnQXf8QxfSZe9AASgNmV1w6cK+ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPhFk9lnEOTdLhTsypyL+nR8qNghzGr3q9OJ3TZ8JQi20oOeaudIOi9NYbJfUACpOlBmhoWiNOwqW1QJURGxW/DPXIeyFoknuwcBW+GLkIPi2uzOnRH9HO3xO9M0NqJGHoRvoZVJCxHrFOGLHwRDmopFrnp6yCkMIKmZU0q64vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v/zOiICb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5c/HVYL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht2zV3Jwo1nvvXt+RYb/7OxyhB2TGOQ0zLq4kftAlWw=;
	b=v/zOiICbwxFvvbkhYTb+BPdiSUlGYgkohq22S5n934KSqzEjHtDwLZcNEOG3ZIk87yScRb
	txKNgenx67ZNeuMLTsLayjc4gQ6KqE/speyfXNjHNnV8EpX79YnhEki0eKmKIN+ipnAu/e
	VO/c3Cg/qoQTFFo7r7U36H0ZXijN41H9AeoMDneSIwrB+FBJHmMfewSYA6iIoPQgKPi7T0
	ANzPrE6+n0D/D09ZW5vHZzG4qISdWsrjEnJgclz8iDlJilyCR79a74IvhZIubEB+cZ0b15
	fj4wcvw+3UQDgwrWulXLz+FwHRRJ5nH71boZztBItkHHDhKHresYrRvRot6MoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht2zV3Jwo1nvvXt+RYb/7OxyhB2TGOQ0zLq4kftAlWw=;
	b=l5c/HVYLvLyXdUH93a45vxSwZGEUso1ZTwv2+/NzTtyLp2LFyX4HFlVW3ws+TGQ1tkeu8l
	JMisrKDY27LCUaCQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled
Date: Wed, 15 May 2024 07:50:39 +0200
Message-Id: <2e391fa6c6f9b3fcf1b41cefbace02ee4ab4bf59.1715750938.git.namcao@linutronix.de>
In-Reply-To: <cover.1715750938.git.namcao@linutronix.de>
References: <cover.1715750938.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debug_pagealloc is a debug feature which clears the valid bit in page table
entry for freed pages to detect illegal accesses to freed memory.

For this feature to work, virtual mapping must have PAGE_SIZE resolution.
(No, we cannot map with huge pages and split them only when needed; because
pages can be allocated/freed in atomic context and page splitting cannot be
done in atomic context)

Force linear mapping to use small pages if debug_pagealloc is enabled.

Note that it is not necessary to force the entire linear mapping, but only
those that are given to memory allocator. Some parts of memory can keep
using huge page mapping (for example, kernel's executable code). But these
parts are minority, so keep it simple. This is just a debug feature, some
extra overhead should be acceptable.

Fixes: 5fde3db5eb02 ("riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
Interestingly this feature somehow still worked when first introduced.
My guess is that back then only 2MB page size is used. When a 4KB page is
freed, the entire 2MB will be (incorrectly) invalidated by this feature.
But 2MB is quite small, so no one else happen to use other 4KB pages in
this 2MB area. In other words, it used to work by luck.

Now larger page sizes are used, so this feature invalidate large chunk of
memory, and the probability that someone else access this chunk and
trigger a page fault is much higher.

 arch/riscv/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2574f6a3b0e7..73914afa3aba 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -682,6 +682,9 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
 				      phys_addr_t size)
 {
+	if (debug_pagealloc_enabled())
+		return PAGE_SIZE;
+
 	if (pgtable_l5_enabled &&
 	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
-- 
2.39.2


