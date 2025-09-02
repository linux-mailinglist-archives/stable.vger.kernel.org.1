Return-Path: <stable+bounces-177552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E7B41056
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8F3B4124
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026642773F3;
	Tue,  2 Sep 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwn8N6+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9A27A469;
	Tue,  2 Sep 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853373; cv=none; b=DjJoMmftpiCPljaZFWBcglCqIl+U9p0mN0cz29yidzhhV8YSwX6/5O7WUpjN6MeYF5iAYrP9U0RT2v/a/7iIeRyF125G+spToK0uYnX6DuwBywC15w9dt+Er1ZOD0T6IrLUucDgwhTK7GKrXb4xqW31C67ZAKgXNanRM8Ev8FZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853373; c=relaxed/simple;
	bh=0DZTl8k2AipkYnKDzUpqimWr/FzOIW31cDY1tZK3nQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQ2oN0OgZZUkqRYRxIXltYFBVCtNrVcwg9AmRX/drp7DNyQoTkV9JO16G4e48vBmNfeLHKlo04ETxN98cA6CIY8UkZOWrXRGuPp2wotbafTCmtC6SyZyam7RefMUQfswsXQf+iTnBWOd1OemDQvIDFh4xq7IHeV4f93FkY7/nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwn8N6+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C9C4CEF4;
	Tue,  2 Sep 2025 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756853373;
	bh=0DZTl8k2AipkYnKDzUpqimWr/FzOIW31cDY1tZK3nQ0=;
	h=From:Date:Subject:To:Cc:From;
	b=pwn8N6+J5brTIo7ffp6w4Wjceht7lEWoW/hQinz/dqoKgq/6/W835c0aTqP4Hr3YO
	 qb52W6qDz20kjm9rJaP0StwMyOfv09Xrb+F5/SQ2ncKKy66SNvSNqtWmD1ylx+rnrI
	 1S39xewqbxiKywApY4JNKIvL8ynibMI7/25cWMHC3C89OyE3Str8FeJ7gf/VnZszlJ
	 nySVARD2HK0OL/qaXqLwOwfUw9iScyuw9xPtqyWJBAWnb/nkhmBltT8crajRR9FVf6
	 meKQFhbBLTd8A0kaWGW1Zvn6PiB7oO1wi9DvW3gVoh0UtziDIwWhE0IDESJlrhxOCk
	 a+BlMUGYkRjKQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 02 Sep 2025 15:49:26 -0700
Subject: [PATCH] compiler-clang.h: Define __SANITIZE_*__ macros only when
 undefined
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clang-update-sanitize-defines-v1-1-cf3702ca3d92@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHV0t2gC/x2MQQqDQAwAvyI5G4ihQvUr0sOyGzVQVtlYkYp/N
 3icGZgTTIqKQV+dUGRX0yU7NHUFcQ55EtTkDEzcUkeM8esWf2sKm6CFrJv+BZOMmsXw/WqJKHK
 XOII/1uLheP7D57puP/hve28AAAA=
X-Change-ID: 20250902-clang-update-sanitize-defines-845000c29d2c
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Marco Elver <elver@google.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0DZTl8k2AipkYnKDzUpqimWr/FzOIW31cDY1tZK3nQ0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnbSyor3R42frFJDXvwra3kuth7/wXGS63uOl61Uz76h
 9WoecWJjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARxUBGhlvLUv4LtvVvm/qk
 9NDrsis/VrZp3r+a6bzd4YpTnH/Ei8OMDC+ZjzifF9ZyT+jzmHjrUcDKdF0+YYMP+z8ZPt8WdVL
 jHjcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang 22 recently added support for defining __SANITIZE__ macros similar
to GCC [1], which causes warnings (or errors with CONFIG_WERROR=y or
W=e) with the existing defines that the kernel creates to emulate this
behavior with existing clang versions.

  In file included from <built-in>:3:
  In file included from include/linux/compiler_types.h:171:
  include/linux/compiler-clang.h:37:9: error: '__SANITIZE_THREAD__' macro redefined [-Werror,-Wmacro-redefined]
     37 | #define __SANITIZE_THREAD__
        |         ^
  <built-in>:352:9: note: previous definition is here
    352 | #define __SANITIZE_THREAD__ 1
        |         ^

Refactor compiler-clang.h to only define the sanitizer macros when they
are undefined and adjust the rest of the code to use these macros for
checking if the sanitizers are enabled, clearing up the warnings and
allowing the kernel to easily drop these defines when the minimum
supported version of LLVM for building the kernel becomes 22.0.0 or
newer.

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f03444dae4fdc8a9c [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Andrew, would it be possible to take this via mm-hotfixes?
---
 include/linux/compiler-clang.h | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index fa4ffe037bc7..8720a0705900 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -18,23 +18,42 @@
 #define KASAN_ABI_VERSION 5
 
 /*
+ * Clang 22 added preprocessor macros to match GCC, in hopes of eventually
+ * dropping __has_feature support for sanitizers:
+ * https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f03444dae4fdc8a9c
+ * Create these macros for older versions of clang so that it is easy to clean
+ * up once the minimum supported version of LLVM for building the kernel always
+ * creates these macros.
+ *
  * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
  * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
  * to avoid adding redundant attributes in other configurations.
  */
+#if __has_feature(address_sanitizer) && !defined(__SANITIZE_ADDRESS__)
+#define __SANITIZE_ADDRESS__
+#endif
+#if __has_feature(hwaddress_sanitizer) && !defined(__SANITIZE_HWADDRESS__)
+#define __SANITIZE_HWADDRESS__
+#endif
+#if __has_feature(thread_sanitizer) && !defined(__SANITIZE_THREAD__)
+#define __SANITIZE_THREAD__
+#endif
 
-#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
-/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel.
+ */
+#ifdef __SANITIZE_HWADDRESS__
 #define __SANITIZE_ADDRESS__
+#endif
+
+#ifdef __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
 		__attribute__((no_sanitize("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
 
-#if __has_feature(thread_sanitizer)
-/* emulate gcc's __SANITIZE_THREAD__ flag */
-#define __SANITIZE_THREAD__
+#ifdef __SANITIZE_THREAD__
 #define __no_sanitize_thread \
 		__attribute__((no_sanitize("thread")))
 #else

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-clang-update-sanitize-defines-845000c29d2c

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


