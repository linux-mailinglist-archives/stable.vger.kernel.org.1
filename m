Return-Path: <stable+bounces-172055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407FB2FA24
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BE41CC0FCF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863C32BF2D;
	Thu, 21 Aug 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/Qu5FMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981E32BF3B
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782185; cv=none; b=CZujE74nlwNF6GvHupTFh9JLjAFcHNZr0s26koWmksKE4EKLF4KhADx+y6JLDAwYxG7LOsc8PshUhvkPeoMvCtGx7f+KoxVP3j+fImMKLttysjcxmGUIX4fuqrPy4felS9vSOdpAuY/5qz7JvKAb1A9HBzhpkuThfqUOpfOrclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782185; c=relaxed/simple;
	bh=57930LTWntw9PZFOFxZmXXz8EMeserthsBH6dYLWosA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CioB/SaScwCa2q+Ivy8+VAztRvOCDYCjRodzkiHowqTRLqPz+Q6qixvM0gGzic+9N55LnxSjpatXwK1q+5H3PMmy1g3zLxkTLZ6d5qiXC8Od48ERN6OMwPTM/H5QVwxbd5+VDCf7Hol4xolIfPG7o6DCpU0FpULqE1aO0eRcz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/Qu5FMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79EC116C6;
	Thu, 21 Aug 2025 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782185;
	bh=57930LTWntw9PZFOFxZmXXz8EMeserthsBH6dYLWosA=;
	h=Subject:To:Cc:From:Date:From;
	b=w/Qu5FMBXo1kvmIo2EMxXXdnj/2QsnpicCZ3YWofOn++0JXw+Cb81FRaFRjx6kOTe
	 37DLLCRnYoyCCUZ1nBiaDgVBz/6abkQ7zV94G1ddl6MjzJaYA2ohZkmucag6iAYMLp
	 E3nCL2TZyt21PGe1AILxYVJFVwJ4BegzCVHTIm4k=
Subject: FAILED: patch "[PATCH] ovl: use I_MUTEX_PARENT when locking parent in" failed to apply to 6.16-stable tree
To: neil@brown.name,amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:13:14 +0200
Message-ID: <2025082114-donator-nursing-1c9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 5f1c8965e748c150d580a2ea8fbee1bd80d07a24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082114-donator-nursing-1c9c@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f1c8965e748c150d580a2ea8fbee1bd80d07a24 Mon Sep 17 00:00:00 2001
From: NeilBrown <neil@brown.name>
Date: Mon, 4 Aug 2025 22:11:28 +1000
Subject: [PATCH] ovl: use I_MUTEX_PARENT when locking parent in
 ovl_create_temp()

ovl_create_temp() treats "workdir" as a parent in which it creates an
object so it should use I_MUTEX_PARENT.

Prior to the commit identified below the lock was taken by the caller
which sometimes used I_MUTEX_PARENT and sometimes used I_MUTEX_NORMAL.
The use of I_MUTEX_NORMAL was incorrect but unfortunately copied into
ovl_create_temp().

Note to backporters: This patch only applies after the last Fixes given
below (post v6.16).  To fix the bug in v6.7 and later the
inode_lock() call in ovl_copy_up_workdir() needs to nest using
I_MUTEX_PARENT.

Link: https://lore.kernel.org/all/67a72070.050a0220.3d72c.0022.GAE@google.com/
Cc: stable@vger.kernel.org
Reported-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com
Tested-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com
Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_writers held")
Fixes: d2c995581c7c ("ovl: Call ovl_create_temp() without lock held.")
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..dbd63a74df4b 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -225,7 +225,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
 	struct dentry *ret;
-	inode_lock(workdir->d_inode);
+	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
 	ret = ovl_create_real(ofs, workdir,
 			      ovl_lookup_temp(ofs, workdir), attr);
 	inode_unlock(workdir->d_inode);


