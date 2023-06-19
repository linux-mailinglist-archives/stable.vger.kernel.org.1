Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6BB7355F7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFSLiU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSLiT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:38:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331C102
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:38:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-311153ec442so2435992f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687174696; x=1689766696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsjaWlrWltr3xvxixMwU91uIzXsPy1ly5cbiRHwgw28=;
        b=kdEC0+5QSjxwSbGbxNbi4f+Xok40QlXp1RyjKmkM6+TqkwsLy8n2r/Eos1BBS+GONR
         LuT/bheR2SAXQNHvOUgLNvstVNC5jSBytk800CuMF4uNlq/D97NLMGdjcGuwdsYCJUCV
         /67J3Pg9O1wkwpq02SlmEysk4W98lDdmX9jWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174696; x=1689766696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsjaWlrWltr3xvxixMwU91uIzXsPy1ly5cbiRHwgw28=;
        b=grnf8qbxxv9B3/JYTL5HkFP2gvCt2NLnnUrP1OpabsPFjKJRNNj57OEUhVWcfHv+NC
         6j3ek7AHICHVmhI/Lx1b4RnfxG1fJ7Ka+Fp8vVGUIyBzMOn80G9iiknYzStzui+D2V1L
         g50ZoTSrz2DhfQronDUcakiTvIboMwydahtrycYlS3HJ4kDOGv8326vA0vnnpXZ8F6Cq
         ClbrRkhGPk49auJIBYkzeQjYR7DdPFgAGrT3PGRJAn4Agt0k3x/EmJXtjtwi5Ky0F7nz
         6iljmSzhSGZX1htxz31+JM6zjKQbaFib3ZjwQ4dLDJgs33iGKzjo00LjIFMpcVsqywKY
         FDOQ==
X-Gm-Message-State: AC+VfDwmtVojhgIE7N3C0NnYr1VjI1NrDdMhMckItTq+NcXL0O9WJMej
        QzRo2xhb8tFvjgy1MLEmxKJEkyx1eTYl63IOf8w=
X-Google-Smtp-Source: ACHHUZ4YPLX++IOgwjyywPmLq+/IJBdRL/uTxrE0ZnvvGFIk+ItbSTTDeHBe089U051OnVboRecgzQ==
X-Received: by 2002:a5d:6501:0:b0:30f:c420:1743 with SMTP id x1-20020a5d6501000000b0030fc4201743mr7291402wru.26.1687174695912;
        Mon, 19 Jun 2023 04:38:15 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:fee5:1f79:8e7b:8da3])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b00311339f5b06sm5190462wrw.57.2023.06.19.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:38:15 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     stable@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19.y] x86/purgatory: remove PGO flags
Date:   Mon, 19 Jun 2023 13:38:06 +0200
Message-ID: <20230619113806.218802-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <2023061700-surplus-art-1fef@gregkh>
References: <2023061700-surplus-art-1fef@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 97b6b9cbba40a21c1d9a344d5c1991f8cfbf136e)
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
 arch/x86/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 002f7a01af11..00f104e341e5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -12,6 +12,11 @@ $(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
 $(obj)/sha256.o: $(srctree)/lib/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
-- 
2.41.0.162.gfafddb0af9-goog

