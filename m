Return-Path: <stable+bounces-209119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A679DD26894
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A75073070E21
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330439B48E;
	Thu, 15 Jan 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUoI+t3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D62D9494;
	Thu, 15 Jan 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497787; cv=none; b=R0zTQiqsVFmD7iC4xvuwytuHkfWIsQ9ThvSWn13VdaQds/JK0+C4r6+T4Azx+gJPGkAFEqF/RlVv+Z5r9Q7kOeyksS5CiQvmcJ9xAsA7l+iU5lUBoiTXISDOFvRcKvaN4vD3/ryajalg91orKBU81bdQiZsC9/PVVOXvT/MBbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497787; c=relaxed/simple;
	bh=vWG3tOc65XuHVSWCvF/17VkhvZSSlqq2uhJb4Jo4UqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKinhrlBgV4Piey3EVQN4+zAhcihjo5VfYU8Y/IOv+PwTL2faKfBeoDvxVMervf2WhgTZ1/8brVhSXXhmkIgFhLJEY/jSl5tZ/2/iryXRcCKD97I3SNK9kHo0RSlwCY/fg4uB9RM38U4vW1AVr2xkzsuoPoSpomeb3NHys5gvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QUoI+t3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB3DC116D0;
	Thu, 15 Jan 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497787;
	bh=vWG3tOc65XuHVSWCvF/17VkhvZSSlqq2uhJb4Jo4UqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUoI+t3/bCe4PdhtqckmGS+iwc0sBxUCI3S9FP/y+dqB57anklIxl6ty2BrXA4Nln
	 qlq+JrZtUu8qTCp4X67qDmR9ONOnp6zvBe8RzIHxFDHUxFAonB1JF+I9VnOH+ldH14
	 4g3Ygz2y/siF/nKQjmklnnPJtAB4oyoXFhC3YlIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sun Ke <sunke32@huawei.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 202/554] NFS: Fix missing unlock in nfs_unlink()
Date: Thu, 15 Jan 2026 17:44:28 +0100
Message-ID: <20260115164253.568507590@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sun Ke <sunke32@huawei.com>

commit 2067231a9e2cbbcae0a4aca6ac36ff2dd6a7b701 upstream.

Add the missing unlock before goto.

Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
Signed-off-by: Sun Ke <sunke32@huawei.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/dir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2331,8 +2331,10 @@ int nfs_unlink(struct inode *dir, struct
 	 */
 	error = -ETXTBSY;
 	if (WARN_ON(dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
-	    WARN_ON(dentry->d_fsdata == NFS_FSDATA_BLOCKED))
+	    WARN_ON(dentry->d_fsdata == NFS_FSDATA_BLOCKED)) {
+		spin_unlock(&dentry->d_lock);
 		goto out;
+	}
 	if (dentry->d_fsdata)
 		/* old devname */
 		kfree(dentry->d_fsdata);



