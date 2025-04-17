Return-Path: <stable+bounces-133217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41678A92388
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C2817B1D8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CB254AEC;
	Thu, 17 Apr 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI+Vzy2w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E317A30E;
	Thu, 17 Apr 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909829; cv=none; b=gANkaQGRgivZX+J7SKqL3Em3TMAhy/JXQ+0rt0CBWplG5ZutAKHEIOuy6x+jhw2U0dfYFRz7ou1OZKZKwjcxCCO2GMQ3s/H4VCpCaBkgsu64b9uRq3yZBXGxOp0hhhwVE6H2GoMyVu/6V19PphokdH1x7TImcplWTsM10mlje4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909829; c=relaxed/simple;
	bh=mffokTJI7z6+Mowkpq78KjCNltdAs9MFi5sKUscpmew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P2Ocnpba8j9GtkQvPoecAwXJvZMEUAe2BofbhTBglU1E6BgCJs68QGur8Fnx78oXLEVRuBkM1O8obTcRE5fJpK4BtHK0SaxYEPtqiM+MlFXzqEIhFihVLxk2usapBvdP2/OSvm8JLJC7viNJx/92bzTjwwBlktJCdpSCRp/CGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI+Vzy2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2EDC4CEE4;
	Thu, 17 Apr 2025 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744909828;
	bh=mffokTJI7z6+Mowkpq78KjCNltdAs9MFi5sKUscpmew=;
	h=Date:From:To:Cc:Subject:From;
	b=OI+Vzy2wpXQxYqtJlBZDcsO/lMgINZ72KzniiWMd2uTG1rjVUB2RTMBpPNsZP/9Pd
	 EIml6a/Hl/wVf/cF1XfweLVRgTS188Uo5/NxhVHTebSsQLZv7TkG/GypXzBQosh+wI
	 o5HsPpgoXzbWsa94UDbmA1JX7HuuERsLswwZFG7cDYiFfvEUDattzqJvEHcpsstd+i
	 wNMnvQYyMiFCR4BzQrywL7t0eW+0Hm7ZaNTq9UJeHuYbW0emQk374GZrdIFi1ylzVY
	 7WjORqcmwq05a+YM45PMoaePQFKoTOocgt+cwOpZrfpPCZvXWbHBm5BkEQHKqQQi79
	 M+rO2p9iVSr4A==
Date: Thu, 17 Apr 2025 10:10:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Backports of 84ffc79bfbf7 for 6.12 and earlier
Message-ID: <20250417171024.GA171175@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ECo7AUNvGO56DH5W"
Content-Disposition: inline


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please find attached backports for commit 84ffc79bfbf7 ("kbuild: Add
'-fno-builtin-wcslen'") to 6.12 and earlier. It has already been queued
for 6.13 and 6.14 since it applied cleanly. If there are any issues,
please let me know.

Cheers,
Nathan

--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=5.4-84ffc79bfbf7.patch

From 5dc6f440b2309877ab27879fc327ef0dfc58b682 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 5.4] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 6cb965fe2cb3..05eed26d3e4b 100644
--- a/Makefile
+++ b/Makefile
@@ -930,6 +930,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: 1b01d9c341770d4dab5a1a04a706a8eb6c389bb1
-- 
2.49.0


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=5.10-84ffc79bfbf7.patch

From b0f27298358b4b6f1b44a586fa0de88ce6ca74d0 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 5.10] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index e13f8f8a9ea9..6f7a5e72bbb9 100644
--- a/Makefile
+++ b/Makefile
@@ -976,6 +976,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: 7222a9d1c9246944d284902fb9aed25613dd0ece
-- 
2.49.0


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=5.15-84ffc79bfbf7.patch

From bc78bacca3f3f9f7367afc6dbf56a4733f47e3f6 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 5.15] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 619f4ec0f613..035578b9fafc 100644
--- a/Makefile
+++ b/Makefile
@@ -1066,6 +1066,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: f7347f4005727f3155551c0550f4deb9c40b56c2
-- 
2.49.0


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.1-84ffc79bfbf7.patch

From a87930300e5abe2d100b17d7941eb2a4357b88b6 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 6.1] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 50f1a283b67d..eae097d3db6c 100644
--- a/Makefile
+++ b/Makefile
@@ -1075,6 +1075,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: 420102835862f49ec15c545594278dc5d2712f42
-- 
2.49.0


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.6-84ffc79bfbf7.patch

From 1b9fbad11767ed56fdc7da1b252913e2f2a155e9 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 6.6] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 45f6b7d3d51e..18ca8d458fa4 100644
--- a/Makefile
+++ b/Makefile
@@ -1004,6 +1004,9 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS   += -fconserve-stack
 endif
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: 814637ca257f4faf57a73fd4e38888cce88b5911
-- 
2.49.0


--ECo7AUNvGO56DH5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.12-84ffc79bfbf7.patch

From 99d01048fc148dc10471b67da642df190a9727bb Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 7 Apr 2025 16:22:12 -0700
Subject: [PATCH 6.12] kbuild: Add '-fno-builtin-wcslen'

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 6a2a60eb67a3..1e0ec6317c17 100644
--- a/Makefile
+++ b/Makefile
@@ -1013,6 +1013,9 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS   += -fconserve-stack
 endif
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 

base-commit: 83b4161a63b87ce40d9f24f09b5b006f63d95b7c
-- 
2.49.0


--ECo7AUNvGO56DH5W--

