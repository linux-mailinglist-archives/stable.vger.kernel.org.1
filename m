Return-Path: <stable+bounces-97613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A679E2AB8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86575B273A8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37A1F8936;
	Tue,  3 Dec 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNOD1iLV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723F1F8930;
	Tue,  3 Dec 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241119; cv=none; b=sXR+adTlpvvTN8K/tgB+suwlDVB5IMeCNizabcyFoBGkIMMYvOtbAa7k/CzWNNXHbklQmodG/on9BQ8Wgge4NHws6NcbzAO1ReALVtZXc8NV8+rFdK2/m0GiXfzDikf8+UcsHnNG/tbi60x+flNN5LavY3eaw0WysmpfMbjCZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241119; c=relaxed/simple;
	bh=Gd7wJJAn6W3XdjftS7qCQ+eqYyQJ7CulU0s3NC2EmdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps1RDiRhEhKGO8fswMHqUCJMualTiLLMgCnVUhlz5ZZWxn1Cf+BYYZ9lweG67iFCQdxQZ+l7JvS/bE4aLJ3CmYrlu2GApbuKBLs/65Vaaa6AzeW6W+pm2yh6e5XB7BcpPClgfSZbY5mzW5oZEnleQb1rmP65RILv4g5WzyeIyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNOD1iLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72832C4CECF;
	Tue,  3 Dec 2024 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241119;
	bh=Gd7wJJAn6W3XdjftS7qCQ+eqYyQJ7CulU0s3NC2EmdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNOD1iLVDWwBELPkNJGrtSyLdxVr7UcorEA3cw1aCSs4kIgZnA3+HxV9z+BIJAsww
	 CaUcuSgqE0rMokFfIcxYhp7ozAqQ+qqQYqSt8BiBClTpcxRVWlhHNvbb82aG27NcGu
	 HDlzFGU8kYcnP06KK7beHxAObk56IS2aLn1u5VUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Kuohai <xukuohai@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 330/826] bpf: Add kernel symbol for struct_ops trampoline
Date: Tue,  3 Dec 2024 15:40:57 +0100
Message-ID: <20241203144756.632691817@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Kuohai <xukuohai@huawei.com>

[ Upstream commit 7c8ce4ffb684676039b1ff9ff81c126794e8d88e ]

Without kernel symbols for struct_ops trampoline, the unwinder may
produce unexpected stacktraces.

For example, the x86 ORC and FP unwinders check if an IP is in kernel
text by verifying the presence of the IP's kernel symbol. When a
struct_ops trampoline address is encountered, the unwinder stops due
to the absence of symbol, resulting in an incomplete stacktrace that
consists only of direct and indirect child functions called from the
trampoline.

The arm64 unwinder is another example. While the arm64 unwinder can
proceed across a struct_ops trampoline address, the corresponding
symbol name is displayed as "unknown", which is confusing.

Thus, add kernel symbol for struct_ops trampoline. The name is
bpf__<struct_ops_name>_<member_name>, where <struct_ops_name> is the
type name of the struct_ops, and <member_name> is the name of
the member that the trampoline is linked to.

Below is a comparison of stacktraces captured on x86 by perf record,
before and after this patch.

Before:
ffffffff8116545d __lock_acquire+0xad ([kernel.kallsyms])
ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])

After:
ffffffff811656bd __lock_acquire+0x30d ([kernel.kallsyms])
ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
ffffffff81309024 __bpf_prog_enter+0x34 ([kernel.kallsyms])
ffffffffc000d7e9 bpf__tcp_congestion_ops_cong_avoid+0x3e ([kernel.kallsyms])
ffffffff81f250a5 tcp_ack+0x10d5 ([kernel.kallsyms])
ffffffff81f27c66 tcp_rcv_established+0x3b6 ([kernel.kallsyms])
ffffffff81f3ad03 tcp_v4_do_rcv+0x193 ([kernel.kallsyms])
ffffffff81d65a18 __release_sock+0xd8 ([kernel.kallsyms])
ffffffff81d65af4 release_sock+0x34 ([kernel.kallsyms])
ffffffff81f15c4b tcp_sendmsg+0x3b ([kernel.kallsyms])
ffffffff81f663d7 inet_sendmsg+0x47 ([kernel.kallsyms])
ffffffff81d5ab40 sock_write_iter+0x160 ([kernel.kallsyms])
ffffffff8149c67b vfs_write+0x3fb ([kernel.kallsyms])
ffffffff8149caf6 ksys_write+0xc6 ([kernel.kallsyms])
ffffffff8149cb5d __x64_sys_write+0x1d ([kernel.kallsyms])
ffffffff81009200 x64_sys_call+0x1d30 ([kernel.kallsyms])
ffffffff82232d28 do_syscall_64+0x68 ([kernel.kallsyms])
ffffffff8240012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])

Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20241112145849.3436772-4-xukuohai@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h         |  3 +-
 kernel/bpf/bpf_struct_ops.c | 79 ++++++++++++++++++++++++++++++++++++-
 kernel/bpf/dispatcher.c     |  3 +-
 kernel/bpf/trampoline.c     |  9 ++++-
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e863b5d06043a..bc2e3dab0487e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1373,7 +1373,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 				struct bpf_prog *to);
 /* Called only from JIT-enabled code, so there's no need for stubs. */
-void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym);
+void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym);
+void bpf_image_ksym_add(struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5058d1536c554..b3a2ce1e5e22e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -32,6 +32,8 @@ struct bpf_struct_ops_map {
 	 * (in kvalue.data).
 	 */
 	struct bpf_link **links;
+	/* ksyms for bpf trampolines */
+	struct bpf_ksym **ksyms;
 	u32 funcs_cnt;
 	u32 image_pages_cnt;
 	/* image_pages is an array of pages that has all the trampolines
@@ -586,6 +588,49 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	return 0;
 }
 
+static void bpf_struct_ops_ksym_init(const char *tname, const char *mname,
+				     void *image, unsigned int size,
+				     struct bpf_ksym *ksym)
+{
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf__%s_%s", tname, mname);
+	INIT_LIST_HEAD_RCU(&ksym->lnode);
+	bpf_image_ksym_init(image, size, ksym);
+}
+
+static void bpf_struct_ops_map_add_ksyms(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		bpf_image_ksym_add(st_map->ksyms[i]);
+	}
+}
+
+static void bpf_struct_ops_map_del_ksyms(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		bpf_image_ksym_del(st_map->ksyms[i]);
+	}
+}
+
+static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		kfree(st_map->ksyms[i]);
+		st_map->ksyms[i] = NULL;
+	}
+}
+
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
@@ -602,6 +647,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
 	struct bpf_link **plink;
+	struct bpf_ksym **pksym;
+	const char *tname, *mname;
 
 	if (flags)
 		return -EINVAL;
@@ -641,14 +688,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	kdata = &kvalue->data;
 
 	plink = st_map->links;
+	pksym = st_map->ksyms;
+	tname = btf_name_by_offset(st_map->btf, t->name_off);
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
 		struct bpf_tramp_link *link;
+		struct bpf_ksym *ksym;
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
+		mname = btf_name_by_offset(st_map->btf, member->name_off);
 		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
@@ -718,6 +769,13 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		*plink++ = &link->link;
 
+		ksym = kzalloc(sizeof(*ksym), GFP_USER);
+		if (!ksym) {
+			err = -ENOMEM;
+			goto reset_unlock;
+		}
+		*pksym++ = ksym;
+
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[i],
@@ -737,6 +795,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
+
+		/* init ksym for this trampoline */
+		bpf_struct_ops_ksym_init(tname, mname,
+					 image + trampoline_start,
+					 image_off - trampoline_start,
+					 ksym);
 	}
 
 	if (st_ops->validate) {
@@ -785,6 +849,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 */
 
 reset_unlock:
+	bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_struct_ops_map_free_image(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
 	memset(uvalue, 0, map->value_size);
@@ -792,6 +857,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 unlock:
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
+	if (!err)
+		bpf_struct_ops_map_add_ksyms(st_map);
 	return err;
 }
 
@@ -851,7 +918,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
+	if (st_map->ksyms)
+		bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_map_area_free(st_map->links);
+	bpf_map_area_free(st_map->ksyms);
 	bpf_struct_ops_map_free_image(st_map);
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
@@ -868,6 +938,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	bpf_struct_ops_map_del_ksyms(st_map);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -980,7 +1052,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	st_map->links =
 		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_link *),
 				   NUMA_NO_NODE);
-	if (!st_map->uvalue || !st_map->links) {
+
+	st_map->ksyms =
+		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_ksym *),
+				   NUMA_NO_NODE);
+	if (!st_map->uvalue || !st_map->links || !st_map->ksyms) {
 		ret = -ENOMEM;
 		goto errout_free;
 	}
@@ -1010,6 +1086,7 @@ static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
 			vt->size - sizeof(struct bpf_struct_ops_value);
 	usage += vt->size;
 	usage += st_map->funcs_cnt * sizeof(struct bpf_link *);
+	usage += st_map->funcs_cnt * sizeof(struct bpf_ksym *);
 	usage += PAGE_SIZE;
 	return usage;
 }
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 70fb82bf16370..b77db7413f8c7 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -154,7 +154,8 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 			d->image = NULL;
 			goto out;
 		}
-		bpf_image_ksym_add(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_init(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_add(&d->ksym);
 	}
 
 	prev_num_progs = d->num_progs;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400d..1166d9dd3e8b5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -115,10 +115,14 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
-void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym)
+void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym)
 {
 	ksym->start = (unsigned long) data;
 	ksym->end = ksym->start + size;
+}
+
+void bpf_image_ksym_add(struct bpf_ksym *ksym)
+{
 	bpf_ksym_add(ksym);
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF, ksym->start,
 			   PAGE_SIZE, false, ksym->name);
@@ -377,7 +381,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
 	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
-	bpf_image_ksym_add(image, size, ksym);
+	bpf_image_ksym_init(image, size, ksym);
+	bpf_image_ksym_add(ksym);
 	return im;
 
 out_free_image:
-- 
2.43.0




