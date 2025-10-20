Return-Path: <stable+bounces-188173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B3BF2541
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87C7188E6C9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CDF27E1A1;
	Mon, 20 Oct 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDT49Oeq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C81CEADB
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976763; cv=none; b=mftdnOl8jbTY066DEVlNm2YCt0FH+SPU6snhF0wwloFsDogI90NHCkR/VUnvLmuUDyYZrJ9db8alULSR6gCALMTb1dy8cGhkLQH0khktFJCNbiqZ1u/1EZV1XahI4MtyxC2RobnUHcOm+S9SpZc9AZQcvQBSJL+ZFcUMN5qgvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976763; c=relaxed/simple;
	bh=9hnyOBB63VXBXqm+gVAMs4N+GAOdJMM4pduW3VvjjDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siQmxZUr0j/NSd7hQX5y+O4Pic0VFM7Wn23bZv+kZ63kj2qQ9onVYaczb724yAEGjJSMGn1gF9g6hpnr6A/M6uyvS+ObohiB0uS+ekw5RJw1dgzkfS6ZX9rjm2HAzTi1c0vrhlmtEsqg4L5EbJFs5LGUR87Qhj5OTWAlwXUOnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDT49Oeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5627C4CEF9;
	Mon, 20 Oct 2025 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976762;
	bh=9hnyOBB63VXBXqm+gVAMs4N+GAOdJMM4pduW3VvjjDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDT49OeqB69D2TALdAgTvj4gBLeNMKIibdT/D8nTmB036CH5clPR5mi+iNBLAkowA
	 gcqpwxb2+6MsHy6MFdLEsidLovIhzSlbijYoZOkZmQ/arNcioUjPaU+aqFxsRfYRBS
	 lf7o60foUVgWf+HrDaMz1iOSqg8TfirUf/imOsrVLa1ccPqLVSbUr6xdYZbdQf2eiO
	 bEEvVHuNQisO9Isg0PQeA8HrfE9tJ9XFtOl9TDSiXhf+sGZ2hxdGWhMmGXONerJ6XX
	 XlCggpl1x90SxVdykSPqtrHpzJFdlnJysZjF9bMudVVth56mbjmPyW3wGtvC4Z8XSs
	 cjyB24LCkKq6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Gergely Kovacs <Gergely.Kovacs2@arm.com>,
	Will Deacon <will@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: mte: Do not flag the zero page as PG_mte_tagged
Date: Mon, 20 Oct 2025 12:12:38 -0400
Message-ID: <20251020161238.1833261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101646-headroom-why-f582@gregkh>
References: <2025101646-headroom-why-f582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit f620d66af3165838bfa845dcf9f5f9b4089bf508 ]

Commit 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to the
zero page") attempted to fix ptrace() reading of tags from the zero page
by marking it as PG_mte_tagged during cpu_enable_mte(). The same commit
also changed the ptrace() tag access permission check to the VM_MTE vma
flag while turning the page flag test into a WARN_ON_ONCE().

Attempting to set the PG_mte_tagged flag early with
CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled may either hang (after commit
d77e59a8fccd "arm64: mte: Lock a page for MTE tag initialisation") or
have the flags cleared later during page_alloc_init_late(). In addition,
pages_identical() -> memcmp_pages() will reject any comparison with the
zero page as it is marked as tagged.

Partially revert the above commit to avoid setting PG_mte_tagged on the
zero page. Update the __access_remote_tags() warning on untagged pages
to ignore the zero page since it is known to have the tags initialised.

Note that all user mapping of the zero page are marked as pte_special().
The arm64 set_pte_at() will not call mte_sync_tags() on such pages, so
PG_mte_tagged will remain cleared.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to the zero page")
Reported-by: Gergely Kovacs <Gergely.Kovacs2@arm.com>
Cc: stable@vger.kernel.org # 5.10.x
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>
Acked-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Will Deacon <will@kernel.org>
[ removed folio-based hugetlb MTE checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++++---
 arch/arm64/kernel/mte.c        |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5d2322eeee476..547c47358133c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2068,17 +2068,21 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	static bool cleared_zero_page = false;
+
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
 
 	mte_cpu_setup();
 
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
-	 * linear map which has the Tagged attribute.
+	 * linear map which has the Tagged attribute. Since this page is
+	 * always mapped as pte_special(), set_pte_at() will not attempt to
+	 * clear the tags or set PG_mte_tagged.
 	 */
-	if (!page_mte_tagged(ZERO_PAGE(0))) {
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
-		set_page_mte_tagged(ZERO_PAGE(0));
 	}
 
 	kasan_init_hw_tags_cpu();
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e20af03b4cdfa..da0f93c5e6756 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -456,7 +456,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+		WARN_ON_ONCE(!page_mte_tagged(page) && !is_zero_page(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
-- 
2.51.0


