Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBDC7831E2
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHUUBJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjHUUBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B163130
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E966479A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CF6C433C8;
        Mon, 21 Aug 2023 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648066;
        bh=dbRHxPMkQ9nrNWUKoWZNWzUzsxBX/FS2dqF9mwM0wSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zgo36UyQP8jc/RRIV6GOYcjk0vpIRt6HKZwFPFZ+6gDHCoY3qOu9Tvu2Hr7YXCX9E
         Bu1qF6yPhcuv502vwvkWp2dfTdkxpJ8KfZaD3Pi13VAUv/riHw2xTg/bzLUoHvZe3n
         4HWdMgDOWiVWcL0wYUzm1qAdbbCFKF+cF3fD4ZlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 043/234] Revert "[PATCH] uml: export symbols added by GCC hardened"
Date:   Mon, 21 Aug 2023 21:40:06 +0200
Message-ID: <20230821194130.636870207@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 8635e8df477bc77837886da206f4915576f88fec ]

This reverts commit cead61a6717a9873426b08d73a34a325e3546f5d.

It exported __stack_smash_handler and __guard, while they may not be
defined by anyone.

The code *declares* __stack_smash_handler and __guard. It does not
create weak symbols. If no external library is linked, they are left
undefined, but yet exported.

If a loadable module tries to access non-existing symbols, bad things
(a page fault, NULL pointer dereference, etc.) will happen. So, the
current code is wrong and dangerous.

If the code were written as follows, it would *define* them as weak
symbols so modules would be able to get access to them.

  void (*__stack_smash_handler)(void *) __attribute__((weak));
  EXPORT_SYMBOL(__stack_smash_handler);

  long __guard __attribute__((weak));
  EXPORT_SYMBOL(__guard);

In fact, modpost forbids exporting undefined symbols. It shows an error
message if it detects such a mistake.

  ERROR: modpost: "..." [...] was exported without definition

Unfortunately, it is checked only when the code is built as modular.
The problem described above has been unnoticed for a long time because
arch/um/os-Linux/user_syms.c is always built-in.

With a planned change in Kbuild, exporting undefined symbols will always
result in a build error instead of a run-time error. It is a good thing,
but we need to fix the breakage in advance.

One fix is to define weak symbols as shown above. An alternative is to
export them conditionally as follows:

  #ifdef CONFIG_STACKPROTECTOR
  extern void __stack_smash_handler(void *);
  EXPORT_SYMBOL(__stack_smash_handler);

  external long __guard;
  EXPORT_SYMBOL(__guard);
  #endif

This is what other architectures do; EXPORT_SYMBOL(__stack_chk_guard)
is guarded by #ifdef CONFIG_STACKPROTECTOR.

However, adding the #ifdef guard is not sensible because UML cannot
enable the stack-protector in the first place! (Please note UML does
not select HAVE_STACKPROTECTOR in Kconfig.)

So, the code is already broken (and unused) in multiple ways.

Just remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/user_syms.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 9b62a9d352b3a..a310ae27b479a 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -37,13 +37,6 @@ EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
 #endif
 
-/* Export symbols used by GCC for the stack protector. */
-extern void __stack_smash_handler(void *) __attribute__((weak));
-EXPORT_SYMBOL(__stack_smash_handler);
-
-extern long __guard __attribute__((weak));
-EXPORT_SYMBOL(__guard);
-
 #ifdef _FORTIFY_SOURCE
 extern int __sprintf_chk(char *str, int flag, size_t len, const char *format);
 EXPORT_SYMBOL(__sprintf_chk);
-- 
2.40.1



