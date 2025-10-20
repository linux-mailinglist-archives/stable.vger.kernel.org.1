Return-Path: <stable+bounces-188073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF6BF15C4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C60C18A5D2A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75E30FC08;
	Mon, 20 Oct 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Q5xYQh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C92FD7C7
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964852; cv=none; b=fExFnBsuzyujtAFIjznCiCt/+rK7mJ2Q7Mr7D3CaWdCPpE/QPueW1TewPgsDYtdd3mI+X2gHDTpHrXxEJ7FsJ5+2oOkwDP4XTe+YyOub1lhfzij6EWYxtlJSZ3CrRq9vSeSwt2wybR7VZ3qtjI+RHL+NnQMGaB0wgT/HIu7EKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964852; c=relaxed/simple;
	bh=qG7Wqnqbia3l3X3uZuKi5Dxhx9i9GhV8kB9fu+a8gzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrakj3IlulohC5AI1SyRI+GytEFLOPKLfM71lfVTMlNV81IRq0JBX5rizh4N09e2hQiN5ftfT/eHROEMxP5lKppvBVlzRCiiKeKcd+0HgRGJVE2hZeZxASBCkymFWFXwxpD1ZA6P+fDOwPchz/dHSwCYrV0sRLLlQ0uzv5aVfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Q5xYQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404C5C4CEF9;
	Mon, 20 Oct 2025 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964851;
	bh=qG7Wqnqbia3l3X3uZuKi5Dxhx9i9GhV8kB9fu+a8gzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/Q5xYQhJq2Hdx5G0SE6TNr+Jx6slyCAd4oxGMHvXrlB7cwY9tvkMpMZejLlDzQiF
	 tlyEeMh4XGXCwB9bGkT4znoB4vTc7TvCf5fCtF2Xgc0jxSIikxSU35+5w6rFoYvxyi
	 JQkRa9yt7FSqe/DKpPN4aKrmDWdE//Er5guawEvLhxJzFDQvZX0WqETHGhfZmoeevA
	 sE0C/PrC7Et8ZMTMoBZ/AzWOUf53IXfI2dyfr4JPqFDWpeh9/nB+EsoFZntseU/hXU
	 B4vqTItqefGI8RwYHm/BbfGJ02JjlMqlDsVyFf6mlTlP0mS6Vy2KduAZQOlGo5G1Bi
	 /4hJ0QWh2Vmxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:54:06 -0400
Message-ID: <20251020125407.1760605-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125407.1760605-1-sashal@kernel.org>
References: <2025101657-sandpaper-shelter-26f2@gregkh>
 <20251020125407.1760605-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit 274365a51d88658fb51cca637ba579034e90a799 ]

Remove dprintk in nfsd4_layoutcommit. These are not needed
in day to day usage, and the information is also available
in Wireshark when capturing NFS traffic.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e9c1271b7ecc3..8f7a9a450046e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2325,18 +2325,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	inode = d_inode(current_fh->fh_dentry);
 
 	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
+	if (new_size <= seg->offset)
 		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
+	if (new_size > seg->offset + seg->length)
 		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
+	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
 		goto out;
-	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
-- 
2.51.0


