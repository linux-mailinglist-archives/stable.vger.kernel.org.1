Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0673E96F
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjFZSgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjFZSgA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6FAC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF85A60F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B193BC433C8;
        Mon, 26 Jun 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804558;
        bh=g5YYxPU/SVLQupiy2ypeCxNWYb61mfRrUNSJY1SDZSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljzfMcM6ITQGiGKeATe3g7qVAM92FfjlHK+hcWcu7+oAgrrTIDri0jJjQYV/GQtc+
         ds7ru4OW11/BLCsFa3G/SSjVOfWQWn3Qwn10QXpn3bL9EUFgl7ne8jwSpDDnj1kXXf
         b/3AG2cqzzIWQzKUnGGgdIxtQqK8VTt7Dr25KwUo=
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
Subject: [PATCH 5.4 06/60] x86/purgatory: remove PGO flags
Date:   Mon, 26 Jun 2023 20:11:45 +0200
Message-ID: <20230626180739.805376303@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
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
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/s
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 


