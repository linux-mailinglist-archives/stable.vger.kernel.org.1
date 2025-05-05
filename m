Return-Path: <stable+bounces-140672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06600AAAAB5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D079A2A51
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AE391A74;
	Mon,  5 May 2025 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNuX9KrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93B2DA0E1;
	Mon,  5 May 2025 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485878; cv=none; b=NS5aMBSanPI4uPrhkRTPUNZud+n+CVSPWyUlqfAmvY/YELr5lfpj7ePB5/Z4PiK6wWEwwQWj/zPDXZrTenrMk8OCs4TFOQEI/79RhUpXIcfGf0KvT9jlpqslU0ZbQptaoBMY4Vou44Q7jV9L6e4QM4XJuMkCLXnJmHvxePy3Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485878; c=relaxed/simple;
	bh=j+EfqvvBXY4PJGPy+vQBKg7QLVsn7odm62WHCyOitj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ob8J+HstUr/KqgohV+t3+mnWXQY+IgdeawoF/EYxXAtDwJ1K2hSRlPY+LqbcOKoIFFAKdcHgqMJlrfCuQUixIb2otrnb6bXQY4RqnbGFAef2m0ABh3k8rGdB7Q1dWeGirvHPT5WE9Dps2w6TktcvdCCRzfaZefvRl7may/D+kEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNuX9KrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976DCC4CEF1;
	Mon,  5 May 2025 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485877;
	bh=j+EfqvvBXY4PJGPy+vQBKg7QLVsn7odm62WHCyOitj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNuX9KrTtfpLf+QFXqN5inONXHJyCOBk3NeLNq7pHj9GJS9T2k09F742Ryzm4L1W/
	 sgxXw6vOXlLgWSg+b7TWYGhWnuPJyfO/6Dmmh31xYTWlmFc0C2kXPKqKjHLzAJ3Fxw
	 o0UUNPguVE6rLNdsfZL8W1KSxwVzvrsT3HPifzguIvgJhIuE82kY6FwKi25DxhbfW1
	 +PyCeJoBe9zSjgp4crp928Bg9wwACMfyO7BDgHQwbPJ2vogN1e4ZzZJVz/UJXZHc17
	 yPtgAbzM61iLLdKuuhqVVhUfpthB9FtccYu3adOdkUH8litmrz9lmD48YCD1WqXJH0
	 TzLnuiltN51GA==
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
Subject: [PATCH AUTOSEL 6.6 041/294] x86/mm: Check return value from memblock_phys_alloc_range()
Date: Mon,  5 May 2025 18:52:21 -0400
Message-Id: <20250505225634.2688578-41-sashal@kernel.org>
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
index 71d29dd7ad761..6cbb5974e4f9e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -644,8 +644,13 @@ static void __init memory_map_top_down(unsigned long map_start,
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


