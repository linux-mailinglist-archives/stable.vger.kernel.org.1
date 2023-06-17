Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2837E733F71
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjFQIJ2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFQIJ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129D1BDF
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7EE60B38
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69960C433C8;
        Sat, 17 Jun 2023 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989365;
        bh=Wosdo1eCQlq+knPU5oEsiLLIcmDqLaFYBNrYSXYE4eM=;
        h=Subject:To:Cc:From:Date:From;
        b=mbFbR8Y3eMTBInRXHHVAHHIU0yrBY2CwBfR0UAxdjQT0UbcXN/4IV1/sL8oh9jg3P
         KX96ngiagn4Xqqdl7vjgZMLAvtcB8uQMm0Z6hyCdbAs0pQVU64IMvpoUSn8RyO9KZk
         8vI7n2fbSURDXhPbP6vu5fs+KIghOMKX7R3pJWqs=
Subject: FAILED: patch "[PATCH] mm/uffd: fix vma operation where start addr cuts part of vma" failed to apply to 6.1-stable tree
To:     peterx@redhat.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, lstoakes@gmail.com,
        mark.rutland@arm.com, rppt@kernel.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:09:23 +0200
Message-ID: <2023061722-stowaway-expand-9f38@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 270aa010620697fb27b8f892cc4e194bc2b7d134
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061722-stowaway-expand-9f38@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 270aa010620697fb27b8f892cc4e194bc2b7d134 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 May 2023 15:09:15 -0400
Subject: [PATCH] mm/uffd: fix vma operation where start addr cuts part of vma

Patch series "mm/uffd: Fix vma merge/split", v2.

This series contains two patches that fix vma merge/split for userfaultfd
on two separate issues.

Patch 1 fixes a regression since 6.1+ due to something we overlooked when
converting to maple tree apis.  The plan is we use patch 1 to replace the
commit "2f628010799e (mm: userfaultfd: avoid passing an invalid range to
vma_merge())" in mm-hostfixes-unstable tree if possible, so as to bring
uffd vma operations back aligned with the rest code again.

Patch 2 fixes a long standing issue that vma can be left unmerged even if
we can for either uffd register or unregister.

Many thanks to Lorenzo on either noticing this issue from the assert
movement patch, looking at this problem, and also provided a reproducer on
the unmerged vma issue [1].

[1] https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e


This patch (of 2):

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge() by Lorenzo Stoakes:

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

It's possible that "start" is contained within vma but not clamped to its
start.  We need to convert this into either "cannot merge" case or "can
merge" case 4 which permits subdivision of prev by assigning vma to prev.
As we loop, each subsequent VMA will be clamped to the start.

This patch will eliminate the report and make sure vma_merge() calls will
become legal again.

One thing to mention is that the "Fixes: 29417d292bd0" below is there only
to help explain where the warning can start to trigger, the real commit to
fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
issue, but unfortunately we may want to keep it in Fixes too just to ease
kernel backporters for easier tracking.

Link: https://lkml.kernel.org/r/20230517190916.3429499-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20230517190916.3429499-2-peterx@redhat.com
Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..17c8c345dac4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
@@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();

