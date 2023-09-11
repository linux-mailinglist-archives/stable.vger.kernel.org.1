Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2379AE78
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbjIKWf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbjIKOhU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE8F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE51BC433C7;
        Mon, 11 Sep 2023 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443034;
        bh=IuD6U8I4kO8L6YZe1GFSL2ruiKsBPAUsHg4kYTdeItE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZbbKzw6ThOyi2eRfjlgaBrwIN/igXBgW3PiPvOpdVMpQZHoo5c8jGXdPG7TSFnp0
         /jgBd1h3Y4tx4kPD0Bdn66zWjK8U+Mx11yZa9b42mzd9faVGXVgcf7p6ofPfAvEC31
         k+wWc/rOiKlJu953BhPGHg2GZT/A6JvoQHpTaHcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 234/737] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Date:   Mon, 11 Sep 2023 15:41:33 +0200
Message-ID: <20230911134657.143987264@linuxfoundation.org>
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

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit ab6c637ad0276e42f8acabcbc64932a6d346dab3 ]

When reviewing local percpu kptr support, Alexei discovered a bug
wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
locally allocated obj type do not match ([1]). Missed struct btf_id
comparison is the reason for the bug. This patch added such struct btf_id
comparison and will flag verification failure if types do not match.

  [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230822050053.2886960-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cef173614fc8f..b9e4dbdfa296a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4790,20 +4790,22 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
 	const char *targ_name = btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
-	int perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
+	int perm_flags;
 	const char *reg_name = "";
 
-	/* Only unreferenced case accepts untrusted pointers */
-	if (kptr_field->type == BPF_KPTR_UNREF)
-		perm_flags |= PTR_UNTRUSTED;
+	if (btf_is_kernel(reg->btf)) {
+		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
+
+		/* Only unreferenced case accepts untrusted pointers */
+		if (kptr_field->type == BPF_KPTR_UNREF)
+			perm_flags |= PTR_UNTRUSTED;
+	} else {
+		perm_flags = PTR_MAYBE_NULL | MEM_ALLOC;
+	}
 
 	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
 		goto bad_type;
 
-	if (!btf_is_kernel(reg->btf)) {
-		verbose(env, "R%d must point to kernel BTF\n", regno);
-		return -EINVAL;
-	}
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = btf_type_name(reg->btf, reg->btf_id);
 
@@ -4816,7 +4818,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	if (__check_ptr_off_reg(env, reg, regno, true))
 		return -EACCES;
 
-	/* A full type match is needed, as BTF can be vmlinux or module BTF, and
+	/* A full type match is needed, as BTF can be vmlinux, module or prog BTF, and
 	 * we also need to take into account the reg->off.
 	 *
 	 * We want to support cases like:
@@ -7554,7 +7556,10 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
-		/* Handled by helper specific checks */
+		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
+				return -EACCES;
+		}
 		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
-- 
2.40.1



