Return-Path: <stable+bounces-87965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8509AD8B3
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CA11C21654
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A792003C2;
	Wed, 23 Oct 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="QKnzaIV8"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63191FF7DB;
	Wed, 23 Oct 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727546; cv=none; b=EDqxtOpZuEi78agYX+eKn1OwXIOUEg4rEAraV59qW55XRnYS1r2Hnqo3JRK2UaHIg3zijHNNgwPH1k9X7KoHnoUHTBpaCd2xPU7H0jMdH6EdlYHKuwaz3F49wsBoPixNSbwZ3JCXeYRwCL3G7t5Y3N6NfX/IfKpXTHbS9g73U5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727546; c=relaxed/simple;
	bh=2jNRSNETBdoBmXcxqoPcSW/Pu+5mOR/5FQsdWsgGU1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXh0KB67XmdxAA/0kq7OZip9qmp/aXwT0azaQxYqZmZBVjl4Z0z3dZFJIRt+CWdEGM4D9MhkBJQwWhGDfODJsdVh/POkjkVUN6vsZ9rHJEL04Cuq552GSgugH4fnN2xUMwYs1uDfDkF4+vgExageTI6ZXKpJYyDr+x64PMhvNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=QKnzaIV8; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 494E214C2DE;
	Thu, 24 Oct 2024 01:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729727543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9RUoHXYJukKxYmUrbnbvTXMN6BCsDk1ng65p881zxY=;
	b=QKnzaIV8nv6sJ0N/C1zf77MAnsd5hTyD2me5tv/nJ4kDZ+7VggPA0vVHmcjU5Y8ueVFseX
	4ltvTyRZYWssqmTlWmWs4k/cqhH5SDJ5jj802392QfZR2oZGcAvwlq/EmEZZf2QGUd1iZ9
	UufM/uGwnpL456/XcJxLN2haoZaSN8lIuOu4KJ8JGDIgUoMgztdWl8ms+Nm+AqjTFCLtAE
	wYvP5ixeiTr3Kzk5+JZIJSnIIGvpDlHYs8AlD8Fa8bBeaHK42q+J9q4b3KDL1SNeJHlgSg
	UCJ7bBGmUEcQhKS1zmEuMIQ7V6s+XSgVqw8OG7yy41qWPKIzIsKyN6wIVIpFRQ==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 23319dd8;
	Wed, 23 Oct 2024 23:52:14 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 24 Oct 2024 08:52:11 +0900
Subject: [PATCH 2/4] Revert "fs/9p: remove redundant pointer v9ses"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-revert_iget-v1-2-4cac63d25f72@codewreck.org>
References: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
In-Reply-To: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Will Deacon <will@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=2jNRSNETBdoBmXcxqoPcSW/Pu+5mOR/5FQsdWsgGU1g=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYwusNK+2S7ozYMD51VyLjMOVOK7Jzb5Kvx2y
 w87QOPuXe+JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmMLgAKCRCrTpvsapjm
 cFefD/94l9C7Rbe1mO1CEvyJQ6fNSmwP9/KG7tEXeLw6OKzMgwnV+VUryXJDxEy+C6UujLoKyv1
 Q7mieUoJ6FGFzHxhCrP2rQ66TIIuGy+HbcPAJuaYUEFR4hIi62Ti78wj7KI3Uz1Vov2gY2s/8DR
 9tkHd2VMNpHUG7fNEmouSVwAjrDwjIkop0LOuZfXqhXA7fw4Fx0uHNzhHGHUeZfrNkDJGBgwc3l
 CvC4W8H/J0SiWbCXITmyEiX/3mXJ4vLmBKn6BvpGxoYezQdkRLZT3m2cmgmT5p/JkEIKXc9LWP1
 2+UdtRKQrJA6AQWiK111r3+vUZ1VocBSbpo354b5w6wBgE6PhxJELoilClbOfbYOYE6Jj8KYfbI
 rx+ERHTrtwUVqikJeOrV6K9v7rNY5pCqDvtXPnza+YZOTw+dAFhDtM9LCeWC3+sCcC/+y7MkdiR
 sV1FSVgKRxGwXc/stzDsIWUvyGQ/iq4j20CgDtiCdu4BE7eudLqISfmq+ERcAjcFRBF6YeU2hPD
 HfoRlZWh2lMQ7aPdMcx8+H8LE9HVt/0R3Cfz+FC8SviJFzDTHS21utNEewWDweeKnuTxJcBwKiV
 1CEy+ppL4yx83tJqFbgYx/h1CbF2Q7iWrUGrl+QEgfvRZIXf0SMi/tm7QJEht/lSs4UHN3xvPyM
 utlQNgLKVwf1btA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This reverts commit 10211b4a23cf4a3df5c11a10e5b3d371f16a906f.

This is a requirement to revert commit 724a08450f74 ("fs/9p: simplify
iget to remove unnecessary paths"), see that revert for details.

Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
Reported-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20240923100508.GA32066@willie-the-truck
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_inode_dotl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 55dde186041a..2b313fe7003e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,6 +297,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       umode_t omode)
 {
 	int err;
+	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -306,6 +307,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
+	v9ses = v9fs_inode2v9ses(dir);
 
 	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -737,6 +739,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
+	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -746,6 +749,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 
+	v9ses = v9fs_inode2v9ses(dir);
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err = PTR_ERR(dfid);

-- 
2.46.0


