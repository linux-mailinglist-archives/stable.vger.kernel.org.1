Return-Path: <stable+bounces-114861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3EA3062A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B52161142
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A11F0E4A;
	Tue, 11 Feb 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUEUZRqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A391EE7D2;
	Tue, 11 Feb 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263511; cv=none; b=CzcCBiFLWdzsjfMLAZLMhyRU2s2PlxTGKDo6gAJnJcKxBOmvex5sNhUEFT0PN4/zX4Yoz5J9Z/Afygo3fJtZ5tTWzO4H8zex86GCL4doqRmCw78S3ZLaCyawaeJeqeRfW6rdDGVenZT1hGbSkGLeZdnQfSlLK9PB7bdahzjPfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263511; c=relaxed/simple;
	bh=lykx5EWzw+9XqeTPJI1ls5uYpIwKGRHJsE11lnC47BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxblG1LpmqCVQf+ckA1kT3RR/6MQ5a9QVodeVkYW9hctsNwIUvHEc28WIzeeQHNt9A2yzL0oLctByCdxkRqycuA1xfQXzi+RTI1vDlf2NqQzcFsJdHxLznCQGwdnM4c7JEF3wwJXLRY7nHlGOL8qKDSDQ793NUjtTTnQZuJkUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUEUZRqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BF1C4CEDD;
	Tue, 11 Feb 2025 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739263511;
	bh=lykx5EWzw+9XqeTPJI1ls5uYpIwKGRHJsE11lnC47BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUEUZRqKCp7kILvi+k6ByeNIpqewDMLRQ1UD7V7oFqcEFA8J8YCP/gburTIaHLa7Q
	 me/6pvaFfkZbrxQO93qKXGvyjl06GaV/zf1qRQc9089t5WjqhCSuWlOtTPmgvivi/r
	 7A0dqQ5ORyT1UyWijFNmte0snV/col62c0JHFWEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.77
Date: Tue, 11 Feb 2025 09:44:58 +0100
Message-ID: <2025021111-unrelated-immodest-318c@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021111-senate-unburned-9456@gregkh>
References: <2025021111-senate-unburned-9456@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d679a3dd5a58..1391d545aee9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 76
+SUBLEVEL = 77
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 9cddd78b11d4..ff201753fd18 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -16,17 +16,11 @@
 #include <linux/seq_file.h>
 #include <linux/writeback.h>
 #include <linux/mount.h>
-#include <linux/fs_context.h>
-#include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include "hostfs.h"
 #include <init.h>
 #include <kern.h>
 
-struct hostfs_fs_info {
-	char *host_root_path;
-};
-
 struct hostfs_inode_info {
 	int fd;
 	fmode_t mode;
@@ -94,17 +88,30 @@ __uml_setup("hostfs=", hostfs_args,
 static char *__dentry_name(struct dentry *dentry, char *name)
 {
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
-	struct hostfs_fs_info *fsi = dentry->d_sb->s_fs_info;
-	char *root = fsi->host_root_path;
-	size_t len = strlen(root);
+	char *root;
+	size_t len;
+
+	root = dentry->d_sb->s_fs_info;
+	len = strlen(root);
+	if (IS_ERR(p)) {
+		__putname(name);
+		return NULL;
+	}
 
-	if (IS_ERR(p) || len > p - name) {
+	/*
+	 * This function relies on the fact that dentry_path_raw() will place
+	 * the path name at the end of the provided buffer.
+	 */
+	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+
+	strscpy(name, root, PATH_MAX);
+	if (len > p - name) {
 		__putname(name);
 		return NULL;
 	}
 
-	memcpy(name, root, len);
-	memmove(name + len, p, name + PATH_MAX - p);
+	if (p > name + len)
+		strcpy(name + len, p);
 
 	return name;
 }
@@ -189,10 +196,8 @@ static int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 	long long f_bavail;
 	long long f_files;
 	long long f_ffree;
-	struct hostfs_fs_info *fsi;
 
-	fsi = dentry->d_sb->s_fs_info;
-	err = do_statfs(fsi->host_root_path,
+	err = do_statfs(dentry->d_sb->s_fs_info,
 			&sf->f_bsize, &f_blocks, &f_bfree, &f_bavail, &f_files,
 			&f_ffree, &sf->f_fsid, sizeof(sf->f_fsid),
 			&sf->f_namelen);
@@ -240,11 +245,7 @@ static void hostfs_free_inode(struct inode *inode)
 
 static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
 {
-	struct hostfs_fs_info *fsi;
-	const char *root_path;
-
-	fsi = root->d_sb->s_fs_info;
-	root_path = fsi->host_root_path;
+	const char *root_path = root->d_sb->s_fs_info;
 	size_t offset = strlen(root_ino) + 1;
 
 	if (strlen(root_path) > offset)
@@ -923,10 +924,10 @@ static const struct inode_operations hostfs_link_iops = {
 	.get_link	= hostfs_get_link,
 };
 
-static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
+static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 {
-	struct hostfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *root_inode;
+	char *host_root_path, *req_root = d;
 	int err;
 
 	sb->s_blocksize = 1024;
@@ -939,7 +940,16 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	root_inode = hostfs_iget(sb, fsi->host_root_path);
+	/* NULL is printed as '(null)' by printf(): avoid that. */
+	if (req_root == NULL)
+		req_root = "";
+
+	sb->s_fs_info = host_root_path =
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
+	if (host_root_path == NULL)
+		return -ENOMEM;
+
+	root_inode = hostfs_iget(sb, host_root_path);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
 
@@ -947,7 +957,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		char *name;
 
 		iput(root_inode);
-		name = follow_link(fsi->host_root_path);
+		name = follow_link(host_root_path);
 		if (IS_ERR(name))
 			return PTR_ERR(name);
 
@@ -964,92 +974,11 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
-enum hostfs_parma {
-	Opt_hostfs,
-};
-
-static const struct fs_parameter_spec hostfs_param_specs[] = {
-	fsparam_string_empty("hostfs",		Opt_hostfs),
-	{}
-};
-
-static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	struct hostfs_fs_info *fsi = fc->s_fs_info;
-	struct fs_parse_result result;
-	char *host_root;
-	int opt;
-
-	opt = fs_parse(fc, hostfs_param_specs, param, &result);
-	if (opt < 0)
-		return opt;
-
-	switch (opt) {
-	case Opt_hostfs:
-		host_root = param->string;
-		if (!*host_root)
-			host_root = "";
-		fsi->host_root_path =
-			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-		if (fsi->host_root_path == NULL)
-			return -ENOMEM;
-		break;
-	}
-
-	return 0;
-}
-
-static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
-{
-	struct hostfs_fs_info *fsi = fc->s_fs_info;
-	char *host_root = (char *)data;
-
-	/* NULL is printed as '(null)' by printf(): avoid that. */
-	if (host_root == NULL)
-		host_root = "";
-
-	fsi->host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-	if (fsi->host_root_path == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int hostfs_fc_get_tree(struct fs_context *fc)
-{
-	return get_tree_nodev(fc, hostfs_fill_super);
-}
-
-static void hostfs_fc_free(struct fs_context *fc)
-{
-	struct hostfs_fs_info *fsi = fc->s_fs_info;
-
-	if (!fsi)
-		return;
-
-	kfree(fsi->host_root_path);
-	kfree(fsi);
-}
-
-static const struct fs_context_operations hostfs_context_ops = {
-	.parse_monolithic = hostfs_parse_monolithic,
-	.parse_param	= hostfs_parse_param,
-	.get_tree	= hostfs_fc_get_tree,
-	.free		= hostfs_fc_free,
-};
-
-static int hostfs_init_fs_context(struct fs_context *fc)
+static struct dentry *hostfs_read_sb(struct file_system_type *type,
+			  int flags, const char *dev_name,
+			  void *data)
 {
-	struct hostfs_fs_info *fsi;
-
-	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
-	if (!fsi)
-		return -ENOMEM;
-
-	fc->s_fs_info = fsi;
-	fc->ops = &hostfs_context_ops;
-	return 0;
+	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
 }
 
 static void hostfs_kill_sb(struct super_block *s)
@@ -1059,11 +988,11 @@ static void hostfs_kill_sb(struct super_block *s)
 }
 
 static struct file_system_type hostfs_type = {
-	.owner			= THIS_MODULE,
-	.name			= "hostfs",
-	.init_fs_context	= hostfs_init_fs_context,
-	.kill_sb		= hostfs_kill_sb,
-	.fs_flags		= 0,
+	.owner 		= THIS_MODULE,
+	.name 		= "hostfs",
+	.mount	 	= hostfs_read_sb,
+	.kill_sb	= hostfs_kill_sb,
+	.fs_flags 	= 0,
 };
 MODULE_ALIAS_FS("hostfs");
 

