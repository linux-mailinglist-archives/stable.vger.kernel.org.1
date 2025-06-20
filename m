Return-Path: <stable+bounces-155143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4AAE1E35
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DB44C0A0B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F642BE7C3;
	Fri, 20 Jun 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHnsDAk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6B2BD03D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432317; cv=none; b=VcF7USPg7PKnFblOWTaFfZDw42aQJyPYEilnPfFx1FwVt2SseVEpe2hJ7l52t8ab4zSZxKeCw3S19gzkIv4VzUL9kmvTv15rF4fBk7yz3zmYLdx2fn4osMTQqmMlEEKeteO6tAie2pzlXuRgzlWBWPV1cYH4hZWv/Gwt8MsHzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432317; c=relaxed/simple;
	bh=eqAQTGzLflIYkvwgj1dYWu9vWFPcQequqXT9rorNpNo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=deROF92vlSwPbXHVlYZeaLQN+PvcLlTCWwXvzOSFPDPwafpQI6+bVv5K/7jF81Wdpghk7dPDxhpvsVUOZAhEqqq8s3VP2Qk5p9mlMPq45CnD2KNOpuigXO2dy+PKIhDKg1DuOtGiM7+rxzZapMTt8pJyP8WwYU4+PYeeckbmsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHnsDAk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BEEC4CEE3;
	Fri, 20 Jun 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432316;
	bh=eqAQTGzLflIYkvwgj1dYWu9vWFPcQequqXT9rorNpNo=;
	h=Subject:To:Cc:From:Date:From;
	b=FHnsDAk+uBDFH0HG2qbqC7wzVuRPz5AjBB5foyb0i8hGVyFhz4YEWZ6vHs98dK/+U
	 kDddVlyXIB9tC8dHVNEyJI96ze13JtBIFBRjs2fIZ3T1K6/hy3e22YFwdXmeZEwDmd
	 04B+TPOVjBtqN8AzHTAf/zCMPsb7JLI5N1al3QFk=
Subject: FAILED: patch "[PATCH] mm/vma: reset VMA iterator on commit_merge() OOM failure" failed to apply to 6.12-stable tree
To: lorenzo.stoakes@oracle.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,jannh@google.com,pfalcato@suse.de,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:11:53 +0200
Message-ID: <2025062053-gills-deliverer-bafc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0cf4b1687a187ba9247c71721d8b064634eda1f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062053-gills-deliverer-bafc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cf4b1687a187ba9247c71721d8b064634eda1f7 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 6 Jun 2025 13:50:32 +0100
Subject: [PATCH] mm/vma: reset VMA iterator on commit_merge() OOM failure

While an OOM failure in commit_merge() isn't really feasible due to the
allocation which might fail (a maple tree pre-allocation) being 'too small
to fail', we do need to handle this case correctly regardless.

In vma_merge_existing_range(), we can theoretically encounter failures
which result in an OOM error in two ways - firstly dup_anon_vma() might
fail with an OOM error, and secondly commit_merge() failing, ultimately,
to pre-allocate a maple tree node.

The abort logic for dup_anon_vma() resets the VMA iterator to the initial
range, ensuring that any logic looping on this iterator will correctly
proceed to the next VMA.

However the commit_merge() abort logic does not do the same thing.  This
resulted in a syzbot report occurring because mlockall() iterates through
VMAs, is tolerant of errors, but ended up with an incorrect previous VMA
being specified due to incorrect iterator state.

While making this change, it became apparent we are duplicating logic -
the logic introduced in commit 41e6ddcaa0f1 ("mm/vma: add give_up_on_oom
option on modify/merge, use in uffd release") duplicates the
vmg->give_up_on_oom check in both abort branches.

Additionally, we observe that we can perform the anon_dup check safely on
dup_anon_vma() failure, as this will not be modified should this call
fail.

Finally, we need to reset the iterator in both cases, so now we can simply
use the exact same code to abort for both.

We remove the VM_WARN_ON(err != -ENOMEM) as it would be silly for this to
be otherwise and it allows us to implement the abort check more neatly.

Link: https://lkml.kernel.org/r/20250606125032.164249-1-lorenzo.stoakes@oracle.com
Fixes: 47b16d0462a4 ("mm: abort vma_modify() on merge out of memory failure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: syzbot+d16409ea9ecc16ed261a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6842cc67.a00a0220.29ac89.003b.GAE@google.com/
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vma.c b/mm/vma.c
index 726b2a31ce59..0fb9b2c7b734 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -967,26 +967,9 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		err = dup_anon_vma(next, middle, &anon_dup);
 	}
 
-	if (err)
+	if (err || commit_merge(vmg))
 		goto abort;
 
-	err = commit_merge(vmg);
-	if (err) {
-		VM_WARN_ON(err != -ENOMEM);
-
-		if (anon_dup)
-			unlink_anon_vmas(anon_dup);
-
-		/*
-		 * We've cleaned up any cloned anon_vma's, no VMAs have been
-		 * modified, no harm no foul if the user requests that we not
-		 * report this and just give up, leaving the VMAs unmerged.
-		 */
-		if (!vmg->give_up_on_oom)
-			vmg->state = VMA_MERGE_ERROR_NOMEM;
-		return NULL;
-	}
-
 	khugepaged_enter_vma(vmg->target, vmg->flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -995,6 +978,9 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	vma_iter_set(vmg->vmi, start);
 	vma_iter_load(vmg->vmi);
 
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 	/*
 	 * This means we have failed to clone anon_vma's correctly, but no
 	 * actual changes to VMAs have occurred, so no harm no foul - if the


