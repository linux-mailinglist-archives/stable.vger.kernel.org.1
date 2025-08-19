Return-Path: <stable+bounces-171737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8FB2B75B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E4565875
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698D2C032C;
	Tue, 19 Aug 2025 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCBzYgEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3613FEE
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572219; cv=none; b=Rx8dK6qP1Qp5fq5f7rZiFtsJgkjlWMo6KSljSgWw9Fochs3GuZrGgAoQRuIN1Tj5vB9KHLSAI+zgC+e0FYE+OR+BZDqhYhy6llRubaU9iwuNdWbDbhcRTANmm/gA0pfDfCtyI6tuPyZlzV/1EKZMiGrtnmAkloRaOknqaQH3p4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572219; c=relaxed/simple;
	bh=ws4BKjxFgf3fUOKjRnveSmOydQwL72dFBTc/ySufEhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRPUDJUrJpSQuU+720JihOAZqX3tkXo7eiL/hbUIDdUTS5x31nxHro49B4ax0PRy0yI8ngG5ji8qbJAZi7lFb+anRX1PMBgAAc/pchnC/X9hfY6QuMSMsd00MdDhou6tVgF8UauHX4Vyo0l3N1S1I53+ANwaOlZtEcqUsYCv2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCBzYgEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE1C4CEED;
	Tue, 19 Aug 2025 02:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755572218;
	bh=ws4BKjxFgf3fUOKjRnveSmOydQwL72dFBTc/ySufEhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCBzYgEaaj47s17Q0AVE1Yn7sQCs1WkEv0DhlLPlpC/+jGrFraVosdKUitpi57/B8
	 A/mkF4JufWIyXOx1jHEQFqMI3MLxPF59pDE4klJ1rBPY7/Rd7dK+PBQGVwJoKIxpp6
	 w8o4Y5ABRtvcfJef3wNC/eWOghPUlcYgN98OkBnMRXir7DBMthleU44F30V4qXmvBY
	 lvrXr0J4xV8xeLcHDMXybUu1jDM/ph2ujlfsGDr0mARETuVOsRMsCJlAEkFUvrAyUZ
	 akeCZRNnbCOcjK34KxTGNc9bmnn+l36mTYMZ2aj+t8fKpm9HeZedJ1IGAC/lq3l7lF
	 f/a6slfqo8BSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	cen zhang <zzzccc427@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags
Date: Mon, 18 Aug 2025 22:56:55 -0400
Message-ID: <20250819025655.301046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081859-buckskin-outwit-e0f0@gregkh>
References: <2025081859-buckskin-outwit-e0f0@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_itable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index f5377ba5967a..68af6ae3b5d5 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -422,11 +422,15 @@ xfs_inumbers(
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
@@ -435,7 +439,7 @@ xfs_inumbers(
 	if (error)
 		goto out;
 
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 out:
-- 
2.50.1


