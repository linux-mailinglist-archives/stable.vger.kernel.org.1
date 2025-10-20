Return-Path: <stable+bounces-188082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 551A2BF15F1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40BF14E558C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF72F83DE;
	Mon, 20 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgNjEUPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95744248883
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965020; cv=none; b=TnovrY/YeYafnRjqHQRiWS4N4ZUuo7BkX3sKiBIJu4ARJ1E2MkUL9kw0rd+Dx0T71CR49kXuZFDi981b74KqIvdD4jaIWJTUidbhNRjb247r95Zlkha7DfCoKGDlKQMDRs3/18UPtOURBicNaHkA3GnI0A3kt0QvwNX4i6Pgo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965020; c=relaxed/simple;
	bh=fan+qaBp9zF4WmLJIWhhZG/+c5RgkC6IAaojnPWjl0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKM3QKNFpV3MEWGt8aO+4hDnFowG7ktpt0qzR8cb/8BVItTlulTve7cAAroMzlReUXhnVOBooO9v31d4yygC5Iz5S7gI8iiZScPFRc/99Bz14tfIemtZ5qowk9TXeETvAe8DkMW15yBOuXE+BY7HtifRtXrxRYO8L63MFaPQSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgNjEUPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B283C113D0;
	Mon, 20 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965020;
	bh=fan+qaBp9zF4WmLJIWhhZG/+c5RgkC6IAaojnPWjl0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgNjEUPzTLgUObkPvqVhApnGKsGI2UsgDpNhASnLW76C5Tx9QyhqCZbDTSrNMwCwg
	 BD3USzxfBuOu2f6HUMIYoDWpSlQBlUDwRXke0ETJdCGLjY527+sWf69/MprbBU6tlJ
	 7eiRjjT1kr6KwWwHos61YBtGaunu117k45NpozIG2CeeR6aDd7Toiu9AXHMhlTEvzF
	 XqGAhHBs1AuMLl/YbtS19mhq5H2XYawNCrus/6EwUjAOmiadX8exp7tD2jSN0GohcW
	 cURcDEygKCOdSa4nZhhXeWB1VUfgxKYxkMq+uAWvi1Sm4NOi62fPiCKnmpL11+NARP
	 dGwai1TsLxXEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:56:55 -0400
Message-ID: <20251020125656.1761732-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125656.1761732-1-sashal@kernel.org>
References: <2025101659-wing-paltry-7e9d@gregkh>
 <20251020125656.1761732-1-sashal@kernel.org>
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
index 1da06a15b13f5..3353bc2e3d0ef 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2278,18 +2278,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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


