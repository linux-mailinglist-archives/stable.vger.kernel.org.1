Return-Path: <stable+bounces-17986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAB8480EA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174ED28A8A0
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F01A1B26E;
	Sat,  3 Feb 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M54aRwta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FD12E49;
	Sat,  3 Feb 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933463; cv=none; b=JTMggpyOO2cakaKJemu0t23ADCK6hMTFq6bsskBzJXc8gfyYmpVjdHkK2BVwlDTCv82fZNKdrCm71fScecVXWfKUZz8mACnRo2PqEKkJOlT/+oNtTE71/FnNFM8LoZ6knozy5Dzu6YcGAKmYnphZDYtAOpFsLJfXIolpRpSzoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933463; c=relaxed/simple;
	bh=Jm76YsSe7KmFYuqfqC78F+UNiqpqFeT8VAq3KTSzCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4Aku3G1n3ZTo5emXKJFu1Em/Hv9C2AG1VsIL6pk79y1DtV0bKklRH7EHZq/3/sg/fNpja12v9vbPfDCsJ8oIPBg5Yw5iQY8a4u35m1pD1STT9iEvg6cZJkMhnIZZk+Os5LiE2xVaZJl5xNQIyFiL7i2CoTs/hL4kXUc40WfTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M54aRwta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AB7C433F1;
	Sat,  3 Feb 2024 04:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933463;
	bh=Jm76YsSe7KmFYuqfqC78F+UNiqpqFeT8VAq3KTSzCc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M54aRwtavO6dQolShML4Y15xBcr5Ripdl4yJpbtFWT8Gje2K4VPj+iu/zyC7s3tSh
	 iASBpRv8n3bOxh3ZihCz3CZqTbtkX5iH/5XBJnx8US0aRLuHRhORxJZus3Su/m393D
	 cwsMQhBa1zfhdr3gOz4fya3Jv21MLXusa10Fefx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenchao Hao <haowenchao2@huawei.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 177/219] ceph: fix invalid pointer access if get_quota_realm return ERR_PTR
Date: Fri,  2 Feb 2024 20:05:50 -0800
Message-ID: <20240203035341.607814406@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenchao Hao <haowenchao2@huawei.com>

[ Upstream commit 0f4cf64eabc6e16cfc2704f1960e82dc79d91c8d ]

This issue is reported by smatch that get_quota_realm() might return
ERR_PTR but we did not handle it. It's not a immediate bug, while we
still should address it to avoid potential bugs if get_quota_realm()
is changed to return other ERR_PTR in future.

Set ceph_snap_realm's pointer in get_quota_realm()'s to address this
issue, the pointer would be set to NULL if get_quota_realm() failed
to get struct ceph_snap_realm, so no ERR_PTR would happen any more.

[ xiubli: minor code style clean up ]

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/quota.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index f7fcf7f08ec6..ca4932e6f71b 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -194,10 +194,10 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
 }
 
 /*
- * This function walks through the snaprealm for an inode and returns the
- * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
+ * This function walks through the snaprealm for an inode and set the
+ * realmp with the first snaprealm that has quotas set (max_files,
  * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
- * reached, return the root ceph_snap_realm instead.
+ * reached, set the realmp with the root ceph_snap_realm instead.
  *
  * Note that the caller is responsible for calling ceph_put_snap_realm() on the
  * returned realm.
@@ -208,18 +208,19 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
  * this function will return -EAGAIN; otherwise, the snaprealms walk-through
  * will be restarted.
  */
-static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
-					       struct inode *inode,
-					       enum quota_get_realm which_quota,
-					       bool retry)
+static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
+			   enum quota_get_realm which_quota,
+			   struct ceph_snap_realm **realmp, bool retry)
 {
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
 	struct inode *in;
 	bool has_quota;
 
+	if (realmp)
+		*realmp = NULL;
 	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return NULL;
+		return 0;
 
 restart:
 	realm = ceph_inode(inode)->i_snap_realm;
@@ -245,7 +246,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 				break;
 			ceph_put_snap_realm(mdsc, realm);
 			if (!retry)
-				return ERR_PTR(-EAGAIN);
+				return -EAGAIN;
 			goto restart;
 		}
 
@@ -254,8 +255,11 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 		iput(in);
 
 		next = realm->parent;
-		if (has_quota || !next)
-		       return realm;
+		if (has_quota || !next) {
+			if (realmp)
+				*realmp = realm;
+			return 0;
+		}
 
 		ceph_get_snap_realm(mdsc, next);
 		ceph_put_snap_realm(mdsc, realm);
@@ -264,7 +268,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 	if (realm)
 		ceph_put_snap_realm(mdsc, realm);
 
-	return NULL;
+	return 0;
 }
 
 bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
@@ -272,6 +276,7 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old->i_sb);
 	struct ceph_snap_realm *old_realm, *new_realm;
 	bool is_same;
+	int ret;
 
 restart:
 	/*
@@ -281,9 +286,9 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	 * dropped and we can then restart the whole operation.
 	 */
 	down_read(&mdsc->snap_rwsem);
-	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
-	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
-	if (PTR_ERR(new_realm) == -EAGAIN) {
+	get_quota_realm(mdsc, old, QUOTA_GET_ANY, &old_realm, true);
+	ret = get_quota_realm(mdsc, new, QUOTA_GET_ANY, &new_realm, false);
+	if (ret == -EAGAIN) {
 		up_read(&mdsc->snap_rwsem);
 		if (old_realm)
 			ceph_put_snap_realm(mdsc, old_realm);
@@ -485,8 +490,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	bool is_updated = false;
 
 	down_read(&mdsc->snap_rwsem);
-	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
-				QUOTA_GET_MAX_BYTES, true);
+	get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYTES,
+			&realm, true);
 	up_read(&mdsc->snap_rwsem);
 	if (!realm)
 		return false;
-- 
2.43.0




