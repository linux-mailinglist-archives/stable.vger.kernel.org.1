Return-Path: <stable+bounces-23382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A552E8601AA
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BD21F272EA
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852A9143C4D;
	Thu, 22 Feb 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H0Lwy5tY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94573F25;
	Thu, 22 Feb 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626736; cv=none; b=pZNHQ8nVUi9bFBmjPiZloiDFkWkIaHeDNHZhSuNWB9rXa87YSWxV3Sm+WmDMXOV/kvB4rNzoT/RzH8NHWipqvoPIJxWShdX6pNmU63hwuE2Lb4jmi9AmKjIOpqN+onq3uQfM75BAAYbCJebN2b4NaufxtcN1oPBJsj9+NeT+LaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626736; c=relaxed/simple;
	bh=oPYU7is8eZZ/AtoaT7tVDRdY70CUs72YRGMUkaO+Xtk=;
	h=Date:To:From:Subject:Message-Id; b=pyoax+QjazhL+lmsf89w2rUmAUvJSxp4VPemK7XMozTMuQVRGlzdRt8PNfCN2YDQqLRj5/W4eSlN4snFcdBtpmTKAVWdBydupT1XRTVKyMXe68cvjngLdZfH6YNfs/e+h01DKexFY/A/pEI2UQfsgLm+1qpEH3iJTPI/ZcYrTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H0Lwy5tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA078C43390;
	Thu, 22 Feb 2024 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708626735;
	bh=oPYU7is8eZZ/AtoaT7tVDRdY70CUs72YRGMUkaO+Xtk=;
	h=Date:To:From:Subject:From;
	b=H0Lwy5tYIqK7FH4e9YeQqCAaIulxGbQyIs3ShPeMZ2kFGbS9hbhRcXcVH4mb15TFi
	 5Yd90HFXNG7SLw201pHgAPYmjsHtDk6fmv4wY+gwk/QBvxuYIkACO3YloPn08TOAvS
	 vR888WuQxXdyyjd6FY2+9du0MhgxQ+U/q1dwyfkk=
Date: Thu, 22 Feb 2024 10:32:15 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mhocko@suse.com,lstoakes@gmail.com,Liam.Howlett@oracle.com,vbabka@suse.cz,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-mmap-fix-vma_merge-case-7-with-vma_ops-close.patch added to mm-hotfixes-unstable branch
Message-Id: <20240222183215.CA078C43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm, mmap: fix vma_merge() case 7 with vma_ops->close
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-mmap-fix-vma_merge-case-7-with-vma_ops-close.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mmap-fix-vma_merge-case-7-with-vma_ops-close.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Vlastimil Babka <vbabka@suse.cz>
Subject: mm, mmap: fix vma_merge() case 7 with vma_ops->close
Date: Thu, 22 Feb 2024 17:55:50 +0100

When debugging issues with a workload using SysV shmem, Michal Hocko has
come up with a reproducer that shows how a series of mprotect() operations
can result in an elevated shm_nattch and thus leak of the resource.

The problem is caused by wrong assumptions in vma_merge() commit
714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
mergeability test").  The shmem vmas have a vma_ops->close callback that
decrements shm_nattch, and we remove the vma without calling it.

vma_merge() has thus historically avoided merging vma's with
vma_ops->close and commit 714965ca8252 was supposed to keep it that way. 
It relaxed the checks for vma_ops->close in can_vma_merge_after() assuming
that it is never called on a vma that would be a candidate for removal. 
However, the vma_merge() code does also use the result of this check in
the decision to remove a different vma in the merge case 7.

A robust solution would be to refactor vma_merge() code in a way that the
vma_ops->close check is only done for vma's that are actually going to be
removed, and not as part of the preliminary checks.  That would both solve
the existing bug, and also allow additional merges that the checks
currently prevent unnecessarily in some cases.

However to fix the existing bug first with a minimized risk, and for
easier stable backports, this patch only adds a vma_ops->close check to
the buggy case 7 specifically.  All other cases of vma removal are covered
by the can_vma_merge_before() check that includes the test for
vma_ops->close.

The reproducer code, adapted from Michal Hocko's code:

int main(int argc, char *argv[]) {
  int segment_id;
  size_t segment_size = 20 * PAGE_SIZE;
  char * sh_mem;
  struct shmid_ds shmid_ds;

  key_t key = 0x1234;
  segment_id = shmget(key, segment_size,
                      IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  sh_mem = (char *)shmat(segment_id, NULL, 0);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);

  mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  shmdt(sh_mem);

  shmctl(segment_id, IPC_STAT, &shmid_ds);
  printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);

  if (shmctl(segment_id, IPC_RMID, 0))
          printf("IPCRM failed %d\n", errno);
  return (shmid_ds.shm_nattch) ? 1 : 0;
}

Link: https://lkml.kernel.org/r/20240222165549.32753-2-vbabka@suse.cz
Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in mergeability test")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Michal Hocko <mhocko@suse.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mmap.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/mm/mmap.c~mm-mmap-fix-vma_merge-case-7-with-vma_ops-close
+++ a/mm/mmap.c
@@ -954,10 +954,19 @@ static struct vm_area_struct
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
+				/*
+				 * can_vma_merge_after() assumed we would not be
+				 * removing prev vma, so it skipped the check
+				 * for vm_ops->close, but we are removing curr
+				 */
+				if (curr->vm_ops && curr->vm_ops->close)
+					err = -EINVAL;
+				else
+					err = dup_anon_vma(prev, curr, &anon_dup);
 				remove = curr;
 			} else {			/* case 5 */
+				err = dup_anon_vma(prev, curr, &anon_dup);
 				adjust = curr;
 				adj_start = (end - curr->vm_start);
 			}
_

Patches currently in -mm which might be from vbabka@suse.cz are

mm-vmscan-prevent-infinite-loop-for-costly-gfp_noio-__gfp_retry_mayfail-allocations.patch
mm-mmap-fix-vma_merge-case-7-with-vma_ops-close.patch


