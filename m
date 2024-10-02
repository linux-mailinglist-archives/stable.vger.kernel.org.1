Return-Path: <stable+bounces-78937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA898D5B5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1871C21000
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DB1D049B;
	Wed,  2 Oct 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHmbZQHy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0F1D049A;
	Wed,  2 Oct 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875963; cv=none; b=tzFGsPF3Ud1Y9VdCupb+i2aCBxu4CNY8Ijt4HipYs3LENxEO3QP2ZA7jyVTmxsSKbz8+VEt4kIC5p/tOEl+s9pffVzEwQ4DTly02iwj49Umw+yOZEiy5o+6lFQewXgJZK4+ewHnAP5cOAH4Ekby62uiPeuxnjfXY7DHEVo+OlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875963; c=relaxed/simple;
	bh=1rKWHvGgRqwens0i+Ikrn3vheWZUtfO0xnvAQafr2ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1vWvx3Kf9NEI0gHTTqDuLwBvAx1LhmRcu0jxWrxWnaSBk7AlGB9hNyy3o0l8Cx1phxpBfkyyqN3wc8qFRrLwPppoIJZ4/7AKQCVi1uxDEreGBVPoA25PiJjV8Op8ABwd8A2++Y4C2TiK0ynIwuPPOxSd5SMrYeckDp11esPPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHmbZQHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EA8C4CEC5;
	Wed,  2 Oct 2024 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875963;
	bh=1rKWHvGgRqwens0i+Ikrn3vheWZUtfO0xnvAQafr2ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHmbZQHydTXgm/OJKO3YieYQgOu75Y1/WBagTLXlMeP/XOVBIeB/fOQbrtg3dorz0
	 5JMTrL7ZtV0O00Qowr29EYgtecOsvJZ6QeTThH1U/jT4KMZEGK0vJTgjibIsnU7/MA
	 9UbtZrtgN1Bs40Kc0+YM6NOql1ZOLucxSwXfCN74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 281/695] libbpf: Dont take direct pointers into BTF data from st_ops
Date: Wed,  2 Oct 2024 14:54:39 +0200
Message-ID: <20241002125833.662420508@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index a3be6f8fac09e..e553538874393 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -496,8 +496,6 @@ struct bpf_program {
 };
 
 struct bpf_struct_ops {
-	const char *tname;
-	const struct btf_type *type;
 	struct bpf_program **progs;
 	__u32 *kern_func_off;
 	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
@@ -1083,11 +1081,14 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
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
@@ -1121,8 +1122,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	int err;
 
 	st_ops = map->st_ops;
-	type = st_ops->type;
-	tname = st_ops->tname;
+	type = btf__type_by_id(btf, st_ops->type_id);
+	tname = btf__name_by_offset(btf, type->name_off);
 	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
@@ -1423,8 +1424,6 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
-		st_ops->type = type;
 		st_ops->type_id = type_id;
 
 		pr_debug("struct_ops init: struct %s(type_id=%u) %s found at offset %u\n",
@@ -8445,11 +8444,13 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 
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
@@ -9712,6 +9713,7 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
+	const struct btf_type *type;
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_program *prog;
@@ -9771,13 +9773,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
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




