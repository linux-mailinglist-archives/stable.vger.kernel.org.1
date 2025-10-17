Return-Path: <stable+bounces-187147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6CDBEA30E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B57455A4190
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53263328E8;
	Fri, 17 Oct 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ug4Y9UTh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912ED2F12D9;
	Fri, 17 Oct 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715247; cv=none; b=qeA7Jo2TLcevJ7prekWPrgqHWOqhmnmaiV56KI15A261+Xaey5sEybmdnaxt9kiw6+Xv2BDLXaXNe+FXiOO1/66Znj/6Q7NMkDIKTaK/6QNBfavnC2EGdiikl2c/Fc7zOjdlzljkYcCyodl8gx71dRvQ57rKVbMJFQtP2XF5NZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715247; c=relaxed/simple;
	bh=JItUip/RIjVrd+bZ1GCz8iJN/eUDL5oBNlofZLwxu4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAw2N5v3QBcLvi6tycM+Qnz+W+Ijs/iZG8dNfwE9e6Q+BUROFp6AaPuRjE9UH7bZq2jJHbzqNU34okQYYwpB6cmwTW9clVhtlAwNOzN/hSzZ9rqnUNdPWnohx+TB31XMEIu7wVFNiXVv4wg7FZNmOCQRcPcpqgYA50iYNkDH//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ug4Y9UTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A0C4CEE7;
	Fri, 17 Oct 2025 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715247;
	bh=JItUip/RIjVrd+bZ1GCz8iJN/eUDL5oBNlofZLwxu4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ug4Y9UThyPmtOOIn6Jhez2pIDud/jKCX8J6JhMo9ncMDi2Py2ls3TT05vJiuhGfVW
	 +S4fxpcFURA8Oals0raPoYG6vVP5CiLsp6ChBxXOzoDVAbrla21Qgz3E5/X4CCIBJH
	 fPky22u7qdPX1T7EOSVV0PGOftOySUYxNa+bk3MM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gergely Kovacs <Gergely.Kovacs2@arm.com>,
	Will Deacon <will@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 6.17 149/371] arm64: mte: Do not flag the zero page as PG_mte_tagged
Date: Fri, 17 Oct 2025 16:52:04 +0200
Message-ID: <20251017145207.324564133@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit f620d66af3165838bfa845dcf9f5f9b4089bf508 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   10 +++++++---
 arch/arm64/kernel/mte.c        |    2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2408,17 +2408,21 @@ static void bti_enable(const struct arm6
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
-	if (try_page_mte_tagging(ZERO_PAGE(0))) {
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
-		set_page_mte_tagged(ZERO_PAGE(0));
 	}
 
 	kasan_init_hw_tags_cpu();
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -460,7 +460,7 @@ static int __access_remote_tags(struct m
 		if (folio_test_hugetlb(folio))
 			WARN_ON_ONCE(!folio_test_hugetlb_mte_tagged(folio));
 		else
-			WARN_ON_ONCE(!page_mte_tagged(page));
+			WARN_ON_ONCE(!page_mte_tagged(page) && !is_zero_page(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);



