Return-Path: <stable+bounces-100699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14BF9ED4FD
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF342840BA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA1236F83;
	Wed, 11 Dec 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMr/SyX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12223695A;
	Wed, 11 Dec 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943044; cv=none; b=RYhELmFjbHJxx6heEfipmekNEVoLJXqdP55g7j2BAbXiGdAUNqPWpE8/+5t/FKo8PDjFuZFgH8bGmdDq7+RoMlMrj6aRdMJfT0yQ4d4l0nK1YuqqvhdiN+JLFqDvNABlCgbac/wGg1OXsxSMpWfN+Vfa3bwmSHmKgpT/DShRudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943044; c=relaxed/simple;
	bh=XCi09Y8r6HODJn5IXLArntZZI5bskvFmlDyqNcwzYjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQFed+ZiGQrGqOMSMRJu9wcLIXHM+c9fftP06jeqOrZAWTBODj9CkUz+RrH1cEAOtFVyBV/7Y0Le4vz2hdVX7eIrTdSfhSTGvJsK5j4lF4O7WFYzW1SgTKjWGo29Rnt9xbRdyvLY9zR4AFyP9sRiiTCfaecrCeqZnSLUmVy28qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMr/SyX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B7C4CEDF;
	Wed, 11 Dec 2024 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943044;
	bh=XCi09Y8r6HODJn5IXLArntZZI5bskvFmlDyqNcwzYjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMr/SyX2LQ71zBXQ41sTszGsX21Xw3L5S317LLQotAcVtddVrjxTxhAlEr4Zp7DMl
	 i0HX3ak+f83pLyHNxbuIom64ooFFh4Wm/aq0egxNcSFgXi+2sh2Ttg3j2UIWp3kFlL
	 LmMdgdwdn+pBdIb5og3OlFb7CwbvnV8cykTc9vor6vqQLnwUJcNIZZ8obfvzXu43Zq
	 d+cnRGrLJt6gsCtAUx6zkDcV911q+HhPhKj/1N3toHmlWvA6VXU/Z3iYqM5ZYjcVYR
	 sy46FZW4jj/RjzJkzWPsjkTGAknGLg08940WzIYd/8zwNjVoZmBUBy9SB3nH/PBDSb
	 1ZlD/kt93srtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.12 09/36] udf: Verify inode link counts before performing rename
Date: Wed, 11 Dec 2024 13:49:25 -0500
Message-ID: <20241211185028.3841047-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 6756af923e06aa33ad8894aaecbf9060953ba00f ]

During rename, we are updating link counts of various inodes either when
rename deletes target or when moving directory across directories.
Verify involved link counts are sane so that we don't trip warnings in
VFS.

Reported-by: syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 2be775d30ac10..2cb49b6b07168 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -791,8 +791,18 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
 				goto out_oiter;
+			retval = -EFSCORRUPTED;
+			if (new_inode->i_nlink != 2)
+				goto out_oiter;
 		}
+		retval = -EFSCORRUPTED;
+		if (old_dir->i_nlink < 3)
+			goto out_oiter;
 		is_dir = true;
+	} else if (new_inode) {
+		retval = -EFSCORRUPTED;
+		if (new_inode->i_nlink < 1)
+			goto out_oiter;
 	}
 	if (is_dir && old_dir != new_dir) {
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
-- 
2.43.0


