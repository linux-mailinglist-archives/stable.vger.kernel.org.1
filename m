Return-Path: <stable+bounces-188275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDDBF4299
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036918A59FA
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3031F4262;
	Tue, 21 Oct 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gelAXab0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5991C695
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007340; cv=none; b=pVBLUZrWiEoWkOm03KVNf+Mej1K2OA2TbUPahcdMxYpuXx2QWzZYOQ3VxEMHzHMWSmUaJAX4pMgVsEaQ3ofNQ8tYnsUivn5XwGgOgMDSE5YNnL4CJYASp13DQ5iLj1yeORom7+FRGstNcilqUYiW2RevTjCJd8q6OlSUFA/Hl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007340; c=relaxed/simple;
	bh=n0/kHP720TsRHcl5iRhXAwARkF2sXYurSSPr5BWY53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmDO+5kXMW0z+3rvvVSDpJQy1LKJNuWqsdA9Dqvw4J7uJo3FzLdGEseMsEeFBaBFu+TwPEAn5pgbPVV0FEFV2B2cBvNnLpN6GhHN2xx7SLbQt4O7Mj0xBL3MiK8sGpFT8E0f9zsNmbW4lhiMfafqfYE0Hp9oQ5Kti9PX4Z7HbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gelAXab0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5CC4CEFB;
	Tue, 21 Oct 2025 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007339;
	bh=n0/kHP720TsRHcl5iRhXAwARkF2sXYurSSPr5BWY53M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gelAXab0jy1souX0mkv2enLVidl4xse5vx9zbqpXXcaDZ5qm/sWx5SK4k5z0Y3oJX
	 fHAf8hFFfLaEM6TSFqlVZuk4aY/9IEp6sVrrdh6OkKQ/SDTE3OkY97uG+YnMi3FAIk
	 7+Ns1F5C4Bs6/jhLgH5jQeYeulXt7fFAIsQo3aUZa63kDXEdB2Z/RbNWnvQlWUfBqx
	 NPkyB3etvjfmmJg97CNE2gQ0teZkJ6oux1Gt7GKxDI9T/LvI5jVOGFa8EzNp6xvPNL
	 aeNufMxhEgUA7YvycXjUv1y+YW4G2z1Vl31+YKaLwgpz72eUYBIJ/Ldgf5pRnXZMiV
	 vVXBkRmWIN3/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 20:42:17 -0400
Message-ID: <20251021004217.1956991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102040-always-thirty-b345@gregkh>
References: <2025102040-always-thirty-b345@gregkh>
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
index fabc21ed68cea..041466513641c 100644
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


