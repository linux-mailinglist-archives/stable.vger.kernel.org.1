Return-Path: <stable+bounces-140870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0ABAAAC46
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E474C98430B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F52882A3;
	Mon,  5 May 2025 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXsFmyc/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91352F10DC;
	Mon,  5 May 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486707; cv=none; b=QbBCU8aKm/ZBQ1EhydMV+o57EcaBLZ3sLi8jd2R/xJELo1Rpjz6ZNFOjka/ugpsvQqfCB4LQqrm7IexJTewhySRU59e+Pr6P+wbuuktMgtVaLOUZJ1WHoEXE6RrLVYDn+AfDPH/bIaYbCUCt+HHfP2Ojzk3PRm9WHUr/WOLgbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486707; c=relaxed/simple;
	bh=Zqp/bwpMcAv5iVBBpb5LTPQPE4uZFS6xV8tEQzyMIfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=so9f1MyUn9SUj82xh4FAydfx8N0CKpKgM0WTJXJih8uf1qWdedJu7aSbJbTbUvIbZvy6WYoh4yVkrQQzVlCjErWhCq5QBfTZfJ7Sy65QmkU13HhH5SzfhIrxE0wBvkXv/Ba2MqZk1SrFU9c2nTbVsvJ6wdAP8JdHzZqx7BFovdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXsFmyc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C6EC4CEEE;
	Mon,  5 May 2025 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486707;
	bh=Zqp/bwpMcAv5iVBBpb5LTPQPE4uZFS6xV8tEQzyMIfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXsFmyc/bTm5CVpB2hId8K6KkHnIjVxBZGrlfM2ekO274+nGZdx0Qu/NeJ1lIvVV/
	 EA9r62dYvh65hbhK5i3FFqmUcpEsM90wn4js4vKbaV17TD706DcH+lyP+PXFdwbs+d
	 KNpwffZsQojLHBxZYc16Q7jsgWDpmGjkLXc5tJ8OVcRcDARy1a9xjn8JByEyLoWjdT
	 bmJfE6zOiQANxaoTKkX3CMQTvstiXeFD4iO+z11ycqSzYXxLmudVyKJFZT3NaHHobr
	 EUVdqN4Xu1xEtOCEPlcZhDBqAm9aKnyUyBnwXKY/SIwyZz4cMGyKh0OBVS0Q3qH6BX
	 q/UGO/VjaJeyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 164/212] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Mon,  5 May 2025 19:05:36 -0400
Message-Id: <20250505230624.2692522-164-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index e08e8d9998070..0c98621a17a80 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -138,7 +138,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
+	struct kernfs_root *root = kernfs_root(kn);
 
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
 
-- 
2.39.5


