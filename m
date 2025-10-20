Return-Path: <stable+bounces-188157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A845DBF234E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46E9A34DA1E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE092750ED;
	Mon, 20 Oct 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1pl2gL6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09792225A38
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975395; cv=none; b=sZp4MgAMnC1NwTVfCdQ+zW5fwcOAWH0qXtz5d2u4ouenNHSU+/Kvt3lttGA6fmiE6z8knOHcomrUHCJB477FdNE7CAShHNXJr9HqX4AS6UjDa/f3BCx+MvlVTXl8x7CMhrbawbXqOvDZifdVgH02ojZGAxZrPgFgjeU5Xbed07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975395; c=relaxed/simple;
	bh=ZBdKLrR1jHr1ASHdxOLyzMbA/KYMvLa99NI2F2SWquw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTcll+W7T7uHIE3x6lwSc3kayOJgA6F+IwoUwOkcf3mfpoBCaagMVOYvRIggxHkPbpCAqVxGsSTdIV+eueiE549dfvWOUjSiX6rGqBfzhRzBQy3lvDjNF/FFzlcPiIyZUOaev0yJcisS20a3J1+yxgbMI1ZwY1KEUkBBmkqWiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1pl2gL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14752C4CEFE;
	Mon, 20 Oct 2025 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975394;
	bh=ZBdKLrR1jHr1ASHdxOLyzMbA/KYMvLa99NI2F2SWquw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1pl2gL6DvNf2C6zc9q7/Rf4Jxk3khz9sntqNiIXlMoReokhQVt/dTT0sVZ2+6tFF
	 dTqa4IQf8Xg9PBToktmZG0C3JA7J8OmV2B2OPuSpyOZ6B7jw9el/HtMmk7WGHd195F
	 DOurBPM8BeH8zgcaPusaunrOeHUu7q+ox4fU6AdNpK8Z9aKmVO+eH3WkBZG3FK4gcW
	 stTnNiBCNEdAfGXVgjomUqipp5Nns0yYlRNZsJSlCKwQVxrSCbecYYmXOgEBdiAVb2
	 w7fF73fp7yftHoxLE2e+bk/g/3c1Di0RdSlZHGgYeNXuAzr0WEkXlDEMXLqwl4EHx0
	 OihFaezAXPd4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: use deferred intent items for reaping crosslinked blocks
Date: Mon, 20 Oct 2025 11:49:51 -0400
Message-ID: <20251020154951.1825215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101603-parasitic-impatient-2d2b@gregkh>
References: <2025101603-parasitic-impatient-2d2b@gregkh>
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
[ adapted xfs_refcount_free_cow_extent() and xfs_rmap_free_extent() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/reap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 53697f3c5e1b0..8688edec58755 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -409,8 +409,6 @@ xreap_agextent_iter(
 	if (crosslinked) {
 		trace_xreap_dispose_unmap_extent(sc->sa.pag, agbno, *aglenp);
 
-		rs->force_roll = true;
-
 		if (rs->oinfo == &XFS_RMAP_OINFO_COW) {
 			/*
 			 * If we're unmapping CoW staging extents, remove the
@@ -418,11 +416,14 @@ xreap_agextent_iter(
 			 * rmap record as well.
 			 */
 			xfs_refcount_free_cow_extent(sc->tp, fsbno, *aglenp);
+			rs->force_roll = true;
 			return 0;
 		}
 
-		return xfs_rmap_free(sc->tp, sc->sa.agf_bp, sc->sa.pag, agbno,
-				*aglenp, rs->oinfo);
+		xfs_rmap_free_extent(sc->tp, sc->sa.pag->pag_agno, agbno,
+				*aglenp, rs->oinfo->oi_owner);
+		rs->deferred++;
+		return 0;
 	}
 
 	trace_xreap_dispose_free_extent(sc->sa.pag, agbno, *aglenp);
-- 
2.51.0


