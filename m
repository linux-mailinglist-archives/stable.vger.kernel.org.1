Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A779BECF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjIKVUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbjIKNxu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1021CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D22C433C9;
        Mon, 11 Sep 2023 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440425;
        bh=EqyFZc8yGVj7eWfRWQgyuofM2j4hifFCC1g/3bj3ZbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lv89PfbR4X9OKI0UzJCplRDpLdJGyAw7kAfxnZKukCEjNXQyKRLKOEDT5xc0q8P8x
         jLqWKetJonF44vd2Dhow79m6l1vi0YFuzUXB3Gu+wwkjqzT5yDTepGO7DDC66fe8lc
         to4jvhq/9EPV5m+KdVgk45heAJ4qzVMYIdIUVQSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhangjin Wu <falcon@tinylab.org>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 057/739] tools/nolibc: arch-*.h: add missing space after ,
Date:   Mon, 11 Sep 2023 15:37:36 +0200
Message-ID: <20230911134652.708637348@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhangjin Wu <falcon@tinylab.org>

[ Upstream commit 20233498359a29f7b2ff4e8fbdb0a1a7c8d5744c ]

Fix up such errors reported by scripts/checkpatch.pl:

    ERROR: space required after that ',' (ctx:VxV)
    #148: FILE: tools/include/nolibc/arch-aarch64.h:148:
    +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
                             ^

    ERROR: space required after that ',' (ctx:VxV)
    #148: FILE: tools/include/nolibc/arch-aarch64.h:148:
    +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
                                      ^

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Stable-dep-of: bff60150f7c4 ("tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/arch-aarch64.h   | 2 +-
 tools/include/nolibc/arch-arm.h       | 2 +-
 tools/include/nolibc/arch-i386.h      | 2 +-
 tools/include/nolibc/arch-loongarch.h | 2 +-
 tools/include/nolibc/arch-mips.h      | 2 +-
 tools/include/nolibc/arch-riscv.h     | 2 +-
 tools/include/nolibc/arch-s390.h      | 2 +-
 tools/include/nolibc/arch-x86_64.h    | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 11f294a406b7c..aaafe8a75c8ee 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -175,7 +175,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index ca4c669874973..7ae6f68594882 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -225,7 +225,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 3d672d925e9e2..853cf77633d90 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index ad3f266e70930..3f96271d9a63a 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -172,7 +172,7 @@ const unsigned long *_auxv __attribute__((weak));
 #endif
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index db24e0837a39b..f031cf9dbf31f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -182,7 +182,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a2e8564e66d6a..6da31dcd2e737 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -180,7 +180,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 516dff5bff8bc..293801221678c 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -166,7 +166,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lg	%r2,0(%r15)\n"		/* argument count */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 6fc4d83927429..2a08bd75ff63b 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-- 
2.40.1



