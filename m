Return-Path: <stable+bounces-116877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA4A3A991
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD823B6BB3
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21702213E99;
	Tue, 18 Feb 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIYzae7X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD896213E8E;
	Tue, 18 Feb 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910433; cv=none; b=tVbDC/nyZ+B22DkclBO6xQsuR4rxlw01Rwe/bp57M0B9X7ZpdvTb8Bx54SatOblnTquQcJRduC5Hl2NitjFMepZpMwma4/MfM0quMOrvpzrlPD830XkRcxD1LurQBWH4XTBv74oXJoYZXao+i6aQbQl6ysHzSwwZq7h/987hYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910433; c=relaxed/simple;
	bh=VbJld1Jx2lXlXIBAg/Vno7nPT2Irbktj0tyJw4CkGCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVzAoUlz7Og7Umfd7cMIKXNTjWzoUwgfV2mmUogPvX/E9vEHoI2brTYgptFJFxq095zGEze2gtLy/QxaGkWJZy1AjNuoiR+Mj4keWj5vDDDtP0kFI0K9OQF1M1nz3etea8uSuLiXj+FwPk73bFEhQuyIEsUDdfjRKq8hItE/kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIYzae7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560A1C4CEE2;
	Tue, 18 Feb 2025 20:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910433;
	bh=VbJld1Jx2lXlXIBAg/Vno7nPT2Irbktj0tyJw4CkGCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIYzae7XBvNEiqfQ94ck2vFRYPsE7C6gr0iYh6e4Ys3qZz/LB0vyr+OG48quhfURM
	 LsvxXK05Nm5IywKRSBTzZyV39VSNX11bzhGNOnjO4epRCLNDHjcINad0U8B2Q/jfKS
	 qkEzOCIPxPjhhy0L2LN+p3QyI7TzFYsI78xvr+xdhEY7tvYQXrC825SVJ21eSbKgXV
	 uWlBh+rKKv9LJNcscS7xqkWjIcfSZ8+bhWsHPOalJOA0hmpdrCzOn/PQuFJncs58eO
	 VYy8AEbuboMbixNt5yFEwdYPlpq0ZwqEIzyk/GuriyY4CRgVyR5qpTr2yhCCDeMwkn
	 TCol3tjFqM9tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	rppt@kernel.org,
	mcgrof@kernel.org,
	akpm@linux-foundation.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 24/31] LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE
Date: Tue, 18 Feb 2025 15:26:10 -0500
Message-Id: <20250218202619.3592630-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 619b52777a4972bdb6ddf86ac54c6f68a47b51c4 ]

Now kernel_page_present() always return true for KPRANGE/XKPRANGE
addresses, this isn't correct because hibernation (ACPI S4) use it
to distinguish whether a page is saveable. If all KPRANGE/XKPRANGE
addresses are considered as saveable, then reserved memory such as
EFI_RUNTIME_SERVICES_CODE / EFI_RUNTIME_SERVICES_DATA will also be
saved and restored.

Fix this by returning true only if the KPRANGE/XKPRANGE address is in
memblock.memory.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index ffd8d76021d47..aca4e86d2d888 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
+#include <linux/memblock.h>
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
 #include <asm/set_memory.h>
@@ -167,7 +168,7 @@ bool kernel_page_present(struct page *page)
 	unsigned long addr = (unsigned long)page_address(page);
 
 	if (addr < vm_map_base)
-		return true;
+		return memblock_is_memory(__pa(addr));
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(pgdp_get(pgd)))
-- 
2.39.5


