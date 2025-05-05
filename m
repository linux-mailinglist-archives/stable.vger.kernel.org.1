Return-Path: <stable+bounces-140173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D0AAA5C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0904620F4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4B318A11;
	Mon,  5 May 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqO9GqBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF3318A06;
	Mon,  5 May 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484271; cv=none; b=LdNYOQ9qNkslRMwWs3QEa9tJSyVKs9/ie2JRfDjJcGBdO8tVbVK+fCDE7c90u1O3+3aGjDl32eHiGsQHdwYxsy9TiCH0QOn4hm5xX74dcWq3PwQpRO6L3eqdtMcCBk9jq1ARiOw5c3Hs63sKXGK/9IhpvKNVOXneu6W+9OiAwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484271; c=relaxed/simple;
	bh=lFmRf0UqXzAD/H+cDJ45OmX59Qe26LwGgupNtdazpJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tT45TVDFqY1qTO+iR7A8lQJmFlJGIFouh+04JsqcprrJvdR2YD47VaZIPkjqq8mmPU068me+BGrYUMq4hIYTm5sbTsobzwjv4xrhGCEBXG7L8qpxXc+IAhUOyJ+LDZKkrppdCBjpc0SoFefbWvkYpDe8wwdzi61Lt1tugn3CZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqO9GqBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF8C4CEED;
	Mon,  5 May 2025 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484271;
	bh=lFmRf0UqXzAD/H+cDJ45OmX59Qe26LwGgupNtdazpJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqO9GqBFLB8y0dRbyUMXplk0ARVjCaZwjhiRQZMuV/3nEgxzfFILUiuAPgD7iML9D
	 IFdhIlfZcERaYJ48UDbjlmeRnX1L9Lx4XB1npnQ0519a3lSZNMkrLwTRjYNLEFIXd4
	 /aFC+xl447d/8rYKBFov5GdKUl+JlMM6I7DLnx3xCZKEE03gA+4+fMGL0ZzNLm3EW0
	 MJSSymy2xu4atCXDwC0GBcrZ04X7Z5lI6RU2OsTjfqdp7dwA4ZvicftxZGbPUAQWWp
	 C6Mbaymml+n63JFkYu+TwtBQ+4ZUCn+dCYFxRFCWV0vQ+D6WCiZYOxxOXH8Z8poN9f
	 z/tHPFKh89r6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 426/642] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Mon,  5 May 2025 18:10:42 -0400
Message-Id: <20250505221419.2672473-426-sashal@kernel.org>
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
index 0f6379ae258d1..4a0ff08d589ca 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -145,7 +145,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
+	struct kernfs_root *root = kernfs_root(kn);
 
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
 
-- 
2.39.5


