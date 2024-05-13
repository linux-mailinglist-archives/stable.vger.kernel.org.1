Return-Path: <stable+bounces-43723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954878C442C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57F71C2310A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0757CA6;
	Mon, 13 May 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1Axh4/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CD3C2D
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614267; cv=none; b=Hc5t4wqyFNnk25Si2rLlnrIcpuulwjwbiRuiXOjT7JImmLG6tCuohmH13OQLgdvHnD6nnkLjV0AVG8F6qh5eeGxY1ANwmjra1V3cPeovE1Ra+Zns0hkZbymkWPRU6Lt+/JVJiyVFjbG4WfVShFGVq5NNYUC0C7LkygDMrJYP8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614267; c=relaxed/simple;
	bh=1HtSJFt90RaqaGeRBDchac1k8ZcGCAzJeUdHemrwB5s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J8KbRMeCe2e/RlwNpE3Jujn6mXCy8wjSFOKwFZKaEi1tFFCdEdLmkyOG9OLqCjZYHPzdfb8t4B24EJ4N+uB6DIqy8vUJtgctJ/nDRhJYx8gMB+31Aup53GEu0X/OPOJvqj7J8scFjsaxCY/q61JuF3/wWjP4vKrjQe+UX+CyyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1Axh4/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E38C32782;
	Mon, 13 May 2024 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614267;
	bh=1HtSJFt90RaqaGeRBDchac1k8ZcGCAzJeUdHemrwB5s=;
	h=Subject:To:Cc:From:Date:From;
	b=P1Axh4/7b05vZvjr3l6yc18jBUq1VrOrn+aYHNl05SjFIK6d05IHPwA6xjg4JwdSd
	 6all+V+PI6/vRt4BGnwwK88juQoHQrPu1cvgsmq2JV2ocSXMnOtGbzqlOBfSjMNRRw
	 qCFsOEcOeWoN1HmecbgFVw8m3TRFAgbGSE/7Lh1A=
Subject: FAILED: patch "[PATCH] mm/userfaultfd: reset ptes when close() for wr-protected ones" failed to apply to 6.1-stable tree
To: peterx@redhat.com,akpm@linux-foundation.org,david@redhat.com,nadav.amit@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:31:04 +0200
Message-ID: <2024051304-turkey-underfed-40fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c88033efe9a391e72ba6b5df4b01d6e628f4e734
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051304-turkey-underfed-40fe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c88033efe9a3 ("mm/userfaultfd: reset ptes when close() for wr-protected ones")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c88033efe9a391e72ba6b5df4b01d6e628f4e734 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 22 Apr 2024 09:33:11 -0400
Subject: [PATCH] mm/userfaultfd: reset ptes when close() for wr-protected ones

Userfaultfd unregister includes a step to remove wr-protect bits from all
the relevant pgtable entries, but that only covered an explicit
UFFDIO_UNREGISTER ioctl, not a close() on the userfaultfd itself.  Cover
that too.  This fixes a WARN trace.

The only user visible side effect is the user can observe leftover
wr-protect bits even if the user close()ed on an userfaultfd when
releasing the last reference of it.  However hopefully that should be
harmless, and nothing bad should happen even if so.

This change is now more important after the recent page-table-check
patch we merged in mm-unstable (446dd9ad37d0 ("mm/page_table_check:
support userfault wr-protect entries")), as we'll do sanity check on
uffd-wp bits without vma context.  So it's better if we can 100%
guarantee no uffd-wp bit leftovers, to make sure each report will be
valid.

Link: https://lore.kernel.org/all/000000000000ca4df20616a0fe16@google.com/
Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
Analyzed-by: David Hildenbrand <david@redhat.com>
Link: https://lkml.kernel.org/r/20240422133311.2987675-1-peterx@redhat.com
Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..292f5fd50104 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -895,6 +895,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			prev = vma;
 			continue;
 		}
+		/* Reset ptes for the whole vma range if wr-protected */
+		if (userfaultfd_wp(vma))
+			uffd_wp_range(vma, vma->vm_start,
+				      vma->vm_end - vma->vm_start, false);
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
 					    vma->vm_end, new_flags,


