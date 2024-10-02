Return-Path: <stable+bounces-80208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9996498DC6F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52193282449
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EA1D1312;
	Wed,  2 Oct 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7nLIFoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBFB1D0E06;
	Wed,  2 Oct 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879700; cv=none; b=guNcvVqzbjoGRRAmZ5Y1WlOdMdVtpKSk/Oq5uDtSemheBReo8xaSPsIEfXp5G47Y7OZKqPndZ9z8xBYjZF6j9N3bhmnwYeNAfE4LwhEmVavfVnHAb5ZCejhk51FM8vmPCHeJ4bsNbP/qn4HpyAxCI7pI8DR+xdHfBzwC37XbcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879700; c=relaxed/simple;
	bh=FSNzPXwU7xcVPyUe3EKjvVL/nYDLjxp9f9DsQb/g6q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMGUy2tYnP2ETqZAvMSIJ/XeT9EBeTQMn8oW/VmGSzhc9Niz/nAtzZJRVk/myNPkaNntZMrLLCnAgRq4llnU4CuKTOH8WwcNwYIot4Od7RBMdgOYXRIRvh5IObeBwX3Gy4z94iaKSzp3bK2tAM2xZBaerbmpTken8El8uHOz/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7nLIFoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65001C4CECF;
	Wed,  2 Oct 2024 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879699;
	bh=FSNzPXwU7xcVPyUe3EKjvVL/nYDLjxp9f9DsQb/g6q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z7nLIFoYdhoHcTZQGvY2HKJGi1Sm6r/zQyiqwZoUakQE+M33Xws2tayxTqF/yyprx
	 mDPJHPMW1W7YW79aVAC7I672xqqQDSalR4eJi2cYAH/jMPg+YUsCw+gs5yMmDy0Twd
	 +aW45ucpz9kNP/vGfPoVoUDx8KFC9wJDfeaP3e3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 209/538] libbpf: Find correct module BTFs for struct_ops maps and progs.
Date: Wed,  2 Oct 2024 14:57:28 +0200
Message-ID: <20241002125800.507563328@linuxfoundation.org>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

[ Upstream commit 9e926acda0c2e21bca431a1818665ddcd6939755 ]

Locate the module BTFs for struct_ops maps and progs and pass them to the
kernel. This ensures that the kernel correctly resolves type IDs from the
appropriate module BTFs.

For the map of a struct_ops object, the FD of the module BTF is set to
bpf_map to keep a reference to the module BTF. The FD is passed to the
kernel as value_type_btf_obj_fd when the struct_ops object is loaded.

For a bpf_struct_ops prog, attach_btf_obj_fd of bpf_prog is the FD of a
module BTF in the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240119225005.668602-13-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 04a94133f1b3 ("libbpf: Don't take direct pointers into BTF data from st_ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.c           |  4 +++-
 tools/lib/bpf/bpf.h           |  4 +++-
 tools/lib/bpf/libbpf.c        | 41 ++++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf_probes.c |  1 +
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a33..ee18aea4a7b58 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr,
+					   value_type_btf_obj_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -191,6 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
 	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
 	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
+	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, -1);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 107fef7488682..db0ff8ade19a4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+	__s32 value_type_btf_obj_fd;
+	size_t:0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field value_type_btf_obj_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 54f3380010f55..a2b765e419c16 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -518,6 +518,7 @@ struct bpf_map {
 	struct bpf_map_def def;
 	__u32 numa_node;
 	__u32 btf_var_idx;
+	int mod_btf_fd;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
@@ -918,22 +919,29 @@ find_member_by_name(const struct btf *btf, const struct btf_type *t,
 	return NULL;
 }
 
+static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
+			    __u16 kind, struct btf **res_btf,
+			    struct module_btf **res_mod_btf);
+
 #define STRUCT_OPS_VALUE_PREFIX "bpf_struct_ops_"
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(const struct btf *btf, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
 			   const struct btf_member **data_member)
 {
 	const struct btf_type *kern_type, *kern_vtype;
 	const struct btf_member *kern_data_member;
+	struct btf *btf;
 	__s32 kern_vtype_id, kern_type_id;
 	__u32 i;
 
-	kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
+					&btf, mod_btf);
 	if (kern_type_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
 			tname);
@@ -987,14 +995,16 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
 }
 
 /* Init the map's fields that depend on kern_btf */
-static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
-					 const struct btf *btf,
-					 const struct btf *kern_btf)
+static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 {
 	const struct btf_member *member, *kern_member, *kern_data_member;
 	const struct btf_type *type, *kern_type, *kern_vtype;
 	__u32 i, kern_type_id, kern_vtype_id, kern_data_off;
+	struct bpf_object *obj = map->obj;
+	const struct btf *btf = obj->btf;
 	struct bpf_struct_ops *st_ops;
+	const struct btf *kern_btf;
+	struct module_btf *mod_btf;
 	void *data, *kern_data;
 	const char *tname;
 	int err;
@@ -1002,16 +1012,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 	st_ops = map->st_ops;
 	type = st_ops->type;
 	tname = st_ops->tname;
-	err = find_struct_ops_kern_types(kern_btf, tname,
+	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
 					 &kern_data_member);
 	if (err)
 		return err;
 
+	kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
+
 	pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u kern_vtype_id:%u\n",
 		 map->name, st_ops->type_id, kern_type_id, kern_vtype_id);
 
+	map->mod_btf_fd = mod_btf ? mod_btf->fd : -1;
 	map->def.value_size = kern_vtype->size;
 	map->btf_vmlinux_value_type_id = kern_vtype_id;
 
@@ -1087,6 +1100,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 				return -ENOTSUP;
 			}
 
+			if (mod_btf)
+				prog->attach_btf_obj_fd = mod_btf->fd;
 			prog->attach_btf_id = kern_type_id;
 			prog->expected_attach_type = kern_member_idx;
 
@@ -1129,8 +1144,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
-		err = bpf_map__init_kern_struct_ops(map, obj->btf,
-						    obj->btf_vmlinux);
+		err = bpf_map__init_kern_struct_ops(map);
 		if (err)
 			return err;
 	}
@@ -5133,8 +5147,13 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+		if (map->mod_btf_fd >= 0) {
+			create_attr.value_type_btf_obj_fd = map->mod_btf_fd;
+			create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
+		}
+	}
 
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
@@ -9444,7 +9463,9 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		*btf_obj_fd = 0;
 		*btf_type_id = 1;
 	} else {
-		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+		err = find_kernel_btf_id(prog->obj, attach_name,
+					 attach_type, btf_obj_fd,
+					 btf_type_id);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6b..98373d126d9d7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -326,6 +326,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 		/* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
 		opts.btf_vmlinux_value_type_id = 1;
+		opts.value_type_btf_obj_fd = -1;
 		exp_err = -524; /* -ENOTSUPP */
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-- 
2.43.0




