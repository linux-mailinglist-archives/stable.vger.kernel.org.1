Return-Path: <stable+bounces-177987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB17CB476C1
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38341BC2C55
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301C285050;
	Sat,  6 Sep 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DO6KqX4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD61C84B8
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185683; cv=none; b=tRyT89S44Otp3SaaIMkIm4YSc1Cilh8OnFxSrv71kxHUxR3eYS0whAbSn5RnChrm11fhk0y81lLkhVYpR5EkxOU9GiZo5Ff5cNvyDOYBtMU3Dwy6hXyGy+Tm0nF7nlKYYVCiak465Wcy6RW4QX9imKVlpzIX4UwlYk1y7i2y8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185683; c=relaxed/simple;
	bh=VQe+C+8L5gsLCSANHlTig4HUwaco85cvxwTr4L3ieaY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sThnpm2c4ZzOdz+cmftsJp9yKUmmbboUbmvcMWYvAThZJ3DyDDCnvhc+DoeKU/7Ej49kR62Mf0+/K93jiuW22SmB7SSKQAeBpmPSp37KLlK/exHWQ2K147xVF11LntKU4i6RrBtcGIwRGou+A7W6Q/2xYDV7Q7YH9sYoVWa8uV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DO6KqX4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98BCC4CEE7;
	Sat,  6 Sep 2025 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757185683;
	bh=VQe+C+8L5gsLCSANHlTig4HUwaco85cvxwTr4L3ieaY=;
	h=Subject:To:Cc:From:Date:From;
	b=DO6KqX4C+uoOhDk8+cl8BM1CciEhTTTPHIwJsyJf8960IPq4qgk6SYeB4UU7ivXpL
	 zyzdN1IZS7PuDNGl5HHrlg25CvlAwXXWQLqxSvyk+/z6NeWxyggHfZ4NNW1C9EKdEc
	 w06LSt+288v7zSdjO43mXSDhWlgzNyHbgOYQ7PkA=
Subject: FAILED: patch "[PATCH] kasan: fix GCC mem-intrinsic prefix with sw tags" failed to apply to 6.6-stable tree
To: ada.coupriediaz@arm.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dvyukov@google.com,elver@google.com,glider@google.com,mark.rutland@arm.com,mpe@ellerman.id.au,nathan@kernel.org,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com,yeoreum.yun@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 21:08:00 +0200
Message-ID: <2025090600-revenue-discharge-a6c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 51337a9a3a404fde0f5337662ffc7699793dfeb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090600-revenue-discharge-a6c4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51337a9a3a404fde0f5337662ffc7699793dfeb5 Mon Sep 17 00:00:00 2001
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Date: Thu, 21 Aug 2025 13:07:35 +0100
Subject: [PATCH] kasan: fix GCC mem-intrinsic prefix with sw tags

GCC doesn't support "hwasan-kernel-mem-intrinsic-prefix", only
"asan-kernel-mem-intrinsic-prefix"[0], while LLVM supports both.  This is
already taken into account when checking
"CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX", but not in the KASAN Makefile
adding those parameters when "CONFIG_KASAN_SW_TAGS" is enabled.

Replace the version check with "CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX",
which already validates that mem-intrinsic prefix parameter can be used,
and choose the correct name depending on compiler.

GCC 13 and above trigger "CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX" which
prevents `mem{cpy,move,set}()` being redefined in "mm/kasan/shadow.c"
since commit 36be5cba99f6 ("kasan: treat meminstrinsic as builtins in
uninstrumented files"), as we expect the compiler to prefix those calls
with `__(hw)asan_` instead.  But as the option passed to GCC has been
incorrect, the compiler has not been emitting those prefixes, effectively
never calling the instrumented versions of `mem{cpy,move,set}()` with
"CONFIG_KASAN_SW_TAGS" enabled.

If "CONFIG_FORTIFY_SOURCES" is enabled, this issue would be mitigated as
it redefines `mem{cpy,move,set}()` and properly aliases the
`__underlying_mem*()` that will be called to the instrumented versions.

Link: https://lkml.kernel.org/r/20250821120735.156244-1-ada.coupriediaz@arm.com
Link: https://gcc.gnu.org/onlinedocs/gcc-13.4.0/gcc/Optimize-Options.html [0]
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Fixes: 36be5cba99f6 ("kasan: treat meminstrinsic as builtins in uninstrumented files")
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Marc Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 693dbbebebba..0ba2aac3b8dc 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -86,10 +86,14 @@ kasan_params += hwasan-instrument-stack=$(stack_enable) \
 		hwasan-use-short-granules=0 \
 		hwasan-inline-all-checks=0
 
-# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
-ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
-	kasan_params += hwasan-kernel-mem-intrinsic-prefix=1
-endif
+# Instrument memcpy/memset/memmove calls by using instrumented __(hw)asan_mem*().
+ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	ifdef CONFIG_CC_IS_GCC
+		kasan_params += asan-kernel-mem-intrinsic-prefix=1
+	else
+		kasan_params += hwasan-kernel-mem-intrinsic-prefix=1
+	endif
+endif # CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 
 endif # CONFIG_KASAN_SW_TAGS
 


