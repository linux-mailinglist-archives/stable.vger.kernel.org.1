Return-Path: <stable+bounces-126767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D9A71D05
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C717B751
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44380204687;
	Wed, 26 Mar 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un2i0acs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB5202C5D;
	Wed, 26 Mar 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009582; cv=none; b=Ux1g5LfGgbJW8ePJos6Nb5OswxjeeHzb4+oZoQfVGq2DyBZcWBd1Bn4erejMuA+lZz9eAH0oNBKfn+hM1ak1rr4eWihQSkjCIDjaqQFNXLreKFb+K9pa3EgvCujYf+KAZ9D+oPQNpVg0vM6DxECxGWm8fDd92/btnM3w+sDyfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009582; c=relaxed/simple;
	bh=KTBrm4WbDj3jrDr3AvU95JjjtHXOiRQkBglBixZek4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ih4mZ55pG76FXifjZRcPtVfKiet3aa054GDUM3tp1pToVImswGyVe7gUtVzUXVpW92y7fHDtRu7ufeI4vz6EwSi3EqLl08aPzXAjWDpEVIPH/txtwdJT9GpEZn5liUnHmAF+m8aWm7YJVp7i0A1FX0DMA2kA3IEWwQP9QBnEos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un2i0acs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA3C4CEE2;
	Wed, 26 Mar 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009581;
	bh=KTBrm4WbDj3jrDr3AvU95JjjtHXOiRQkBglBixZek4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=un2i0acsg1hjYpObtYDIR1yN6uezD9ce40Kn3vxvjIE9aGWA47y8fRSxI4IFrXP0e
	 EDGl/HSKrc7qLOeMgdcm6K6mY5W61SJwUdz6v8FNzE2yrLv7PlTZJfLfKlMpk/RUxu
	 02lokKZBHA+oesOGar3aOmEBv5JDzsHajUNelW5invbE/UJdRw4moFS7t0P6qLFxa9
	 QojoMEoMmItJrtQvgb9zct3lDMe1hG/mCrdKVEsSl04KcS/AAyfNHPu71OW7yz3iDl
	 rqVn/VLNOkRhCJtkkWHenlR3zm7HLxoHs13Ph/VqRywa/c/Hp/Sp3hlLezqQvTJfvQ
	 p9dBr+cKhbTPQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 26 Mar 2025 09:32:32 -0700
Subject: [PATCH v2 2/2] lib/string.c: Add wcslen()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org>
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
In-Reply-To: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=nathan@kernel.org;
 h=from:subject:message-id; bh=KTBrm4WbDj3jrDr3AvU95JjjtHXOiRQkBglBixZek4c=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlPzFWVThj1n0lOqLQ/fu1pX21+WNfWUy6e5/a4xUdk/
 az/Ivyro5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExEfgEjw9XCxco+M7W5an31
 bQ1ibD2MPqnbCaq6sD8ymXH7Cv/WGwx/5bu1K/tmviphUZ+spz3n7fec/MUR8x/XN5197XNh2s4
 7bAA=
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
index 0403a4ca4c11..4a48f8eac301 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -7,6 +7,7 @@
 #include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
+#include <linux/nls_types.h>	/* for wchar_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
@@ -203,6 +204,7 @@ extern __kernel_size_t strlen(const char *);
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+extern __kernel_size_t wcslen(const wchar_t *s);
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


