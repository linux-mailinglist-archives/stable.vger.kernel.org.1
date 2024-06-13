Return-Path: <stable+bounces-51872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E080907202
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842C51C21635
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588AA59;
	Thu, 13 Jun 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ri05o54M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217321849;
	Thu, 13 Jun 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282563; cv=none; b=JeqBGCVxZxr9XTAAsimDscZGcODVESOhEezZNRTTTQAId1bvl/3uSY4ksuEBXRGOIGDqRNf3yuHplHJZmpxmSvdydEkR8IQFSQh2pwihe+/962gaefyYnaFTc2J5UAmvHB7cOfudB9iPbhlFvxM9gwVCnQqJaRw4dSRiMh5fEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282563; c=relaxed/simple;
	bh=r92TeYbC+S01cO2bnWjlNp62ptjoQObsgWoaua8uqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw7TsiykocbOpoKwjQ/0ZJDYLfew2fFK2mY2bMX5AfNloa9Ib6byc/0KaTFD1KRowWq0/JgaaiGcJP+IYkRhDljbptBEfUQ3DTaUigqjENvw1tOPxMC53QsKoXuAUkafEMjMbOWtCotVuAQidvp/yeqE3DRGwiRFKZMbOB85UKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ri05o54M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA99C32786;
	Thu, 13 Jun 2024 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282563;
	bh=r92TeYbC+S01cO2bnWjlNp62ptjoQObsgWoaua8uqjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri05o54MVeuFqL6ImOFRG2ypZHBSqyoHpwD6Msoy6fIBhLe3nedet12J/aQLOpYBp
	 DrAtbV56DGlJGE/QkmQC2Oz32J032YCOGvBxHKnZu2rHg6zU8KyjmM7E6hgzEwi3sK
	 vVMnIvXuid8KeW+ctNsSnDRwCHkD87jM9fgMEiAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 288/402] NFSv4: Fixup smatch warning for ambiguous return
Date: Thu, 13 Jun 2024 13:34:05 +0200
Message-ID: <20240613113313.386279069@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 37ffe06537af3e3ec212e7cbe941046fce0a822f ]

Dan Carpenter reports smatch warning for nfs4_try_migration() when a memory
allocation failure results in a zero return value.  In this case, a
transient allocation failure error will likely be retried the next time the
server responds with NFS4ERR_MOVED.

We can fixup the smatch warning with a small refactor: attempt all three
allocations before testing and returning on a failure.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on referral lookup.")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index d7868cc527805..d452fa85a567c 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2102,6 +2102,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs_fattr *fattr;
 	struct inode *inode;
 	struct page *page;
 	int status, result;
@@ -2111,19 +2112,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 			(unsigned long long)server->fsid.minor,
 			clp->cl_hostname);
 
-	result = 0;
 	page = alloc_page(GFP_KERNEL);
 	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (page == NULL || locations == NULL) {
-		dprintk("<-- %s: no memory\n", __func__);
-		goto out;
-	}
-	locations->fattr = nfs_alloc_fattr();
-	if (locations->fattr == NULL) {
+	fattr = nfs_alloc_fattr();
+	if (page == NULL || locations == NULL || fattr == NULL) {
 		dprintk("<-- %s: no memory\n", __func__);
+		result = 0;
 		goto out;
 	}
 
+	locations->fattr = fattr;
 	inode = d_inode(server->super->s_root);
 	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
 					 page, cred);
-- 
2.43.0




