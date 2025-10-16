Return-Path: <stable+bounces-185901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FABE2328
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AE619A79EA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0D305966;
	Thu, 16 Oct 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAZkxY2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FF2FF14D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604117; cv=none; b=XRi46w/TG6JF5LIFXsMnmXZQBqgBNBtPsoU4N2I4iL4HysIhHwHKhiXBp3PIfv3dPdhbVPgcj9i7MMyZ5evtXRHt05B7QXxozfyLwwouQzGJtCP/AVK+qTT6Y0Rrrm9VTgUABrFN98KwM/TWNQj5+IdP3xHA5bXoPKeuAmH+L2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604117; c=relaxed/simple;
	bh=t9NvzSHny9utUsa7du2pUk6HBWdsI4g6z37GLZsX4+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OlbiLgQ8O768Q6S1Ag00hAIsL8ky/Bbq8YORqs3PiLaAUbm5jmuFWoPjKL0EPU8Ctz0tmirvd1IShGS8+/nO85RYr34/g9rDS0ZjgWf0VQ7h4wYqC4uPqaJHPfRqTq8YTvF8FBD/fvGrRX9PNMEi6pV5vRaTie/M3B5hWx/+q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAZkxY2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADE8C4CEF1;
	Thu, 16 Oct 2025 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760604116;
	bh=t9NvzSHny9utUsa7du2pUk6HBWdsI4g6z37GLZsX4+Q=;
	h=Subject:To:Cc:From:Date:From;
	b=hAZkxY2xA+8dmwip221lRerMQRfBUAU1TcwhttwrTGuOK9Ch963rw8Yq0fL7roz6U
	 RDrBvRRI0+YINvQ16HkUr3RQeccnWLvI04lWATzJ3NUINacaJ1Kj/jiZWz4LA1gnl1
	 tnBWJOrpw4ngKOyelg5++z6oMVy5L8TErLgPdfw4=
Subject: FAILED: patch "[PATCH] arm64: mte: Do not flag the zero page as PG_mte_tagged" failed to apply to 5.15-stable tree
To: catalin.marinas@arm.com,Gergely.Kovacs2@arm.com,david@redhat.com,lance.yang@linux.dev,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:41:47 +0200
Message-ID: <2025101647-segment-boney-64c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f620d66af3165838bfa845dcf9f5f9b4089bf508
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101647-segment-boney-64c3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f620d66af3165838bfa845dcf9f5f9b4089bf508 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 24 Sep 2025 13:31:22 +0100
Subject: [PATCH] arm64: mte: Do not flag the zero page as PG_mte_tagged

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

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ecb83ab0700e..7345987a50a0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2303,17 +2303,21 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
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
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e5e773844889..63aed49ac181 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -460,7 +460,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		if (folio_test_hugetlb(folio))
 			WARN_ON_ONCE(!folio_test_hugetlb_mte_tagged(folio));
 		else
-			WARN_ON_ONCE(!page_mte_tagged(page));
+			WARN_ON_ONCE(!page_mte_tagged(page) && !is_zero_page(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);


