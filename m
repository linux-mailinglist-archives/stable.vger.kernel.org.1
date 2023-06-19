Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1581735604
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFSLlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFSLls (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:41:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A31BB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:41:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31110aea814so3415752f8f.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687174890; x=1689766890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PMzb6UMa6csn+79C2qrrJ7RqCLkRm7ZFcPhWGH3AR0=;
        b=Sio84A7W3MT35bkR6b5BwQ+v/rGOy6oHwrQ+x9cIMAJCrjtGKdM7mtsosXvD17Mu5D
         dq82nMQhg9FPiWnRQQWqhuc5z8YwAechswOBa9JMnJ4gmrrP6q3a15W6Kc4zWNQnNMav
         NivuPOV0CTdvver3z4E3tqRWChA/KkSIUzOmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174890; x=1689766890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PMzb6UMa6csn+79C2qrrJ7RqCLkRm7ZFcPhWGH3AR0=;
        b=lWJB4O93TXIj2stYwylO9Q0htqPGTurfwTK8/emGOLxSeUsz6kK8AE5gW/VLDAjfux
         sUY8IwX/6YvTXt2vQodwMByI+uYaee9ytbXA0urIy0p7BzMKLnW2zH5GIdsN5LZvnVFR
         r4vMwFrp1byELVrnEay83tdR9VcB7LkLQP/vKPddK8J0BZ80T0HfgwsveDmB4SeyjoYu
         APLAhquw17yclEZ/nwymSOXeAqaWIta03TcNkhHETd1OyrWhaitWgGZJSCMnxmHhypA7
         shnlj1NG7vvZr+NGxuG2VwtDmuP2Y3xo8AqRkqLRFwcKpC4SNgiwqnQwWNUGJau/YVf+
         Fr6g==
X-Gm-Message-State: AC+VfDz0ZQKGMlBELci6Tgh1DK1iQknnpR6xvYrkBUc5aSmAewulsGGC
        UNrIpm4LpezsuZNgGl6tEtIcUl+JNmAVC20q10A=
X-Google-Smtp-Source: ACHHUZ7b1yObTgaTgkZjSR0Cpm3h8wuFgFlDCbwMow2D8g6KLjbzBxCvNuKX+iNVgYG/GtXHNbyo4Q==
X-Received: by 2002:a5d:464e:0:b0:30f:c801:aa7c with SMTP id j14-20020a5d464e000000b0030fc801aa7cmr10322825wrs.43.1687174890328;
        Mon, 19 Jun 2023 04:41:30 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:fee5:1f79:8e7b:8da3])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm31314724wro.55.2023.06.19.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:41:29 -0700 (PDT)
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
Subject: [PATCH 5.4.y] x86/purgatory: remove PGO flags
Date:   Mon, 19 Jun 2023 13:41:24 +0200
Message-ID: <20230619114124.233299-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <2023061759-gilled-droop-f51d@gregkh>
References: <2023061759-gilled-droop-f51d@gregkh>
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
index 969d2b2eb7d7..8309e230aeed 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
-- 
2.41.0.162.gfafddb0af9-goog

