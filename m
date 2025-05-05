Return-Path: <stable+bounces-139836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6BAAA09D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FC3BCD61
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4A293754;
	Mon,  5 May 2025 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I30BnIpK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48B29374C;
	Mon,  5 May 2025 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483513; cv=none; b=AdCTBTfeCN+I/RH4A3RYMlLoPUvWhmUiNuG7ZrnGF+/Zgdth7V7FBtGxHdzhKu7KavvyCkdzjxz1AhvuyCbyNtvPh8OxVWrHlTqhw9m7e0PpQhXmaK6ecp6+yT0j9Jq5OmHojC0gctD3FLNuGwTknhklN3CxLeAYndQpged19a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483513; c=relaxed/simple;
	bh=XgH3XKm1IAc32eD0g9jNld7LDdIY89FxHXmbpYkLaJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCg4jjDCHjBYBZ0NZ+Oe8OfWwUg/LkTJgGL4UqD+bSd0BI52xBIS/JSUPijSYrYCLgao+lBxMi94qp9XS0lRzxJPjrBPbqBn8CT/jcH760YIUtzNw44kj59984rwXq2E3xIK/lSjPXC12rBEJPSICNPD91gJO7TVTRu0RsigzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I30BnIpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B061C4CEEE;
	Mon,  5 May 2025 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483513;
	bh=XgH3XKm1IAc32eD0g9jNld7LDdIY89FxHXmbpYkLaJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I30BnIpK8ZqIzT/YffNhvvDCoT5dJfuTrbdPrYqJ9aT0eVo6aR11oDlXLFMSKQ2Br
	 g8APrRvlCKQMunYlNhRvGcmO5UnMrkbtTcLIuR5vtMeuo+jCh0xEv7mHNGcjUsBLdy
	 +2VLhpcxqF0ykORy6Hj9tp1bDtbOdeSVrcIxBk74EN3Gd4f32L1QkHaCTUgrMhR1Na
	 aecuWvKM7vD+Z9Nel7HGKYgXx4uwy+REsCN26eoq8n49gIS40IFdkgm42jFBlZ0+JG
	 /E4xMjsfFGC2TbXeFGnYBi1k10vzHvQOoQo193UiAsWIHkcQVy0FJKfW3Kr3Wy+u/P
	 N/eYbBdekN7GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Redkin <me@rarity.fan>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@surriel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.14 089/642] x86/mm: Check return value from memblock_phys_alloc_range()
Date: Mon,  5 May 2025 18:05:05 -0400
Message-Id: <20250505221419.2672473-89-sashal@kernel.org>
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

From: Philip Redkin <me@rarity.fan>

[ Upstream commit 631ca8909fd5c62b9fda9edda93924311a78a9c4 ]

At least with CONFIG_PHYSICAL_START=0x100000, if there is < 4 MiB of
contiguous free memory available at this point, the kernel will crash
and burn because memblock_phys_alloc_range() returns 0 on failure,
which leads memblock_phys_free() to throw the first 4 MiB of physical
memory to the wolves.

At a minimum it should fail gracefully with a meaningful diagnostic,
but in fact everything seems to work fine without the weird reserve
allocation.

Signed-off-by: Philip Redkin <me@rarity.fan>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 62aa4d66a032d..bfa444a7dbb04 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -645,8 +645,13 @@ static void __init memory_map_top_down(unsigned long map_start,
 	 */
 	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
 					 map_end);
-	memblock_phys_free(addr, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
+	if (!addr) {
+		pr_warn("Failed to release memory for alloc_low_pages()");
+		real_end = max(map_start, ALIGN_DOWN(map_end, PMD_SIZE));
+	} else {
+		memblock_phys_free(addr, PMD_SIZE);
+		real_end = addr + PMD_SIZE;
+	}
 
 	/* step_size need to be small so pgt_buf from BRK could cover it */
 	step_size = PMD_SIZE;
-- 
2.39.5


