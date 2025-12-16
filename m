Return-Path: <stable+bounces-201492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA1CC2659
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4EA30A7A17
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE155342C8F;
	Tue, 16 Dec 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CxtdUXbH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865E341648;
	Tue, 16 Dec 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884815; cv=none; b=YZpDMvCXM3ZFGu8mCyAkcklp6xn/h0FBSsIyKnPqTLwkgoKLXq3/u6U7s6KolgNySVZ0p7JBUUAUPslK3++SlTiseKfY7IORXidTfoSmwX1gDDHM1AETfES7laxKJjemEV6lahGmoLsTPcBeuMqNwfOlK2gOZg8IPLrIZq5OhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884815; c=relaxed/simple;
	bh=pCoxKBFY1ccyDQwbi/XcGuxrx/xB8ogtEARbPUdn1dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/X7OFS/74HAyk8WL7YEcXlCUs2H5WMnQ3phZFeEYursi5JDm0uJ1CWdOyH/6ygFT98ry6oUeYcKJQMz8wQb3///Pcvk+m56M96Q1dZIzk4T/jfQiSSVhuh/6HKQdObBDiTpOuseFDIKs9DcrRh7qQkjGqRBsP5kBt3PZECoSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CxtdUXbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91F3C4CEF1;
	Tue, 16 Dec 2025 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884815;
	bh=pCoxKBFY1ccyDQwbi/XcGuxrx/xB8ogtEARbPUdn1dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxtdUXbHN2e0nKpUCZyUcL11C5wxZoTPUkmpQ8G/+fRA+rINMpZK1zO9eFy+9UkjZ
	 Wh8O8+qDJbZOqKxlNzUnXCOZK5gFijr/yVWR7jadx8wXRhARJSAzu74wmBhzmh+U45
	 HnEIFBaKkLOk+RSPKCHoPlUjFwVKx0KNnl4xUX7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Stoler <michael.stoler@vastdata.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 307/354] NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_state
Date: Tue, 16 Dec 2025 12:14:34 +0100
Message-ID: <20251216111332.034824571@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 0f900f11002ff52391fc2aa4a75e59f26ed1c242 ]

Ensure that the verifiers are initialised before calling
d_splice_alias() in _nfs4_open_and_get_state().

Reported-by: Michael Stoler <michael.stoler@vastdata.com>
Fixes: cf5b4059ba71 ("NFSv4: Fix races between open and dentry revalidation")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7fe71aaa18666..172ff213b50b6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3148,18 +3148,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
 		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
 
-	dentry = opendata->dentry;
-	if (d_really_is_negative(dentry)) {
-		struct dentry *alias;
-		d_drop(dentry);
-		alias = d_splice_alias(igrab(state->inode), dentry);
-		/* d_splice_alias() can't fail here - it's a non-directory */
-		if (alias) {
-			dput(ctx->dentry);
-			ctx->dentry = dentry = alias;
-		}
-	}
-
 	switch(opendata->o_arg.claim) {
 	default:
 		break;
@@ -3170,7 +3158,20 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 			break;
 		if (opendata->o_res.delegation.type != 0)
 			dir_verifier = nfs_save_change_attribute(dir);
-		nfs_set_verifier(dentry, dir_verifier);
+	}
+
+	dentry = opendata->dentry;
+	nfs_set_verifier(dentry, dir_verifier);
+	if (d_really_is_negative(dentry)) {
+		struct dentry *alias;
+		d_drop(dentry);
+		alias = d_splice_alias(igrab(state->inode), dentry);
+		/* d_splice_alias() can't fail here - it's a non-directory */
+		if (alias) {
+			dput(ctx->dentry);
+			nfs_set_verifier(alias, dir_verifier);
+			ctx->dentry = dentry = alias;
+		}
 	}
 
 	/* Parse layoutget results before we check for access */
-- 
2.51.0




