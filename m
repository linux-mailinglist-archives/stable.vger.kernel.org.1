Return-Path: <stable+bounces-79616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383198D962
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D7CB24681
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181DA1D0F44;
	Wed,  2 Oct 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i2yh0dCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCE1D07AD;
	Wed,  2 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877962; cv=none; b=ExheqcoawJfyeFP714MYFvs+EuMycBn4Awq5cbIY3oy/uF/rs/PfvAroQ5lzTPUp7ktBVSGkLcNrFjgPK8nFYH0GUVLkK4MBi8pf36W2lHae+nDaXNsOIjmmrQ0ow+fbSlBh8KjNG00sLWs0moaL/e8RnVqLuWaJIuA3zpQ1wYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877962; c=relaxed/simple;
	bh=AfUHsa5R2x7Er5ykYffHeSHzQHL91uoSWXniqqGw2cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/uZ/cXeOXZuKKBxlGAmJkLzPrycuTscAa3qwxBhGj7+kBQxOaZ3JeAquy7cyl3Hh/8Y39cvofnBBKnKLBhr0qu5kRGjIEQfvtmoz0uCNgBj2mBD0aX/bquHbEJJLgeRqPSAZG3NpLBSl1STRnfVswgBQTU/5tEIbBZgKRSgqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i2yh0dCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52737C4CEC2;
	Wed,  2 Oct 2024 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877962;
	bh=AfUHsa5R2x7Er5ykYffHeSHzQHL91uoSWXniqqGw2cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2yh0dCXrkArTUBDLyrtIFQXcd5LrNb3LmhB3WQLbD+R7gVf1YWdLOakhuYJCcb5W
	 P+qzqINZIQLHbechUq4pyYfrrRtEfWN86s9Fj5YnqHzGeqvdhD8e6GLBsi9zO+kuvj
	 RDMgeoVD+s/yB0I1CcH8ltDrOhlVVMCWam1p0+/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 254/634] libbpf: Dont take direct pointers into BTF data from st_ops
Date: Wed,  2 Oct 2024 14:55:54 +0200
Message-ID: <20241002125821.124250538@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Vernet <void@manifault.com>

[ Upstream commit 04a94133f1b3cccb19e056c26f056c50b4e5b3b1 ]

In struct bpf_struct_ops, we have take a pointer to a BTF type name, and
a struct btf_type. This was presumably done for convenience, but can
actually result in subtle and confusing bugs given that BTF data can be
invalidated before a program is loaded. For example, in sched_ext, we
may sometimes resize a data section after a skeleton has been opened,
but before the struct_ops scheduler map has been loaded. This may cause
the BTF data to be realloc'd, which can then cause a UAF when loading
the program because the struct_ops map has pointers directly into the
BTF data.

We're already storing the BTF type_id in struct bpf_struct_ops. Because
type_id is stable, we can therefore just update the places where we were
looking at those pointers to instead do the lookups we need from the
type_id.

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240724171459.281234-1-void@manifault.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5edb717647847..31f58e3c4059c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -473,8 +473,6 @@ struct bpf_program {
 };
 
 struct bpf_struct_ops {
-	const char *tname;
-	const struct btf_type *type;
 	struct bpf_program **progs;
 	__u32 *kern_func_off;
 	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
@@ -1059,11 +1057,14 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			continue;
 
 		for (j = 0; j < obj->nr_maps; ++j) {
+			const struct btf_type *type;
+
 			map = &obj->maps[j];
 			if (!bpf_map__is_struct_ops(map))
 				continue;
 
-			vlen = btf_vlen(map->st_ops->type);
+			type = btf__type_by_id(obj->btf, map->st_ops->type_id);
+			vlen = btf_vlen(type);
 			for (k = 0; k < vlen; ++k) {
 				slot_prog = map->st_ops->progs[k];
 				if (prog != slot_prog)
@@ -1097,8 +1098,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	int err;
 
 	st_ops = map->st_ops;
-	type = st_ops->type;
-	tname = st_ops->tname;
+	type = btf__type_by_id(btf, st_ops->type_id);
+	tname = btf__name_by_offset(btf, type->name_off);
 	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
@@ -1398,8 +1399,6 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
-		st_ops->type = type;
 		st_ops->type_id = type_id;
 
 		pr_debug("struct_ops init: struct %s(type_id=%u) %s found at offset %u\n",
@@ -8406,11 +8405,13 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 
 static void bpf_map_prepare_vdata(const struct bpf_map *map)
 {
+	const struct btf_type *type;
 	struct bpf_struct_ops *st_ops;
 	__u32 i;
 
 	st_ops = map->st_ops;
-	for (i = 0; i < btf_vlen(st_ops->type); i++) {
+	type = btf__type_by_id(map->obj->btf, st_ops->type_id);
+	for (i = 0; i < btf_vlen(type); i++) {
 		struct bpf_program *prog = st_ops->progs[i];
 		void *kern_data;
 		int prog_fd;
@@ -9673,6 +9674,7 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
+	const struct btf_type *type;
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_program *prog;
@@ -9732,13 +9734,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		}
 		insn_idx = sym->st_value / BPF_INSN_SZ;
 
-		member = find_member_by_offset(st_ops->type, moff * 8);
+		type = btf__type_by_id(btf, st_ops->type_id);
+		member = find_member_by_offset(type, moff * 8);
 		if (!member) {
 			pr_warn("struct_ops reloc %s: cannot find member at moff %u\n",
 				map->name, moff);
 			return -EINVAL;
 		}
-		member_idx = member - btf_members(st_ops->type);
+		member_idx = member - btf_members(type);
 		name = btf__name_by_offset(btf, member->name_off);
 
 		if (!resolve_func_ptr(btf, member->type, NULL)) {
-- 
2.43.0




