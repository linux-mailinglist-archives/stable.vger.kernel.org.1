Return-Path: <stable+bounces-178998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D19B49E16
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C51BC3AEA
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015C04C81;
	Tue,  9 Sep 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjhI6jCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA01E9906
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378208; cv=none; b=qhLaqUZragG5RyJKBpWzYq/E+z/9gZtp2i9jNQfbr4Sb1rBYOboeZjdu74tD9Y8R0qrxYYBvajAxs83ozEP39qytMoIGx3Gs+apmRydVZbG19LrNxrPAez5d/iFBPb7r+ri3skBX+++y69zkPgB20JZUIKqlQWIAvy3P1QINdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378208; c=relaxed/simple;
	bh=4+6x9ephW3MdfsJakiMmE30BS7jjEE4E4qPo+kI+Jus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFVT1F2910D0jr+8WxOOBy5harkTPlmXta32jG3mjZD8eRoBsWGBLvMNpOiCxFPs73KYjH224LfNX3TEvaMaIDaEjFRZbbeUPSAlMwrJfo9eOZz774YSXc83SD+yyP1vV/ikRUf1MylLaPEVwbrqKYnIocL612uCzBxbutedGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjhI6jCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EE2C4CEF1;
	Tue,  9 Sep 2025 00:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378208;
	bh=4+6x9ephW3MdfsJakiMmE30BS7jjEE4E4qPo+kI+Jus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjhI6jCE+LWS2pC7iaa3TifGubpRM3CL/HjkOkP7vEK4mC9CSePlaybuboQ4d1n90
	 rdediBtHYazVnZ1K3afyJW6yeeA9djjqpddgd9UrEGeVQdeU+AMwiWfaq9KdEmGNit
	 CY8/Nj3ay9rVdHQA7VD6V9SNa7uA9GiPZpqX3wMnisqhks+nekSUME4ky8EQTbhsmx
	 vatd1olpng3ZyDhPrU5yPowqcVqet8Uj38sF7dvXVJYkz7TqhT1tufHJCNj5A6qHE7
	 EWDZbcZJDi9mPDS6C8DHdwPsRSaLE9Fkwv4puA10tzET+eaFx0V91j3elDuBfb7P0q
	 j9DXJEtnIrTPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: Fix a regression in nfsd_setattr()
Date: Mon,  8 Sep 2025 20:36:43 -0400
Message-ID: <20250909003644.2495376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025040835-legroom-backshift-766c@gregkh>
References: <2025040835-legroom-backshift-766c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 6412e44c40aaf8f1d7320b2099c5bdd6cb9126ac ]

Commit bb4d53d66e4b ("NFSD: use (un)lock_inode instead of
fh_(un)lock for file operations") broke the NFSv3 pre/post op
attributes behaviour when doing a SETATTR rpc call by stripping out
the calls to fh_fill_pre_attrs() and fh_fill_post_attrs().

Fixes: bb4d53d66e4b ("NFSD: use (un)lock_inode instead of fh_(un)lock for file operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Message-ID: <20240216012451.22725-1-trondmy@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: d7d8e3169b56 ("NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 4 ++++
 fs/nfsd/vfs.c      | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b2bbf3d6d177e..cd78b7ecbd432 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1131,6 +1131,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	struct inode *inode;
 	__be32 status = nfs_ok;
+	bool save_no_wcc;
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
@@ -1156,8 +1157,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (status)
 		goto out;
+	save_no_wcc = cstate->current_fh.fh_no_wcc;
+	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
 				0, (time64_t)0);
+	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b3e51d88faff4..58580eb6cf929 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -480,7 +480,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
@@ -538,6 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
+	err = fh_fill_pre_attrs(fhp);
+	if (err)
+		goto out_unlock;
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -565,13 +568,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	return nfserrno(host_err);
+	return err != 0 ? err : nfserrno(host_err);
 }
 
 #if defined(CONFIG_NFSD_V4)
-- 
2.51.0


