Return-Path: <stable+bounces-186317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F99BE89D8
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 530AD35A803
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB362E5B2A;
	Fri, 17 Oct 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSIVNG3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A71E5B64
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704824; cv=none; b=nFf/U7uRUq/bFJHDq8TKnBnv3ZSb2glYhcPPb3Uuf39mEuHxHfnO1mUKGpw2Y/xfQUI8YnumZt1s6KMX9AdH2Ml/0kdhrYi7eZoGd1s6/GBIvZRX5R7tdTqMulFIsNNcDRFzbvVmu49Pg9bXeJJoG0W0Vwo3uhPPfuLE0xqaL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704824; c=relaxed/simple;
	bh=T5Yi0gD+UUGd9ioMRc1lWVIL8Wn6O4NrGBcJfqvFsUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4ZHYHkuklJlzsM405MR9+r65yEahQ5IPeFiRM6xdR/cbvGEzBrgYwysIe3mtd+rtclvezhzqBnT4zASSMelmT8HFHx4LnHTq04ZW5KoHwRm7hfAcpLxmk1LywZcnQ67+yoawqLute1JgF59Ez55RaRVqEPBjW2D4EjfqV7MVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSIVNG3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B259C4CEE7;
	Fri, 17 Oct 2025 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760704823;
	bh=T5Yi0gD+UUGd9ioMRc1lWVIL8Wn6O4NrGBcJfqvFsUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSIVNG3Rx4jcfHS6ycBBaG3J49EvKzlww8xIOS1iKT2UmiV4nvbC7JWcmU1d8tVn9
	 1xX2EmPzQ2nmWIpuAZXH37m4ai/XYlgXTAvTfSPDk6B4jIvGEkNRCobfCY8kEyZ0RC
	 wrkntbi6U2M3dXAZst9rXEXlzMjHSLfntUNlpG6bErl6oM1epZpqGebpddN4Wujpn9
	 HeezifGHZdZwjICmOJSCoQ+vHbQHRoqZ+k1Y8Yted54g9RiDMbV4qLlThrzlUisrfg
	 jM3LxrKW8y/3BIEZu76UtS7ymFhYO51EcuNU/GeXxvLkoWH+dXLPrCDImheUklRFJp
	 Nhad4QRK7Ec0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Gergely Kovacs <Gergely.Kovacs2@arm.com>,
	Will Deacon <will@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] arm64: mte: Do not flag the zero page as PG_mte_tagged
Date: Fri, 17 Oct 2025 08:40:20 -0400
Message-ID: <20251017124020.3888332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101647-segment-boney-64c3@gregkh>
References: <2025101647-segment-boney-64c3@gregkh>
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
[ replaced page_mte_tagged() and is_zero_page() with test_bit() and is_zero_pfn() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 10 ++++++++--
 arch/arm64/kernel/mte.c        |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e9d1e429456f1..a2518ccc5e980 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1948,16 +1948,22 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
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
-	if (!test_and_set_bit(PG_mte_tagged, &ZERO_PAGE(0)->flags))
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
+	}
 
 	kasan_init_hw_tags_cpu();
 }
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a3898bac5ae6f..7f77fedb09014 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -370,7 +370,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!test_bit(PG_mte_tagged, &page->flags));
+		WARN_ON_ONCE(!test_bit(PG_mte_tagged, &page->flags) &&
+			     !is_zero_pfn(page_to_pfn(page)));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
-- 
2.51.0


