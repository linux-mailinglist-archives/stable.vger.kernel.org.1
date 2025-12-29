Return-Path: <stable+bounces-204025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2BCE77F5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A32C4301721A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B573328FE;
	Mon, 29 Dec 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+L8rx4X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12433321CF;
	Mon, 29 Dec 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025840; cv=none; b=b5UE6KQnjpcgX4SgZJu4drHtfXM1RgW2thkEyTfiB0GxmNJEpx8ohfT0hFlb+B3PFj0e0d8PCmvvJ0Wi44ULJpxZsnDQpM+SCkkKXb8Uu+J/7woFXzuesJ+kgrwNc0sNgz34vdSbzSiVjkvmd9PqAN86r8pNdRPOFLxQgOmeZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025840; c=relaxed/simple;
	bh=EUIt2i28v/TyZ6DmbiZEPmUCDU/EVBh7JOTAGCxaYXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzgBEAfIJZs5+U4J0EdDCoxHUxtBNYkg4eUIcX/U3KrZwVyQBaya5RQQTFTwwbuKLCV+68aJ8eVErheN6Nm5sFHJY+KFSIHrai1evI8x8KeZkNYgvFsRaEzOIAMVJXexrUPtrTy44rLzKNWxuQS3JssxZ7abpkboCb+9YysHwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+L8rx4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79413C4CEF7;
	Mon, 29 Dec 2025 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025839;
	bh=EUIt2i28v/TyZ6DmbiZEPmUCDU/EVBh7JOTAGCxaYXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+L8rx4XdWINUWb2qZq3drHrF/7DtFSy3h81xoQ7OzEuP/kXzqFpQlJj9ALPjJCJB
	 E5KIdF+lOlFtXVLuEvNF4kdfESXZqAivmNjmWJwvTMFbhlKFiWTIvk/26eiY7zQ882
	 kIUe4hq9rEPbjS1M7cFTif5RsGi190Abx0RzBFdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18 356/430] xfs: fix the zoned RT growfs check for zone alignment
Date: Mon, 29 Dec 2025 17:12:38 +0100
Message-ID: <20251229160737.428956606@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit dc68c0f601691010dd5ae53442f8523f41a53131 upstream.

The grofs code for zoned RT subvolums already tries to check for zone
alignment, but gets it wrong by using the old instead of the new mount
structure.

Fixes: 01b71e64bb87 ("xfs: support growfs on zoned file systems")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: stable@vger.kernel.org # v6.15
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_rtalloc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 6907e871fa15..e063f4f2f2e6 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1255,12 +1255,10 @@ xfs_growfs_check_rtgeom(
 	min_logfsbs = min_t(xfs_extlen_t, xfs_log_calc_minimum_size(nmp),
 			nmp->m_rsumblocks * 2);
 
-	kfree(nmp);
-
 	trace_xfs_growfs_check_rtgeom(mp, min_logfsbs);
 
 	if (min_logfsbs > mp->m_sb.sb_logblocks)
-		return -EINVAL;
+		goto out_inval;
 
 	if (xfs_has_zoned(mp)) {
 		uint32_t	gblocks = mp->m_groups[XG_TYPE_RTG].blocks;
@@ -1268,16 +1266,20 @@ xfs_growfs_check_rtgeom(
 
 		if (rextsize != 1)
 			return -EINVAL;
-		div_u64_rem(mp->m_sb.sb_rblocks, gblocks, &rem);
+		div_u64_rem(nmp->m_sb.sb_rblocks, gblocks, &rem);
 		if (rem) {
 			xfs_warn(mp,
 "new RT volume size (%lld) not aligned to RT group size (%d)",
-				mp->m_sb.sb_rblocks, gblocks);
-			return -EINVAL;
+				nmp->m_sb.sb_rblocks, gblocks);
+			goto out_inval;
 		}
 	}
 
+	kfree(nmp);
 	return 0;
+out_inval:
+	kfree(nmp);
+	return -EINVAL;
 }
 
 /*
-- 
2.52.0




