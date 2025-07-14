Return-Path: <stable+bounces-161819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59ADB03A44
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769BD7AA730
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5C23AB88;
	Mon, 14 Jul 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L914gAz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F87CA6B
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483939; cv=none; b=OhedE5k19JsBhEN34ZQw5wbNF5+VoRBqiFWQBM9hA6c2GUAug7HT2AUrjb+fo/mqmVGCJ7m3DRsP9Xj3RyWoZOEexPUZobeAwkC2j9drc6biIGsiNzf15gDMuR9k/PFW7Gf+oG0saWbjtYF+aUdbVXVUkRny36oSqpXIlPchV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483939; c=relaxed/simple;
	bh=4fHU0tAhEpD0woxkC9lChz6VEwaQn1fEiSMjf9kgpNU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rBbOc31QqALplZFk+Em7V5i8hu1854+cjih79ff5bfQBCzmt3DHwLQtXc0Ir1DHSOpBqUkF+Gg3kR4KTmLbUsb3NNxBzVaA9sgJV7epYuHRNzZLGiCK/4g26Q+dU+VvpJrG+wXUPAxZETELyiFNAU0QwSjJBjr3vkrHqV/aOxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L914gAz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E125FC4CEED;
	Mon, 14 Jul 2025 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752483938;
	bh=4fHU0tAhEpD0woxkC9lChz6VEwaQn1fEiSMjf9kgpNU=;
	h=Subject:To:Cc:From:Date:From;
	b=L914gAz0vwNBLyvghCzrKoya2/xExXVk47p910ZX1bXg4tMXfzZkIHg1YClp83Vbp
	 +dJ8shl5OTPMuOJp4N9FKw+g81ZynT+MluYJWDzAoPkxJsMflZJWJkcGBbXngJpzZW
	 h5wjHYPk84AiQYrQL2oiGWcao6CV+/mNsfM4KCdE=
Subject: FAILED: patch "[PATCH] x86/mm: Disable hugetlb page table sharing on 32-bit" failed to apply to 5.4-stable tree
To: jannh@google.com,dave.hansen@intel.com,dave.hansen@linux.intel.com,david@redhat.com,osalvador@suse.de,vt@altlinux.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Jul 2025 11:05:23 +0200
Message-ID: <2025071423-imbecile-slander-d8e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071423-imbecile-slander-d8e9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Wed, 2 Jul 2025 10:32:04 +0200
Subject: [PATCH] x86/mm: Disable hugetlb page table sharing on 32-bit

Only select ARCH_WANT_HUGE_PMD_SHARE on 64-bit x86.
Page table sharing requires at least three levels because it involves
shared references to PMD tables; 32-bit x86 has either two-level paging
(without PAE) or three-level paging (with PAE), but even with
three-level paging, having a dedicated PGD entry for hugetlb is only
barely possible (because the PGD only has four entries), and it seems
unlikely anyone's actually using PMD sharing on 32-bit.

Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
has 2-level paging) became particularly problematic after commit
59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
the `pt_share_count` (for PMDs) share the same union storage - and with
2-level paging, PMDs are PGDs.

(For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
configuration of page tables such that it is never enabled with 2-level
paging.)

Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Vitaly Chikunov <vt@altlinux.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250702-x86-2level-hugetlb-v2-1-1a98096edf92%40google.com

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..4e0fe688cc83 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,7 +147,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64


