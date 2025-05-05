Return-Path: <stable+bounces-141412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE64AAB6F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AEA1C211A8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F9228C99;
	Tue,  6 May 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxG+Sb5X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77E281379;
	Mon,  5 May 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486211; cv=none; b=OCg7vKiCJtr2WqjpUxrY7bh0vm9jVz1F4AyPJ71vB6me9zBMHxKpFF4G3tNVZEwA2nEGD0G8eXoJVrKJ/jKrV5ZByvWgEx9SN3Woa33VJBrqygRZqmRiwiZ/8In5wxKnEwv99lBxtqqdYByyx7fzCYXUJdwz7EUwrJUGrUHBw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486211; c=relaxed/simple;
	bh=izhou5qxPFbb1SvbzdJaU6K5rcctrghYjKIyrQ0y4Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVEbOOHcVzyNKHpoXLxTBRaIhqedbAVfPcsn2CxE92l9QmKAvthOgmr4cCHmukq5ffFnney+ssYHgWRbM/pTC9mwHRl5GXXAWqHqubrBz0ZVyNulJvP+itj7WNjOuxeM7aJLK5/vqqKJYvlFkTvEkxoIsu7ZXHJ/+U47jwofaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxG+Sb5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4ACC4CEED;
	Mon,  5 May 2025 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486211;
	bh=izhou5qxPFbb1SvbzdJaU6K5rcctrghYjKIyrQ0y4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxG+Sb5XUtuCANQHVylDkQbkyih59j0Fv9CyZC+xa3z9eNgbHJdEY0DH2asa+oxUp
	 jnwtH+x/KyxtUCFV0Hp7yVrUVoiKiIf9sPRQBnbPz9eVZMzn8JETqpNc46Dydvgh9T
	 GNkN22facXTQw9WIwSiRqJ/fGLm1lidTnLZISl2xzUYMlZhgzJUuA8WJ7BXORfzKNp
	 A4ZMfOJkx2ZZclnTrZWRi6u/71dHO8uTmesGBT05MlWI7EccH4cMU3phf8kLPkWP4X
	 4mW+2O8B80f4PFmRSJWkBuPfKctm92P/A0pHXyh7lcElx9t+jkqJ8YULBtnOY53U8i
	 OwyyzeNGcOMeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 209/294] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Mon,  5 May 2025 18:55:09 -0400
Message-Id: <20250505225634.2688578-209-sashal@kernel.org>
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

[ Upstream commit 122ab92dee80582c39740609a627198dd5b6b595 ]

kernfs_get_parent_dentry() passes kernfs_node::parent to
kernfs_get_inode().

Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
replaced during the operation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-3-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c4bf26142eec9..5fda25dbbd256 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -147,7 +147,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
+	struct kernfs_root *root = kernfs_root(kn);
 
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
 
-- 
2.39.5


