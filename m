Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12BB73525C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFSKeM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjFSKeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E3B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E391360B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050B9C433CA;
        Mon, 19 Jun 2023 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170835;
        bh=ukkKFfPAt0k1Ac8WuXzsh10fEpEZ7KxeDLHONxYAjFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1d4enlwgnYa6rroY0M8nQ+Bgqh66WLyyuIvB/Q+JAA6EyrrkXkjr00w+XTQ8WwDs
         P7U9cfQpTADkeprIs/+L2cmH1VF/fI6WkbzITFSIyJGOmJAbUKNiJ53OwIJHhLXrD1
         VeEQ583RGrTX74qCFiY+ghkfDLf6I3wKXL4v6klE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 053/187] mm/uffd: fix vma operation where start addr cuts part of vma
Date:   Mon, 19 Jun 2023 12:27:51 +0200
Message-ID: <20230619102200.218133854@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

commit 270aa010620697fb27b8f892cc4e194bc2b7d134 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/userfaultfd.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1429,6 +1429,8 @@ static int userfaultfd_register(struct u
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
@@ -1595,6 +1597,9 @@ static int userfaultfd_unregister(struct
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();


