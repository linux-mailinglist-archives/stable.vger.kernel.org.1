Return-Path: <stable+bounces-188272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A851CBF4245
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFAC434F3A8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17654128819;
	Tue, 21 Oct 2025 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDCWzGQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A7EAC7
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006297; cv=none; b=XsnxqiJzkYbUribDfsUMZt3duGlac1wvs+G3eb/WO2BsbQqnuFF0335/n+JCEsAdYQuusOhL9e88DYGc1E13iwAg6LUd+DmNU8Ggafqm6V5JZSI7D03KySpLV9zETvtNwIfvUZ/YHV1H6WcODNFziA7v3ahcmAHimmDcHjDAVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006297; c=relaxed/simple;
	bh=SkGFJsykX59h6O2bOvS6jgyvSc6Hz8TWacHvQLYYnVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZZvm/Am5TDjshdsqRfLy/2VVM3R9MrZNqKXyBU5VEMVErRgl8xGLW+Tapg/prU+gsVpJjuyQ41MDof1RqFEvEgxV3DO8l/6TOK6Gn22MvFrXoiq4htgQproR0B4QWlUyFKDQfdV5qNzhXRgZcENZeLmtmWakauhgVug+5/vB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDCWzGQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2219C4CEFB;
	Tue, 21 Oct 2025 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006297;
	bh=SkGFJsykX59h6O2bOvS6jgyvSc6Hz8TWacHvQLYYnVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDCWzGQgowLJLNLvJvahBUluMlwiItK4LfE/8+Azds3N8K09RhlEUhfSe3ipZPNS3
	 8mBonoXIz/Mxtya4vZeEMQkLkTGvlCz2e6Rmd6Rcyv3/YEBDGbzIL0xKqOIPx52591
	 CT2siaewC3iON40k5lDZNsdsoOOPc6i+J3KSFMJ/HecBb1Hj/HNaGP7g22SdqyxioI
	 0waCjv41P6NCvUqaDSXxxYGWEgIJzpE8IMXqCD+fRh2Qtn9Kfyfp+L4EnLGhRt1CMy
	 MME00kPBJKUbzzvLGqJ9trxSLwMcc0NHnJlL4Ci/JtzLVQJd0aY0QRH0vbpxQI9xTL
	 txlg90XmbcGgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 20:24:54 -0400
Message-ID: <20251021002454.1948865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102006-approach-hesitancy-3614@gregkh>
References: <2025102006-approach-hesitancy-3614@gregkh>
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


