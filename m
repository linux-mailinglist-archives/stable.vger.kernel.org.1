Return-Path: <stable+bounces-39380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA098A42A6
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2D1C20D9F
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CB43AD1;
	Sun, 14 Apr 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aIPMPuZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459C40BED
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101745; cv=none; b=eq2X1cfT1+snylHo6cl0+IHDsMKILrQA+mdWwaphBPuB2zVL0FrUqNTDiroB+ZZkI/38DAxNMMuuNs2UMNsKmiyGSqqTz1SSLj5RmBxt7mhY/UcOOThIEzai910z1omlSvccZGVXT/Qno0VBzC+O9Rvv89/iSE+gTsRDHHk6Kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101745; c=relaxed/simple;
	bh=Zri6jV30+Cn3mi54mD0GJHmLDhu3vOjWzUybJ1/719Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BdSHUuzeRZ+XwbgItlw/6WpvyyUmte9GMuyrBWLV7XndqhLqXMUKx7EPGrMXxjMmfV6KXHisc2+RN3opSDz7YkqgsWHqvYb1efmgzZoFSlSVwHCk4Pr2vro4M62DaGNAVGv/HkfP7t66FLcdo4NkWNK/Y1RBkRgiBZborvIyr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aIPMPuZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EBCC072AA;
	Sun, 14 Apr 2024 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713101744;
	bh=Zri6jV30+Cn3mi54mD0GJHmLDhu3vOjWzUybJ1/719Y=;
	h=Subject:To:Cc:From:Date:From;
	b=aIPMPuZqz+eqgCDk6ZGKfqdA24e/D+8cl2pDIpowElb9JqMMi13N06SnUBCLh+muO
	 5EOgPRFfu8o5O5EPsMl3R15qMomOdCm7Yg0LkSRLhaVaw7lz1LvAuhKI2m/QEvGgge
	 JZR2sDySPvr5EE/hzHp6iSk77XkFsA9o6sv6Q8xg=
Subject: FAILED: patch "[PATCH] ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE" failed to apply to 6.6-stable tree
To: neilb@suse.de,idryomov@gmail.com,jlayton@kernel.org,xiubli@redhat.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Apr 2024 15:35:41 +0200
Message-ID: <2024041441-unabashed-swarm-244d@gregkh>
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
git cherry-pick -x b372e96bd0a32729d55d27f613c8bc80708a82e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041441-unabashed-swarm-244d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b372e96bd0a32729d55d27f613c8bc80708a82e1 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Mon, 25 Mar 2024 09:21:20 +1100
Subject: [PATCH] ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

The page has been marked clean before writepage is called.  If we don't
redirty it before postponing the write, it might never get written.

Cc: stable@vger.kernel.org
Fixes: 503d4fa6ee28 ("ceph: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Xiubo Li <xiubli@redhat.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1340d77124ae..ee9caf7916fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -795,8 +795,10 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	ihold(inode);
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested)
+	    ceph_inode_to_fs_client(inode)->write_congested) {
+		redirty_page_for_writepage(wbc, page);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	wait_on_page_fscache(page);
 


