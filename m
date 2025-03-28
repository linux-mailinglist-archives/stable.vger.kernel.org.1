Return-Path: <stable+bounces-126966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632FA750C1
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 20:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F351893D2D
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5F1E5B97;
	Fri, 28 Mar 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdrLdeM5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FC1E5710;
	Fri, 28 Mar 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190011; cv=none; b=XJNpHPANzTnWDDI8bUomRce07fhdA8B+UhqZhVcHoBGLdNB4Zn39vBrImw5osr1JsaQeQfCb8pjf2tzbQoBDah+Sdws7dL4FOMiqk0Sb7S2AMIH4uBw9hNoAg0tZUiNIvn7s4e1K1tkPpedJs1BRF0YQKCXj4AaaQpJxK84bP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190011; c=relaxed/simple;
	bh=PkGUDCBwQo6CjP1Y3kpo+26fhidFS6GR+HAnWO8Fc0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciaFYQ8hk2V2gY6DzmLceLvWtOfrMRdCDAsVf3GGzrgIkrKvFyyEWddp0XiFde7o4oXLk8OQGomH4LMXFhsNmv+uD2k7P2ETIrbVUl4UWEC2dsjcUcQLH8h/T9jKv5ICPUW2U2VAuMe+yyPiX1My4c2wJiONNEPAQirhQntzdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdrLdeM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48600C4CEE8;
	Fri, 28 Mar 2025 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743190011;
	bh=PkGUDCBwQo6CjP1Y3kpo+26fhidFS6GR+HAnWO8Fc0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AdrLdeM5ZqfmdqdsCR0RUN1KCYuR8FAWlpYqC3dRqRRh0vSLTwj4nVm1puUXn/xqS
	 vcrm9G/MqnsMFumg4oQYiwo5KRBscvlgaNcYogmBsH9kkvKXz7n0TRV59x0ziRHTDw
	 lVqdMxXWDS0aET2+sb5HpsFOKgoJYET/0zKnFG6XUvsSWzZN0vTQhyX8q54MLUthxD
	 ZsaafVbMzt9SuZIH83RdxX+TAShOCORLhMAaOMHp9MlJ0NwfGAwyqSZslyzWGjqz7Y
	 HxmJZXn/v/44vSv4IV2JhTE6cJ1kyzqmim9+eOGYu2vw4BU2/TQaS+ANWjundl/k2e
	 TLPF98d5iuDXw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 28 Mar 2025 12:26:32 -0700
Subject: [PATCH v3 2/2] lib/string.c: Add wcslen()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-string-add-wcslen-for-llvm-opt-v3-2-a180b4c0c1c4@kernel.org>
References: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
In-Reply-To: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056; i=nathan@kernel.org;
 h=from:subject:message-id; bh=PkGUDCBwQo6CjP1Y3kpo+26fhidFS6GR+HAnWO8Fc0Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnPvn/5ce7nCeFZFl8TPaKMXlscn3zmy74tFp83MEfN+
 WnA1bjnZ0cpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYiFAEwx+OXy7vHP7ulfl7
 u3z+xLYTQT99UpK3zNJ0+MRmVnxAwGAfw1/hrn2blhwVO7F884ro83s9NF25C7Iis/e+K3e++JF
 HpJgVAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

The kernel does not build with '-ffreestanding' (which would avoid this
transformation) because it does want libcall optimizations in general
and turning on '-ffreestanding' disables the majority of them. While
'-fno-builtin-wcslen' would be more targeted at the problem, it does not
work with LTO.

Add a basic wcslen() to avoid this linkage failure. While no
architecture or FORTIFY_SOURCE overrides this, add it to string.c
instead of string_helpers.c so that it is built with '-ffreestanding',
otherwise the compiler might transform it into a call to itself.

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/string.h |  2 ++
 lib/string.c           | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0403a4ca4c11..b000f445a2c7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -10,6 +10,7 @@
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/nls_types.h>	/* for wchar_t */
 #include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
@@ -203,6 +204,7 @@ extern __kernel_size_t strlen(const char *);
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+__kernel_size_t wcslen(const wchar_t *s);
 #ifndef __HAVE_ARCH_STRPBRK
 extern char * strpbrk(const char *,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d2..2c6f8c8f4159 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
+#include <linux/nls_types.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -429,6 +430,16 @@ size_t strnlen(const char *s, size_t count)
 EXPORT_SYMBOL(strnlen);
 #endif
 
+size_t wcslen(const wchar_t *s)
+{
+	const wchar_t *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+EXPORT_SYMBOL(wcslen);
+
 #ifndef __HAVE_ARCH_STRSPN
 /**
  * strspn - Calculate the length of the initial substring of @s which only contain letters in @accept

-- 
2.49.0


