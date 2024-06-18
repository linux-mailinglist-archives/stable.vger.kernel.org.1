Return-Path: <stable+bounces-53280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15990D0F3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1071C24015
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46918EFF8;
	Tue, 18 Jun 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xoaxonhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83E18EFF3;
	Tue, 18 Jun 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715861; cv=none; b=bgpgeaofryIiFx9csSYlowXvPnAilpOu0s0lxcH80lJKZcISU7vAIbRXRkf/ys3iXZT5CcS8Wc4/ptsV+SxPiSIX72kN9HwVT4Hjo/pl6eLePBKmFxIfQo6SGyC8VAWcEIZrPP1mz6+lEOUdTsFLATWeVHzMEy+uVAouYC6bmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715861; c=relaxed/simple;
	bh=yo/7IuZHOx2KjXKfHZLACmAVc4sGvhm9/4MTNgVvIxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj83mHKJvuPg+uCzf7RFqjKYk9en69LCd65UN7qrdNoYjnP0kWoJ0vu3OnD3F0UD72fhf0qnw88r8gK8+fKz3yGaRk3qkISmZpozFYN1ZeJhkDCr+48PRzu0NjP3M3fZUns2nZly05MNdN0SuLj13ChwkWtPIsuayGNOFrmVP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xoaxonhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027A6C3277B;
	Tue, 18 Jun 2024 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715861;
	bh=yo/7IuZHOx2KjXKfHZLACmAVc4sGvhm9/4MTNgVvIxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoaxonhwFpqiLSuXLmwIE9g4Kfy5PEdsnD3dgLstxKJIKz9XJJDHMYZl3zyQAoejq
	 3PYzplRa2v0fo6WVpD9Dy0c3Yot9h5NaiZs5P8ezUQnzCKwMlUvkY+IxbDoK9Z3Wix
	 oQu7ALQzp/wNgpfzNrEru23aH4aohhZRi3tGBMj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 410/770] fanotify: use helpers to parcel fanotify_info buffer
Date: Tue, 18 Jun 2024 14:34:23 +0200
Message-ID: <20240618123423.111056682@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 1a9515ac9e55e68d733bab81bd408463ab1e25b1 ]

fanotify_info buffer is parceled into variable sized records, so the
records must be written in order: dir_fh, file_fh, name.

Use helpers to assert that order and make fanotify_alloc_name_event()
a bit more generic to allow empty dir_fh record and to allow expanding
to more records (i.e. name2) soon.

Link: https://lore.kernel.org/r/20211129201537.1932819-7-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++----------------
 fs/notify/fanotify/fanotify.h | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ffad224be0149..2b13c79cebc62 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -576,7 +576,7 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 	return &ffe->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
+static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 							__kernel_fsid_t *fsid,
 							const struct qstr *name,
 							struct inode *child,
@@ -586,15 +586,17 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
-	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
+	unsigned int dir_fh_len = fanotify_encode_fh_len(dir);
 	unsigned int child_fh_len = fanotify_encode_fh_len(child);
-	unsigned int size;
+	unsigned long name_len = name ? name->len : 0;
+	unsigned int len, size;
 
-	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	/* Reserve terminating null byte even for empty name */
+	size = sizeof(*fne) + name_len + 1;
+	if (dir_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + dir_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	if (name)
-		size += name->len + 1;
 	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
@@ -604,22 +606,23 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	*hash ^= fanotify_hash_fsid(fsid);
 	info = &fne->info;
 	fanotify_info_init(info);
-	dfh = fanotify_info_dir_fh(info);
-	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, hash, 0);
+	if (dir_fh_len) {
+		dfh = fanotify_info_dir_fh(info);
+		len = fanotify_encode_fh(dfh, dir, dir_fh_len, hash, 0);
+		fanotify_info_set_dir_fh(info, len);
+	}
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
-		info->file_fh_totlen = fanotify_encode_fh(ffh, child,
-							child_fh_len, hash, 0);
+		len = fanotify_encode_fh(ffh, child, child_fh_len, hash, 0);
+		fanotify_info_set_file_fh(info, len);
 	}
-	if (name) {
-		long salt = name->len;
-
+	if (name_len) {
 		fanotify_info_copy_name(info, name);
-		*hash ^= full_name_hash((void *)salt, name->name, name->len);
+		*hash ^= full_name_hash((void *)name_len, name->name, name_len);
 	}
 
-	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
-		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
+	pr_debug("%s: size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
+		 __func__, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
 	return &fne->fae;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index dd23ba659e76b..7ac6f9f1e4148 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -138,6 +138,26 @@ static inline void fanotify_info_init(struct fanotify_info *info)
 	info->name_len = 0;
 }
 
+/* These set/copy helpers MUST be called by order */
+static inline void fanotify_info_set_dir_fh(struct fanotify_info *info,
+					    unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0))
+		return;
+
+	info->dir_fh_totlen = totlen;
+}
+
+static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
+					     unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->name_len > 0))
+		return;
+
+	info->file_fh_totlen = totlen;
+}
+
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-- 
2.43.0




