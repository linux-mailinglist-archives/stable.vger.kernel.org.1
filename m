Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D749726A46
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjFGUAX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjFGUAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FD213B;
        Wed,  7 Jun 2023 13:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0533263446;
        Wed,  7 Jun 2023 20:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582C1C433EF;
        Wed,  7 Jun 2023 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686168005;
        bh=yXJFHRqg6GkNK0dANI/hkYekXweeIh63MUfu9JjFAg0=;
        h=Date:To:From:Subject:From;
        b=wyr6NUfD+GsYm3FiMaPysvR30Af1SVBtfMTHKgtpi//qqXtwY7/Kq7cLE+qs3rl7Q
         N/zV4kxP6I7wj3BSUjzNVUKAG+u9nkYRRQHFvf5fq3vB6/fl0jSKVGPZAMYa4XDh1v
         K5QrvYyxk0R22OWSMfe1WvEHnviqfzJAslzIcvjg=
Date:   Wed, 07 Jun 2023 13:00:04 -0700
To:     mm-commits@vger.kernel.org, zwisler@google.com, trix@redhat.com,
        tglx@linutronix.de, stable@vger.kernel.org, rostedt@goodmis.org,
        prudo@redhat.com, paul.walmsley@sifive.com, palmer@rivosinc.com,
        palmer@dabbelt.com, npiggin@gmail.com, ndesaulniers@google.com,
        nathan@kernel.org, mpe@ellerman.id.au, mingo@redhat.com,
        hpa@zytor.com, horms@kernel.org, ebiederm@xmission.com,
        dyoung@redhat.com, dave.hansen@linux.intel.com,
        christophe.leroy@csgroup.eu, bp@alien8.de, bhe@redhat.com,
        aou@eecs.berkeley.edu, ribalda@chromium.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] riscv-purgatory-remove-pgo-flags.patch removed from -mm tree
Message-Id: <20230607200005.582C1C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: riscv/purgatory: remove PGO flags
has been removed from the -mm tree.  Its filename was
     riscv-purgatory-remove-pgo-flags.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: riscv/purgatory: remove PGO flags
Date: Fri, 19 May 2023 16:47:39 +0200

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
---

 arch/riscv/purgatory/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/riscv/purgatory/Makefile~riscv-purgatory-remove-pgo-flags
+++ a/arch/riscv/purgatory/Makefile
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
_

Patches currently in -mm which might be from ribalda@chromium.org are


