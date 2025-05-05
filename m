Return-Path: <stable+bounces-140467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A4AAA900
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787F517649B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC32357D50;
	Mon,  5 May 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joXavFqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAF2989AD;
	Mon,  5 May 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484909; cv=none; b=DAnegFud5vOgx45ZtvLsmH2RDiadvnrEOefY/bIEa4pCOYqqptrwJ2ZdmFADb1mbiW21wdR16xJv8hMDAFn06sNX+nvRpxJ8QvJaUwflZggNMpFw8mfmR7x6D6X9rkv57oHgETd6EqSxvUmgE2Afgje9EE2MvXdhewJcalPYUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484909; c=relaxed/simple;
	bh=bHyz8c5tpBcqMqkz5kIdDIq0oeqPCdzWTDQUhNkqZGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYPrd5BbvKwxqOTzlJq8IYEg6drgGM7mDmMokgDe7iZqNEIrqQwWrd5U1jQDeIyjHz3RIaJonZKKP/vHOdI8HA9f7WWgpBSuva2ylg72+TJpaF+bF9S6AcK/ORaLcPwomDY8V0j8mWyjbozDxC6BfuPNAYV7G50dIveFdckj9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joXavFqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD561C4CEEE;
	Mon,  5 May 2025 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484909;
	bh=bHyz8c5tpBcqMqkz5kIdDIq0oeqPCdzWTDQUhNkqZGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joXavFqo/hmo2bDXI4o7T09XGkPpf+mbqeIrfgwkh5VjgnTjfJeVQYKqGBUPAC0sm
	 vAymu44zg5eUAARoFdPgw5jNGo/sTYvlJ8wAsDnGv6dhJZtZsuoPQGRhti8rpYCia7
	 FTmJkN8M226OqxJwwgJZsjvF88ufzhM0XcpFfRQx1nbp7HDifxCYQjHx+rnRGu1UdN
	 IoR64k0N2tVP+N9LhmZdxf2cxoJ9U4LJT50nsJeMJ8D2lBsZcEfjnOpI/2oRyJQ8Vv
	 LLbdcvQZQm6DKE8SB7Giq5IYVBRx+WBWlKRVzdbqBra+H5scuSywxnVdeZ8sZKqkUJ
	 i1hGEl8zHTkeA==
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
Subject: [PATCH AUTOSEL 6.12 069/486] x86/mm: Check return value from memblock_phys_alloc_range()
Date: Mon,  5 May 2025 18:32:25 -0400
Message-Id: <20250505223922.2682012-69-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 101725c149c42..9cbc1e6057d3c 100644
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


