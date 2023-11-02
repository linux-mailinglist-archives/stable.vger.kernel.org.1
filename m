Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49157DF6B8
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKBPnV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBPnU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 11:43:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA8DFB
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 08:43:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3647FC433C7;
        Thu,  2 Nov 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698939797;
        bh=fmWkFw792BH84PRGV1BX0heQWqrdPlVNLaz2U+olMxA=;
        h=From:Date:Subject:To:Cc:From;
        b=Qdf8tKnBk4lJRHSoNIR4vekMZEgbi3Cx+tzkmk3iij3FBMMO7jrhJkl1UOi0Uu73p
         u0nL75qceUwh/jjsXnsGCoLABvvrbxZsHPNRrdOzj3VxUlC0rXNG6TQVzhierjw32k
         FYkcF9pV42NzzOicEkOqSJIWQv4KCmYd5h466LY07ZbaEDR7DbtHiTBz61RlCYYPkC
         tiH7o4x3B+EZQM3PTuIDhkMMSGD32cuQjoJIwxCYMnz+1w6fswqmMbF0XGyV/LkX6F
         VBejvYTjGldZNGEGCLr/32mugLUNNJURM8lfexuOn06gtOsTMI2jYaPSJLk+AMWMR5
         1UGWWHQE72UtQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 02 Nov 2023 08:43:02 -0700
Subject: [PATCH v2] LoongArch: Mark __percpu functions as always inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231102-loongarch-always-inline-percpu-ops-v2-1-31c51959a5c0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIXDQ2UC/5WNQQ7CIBAAv2I4u6aLibSe/IfpAXFpNxIgi1abp
 n8X+wOPM4eZRRUSpqLOu0UJTVw4xQp6v1NutHEg4HtlpRt9RGwQQkpxsOJGsOFt5wIcA0eCTOL
 yC1Iu4LwxDk/YGvSqhrKQ5882ufaVRy7PJPP2nPBn/8pPCAi31mvqrEGju8uDJFI4JBlUv67rF
 4wAASXVAAAA
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ndesaulniers@google.com, trix@redhat.com, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4824; i=nathan@kernel.org;
 h=from:subject:message-id; bh=fmWkFw792BH84PRGV1BX0heQWqrdPlVNLaz2U+olMxA=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKnOh6e+/3jg4MvoxhcRaeaKWZOmvs1WXfTrrVr4chmLf
 CPe2cHHOkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE7p1jZNjUa8W5Z7p60IZ9
 nmt0w5XaGlyetiTe5qwu1arr7LqwSJ6RYZ7y19o7+rnf1NdJifftrvidNuUjw8cLHikKf99sWLN
 9JSsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

A recent change to the optimization pipeline in LLVM reveals some
fragility around the inlining of LoongArch's __percpu functions, which
manifests as a BUILD_BUG() failure:

  In file included from kernel/sched/build_policy.c:17:
  In file included from include/linux/sched/cputime.h:5:
  In file included from include/linux/sched/signal.h:5:
  In file included from include/linux/rculist.h:11:
  In file included from include/linux/rcupdate.h:26:
  In file included from include/linux/irqflags.h:18:
  arch/loongarch/include/asm/percpu.h:97:3: error: call to '__compiletime_assert_51' declared with 'error' attribute: BUILD_BUG failed
     97 |                 BUILD_BUG();
        |                 ^
  include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
     59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
        |                     ^
  include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^
  include/linux/compiler_types.h:425:2: note: expanded from macro 'compiletime_assert'
    425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^
  include/linux/compiler_types.h:413:2: note: expanded from macro '_compiletime_assert'
    413 |         __compiletime_assert(condition, msg, prefix, suffix)
        |         ^
  include/linux/compiler_types.h:406:4: note: expanded from macro '__compiletime_assert'
    406 |                         prefix ## suffix();                             \
        |                         ^
  <scratch space>:86:1: note: expanded from here
     86 | __compiletime_assert_51
        | ^
  1 error generated.

If these functions are not inlined (which the compiler is free to do
even with functions marked with the standard 'inline' keyword), the
BUILD_BUG() in the default case cannot be eliminated since the compiler
cannot prove it is never used, resulting in a build failure due to the
error attribute.

Mark these functions as __always_inline to guarantee inlining so that
the BUILD_BUG() only triggers when the default case genuinely cannot be
eliminated due to an unexpected size.

Cc:  <stable@vger.kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1955
Fixes: 46859ac8af52 ("LoongArch: Add multi-processor (SMP) support")
Link: https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Change 'inline' to __always_inline for all functions that contain
  BUILD_BUG() (Huacai)
- Notate that 'inline' does not guarantee inlining in the commit message
  to further clarify the change to __always_inline.
- Link to v1: https://lore.kernel.org/r/20231101-loongarch-always-inline-percpu-ops-v1-1-b8f2e9a71729@kernel.org
---
 arch/loongarch/include/asm/percpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index b9f567e66016..313852fba845 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -32,7 +32,7 @@ static inline void set_my_cpu_offset(unsigned long off)
 #define __my_cpu_offset __my_cpu_offset
 
 #define PERCPU_OP(op, asm_op, c_op)					\
-static inline unsigned long __percpu_##op(void *ptr,			\
+static __always_inline unsigned long __percpu_##op(void *ptr,		\
 			unsigned long val, int size)			\
 {									\
 	unsigned long ret;						\
@@ -63,7 +63,7 @@ PERCPU_OP(and, and, &)
 PERCPU_OP(or, or, |)
 #undef PERCPU_OP
 
-static inline unsigned long __percpu_read(void *ptr, int size)
+static __always_inline unsigned long __percpu_read(void *ptr, int size)
 {
 	unsigned long ret;
 
@@ -100,7 +100,8 @@ static inline unsigned long __percpu_read(void *ptr, int size)
 	return ret;
 }
 
-static inline void __percpu_write(void *ptr, unsigned long val, int size)
+static __always_inline void __percpu_write(void *ptr, unsigned long val,
+					   int size)
 {
 	switch (size) {
 	case 1:
@@ -132,8 +133,8 @@ static inline void __percpu_write(void *ptr, unsigned long val, int size)
 	}
 }
 
-static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
-						int size)
+static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
+						   int size)
 {
 	switch (size) {
 	case 1:

---
base-commit: 278be83601dd1725d4732241f066d528e160a39d
change-id: 20231101-loongarch-always-inline-percpu-ops-cf77c161871f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

