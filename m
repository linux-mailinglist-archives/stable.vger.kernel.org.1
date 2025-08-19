Return-Path: <stable+bounces-171705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCD6B2B5DB
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEBC1962DDF
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382A1DF75D;
	Tue, 19 Aug 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOB0sh/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BA1DF25C
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566407; cv=none; b=qp9LUMR7QOfCE1vq5iwKPREeXSer1MXYOsre8NdhsUjk29r2XBhuZNvPFnmkhHvj1d8dQ6SPtthLhn71wEF31qud/FwYFSpOs0L1CdK/DEsfDeSHKmnMPv5nmZb8AXE8ywfSwW3v7xPqeu0jERORk/zQkH2RsT6rJfEzAweapvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566407; c=relaxed/simple;
	bh=fQ7ysY7v5OUl16m4Z9WUCKroknn21MZ9YDWEeSEnhRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfMkRuZEfkMpWYVBualaNka98IDqEB2FD6TKYrFORqxOrTAaHA7SuHnJKKq3EUZMe5khu650DtG4WwsfmbsxtGUSD5hPO1aP2gv56TlGgMAI0Yyo15OhsI14emdOtGNkND3ycHetfPqbrDmPO/nKx4UtBzod8l2QHnxG75dq7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOB0sh/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B7C4CEEB;
	Tue, 19 Aug 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566405;
	bh=fQ7ysY7v5OUl16m4Z9WUCKroknn21MZ9YDWEeSEnhRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOB0sh/YsVdejTZAopTrFG2ggXWcbEykBC2qnpySotbMd7zzVuW0ZsfdLiKuB/UhN
	 OfmrD+T1QNuK1DPYS/Lvr4TkV1uhne0W5AuP5ur1KNUjJwTQ/O0L7x10Yb9cQVNvLA
	 3JeSaZlKFoo4NHmALHegThUPKzeZIbYiuvfeoCKadKuF8hXNUkrJTVFOrG/Os2WPgV
	 bsN5leJepTLRbo8f/TPUoVprDPNdeht15u8lpyAEGXgfutEctEA8pDN6GZTv0DTKhg
	 c6jOl6HiOBb2PjzJc05IhVnj3SVfhWKt+wWMFVXvcE7/Ez5QLv40OOwX8w5lRdAJRo
	 llegzdT0ygwPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	cen zhang <zzzccc427@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 4/5] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags
Date: Mon, 18 Aug 2025 21:19:58 -0400
Message-ID: <20250819011959.244870-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819011959.244870-1-sashal@kernel.org>
References: <2025081857-swerve-preschool-2c2c@gregkh>
 <20250819011959.244870-1-sashal@kernel.org>
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


