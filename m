Return-Path: <stable+bounces-169875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68523B29127
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83DF1964631
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1F1D61BB;
	Sun, 17 Aug 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGSN9SBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C715E96
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755397696; cv=none; b=A2exfH1G8gBvz2b3Yf3GRnmpsjxKJLPPd28doQnkqCaMqIVTiSDLdVmSDn3cUTpWimgUO/X/ZYuuuGdRtOlN09+rr9w/gP4YDhoa7o11SW+l2i0WFn5j6hduE6Fc9qxHSTUPW8DDkpH5liKqpU5UuFUI2I9dujoDR+mGB3vAxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755397696; c=relaxed/simple;
	bh=YFA11S0pguit9DsquA+Hx4Q8cKh+waPfedqQmc/WsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWE5SaRUdpZABBiK7P/tA8uTJ69xn2txfNBOyp5TznkWqgCEsrMCRRhMhy7EhqARpwYaUBxs3ap0k/mI21NIhyF7N4Joxr8h97/P1jeyPOymL7DvNoKVgoIrFC84+Gu0828mtveZy5Ml+UOYWKar9GO+vXzr9CDDHgPVgnnd4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGSN9SBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8DC4CEF6;
	Sun, 17 Aug 2025 02:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755397695;
	bh=YFA11S0pguit9DsquA+Hx4Q8cKh+waPfedqQmc/WsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGSN9SBarZDthJLR8qEl0g8dLmndliNgkqoLkjvKXN70cSWw+jepKjJUA2L4FfszO
	 Ys+2zfu8UnkrW5/fZuRH2QKLN4C9aruj38p9wbwQaQCTxqhr3faoT63VZf6DmlF+HM
	 sDMW7+q2v/kQ4LG69e+oJpULgXAf18PDwTrZTww0dYdu+E6sBIXVC6k4aMlfUfl0Xo
	 7e/D6O7qQ3sypC06x/EjbipGhgkLWdbu5ssng02b4LxXytLYRcxfmt3Ro3iGlWGKES
	 YODRxcomVF6ZqNiBb3xmfDTtl4HsOlnmDIutFZsEcU6m0dwrS4XcyOpZGFJQwX9zRv
	 f4XajUrJGQyaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/3] NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
Date: Sat, 16 Aug 2025 22:28:11 -0400
Message-ID: <20250817022812.1338100-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250817022812.1338100-1-sashal@kernel.org>
References: <2025081556-illusive-crawlers-8c0e@gregkh>
 <20250817022812.1338100-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 709fa5769914b377af87962bbe4ff81ffb019b2d ]

If there is an outstanding layoutcommit, then the list of attributes
whose values are expected to change is not the full set. So let's
be explicit about the full list.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0dc53732b5c9..4f0d2fc810e4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1869,7 +1869,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfs_wcc_update_inode(inode, fattr);
 
 	if (pnfs_layoutcommit_outstanding(inode)) {
-		nfsi->cache_validity |= save_cache_validity & NFS_INO_INVALID_ATTR;
+		nfsi->cache_validity |=
+			save_cache_validity &
+			(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+			 NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
 
-- 
2.50.1


