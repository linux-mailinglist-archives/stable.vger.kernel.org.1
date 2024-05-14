Return-Path: <stable+bounces-43861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C48C4FF3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537B1283FE3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DB47F5D;
	Tue, 14 May 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yd6+U1hJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EB22EF3;
	Tue, 14 May 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682730; cv=none; b=tuSozD5zVhjHMjlGtPWQKMTGiw5tLK23cwH3myKwO91Ae6TShwX2YOoeRZwf36kEND3Jgi2Sq/dBTFI8+VrJ0BWv7DMFmy92Z+HXVsraJjVfrL0YvqpYC2UvGW8TC35rw7YDdNPU8rSrk2IpotATYufRdT8AlRk7AD616Nu2RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682730; c=relaxed/simple;
	bh=G3NmOMcbpsu15GLZ8fYyvilvgZ7XJfkbamQKb/GrfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+E98wwbawuSOcWQ80iLFU3nQhSJUF47sHgSdyAM80awbW0WG03s3EEtBARZ0+frgKUJJNX3jj0CfDyJhcaKO8ECGNF7BeBDGrAKmOvz1VLVMH2b0WCA6onQbDB7f7nD6YxRTwrCBE3IhS+QIut5m46EIMMOkilypjM4/uuslxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yd6+U1hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4862C2BD10;
	Tue, 14 May 2024 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682730;
	bh=G3NmOMcbpsu15GLZ8fYyvilvgZ7XJfkbamQKb/GrfjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yd6+U1hJIYtou55rVNo1mPQWodvGuhZ/h7jntT3DcaSyAoPSHNRuToFHp6OuLGo2f
	 44M5Jc5qpgz5R7msGM4ZynL7ouVPWgTH+WyVzds5is2AWxju+2x6QfU99KGywSjvcu
	 IHuDWRy6aFg6zyR/yyttwIw43Z3W5qSowKcbe0cg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 104/336] fs/9p: fix uninitialized values during inode evict
Date: Tue, 14 May 2024 12:15:08 +0200
Message-ID: <20240514101042.532819449@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Van Hensbergen <ericvh@kernel.org>

[ Upstream commit 6630036b7c228f57c7893ee0403e92c2db2cd21d ]

If an iget fails due to not being able to retrieve information
from the server then the inode structure is only partially
initialized.  When the inode gets evicted, references to
uninitialized structures (like fscache cookies) were being
made.

This patch checks for a bad_inode before doing anything other
than clearing the inode from the cache.  Since the inode is
bad, it shouldn't have any state associated with it that needs
to be written back (and there really isn't a way to complete
those anyways).

Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e6..7d42f0c6c644f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -371,17 +371,21 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	__le32 __maybe_unused version;
 
-	truncate_inode_pages_final(&inode->i_data);
+	if (!is_bad_inode(inode)) {
+		truncate_inode_pages_final(&inode->i_data);
 
-	version = cpu_to_le32(v9inode->qid.version);
-	netfs_clear_inode_writeback(inode, &version);
+		version = cpu_to_le32(v9inode->qid.version);
+		netfs_clear_inode_writeback(inode, &version);
 
-	clear_inode(inode);
-	filemap_fdatawrite(&inode->i_data);
+		clear_inode(inode);
+		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+		if (v9fs_inode_cookie(v9inode))
+			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
+	} else
+		clear_inode(inode);
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
-- 
2.43.0




