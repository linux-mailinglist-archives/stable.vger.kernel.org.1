Return-Path: <stable+bounces-2126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A607F82E3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62042B231D4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82519364C1;
	Fri, 24 Nov 2023 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELbkxirp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7833CFD;
	Fri, 24 Nov 2023 19:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E996C433C7;
	Fri, 24 Nov 2023 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853112;
	bh=sONzyrbRjcnX1YeQ9n2M8OtBThx36Crv/CCuEC/pYEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELbkxirp1hX77TNkg+HZKziiME7YOdaBWcOcJuJll4de324k12IJVvkgbcTbEeQs8
	 Q3axeWohnCI4WW4hXmxhjzZVKNS620DiflPH5FfBWjmhtDkPoJ72Ylm49SZVaTlncy
	 +ismXpVCRq4J0kNLldAERVZY7P+vn6eSJWgaTAvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/297] exfat: support handle zero-size directory
Date: Fri, 24 Nov 2023 17:51:41 +0000
Message-ID: <20231124172002.277667860@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit dab48b8f2fe7264d51ec9eed0adea0fe3c78830a ]

After repairing a corrupted file system with exfatprogs' fsck.exfat,
zero-size directories may result. It is also possible to create
zero-size directories in other exFAT implementation, such as Paragon
ufsd dirver.

As described in the specification, the lower directory size limits
is 0 bytes.

Without this commit, sub-directories and files cannot be created
under a zero-size directory, and it cannot be removed.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b22d6c984f8c7..cfa46d8cf5b39 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -330,14 +330,20 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
 
-		/* we trust p_dir->size regardless of FAT type */
-		if (exfat_find_last_cluster(sb, p_dir, &last_clu))
-			return -EIO;
-
 		/*
 		 * Allocate new cluster to this directory
 		 */
-		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		if (ei->start_clu != EXFAT_EOF_CLUSTER) {
+			/* we trust p_dir->size regardless of FAT type */
+			if (exfat_find_last_cluster(sb, p_dir, &last_clu))
+				return -EIO;
+
+			exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		} else {
+			/* This directory is empty */
+			exfat_chain_set(&clu, EXFAT_EOF_CLUSTER, 0,
+					ALLOC_NO_FAT_CHAIN);
+		}
 
 		/* allocate a cluster */
 		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
@@ -347,6 +353,11 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_zeroed_cluster(inode, clu.dir))
 			return -EIO;
 
+		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
+			ei->start_clu = clu.dir;
+			p_dir->dir = clu.dir;
+		}
+
 		/* append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
 			/* no-fat-chain bit is disabled,
@@ -644,7 +655,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
 	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+	if (info->size == 0) {
 		info->flags = ALLOC_NO_FAT_CHAIN;
 		info->start_clu = EXFAT_EOF_CLUSTER;
 	} else {
@@ -891,6 +902,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1274,7 +1288,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
-- 
2.42.0




