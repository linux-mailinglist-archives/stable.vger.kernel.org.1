Return-Path: <stable+bounces-171711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B29B2B654
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28701B27A26
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7D1EFF9A;
	Tue, 19 Aug 2025 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhPxr8yz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74841798F
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567280; cv=none; b=XrURrdjw4Keu0fpyvcxWc1JlQcWMPplZ3p7hbbU7hxnO1SdI1XwayZEmcLSkaJNVE+w+R5hSoVHQEWvMuodMe3xsSRsD7HVapP7wrkGGfP6sZ+D6dvTJ0H++jVvrVBd3QkNo4NXKrSX7mMr7iqEGYB63LdWT3N4DqmDfXBmb7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567280; c=relaxed/simple;
	bh=fQ7ysY7v5OUl16m4Z9WUCKroknn21MZ9YDWEeSEnhRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm+1vEpl4bAGVYr8Yzl2sDhSWZL+YsMa5Qs2eyYua22w3Hod0wZusip2XO1IoKiYZaJfCTK7VJUKDjfSiFbSfKSoC3ULftgEa8nVPsIcnuP5oWqpbbcvNvyFNf3D9MWsj+9uwRWIoTPorcTlQIgAvV4kV+3nMy+aAFXJQlqxYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhPxr8yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C4C116B1;
	Tue, 19 Aug 2025 01:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567280;
	bh=fQ7ysY7v5OUl16m4Z9WUCKroknn21MZ9YDWEeSEnhRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhPxr8yzuM9ru6LIzkAIS1QGY59yf3X6j5RFfoiu9N99XX5kgbarlCgZOfMjswzpt
	 QPQ9l5/iBLZ+UNoIHMHK83zZfkvQHpbbNbnKVS5HI+VqXc1o/Mt7tSvessk4zmN+Q0
	 YdrhzmzdJYEsAKFSPI4U+4V/LjN4NIiklVhWCIEASTgnk7O3ILPgnar1I3JzeI5s/r
	 GNk/1I+Wjsmiq4OIzjB+MESctNjuRDUdG2Q1JTwp6BtXkbzBtASh9VHs/KjyVwPyLg
	 cGkDSh2gH/d/Jfq8PPSObYCrPG+KbA6A0213z3TYzX40KUk/BzXrr8FdovpYGoW5y7
	 kbzYSmPF7JPRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	cen zhang <zzzccc427@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 4/5] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags
Date: Mon, 18 Aug 2025 21:34:33 -0400
Message-ID: <20250819013434.249383-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819013434.249383-1-sashal@kernel.org>
References: <2025081857-glitter-hummus-4836@gregkh>
 <20250819013434.249383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d2845519b0723c5d5a0266cbf410495f9b8fd65c ]

Fix up xfs_inumbers to now pass in the XFS_IBULK* flags into the flags
argument to xfs_inobt_walk, which expects the XFS_IWALK* flags.

Currently passing the wrong flags works for non-debug builds because
the only XFS_IWALK* flag has the same encoding as the corresponding
XFS_IBULK* flag, but in debug builds it can trigger an assert that no
incorrect flag is passed.  Instead just extra the relevant flag.

Fixes: 5b35d922c52798 ("xfs: Decouple XFS_IBULK flags from XFS_IWALK flags")
Cc: <stable@vger.kernel.org> # v5.19
Reported-by: cen zhang <zzzccc427@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_itable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index c8c9b8d8309f..5116842420b2 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -447,17 +447,21 @@ xfs_inumbers(
 		.breq		= breq,
 	};
 	struct xfs_trans	*tp;
+	unsigned int		iwalk_flags = 0;
 	int			error = 0;
 
 	if (xfs_bulkstat_already_done(breq->mp, breq->startino))
 		return 0;
 
+	if (breq->flags & XFS_IBULK_SAME_AG)
+		iwalk_flags |= XFS_IWALK_SAME_AG;
+
 	/*
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
 	tp = xfs_trans_alloc_empty(breq->mp);
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 
-- 
2.50.1


