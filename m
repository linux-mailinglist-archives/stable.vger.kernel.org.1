Return-Path: <stable+bounces-210526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGF9L9NWcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:32:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CE5109B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0904F6C4F9F
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFFC42DFF9;
	Tue, 20 Jan 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Ob7xGxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E52426ECE
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914493; cv=none; b=GrKL+I6t3P47eX6cn2WtqfmW5gNKji+RnOqcykPQFYas1TkEtAtqidX+mLsCWkCFE5DdSxhbXz60l14oxglbWeowdZCCixVZNfpv57JOKIPOMG2kKSn+yIAnrjPOTDzc85OT6LKRgyleZ0lJ1TLivTiPStrJsjrb7XG+//F4A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914493; c=relaxed/simple;
	bh=1tD22ovgtxJrHXt2i5RL7Z6UIhiESHe8ZnNlW++31ic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s5/ZqLlilAYE+oJNEGjbWT4hE+EjnhKiBCoYGUEjcCA8s6ZCNOI4Ls4K22hVRK9EnfaE9oLrMIGRK7OSE5RrFb0LNII46QQP87N6/uFCUWfiu9fB6OYaJjKeBQvPGC5nF+fIrFMuv7o46RujTYv0dx6jB7EVcis2pix/3sn2rUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Ob7xGxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31832C16AAE;
	Tue, 20 Jan 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914492;
	bh=1tD22ovgtxJrHXt2i5RL7Z6UIhiESHe8ZnNlW++31ic=;
	h=Subject:To:Cc:From:Date:From;
	b=1Ob7xGxtkGry/iPEEc06YtzKOoZxwq1fzG5MCTNukUz10jwnNl6ZBaHanYiC+2oag
	 kGrhI2yZjh3b5K83moiaMvEnpwA4MkS539XaSVBU8UQGk1Yp9yB+PugVUuR1Uwd3Ce
	 Pulcab1ZL3zGvzhwktcQkjKE4VnFUjQMINphlV8Y=
Subject: FAILED: patch "[PATCH] mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge" failed to apply to 6.18-stable tree
To: lorenzo.stoakes@oracle.com,Liam.Howlett@oracle.com,aha310510@gmail.com,akpm@linux-foundation.org,david@kernel.org,harry.yoo@oracle.com,jannh@google.com,liam.howlett@oracle.com,pfalcato@suse.de,riel@surriel.com,stable@vger.kernel.org,vbabka@suse.cz,yeoreum.yun@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:08:09 +0100
Message-ID: <2026012009-headroom-imitate-c895@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210526-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,linux-foundation.org,kernel.org,google.com,suse.de,surriel.com,vger.kernel.org,suse.cz,arm.com];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4B9CE5109B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 61f67c230a5e7c741c352349ea80147fbe65bfae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012009-headroom-imitate-c895@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61f67c230a5e7c741c352349ea80147fbe65bfae Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 5 Jan 2026 20:11:47 +0000
Subject: [PATCH] mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge

Patch series "mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted
merge", v2.

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

However, it is handling merges incorrectly when it comes to mremap() of a
faulted VMA adjacent to an unfaulted VMA.  The issues arise in three
cases:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

This series fixes each of these cases, and introduces self tests to assert
that the issues are corrected.

I also test a further case which was already handled, to assert that my
changes continues to correctly handle it:

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

This bug was discovered via a syzbot report, linked to in the first patch
in the series, I confirmed that this series fixes the bug.

I also discovered that we are failing to check that the faulted VMA was
not forked when merging a copied VMA in cases 1-3 above, an issue this
series also addresses.

I also added self tests to assert that this is resolved (and confirmed
that the tests failed prior to this).

I also cleaned up vma_expand() as part of this work, renamed
vma_had_uncowed_parents() to vma_is_fork_child() as the previous name was
unduly confusing, and simplified the comments around this function.


This patch (of 4):

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

The key piece of logic introduced was the ability to merge a faulted VMA
immediately next to an unfaulted VMA, which relies upon dup_anon_vma() to
correctly handle anon_vma state.

In the case of the merge of an existing VMA (that is changing properties
of a VMA and then merging if those properties are shared by adjacent
VMAs), dup_anon_vma() is invoked correctly.

However in the case of the merge of a new VMA, a corner case peculiar to
mremap() was missed.

The issue is that vma_expand() only performs dup_anon_vma() if the target
(the VMA that will ultimately become the merged VMA): is not the next VMA,
i.e.  the one that appears after the range in which the new VMA is to be
established.

A key insight here is that in all other cases other than mremap(), a new
VMA merge either expands an existing VMA, meaning that the target VMA will
be that VMA, or would have anon_vma be NULL.

Specifically:

* __mmap_region() - no anon_vma in place, initial mapping.
* do_brk_flags() - expanding an existing VMA.
* vma_merge_extend() - expanding an existing VMA.
* relocate_vma_down() - no anon_vma in place, initial mapping.

In addition, we are in the unique situation of needing to duplicate
anon_vma state from a VMA that is neither the previous or next VMA being
merged with.

dup_anon_vma() deals exclusively with the target=unfaulted, src=faulted
case.  This leaves four possibilities, in each case where the copied VMA
is faulted:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

target = prev, expand prev to cover.

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

target = next, expand next to cover.

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.  Essentially equivalent to 3, but
with additional requirement that next's anon_vma is the same as the copied
VMA's.  This is covered by the existing logic.

To account for this very explicitly, we introduce
vma_merge_copied_range(), which sets a newly introduced vmg->copied_from
field, then invokes vma_merge_new_range() which handles the rest of the
logic.

We then update the key vma_expand() function to clean up the logic and
make what's going on clearer, making the 'remove next' case less special,
before invoking dup_anon_vma() unconditionally should we be copying from a
VMA.

Note that in case 3, the if (remove_next) ...  branch will be a no-op, as
next=src in this instance and src is unfaulted.

In case 4, it won't be, but since in this instance next=src and it is
faulted, this will have required tgt=faulted, src=faulted to be
compatible, meaning that next->anon_vma == vmg->copied_from->anon_vma, and
thus a single dup_anon_vma() of next suffices to copy anon_vma state for
the copied-from VMA also.

If we are copying from a VMA in a successful merge we must _always_
propagate anon_vma state.

This issue can be observed most directly by invoked mremap() to move
around a VMA and cause this kind of merge with the MREMAP_DONTUNMAP flag
specified.

This will result in unlink_anon_vmas() being called after failing to
duplicate anon_vma state to the target VMA, which results in the anon_vma
itself being freed with folios still possessing dangling pointers to the
anon_vma and thus a use-after-free bug.

This bug was discovered via a syzbot report, which this patch resolves.

We further make a change to update the mergeable anon_vma check to assert
the copied-from anon_vma did not have CoW parents, as otherwise
dup_anon_vma() might incorrectly propagate CoW ancestors from the next VMA
in case 4 despite the anon_vma's being identical for both VMAs.

Link: https://lkml.kernel.org/r/cover.1767638272.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/b7930ad2b1503a657e29fe928eb33061d7eadf5b.1767638272.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA merges")
Reported-by: syzbot+b165fc2e11771c66d8ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694a2745.050a0220.19928e.0017.GAE@google.com/
Reported-by: syzbot+5272541ccbbb14e2ec30@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694e3dc6.050a0220.35954c.0066.GAE@google.com/
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vma.c b/mm/vma.c
index fc90befd162f..9df9e3b78604 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -829,6 +829,8 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	VM_WARN_ON_VMG(middle &&
 		       !(vma_iter_addr(vmg->vmi) >= middle->vm_start &&
 			 vma_iter_addr(vmg->vmi) < middle->vm_end), vmg);
+	/* An existing merge can never be used by the mremap() logic. */
+	VM_WARN_ON_VMG(vmg->copied_from, vmg);
 
 	vmg->state = VMA_MERGE_NOMERGE;
 
@@ -1098,6 +1100,33 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	return NULL;
 }
 
+/*
+ * vma_merge_copied_range - Attempt to merge a VMA that is being copied by
+ * mremap()
+ *
+ * @vmg: Describes the VMA we are adding, in the copied-to range @vmg->start to
+ *       @vmg->end (exclusive), which we try to merge with any adjacent VMAs if
+ *       possible.
+ *
+ * vmg->prev, next, start, end, pgoff should all be relative to the COPIED TO
+ * range, i.e. the target range for the VMA.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * ASSUMPTIONS: Same as vma_merge_new_range(), except vmg->middle must contain
+ *              the copied-from VMA.
+ */
+static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vmg)
+{
+	/* We must have a copied-from VMA. */
+	VM_WARN_ON_VMG(!vmg->middle, vmg);
+
+	vmg->copied_from = vmg->middle;
+	vmg->middle = NULL;
+	return vma_merge_new_range(vmg);
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -1117,46 +1146,52 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 int vma_expand(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *anon_dup = NULL;
-	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	bool remove_next = false;
 	vm_flags_t sticky_flags;
-
-	sticky_flags = vmg->vm_flags & VM_STICKY;
-	sticky_flags |= target->vm_flags & VM_STICKY;
-
-	VM_WARN_ON_VMG(!target, vmg);
+	int ret = 0;
 
 	mmap_assert_write_locked(vmg->mm);
-
 	vma_start_write(target);
-	if (next && (target != next) && (vmg->end == next->vm_end)) {
-		int ret;
 
-		sticky_flags |= next->vm_flags & VM_STICKY;
+	if (next && target != next && vmg->end == next->vm_end)
 		remove_next = true;
-		/* This should already have been checked by this point. */
-		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
-		vma_start_write(next);
-		/*
-		 * In this case we don't report OOM, so vmg->give_up_on_mm is
-		 * safe.
-		 */
-		ret = dup_anon_vma(target, next, &anon_dup);
-		if (ret)
-			return ret;
-	}
 
+	/* We must have a target. */
+	VM_WARN_ON_VMG(!target, vmg);
+	/* This should have already been checked by this point. */
+	VM_WARN_ON_VMG(remove_next && !can_merge_remove_vma(next), vmg);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON_VMG(next && !remove_next &&
 		       next != target && vmg->end > next->vm_start, vmg);
-	/* Only handles expanding */
+	/* Only handles expanding. */
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 	if (remove_next)
-		vmg->__remove_next = true;
+		sticky_flags |= next->vm_flags & VM_STICKY;
 
+	/*
+	 * If we are removing the next VMA or copying from a VMA
+	 * (e.g. mremap()'ing), we must propagate anon_vma state.
+	 *
+	 * Note that, by convention, callers ignore OOM for this case, so
+	 * we don't need to account for vmg->give_up_on_mm here.
+	 */
+	if (remove_next)
+		ret = dup_anon_vma(target, next, &anon_dup);
+	if (!ret && vmg->copied_from)
+		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+	if (ret)
+		return ret;
+
+	if (remove_next) {
+		vma_start_write(next);
+		vmg->__remove_next = true;
+	}
 	if (commit_merge(vmg))
 		goto nomem;
 
@@ -1828,10 +1863,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	vmg.middle = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
-	new_vma = vma_merge_new_range(&vmg);
+	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
 		/*
diff --git a/mm/vma.h b/mm/vma.h
index abada6a64c4e..9d5ee6ac913a 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -106,6 +106,9 @@ struct vma_merge_struct {
 	struct anon_vma_name *anon_name;
 	enum vma_merge_state state;
 
+	/* If copied from (i.e. mremap()'d) the VMA from which we are copying. */
+	struct vm_area_struct *copied_from;
+
 	/* Flags which callers can use to modify merge behaviour: */
 
 	/*


