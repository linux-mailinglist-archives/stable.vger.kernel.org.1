Return-Path: <stable+bounces-188263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99EBF3C95
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 23:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D43C3A9A43
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199F2ECD37;
	Mon, 20 Oct 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaiAjI7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC542C3745
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997017; cv=none; b=h5yj+GM4Jvc8uy68anXith3O1MD7vRau0RHu1xZvMG9TR/7l7EDfrlvbMbUfTEePrmh7anwHm84hLWCxp5RQBWw0oA1EdMVzGKzr0YkRCA2BQOQ3khNqSu8re5vY+H3Qx1Lm8tnB3ISfymcKlnxg5hxfu9bNlc0Lrq8XrGhN1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997017; c=relaxed/simple;
	bh=SkGFJsykX59h6O2bOvS6jgyvSc6Hz8TWacHvQLYYnVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0w2bP7CqpnZ6nL6bXtNxoFwsdzD45sbtqjYyXB7XAKkRzHd5VBvVU1cn56sn7HFGBKUbSqgxmPJHNUwODirrAnSWM0gjC0vbbkguhwB2zWa/6HMbcWMbUueKpZ2D9CVH+GdXRlcbRHg2ZRPb9Q93NG+ckMuZ9+mlRh2nUQl7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaiAjI7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6E2C4CEFB;
	Mon, 20 Oct 2025 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997016;
	bh=SkGFJsykX59h6O2bOvS6jgyvSc6Hz8TWacHvQLYYnVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaiAjI7zob/Uqh0B/r9tgSYxvlaacz/awU9D84bK1H5Xk5zq5SyGJAgBbbR0IM0Vq
	 516NNbfwxEwY/CmcWoWpKFvpwnVXTenmSWo053H2yoXtZopqkaJRcybCJQ8oN6K8nV
	 eazG75wvxUByLLrM8oHDa7M2yXc9W+0DCtAN4UlA5oTLwygIY/IoYdsCxoIo6yjOs+
	 vDLHKU5JfO7SMfixt9C6Kwg8Rh4qpDsM+/8n0qBUGsrxtHJDs0xSNmPX03VLOlI0o0
	 eYCEJO3VD9kBgURfrn2kl2X6hc3ot0dsLc8M47XRi2L+LQA4LNq4tyOcahjQH1MOSj
	 oPZGQMIu7Nlfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 17:50:14 -0400
Message-ID: <20251020215014.1927401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102007-unashamed-manmade-2cbd@gregkh>
References: <2025102007-unashamed-manmade-2cbd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4b47a8601b71ad98833b447d465592d847b4dc77 ]

Avoid a crash if a pNFS client should happen to send a LAYOUTCOMMIT
operation on a FlexFiles layout.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com/T/#t
Cc: Thomas Haynes <loghyr@hammerspace.com>
Cc: stable@vger.kernel.org
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ removed struct svc_rqst parameter from nfsd4_ff_proc_layoutcommit ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/flexfilelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff0..0bc52e6bec394 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
-- 
2.51.0


