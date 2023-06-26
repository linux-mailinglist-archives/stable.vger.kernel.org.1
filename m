Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25B073E886
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFZS0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjFZS0W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A921984
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AFB60E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B30C433C9;
        Mon, 26 Jun 2023 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803948;
        bh=rPuc8Pj6VUZ4jVpNy+8Lp9AuzNyWmMOhqY1rhbIfKgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMXVZYfiqABjxrnO92x8qyC8SQvD1Q+v0/mQ7z5yJApKJ4ijYZ+zV7reXDZbgkQ7P
         HK+UZmrmQylQXnFieCI3690QjjshBnacepKLE9xA6GUubGT5cMSKSiaQSaCAileiSV
         e0wqsY1ECX3ZKrw+S0p+JoLp5g5zmrSTh0GbMyS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Rudo <prudo@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Simon Horman <horms@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 06/41] x86/purgatory: remove PGO flags
Date:   Mon, 26 Jun 2023 20:11:29 +0200
Message-ID: <20230626180736.500425171@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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

From: Ricardo Ribalda <ribalda@chromium.org>

commit 97b6b9cbba40a21c1d9a344d5c1991f8cfbf136e upstream.

If profile-guided optimization is enabled, the purgatory ends up with
multiple .text sections.  This is not supported by kexec and crashes the
system.

Link: https://lkml.kernel.org/r/20230321-kexec_clang16-v7-2-b05c520b7296@chromium.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Cc: <stable@vger.kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/purgatory/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -12,6 +12,11 @@ $(obj)/string.o: $(srctree)/arch/x86/boo
 $(obj)/sha256.o: $(srctree)/lib/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 


