Return-Path: <stable+bounces-80207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807798DC6D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035BC281BB6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45F1D0F40;
	Wed,  2 Oct 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/dmEluw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D11D0DF7;
	Wed,  2 Oct 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879697; cv=none; b=mA+RG40daGeHeauOZmChGybbtZsP+Ws6BVybFsx1lGSkIt/+dLTfqAlJNAJ1nNqUGJuSUYvcwbKMRd3ny7pyx3XiN+KUB7mHApdhYeB+DAWTh/rICOfr5h07ndqyYOsbNrZdKfsmq2UHDyJA33d/Bgax/UNDWu/qSxFZ8Z4gM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879697; c=relaxed/simple;
	bh=HWdDDFahQtQoKiEK3SJwpG8EW0QO7iE7pBzWgILjFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyJmsO0VW7oQYOV4KJCO65eeKGhcr6jerxt/URp9PtyvpwI48CQEoLKJwoLVKfr+WqdcOYLmphaW55gXcTfzJhpQyRrULzCEnz9uZAEh4YDzCG36ESbvpN8GQ+d/71Stw0tnkB4hE0w3MdOchfdbUtE6L+j9scm94K2c0JXuK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/dmEluw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D96C4CEC2;
	Wed,  2 Oct 2024 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879696;
	bh=HWdDDFahQtQoKiEK3SJwpG8EW0QO7iE7pBzWgILjFSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/dmEluweg2oJNRxCwqyHOYtqTplGJbK3fB00WNjrEUgctnncXE/NWWpEYYFU8hVd
	 mVSTg2kX3PjLUAmmaqSbj8vKBDZOyQmk1x1dUQhs2rzfPUdpEuB+UOfoabwvxGtYRC
	 3DygGqz4VAK8/+Xt2snstDuy0+NtvuzdvOOLwWgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 208/538] libbpf: use stable map placeholder FDs
Date: Wed,  2 Oct 2024 14:57:27 +0200
Message-ID: <20241002125800.466512971@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit dac645b950ea4fc0896fe46a645365cb8d9ab92b ]

Move map creation to later during BPF object loading by pre-creating
stable placeholder FDs (utilizing memfd_create()). Use dup2()
syscall to then atomically make those placeholder FDs point to real
kernel BPF map objects.

This change allows to delay BPF map creation to after all the BPF
program relocations. That, in turn, allows to delay BTF finalization and
loading into kernel to after all the relocations as well. We'll take
advantage of the latter in subsequent patches to allow libbpf to adjust
BTF in a way that helps with BPF global function usage.

Clean up a few places where we close map->fd, which now shouldn't
happen, because map->fd should be a valid FD regardless of whether map
was created or not. Surprisingly and nicely it simplifies a bunch of
error handling code. If this change doesn't backfire, I'm tempted to
pre-create such stable FDs for other entities (progs, maybe even BTF).
We previously did some manipulations to make gen_loader work with fake
map FDs, with stable map FDs this hack is not necessary for maps (we
still have it for BTF, but I left it as is for now).

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240104013847.3875810-5-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 04a94133f1b3 ("libbpf: Don't take direct pointers into BTF data from st_ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 101 ++++++++++++++++++++------------
 tools/lib/bpf/libbpf_internal.h |  14 +++++
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ceed16a10285a..54f3380010f55 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1491,6 +1491,16 @@ static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const char *nam
 	return ERR_PTR(-ENOENT);
 }
 
+static int create_placeholder_fd(void)
+{
+	int fd;
+
+	fd = ensure_good_fd(memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
+	if (fd < 0)
+		return -errno;
+	return fd;
+}
+
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 {
 	struct bpf_map *map;
@@ -1503,7 +1513,21 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 
 	map = &obj->maps[obj->nr_maps++];
 	map->obj = obj;
-	map->fd = -1;
+	/* Preallocate map FD without actually creating BPF map just yet.
+	 * These map FD "placeholders" will be reused later without changing
+	 * FD value when map is actually created in the kernel.
+	 *
+	 * This is useful to be able to perform BPF program relocations
+	 * without having to create BPF maps before that step. This allows us
+	 * to finalize and load BTF very late in BPF object's loading phase,
+	 * right before BPF maps have to be created and BPF programs have to
+	 * be loaded. By having these map FD placeholders we can perform all
+	 * the sanitizations, relocations, and any other adjustments before we
+	 * start creating actual BPF kernel objects (BTF, maps, progs).
+	 */
+	map->fd = create_placeholder_fd();
+	if (map->fd < 0)
+		return ERR_PTR(map->fd);
 	map->inner_map_fd = -1;
 	map->autocreate = true;
 
@@ -2595,7 +2619,9 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		map->inner_map = calloc(1, sizeof(*map->inner_map));
 		if (!map->inner_map)
 			return -ENOMEM;
-		map->inner_map->fd = -1;
+		map->inner_map->fd = create_placeholder_fd();
+		if (map->inner_map->fd < 0)
+			return map->inner_map->fd;
 		map->inner_map->sec_idx = sec_idx;
 		map->inner_map->name = malloc(strlen(map_name) + sizeof(".inner") + 1);
 		if (!map->inner_map->name)
@@ -4446,14 +4472,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 		goto err_free_new_name;
 	}
 
-	err = zclose(map->fd);
-	if (err) {
-		err = -errno;
-		goto err_close_new_fd;
-	}
+	err = reuse_fd(map->fd, new_fd);
+	if (err)
+		goto err_free_new_name;
+
 	free(map->name);
 
-	map->fd = new_fd;
 	map->name = new_name;
 	map->def.type = info.type;
 	map->def.key_size = info.key_size;
@@ -4467,8 +4491,6 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 
 	return 0;
 
-err_close_new_fd:
-	close(new_fd);
 err_free_new_name:
 	free(new_name);
 	return libbpf_err(err);
@@ -5102,7 +5124,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
 	struct bpf_map_def *def = &map->def;
 	const char *map_name = NULL;
-	int err = 0;
+	int err = 0, map_fd;
 
 	if (kernel_supports(obj, FEAT_PROG_NAME))
 		map_name = map->name;
@@ -5164,17 +5186,19 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		bpf_gen__map_create(obj->gen_loader, def->type, map_name,
 				    def->key_size, def->value_size, def->max_entries,
 				    &create_attr, is_inner ? -1 : map - obj->maps);
-		/* Pretend to have valid FD to pass various fd >= 0 checks.
-		 * This fd == 0 will not be used with any syscall and will be reset to -1 eventually.
+		/* We keep pretenting we have valid FD to pass various fd >= 0
+		 * checks by just keeping original placeholder FDs in place.
+		 * See bpf_object__add_map() comment.
+		 * This placeholder fd will not be used with any syscall and
+		 * will be reset to -1 eventually.
 		 */
-		map->fd = 0;
+		map_fd = map->fd;
 	} else {
-		map->fd = bpf_map_create(def->type, map_name,
-					 def->key_size, def->value_size,
-					 def->max_entries, &create_attr);
+		map_fd = bpf_map_create(def->type, map_name,
+					def->key_size, def->value_size,
+					def->max_entries, &create_attr);
 	}
-	if (map->fd < 0 && (create_attr.btf_key_type_id ||
-			    create_attr.btf_value_type_id)) {
+	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
 		char *cp, errmsg[STRERR_BUFSIZE];
 
 		err = -errno;
@@ -5186,13 +5210,11 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id = 0;
 		map->btf_key_type_id = 0;
 		map->btf_value_type_id = 0;
-		map->fd = bpf_map_create(def->type, map_name,
-					 def->key_size, def->value_size,
-					 def->max_entries, &create_attr);
+		map_fd = bpf_map_create(def->type, map_name,
+					def->key_size, def->value_size,
+					def->max_entries, &create_attr);
 	}
 
-	err = map->fd < 0 ? -errno : 0;
-
 	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
 		if (obj->gen_loader)
 			map->inner_map->fd = -1;
@@ -5200,7 +5222,19 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		zfree(&map->inner_map);
 	}
 
-	return err;
+	if (map_fd < 0)
+		return map_fd;
+
+	/* obj->gen_loader case, prevent reuse_fd() from closing map_fd */
+	if (map->fd == map_fd)
+		return 0;
+
+	/* Keep placeholder FD value but now point it to the BPF map object.
+	 * This way everything that relied on this map's FD (e.g., relocated
+	 * ldimm64 instructions) will stay valid and won't need adjustments.
+	 * map->fd stays valid but now point to what map_fd points to.
+	 */
+	return reuse_fd(map->fd, map_fd);
 }
 
 static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
@@ -5284,10 +5318,8 @@ static int bpf_object_init_prog_arrays(struct bpf_object *obj)
 			continue;
 
 		err = init_prog_array_slots(obj, map);
-		if (err < 0) {
-			zclose(map->fd);
+		if (err < 0)
 			return err;
-		}
 	}
 	return 0;
 }
@@ -5378,25 +5410,20 @@ bpf_object__create_maps(struct bpf_object *obj)
 
 			if (bpf_map__is_internal(map)) {
 				err = bpf_object__populate_internal_map(obj, map);
-				if (err < 0) {
-					zclose(map->fd);
+				if (err < 0)
 					goto err_out;
-				}
 			}
 
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
-				if (err < 0) {
-					zclose(map->fd);
+				if (err < 0)
 					goto err_out;
-				}
 			}
 		}
 
 		if (map->pin_path && !map->pinned) {
 			err = bpf_map__pin(map, NULL);
 			if (err) {
-				zclose(map->fd);
 				if (!retried && err == -EEXIST) {
 					retried = true;
 					goto retry;
@@ -7937,8 +7964,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
-	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
+	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__load_progs(obj, extra_log_level);
 	err = err ? : bpf_object_init_prog_arrays(obj);
 	err = err ? : bpf_object_prepare_struct_ops(obj);
@@ -7947,8 +7974,6 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		/* reset FDs */
 		if (obj->btf)
 			btf__set_fd(obj->btf, -1);
-		for (i = 0; i < obj->nr_maps; i++)
-			obj->maps[i].fd = -1;
 		if (!err)
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 57dec645d6878..ead99497cb157 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -569,6 +569,20 @@ static inline int ensure_good_fd(int fd)
 	return fd;
 }
 
+/* Point *fixed_fd* to the same file that *tmp_fd* points to.
+ * Regardless of success, *tmp_fd* is closed.
+ * Whatever *fixed_fd* pointed to is closed silently.
+ */
+static inline int reuse_fd(int fixed_fd, int tmp_fd)
+{
+	int err;
+
+	err = dup2(tmp_fd, fixed_fd);
+	err = err < 0 ? -errno : 0;
+	close(tmp_fd); /* clean up temporary FD */
+	return err;
+}
+
 /* The following two functions are exposed to bpftool */
 int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		       size_t local_essent_len,
-- 
2.43.0




