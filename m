Return-Path: <stable+bounces-186008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E1FBE3356
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978133A4B4D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF031CA54;
	Thu, 16 Oct 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO+ajIFG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E32E36E9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615958; cv=none; b=kI4U+JMLEb9lehfevHPzG1btQWD7oNExwP3Cv1o2FZpI3xN0wW1ANlnwGFpX5Hcr1fbn1CZcFm6d5l7VaSbwjCMfZMrV5hIwyC3DUqikUJjCFosC6DNNHDz0BqkMzcSu3pMeFviHL/cEgjgbJd/kWWUT/13/fq8uBeoWhR6VDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615958; c=relaxed/simple;
	bh=P7qjtypTE0B86nefgEFU+sPeBd+IuYyvuZElOEwTHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9gbeHUGGQ9yIYZ/l2T/FR5v+EVOjq0U0OCkD40iKLskncz/jdEfQzILLsbHQ+DpYH7REpXoNUI7zLGEzKHHi0XHj99AcYaXXFqWqF96kSjP+34l7UXVxLFmXZ9F+n3W78tfs0CAXA8ISm7+0OGvUPygFwAG4cANVI2H/nODrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO+ajIFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2B3C4CEF1;
	Thu, 16 Oct 2025 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615957;
	bh=P7qjtypTE0B86nefgEFU+sPeBd+IuYyvuZElOEwTHfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RO+ajIFGkEdsXc94S/ujbLDhsn/2ulfsF8cgm3HC1bs+vJ8vGD4ZZJma+CjXvLKTa
	 BjEDDK7HIp/zteIYgo6UIUbxQoywDCdcyxBxUGXWi3PVxJjQ4hcFOuPVukXFhcvbqg
	 JwfqcY+BhZWdgptZ3V7+TSu3wTtttpUulHmqpf/uYikuoEupoCJvj0o0gD8nCIW4B+
	 xr78r2lggQiJfv5LvnPX7gu1RlfPHfnyCfW2PYiWxruAeN9SqsUt4drKEMVtxgE2gI
	 dl652cO4hhl8w/E393q6AqiYMvlwdX5EwhZtJdC2Bj89yH1f+Q6Hba+qn0tgPrnPKJ
	 QbOlFVhfqFBiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] statmount: don't call path_put() under namespace semaphore
Date: Thu, 16 Oct 2025 07:59:15 -0400
Message-ID: <20251016115915.3270405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101533-mutt-routing-a332@gregkh>
References: <2025101533-mutt-routing-a332@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e8c84e2082e69335f66c8ade4895e80ec270d7c4 ]

Massage statmount() and make sure we don't call path_put() under the
namespace semaphore. If we put the last reference we're fscked.

Fixes: 46eae99ef733 ("add statmount(2) syscall")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c8519302f5824..274db35ca5abd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5200,7 +5200,6 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
-	struct path root __free(path_put) = {};
 	struct mount *m;
 	int err;
 
@@ -5212,7 +5211,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!s->mnt)
 		return -ENOENT;
 
-	err = grab_requested_root(ns, &root);
+	err = grab_requested_root(ns, &s->root);
 	if (err)
 		return err;
 
@@ -5221,15 +5220,13 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &root) &&
+	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = security_sb_statfs(s->mnt->mnt_root);
 	if (err)
 		return err;
-
-	s->root = root;
 	if (s->mask & STATMOUNT_SB_BASIC)
 		statmount_sb_basic(s);
 
@@ -5406,6 +5403,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
 	kvfree(ks->seq.buf);
+	path_put(&ks->root);
 	if (retry_statmount(ret, &seq_size))
 		goto retry;
 	return ret;
-- 
2.51.0


