Return-Path: <stable+bounces-147674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7438AC58B0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF57E8A819E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36C271476;
	Tue, 27 May 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqejxNcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608C1FB3;
	Tue, 27 May 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368078; cv=none; b=uz1cQNKoVKd9+6rhDOJHSd2juw0unbq0OtpL7HOS5GWXqhNKrkvi+ifGYJAdquq1w73mdnHIiMpZh9AKcNkhzQOM+ojPCoLokwwCu6nPIfwsfQuqEtVKrQqyLGYrtKrh1VHAcumEduJV+TPXEUQQVS5UQFKAe+A7omk7v1aoG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368078; c=relaxed/simple;
	bh=eJfYw1IDQjs/06BRt/xFZSkp92eMHkSxJxoGWx0mal8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uriDtxjMgoCYIU0cBZwntxG98IT+y7hXdXZRd+Qvj0d8GD8pNp1hlzAsDHV1xWsTvslW1EqhLLG+6P98lTqDc9hCITBlTyd+Q3RmVO8xSBw4dzssng8bBnRBKn1eXdlePrIP+SDGNOwTf8VATVz21U6FxCOwqEJrOTuwmCKEd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqejxNcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEBCC4CEE9;
	Tue, 27 May 2025 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368078;
	bh=eJfYw1IDQjs/06BRt/xFZSkp92eMHkSxJxoGWx0mal8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqejxNcXTdRxhM/LRLpwANn7G7Tz+swvBxmCnIDXhmBf4Y0ORW9zqZ3V9eWae+rXL
	 zPlC/S67F8jbSysQxQw5g8k8bI40GEkTabPl9wqzx5yPI+EeTabp7AdcggAbJ2nFZp
	 uwjyNM7b3oFgRuUC2gYqsOELEp8NsZXHIemA3reE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 592/783] bpf: Use kallsyms to find the function name of a struct_opss stub function
Date: Tue, 27 May 2025 18:26:29 +0200
Message-ID: <20250527162537.238811710@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 12fdd29d5d71d2987a1aec434b704d850a4d7fcb ]

In commit 1611603537a4 ("bpf: Create argument information for nullable arguments."),
it introduced a "__nullable" tagging at the argument name of a
stub function. Some background on the commit:
it requires to tag the stub function instead of directly tagging
the "ops" of a struct. This is because the btf func_proto of the "ops"
does not have the argument name and the "__nullable" is tagged at
the argument name.

To find the stub function of a "ops", it currently relies on a naming
convention on the stub function "st_ops__ops_name".
e.g. tcp_congestion_ops__ssthresh. However, the new kernel
sub system implementing bpf_struct_ops have missed this and
have been surprised that the "__nullable" and the to-be-landed
"__ref" tagging was not effective.

One option would be to give a warning whenever the stub function does
not follow the naming convention, regardless if it requires arg tagging
or not.

Instead, this patch uses the kallsyms_lookup approach and removes
the requirement on the naming convention. The st_ops->cfi_stubs has
all the stub function kernel addresses. kallsyms_lookup() is used to
lookup the function name. With the function name, BTF can be used to
find the BTF func_proto. The existing "__nullable" arg name searching
logic will then fall through.

One notable change is,
if it failed in kallsyms_lookup or it failed in looking up the stub
function name from the BTF, the bpf_struct_ops registration will fail.
This is different from the previous behavior that it silently ignored
the "st_ops__ops_name" function not found error.

The "tcp_congestion_ops", "sched_ext_ops", and "hid_bpf_ops" can still be
registered successfully after this patch. There is struct_ops_maybe_null
selftest to cover the "__nullable" tagging.

Other minor changes:
1. Removed the "%s__%s" format from the pr_warn because the naming
   convention is removed.
2. The existing bpf_struct_ops_supported() is also moved earlier
   because prepare_arg_info needs to use it to decide if the
   stub function is NULL before calling the prepare_arg_info.

Cc: Tejun Heo <tj@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/20250127222719.2544255-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 98 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 040fb1cd840b6..9b7f3b9c52622 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -146,39 +146,6 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
-#define MAX_STUB_NAME 128
-
-/* Return the type info of a stub function, if it exists.
- *
- * The name of a stub function is made up of the name of the struct_ops and
- * the name of the function pointer member, separated by "__". For example,
- * if the struct_ops type is named "foo_ops" and the function pointer
- * member is named "bar", the stub function name would be "foo_ops__bar".
- */
-static const struct btf_type *
-find_stub_func_proto(const struct btf *btf, const char *st_op_name,
-		     const char *member_name)
-{
-	char stub_func_name[MAX_STUB_NAME];
-	const struct btf_type *func_type;
-	s32 btf_id;
-	int cp;
-
-	cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
-		      st_op_name, member_name);
-	if (cp >= MAX_STUB_NAME) {
-		pr_warn("Stub function name too long\n");
-		return NULL;
-	}
-	btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
-	if (btf_id < 0)
-		return NULL;
-	func_type = btf_type_by_id(btf, btf_id);
-	if (!func_type)
-		return NULL;
-
-	return btf_type_by_id(btf, func_type->type); /* FUNC_PROTO */
-}
 
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
@@ -203,27 +170,42 @@ find_stub_func_proto(const struct btf *btf, const char *st_op_name,
 static int prepare_arg_info(struct btf *btf,
 			    const char *st_ops_name,
 			    const char *member_name,
-			    const struct btf_type *func_proto,
+			    const struct btf_type *func_proto, void *stub_func_addr,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
+	char ksym[KSYM_SYMBOL_LEN];
+	const char *stub_fname;
+	s32 stub_func_id;
 	u32 arg_btf_id;
 	int offset;
 
-	stub_func_proto = find_stub_func_proto(btf, st_ops_name, member_name);
-	if (!stub_func_proto)
-		return 0;
+	stub_fname = kallsyms_lookup((unsigned long)stub_func_addr, NULL, NULL, NULL, ksym);
+	if (!stub_fname) {
+		pr_warn("Cannot find the stub function name for the %s in struct %s\n",
+			member_name, st_ops_name);
+		return -ENOENT;
+	}
+
+	stub_func_id = btf_find_by_name_kind(btf, stub_fname, BTF_KIND_FUNC);
+	if (stub_func_id < 0) {
+		pr_warn("Cannot find the stub function %s in btf\n", stub_fname);
+		return -ENOENT;
+	}
+
+	stub_func_proto = btf_type_by_id(btf, stub_func_id);
+	stub_func_proto = btf_type_by_id(btf, stub_func_proto->type);
 
 	/* Check if the number of arguments of the stub function is the same
 	 * as the number of arguments of the function pointer.
 	 */
 	nargs = btf_type_vlen(func_proto);
 	if (nargs != btf_type_vlen(stub_func_proto)) {
-		pr_warn("the number of arguments of the stub function %s__%s does not match the number of arguments of the member %s of struct %s\n",
-			st_ops_name, member_name, member_name, st_ops_name);
+		pr_warn("the number of arguments of the stub function %s does not match the number of arguments of the member %s of struct %s\n",
+			stub_fname, member_name, st_ops_name);
 		return -EINVAL;
 	}
 
@@ -253,21 +235,21 @@ static int prepare_arg_info(struct btf *btf,
 						    &arg_btf_id);
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
-			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
-				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+			pr_warn("stub function %s has %s tagging to an unsupported type\n",
+				stub_fname, MAYBE_NULL_SUFFIX);
 			goto err_out;
 		}
 
 		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
 		if (offset < 0) {
-			pr_warn("stub function %s__%s has an invalid trampoline ctx offset for arg#%u\n",
-				st_ops_name, member_name, arg_no);
+			pr_warn("stub function %s has an invalid trampoline ctx offset for arg#%u\n",
+				stub_fname, arg_no);
 			goto err_out;
 		}
 
 		if (args[arg_no].type != stub_args[arg_no].type) {
-			pr_warn("arg#%u type in stub function %s__%s does not match with its original func_proto\n",
-				arg_no, st_ops_name, member_name);
+			pr_warn("arg#%u type in stub function %s does not match with its original func_proto\n",
+				arg_no, stub_fname);
 			goto err_out;
 		}
 
@@ -324,6 +306,13 @@ static bool is_module_member(const struct btf *btf, u32 id)
 	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
 }
 
+int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
+{
+	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
+
+	return func_ptr ? 0 : -ENOTSUPP;
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
@@ -387,7 +376,10 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
+		void **stub_func_addr;
+		u32 moff;
 
+		moff = __btf_member_bit_offset(t, member) / 8;
 		mname = btf_name_by_offset(btf, member->name_off);
 		if (!*mname) {
 			pr_warn("anon member in struct %s is not supported\n",
@@ -413,7 +405,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		func_proto = btf_type_resolve_func_ptr(btf,
 						       member->type,
 						       NULL);
-		if (!func_proto)
+
+		/* The member is not a function pointer or
+		 * the function pointer is not supported.
+		 */
+		if (!func_proto || bpf_struct_ops_supported(st_ops, moff))
 			continue;
 
 		if (btf_distill_func_proto(log, btf,
@@ -425,8 +421,9 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			goto errout;
 		}
 
+		stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
 		err = prepare_arg_info(btf, st_ops->name, mname,
-				       func_proto,
+				       func_proto, stub_func_addr,
 				       arg_info + i);
 		if (err)
 			goto errout;
@@ -1152,13 +1149,6 @@ void bpf_struct_ops_put(const void *kdata)
 	bpf_map_put(&st_map->map);
 }
 
-int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
-{
-	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
-
-	return func_ptr ? 0 : -ENOTSUPP;
-}
-
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-- 
2.39.5




