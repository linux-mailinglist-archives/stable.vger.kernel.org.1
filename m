Return-Path: <stable+bounces-96086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1229E0691
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D89B282EA1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E2207A03;
	Mon,  2 Dec 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ak3XiGim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C30205E23
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152165; cv=none; b=isBT2kBk42ibP6VK8exeVaSBj/KNhDGMkmBqA0AoL2wUwdbdPyU5RujgwujOQJbNqLpdmNtZeAP+QDLtglqWZ6Y4Vbbnnkuqx91SsP9hacu1ltJPSXuL+LGEFXeECQso7MwcS5PRrkTM4bSItPGKHVy60WQwfL02vrJaV+3xxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152165; c=relaxed/simple;
	bh=y/aIyBX1GUmV+Ta+DTe4viW6okjvCb1zDptBkua8pYY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lz2GN+9uljLHDv9uGTGH+KaCZ9GsCGQnsS+PR18y4e7+Aom40YnvCKS1lQ8w4GQkC8vkZ4ktYPJbodKb+a2JarEmubZCnznGkkRKPImVQgb+rqI/Z34gBBbX3GvOdgXzaeehLuSFC2xHHKiVkDron74NPa/SSoJP7bK/skQQATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ak3XiGim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A9EC4CED1;
	Mon,  2 Dec 2024 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733152164;
	bh=y/aIyBX1GUmV+Ta+DTe4viW6okjvCb1zDptBkua8pYY=;
	h=Subject:To:Cc:From:Date:From;
	b=ak3XiGimiNoLdCjmhge9Shf0FrYhgTrZwJEnj9JkyMeobL9pEIWYvZD+1bxo9ZmwW
	 jfka1zq3pWbUs18q121L7afg/0HfFJ9ZV4KbfVN4lK4UKAP+ABeGNuyBsUeZjGeOb4
	 6W+rvOaBJfE8HB0QOOJbJElzyvJjI2mnmb6e1MKo=
Subject: FAILED: patch "[PATCH] Compiler Attributes: disable __counted_by for clang < 19.1.3" failed to apply to 6.6-stable tree
To: kernel@jfarr.cc,kees@kernel.org,nathan@kernel.org,ojeda@kernel.org,oliver.sang@intel.com,thorsten.blum@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:09:21 +0100
Message-ID: <2024120221-gizzard-thermos-ba19@gregkh>
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
git cherry-pick -x f06e108a3dc53c0f5234d18de0bd224753db5019
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120221-gizzard-thermos-ba19@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f06e108a3dc53c0f5234d18de0bd224753db5019 Mon Sep 17 00:00:00 2001
From: Jan Hendrik Farr <kernel@jfarr.cc>
Date: Tue, 29 Oct 2024 15:00:36 +0100
Subject: [PATCH] Compiler Attributes: disable __counted_by for clang < 19.1.3

This patch disables __counted_by for clang versions < 19.1.3 because
of the two issues listed below. It does this by introducing
CONFIG_CC_HAS_COUNTED_BY.

1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
https://github.com/llvm/llvm-project/pull/110497

2. clang < 19.1.3 has a bug that can lead to __bdos being off by 4:
https://github.com/llvm/llvm-project/pull/112636

Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
Cc: stable@vger.kernel.org # 6.6.x: 16c31dd7fdf6: Compiler Attributes: counted_by: bump min gcc version
Cc: stable@vger.kernel.org # 6.6.x: 2993eb7a8d34: Compiler Attributes: counted_by: fixup clang URL
Cc: stable@vger.kernel.org # 6.6.x: 231dc3f0c936: lkdtm/bugs: Improve warning message for compilers without counted_by support
Cc: stable@vger.kernel.org # 6.6.x
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com
Link: https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://lore.kernel.org/r/20241029140036.577804-2-kernel@jfarr.cc
Signed-off-by: Kees Cook <kees@kernel.org>

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 62ba01525479..376047beea3d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -445,7 +445,7 @@ static void lkdtm_FAM_BOUNDS(void)
 
 	pr_err("FAIL: survived access of invalid flexible array member index!\n");
 
-	if (!__has_attribute(__counted_by__))
+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
 		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
 			lkdtm_kernel_info);
 	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 32284cd26d52..c16d4199bf92 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,19 +94,6 @@
 # define __copy(symbol)
 #endif
 
-/*
- * Optional: only supported since gcc >= 15
- * Optional: only supported since clang >= 18
- *
- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://github.com/llvm/llvm-project/pull/76348
- */
-#if __has_attribute(__counted_by__)
-# define __counted_by(member)		__attribute__((__counted_by__(member)))
-#else
-# define __counted_by(member)
-#endif
-
 /*
  * Optional: not supported by gcc
  * Optional: only supported since clang >= 14.0
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe..639be0f30b45 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -323,6 +323,25 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/*
+ * Optional: only supported since gcc >= 15
+ * Optional: only supported since clang >= 18
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://github.com/llvm/llvm-project/pull/76348
+ *
+ * __bdos on clang < 19.1.2 can erroneously return 0:
+ * https://github.com/llvm/llvm-project/pull/110497
+ *
+ * __bdos on clang < 19.1.3 can be off by 4:
+ * https://github.com/llvm/llvm-project/pull/112636
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /*
  * Apply __counted_by() when the Endianness matches to increase test coverage.
  */
diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0fe..92f106cf5572 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -116,6 +116,15 @@ config CC_HAS_ASM_INLINE
 config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 
+config CC_HAS_COUNTED_BY
+	# TODO: when gcc 15 is released remove the build test and add
+	# a gcc version check
+	def_bool $(success,echo 'struct flex { int count; int array[] __attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
+	# clang needs to be at least 19.1.3 to avoid __bdos miscalculations
+	# https://github.com/llvm/llvm-project/pull/110497
+	# https://github.com/llvm/llvm-project/pull/112636
+	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 2abc78367dd1..5222c6393f11 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1187,7 +1187,7 @@ static void DEFINE_FLEX_test(struct kunit *test)
 {
 	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
 	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
-#if __has_attribute(__counted_by__)
+#ifdef CONFIG_CC_HAS_COUNTED_BY
 	int expected_raw_size = sizeof(struct foo);
 #else
 	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);


