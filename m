Return-Path: <stable+bounces-35291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0489434A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD7428385A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B0482CA;
	Mon,  1 Apr 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RhZgBWqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F81DFF4;
	Mon,  1 Apr 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990917; cv=none; b=KCDZbshM7taocSkPFc4042bM1XMUvCfIkyN9RA0bqQjDgLhFcMB3MNo0kvGM7OqHUpD8PKYtclefZ6YFtsYKJKcX2vjP7Wdk5JwFd+9Y1FWIk6n3VNmKmCfK5d5Fmp6wIuKmdAAS/v04fSgg8jXSW7v+UhmnOQy6xjkjDokkip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990917; c=relaxed/simple;
	bh=65PT+ATWuciVg9fUCrawcu4dQbw0IBX1trOpu8HYRG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srK8/UoVo77OK3mVN7QO1iOs061QHK4PgC/QhYC4i5FNV0B1CwzqcFq5lnaxZY3fgVLJwy/voco8b5kEAzPIZEfmj4f/kNOjm5C7SvENmC81+pwC3qWh47fbbSu1Nr0d/CZPywKjxmxhvCfq4LCceKTx9ccHc123oKyw1eJ0Ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RhZgBWqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C099C433F1;
	Mon,  1 Apr 2024 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990917;
	bh=65PT+ATWuciVg9fUCrawcu4dQbw0IBX1trOpu8HYRG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhZgBWqwn8lkt6PwvYQzE90LleY1c4AlD9RA/aaa2tNDIUNkwamGZCPqRsrEAOpP0
	 BPPKArnXzkMjuJ1NzfMF4U9gQhR2x2LEcGdDJZjJToT3ShzzkPvNMXxHIejOT8ThV+
	 hbMiUA48lShgupDx1NCLSbvncZgyyt2QLIa63Mzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 106/272] ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info
Date: Mon,  1 Apr 2024 17:44:56 +0200
Message-ID: <20240401152533.948270923@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 34cd86b6632718b7df3999d96f51e63de41c5e4f ]

Use vfs_getattr() to retrieve stat information, rather than make
assumptions about how a filesystem fills inode structs.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 66d25d0e34d8b..39fc078284c8e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5757,15 +5757,21 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 
 	loff_t alloc_blks;
 	struct inode *inode;
+	struct kstat stat;
 	int rc;
 
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
+	rc = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			 AT_STATX_SYNC_AS_STAT);
+	if (rc)
+		return rc;
+
 	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
 	inode = file_inode(fp->filp);
 
-	if (alloc_blks > inode->i_blocks) {
+	if (alloc_blks > stat.blocks) {
 		smb_break_all_levII_oplock(work, fp, 1);
 		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
 				   alloc_blks * 512);
@@ -5773,7 +5779,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < inode->i_blocks) {
+	} else if (alloc_blks < stat.blocks) {
 		loff_t size;
 
 		/*
-- 
2.43.0




