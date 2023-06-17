Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F0733F82
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbjFQINj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjFQINg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E12738
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19304611B3
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F4FC433CB;
        Sat, 17 Jun 2023 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989611;
        bh=mkDD5tMRPjZQs5+Gh0nRa+3Hr1t1ZC/FCza+ESWjLxM=;
        h=Subject:To:Cc:From:Date:From;
        b=Zb7462B6X5u7uAwvT1bpfZqFydweAeiSXHY44PF1tbpuubRRmp2+/cpfBbN4tqp6T
         1BTcyTKCGiARR4eYKrC67qZRyErGQlP/rF7DNKDBi36cJqb1pgPi05VlZPeJgSFABQ
         /ox0NKBmCSv1hIjHeytOOzezTaES3aOsWP42FP3M=
Subject: FAILED: patch "[PATCH] riscv/purgatory: remove PGO flags" failed to apply to 5.4-stable tree
To:     ribalda@chromium.org, akpm@linux-foundation.org,
        aou@eecs.berkeley.edu, bhe@redhat.com, bp@alien8.de,
        christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
        dyoung@redhat.com, ebiederm@xmission.com, horms@kernel.org,
        hpa@zytor.com, mingo@redhat.com, mpe@ellerman.id.au,
        nathan@kernel.org, ndesaulniers@google.com, npiggin@gmail.com,
        palmer@dabbelt.com, palmer@rivosinc.com, paul.walmsley@sifive.com,
        prudo@redhat.com, rostedt@goodmis.org, stable@vger.kernel.org,
        tglx@linutronix.de, trix@redhat.com, zwisler@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:13:26 +0200
Message-ID: <2023061726-possum-unrigged-32af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 88ac3bbcf73853880a9b2a65c67e6854390741cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061726-possum-unrigged-32af@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88ac3bbcf73853880a9b2a65c67e6854390741cc Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 May 2023 16:47:39 +0200
Subject: [PATCH] riscv/purgatory: remove PGO flags

If profile-guided optimization is enabled, the purgatory ends up with
multiple .text sections.  This is not supported by kexec and crashes the
system.

Link: https://lkml.kernel.org/r/20230321-kexec_clang16-v7-4-b05c520b7296@chromium.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..bd2e27f82532 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

