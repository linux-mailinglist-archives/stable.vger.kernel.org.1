Return-Path: <stable+bounces-141205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FC9AAB15B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26471BA4DBF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1813F0CC0;
	Tue,  6 May 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ5EYRzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BB2D1134;
	Mon,  5 May 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485479; cv=none; b=ufcEiZNFdrsGxsIbJQT2x844vpXMQX9st4NT7IoRyAXidpvvrNFqVYK/INvjodoXLnKRHFSFJ+w8/jGTCsVuLYcL5uV7p+sypOz7YWppOnHq4A14xdggBdCgeApE6C4UboCFr2WNcagldKkiGBanpFn+gN/m2zUEu2z1t5X8yVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485479; c=relaxed/simple;
	bh=/stf3tHvA8s7QEAMakhpG4T94tRsVcqgN7pTpnDXAzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oltbjuvh5Er/K9QYZ+uKjTjEnpW2t9pcOBoP82TpAZLutsLotmKfH1sAOG/ettWn9vj1yG8kZxo/xvLirLqyoN32BCapI9YNxT3VKKKyLD12/uzYvuTV4l9oxE/GrGLKY2Q9484sl9E+Vgj8ohWZBs+pvAYr/tzrv4/XyQfvaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ5EYRzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6850CC4CEEF;
	Mon,  5 May 2025 22:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485478;
	bh=/stf3tHvA8s7QEAMakhpG4T94tRsVcqgN7pTpnDXAzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJ5EYRzNU5SYMJwVPQPHjeosfiviRMCJ+Lky881dEVE/B1G9gLod8yuy32b9oDqIn
	 WKYn/i/HoAB8ln6DBhtMb+0HJSjxOQ2ugLSeOSZK5Vf3c6pO2o9eXUx5n3x/naw/9t
	 SI5Ehz642ddk5bPBu0VzIpJRAZ8HTnY/1DHtoSscke2/7vlmwQkQHZYj4o+dwn6rMm
	 Ic+BudIHLJAnQzZOCfwRqraObRiBd88WHWfgtRFVND6fnkSSGnVy+IbUeXTw1Ot/fJ
	 EyMvRgLmmpQNe02J5XV5AKvW3TI3ipBcvC7Pz/MYyStfajxG1QE9yi9zVXcZccx/vb
	 xYqjB5L6u2afA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 335/486] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Mon,  5 May 2025 18:36:51 -0400
Message-Id: <20250505223922.2682012-335-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 458519e416fe7..5a1fea414996e 100644
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


