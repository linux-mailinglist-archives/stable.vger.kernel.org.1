Return-Path: <stable+bounces-6329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A394680DA21
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC83B21A42
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D0524D1;
	Mon, 11 Dec 2023 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rsG1pByk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA251C5C;
	Mon, 11 Dec 2023 18:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61CC433C7;
	Mon, 11 Dec 2023 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321135;
	bh=dS+SdOU2O9UDGEz9CdvP7llG5AYiZ2e4sTzdDp+bTOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsG1pBykmj30Jo2pazWKBKGdBe3RmLyBFhlzUOU5oEc6Ig1h52z69cjnavBeRYx3i
	 Wkyi18ioYt6iCK/d3vwbBV6jh/1buxQBrRSvntWqUz7Gs6ot5URmmHKSmVgt6xaxKP
	 u/xQh48lPTYMnqG7WvupPiAY8GoIT4xitKE0DPCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Jani Nikula <jani.nikula@intel.com>,
	David Sterba <dsterba@suse.com>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Alex Shi <alexs@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 122/141] Kbuild: move to -std=gnu11
Date: Mon, 11 Dec 2023 19:23:01 +0100
Message-ID: <20231211182031.861907036@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e8c07082a810fbb9db303a2b66b66b8d7e588b53 ]

During a patch discussion, Linus brought up the option of changing
the C standard version from gnu89 to gnu99, which allows using variable
declaration inside of a for() loop. While the C99, C11 and later standards
introduce many other features, most of these are already available in
gnu89 as GNU extensions as well.

An earlier attempt to do this when gcc-5 started defaulting to
-std=gnu11 failed because at the time that caused warnings about
designated initializers with older compilers. Now that gcc-5.1 is
the minimum compiler version used for building kernels, that is no
longer a concern. Similarly, the behavior of 'inline' functions changes
between gnu89 using gnu_inline behavior and gnu11 using standard c99+
behavior, but this was taken care of by defining 'inline' to include
__attribute__((gnu_inline)) in order to allow building with clang a
while ago.

Nathan Chancellor reported a new -Wdeclaration-after-statement
warning that appears in a system header on arm, this still needs a
workaround.

The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
minimal and mainly impact warnings at the -Wpedantic level that the
kernel never enables. Between these, gnu11 is the newest version
that is supported by all supported compiler versions, though it is
only the default on gcc-5, while all other supported versions of
gcc or clang default to gnu1x/gnu17.

Link: https://lore.kernel.org/lkml/CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com/
Link: https://github.com/ClangBuiltLinux/linux/issues/1603
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: David Sterba <dsterba@suse.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/process/programming-language.rst              | 6 +++---
 .../translations/it_IT/process/programming-language.rst     | 4 ++--
 .../translations/zh_CN/process/programming-language.rst     | 3 +--
 .../translations/zh_TW/process/programming-language.rst     | 3 +--
 Makefile                                                    | 4 ++--
 arch/arm64/kernel/vdso32/Makefile                           | 2 +-
 6 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
index ec474a70a02fa..5fc9160ca1fa5 100644
--- a/Documentation/process/programming-language.rst
+++ b/Documentation/process/programming-language.rst
@@ -5,9 +5,9 @@ Programming Language
 
 The kernel is written in the C programming language [c-language]_.
 More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
-under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
-(including some C99 features). ``clang`` [clang]_ is also supported, see
-docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+under ``-std=gnu11`` [gcc-c-dialect-options]_: the GNU dialect of ISO C11.
+``clang`` [clang]_ is also supported, see docs on
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
 This dialect contains many extensions to the language [gnu-extensions]_,
 and many of them are used within the kernel as a matter of course.
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
index 41db2598ce119..c1a9b481a6f99 100644
--- a/Documentation/translations/it_IT/process/programming-language.rst
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -10,8 +10,8 @@ Linguaggio di programmazione
 
 Il kernel è scritto nel linguaggio di programmazione C [it-c-language]_.
 Più precisamente, il kernel viene compilato con ``gcc`` [it-gcc]_ usando
-l'opzione ``-std=gnu89`` [it-gcc-c-dialect-options]_: il dialetto GNU
-dello standard ISO C90 (con l'aggiunta di alcune funzionalità da C99).
+l'opzione ``-std=gnu11`` [it-gcc-c-dialect-options]_: il dialetto GNU
+dello standard ISO C11.
 Linux supporta anche ``clang`` [it-clang]_, leggete la documentazione
 :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 2a47a1d2ec20f..fabdc338dbfbc 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -9,8 +9,7 @@
 ============
 
 内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
-在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C90的 GNU 方言（
-包括一些C99特性）
+在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
 
 这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
 
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index 54e3699eadf85..144bdaf81a416 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -12,8 +12,7 @@
 ============
 
 內核是用C語言 :ref:`c-language <tw_c-language>` 編寫的。更準確地說，內核通常是用 :ref:`gcc <tw_gcc>`
-在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect-options>` 下編譯的：ISO C90的 GNU 方言（
-包括一些C99特性）
+在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect-options>` 下編譯的：ISO C11的 GNU 方言
 
 這種方言包含對語言 :ref:`gnu-extensions <tw_gnu-extensions>` 的許多擴展，當然，它們許多都在內核中使用。
 
diff --git a/Makefile b/Makefile
index 5976e71522607..fb1517f05c3ff 100644
--- a/Makefile
+++ b/Makefile
@@ -524,7 +524,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
-		   -std=gnu89
+		   -std=gnu11
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
@@ -809,7 +809,7 @@ KBUILD_CFLAGS += $(KBUILD_CFLAGS-y)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
-# The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
+# The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 50cb1ec092ae5..d7f5b140a5d2a 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -77,7 +77,7 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
                -Wdeclaration-after-statement \
-               -std=gnu89
+               -std=gnu11
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
 VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
-- 
2.42.0




