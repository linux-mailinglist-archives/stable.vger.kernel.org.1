Return-Path: <stable+bounces-5948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EE80D800
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5301F21241
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315E52F7F;
	Mon, 11 Dec 2023 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aRSWXVEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115241D696;
	Mon, 11 Dec 2023 18:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F3EC433C9;
	Mon, 11 Dec 2023 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320098;
	bh=PlCACUQw9d3JP8VAh9cQ9qKUTLao52L9aYiUSdr/ZTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRSWXVEAN2j8hXvGPHxgzcTg0MxGzFeaqncsEiBm3PpwA6evplv6B0m8wNmU7WahL
	 1MzuOM5UvnQ1GommUNSnriGoHyhpzIkMHEYQ01EdMs15uwomolV5gs0SWgigXjAXQp
	 F7Se4NuRoWJPgBChXq7DPY0EH7dI8dOI+QxzXwt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 94/97] smb: client: fix potential NULL deref in parse_dfs_referrals()
Date: Mon, 11 Dec 2023 19:22:37 +0100
Message-ID: <20231211182023.867440600@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 92414333eb375ed64f4ae92d34d579e826936480 ]

If server returned no data for FSCTL_DFS_GET_REFERRALS, @dfs_rsp will
remain NULL and then parse_dfs_referrals() will dereference it.

Fix this by returning -EIO when no output data is returned.

Besides, we can't fix it in SMB2_ioctl() as some FSCTLs are allowed to
return no data as per MS-SMB2 2.2.32.

Fixes: 9d49640a21bf ("CIFS: implement get_dfs_refer for SMB2+")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 015b7b37edee5..e58525a958270 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2765,6 +2765,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 				(char **)&dfs_rsp, &dfs_rsp_size);
 	} while (rc == -EAGAIN);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if ((rc != -ENOENT) && (rc != -EOPNOTSUPP))
 			cifs_tcon_dbg(VFS, "ioctl error in %s rc=%d\n", __func__, rc);
-- 
2.42.0




