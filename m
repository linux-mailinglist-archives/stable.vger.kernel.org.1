Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238774C3C0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGILfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjGILfx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AB895
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D7D60B51
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDD7C433C8;
        Sun,  9 Jul 2023 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902550;
        bh=seFkwHfovXlqN6zLMnKQGR6B2zS52l9j10g99w64Aro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUdgTXV3zBJKZupqdVTJmslfP/pa349Ua3lYfY3P9cEUPwW+bZsabdXMZT5mqMoWg
         EueWmbSAL/EeTfw10A7eJQ5VqAqmjMH+luLtO4TGKzjik9Ou5/dxNz/pgjOIpeUdjt
         d2qeErEASTSUJc59dNLbXdM+sT5SMoYeuNokVO/Q=
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
Subject: [PATCH 6.3 416/431] kbuild: Fix CFI failures with GCOV
Date:   Sun,  9 Jul 2023 13:16:04 +0200
Message-ID: <20230709111500.940451278@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit ddf56288eebd1fe82c46fc9f693b5b18045cddb6 ]

With GCOV_PROFILE_ALL, Clang injects __llvm_gcov_* functions to
each object file, and the functions are indirectly called during
boot. However, when code is injected to object files that are not
part of vmlinux.o, it's also not processed by objtool, which breaks
CFI hash randomization as the hashes in these files won't be
included in the .cfi_sites section and thus won't be randomized.

Similarly to commit 42633ed852de ("kbuild: Fix CFI hash
randomization with KASAN"), disable GCOV for .vmlinux.export.o and
init/version-timestamp.o to avoid emitting unnecessary functions to
object files that don't otherwise have executable code.

Fixes: 0c3e806ec0f9 ("x86/cfi: Add boot time hash randomization")
Reported-by: Joe Fradley <joefradley@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Makefile            | 1 +
 scripts/Makefile.vmlinux | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/Makefile b/init/Makefile
index 26de459006c4e..ec557ada3c12e 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -60,3 +60,4 @@ include/generated/utsversion.h: FORCE
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
 KASAN_SANITIZE_version-timestamp.o := n
+GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 10176dec97eac..3cd6ca15f390d 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -19,6 +19,7 @@ quiet_cmd_cc_o_c = CC      $@
 
 ifdef CONFIG_MODULES
 KASAN_SANITIZE_.vmlinux.export.o := n
+GCOV_PROFILE_.vmlinux.export.o := n
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
 endif
-- 
2.39.2



