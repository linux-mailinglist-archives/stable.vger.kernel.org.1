Return-Path: <stable+bounces-167215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD6B22D35
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8EE1893F41
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502E2F747B;
	Tue, 12 Aug 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NJuENIOm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B512F744F
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015418; cv=none; b=jSMYCkKhLt4K+PvObYmVMq75bnImiz/DFOu4j1FB6OjP7/5Q07Gz8c25t7oMOIiVyBEkL/G22JJbAZ8za1Mx8xF80tgu9O9pez8BbXA+gGZw0LnjVXSlJ/6s5mTPBTZH+ib2hPaPLKjtnxhPEaPWHrw03uvl9xnNIP9ixZBcS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015418; c=relaxed/simple;
	bh=LEErqAAwkXBX0BBhkbEVFEo4Sd7pDls5rKBKLa+0omE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nc1g/8BAHCh1iHjq4K+APkkbIIvGm9FlklkuXSMq6i2T6ElNgH3hN+QQlLxYqnDy0KL2Rq1GY+Ux4atzHhnmgdOLm7B+7oVhIz/R9rZbKAKhT+2gmxAIvqt3AAFuOtO9ePVFOjUuZ323zbDCVfeXVTfVLnK2ssNrTzzS5SBzbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NJuENIOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3856BC4CEF0;
	Tue, 12 Aug 2025 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015418;
	bh=LEErqAAwkXBX0BBhkbEVFEo4Sd7pDls5rKBKLa+0omE=;
	h=Subject:To:Cc:From:Date:From;
	b=NJuENIOmHlC0z9koybSDh1YJejvoO3NS0mWuUNLyupUJfmd6bG93GoudUWKCv2PPN
	 1Gf2SQ/pPY+vmCmIjsvSzmIsEj1OBXg7RutaroNKJz50NHVbc1GUpMIpjAimoAlBhR
	 Y3qmgicjqVy3l/rl+tntPWDUN3Ht84WevFnPMo6I=
Subject: FAILED: patch "[PATCH] s390/mm: Remove possible false-positive warning in" failed to apply to 6.6-stable tree
To: gerald.schaefer@linux.ibm.com,agordeev@linux.ibm.com,imbrenda@linux.ibm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:16:55 +0200
Message-ID: <2025081255-shabby-impound-4a47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5647f61ad9171e8f025558ed6dc5702c56a33ba3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081255-shabby-impound-4a47@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5647f61ad9171e8f025558ed6dc5702c56a33ba3 Mon Sep 17 00:00:00 2001
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Date: Wed, 9 Jul 2025 20:34:30 +0200
Subject: [PATCH] s390/mm: Remove possible false-positive warning in
 pte_free_defer()

Commit 8211dad627981 ("s390: add pte_free_defer() for pgtables sharing
page") added a warning to pte_free_defer(), on our request. It was meant
to warn if this would ever be reached for KVM guest mappings, because
the page table would be freed w/o a gmap_unlink(). THP mappings are not
allowed for KVM guests on s390, so this should never happen.

However, it is possible that the warning is triggered in a valid case as
false-positive.

s390_enable_sie() takes the mmap_lock, marks all VMAs as VM_NOHUGEPAGE and
splits possibly existing THP guest mappings. mm->context.has_pgste is set
to 1 before that, to prevent races with the mm_has_pgste() check in
MADV_HUGEPAGE.

khugepaged drops the mmap_lock for file mappings and might run in parallel,
before a vma is marked VM_NOHUGEPAGE, but after mm->context.has_pgste was
set to 1. If it finds file mappings to collapse, it will eventually call
pte_free_defer(). This will trigger the warning, but it is a valid case
because gmap is not yet set up, and the THP mappings will be split again.

Therefore, remove the warning and the comment.

Fixes: 8211dad627981 ("s390: add pte_free_defer() for pgtables sharing page")
Cc: <stable@vger.kernel.org> # 6.6+
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index b449fd2605b0..d2f6f1f6d2fc 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -173,11 +173,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
 	call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
-	/*
-	 * THPs are not allowed for KVM guests. Warn if pgste ever reaches here.
-	 * Turn to the generic pte_free_defer() version once gmap is removed.
-	 */
-	WARN_ON_ONCE(mm_has_pgste(mm));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 


