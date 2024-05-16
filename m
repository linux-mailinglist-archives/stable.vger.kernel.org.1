Return-Path: <stable+bounces-45327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD28C7C6E
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 20:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E332A1F21B7D
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340751635AE;
	Thu, 16 May 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1+TVKVPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15C15FD1B
	for <stable@vger.kernel.org>; Thu, 16 May 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883598; cv=none; b=NnyHuVkK6oagu90AXw95JHXl8/8Qp/c2ZzNXhe1xM2KrOOoWvM2oqTQ6y6k6xH9nDVRdi5V0Ecu7/xB7CcCc2iSn4slpMUQhgRQA1X6I5oTdYO71t0kRzU/+OkkFSbmvQUuHx7sK0HWpjj9CATS0pfvs33wBMIAKOpvlG6RZuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883598; c=relaxed/simple;
	bh=5KRWtyLsaH6DIVboHThP86V5QZIcRzReg8vtxsJ0D1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/O0n7ieZ2koNYRRr9FXLKh+lMrulIOVMkVNXSU+iPB3gbey84VYwB8yqo3FwPB/W39qHT77hThC0iPl0A7zxfKqDPGpQnC3Z/rZAkEW7WjbnrxDHdo5pT+cU9l8aJMHjxLUt3fmA+HXPpN/N5SWAFP+37M1Xp1tN9XfFoyv/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1+TVKVPP; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VgJKG6Z0lzC4V;
	Thu, 16 May 2024 20:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715883586;
	bh=3HPBFcfXIupAj8rBMIh3SYeVvxw0d3/RL490PTDHfy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1+TVKVPPz2feTbBej8nkBd3KW28RYulRNpHiWy9t/UGYLMlYCv7QjnZZVoO5mqqHM
	 61vb+X7HZ0ksaxu1M8Tte4U0KvKv53pPHV0EheOGfYx+JV5juMpI8oQKkwSTx2xa0+
	 SgOF2+JNnrENcTF2daXVpZp7/FyX8/I9wwhcfizg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VgJKG1fLNzhPV;
	Thu, 16 May 2024 20:19:46 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	nathan@kernel.org,
	ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+bf4903dc7e12b18ebc87@syzkaller.appspotmail.com
Subject: [PATCH v1 1/2] landlock: Fix d_parent walk
Date: Thu, 16 May 2024 20:19:34 +0200
Message-ID: <20240516181935.1645983-2-mic@digikod.net>
In-Reply-To: <20240516181935.1645983-1-mic@digikod.net>
References: <20240516181935.1645983-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The canary in collect_domain_accesses() can be triggered when trying to
link a root mount point.  This cannot work in practice because this
directory is mounted, but the VFS check is done after the call to
security_path_link().

Do not use source directory's d_parent when the source directory is the
mount point.

Add tests to check error codes when renaming or linking a mount root
directory.  This previously triggered a kernel warning.  The
linux/mount.h file is not sorted with other headers to ease backport to
Linux 6.1 .

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Reported-by: syzbot+bf4903dc7e12b18ebc87@syzkaller.appspotmail.com
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Closes: https://lore.kernel.org/r/000000000000553d3f0618198200@google.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240516181935.1645983-2-mic@digikod.net
---
 security/landlock/fs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 22d8b7c28074..7877a64cc6b8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1110,6 +1110,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
+	struct dentry *old_parent;
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
@@ -1157,9 +1158,17 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	mnt_dir.mnt = new_dir->mnt;
 	mnt_dir.dentry = new_dir->mnt->mnt_root;
 
+	/*
+	 * old_dentry may be the root of the common mount point and
+	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
+	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
+	 * we keep a reference to old_dentry.
+	 */
+	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
+						      old_dentry->d_parent;
+
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry,
-						old_dentry->d_parent,
+	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry, old_parent,
 						&layer_masks_parent1);
 	allow_parent2 = collect_domain_accesses(
 		dom, mnt_dir.dentry, new_dir->dentry, &layer_masks_parent2);
-- 
2.45.0


