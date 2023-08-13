Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738577ACA7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjHMVfc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHMVfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FAA10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4FA62CE6
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F253C433C8;
        Sun, 13 Aug 2023 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962532;
        bh=XjgvC2k3FC8AtJi18NyLW0cqKXTOhvGuPdfygv/2zk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMhjVb7Mb2jzefJ3ylnyxaACuwZUt7k7IqENHE6Iq+iXuh4YD2eOjKASFZIDpUp15
         q7vZdhhIDgD+HwqlT8tvtSPl5UEh1YOn83p3VJg+tjRocURjcK710zk7KpMC9LwARY
         cZpaCN5xaAaKo4sbNom4ZHSh6N2+WtFHkrnSg/Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 064/149] x86/srso: Fix build breakage with the LLVM linker
Date:   Sun, 13 Aug 2023 23:18:29 +0200
Message-ID: <20230813211720.720506977@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nick Desaulniers <ndesaulniers@google.com>

commit cbe8ded48b939b9d55d2c5589ab56caa7b530709 upstream.

The assertion added to verify the difference in bits set of the
addresses of srso_untrain_ret_alias() and srso_safe_ret_alias() would fail
to link in LLVM's ld.lld linker with the following error:

  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:210: at least one side of
  the expression must be absolute
  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:211: at least one side of
  the expression must be absolute

Use ABSOLUTE to evaluate the expression referring to at least one of the
symbols so that LLD can evaluate the linker script.

Also, add linker version info to the comment about XOR being unsupported
in either ld.bfd or ld.lld until somewhat recently.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Closes: https://lore.kernel.org/llvm/CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Daniel Kolesa <daniel@octaforge.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Sven Volkinsfeld <thyrc@gmx.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://github.com/ClangBuiltLinux/linux/issues/1907
Link: https://lore.kernel.org/r/20230809-gds-v1-1-eaac90b0cbcc@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/vmlinux.lds.S |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -514,11 +514,17 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_SRSO
 /*
- * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
+ * GNU ld cannot do XOR until 2.41.
+ * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f6f78318fca803c4907fb8d7f6ded8295f1947b1
+ *
+ * LLVM lld cannot do XOR until lld-17.
+ * https://github.com/llvm/llvm-project/commit/fae96104d4378166cbe5c875ef8ed808a356f3fb
+ *
+ * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
-		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
+		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 


