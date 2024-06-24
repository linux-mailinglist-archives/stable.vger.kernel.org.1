Return-Path: <stable+bounces-55036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA35915190
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A12428ABB2
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1919E7FA;
	Mon, 24 Jun 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOYHTbV5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C319E7F6
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241780; cv=none; b=VZwGCUelhvQM4HbNh7CQyuYsWdQ4FLm+p11BolKBLhVYyFsq5Mn5sGQ2Za3pGO0vxrXhTqwIpWdtAV7jk1kiiAN5NSMgNx7cyb8WWQqrGCQwNhjupNYkUBTWucyPADLhl9dJuGgnDvfg0UY1fNEm3GL4zOfRMobOE0HeYLzC2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241780; c=relaxed/simple;
	bh=VR7xoD13Fj3s2ZRKT0WmKl5DlVizzpTFmVU4fhrbaSU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QZCt8KPDIQkN+7qYikHgqM8KtjivzgViW41sbNK6N5xeptWgG+KpUDpAkAhKqLIC3FJhDINLFQXLamw8S/ogt+/+Y8hR86HcWyzRkf+yWcSMpU1A0a7Cft8Mxqew5N9mreLScW/5qIsjFU0fgM0UDv5DYOMp0+a1gRZ+bU6TlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jOYHTbV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99058C32789;
	Mon, 24 Jun 2024 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241780;
	bh=VR7xoD13Fj3s2ZRKT0WmKl5DlVizzpTFmVU4fhrbaSU=;
	h=Subject:To:Cc:From:Date:From;
	b=jOYHTbV5zYFfwJHA4uXPjZMUK7F5GzXI5cNvFook2Qimx5BwxX+mk7X5rWdXIDPRr
	 RLNg2j0jW1W7VQdhBYSfnQXnNrc32y4YIi4TAV1gMEGpfN+iHgoVED4Ibxagf15uWj
	 YP8GaGNv9fWvIn65oXJtUjXi8h7fgd8hkc0rmfzk=
Subject: FAILED: patch "[PATCH] cifs: drop the incorrect assertion in cifs_swap_rw()" failed to apply to 6.6-stable tree
To: baohua@kernel.org,anna@kernel.org,bharathsm@microsoft.com,chrisl@kernel.org,hanchuanhua@oppo.com,hch@lst.de,jlayton@kernel.org,neilb@suse.de,pc@manguebit.com,ronniesahlberg@gmail.com,ryan.roberts@arm.com,sfrench@samba.org,sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com,tom@talpey.com,trondmy@kernel.org,v-songbaohua@oppo.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:09:29 +0200
Message-ID: <2024062428-juggle-shrine-cd22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29433a17a79caa8680b9c0761f2b10502fda9ce3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062428-juggle-shrine-cd22@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29433a17a79caa8680b9c0761f2b10502fda9ce3 Mon Sep 17 00:00:00 2001
From: Barry Song <baohua@kernel.org>
Date: Tue, 18 Jun 2024 19:22:58 +1200
Subject: [PATCH] cifs: drop the incorrect assertion in cifs_swap_rw()

Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
swap-space"), we can plug multiple pages then unplug them all together.
That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
actually equals the size of iov_iter_npages(iter, INT_MAX).

Note this issue has nothing to do with large folios as we don't support
THP_SWPOUT to non-block devices.

Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/linux-mm/20240614100329.1203579-1-hch@lst.de/
Cc: NeilBrown <neilb@suse.de>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..1e269e0bc75b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3200,8 +3200,6 @@ static int cifs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	WARN_ON_ONCE(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = netfs_unbuffered_read_iter_locked(iocb, iter);
 	else


