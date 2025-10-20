Return-Path: <stable+bounces-188211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CCBF2B69
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91054461028
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADDF32F75B;
	Mon, 20 Oct 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmaTkTS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2A221FC8
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981343; cv=none; b=o+9jpV+OqVnPKVAx5yHICTKXdV5Q90JVO9XljK7RdnJL+tmfVXRDjIb4hBV1+I54xDZsr4Au7L2JwfQdQy7edcdCOSOsNCOPw13GMQKnnXVmh9wVVPiOkIP5i0O/SCwlm4U9ba5kgrI0DFhXUsZIzsdTAaq+iUmVmdvb3Nuyjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981343; c=relaxed/simple;
	bh=POeUuxRxNO9gA6/UVY+tBhszzkiDL6YNaCVyIoaTS2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIdXy1s5GFqzI9aSF+G6hARDNUcvIOAdvcIADOfb2+LU0YFMeSBsRwr/0xRzVe28pa27yR8OcCA2QgRjVt6g9e8YAUQEZrXpqUcw8S6sHWfVbIBNSMMtWAD5E2A4hzy1DyVYG6IEpMmuamRIvXC5pkdS5/5sI3j/KBS0C+F6CBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmaTkTS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B58C4CEF9;
	Mon, 20 Oct 2025 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981343;
	bh=POeUuxRxNO9gA6/UVY+tBhszzkiDL6YNaCVyIoaTS2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmaTkTS47fynYY/6rBSlX45NE41wk33n5/KUcv5UxEMAILkADRfRzISECZRNkHK+B
	 0hDWSssNeHxlFu+bEDPq9g6QzriQY7q9ma6B0y8qhi2qEjlpKILnQQzqHby040rXIo
	 QaHenKofw6V7GE/vAsk4A2+b8qdoSWbRh04SJeXlBt12AHHjWlVty3y7x5oFW8MkgI
	 6214k0tkS9dvBzWJrn6TDFMQxRzMMthRVGLYhUlURAjLDvRZRXsf0o23Eh6cw8lxMX
	 7B0MNpF0qY/SjvNEsUIG3JVwVzksp00lpcSU35AnqFvMOWiT22jG/3hHvTArVRleqe
	 TKuPBLlm/jUiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier
Date: Mon, 20 Oct 2025 13:28:58 -0400
Message-ID: <20251020172900.1851256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102038-hash-smashing-4b29@gregkh>
References: <2025102038-hash-smashing-4b29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit e95db51c81f54dd12ea465b5127e4786f62a1095 ]

Do that before new dentry is visible anywhere.  It does create
a new possible state for dentries present in ->d_children/->d_sib -
DCACHE_PAR_LOOKUP present, negative, unhashed, not in in-lookup
hash chains, refcount positive.  Those are going to be skipped
by all tree-walkers (both d_walk() callbacks in fs/dcache.c and
explicit loops over children/sibling lists elsewhere) and
dput() is fine with those.

NOTE: dropping the final reference to a "normal" in-lookup dentry
(in in-lookup hash) is a bug - somebody must've forgotten to
call d_lookup_done() on it and bad things will happen.  With those
it's OK; if/when we get around to making __dentry_kill() complain
about such breakage, remember that predicate to check should
*not* be just d_in_lookup(victim) but rather a combination of that
with !hlist_bl_unhashed(&victim->d_u.d_in_lookup_hash).  Might
be worth considering later...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 56094ad3eaa2 ("vfs: Don't leak disconnected dentries on umount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0f6b16ba30d08..d81765352cf81 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2475,13 +2475,19 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
 	struct hlist_bl_node *node;
-	struct dentry *new = d_alloc(parent, name);
+	struct dentry *new = __d_alloc(parent->d_sb, name);
 	struct dentry *dentry;
 	unsigned seq, r_seq, d_seq;
 
 	if (unlikely(!new))
 		return ERR_PTR(-ENOMEM);
 
+	new->d_flags |= DCACHE_PAR_LOOKUP;
+	spin_lock(&parent->d_lock);
+	new->d_parent = dget_dlock(parent);
+	hlist_add_head(&new->d_sib, &parent->d_children);
+	spin_unlock(&parent->d_lock);
+
 retry:
 	rcu_read_lock();
 	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
@@ -2565,8 +2571,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	/* we can't take ->d_lock here; it's OK, though. */
-	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
-- 
2.51.0


