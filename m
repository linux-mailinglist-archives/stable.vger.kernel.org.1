Return-Path: <stable+bounces-180127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B0B7EA51
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4670188BA94
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AE2F39DC;
	Wed, 17 Sep 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugGPpBHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FF30CB29;
	Wed, 17 Sep 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113468; cv=none; b=iPQNTfZ8nlfRbCQDjiRmOid34ODQs93AhEtoX8xl1qCM68fY9faOnDQxxtVHg1wRgmY8rPNAJT0ZG/1d8evXdPTuCp537QNGMVvrc2Fx785oQao/vR/apDEde6mw/ITHLc3WJbL/Cafr1W4aH5vKuLwRrl8tBq+cwSW2EmQIiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113468; c=relaxed/simple;
	bh=VFmLMmOMs2sm0FdFo6YFJbpF9VMRdzibWj9BX0g5yHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2HWWOA+GX0PrXgCTgVoWdt6HRzERO7Xd4jnorCAJhVUZvdV/PMjEmspC0wgaCdKP0zIHqHMjby5OscIe5ZADvLvq9fp/R7mnEN4Ie1kpK1xRwz0Dxd94ZoAHuC5BZyJnQp2cVLDiegbRGYMCNfOi0pwP0PrJktNdLSlhR4Tsic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugGPpBHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0818C4CEF0;
	Wed, 17 Sep 2025 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113468;
	bh=VFmLMmOMs2sm0FdFo6YFJbpF9VMRdzibWj9BX0g5yHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugGPpBHbrLetiLib58FZzcXbII+Armrr2v1yq73erfCFZYmrIPECsoo1/G89gRuJ8
	 bOUrNM8clta7RxaqBusqRRy1xIDznw08L22HMMedamfbbHxHnMmv7Ugw8V+XQSkYr6
	 jynwQ3Dv4ftWZlIu1O7tXuAgqDuluplKLmsf594Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12 078/140] ceph: fix race condition where r_parent becomes stale before sending message
Date: Wed, 17 Sep 2025 14:34:10 +0200
Message-ID: <20250917123346.217417729@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Markuze <amarkuze@redhat.com>

commit bec324f33d1ed346394b2eee25bf6dbf3511f727 upstream.

When the parent directory's i_rwsem is not locked, req->r_parent may become
stale due to concurrent operations (e.g. rename) between dentry lookup and
message creation. Validate that r_parent matches the encoded parent inode
and update to the correct inode if a mismatch is detected.

[ idryomov: folded a follow-up fix from Alex to drop extra reference
  from ceph_get_reply_dir() in ceph_fill_trace():

  ceph_get_reply_dir() may return a different, referenced inode when
  r_parent is stale and the parent directory lock is not held.
  ceph_fill_trace() used that inode but failed to drop the reference
  when it differed from req->r_parent, leaking an inode reference.

  Keep the directory inode in a local variable and iput() it at
  function end if it does not match req->r_parent. ]

Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/inode.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 12 deletions(-)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -55,6 +55,52 @@ static int ceph_set_ino_cb(struct inode
 	return 0;
 }
 
+/*
+ * Check if the parent inode matches the vino from directory reply info
+ */
+static inline bool ceph_vino_matches_parent(struct inode *parent,
+					    struct ceph_vino vino)
+{
+	return ceph_ino(parent) == vino.ino && ceph_snap(parent) == vino.snap;
+}
+
+/*
+ * Validate that the directory inode referenced by @req->r_parent matches the
+ * inode number and snapshot id contained in the reply's directory record.  If
+ * they do not match – which can theoretically happen if the parent dentry was
+ * moved between the time the request was issued and the reply arrived – fall
+ * back to looking up the correct inode in the inode cache.
+ *
+ * A reference is *always* returned.  Callers that receive a different inode
+ * than the original @parent are responsible for dropping the extra reference
+ * once the reply has been processed.
+ */
+static struct inode *ceph_get_reply_dir(struct super_block *sb,
+					struct inode *parent,
+					struct ceph_mds_reply_info_parsed *rinfo)
+{
+	struct ceph_vino vino;
+
+	if (unlikely(!rinfo->diri.in))
+		return parent; /* nothing to compare against */
+
+	/* If we didn't have a cached parent inode to begin with, just bail out. */
+	if (!parent)
+		return NULL;
+
+	vino.ino  = le64_to_cpu(rinfo->diri.in->ino);
+	vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+
+	if (likely(ceph_vino_matches_parent(parent, vino)))
+		return parent; /* matches – use the original reference */
+
+	/* Mismatch – this should be rare.  Emit a WARN and obtain the correct inode. */
+	WARN_ONCE(1, "ceph: reply dir mismatch (parent valid %llx.%llx reply %llx.%llx)\n",
+		  ceph_ino(parent), ceph_snap(parent), vino.ino, vino.snap);
+
+	return ceph_get_inode(sb, vino, NULL);
+}
+
 /**
  * ceph_new_inode - allocate a new inode in advance of an expected create
  * @dir: parent directory for new inode
@@ -1523,6 +1569,7 @@ int ceph_fill_trace(struct super_block *
 	struct ceph_vino tvino, dvino;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	struct inode *parent_dir = NULL;
 	int err = 0;
 
 	doutc(cl, "%p is_dentry %d is_target %d\n", req,
@@ -1536,10 +1583,17 @@ int ceph_fill_trace(struct super_block *
 	}
 
 	if (rinfo->head->is_dentry) {
-		struct inode *dir = req->r_parent;
-
-		if (dir) {
-			err = ceph_fill_inode(dir, NULL, &rinfo->diri,
+		/*
+		 * r_parent may be stale, in cases when R_PARENT_LOCKED is not set,
+		 * so we need to get the correct inode
+		 */
+		parent_dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
+		if (unlikely(IS_ERR(parent_dir))) {
+			err = PTR_ERR(parent_dir);
+			goto done;
+		}
+		if (parent_dir) {
+			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
 					      &req->r_caps_reservation);
 			if (err < 0)
@@ -1548,14 +1602,14 @@ int ceph_fill_trace(struct super_block *
 			WARN_ON_ONCE(1);
 		}
 
-		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
+		if (parent_dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
 		    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		    !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 			bool is_nokey = false;
 			struct qstr dname;
 			struct dentry *dn, *parent;
 			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
-			struct ceph_fname fname = { .dir	= dir,
+			struct ceph_fname fname = { .dir	= parent_dir,
 						    .name	= rinfo->dname,
 						    .ctext	= rinfo->altname,
 						    .name_len	= rinfo->dname_len,
@@ -1564,10 +1618,10 @@ int ceph_fill_trace(struct super_block *
 			BUG_ON(!rinfo->head->is_target);
 			BUG_ON(req->r_dentry);
 
-			parent = d_find_any_alias(dir);
+			parent = d_find_any_alias(parent_dir);
 			BUG_ON(!parent);
 
-			err = ceph_fname_alloc_buffer(dir, &oname);
+			err = ceph_fname_alloc_buffer(parent_dir, &oname);
 			if (err < 0) {
 				dput(parent);
 				goto done;
@@ -1576,7 +1630,7 @@ int ceph_fill_trace(struct super_block *
 			err = ceph_fname_to_usr(&fname, NULL, &oname, &is_nokey);
 			if (err < 0) {
 				dput(parent);
-				ceph_fname_free_buffer(dir, &oname);
+				ceph_fname_free_buffer(parent_dir, &oname);
 				goto done;
 			}
 			dname.name = oname.name;
@@ -1595,7 +1649,7 @@ retry_lookup:
 				      dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
-					ceph_fname_free_buffer(dir, &oname);
+					ceph_fname_free_buffer(parent_dir, &oname);
 					err = -ENOMEM;
 					goto done;
 				}
@@ -1610,12 +1664,12 @@ retry_lookup:
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
 				doutc(cl, " dn %p points to wrong inode %p\n",
 				      dn, d_inode(dn));
-				ceph_dir_clear_ordered(dir);
+				ceph_dir_clear_ordered(parent_dir);
 				d_delete(dn);
 				dput(dn);
 				goto retry_lookup;
 			}
-			ceph_fname_free_buffer(dir, &oname);
+			ceph_fname_free_buffer(parent_dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
@@ -1794,6 +1848,9 @@ retry_lookup:
 					    &dvino, ptvino);
 	}
 done:
+	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
+	if (unlikely(!IS_ERR_OR_NULL(parent_dir) && parent_dir != req->r_parent))
+		iput(parent_dir);
 	doutc(cl, "done err=%d\n", err);
 	return err;
 }



