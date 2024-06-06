Return-Path: <stable+bounces-48903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6428FEB0A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2611F262EF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A41A2C25;
	Thu,  6 Jun 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKKzBXeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6E197536;
	Thu,  6 Jun 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683204; cv=none; b=WbcXlQMh41wlyT8Mwi4RFFAQTRP3NyiVl8KQpVKZtn099zVUjTacJTXziCpBweAeUC+0FWohOSH72+rlPSIcmVktjNJ/GJtr/5KodSMV2/JL5pu93chCIgl3lSMjYwtG9otNczA/qJlDzA9ql9G4mzma9jco5b1JQjP65OUSUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683204; c=relaxed/simple;
	bh=EWGMn+IEPIcg2J+TzwbjTQDB/0WS/OR9HRqNaZXVNsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs6PDycRzIG0KGY5QkoB4Zz8FKXuz//210jTcl63lboPiDjgn7Umn1FWzqn37+5H+f4RhisVpIzMbJzRe3YFByydZQdGbFSwHJ+WbkWbR+cjEH/553cT2+2zE93bIlagdoq+4/zo8LwPT8sm8toDCJTcaJ6PLtYpn3Jg+dC+r8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKKzBXeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77CFC2BD10;
	Thu,  6 Jun 2024 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683203;
	bh=EWGMn+IEPIcg2J+TzwbjTQDB/0WS/OR9HRqNaZXVNsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKKzBXeZ0e6mlMKR8pOnS6JBLYbbW7HBrlTkfRTi3u7mUmpUIsnehaJrtEbOT2zqk
	 Fdz0jI6Q/RQGe3ODNExzwP/FMu8640EO2loxdGL99UxJnRqCJ/ce5+J0KS/bUQ0wX9
	 Q0LUMKOOr0kLGhveBXsJOy1p6wW7979DZDVKL1ZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sahil Siddiq <icegambit91@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 147/744] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Thu,  6 Jun 2024 15:56:59 +0200
Message-ID: <20240606131737.126874314@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sahil Siddiq <icegambit91@gmail.com>

[ Upstream commit 478a535ae54ad3831371904d93b5dfc403222e17 ]

When pinning programs/objects under PATH (eg: during "bpftool prog
loadall") the bpffs is mounted on the parent dir of PATH in the
following situations:
- the given dir exists but it is not bpffs.
- the given dir doesn't exist and the parent dir is not bpffs.

Mounting on the parent dir can also have the unintentional side-
effect of hiding other files located under the parent dir.

If the given dir exists but is not bpffs, then the bpffs should
be mounted on the given dir and not its parent dir.

Similarly, if the given dir doesn't exist and its parent dir is not
bpffs, then the given dir should be created and the bpffs should be
mounted on this new dir.

Fixes: 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog loadall")
Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com/T/#t
Link: https://lore.kernel.org/bpf/20240404192219.52373-1-icegambit91@gmail.com

Closes: https://github.com/libbpf/bpftool/issues/100

Changes since v1:
 - Split "mount_bpffs_for_pin" into two functions.
   This is done to improve maintainability and readability.

Changes since v2:
- mount_bpffs_for_pin: rename to "create_and_mount_bpffs_dir".
- mount_bpffs_given_file: rename to "mount_bpffs_given_file".
- create_and_mount_bpffs_dir:
  - introduce "dir_exists" boolean.
  - remove new dir if "mnt_fs" fails.
- improve error handling and error messages.

Changes since v3:
- Rectify function name.
- Improve error messages and formatting.
- mount_bpffs_for_file:
  - Check if dir exists before block_mount check.

Changes since v4:
- Use strdup instead of strcpy.
- create_and_mount_bpffs_dir:
  - Use S_IRWXU instead of 0700.
- Improve error handling and formatting.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c     | 96 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/iter.c       |  2 +-
 tools/bpf/bpftool/main.h       |  3 +-
 tools/bpf/bpftool/prog.c       |  5 +-
 tools/bpf/bpftool/struct_ops.c |  2 +-
 5 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447d..958e92acca8e2 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,29 +244,101 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name, bool is_dir)
+int create_and_mount_bpffs_dir(const char *dir_name)
 {
 	char err_str[ERR_MAX_LEN];
-	char *file;
-	char *dir;
+	bool dir_exists;
 	int err = 0;
 
-	if (is_dir && is_bpffs(name))
+	if (is_bpffs(dir_name))
 		return err;
 
-	file = malloc(strlen(name) + 1);
-	if (!file) {
+	dir_exists = access(dir_name, F_OK) == 0;
+
+	if (!dir_exists) {
+		char *temp_name;
+		char *parent_name;
+
+		temp_name = strdup(dir_name);
+		if (!temp_name) {
+			p_err("mem alloc failed");
+			return -1;
+		}
+
+		parent_name = dirname(temp_name);
+
+		if (is_bpffs(parent_name)) {
+			/* nothing to do if already mounted */
+			free(temp_name);
+			return err;
+		}
+
+		if (access(parent_name, F_OK) == -1) {
+			p_err("can't create dir '%s' to pin BPF object: parent dir '%s' doesn't exist",
+			      dir_name, parent_name);
+			free(temp_name);
+			return -1;
+		}
+
+		free(temp_name);
+	}
+
+	if (block_mount) {
+		p_err("no BPF file system found, not mounting it due to --nomount option");
+		return -1;
+	}
+
+	if (!dir_exists) {
+		err = mkdir(dir_name, S_IRWXU);
+		if (err) {
+			p_err("failed to create dir '%s': %s", dir_name, strerror(errno));
+			return err;
+		}
+	}
+
+	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
+	if (err) {
+		err_str[ERR_MAX_LEN - 1] = '\0';
+		p_err("can't mount BPF file system on given dir '%s': %s",
+		      dir_name, err_str);
+
+		if (!dir_exists)
+			rmdir(dir_name);
+	}
+
+	return err;
+}
+
+int mount_bpffs_for_file(const char *file_name)
+{
+	char err_str[ERR_MAX_LEN];
+	char *temp_name;
+	char *dir;
+	int err = 0;
+
+	if (access(file_name, F_OK) != -1) {
+		p_err("can't pin BPF object: path '%s' already exists", file_name);
+		return -1;
+	}
+
+	temp_name = strdup(file_name);
+	if (!temp_name) {
 		p_err("mem alloc failed");
 		return -1;
 	}
 
-	strcpy(file, name);
-	dir = dirname(file);
+	dir = dirname(temp_name);
 
 	if (is_bpffs(dir))
 		/* nothing to do if already mounted */
 		goto out_free;
 
+	if (access(dir, F_OK) == -1) {
+		p_err("can't pin BPF object: dir '%s' doesn't exist", dir);
+		err = -1;
+		goto out_free;
+	}
+
 	if (block_mount) {
 		p_err("no BPF file system found, not mounting it due to --nomount option");
 		err = -1;
@@ -276,12 +348,12 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
-		p_err("can't mount BPF file system to pin the object (%s): %s",
-		      name, err_str);
+		p_err("can't mount BPF file system to pin the object '%s': %s",
+		      file_name, err_str);
 	}
 
 out_free:
-	free(file);
+	free(temp_name);
 	return err;
 }
 
@@ -289,7 +361,7 @@ int do_pin_fd(int fd, const char *name)
 {
 	int err;
 
-	err = mount_bpffs_for_pin(name, false);
+	err = mount_bpffs_for_file(name);
 	if (err)
 		return err;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 6b0e5202ca7a9..5c39c2ed36a2b 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
 
-	err = mount_bpffs_for_pin(path, false);
+	err = mount_bpffs_for_file(path);
 	if (err)
 		goto close_link;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b8bb08d10dec9..9eb764fe4cc8b 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,7 +142,8 @@ const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
-int mount_bpffs_for_pin(const char *name, bool is_dir);
+int mount_bpffs_for_file(const char *file_name);
+int create_and_mount_bpffs_dir(const char *dir_name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f186f1cee465b..086b93939ce93 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1774,7 +1774,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
+	if (first_prog_only)
+		err = mount_bpffs_for_file(pinfile);
+	else
+		err = create_and_mount_bpffs_dir(pinfile);
 	if (err)
 		goto err_close_obj;
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 3ebc9fe91e0e1..d110c6ad8175c 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -509,7 +509,7 @@ static int do_register(int argc, char **argv)
 	if (argc == 1)
 		linkdir = GET_ARG();
 
-	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
+	if (linkdir && create_and_mount_bpffs_dir(linkdir)) {
 		p_err("can't mount bpffs for pinning");
 		return -1;
 	}
-- 
2.43.0




