Return-Path: <stable+bounces-114292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC1A2CC8A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6232A3AAD07
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB1A3141;
	Fri,  7 Feb 2025 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLEMdw8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38A19D072;
	Fri,  7 Feb 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956410; cv=none; b=eb8JR6FRFvJSzHB9y1QX+mq4SQ7YVt+HRMwqC9s6cPcAk6dgaNWVno+vP9K1bUZgGKVNDZZl3cLUUpu9b9AMms1QGOIePNqMDks4EzPlUx3wbMmTMMHW0MV3pXFwm/1DPQJvMPipM+rRVqGST6C8rTl1cJIcwbDEwG7wLhoZbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956410; c=relaxed/simple;
	bh=Oj4GfZBW4oDzY5Nxy5immunZV/OO6PBiunXKTZOu6ms=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PM6Gm6zIZKxALL7kNK0CHCGJhWxMI5DLNQswnh6Uwgy/VySumKTeHEw+YvMNIqTUjAcTkC/dU3vSNbFJrbSo5eTUKPLQsxs4GJc4lvYe6eWvkyJIntU8dpGS+0vh8+tL92r8ty+7hbkhgeIKxAzh0MEtxLgIn+u3tSz9DzgINKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLEMdw8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A72FC4CED1;
	Fri,  7 Feb 2025 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956409;
	bh=Oj4GfZBW4oDzY5Nxy5immunZV/OO6PBiunXKTZOu6ms=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aLEMdw8cbYXrkZTGd8bOmFZuzIPyNDJpelttM5KxAZ/IZFkJJwFMX0fJ+3cp5naY0
	 x2y0t9FA3v3W8izC7qOlzCxhiaHnxsLOPU7yJ1xr5cP6lXsfUk12csHAkwaeWNShUl
	 J/g5sOvijGCiNigQc+C44Cnx0YbOrd7xjmcXSjaAxFchvXdGB41Qr6Mbo6Uq02eYnj
	 qSM3z0tnaROXZwSp5Haza+B/pf3EYcWp5nEhQG4sANxBLnhmxPplEr8tO5zh6LqWzp
	 s4LfGhGnRgG3c2KY5kvBs6GFNszetWoP6AIpjzAm9itbqkBO0wHCz/3r6gr/ghOXXU
	 //HAF/ci8uwqA==
Date: Fri, 07 Feb 2025 11:26:48 -0800
Subject: [PATCH 02/11] xfs: don't lose solo superblock counter update
 transactions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, stable@vger.kernel.org
Message-ID: <173895601435.3373740.16661001569520012189.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

commit c817aabd3b08e8770d89a9a29ae80fead561a1a1 upstream

Superblock counter updates are tracked via per-transaction counters in
the xfs_trans object.  These changes are then turned into dirty log
items in xfs_trans_apply_sb_deltas just prior to commiting the log items
to the CIL.

However, updating the per-transaction counter deltas do not cause
XFS_TRANS_DIRTY to be set on the transaction.  In other words, a pure sb
counter update will be silently discarded if there are no other dirty
log items attached to the transaction.

This is currently not the case anywhere in the filesystem because sb
counter updates always dirty at least one other metadata item, but let's
not leave a logic bomb.

Cc: <stable@vger.kernel.org> # v2.6.35
Fixes: 0924378a689ccb ("xfs: split out iclog writing from xfs_trans_commit()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_trans.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 001d9bec4ed571..ee46051db12dde 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -834,6 +834,13 @@ __xfs_trans_commit(
 
 	trace_xfs_trans_commit(tp, _RET_IP_);
 
+	/*
+	 * Commit per-transaction changes that are not already tracked through
+	 * log items.  This can add dirty log items to the transaction.
+	 */
+	if (tp->t_flags & XFS_TRANS_SB_DIRTY)
+		xfs_trans_apply_sb_deltas(tp);
+
 	error = xfs_trans_run_precommits(tp);
 	if (error)
 		goto out_unreserve;
@@ -864,8 +871,6 @@ __xfs_trans_commit(
 	/*
 	 * If we need to update the superblock, then do it now.
 	 */
-	if (tp->t_flags & XFS_TRANS_SB_DIRTY)
-		xfs_trans_apply_sb_deltas(tp);
 	xfs_trans_apply_dquot_deltas(tp);
 
 	xlog_cil_commit(log, tp, &commit_seq, regrant);


