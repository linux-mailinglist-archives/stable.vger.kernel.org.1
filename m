Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5AD713DDF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjE1T3v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjE1T3u (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3EA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B84A61D3C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E5BC433EF;
        Sun, 28 May 2023 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302178;
        bh=oYJfFKttYLizDzll8gvpai86bvGG257IY/PdTCPAdfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYPOkcLEF7O1QDd+SMG5MvOr4C3xnxad9Kkj+8fbo3W7JuugH5zpDfdqUiQ5+nb/D
         ELede23Jgbj/6lN/rzh09Ti9rLiEBzTvQ+1j+cipOd/0G6Ppd0u45O7lT9hrHGdVLq
         noMXVo2ORLuBDrbTzQlXkhz0zUxMGOvg6xgt7+3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6.3 030/127] xtensa: add __bswap{si,di}2 helpers
Date:   Sun, 28 May 2023 20:10:06 +0100
Message-Id: <20230528190837.269621721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit 034f4a7877c32a8efd6beee4d71ed14e424499a9 upstream.

gcc-13 may generate calls for __bswap{si,di}2. This breaks the kernel
build when optimization for size is selected. Add __bswap{si,di}2
helpers to fix that.

Cc: stable@vger.kernel.org
Fixes: 19c5699f9aff ("xtensa: don't link with libgcc")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/kernel/xtensa_ksyms.c |    4 ++++
 arch/xtensa/lib/Makefile          |    2 +-
 arch/xtensa/lib/bswapdi2.S        |   21 +++++++++++++++++++++
 arch/xtensa/lib/bswapsi2.S        |   16 ++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/xtensa/lib/bswapdi2.S
 create mode 100644 arch/xtensa/lib/bswapsi2.S

--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(empty_zero_page);
  */
 extern long long __ashrdi3(long long, int);
 extern long long __ashldi3(long long, int);
+extern long long __bswapdi2(long long);
+extern int __bswapsi2(int);
 extern long long __lshrdi3(long long, int);
 extern int __divsi3(int, int);
 extern int __modsi3(int, int);
@@ -66,6 +68,8 @@ extern unsigned long long __umulsidi3(un
 
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__bswapdi2);
+EXPORT_SYMBOL(__bswapsi2);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__divsi3);
 EXPORT_SYMBOL(__modsi3);
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -4,7 +4,7 @@
 #
 
 lib-y	+= memcopy.o memset.o checksum.o \
-	   ashldi3.o ashrdi3.o lshrdi3.o \
+	   ashldi3.o ashrdi3.o bswapdi2.o bswapsi2.o lshrdi3.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o umulsidi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
--- /dev/null
+++ b/arch/xtensa/lib/bswapdi2.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapdi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a4, a2, 16
+	src	a4, a4, a2
+	src	a4, a4, a4
+	src	a4, a2, a4
+	srli	a2, a3, 16
+	src	a2, a2, a3
+	src	a2, a2, a2
+	src	a2, a3, a2
+	mov	a3, a4
+	abi_ret_default
+
+ENDPROC(__bswapdi2)
--- /dev/null
+++ b/arch/xtensa/lib/bswapsi2.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapsi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a3, a2, 16
+	src	a3, a3, a2
+	src	a3, a3, a3
+	src	a2, a2, a3
+	abi_ret_default
+
+ENDPROC(__bswapsi2)


