Return-Path: <stable+bounces-93717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74009D05CF
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59976B21C39
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8301DC194;
	Sun, 17 Nov 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpZ+65AR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB391DA116
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875145; cv=none; b=jlrHxIfzHPLDHx6rNYZWha27I5O0F/N2cLT5NlBDcTLc7xfyGNhTX1/8gjoq5NsLSlGiVSxj/e76JX57OnKujXWp/X8z6rf9K0kZlqW7RDqMzV8wuCSdKGy5YnYmR1apXLHf2RcSwMdUqf64fWKeWyanwgNe5o0Kk61UaRGtEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875145; c=relaxed/simple;
	bh=YDWQ8+jrYD/1+nvSrVZI0tP54jNEUkVd4Pjk1NLyMFM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bx0tLduUWS8RDNfYGiTCuX0MJUFFtXjvuHSNH+d7sHDp7KiVifoV470FpHQLnTiMOnNFuBkBvBPczYYCqhtFme60Yw/ko8C8VMNOp0a3S80tjSLexgG97n+7dEkkQiqgal3q4S8TTZ09q3Wj+uSg2EQB6i3iQmDAYYPwXHw1DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpZ+65AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F03C4CECD;
	Sun, 17 Nov 2024 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875144;
	bh=YDWQ8+jrYD/1+nvSrVZI0tP54jNEUkVd4Pjk1NLyMFM=;
	h=Subject:To:Cc:From:Date:From;
	b=fpZ+65ARyxsw+Kt5lYQuDN6y1MOl59P/CtLbmKu8cPywXNGyPlXkOoNVkG+n6a/7L
	 DNl6ITfuPKdPoRBc2GzhlNFHfqmqoeofWEDuwcV2lqme1OjHXDnFuJrm3d51AVnhU4
	 n8hF6n2YzpVEUTHmf7SXHGOJLEg+uibKWDEBPfhs=
Subject: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 4.19-stable tree
To: akpm@linux-foundation.org,aha310510@gmail.com,chuck.lever@oracle.com,hughd@google.com,stable@vger.kernel.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:25:04 +0100
Message-ID: <2024111704-operator-cusp-93c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111704-operator-cusp-93c5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


