Return-Path: <stable+bounces-177003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBBB3FEDD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549C93BFC16
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E631302CAC;
	Tue,  2 Sep 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzP3Tewr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263A27A456
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813913; cv=none; b=RNOsNIFwHvSuwC4YkBdH160LIcvccPsb1Ul8z63LsoczvjTmWNChlqNcPnSW3waS59sncJzdiH8AehWx/a79qYpJWuLVg0ADKYxNapzYyM9/tQ54YxuBOdkF2GIjQ19s7h/UTkRGmcQl+EkYF3DNofPetTja3CSTxQzlWEML/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813913; c=relaxed/simple;
	bh=K5C4PGpx/LOMzvnzh3r4Qx2adU6alBsrvqQPUMcNiyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwxHgTIJEPiuodJFu/mwC1zLgqutUM5dD02JMZKMC5QHwZOG8YgulWv7NPjKVCkndwZkCi4t95nqfyi2H6j12QO6rH/EbekbXMEIFGGM1j5Ex5/yCyHxMLvLZnB8hIIJ6F/KB6I0VBp4OApKxNrYkVvMihk1BRZKJDkuO9SjrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzP3Tewr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D7BC4CEED;
	Tue,  2 Sep 2025 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813913;
	bh=K5C4PGpx/LOMzvnzh3r4Qx2adU6alBsrvqQPUMcNiyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzP3TewryGXOjBJ/foM6k2Kj1mT5lmUqO8UI0g85OeORACxK0CYhukH6OKrsqlPRz
	 iK0+uIJZUQgShnnn0Kh65Ye68BOevvqZX5Lp+57AAMOmBv+U3y19cw8J1l2g4p/g4g
	 AaxlgdHGoiR64ZSF9MwrnE4k/kspWIgU+zm1+rHZacdpQetBTlu7SrfSNHnZTObTOk
	 LT98BW1wfdIRW5zfBFpwXFfMV0omJg4VjKG+c39SZzFy8SiwyFF3EwDIhIYnFArOB/
	 fVRjRpiGc468B7a1l9vQGCCzB0p9TBehV5DxQbV6uqGDCFFqUWzB9cOe40247vl4wH
	 Fc+lz7EFEbjzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: do not propagate ENODATA disk errors into xattr code
Date: Tue,  2 Sep 2025 07:51:50 -0400
Message-ID: <20250902115150.1331801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025090105-strainer-glider-fdcd@gregkh>
References: <2025090105-strainer-glider-fdcd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit ae668cd567a6a7622bc813ee0bb61c42bed61ba7 ]

ENODATA (aka ENOATTR) has a very specific meaning in the xfs xattr code;
namely, that the requested attribute name could not be found.

However, a medium error from disk may also return ENODATA. At best,
this medium error may escape to userspace as "attribute not found"
when in fact it's an IO (disk) error.

At worst, we may oops in xfs_attr_leaf_get() when we do:

	error = xfs_attr_leaf_hasname(args, &bp);
	if (error == -ENOATTR)  {
		xfs_trans_brelse(args->trans, bp);
		return error;
	}

because an ENODATA/ENOATTR error from disk leaves us with a null bp,
and the xfs_trans_brelse will then null-deref it.

As discussed on the list, we really need to modify the lower level
IO functions to trap all disk errors and ensure that we don't let
unique errors like this leak up into higher xfs functions - many
like this should be remapped to EIO.

However, this patch directly addresses a reported bug in the xattr
code, and should be safe to backport to stable kernels. A larger-scope
patch to handle more unique errors at lower levels can follow later.

(Note, prior to 07120f1abdff we did not oops, but we did return the
wrong error code to userspace.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Fixes: 07120f1abdff ("xfs: Add xfs_has_attr and subroutines")
Cc: stable@vger.kernel.org # v5.9+
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Adjust context: removed metadata health tracking calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 7 +++++++
 fs/xfs/libxfs/xfs_da_btree.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 54de405cbab5a..4d369876487bd 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -418,6 +418,13 @@ xfs_attr_rmtval_get(
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
 					0, &bp, &xfs_attr3_rmt_buf_ops);
+			/*
+			 * ENODATA from disk implies a disk medium failure;
+			 * ENODATA for xattrs means attribute not found, so
+			 * disambiguate that here.
+			 */
+			if (error == -ENODATA)
+				error = -EIO;
 			if (error)
 				return error;
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 28bbfc31039c0..1efd45076ee2a 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2649,6 +2649,12 @@ xfs_da_read_buf(
 
 	error = xfs_trans_read_buf_map(mp, tp, mp->m_ddev_targp, mapp, nmap, 0,
 			&bp, ops);
+	/*
+	 * ENODATA from disk implies a disk medium failure; ENODATA for
+	 * xattrs means attribute not found, so disambiguate that here.
+	 */
+	if (error == -ENODATA && whichfork == XFS_ATTR_FORK)
+		error = -EIO;
 	if (error)
 		goto out_free;
 
-- 
2.50.1


