Return-Path: <stable+bounces-141197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84900AAB15C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424D64E44D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088B3D14AE;
	Tue,  6 May 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdDU+o2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292A2D190B;
	Mon,  5 May 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485480; cv=none; b=LnBg8FYWrujm/K6B7mMyypK/eGYskZVGrs5HUr58Ica9A66HghcFrUQcG4D6mGEs55Ckwq2j6AxgY1Vp1cVwNAdnWeCuK0gxt3MaMx+S8lMk+iRw9wfnN1JGA55YFMwhtahvbB+ZJQXTzX0w5OgdhrfPSi599SVqK/Vjn8QFs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485480; c=relaxed/simple;
	bh=pwIrPYe2moK7L7uJ3vTZLVwNuFiG5U0eZA331dBMFMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ba36sJJKFG7tROR/diLtkhYJHaRO5V6gk7XShJHCqXhi5FgvoLmqJMLQCRjzhuBWDhEd6yziDB5EeDuIB8mu2/gxI4mUEvZRZIovsMIoLf4u7L2tOPUoT2r0PVMYlroCNQLzVDlBbgjRm0cBN6ev++3dUW+frTmCCdJ8/uZSEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdDU+o2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE2C4CEED;
	Mon,  5 May 2025 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485479;
	bh=pwIrPYe2moK7L7uJ3vTZLVwNuFiG5U0eZA331dBMFMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdDU+o2+t/cNdTob4I+Xs9EdfZOZ7UqYBbHeujMf6/yccnGa3wXLrksGADsIrMnAU
	 zE8fx8j/apWheZMrpS/ZcMNVPuA8P7Ex/eFPK1+w+fYWjlHlfyUVXP3DOjXmr9jNm8
	 syJR1RU7XyT5Udg/I5VmOi3zd5RPkLB5PZEwSfekeXmG780/EIEY575wDxoI0SVgkE
	 VGzm314OZ6YaJT7cwpSR8gdpWLwmp/8wk9bW/2cl46+uoUAfLjcIRRUvL6jn7Q2fL6
	 Gr8kE93Ik2W4Su/9Oc+rZBNpTQtOYk2WpmQmXpCiuvcikVzuv01G3XGCbNfhCzkhFQ
	 J9DNYJ2jeoLBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 336/486] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Mon,  5 May 2025 18:36:52 -0400
Message-Id: <20250505223922.2682012-336-sashal@kernel.org>
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


