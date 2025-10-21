Return-Path: <stable+bounces-188278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BBBF4399
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 03:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718AF3AFC21
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487021D3F5;
	Tue, 21 Oct 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCt9L11s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C2632
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009059; cv=none; b=it8HuG3oHPcIVlDn3GgqP5LZOVQ7Q0h8UEP8yAJslUEklno69qMDRr13wrlUExGoVNBzO8xCOrh3Jv2qHXb+ZctUfTn/zyPGOC/fD1H88VdLlnjQCobnF+smHfKUnFPyUxkUpmpmFapa1FemBCL9f7vpBcZdcyZfVYHRJjrmYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009059; c=relaxed/simple;
	bh=5nzh3peKlYYTH9W3unqLoNwoGcxFVZFMWUS2MvDjOw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hleO/T3gCfjCb0dri4Tgv170j2ck++dQ2O4SCXuTtINVX3IU7lyKCbahGbAcNVXtc0P0Cg/1TKomRt6wQqATc00zy1XoQG6zj9WwP997GqWA45PcmuC2b7m4+zcrREyMMtdkRHTdXvKEl2Lwq8d9sUBpwg3np6cCJacDmygBTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCt9L11s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DDFC4CEFB;
	Tue, 21 Oct 2025 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009058;
	bh=5nzh3peKlYYTH9W3unqLoNwoGcxFVZFMWUS2MvDjOw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCt9L11siX70+f635qjktGaiEdHeJIRTy1Q1EexMqamVS0BWjwxE1nTSvM6vNqkta
	 nB6FU88z3bNuYL24Id+7to/9F6lh2ls/o9QrSYVJH+ABqn+ROerlmNfBAEWvVauiEs
	 UgJrHqpqligdN4RkRiqqq0PDI3dhIZGS7dvpp6Ohjl0FnHRpL2S+yqgbNHuCZ7qMaY
	 k1tG4c4wfpEd8+0vjMa5wOyre3xGrk86dADDx9hJ7V6u0LqDjexIhmZLvjMu2hJdqr
	 n6HIR9aB8qNRLu+hBOcekvamf6wnYn1l1zBNse4BqWmW7ALCF9L4V4QRcg0SEiKZD9
	 Ysenf8eQTKOYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 21:10:56 -0400
Message-ID: <20251021011056.1964892-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102009-buckskin-tweet-87b7@gregkh>
References: <2025102009-buckskin-tweet-87b7@gregkh>
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
index db7ef07ae50c9..c2e1a985412c0 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -124,6 +124,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
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
@@ -132,4 +139,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
-- 
2.51.0


