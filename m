Return-Path: <stable+bounces-188159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A25BF2378
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7031889ACA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523DA2673AA;
	Mon, 20 Oct 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrxopzK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC9220F5E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975482; cv=none; b=pN+fnX6dlN6HLARVca1wXrpCY2aQNMhzXQwofUvjx0MxUMqlJG+VG+Tznzma1KquEtZNFFKtA0fHNb+Eq2R179eVmDvzUKfl8O06+pF8s5BqN1gnZlYdXfC17pc+HHjtQckcFnJzla16UQEqXZp3K1UQz7elvOQXDd3hTGWuTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975482; c=relaxed/simple;
	bh=IWtc+1Q5MWbefDcUaz7c0cpPEvOQwXDfLxjoayqEzAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh3i/ENBiQeJmw/Sue+vJpzTFolOUcmfO/8XXr/pwshmUmjL8Wm1DtqwMK8FlaKl6qhd/6v/7mYg4NRLQKp7PAmX/oU0vGmefJKBqy5R2wjywAUjGIXhLsNmjrHgjifsnRySvtyJx2Ba3p9ZJPpf5PR1N4MNQs4ykmCMJXJuQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrxopzK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAD3C4CEF9;
	Mon, 20 Oct 2025 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975481;
	bh=IWtc+1Q5MWbefDcUaz7c0cpPEvOQwXDfLxjoayqEzAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrxopzK+YB+7zH5/VAMi5ntocOtpAGrokNVQ7RNsZsNK/WPdkewmf7iVD+3rvHEdY
	 D9pywvrRMHoc5/tQH6e6PX7E5lRUAz9d5fQDclBT1959GBvfw+qsaWDdPpYNTu5NEt
	 D2E8LZWd6YCwrcVCK7SKuZXzO1WgyQS0UkMXUvXtmX6KPWTx8FEE+CppYmmhRHUMpZ
	 yUquU2yUjT5BERK21z9U0H4iAH5e4KKkb5X/DGII/JBdbVlUxgr4yDoxF42XUOl4GD
	 Ijsk4s6i71HUH956nY46Mu1++yffLLOBPEeIzonxDRyzZVvrTiAZabrAQoaQsuvHrA
	 yUz5LJwzotVKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: use deferred intent items for reaping crosslinked blocks
Date: Mon, 20 Oct 2025 11:51:16 -0400
Message-ID: <20251020155116.1825625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101603-baggage-humming-330b@gregkh>
References: <2025101603-baggage-humming-330b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit cd32a0c0dcdf634f2e0e71f41c272e19dece6264 ]

When we're removing rmap records for crosslinked blocks, use deferred
intent items so that we can try to free/unmap as many of the old data
structure's blocks as we can in the same transaction as the commit.

Cc: <stable@vger.kernel.org> # v6.6
Fixes: 1c7ce115e52106 ("xfs: reap large AG metadata extents when possible")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[ adjusted xfs_rmap_free_extent() and xfs_refcount_free_cow_extent() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/reap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 822f5adf7f7cc..b968f7bc202cf 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -20,6 +20,7 @@
 #include "xfs_ialloc_btree.h"
 #include "xfs_rmap.h"
 #include "xfs_rmap_btree.h"
+#include "xfs_refcount.h"
 #include "xfs_refcount_btree.h"
 #include "xfs_extent_busy.h"
 #include "xfs_ag.h"
@@ -376,9 +377,21 @@ xreap_agextent_iter(
 	if (crosslinked) {
 		trace_xreap_dispose_unmap_extent(sc->sa.pag, agbno, *aglenp);
 
-		rs->force_roll = true;
-		return xfs_rmap_free(sc->tp, sc->sa.agf_bp, sc->sa.pag, agbno,
-				*aglenp, rs->oinfo);
+		if (rs->oinfo == &XFS_RMAP_OINFO_COW) {
+			/*
+			 * If we're unmapping CoW staging extents, remove the
+			 * records from the refcountbt, which will remove the
+			 * rmap record as well.
+			 */
+			xfs_refcount_free_cow_extent(sc->tp, fsbno, *aglenp);
+			rs->force_roll = true;
+			return 0;
+		}
+
+		xfs_rmap_free_extent(sc->tp, sc->sa.pag->pag_agno, agbno,
+				*aglenp, rs->oinfo->oi_owner);
+		rs->deferred++;
+		return 0;
 	}
 
 	trace_xreap_dispose_free_extent(sc->sa.pag, agbno, *aglenp);
-- 
2.51.0


