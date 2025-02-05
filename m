Return-Path: <stable+bounces-113708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875EA293E6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871C4188AAD7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403517084F;
	Wed,  5 Feb 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0el6jVrl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63311519BF;
	Wed,  5 Feb 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767888; cv=none; b=cQGB8cCSAWOhZGsTxmuVCPjSJC3ztpchywjJYNXt2xU5i5c+JtZbSQs/bEAV0hR3Ft8fcGROdx6cHQMW3bjW2FWPekfGGVbOBymdU/YQLnrPbdqaAgNdZy2rfWYIv/XCV5YdppSQgaWxmCgjVuxGIsA9V/mbU0WFNWXV8j3dt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767888; c=relaxed/simple;
	bh=AiCZpS/rb3CApxStFR+39F5xT9AD4acq954aY+7AZrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM9ZsVxtP3MKbM+jtXj6QdV8Fzv4c2OVRmlPn8IuuFGOjIK+N0WEEUTn2EFoKkrAU/HmgbHQROHQ+REp1GZaBoIFXD1kygJ/afHo+2yZljJ4JdFgUWZE9O7tbVt8qcCNKQtG7DLr0aUKMSsMEo3vdOhTMsy36p6FHmwXG5askO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0el6jVrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927AC4CED1;
	Wed,  5 Feb 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767887;
	bh=AiCZpS/rb3CApxStFR+39F5xT9AD4acq954aY+7AZrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0el6jVrl8lupM6VcTk4fhjTrWe0dQoLcVqV5b4k/coV2fk8kYGN9K/f+pOmh3VPxD
	 8DlP4+JnNzuBrWqZFwwx7GlzCk5M9NCPrU3sKZrlWtlmnmDWDcuoQUMmWVhZQodIEi
	 epHiTxd53EAbLIyyXTVtRKaoufKONZRLfxwGRicQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 522/590] hostfs: fix string handling in __dentry_name()
Date: Wed,  5 Feb 2025 14:44:37 +0100
Message-ID: <20250205134515.234630744@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 60a6002432448bb3f291d80768ae98d62efc9c77 ]

strcpy() should not be used with destination potentially overlapping
the source; what's more, strscpy() in there is pointless - we already
know the amount we want to copy; might as well use memcpy().

Fixes: c278e81b8a02 "hostfs: Remove open coded strcpy()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 084f6ed2dd7a6..94f3cc42c7403 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -94,32 +94,17 @@ __uml_setup("hostfs=", hostfs_args,
 static char *__dentry_name(struct dentry *dentry, char *name)
 {
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
-	char *root;
-	size_t len;
-	struct hostfs_fs_info *fsi;
-
-	fsi = dentry->d_sb->s_fs_info;
-	root = fsi->host_root_path;
-	len = strlen(root);
-	if (IS_ERR(p)) {
-		__putname(name);
-		return NULL;
-	}
-
-	/*
-	 * This function relies on the fact that dentry_path_raw() will place
-	 * the path name at the end of the provided buffer.
-	 */
-	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+	struct hostfs_fs_info *fsi = dentry->d_sb->s_fs_info;
+	char *root = fsi->host_root_path;
+	size_t len = strlen(root);
 
-	strscpy(name, root, PATH_MAX);
-	if (len > p - name) {
+	if (IS_ERR(p) || len > p - name) {
 		__putname(name);
 		return NULL;
 	}
 
-	if (p > name + len)
-		strcpy(name + len, p);
+	memcpy(name, root, len);
+	memmove(name + len, p, name + PATH_MAX - p);
 
 	return name;
 }
-- 
2.39.5




