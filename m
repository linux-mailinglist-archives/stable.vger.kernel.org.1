Return-Path: <stable+bounces-140172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A08AAA5CF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F2D1893136
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC628CF7E;
	Mon,  5 May 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBgE6vRu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413EC3184DA;
	Mon,  5 May 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484270; cv=none; b=WCVY9B52ns+/2bDLjN3k3PkXzKvhUHwDRh8mmnRIOO7d/QJm1reC/y++txl4awO938HK/QEIlLvr3qub/W4KvQvhi3bRbSauUybOtfr6mMK1zJCzbzQN6n8u7VZhg9JYdH8Waina1ZW9iQ906JLN5DpNfUcXpQUjwPOiV5b8370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484270; c=relaxed/simple;
	bh=pwIrPYe2moK7L7uJ3vTZLVwNuFiG5U0eZA331dBMFMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTI6UfRUhmk4k+jG1IymF7ZcjHJ6QotSSj6d6h5UryjazI+OI/EpKfbOGaKKQ6j/LtQuoXdub7H5JUfbRI2W7GsolqLk5hoTvOl+aZJrVRr9s7AhcquERAb/j8R3g2rLRRhVTUL5jxfhI2qjel1zcKkUljjuR4qjN6ub9700J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBgE6vRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D4BC4CEE4;
	Mon,  5 May 2025 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484270;
	bh=pwIrPYe2moK7L7uJ3vTZLVwNuFiG5U0eZA331dBMFMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBgE6vRu4q6szLzYtbwQ5Qj8oFa5q9mxZOo0RhPhk2/rK8PfJNq+hMUcRUuwP9R1A
	 vAoLylUjAMJ0OkEQ8LGP2zzEzGC9uk/cg4WVCr9oJRDcjNILBQtPH+SImA732CwhL9
	 P5sl1XX3MdshbQR8fhDsnbWO5dJySx5M/ktojnoHJeIem5mHF/Y84q7KjN0kkOztNg
	 frHMwqyAMPlBF3V7okNJSQN5OQaIyaJMe+BXJMT71xIsRYkbOc705uEdD1r3H34Cro
	 ZE4jDxc2SVX1RLxY3nLYEbUM+Bh3GCR86GIbFBFKUaTLqUpjpUhHj49j1eAoAtO2VJ
	 DriSD7lmzUtqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 425/642] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Mon,  5 May 2025 18:10:41 -0400
Message-Id: <20250505221419.2672473-425-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 5b2fabf7fe8f745ff214ff003e6067b64f172271 ]

kernfs_node_dentry() passes kernfs_node::name to
lookup_positive_unlocked().

Acquire kernfs_root::kernfs_rwsem to ensure the node is not renamed
during the operation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-4-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/mount.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..0f6379ae258d1 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -207,6 +207,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 {
 	struct dentry *dentry;
 	struct kernfs_node *knparent;
+	struct kernfs_root *root;
 
 	BUG_ON(sb->s_op != &kernfs_sops);
 
@@ -216,6 +217,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	if (!kn->parent)
 		return dentry;
 
+	root = kernfs_root(kn);
+	guard(rwsem_read)(&root->kernfs_rwsem);
+
 	knparent = find_next_ancestor(kn, NULL);
 	if (WARN_ON(!knparent)) {
 		dput(dentry);
-- 
2.39.5


