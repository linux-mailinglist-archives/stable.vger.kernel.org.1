Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30573E917
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFZScm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjFZScY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF02136
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F32C160F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09770C433C9;
        Mon, 26 Jun 2023 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804330;
        bh=qQf/OyIgR4XnoASZdvywr+M6gKTqZqBnUD5GvGrHF1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hh8UWzqqa9ZqlKHuc7cGtytfjkw38F6UN8ydm2QAicYnNx7hsAGX+y4W4/pV2NICo
         1WvcdPbquwmIn1tju6YnANurdtu4HV58D1JoWs0WpcxKeH1sjbN0yTWRbqlp6vzKB3
         coUTUh65mftrddebCN8oAxU8Bi/lCOEUqgDWkD2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florent Revest <revest@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@meta.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 120/170] bpf/btf: Accept function names that contain dots
Date:   Mon, 26 Jun 2023 20:11:29 +0200
Message-ID: <20230626180805.950364291@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Florent Revest <revest@chromium.org>

[ Upstream commit 9724160b3942b0a967b91a59f81da5593f28b8ba ]

When building a kernel with LLVM=1, LLVM_IAS=0 and CONFIG_KASAN=y, LLVM
leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
metadata validation fail because they contain a dot.

In a dramatic turn of event, this BTF verification failure can cause
the netfilter_bpf initialization to fail, causing netfilter_core to
free the netfilter_helper hashmap and netfilter_ftp to trigger a
use-after-free. The risk of u-a-f in netfilter will be addressed
separately but the existence of "asan.module_ctor" debug info under some
build conditions sounds like a good enough reason to accept functions
that contain dots in BTF.

Although using only LLVM=1 is the recommended way to compile clang-based
kernels, users can certainly do LLVM=1, LLVM_IAS=0 as well and we still
try to support that combination according to Nick. To clarify:

  - > v5.10 kernel, LLVM=1 (LLVM_IAS=0 is not the default) is recommended,
    but user can still have LLVM=1, LLVM_IAS=0 to trigger the issue

  - <= 5.10 kernel, LLVM=1 (LLVM_IAS=0 is the default) is recommended in
    which case GNU as will be used

Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
Signed-off-by: Florent Revest <revest@chromium.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yhs@meta.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/bpf/20230615145607.3469985-1-revest@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a8838a32f750e..8220caa488c54 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -735,13 +735,12 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first, bool dot_ok)
+static bool __btf_name_char_ok(char c, bool first)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    ((c == '.' && !dot_ok) ||
-	      c != '.'))
+	    c != '.')
 		return false;
 	return true;
 }
@@ -758,20 +757,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
+static bool __btf_name_valid(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true, dot_ok))
+	if (!__btf_name_char_ok(*src, true))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false, dot_ok))
+		if (!__btf_name_char_ok(*src, false))
 			return false;
 		src++;
 	}
@@ -779,17 +778,14 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
 	return !*src;
 }
 
-/* Only C-style identifier is permitted. This can be relaxed if
- * necessary.
- */
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, false);
+	return __btf_name_valid(btf, offset);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, true);
+	return __btf_name_valid(btf, offset);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -4044,7 +4040,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off, true)) {
+	    !__btf_name_valid(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
-- 
2.39.2



