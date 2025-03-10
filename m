Return-Path: <stable+bounces-121835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FDBA59C8D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A049E16E7C3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F185233729;
	Mon, 10 Mar 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWNMWIoi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A25233716;
	Mon, 10 Mar 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626768; cv=none; b=Byrak7efH/ftgHrnOTx539XgkZvVoBYEqWjvioH1xFmhmusErPbOLC0H5odGQEwzIrRFnPv1WcWm19AKfycOeavXgvIEv3ThEJmVonZofg+9dQGc3nPjVXNYBj8+Ev4UMXLVEjkaIdOBFcQ9wF30SKIqqEYYcjeF78udXlj01Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626768; c=relaxed/simple;
	bh=FbYbTb58b9KqqLbpI9vgQlUR9+Dek3Vm/YTR1+2ElFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIFTyiKidc9/7AI9mOZHTaQcltqVXoKLUT9+MXjMhQQKal/Xs/tXsO64mt8ozSb97qPRC8G18CxT+Ka0QyoX1IAjJoARq2MwZmI9rQqY5H5g9Xl20s6v/ovJYsrLB1cX9qvZHTM3ETuG1UvcI2s7HE7XnbPOSof2BHGWwr4HKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWNMWIoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EDEC4CEE5;
	Mon, 10 Mar 2025 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626767;
	bh=FbYbTb58b9KqqLbpI9vgQlUR9+Dek3Vm/YTR1+2ElFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWNMWIoikCC49jSjJIpNmoP+GWEcb/agveVxChQQZ/cdFE92Yx18DK7wwBDyEdkkR
	 c0WyI6ouUOkhyuoT6II3DSkkzrks8cqhf3FSs6UuuZDpsA4CSFJlmi8a5WyjnL7CrK
	 G2Kb4OOl9kSwam4jbhegF0cVeIZ4xF/9cxsf3tY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	syzbot+46423ed8fa1f1148c6e4@syzkaller.appspotmail.com,
	Jann Horn <jannh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 075/207] mm: abort vma_modify() on merge out of memory failure
Date: Mon, 10 Mar 2025 18:04:28 +0100
Message-ID: <20250310170450.744922317@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit 47b16d0462a460000b8f05dfb1292377ac48f3ca upstream.

The remainder of vma_modify() relies upon the vmg state remaining pristine
after a merge attempt.

Usually this is the case, however in the one edge case scenario of a merge
attempt failing not due to the specified range being unmergeable, but
rather due to an out of memory error arising when attempting to commit the
merge, this assumption becomes untrue.

This results in vmg->start, end being modified, and thus the proceeding
attempts to split the VMA will be done with invalid start/end values.

Thankfully, it is likely practically impossible for us to hit this in
reality, as it would require a maple tree node pre-allocation failure that
would likely never happen due to it being 'too small to fail', i.e.  the
kernel would simply keep retrying reclaim until it succeeded.

However, this scenario remains theoretically possible, and what we are
doing here is wrong so we must correct it.

The safest option is, when this scenario occurs, to simply give up the
operation.  If we cannot allocate memory to merge, then we cannot allocate
memory to split either (perhaps moreso!).

Any scenario where this would be happening would be under very extreme
(likely fatal) memory pressure, so it's best we give up early.

So there is no doubt it is appropriate to simply bail out in this
scenario.

However, in general we must if at all possible never assume VMG state is
stable after a merge attempt, since merge operations update VMG fields.
As a result, additionally also make this clear by storing start, end in
local variables.

The issue was reported originally by syzkaller, and by Brad Spengler (via
an off-list discussion), and in both instances it manifested as a
triggering of the assert:

	VM_WARN_ON_VMG(start >= end, vmg);

In vma_merge_existing_range().

It seems at least one scenario in which this is occurring is one in which
the merge being attempted is due to an madvise() across multiple VMAs
which looks like this:

        start     end
          |<------>|
     |----------|------|
     |   vma    | next |
     |----------|------|

When madvise_walk_vmas() is invoked, we first find vma in the above
(determining prev to be equal to vma as we are offset into vma), and then
enter the loop.

We determine the end of vma that forms part of the range we are
madvise()'ing by setting 'tmp' to this value:

		/* Here vma->vm_start <= start < (end|vma->vm_end) */
		tmp = vma->vm_end;

We then invoke the madvise() operation via visit(), letting prev get
updated to point to vma as part of the operation:

		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
		error = visit(vma, &prev, start, tmp, arg);

Where the visit() function pointer in this instance is
madvise_vma_behavior().

As observed in syzkaller reports, it is ultimately madvise_update_vma()
that is invoked, calling vma_modify_flags_name() and vma_modify() in turn.

Then, in vma_modify(), we attempt the merge:

	merged = vma_merge_existing_range(vmg);
	if (merged)
		return merged;

We invoke this with vmg->start, end set to start, tmp as such:

        start  tmp
          |<--->|
     |----------|------|
     |   vma    | next |
     |----------|------|

We find ourselves in the merge right scenario, but the one in which we
cannot remove the middle (we are offset into vma).

Here we have a special case where vmg->start, end get set to perhaps
unintuitive values - we intended to shrink the middle VMA and expand the
next.

This means vmg->start, end are set to...  vma->vm_start, start.

Now the commit_merge() fails, and vmg->start, end are left like this.
This means we return to the rest of vma_modify() with vmg->start, end
(here denoted as start', end') set as:

  start' end'
     |<-->|
     |----------|------|
     |   vma    | next |
     |----------|------|

So we now erroneously try to split accordingly.  This is where the
unfortunate stuff begins.

We start with:

	/* Split any preceding portion of the VMA. */
	if (vma->vm_start < vmg->start) {
		...
	}

This doesn't trigger as we are no longer offset into vma at the start.

But then we invoke:

	/* Split any trailing portion of the VMA. */
	if (vma->vm_end > vmg->end) {
		...
	}

Which does get invoked. This leaves us with:

  start' end'
     |<-->|
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|

We then return ultimately to madvise_walk_vmas().  Here 'new' is unknown,
and putting back the values known in this function we are faced with:

        start tmp end
          |     |  |
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|
      prev

Then:

		start = tmp;

So:

             start end
                |  |
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|
      prev

The following code does not cause anything to happen:

		if (prev && start < prev->vm_end)
			start = prev->vm_end;
		if (start >= end)
			break;

And then we invoke:

		if (prev)
			vma = find_vma(mm, prev->vm_end);

Which is where a problem occurs - we don't know about 'new' so we
essentially look for the vma after prev, which is new, whereas we actually
intended to discover next!

So we end up with:

             start end
                |  |
     |----|-----|------|
     |prev| vma | next |
     |----|-----|------|

And we have successfully bypassed all of the checks madvise_walk_vmas()
has to ensure early exit should we end up moving out of range.

We loop around, and hit:

		/* Here vma->vm_start <= start < (end|vma->vm_end) */
		tmp = vma->vm_end;

Oh dear. Now we have:

              tmp
             start end
                |  |
     |----|-----|------|
     |prev| vma | next |
     |----|-----|------|

We then invoke:

		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
		error = visit(vma, &prev, start, tmp, arg);

Where start == tmp. That is, a zero range. This is not good.

We invoke visit() which is madvise_vma_behavior() which does not check the
range (for good reason, it assumes all checks have been done before it was
called), which in turn finally calls madvise_update_vma().

The madvise_update_vma() function calls vma_modify_flags_name() in turn,
which ultimately invokes vma_modify() with...  start == end.

vma_modify() calls vma_merge_existing_range() and finally we hit:

	VM_WARN_ON_VMG(start >= end, vmg);

Which triggers, as start == end.

While it might be useful to add some CONFIG_DEBUG_VM asserts in these
instances to catch this kind of error, since we have just eliminated any
possibility of that happening, we will add such asserts separately as to
reduce churn and aid backporting.

Link: https://lkml.kernel.org/r/20250222161952.41957-1-lorenzo.stoakes@oracle.com
Fixes: 2f1c6611b0a8 ("mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Brad Spengler <brad.spengler@opensrcsec.com>
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Reported-by: syzbot+46423ed8fa1f1148c6e4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6774c98f.050a0220.25abdd.0991.GAE@google.com/
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vma.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1508,24 +1508,28 @@ int do_vmi_munmap(struct vma_iterator *v
 static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->vma;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_nomem(vmg))
+		return ERR_PTR(-ENOMEM);
 
 	/* Split any preceding portion of the VMA. */
-	if (vma->vm_start < vmg->start) {
-		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
+	if (vma->vm_start < start) {
+		int err = split_vma(vmg->vmi, vma, start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
 	/* Split any trailing portion of the VMA. */
-	if (vma->vm_end > vmg->end) {
-		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
+	if (vma->vm_end > end) {
+		int err = split_vma(vmg->vmi, vma, end, 0);
 
 		if (err)
 			return ERR_PTR(err);



