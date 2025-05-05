Return-Path: <stable+bounces-140384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE8AAA80D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228F27AF0CC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727429A31F;
	Mon,  5 May 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk6wgEtI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC229A31B;
	Mon,  5 May 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484740; cv=none; b=d0VmjaGmSls46lvSB+u2iOtUx3ZpG4qrILV6vkZFWb+I7//lP/9hrHHRWijDMwSEU53dF2QCSvYGvLGir0wkXoCvOVtaOy0Mo5IC50bfIFh8fGy2aknwe8HNvQC/TRnqTRmopo56TtQpWka9MQF3PCGWFRMOQuYm2D50/STkJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484740; c=relaxed/simple;
	bh=YExE6Iao+V2mf3eZCniHu/FQ0aRpByYnf/YTVRJEPGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duypDmXXgt0jH1wUXED0MUmx5+YUwdaQNi2C7QDc/MmovVyCp0MNIpbBEdfas2T6RBA6NWUp0zrIh9jKMeDt8QB/GGLhfjrBZC+CYZRaWegHyp4O4l5FM5Gbw2Hm9VXmxvXNbyptIo69DczKJ2+3spBUnSEAEUpREza2UvKbED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk6wgEtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675AFC4CEE4;
	Mon,  5 May 2025 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484740;
	bh=YExE6Iao+V2mf3eZCniHu/FQ0aRpByYnf/YTVRJEPGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kk6wgEtIEwUxAVcuKKf7OF1Dtv15gjllHYyhxwgLFL3l9+7Gfg5Evu2Wu5aTxifMb
	 /sVQgL6pWc5t5z8fquZSCf60EoCmasxDs85PhLj89LZh8sGYXXMI5BHZpzO612vdDF
	 fsM/52CKe/vxsDDyRGQotL+59nIMzd9DtBoZbXDcZPOrRAoqMDlGNkKedhDQkvpvMr
	 HqRFZ4xGucmjjtUSLPdNRfydamy5uK0JMmNRt6ljCXwRwSVI0fglmA4mq9ulrA44qH
	 9EZevh/b/6b8MNY6ELGkNGTrz0vcIVDVWuo5E+cl0lNAsg3dKdRUP+M8sSGbiMbeI8
	 pMbBtuHNRskcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 635/642] kernfs: Drop kernfs_rwsem while invoking lookup_positive_unlocked().
Date: Mon,  5 May 2025 18:14:11 -0400
Message-Id: <20250505221419.2672473-635-sashal@kernel.org>
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

[ Upstream commit 6ef5b6fae304091593956be59065c0c8633ad9e8 ]

syzbot reported two warnings:
- kernfs_node::name was accessed outside of a RCU section so it created
  warning. The kernfs_rwsem was held so it was okay but it wasn't seen.

- While kernfs_rwsem was held invoked lookup_positive_unlocked()->
  kernfs_dop_revalidate() which acquired kernfs_rwsem.

kernfs_rwsem was both acquired as a read lock so it can be acquired
twice. However if a writer acquires the lock after the first reader then
neither the writer nor the second reader can obtain the lock so it
deadlocks.

The reason for the lock is to ensure that kernfs_node::name remain
stable during lookup_positive_unlocked()'s invocation. The function can
not be invoked within a RCU section because it may sleep.

Make a temporary copy of the kernfs_node::name under the lock so
GFP_KERNEL can be used and use this instead.

Reported-by: syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com
Fixes: 5b2fabf7fe8f ("kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20250218163938.xmvjlJ0K@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/mount.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d1f512b7bf867..f1cea282aae32 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -220,12 +220,19 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 		return dentry;
 
 	root = kernfs_root(kn);
-	guard(rwsem_read)(&root->kernfs_rwsem);
-
-	knparent = find_next_ancestor(kn, NULL);
-	if (WARN_ON(!knparent)) {
-		dput(dentry);
+	/*
+	 * As long as kn is valid, its parent can not vanish. This is cgroup's
+	 * kn so it not have its parent replaced. Therefore it is safe to use
+	 * the ancestor node outside of the RCU or locked section.
+	 */
+	if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_INVARIANT_PARENT)))
 		return ERR_PTR(-EINVAL);
+	scoped_guard(rcu) {
+		knparent = find_next_ancestor(kn, NULL);
+		if (WARN_ON(!knparent)) {
+			dput(dentry);
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	do {
@@ -235,14 +242,22 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 
 		if (kn == knparent)
 			return dentry;
-		kntmp = find_next_ancestor(kn, knparent);
-		if (WARN_ON(!kntmp)) {
+
+		scoped_guard(rwsem_read, &root->kernfs_rwsem) {
+			kntmp = find_next_ancestor(kn, knparent);
+			if (WARN_ON(!kntmp)) {
+				dput(dentry);
+				return ERR_PTR(-EINVAL);
+			}
+			name = kstrdup(kernfs_rcu_name(kntmp), GFP_KERNEL);
+		}
+		if (!name) {
 			dput(dentry);
-			return ERR_PTR(-EINVAL);
+			return ERR_PTR(-ENOMEM);
 		}
-		name = rcu_dereference(kntmp->name);
 		dtmp = lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
+		kfree(name);
 		if (IS_ERR(dtmp))
 			return dtmp;
 		knparent = kntmp;
-- 
2.39.5


