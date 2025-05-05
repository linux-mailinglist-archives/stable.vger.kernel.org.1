Return-Path: <stable+bounces-141487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4EAAB3EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D81895EAA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692D46B211;
	Tue,  6 May 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpjaO/61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B163984A7;
	Mon,  5 May 2025 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486445; cv=none; b=VZhBbKvBn3lPQzC2OL2fxuQyfL2P14pfcmRUGvoMjL0MLhuc46I6PuHVfORtXW4u7GnWfDl0VpMK+7HY802NRkpTq3jEQzSDbLkkUJM3UR/UTYKjka1Y72W0DvSB6MXkUoDy5Q5Xddr16PhN/EBdqzfSRJ/F+UTx52uhjMXZlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486445; c=relaxed/simple;
	bh=CGGgXTmE7gN0LY+x+ksggp3OMcvrTIi17ts48Q6UQDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSmT9XnuDrWPWw4WWlquPvqkBFT8y3kfbN2I9PGJGxfeI62oZG0JpaGvJW2eueEWCiAUw9WSCMod1mrQt/9/2pJ++xBeYC14QoVMw0fIi3NL0YBo+xcOEM6Vk4oBhv73JESTPQgJ2kbGLqApL8wJ16tzv9G7gfwJwFtfQTs3yEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpjaO/61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D3C4CEEE;
	Mon,  5 May 2025 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486444;
	bh=CGGgXTmE7gN0LY+x+ksggp3OMcvrTIi17ts48Q6UQDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpjaO/61QPT9utO58kMU/fORYcYBuCDZ9KUtH2kc506IRUgLCiOLWNsoaSkSLFiuP
	 p7x0whmQZmW/iqCxf/sgwkQWHQELeBv0TbhULWB4lXY7JKaNF6anaTxuVBsYF90jry
	 JinU5AuMU2vTtarXdohDLFbtmYAQI8QFA0/DiMAwJEKqk61Y41jfcVBUlZNMHHDq4+
	 p0Kn3ady1WXKzFch3fo6Icvu3QtBugSgzEGRvu9lLqskaisSlL3bujdjAQefXjhy/i
	 Hiite7JN0E9G9dspUJe9vxrJDZPPJ+psZR0PA094O1ofGSMklPIT/PtuYzyDQrwBnJ
	 pTVxtNT0+6mQg==
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
Subject: [PATCH AUTOSEL 6.1 031/212] x86/mm: Check return value from memblock_phys_alloc_range()
Date: Mon,  5 May 2025 19:03:23 -0400
Message-Id: <20250505230624.2692522-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index ab697ee645288..446bf7fbc3250 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -654,8 +654,13 @@ static void __init memory_map_top_down(unsigned long map_start,
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


