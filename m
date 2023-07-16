Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F2755372
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjGPUTM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjGPUTM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE1126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC4860EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8932C433C7;
        Sun, 16 Jul 2023 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538750;
        bh=fjnxqA4UUS6QAbFy+OFrg0tcWUdkF7DkC6nzAJIuEr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1tGJwdSs+WllJnXN+hHUut3XQ7DksrA52Y8LgVFVrO3RxAIzaOUIeup7h9AlkxUE
         NZb1s097nEOh6IjKDcTCGph52oRXPtMj0+zdYz1+IH8+s3S2KSprvGic1OSXUfDYxm
         VmoDYFz0rVHWG1XWlj7UtsQa5E4YsP65ROaJgAAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Fradley <joefradley@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 533/800] kbuild: Disable GCOV for *.mod.o
Date:   Sun, 16 Jul 2023 21:46:26 +0200
Message-ID: <20230716195001.474943070@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 25a21fbb934a0d989e1858f83c2ddf4cfb2ebe30 ]

With GCOV_PROFILE_ALL, Clang injects __llvm_gcov_* functions to each
object file, including the *.mod.o. As we filter out CC_FLAGS_CFI
for *.mod.o, the compiler won't generate type hashes for the
injected functions, and therefore indirectly calling them during
module loading trips indirect call checking.

Enabling CFI for *.mod.o isn't sufficient to fix this issue after
commit 0c3e806ec0f9 ("x86/cfi: Add boot time hash randomization"),
as *.mod.o aren't processed by objtool, which means any hashes
emitted there won't be randomized. Therefore, in addition to
disabling CFI for *.mod.o, also disable GCOV, as the object files
don't otherwise contain any executable code.

Fixes: cf68fffb66d6 ("add support for Clang CFI")
Reported-by: Joe Fradley <joefradley@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.modfinal | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 4703f652c0098..fc19f67039bda 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
-- 
2.39.2



