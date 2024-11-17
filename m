Return-Path: <stable+bounces-93714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC29D05CC
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F21F21779
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59061DB940;
	Sun, 17 Nov 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3IxkPhL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933672E419
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875136; cv=none; b=mXX0JhYJ9KmBCjmaMvBCHtbVNTp2zRXec0Ye4K5njPlnrofueXrfxvyvAnc5jwxq6Z16eG/x3sGP8rDCWSC02gZnJ1BWrNrfK9sNFqYVGRA5MdsA2FSxqPqMs+7iUyp3OKi+tPH8rm0tgEN6QGYvziXEWYMoZdKMsXTOe8skWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875136; c=relaxed/simple;
	bh=WMR124bojz/Gj5wM8K/qb/a918n1WVrmNH9rD5bUsOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G3pg66XYipb7VnAnTQYIR46BVhZIGS4Riex5P8nAX8SvoB47dPg4WhJ4iXhDS8H/FISp6FvU/QRR3fvLYnmZCXoNGd3UWE+80AQtHZAgLaUdimSEO84ARRBDLKI1xkDPOfkdR5u1vXZbyOXKpjqRqkd2RTf1IvFDVHoWkvshgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3IxkPhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B974C4CECD;
	Sun, 17 Nov 2024 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875136;
	bh=WMR124bojz/Gj5wM8K/qb/a918n1WVrmNH9rD5bUsOw=;
	h=Subject:To:Cc:From:Date:From;
	b=u3IxkPhLATqxD+2Eha6/RRYb7M5gBO3ZzfxbwI/BY4qq7SUKNKY3eiyygAVO92+C7
	 EtI/QD0oqagz0U2+JJpIkHUI6Ga2ZN4qm9Fx0bPJpH11AYr80xNeF1Ns0b4GEkQwC4
	 Zhr/DW2JlwPO/fIdSdT6OHyXNSnxQo+6VGxHc0iA=
Subject: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 5.15-stable tree
To: akpm@linux-foundation.org,aha310510@gmail.com,chuck.lever@oracle.com,hughd@google.com,stable@vger.kernel.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:25:02 +0100
Message-ID: <2024111702-gonad-immobile-513e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111702-gonad-immobile-513e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


