Return-Path: <stable+bounces-171735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB9B2B73E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F490622149
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76201494A8;
	Tue, 19 Aug 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gry9S5uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB22F852
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571606; cv=none; b=tVC/hhrOaGWGFlBvc/qcxD3Drwx74B2zlbs3GHAOeRxkUUvbsp6j+XN3kxLRsDMDngBsUfAwxXUnJtPUZBzJ3hTZPDyUvNSC3UyiFFYmVGbq4kCR+u+IBbEvL43Ks9LsG4k8KxrtF2kl3wesyZYx4X98ZXzZfHrphexMj47EMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571606; c=relaxed/simple;
	bh=z6Gl5Gkrr9oWFjWLgjz5nfY+2+t05p8WuZ4aps/hd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lopCnjvxWozhRTkdIK2bJ4sRBG4brbMQ7ePEE1cOfqefbdMZ5wikA7MJW+rp6Ije5LbtyZpHhnp8x8IaM71HOoFv2SnQxeLZPogjtVvzOwCIRd4WHjEe7rLR30ufqMoeL5OuLs0qkHTzbncfAC4qAo91VV+lDx++itpGBizXoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gry9S5uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841ABC116B1;
	Tue, 19 Aug 2025 02:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571606;
	bh=z6Gl5Gkrr9oWFjWLgjz5nfY+2+t05p8WuZ4aps/hd80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gry9S5uzIDLSt6Osg55EGwlnS/Ypm2ONJZZnyLC9SI4fdw4bTTOG4SyCh5tPyU17K
	 9hJsae/nAWhAwOdD6bQfHXGN0sTsNz7HwlUZLEJYuCG9c5PVdvgK4gc6r74Eqxbv98
	 w2yYmp+WiaS82xSsdZF7KFvaobELWdnHPlmKE98aFe9fHCsmvhDFbdYh4YEoSgl16Z
	 6N3oYfWiFe3zjir2G8L1RMbPpqsfapRqpd0Xs6DKU/xUjDLLzs8WD/l0XKZK1TB6nv
	 kmqwLJL/77nE2Gz7qZrk2aqekqZKKGzoE6MiRXbJ/RUqpu2sJQi5G8nrMfbZ7qBlFY
	 t/8mcub9dEs3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	cen zhang <zzzccc427@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags
Date: Mon, 18 Aug 2025 22:46:42 -0400
Message-ID: <20250819024642.295522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081858-issuing-conclude-4ff3@gregkh>
References: <2025081858-issuing-conclude-4ff3@gregkh>
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
index c0757ab99495..dc395cd2f33b 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -430,11 +430,15 @@ xfs_inumbers(
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
@@ -443,7 +447,7 @@ xfs_inumbers(
 	if (error)
 		goto out;
 
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 out:
-- 
2.50.1


