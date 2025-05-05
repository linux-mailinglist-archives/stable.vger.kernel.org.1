Return-Path: <stable+bounces-140778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2D7AAAB70
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D4188BC4F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B23ABCE1;
	Mon,  5 May 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxBlDsLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6923703B4;
	Mon,  5 May 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486210; cv=none; b=fbDeiaxt6T8bqtBFrx9ugkOPyAjPI1JKOAPCq5OD8j9umOZIi8KZaJxkr2DiIboLhHxuXBcVgBLh1q77fS82Vm5Phc+KOLbl6PYPSuVnmA/TyVp+PMdSDu/zfoQj6f5QZCy519n3R6+j4SSQkrMQJ5XhTW1nkoAX/Syb4qAPTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486210; c=relaxed/simple;
	bh=i0oL4w24qQt12YYISG+B4mmHcITlwFtaK/phJLsUicU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6l9kagHesk8IAYd9Y/8rMoKVPjad/63Won/4hvRJcPHBSu70uy8C6s9cVIK2BRxtSNcNqFEZ9tjSVp4JWwmroEbEimyigNEmNDopEmQx3Xu8w0Idh7NPOTuiXS45hO9cIqRT8l8WO5vD9ctMDWe4OXQco9CILgeuoTHLqcSLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxBlDsLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CC2C4CEE4;
	Mon,  5 May 2025 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486210;
	bh=i0oL4w24qQt12YYISG+B4mmHcITlwFtaK/phJLsUicU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxBlDsLKPQuSNZROyzps2KcsgIrCaKExUZ/0w9jQj+RaluVEDJM2C/fsje3bSBIBQ
	 3NJKSCnLGhPKh9fm9kpOt/sd+zn/IigUH1qhh4xiveHIq161fyA+QNwHKEmBx2KZ+n
	 JX1z3cR9ZDy5rgpwYZmbnaORFwU5XIc7c57kcoldhxT7NYUku5H5U3cm692t+3ZUJZ
	 agp0j3dJNRo1CN/7zjpn0RXjKl9P+UhnrWDUf8vt/W6eJnfvoWheFprMN9zLzqcey6
	 LtwxRS7yWjROVafZpXwUfRHxw15Z0mwp9IKMhuFEJ2Rwb/XsqgE/c5uPu23aoSC1SE
	 UvLc66MHqCPdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 208/294] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Mon,  5 May 2025 18:55:08 -0400
Message-Id: <20250505225634.2688578-208-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 9aab10a0249eab4ec77c6a5e4f66442610c12a09 ]

The readdir operation iterates over all entries and invokes dir_emit()
for every entry passing kernfs_node::name as argument.
Since the name argument can change, and become invalid, the
kernfs_root::kernfs_rwsem lock should not be dropped to prevent renames
during the operation.

The lock drop around dir_emit() has been initially introduced in commit
   1e5289c97bba2 ("sysfs: Cache the last sysfs_dirent to improve readdir scalability v2")

to avoid holding a global lock during a page fault. The lock drop is
wrong since the support of renames and not a big burden since the lock
is no longer global.

Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
userpace buffer.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-5-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b068ed32d7b32..60ea525dd205f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1868,10 +1868,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
-- 
2.39.5


