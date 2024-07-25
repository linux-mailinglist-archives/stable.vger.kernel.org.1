Return-Path: <stable+bounces-61720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B095193C5A2
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A572280FD3
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23419AD93;
	Thu, 25 Jul 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kDTPQygT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3BFC19;
	Thu, 25 Jul 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919226; cv=none; b=A8srAcW1M9JmVymi7DqAG/uAWT9UqghRyL6v8093xJ+s9oFiVa0I6Tx/mTrDmA7wz6TPW2+ESMTW0LzUDMARWh/AuS5Q65K+9v+A57luHParJOafilH3DE+n1kCXA0dCL/RHKY7JlutyaTh3A37X4+TITJiSf8E7u/+HGnzuBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919226; c=relaxed/simple;
	bh=k1NdSPpsvWvgbDDdoXbdX4GpmwKnjeJfB7kf+NwMqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u43KY4ZeQqFIOCT3hTsEGgu2jUixuEy1+agQu+T9m8h9XcxR67OYkkjX2aMb+KiXFAGcxC2STkW9G/I25stnjGFEPUNciSXy5O4emiyswJPPVM0R3udn/GBCMNIU2kZ28uZ0HwEY4WzIc8Ua0YLZVEvIfa3jwCaalxq9qb4lHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kDTPQygT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55428C116B1;
	Thu, 25 Jul 2024 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919226;
	bh=k1NdSPpsvWvgbDDdoXbdX4GpmwKnjeJfB7kf+NwMqBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDTPQygTV44aY0JbemGfwgYSzK+0AznSt1X8R2BgzH7VKMOmv/Nmkn97UIwVlipNk
	 r4p4r/S23+8j8EalhK25q3C3u0lHIAzoVKGaL1erhRPKi/aFXeKtkGbEZh2hUgSObL
	 6+iA9xFmrfmWpCpDYU3CfAO/EzestnS1xu3EIHIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Llamas <cmllamas@google.com>,
	Edward Liaw <edliaw@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 61/87] selftests/vDSO: fix clang build errors and warnings
Date: Thu, 25 Jul 2024 16:37:34 +0200
Message-ID: <20240725142740.732910979@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit 73810cd45b99c6c418e1c6a487b52c1e74edb20d ]

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...there are several warnings, and an error. This fixes all of those and
allows these tests to run and pass.

1. Fix linker error (undefined reference to memcpy) by providing a local
   version of memcpy.

2. clang complains about using this form:

    if (g = h & 0xf0000000)

...so factor out the assignment into a separate step.

3. The code is passing a signed const char* to elf_hash(), which expects
   a const unsigned char *. There are several callers, so fix this at
   the source by allowing the function to accept a signed argument, and
   then converting to unsigned operations, once inside the function.

4. clang doesn't have __attribute__((externally_visible)) and generates
   a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
   to require that attribute in order to build, run and pass tests here,
   so remove it.

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
 .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35b..4ae417372e9eb 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -55,14 +55,20 @@ static struct vdso_info
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 8a44ff973ee17..27f6fdf119691 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -18,7 +18,7 @@
 
 #include "parse_vdso.h"
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
 	return 0;
 }
 
+/*
+ * The clang build needs this, although gcc does not.
+ * Stolen from lib/string.c.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
 /* ...and two syscalls.  This is x86-specific. */
 static inline long x86_syscall3(long nr, long a0, long a1, long a2)
 {
@@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;
-- 
2.43.0




