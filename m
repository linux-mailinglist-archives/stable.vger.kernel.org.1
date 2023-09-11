Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882279BD7A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjIKUvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbjIKOeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:34:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE8E4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:33:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E7EC433C7;
        Mon, 11 Sep 2023 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442837;
        bh=hKWinUgWL/fSSilsNXlHPSf46PyCIOLgCmwVLr6e+ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v391dLlv9yIy9ggnPfXSrCtbXr9VXH0xAH/Sg+54hqEljNhm6VKqx3WPABc1hrfqH
         /QjkTShJySDk3m4dcttDI/umvE9dUaqcNygF7J7Cv+/Fd04Jxh03vl469/XFxkt/FG
         P2J5b56Gbj5dVGD+z844wssyoiujEBphdZHp4Irk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 148/737] bpf: Fix an error around PTR_UNTRUSTED
Date:   Mon, 11 Sep 2023 15:40:07 +0200
Message-ID: <20230911134654.624103508@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 7ce4dc3e4a9d954c8a1fb483c7a527e9b060b860 ]

Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
cleared when we start to walk a new struct, because the struct in
question may be a struct nested in a union. We should also check and set
this flag before we walk its each member, in case itself is a union.
We will clear this flag if the field is BTF_TYPE_SAFE_RCU_OR_NULL.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lore.kernel.org/r/20230713025642.27477-2-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c      | 20 +++++++++-----------
 kernel/bpf/verifier.c |  5 +++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8b4e92439d1d6..5dd8534b778d1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6126,7 +6126,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	const char *tname, *mname, *tag_value;
 	u32 vlen, elem_id, mid;
 
-	*flag = 0;
 again:
 	tname = __btf_name_by_offset(btf, t->name_off);
 	if (!btf_type_is_struct(t)) {
@@ -6135,6 +6134,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	}
 
 	vlen = btf_type_vlen(t);
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNION && vlen != 1 && !(*flag & PTR_UNTRUSTED))
+		/*
+		 * walking unions yields untrusted pointers
+		 * with exception of __bpf_md_ptr and other
+		 * unions with a single member
+		 */
+		*flag |= PTR_UNTRUSTED;
+
 	if (off + size > t->size) {
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
@@ -6295,15 +6302,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * of this field or inside of this struct
 		 */
 		if (btf_type_is_struct(mtype)) {
-			if (BTF_INFO_KIND(mtype->info) == BTF_KIND_UNION &&
-			    btf_type_vlen(mtype) != 1)
-				/*
-				 * walking unions yields untrusted pointers
-				 * with exception of __bpf_md_ptr and other
-				 * unions with a single member
-				 */
-				*flag |= PTR_UNTRUSTED;
-
 			/* our field must be inside that union or struct */
 			t = mtype;
 
@@ -6469,7 +6467,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  bool strict)
 {
 	const struct btf_type *type;
-	enum bpf_type_flag flag;
+	enum bpf_type_flag flag = 0;
 	int err;
 
 	/* Are we already done? */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbfe1d086467..cef173614fc8f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5893,6 +5893,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   type_is_rcu_or_null(env, reg, field_name, btf_id)) {
 				/* __rcu tagged pointers can be NULL */
 				flag |= MEM_RCU | PTR_MAYBE_NULL;
+
+				/* We always trust them */
+				if (type_is_rcu_or_null(env, reg, field_name, btf_id) &&
+				    flag & PTR_UNTRUSTED)
+					flag &= ~PTR_UNTRUSTED;
 			} else if (flag & (MEM_PERCPU | MEM_USER)) {
 				/* keep as-is */
 			} else {
-- 
2.40.1



