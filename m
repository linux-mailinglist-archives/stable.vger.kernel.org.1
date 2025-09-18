Return-Path: <stable+bounces-177181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3DB40400
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A797188DC83
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685E310650;
	Tue,  2 Sep 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8r4CuCm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45630EF9D;
	Tue,  2 Sep 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819841; cv=none; b=FoOz9IEmekPe/mwaYg8cO2jxlHUNidkELHA/XWJ47Ok9l0NUnfarrKMsvJ4LtBh98j3UVT7cT3CZOe0iCJT5wf3HR95tIWELzNHY19ZVooSJ/Pm/Gof/ArBE9V++V57VxCSMgFWphSYnfPsR661RTuGLmk4/mWj0GvI2xG3FcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819841; c=relaxed/simple;
	bh=+Dtk2DyDvkDPXt+hDXQpMKXlQYlCLP7UnJ8tXTBDDPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsSEXND94gZEPdkH8A0hrGfPHd/7lXGGMxuJmXKbzFjl336y11ug3At4xPGacqaQTstm8ew4sWGkitfJmaV1WV84DRZweYskAe7UReED+oX7cNLR1kv5n54b5VgX0zEs+7A00GnSP0PihG6V28yjGX8mRgxHYeug2phDqsaReGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8r4CuCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A2DC4CEED;
	Tue,  2 Sep 2025 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819841;
	bh=+Dtk2DyDvkDPXt+hDXQpMKXlQYlCLP7UnJ8tXTBDDPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8r4CuCmajyO1di5fG/eMyqAy4kNXA87KsjRvpLkOPFjWAKqz+c4C4utPdEuwdAop
	 WlUNZbObPY2dziLDgJ4WvR+A392UKuk+jqpcC3w1MV0TOM9OkK8Alk7bj6VP8l/kok
	 8NPAaiFeSGBou64OkFoXJ7h2WCTI4Gn1EhoCv5Wc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jay Shin <jaeshin@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-cifs@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 13/95] smb: client: fix race with concurrent opens in unlink(2)
Date: Tue,  2 Sep 2025 15:19:49 +0200
Message-ID: <20250902131940.122581369@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 0af1561b2d60bab2a2b00720a5c7b292ecc549ec ]

According to some logs reported by customers, CIFS client might end up
reporting unlinked files as existing in stat(2) due to concurrent
opens racing with unlink(2).

Besides sending the removal request to the server, the unlink process
could involve closing any deferred close as well as marking all
existing open handles as deleted to prevent them from deferring
closes, which increases the race window for potential concurrent
opens.

Fix this by unhashing the dentry in cifs_unlink() to prevent any
subsequent opens.  Any open attempts, while we're still unlinking,
will block on parent's i_rwsem.

Reported-by: Jay Shin <jaeshin@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 31fce0a1b5719..02f78e58e11d0 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1917,15 +1917,24 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
+	__u32 dosattr = 0, origattr = 0;
 	struct TCP_Server_Info *server;
 	struct iattr *attrs = NULL;
-	__u32 dosattr = 0, origattr = 0;
+	bool rehash = false;
 
 	cifs_dbg(FYI, "cifs_unlink, dir=0x%p, dentry=0x%p\n", dir, dentry);
 
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return -EIO;
 
+	/* Unhash dentry in advance to prevent any concurrent opens */
+	spin_lock(&dentry->d_lock);
+	if (!d_unhashed(dentry)) {
+		__d_drop(dentry);
+		rehash = true;
+	}
+	spin_unlock(&dentry->d_lock);
+
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -1977,7 +1986,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 			cifs_drop_nlink(inode);
 		}
 	} else if (rc == -ENOENT) {
-		d_drop(dentry);
+		if (simple_positive(dentry))
+			d_delete(dentry);
 	} else if (rc == -EBUSY) {
 		if (server->ops->rename_pending_delete) {
 			rc = server->ops->rename_pending_delete(full_path,
@@ -2030,6 +2040,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	kfree(attrs);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
+	if (rehash)
+		d_rehash(dentry);
 	return rc;
 }
 
-- 
2.50.1




