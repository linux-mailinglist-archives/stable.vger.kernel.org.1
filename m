Return-Path: <stable+bounces-93715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17769D05CD
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6829F282074
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0961CACE0;
	Sun, 17 Nov 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G+dTGIMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5901DA116
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875139; cv=none; b=I6SUSPRq74gAvtUypUCu1lFFpd6z4egRVxcPUKNFn/gDwvSFvDD71Y7CURHYM+Yj88lUY1mCI/fp6TMikupMWxmTUibA8uLx1m0iscXg7+r2iJxzzGetBuFIE3vLUTkH8gB7kPXYmIsxpfXZpXrvINKmu+D042zVsvO1Dy6UNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875139; c=relaxed/simple;
	bh=u7uUvw1Y2aZzu2fsGjp4+bmegPjVogCKu9RkgYNt6N4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kj2Oyk/KzsiAtUSkbjtRGucNOhHxaqilAuLeHRIpo4zM17yJnYtHBU2mB77a8JQ31A3QOh8kwD10vDf0YW7qm5arAuF4alleMyfLx+LC/S7NQgDe4x+5Ezsl+U50ZpM40Dr/v1QmDOaPEWasJ6R9PXK78VfXwvHJJJr1l8cF3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G+dTGIMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B71C4CECD;
	Sun, 17 Nov 2024 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875139;
	bh=u7uUvw1Y2aZzu2fsGjp4+bmegPjVogCKu9RkgYNt6N4=;
	h=Subject:To:Cc:From:Date:From;
	b=G+dTGIMvckJH/2WIf+x2FQVLzNh546LdkrmsdtrdWsQLKLd4TR43wgNdqNcH0kZ8l
	 s8wNOoki9sKZ9pCwz+tk3cB/snVAFL2+7X1AGtPBHoedHPCR5Bs8XPYHewBSnIBqcy
	 N0AbAVQCE6b3lFajR1x7J5LWy9LDDBKCXtnjYkxI=
Subject: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 5.4-stable tree
To: akpm@linux-foundation.org,aha310510@gmail.com,chuck.lever@oracle.com,hughd@google.com,stable@vger.kernel.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:25:03 +0100
Message-ID: <2024111703-shopper-overtly-8e35@gregkh>
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
git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111703-shopper-overtly-8e35@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1aa0c04294e29883d65eac6c2f72fe95cc7c049 Mon Sep 17 00:00:00 2001
From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 15 Nov 2024 16:57:24 -0800
Subject: [PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
NFS.

As Hugh commented, "added just to silence a syzbot sanitizer splat: added
where there has never been any practical problem".

Link: https://lkml.kernel.org/r/ZzdxKF39VEmXSSyN@tissot.1015granger.net [1]
Fixes: d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()")
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeongjun Park <aha310510@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index e87f5d6799a7..568bb290bdce 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
-	inode_lock_shared(inode);
 	generic_fillattr(idmap, request_mask, inode, stat);
-	inode_unlock_shared(inode);
 
 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;


