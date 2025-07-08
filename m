Return-Path: <stable+bounces-160849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD991AFD239
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DBC5439CF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE92E2F0D;
	Tue,  8 Jul 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CbjWnTub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25222E5B08;
	Tue,  8 Jul 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992869; cv=none; b=QAke+fC4KQBijaOAkA8DmwxbSSwdl2svfDzckngDfwUi8UR2yAmKt1Vvd9nDRrV9KgXehAowUrI1suvXiyvbjzZGcVkLkCCUMGtJHWoyDiloJSwAAW78lzbq09OXi58woHi70kbcuBamcx8RMmidBWovzoemU7JY8nyj3eEuC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992869; c=relaxed/simple;
	bh=fRNUCF6s1tzaX4FWPXIyIi7dHmtP/voWVYCAhCcBStc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKasITkVCLbHVYijdOFZZ8CzS/GmgbSDNvBb5XB+7Zop7nJ+mX4nO5gN4UDB0/uzXiWgkwxdLBg+ockfc4Ba3ZleME9MdJjrdWWzPVqppX1U/tJXjvnjSWp+LMKozDiq/hdIJapMO+jKC4/t9XT/D7cdSIfiXXTz/YqjzubhRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CbjWnTub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D41C4CEED;
	Tue,  8 Jul 2025 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992868;
	bh=fRNUCF6s1tzaX4FWPXIyIi7dHmtP/voWVYCAhCcBStc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbjWnTubDDqeDmuYz3r3As/klNIoOqbKggi3zmqNaG7K7qmsSaUsvp4RfxmvryUzA
	 DBBWRR0pZNRfK4kJvJZhTv+woH/niV7T7s6MGQ+Vrf5CAsKkBYcvao8cAZCehfruJm
	 X4ko2JddyzlyD0iwf7fGzwjVOXlCKtwM6V5KJroc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 109/232] gfs2: Move GIF_ALLOC_FAILED check out of gfs2_ea_dealloc
Date: Tue,  8 Jul 2025 18:21:45 +0200
Message-ID: <20250708162244.293075797@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 0cc617a54dfe6b44624c9a03e2e11a24eb9bc720 ]

Don't check for the GIF_ALLOC_FAILED flag in gfs2_ea_dealloc() and pass
that information explicitly instead.  This allows for a cleaner
follow-up patch.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: 2c63986dd35f ("gfs2: deallocate inodes in gfs2_create_inode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c |  2 +-
 fs/gfs2/xattr.c | 11 ++++++-----
 fs/gfs2/xattr.h |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index aad6d5d2816e3..694d554dba546 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1319,7 +1319,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	}
 
 	if (ip->i_eattr) {
-		ret = gfs2_ea_dealloc(ip);
+		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
 		if (ret)
 			goto out;
 	}
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 17ae5070a90e6..df9c93de94c79 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1383,7 +1383,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 	return error;
 }
 
-static int ea_dealloc_block(struct gfs2_inode *ip)
+static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrpd *rgd;
@@ -1416,7 +1416,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 	ip->i_eattr = 0;
 	gfs2_add_inode_blocks(&ip->i_inode, -1);
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = gfs2_meta_inode_buffer(ip, &dibh);
 		if (!error) {
 			gfs2_trans_add_meta(ip->i_gl, dibh);
@@ -1435,11 +1435,12 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 /**
  * gfs2_ea_dealloc - deallocate the extended attribute fork
  * @ip: the inode
+ * @initialized: xattrs have been initialized
  *
  * Returns: errno
  */
 
-int gfs2_ea_dealloc(struct gfs2_inode *ip)
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized)
 {
 	int error;
 
@@ -1451,7 +1452,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 	if (error)
 		return error;
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = ea_foreach(ip, ea_dealloc_unstuffed, NULL);
 		if (error)
 			goto out_quota;
@@ -1463,7 +1464,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 		}
 	}
 
-	error = ea_dealloc_block(ip);
+	error = ea_dealloc_block(ip, initialized);
 
 out_quota:
 	gfs2_quota_unhold(ip);
diff --git a/fs/gfs2/xattr.h b/fs/gfs2/xattr.h
index eb12eb7e37c19..3c9788e0e1375 100644
--- a/fs/gfs2/xattr.h
+++ b/fs/gfs2/xattr.h
@@ -54,7 +54,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 		     const void *value, size_t size,
 		     int flags, int type);
 ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size);
-int gfs2_ea_dealloc(struct gfs2_inode *ip);
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized);
 
 /* Exported to acl.c */
 
-- 
2.39.5




