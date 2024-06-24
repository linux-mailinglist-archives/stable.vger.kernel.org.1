Return-Path: <stable+bounces-55035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EB91518B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DE51F22004
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758319B3F9;
	Mon, 24 Jun 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wb8tR8eQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1F19E7E7
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241772; cv=none; b=U6z0vQcdG603yaafal1odvJqLJMnFXBTPk7AWCOXCkx2/a34sLNhOa4e2qpghhRhqk2IpPhokJL/uSc38WOCSeZQPXagAMqzctN/XqgIHBQ+ovGsYVDUce2nVESUMnckufOaanbBF2FTaxeIrdL6fA+yfHpfU5Ao7Etpxm0NgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241772; c=relaxed/simple;
	bh=i8lfafPA8hYY1B6g2RfUt7+8CQ9JYbpi0eRr019CkoE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qts/VbHKFrhZBe6z6CHsCZZGGPUGARaAsbmgLpbiUTw0xvkKJXu1PLn9H5fjUKSZxt+tcornSUWqbIfPiPAjM6AaaapLRgkF7/1b7uK7hfG0CfI2VXOmGZO1732PWnUdyI3CqIF5SpQo/IaHeZc/LUOOPGBxAUKLSl+teyEtdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wb8tR8eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A02DC32782;
	Mon, 24 Jun 2024 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241771;
	bh=i8lfafPA8hYY1B6g2RfUt7+8CQ9JYbpi0eRr019CkoE=;
	h=Subject:To:Cc:From:Date:From;
	b=Wb8tR8eQSZWNpUGb6fcpKZVf2nmgudFwCJLjKqc2T6lONOCTBMHkE8dKMrb0Twph5
	 FPYEsiqoBIaHbQJPR79xvC4hzjmjO0O5BLqp0I53Jt6GnsDOtyM/oZAIcSbxo7mKYX
	 TTmJvJvSUy5ch7fhx4U2I8Ngw4zJ51M9HgZv0Un0=
Subject: FAILED: patch "[PATCH] cifs: drop the incorrect assertion in cifs_swap_rw()" failed to apply to 6.9-stable tree
To: baohua@kernel.org,anna@kernel.org,bharathsm@microsoft.com,chrisl@kernel.org,hanchuanhua@oppo.com,hch@lst.de,jlayton@kernel.org,neilb@suse.de,pc@manguebit.com,ronniesahlberg@gmail.com,ryan.roberts@arm.com,sfrench@samba.org,sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com,tom@talpey.com,trondmy@kernel.org,v-songbaohua@oppo.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:09:28 +0200
Message-ID: <2024062428-captivate-grasp-a4cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 29433a17a79caa8680b9c0761f2b10502fda9ce3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062428-captivate-grasp-a4cf@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

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


