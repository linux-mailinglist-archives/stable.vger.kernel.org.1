Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4A7611F6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGYK6d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjGYK5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807544AC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FC06165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E88C433C9;
        Tue, 25 Jul 2023 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282493;
        bh=jGMuyocLU3PgFyrhfG/sjb51MtRGWMW7l2UcH4rCVrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1VM1aqXTxuVokh2WgeOMlh9nWWVNeIEA2h1G01LtDeOBq/7oEnOewP0ZnMdaJAlf
         MjbC5m7Nby/k5et8FVRuSQ3spT7iEQeTNq0rVckEyCv2fHesF6i3gIhIuOE6ZqFCst
         vh1mhk/67+SQUe5CrYuAZZ2/MIjFt05rsPbGUP4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 149/227] kallsyms: strip LTO-only suffixes from promoted global functions
Date:   Tue, 25 Jul 2023 12:45:16 +0200
Message-ID: <20230725104521.062777318@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 8cc32a9bbf2934d90762d9de0187adcb5ad46a11 ]

Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
stripped all function/variable suffixes started with '.' regardless
of whether those suffixes are generated at LTO mode or not. In fact,
as far as I know, in LTO mode, when a static function/variable is
promoted to the global scope, '.llvm.<...>' suffix is added.

The existing mechanism breaks live patch for a LTO kernel even if
no <symbol>.llvm.<...> symbols are involved. For example, for the following
kernel symbols:
  $ grep bpf_verifier_vlog /proc/kallsyms
  ffffffff81549f60 t bpf_verifier_vlog
  ffffffff8268b430 d bpf_verifier_vlog._entry
  ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
  ffffffff82e12a1f d bpf_verifier_vlog.__already_done
'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
'__already_done' are static variables used inside 'bpf_verifier_vlog',
so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
Note that the func-level to file-level static function promotion also
happens without LTO.

Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current mechanism will
return 4 symbols to live patch subsystem which current live patching
subsystem cannot handle it. With non-LTO kernel, only one symbol
is returned.

In [1], we have a lengthy discussion, the suggestion is to separate two
cases:
  (1). new symbols with suffix which are generated regardless of whether
       LTO is enabled or not, and
  (2). new symbols with suffix generated only when LTO is enabled.

The cleanup_symbol_name() should only remove suffixes for case (2).
Case (1) should not be changed so it can work uniformly with or without LTO.

This patch removed LTO-only suffix '.llvm.<...>' so live patching and
tracing should work the same way for non-LTO kernel.
The cleanup_symbol_name() in scripts/kallsyms.c is also changed to have the same
filtering pattern so both kernel and kallsyms tool have the same
expectation on the order of symbols.

 [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u

Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230628181926.4102448-1-yhs@fb.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kallsyms.c  | 5 ++---
 scripts/kallsyms.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b6..4874508bb950e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
 	 * LLVM appends various suffixes for local functions and variables that
 	 * must be promoted to global scope as part of LTO.  This can break
 	 * hooking of static functions with kprobes. '.' is not a valid
-	 * character in an identifier in C. Suffixes observed:
+	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
 	 * - foo.llvm.[0-9a-f]+
-	 * - foo.[0-9a-f]+
 	 */
-	res = strchr(s, '.');
+	res = strstr(s, ".llvm.");
 	if (res) {
 		*res = '\0';
 		return true;
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 0d2db41177b23..13af6d0ff845d 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -346,10 +346,10 @@ static void cleanup_symbol_name(char *s)
 	 * ASCII[_]   = 5f
 	 * ASCII[a-z] = 61,7a
 	 *
-	 * As above, replacing '.' with '\0' does not affect the main sorting,
-	 * but it helps us with subsorting.
+	 * As above, replacing the first '.' in ".llvm." with '\0' does not
+	 * affect the main sorting, but it helps us with subsorting.
 	 */
-	p = strchr(s, '.');
+	p = strstr(s, ".llvm.");
 	if (p)
 		*p = '\0';
 }
-- 
2.39.2



