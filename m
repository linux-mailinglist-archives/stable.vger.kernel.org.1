Return-Path: <stable+bounces-73868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7C970704
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152891F219A0
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90915821E;
	Sun,  8 Sep 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQQ9TwaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E8158203
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795787; cv=none; b=d6ohHuSYtfCQ0L2rwS3JpsEtTrNK88Hg2U2Lee6B1krVOQGfKLZFR4oixP01VnCOGZoDGboOMvelaCJy6FEcL0s4EyXuDVTli075XXV3VXy775Lyx9MaJyb0J2R0t3SWwbGHhUCZq5D+/95P7fqxyk1KuhY/+JiG6F1lUP9b5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795787; c=relaxed/simple;
	bh=ZAnZWLp6mxzwnfmObxeEZvq7FKdz5+OSpK+mdLzkeVU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=odAv7D0LoVKkN5IFnmLeZ3apZ6a8Mgz7tQCgmufPtqqlsEIsvLaTrZVuAX8m/Mk4qDLTIaJytKDeL6SrP6AN+4HokkqGCntB+szl2Z1oAOM+LVHdis6cj6H7P3jGp1zId6MMeYWg7EaSV4EC9kgkXYr1UqSY5i5I6B337QZWSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQQ9TwaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0218CC4CEC3;
	Sun,  8 Sep 2024 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725795787;
	bh=ZAnZWLp6mxzwnfmObxeEZvq7FKdz5+OSpK+mdLzkeVU=;
	h=Subject:To:Cc:From:Date:From;
	b=PQQ9TwaNu3rXtBC7IdLFfCnl2gdu15uS2oiaEsZOsBapl2ltN3PU38e4J2YRfohv0
	 bC2oCORHLBUVWxUw41JupwGuIxmJwfK0aJmIMXP8hsIAOuNuIuH8PvvcD6FrplaBz8
	 szVLc5mTkDYT4McmQoanROIDQIiEAUInWU37hGRo=
Subject: FAILED: patch "[PATCH] fuse: fix memory leak in fuse_create_open" failed to apply to 6.1-stable tree
To: yangyun50@huawei.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:43:04 +0200
Message-ID: <2024090804-leverage-floral-9b6b@gregkh>
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
git cherry-pick -x 3002240d16494d798add0575e8ba1f284258ab34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090804-leverage-floral-9b6b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3002240d1649 ("fuse: fix memory leak in fuse_create_open")
15d937d7ca8c ("fuse: add request extension")
153524053bbb ("fuse: allow non-extending parallel direct writes on the same file")
4f8d37020e1f ("fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3002240d16494d798add0575e8ba1f284258ab34 Mon Sep 17 00:00:00 2001
From: yangyun <yangyun50@huawei.com>
Date: Fri, 23 Aug 2024 16:51:46 +0800
Subject: [PATCH] fuse: fix memory leak in fuse_create_open

The memory of struct fuse_file is allocated but not freed
when get_create_ext return error.

Fixes: 3e2b6fdbdc9a ("fuse: send security context of inode on file")
Cc: stable@vger.kernel.org # v5.17
Signed-off-by: yangyun <yangyun50@huawei.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..8e96df9fd76c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -670,7 +670,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 
 	err = get_create_ext(&args, dir, entry, mode);
 	if (err)
-		goto out_put_forget_req;
+		goto out_free_ff;
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);


