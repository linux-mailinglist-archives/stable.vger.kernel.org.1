Return-Path: <stable+bounces-195320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8CC754DB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 308EA35852F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FABF2E0400;
	Thu, 20 Nov 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iz9F7hES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F433BBB2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655090; cv=none; b=KyRM4EImF+icFMlK0FLfxf/sQmlcJbaVMH3fWgOOE+FcVx6SV/fHT8p6mqaTATyfXznGj5JVHglRcmIAc3ur9baT+7m2WyLmRBhbcwEaMx6eA4GXZzsNvLKmqlN5Ba78vLufDj2h+yApYqL7lbv5iaxlZ4r1ITf3gkVaoam5OPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655090; c=relaxed/simple;
	bh=osjCowjAMM7psSitQ1JPkB+NhuliJfF7jynP1FEK22I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vAjEHvYjqOZaTO9OTUeQ1QJ6SNEF9OY3a+YWt/7Nxd/DryCE0pjfIWhq6g5ZphTW7fCLzc/OSUuX7Y8SAUipkOKdLsOx0mooQL1MBKTPQAsC6HegmpaX0cyA2x6m17qAAeM7bOfzaBmIjxkRuCWTlGXbU8ic2pLMPyxxNI7UQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iz9F7hES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E8DC4CEF1;
	Thu, 20 Nov 2025 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655089;
	bh=osjCowjAMM7psSitQ1JPkB+NhuliJfF7jynP1FEK22I=;
	h=Subject:To:Cc:From:Date:From;
	b=Iz9F7hESre3tSgf2zOdxyJh9m2CPApx4ik+GJEO8DBYPRPuvC3xbKwTpvQwYBw+rS
	 AT80WM6WRCFdybGAjf6lyOLzf9Cgi2gnvlrplZ8awN0fo9U/KK3YhnHUj6myDECuXR
	 3R+EJNyNW7AkB26xMN/hjs66I1mNkSBB+s77tATk=
Subject: FAILED: patch "[PATCH] mm/secretmem: fix use-after-free race in fault handler" failed to apply to 6.6-stable tree
To: lance.yang@linux.dev,akpm@linux-foundation.org,big-sleep-vuln-reports@google.com,david@redhat.com,lorenzo.stoakes@oracle.com,rppt@kernel.org,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:11:21 +0100
Message-ID: <2025112021-swept-idealness-9ecb@gregkh>
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
git cherry-pick -x 6f86d0534fddfbd08687fa0f01479d4226bc3c3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112021-swept-idealness-9ecb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f86d0534fddfbd08687fa0f01479d4226bc3c3d Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Fri, 31 Oct 2025 20:09:55 +0800
Subject: [PATCH] mm/secretmem: fix use-after-free race in fault handler

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a folio and removing the page from the direct map, but only
one would succeed in adding the folio to the file mapping.  The task that
failed undoes the effects of its attempt by (a) freeing the folio again
and (b) putting the page back into the direct map.  However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and the
kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the folio is freed.

Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..b59350daffe3 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 


