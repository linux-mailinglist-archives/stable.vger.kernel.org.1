Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAD6FA7EE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjEHKgS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjEHKft (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630728AB9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D096F6273F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A6DC433EF;
        Mon,  8 May 2023 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542119;
        bh=D9AqLfbiGcBIkHtjTKiSKWpAgYGMwz0ajUgTA9NumfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDHhE2xgyqLFHQleSrKl3qe+LppEdwdZdagpCjat8rtHzeS6REWu8XK1KL5M941BH
         SUxgaNXetdpCH3o2T+kd+lNIaZvg4s5H2eoPCwCXqlm5d70SLcgbje/LE0/ZSytSIl
         nnJ3wXQ42zCNwDsPHSadsy4N4qK/IvGTpPg+sfRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 332/663] bpf: Add basic bpf_rb_{root,node} support
Date:   Mon,  8 May 2023 11:42:38 +0200
Message-Id: <20230508094438.946624597@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 9c395c1b99bd23f74bc628fa000480c49593d17f ]

This patch adds special BPF_RB_{ROOT,NODE} btf_field_types similar to
BPF_LIST_{HEAD,NODE}, adds the necessary plumbing to detect the new
types, and adds bpf_rb_root_free function for freeing bpf_rb_root in
map_values.

structs bpf_rb_root and bpf_rb_node are opaque types meant to
obscure structs rb_root_cached rb_node, respectively.

btf_struct_access will prevent BPF programs from touching these special
fields automatically now that they're recognized.

btf_check_and_fixup_fields now groups list_head and rb_root together as
"graph root" fields and {list,rb}_node as "graph node", and does same
ownership cycle checking as before. Note that this function does _not_
prevent ownership type mixups (e.g. rb_root owning list_node) - that's
handled by btf_parse_graph_root.

After this patch, a bpf program can have a struct bpf_rb_root in a
map_value, but not add anything to nor do anything useful with it.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230214004017.2534011-2-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: f6a6a5a97628 ("bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h                           |  20 ++-
 include/uapi/linux/bpf.h                      |  11 ++
 kernel/bpf/btf.c                              | 162 ++++++++++++------
 kernel/bpf/helpers.c                          |  40 +++++
 kernel/bpf/syscall.c                          |  28 ++-
 kernel/bpf/verifier.c                         |   5 +-
 tools/include/uapi/linux/bpf.h                |  11 ++
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +-
 8 files changed, 216 insertions(+), 73 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 69b4b623ff06b..1c88f6761eea3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -180,7 +180,10 @@ enum btf_field_type {
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  = (1 << 4),
 	BPF_LIST_NODE  = (1 << 5),
-	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD,
+	BPF_RB_ROOT    = (1 << 6),
+	BPF_RB_NODE    = (1 << 7),
+	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD |
+				 BPF_RB_NODE | BPF_RB_ROOT,
 };
 
 struct btf_field_kptr {
@@ -284,6 +287,10 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
 		return "bpf_list_node";
+	case BPF_RB_ROOT:
+		return "bpf_rb_root";
+	case BPF_RB_NODE:
+		return "bpf_rb_node";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -304,6 +311,10 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return sizeof(struct bpf_list_node);
+	case BPF_RB_ROOT:
+		return sizeof(struct bpf_rb_root);
+	case BPF_RB_NODE:
+		return sizeof(struct bpf_rb_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -324,6 +335,10 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return __alignof__(struct bpf_list_node);
+	case BPF_RB_ROOT:
+		return __alignof__(struct bpf_rb_root);
+	case BPF_RB_NODE:
+		return __alignof__(struct bpf_rb_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -441,6 +456,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
+		      struct bpf_spin_lock *spin_lock);
+
 
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 464ca3f01fe7a..bd260134c4201 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6901,6 +6901,17 @@ struct bpf_list_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_rb_root {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_rb_node {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b38b3335cd1e7..70ab572f81bc7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3305,12 +3305,14 @@ static const char *btf_find_decl_tag_value(const struct btf *btf,
 	return NULL;
 }
 
-static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
-			      const struct btf_type *t, int comp_idx,
-			      u32 off, int sz, struct btf_field_info *info)
+static int
+btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
+		    const struct btf_type *t, int comp_idx, u32 off,
+		    int sz, struct btf_field_info *info,
+		    enum btf_field_type head_type)
 {
+	const char *node_field_name;
 	const char *value_type;
-	const char *list_node;
 	s32 id;
 
 	if (!__btf_type_is_struct(t))
@@ -3320,26 +3322,32 @@ static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
 	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
 	if (!value_type)
 		return -EINVAL;
-	list_node = strstr(value_type, ":");
-	if (!list_node)
+	node_field_name = strstr(value_type, ":");
+	if (!node_field_name)
 		return -EINVAL;
-	value_type = kstrndup(value_type, list_node - value_type, GFP_KERNEL | __GFP_NOWARN);
+	value_type = kstrndup(value_type, node_field_name - value_type, GFP_KERNEL | __GFP_NOWARN);
 	if (!value_type)
 		return -ENOMEM;
 	id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
 	kfree(value_type);
 	if (id < 0)
 		return id;
-	list_node++;
-	if (str_is_empty(list_node))
+	node_field_name++;
+	if (str_is_empty(node_field_name))
 		return -EINVAL;
-	info->type = BPF_LIST_HEAD;
+	info->type = head_type;
 	info->off = off;
 	info->graph_root.value_btf_id = id;
-	info->graph_root.node_name = list_node;
+	info->graph_root.node_name = node_field_name;
 	return BTF_FIELD_FOUND;
 }
 
+#define field_mask_test_name(field_type, field_type_str) \
+	if (field_mask & field_type && !strcmp(name, field_type_str)) { \
+		type = field_type;					\
+		goto end;						\
+	}
+
 static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			      int *align, int *sz)
 {
@@ -3363,18 +3371,11 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			goto end;
 		}
 	}
-	if (field_mask & BPF_LIST_HEAD) {
-		if (!strcmp(name, "bpf_list_head")) {
-			type = BPF_LIST_HEAD;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_LIST_NODE) {
-		if (!strcmp(name, "bpf_list_node")) {
-			type = BPF_LIST_NODE;
-			goto end;
-		}
-	}
+	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
+	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
+	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
+	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
+
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & BPF_KPTR) {
 		type = BPF_KPTR_REF;
@@ -3387,6 +3388,8 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 	return type;
 }
 
+#undef field_mask_test_name
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
@@ -3419,6 +3422,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3432,8 +3436,11 @@ static int btf_find_struct_field(const struct btf *btf,
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
-			ret = btf_find_list_head(btf, t, member_type, i, off, sz,
-						 idx < info_cnt ? &info[idx] : &tmp);
+		case BPF_RB_ROOT:
+			ret = btf_find_graph_root(btf, t, member_type,
+						  i, off, sz,
+						  idx < info_cnt ? &info[idx] : &tmp,
+						  field_type);
 			if (ret < 0)
 				return ret;
 			break;
@@ -3480,6 +3487,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3493,8 +3501,11 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
-			ret = btf_find_list_head(btf, var, var_type, -1, off, sz,
-						 idx < info_cnt ? &info[idx] : &tmp);
+		case BPF_RB_ROOT:
+			ret = btf_find_graph_root(btf, var, var_type,
+						  -1, off, sz,
+						  idx < info_cnt ? &info[idx] : &tmp,
+						  field_type);
 			if (ret < 0)
 				return ret;
 			break;
@@ -3596,8 +3607,11 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 	return ret;
 }
 
-static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
-			       struct btf_field_info *info)
+static int btf_parse_graph_root(const struct btf *btf,
+				struct btf_field *field,
+				struct btf_field_info *info,
+				const char *node_type_name,
+				size_t node_type_align)
 {
 	const struct btf_type *t, *n = NULL;
 	const struct btf_member *member;
@@ -3619,13 +3633,13 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
 		n = btf_type_by_id(btf, member->type);
 		if (!__btf_type_is_struct(n))
 			return -EINVAL;
-		if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
+		if (strcmp(node_type_name, __btf_name_by_offset(btf, n->name_off)))
 			return -EINVAL;
 		offset = __btf_member_bit_offset(n, member);
 		if (offset % 8)
 			return -EINVAL;
 		offset /= 8;
-		if (offset % __alignof__(struct bpf_list_node))
+		if (offset % node_type_align)
 			return -EINVAL;
 
 		field->graph_root.btf = (struct btf *)btf;
@@ -3637,6 +3651,20 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
 	return 0;
 }
 
+static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
+			       struct btf_field_info *info)
+{
+	return btf_parse_graph_root(btf, field, info, "bpf_list_node",
+					    __alignof__(struct bpf_list_node));
+}
+
+static int btf_parse_rb_root(const struct btf *btf, struct btf_field *field,
+			     struct btf_field_info *info)
+{
+	return btf_parse_graph_root(btf, field, info, "bpf_rb_node",
+					    __alignof__(struct bpf_rb_node));
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
@@ -3699,7 +3727,13 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_RB_ROOT:
+			ret = btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			break;
 		default:
 			ret = -EFAULT;
@@ -3708,8 +3742,9 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->cnt++;
 	}
 
-	/* bpf_list_head requires bpf_spin_lock */
-	if (btf_record_has_field(rec, BPF_LIST_HEAD) && rec->spin_lock_off < 0) {
+	/* bpf_{list_head, rb_node} require bpf_spin_lock */
+	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
+	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0) {
 		ret = -EINVAL;
 		goto end;
 	}
@@ -3720,22 +3755,28 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+#define GRAPH_ROOT_MASK (BPF_LIST_HEAD | BPF_RB_ROOT)
+#define GRAPH_NODE_MASK (BPF_LIST_NODE | BPF_RB_NODE)
+
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 {
 	int i;
 
-	/* There are two owning types, kptr_ref and bpf_list_head. The former
-	 * only supports storing kernel types, which can never store references
-	 * to program allocated local types, atleast not yet. Hence we only need
-	 * to ensure that bpf_list_head ownership does not form cycles.
+	/* There are three types that signify ownership of some other type:
+	 *  kptr_ref, bpf_list_head, bpf_rb_root.
+	 * kptr_ref only supports storing kernel types, which can't store
+	 * references to program allocated local types.
+	 *
+	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
+	 * does not form cycles.
 	 */
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_LIST_HEAD))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & GRAPH_ROOT_MASK))
 		return 0;
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
 		u32 btf_id;
 
-		if (!(rec->fields[i].type & BPF_LIST_HEAD))
+		if (!(rec->fields[i].type & GRAPH_ROOT_MASK))
 			continue;
 		btf_id = rec->fields[i].graph_root.value_btf_id;
 		meta = btf_find_struct_meta(btf, btf_id);
@@ -3743,39 +3784,47 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 			return -EFAULT;
 		rec->fields[i].graph_root.value_rec = meta->record;
 
-		if (!(rec->field_mask & BPF_LIST_NODE))
+		/* We need to set value_rec for all root types, but no need
+		 * to check ownership cycle for a type unless it's also a
+		 * node type.
+		 */
+		if (!(rec->field_mask & GRAPH_NODE_MASK))
 			continue;
 
 		/* We need to ensure ownership acyclicity among all types. The
 		 * proper way to do it would be to topologically sort all BTF
 		 * IDs based on the ownership edges, since there can be multiple
-		 * bpf_list_head in a type. Instead, we use the following
-		 * reasoning:
+		 * bpf_{list_head,rb_node} in a type. Instead, we use the
+		 * following resaoning:
 		 *
 		 * - A type can only be owned by another type in user BTF if it
-		 *   has a bpf_list_node.
+		 *   has a bpf_{list,rb}_node. Let's call these node types.
 		 * - A type can only _own_ another type in user BTF if it has a
-		 *   bpf_list_head.
+		 *   bpf_{list_head,rb_root}. Let's call these root types.
 		 *
-		 * We ensure that if a type has both bpf_list_head and
-		 * bpf_list_node, its element types cannot be owning types.
+		 * We ensure that if a type is both a root and node, its
+		 * element types cannot be root types.
 		 *
 		 * To ensure acyclicity:
 		 *
-		 * When A only has bpf_list_head, ownership chain can be:
+		 * When A is an root type but not a node, its ownership
+		 * chain can be:
 		 *	A -> B -> C
 		 * Where:
-		 * - B has both bpf_list_head and bpf_list_node.
-		 * - C only has bpf_list_node.
+		 * - A is an root, e.g. has bpf_rb_root.
+		 * - B is both a root and node, e.g. has bpf_rb_node and
+		 *   bpf_list_head.
+		 * - C is only an root, e.g. has bpf_list_node
 		 *
-		 * When A has both bpf_list_head and bpf_list_node, some other
-		 * type already owns it in the BTF domain, hence it can not own
-		 * another owning type through any of the bpf_list_head edges.
+		 * When A is both a root and node, some other type already
+		 * owns it in the BTF domain, hence it can not own
+		 * another root type through any of the ownership edges.
 		 *	A -> B
 		 * Where:
-		 * - B only has bpf_list_node.
+		 * - A is both an root and node.
+		 * - B is only an node.
 		 */
-		if (meta->record->field_mask & BPF_LIST_HEAD)
+		if (meta->record->field_mask & GRAPH_ROOT_MASK)
 			return -ELOOP;
 	}
 	return 0;
@@ -5238,6 +5287,8 @@ static const char *alloc_obj_fields[] = {
 	"bpf_spin_lock",
 	"bpf_list_head",
 	"bpf_list_node",
+	"bpf_rb_root",
+	"bpf_rb_node",
 };
 
 static struct btf_struct_metas *
@@ -5311,7 +5362,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
-		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
+		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
+						  BPF_RB_ROOT | BPF_RB_NODE, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 527040ffead41..92a57cc106656 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1761,6 +1761,46 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	}
 }
 
+/* Like rbtree_postorder_for_each_entry_safe, but 'pos' and 'n' are
+ * 'rb_node *', so field name of rb_node within containing struct is not
+ * needed.
+ *
+ * Since bpf_rb_tree's node type has a corresponding struct btf_field with
+ * graph_root.node_offset, it's not necessary to know field name
+ * or type of node struct
+ */
+#define bpf_rbtree_postorder_for_each_entry_safe(pos, n, root) \
+	for (pos = rb_first_postorder(root); \
+	    pos && ({ n = rb_next_postorder(pos); 1; }); \
+	    pos = n)
+
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
+		      struct bpf_spin_lock *spin_lock)
+{
+	struct rb_root_cached orig_root, *root = rb_root;
+	struct rb_node *pos, *n;
+	void *obj;
+
+	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
+	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
+
+	__bpf_spin_lock_irqsave(spin_lock);
+	orig_root = *root;
+	*root = RB_ROOT_CACHED;
+	__bpf_spin_unlock_irqrestore(spin_lock);
+
+	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
+		obj = pos;
+		obj -= field->graph_root.node_offset;
+
+		bpf_obj_free_fields(field->graph_root.value_rec, obj);
+
+		migrate_disable();
+		bpf_mem_free(&bpf_global_ma, obj);
+		migrate_enable();
+	}
+}
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ecca9366c7a6f..011983b39472f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -527,9 +527,6 @@ void btf_record_free(struct btf_record *rec)
 		return;
 	for (i = 0; i < rec->cnt; i++) {
 		switch (rec->fields[i].type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			if (rec->fields[i].kptr.module)
@@ -538,7 +535,11 @@ void btf_record_free(struct btf_record *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
-			/* Nothing to release for bpf_list_head */
+		case BPF_RB_ROOT:
+		case BPF_RB_NODE:
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			/* Nothing to release */
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -571,9 +572,6 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 	new_rec->cnt = 0;
 	for (i = 0; i < rec->cnt; i++) {
 		switch (fields[i].type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			btf_get(fields[i].kptr.btf);
@@ -584,7 +582,11 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
-			/* Nothing to acquire for bpf_list_head */
+		case BPF_RB_ROOT:
+		case BPF_RB_NODE:
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			/* Nothing to acquire */
 			break;
 		default:
 			ret = -EFAULT;
@@ -664,7 +666,13 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				continue;
 			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
+		case BPF_RB_ROOT:
+			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
+				continue;
+			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
+			break;
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1005,7 +1013,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		return -EINVAL;
 
 	map->record = btf_parse_fields(btf, value_type,
-				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
+				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
+				       BPF_RB_ROOT,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1053,6 +1062,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				}
 				break;
 			case BPF_LIST_HEAD:
+			case BPF_RB_ROOT:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7c2c048807c0..975f30e4f8612 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14583,9 +14583,10 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
-	if (btf_record_has_field(map->record, BPF_LIST_HEAD)) {
+	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
+	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
 			return -EINVAL;
 		}
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 464ca3f01fe7a..bd260134c4201 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6901,6 +6901,17 @@ struct bpf_list_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_rb_root {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_rb_node {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2592b8aa5e41a..c456b34a823ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -58,12 +58,12 @@ static struct {
 	TEST(inner_map, pop_front)
 	TEST(inner_map, pop_back)
 #undef TEST
-	{ "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_kprobe", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_kretprobe", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_tp", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_perf", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_raw_tp", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struct" },
-- 
2.39.2



