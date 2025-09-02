Return-Path: <stable+bounces-177008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A91B3FF7B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEE11B600C2
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC62FFDCF;
	Tue,  2 Sep 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR+UZkEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26422FE07A
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814587; cv=none; b=uwnestRSPQhRI0KCS1625pxTSX9ub7qpAxkBYT7OZJ8WhMVWidvZMl6RO1P0tdt7shECfJ1jJnNrWRpYYiUgkGge2AuE/KjYm8s/fQU/P1IchgKjUH6qua1KqZh297PZbwJCSMW0x/aslSFUDxnsoJZ0IbQvsg7Acd8WbFVqGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814587; c=relaxed/simple;
	bh=NPZL+i4WAY2SwfjdvqK18LwyROxpl7tGSxQpG5ZlYSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0UWYPumBYXvLD7bzeypQjqXdb+BnCYy0WaGfudDv10XmuR5jtgKbObXAYtOm5oCu2C+pke79cWI2ZTzK0Yo7mr8TtIXBILOdDwC23JkJYNmAwzzsdtUyN94dsD+IxkpXVxttS8WIQnuuFfIWLgxLjfGfdsM1kEEt8K9hNlLK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR+UZkEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E15C4CEED;
	Tue,  2 Sep 2025 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756814587;
	bh=NPZL+i4WAY2SwfjdvqK18LwyROxpl7tGSxQpG5ZlYSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR+UZkENVZD65BzzDYgANEZn0/CYeZbCRz16aeIXZjgiCANA7Gu0x8NaW53s6Oh+F
	 iQAczFXac1h6Hce7vd/gNgDLX2qKzzizXz6r1X84AfzlUKFE+5RbVkklfWQ8UjBUKn
	 n0c5gmAMwv5Z1iGCaJh1pp80CESYNVrhAf6HUd5etJ3+I9/FyrwjusmfAHhUl4K8fm
	 VoLPUU6oipiiLJMygJQORddBHCBIuiB0zE9esMGqQ5d+zuk7lNArjv4gsgJbPyGyvS
	 YHuS4D7LVI7BpT/VFY1vC/D5n7XZ94xpDA3IIbliO1KnaFZi3hL0873d1F9FVtoH4w
	 P4Q5ks5Q6Tycg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: do not propagate ENODATA disk errors into xattr code
Date: Tue,  2 Sep 2025 08:03:03 -0400
Message-ID: <20250902120303.1337984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025090111-poem-retold-4ac2@gregkh>
References: <2025090111-poem-retold-4ac2@gregkh>
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
index 12e3cca804b7e..3ec681fdc075b 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2648,6 +2648,12 @@ xfs_da_read_buf(
 
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


