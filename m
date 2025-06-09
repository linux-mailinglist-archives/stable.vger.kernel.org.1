Return-Path: <stable+bounces-152020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CECAD1E8F
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D7E7A3B6A
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F262580EC;
	Mon,  9 Jun 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN5LXHVH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D6257AF4;
	Mon,  9 Jun 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474892; cv=none; b=Xv9Sox5v6ApY7e755VxsvcBevIVtMDShDkG6rFldvbuU/6qjWv5ZWjfvGW+7833A1YOBpW65gqRQcz7nK2lyC1Ko4Nt1shFlci4rSSt2HHe39OiDQdMT20ip1VCCbVnztjWCztnq0Qerjdy3IZhAuxXCZtR5/mRw7nbA9Ay5+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474892; c=relaxed/simple;
	bh=XYVils960f1E8mwod6msEyFbYvJt8XnpCDrKXIKzUvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIibjaKYZDWTrYxXQOz9CV1aO0f87VSOmNtinD9qpMow9UADhLMEzXwlXQQr+RicdrHS/t6/Umh+5gS70Zw09pJxpdnnanxihnjn+Q91KQisCCLkygqfZgISPThwg4yveBwYP6W7/EwJREqs4MMk4yIQ2LR2HCtSbqYKv1nWu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN5LXHVH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749474891; x=1781010891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYVils960f1E8mwod6msEyFbYvJt8XnpCDrKXIKzUvw=;
  b=eN5LXHVHnTUJ+q4PJJW/9N4QgvYc4hIwWNmFwOjw0gTzdGndkOp9kbaK
   65zgK5arKfHDFfXEd9Iu8XIEuZ1Z53QjxzdQYz2VgVyHVmPnWKJC54B4D
   wIGhiN//aQEKLHqKBpq378W5Q5/9p9XRX3hqzT98V2iRIcKOZN3T+TTfJ
   RdOkMJGbgbWEyp3qxa+xD3AJb2dP/+YQHNYXULt813TaRiooC0B/s+sFJ
   RvZa/Eg/uhsLA3aOWzr3V8hE0gmoHL8o1V9dVgGNCYgKmRoCHwu+WiY3Q
   fdUQR61zO3O5TfzndPxCcItuRUsrHWVmL48471K6/c8o3rOhgHfC9FHWn
   A==;
X-CSE-ConnectionGUID: BrbT2VVBSBWEHlJFoVTUvA==
X-CSE-MsgGUID: LHUQt2tXTCKbRoNqUUAA4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51694301"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51694301"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:14:46 -0700
X-CSE-ConnectionGUID: 2I/Fmt4wTfunuifztq713g==
X-CSE-MsgGUID: FjJp5EQwQeGq0jKHe6+zOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="177451053"
Received: from intelmailrelay-02.habana-labs.com ([10.111.11.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:14:41 -0700
Received: internal info suppressed
Received: from dhirschfeld-vm-u24.habana-labs.com (localhost [127.0.0.1])
	by dhirschfeld-vm-u24.habana-labs.com (8.18.1/8.18.1/Debian-2) with SMTP id 559DERg31077121;
	Mon, 9 Jun 2025 16:14:28 +0300
Date: Mon, 9 Jun 2025 16:14:27 +0300
From: Dafna Hirschfeld <dafna.hirschfeld@intel.com>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: kees@kernel.org, nathan@kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
        thorsten.blum@toblux.com, ardb@kernel.org, oliver.sang@intel.com,
        gustavoars@kernel.org, kent.overstreet@linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        tavianator@tavianator.com, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang
 < 19.1.3
Message-ID: <paezt3cuux5kwv7dvyuo4rrff2felwzmjunkdpyxqjp3fbnyzn@rcdj4xq6djio>
References: <20241029140036.577804-1-kernel@jfarr.cc>
 <20241029140036.577804-2-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20241029140036.577804-2-kernel@jfarr.cc>

On 29.10.2024 15:00, Jan Hendrik Farr wrote:
>This patch disables __counted_by for clang versions < 19.1.3 because
>of the two issues listed below. It does this by introducing
>CONFIG_CC_HAS_COUNTED_BY.
>
>1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
>https://github.com/llvm/llvm-project/pull/110497
>
>2. clang < 19.1.3 has a bug that can lead to __bdos being off by 4:
>https://github.com/llvm/llvm-project/pull/112636
>
>Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
>Cc: stable@vger.kernel.org # 6.6.x: 16c31dd7fdf6: Compiler Attributes: counted_by: bump min gcc version
>Cc: stable@vger.kernel.org # 6.6.x: 2993eb7a8d34: Compiler Attributes: counted_by: fixup clang URL
>Cc: stable@vger.kernel.org # 6.6.x: 231dc3f0c936: lkdtm/bugs: Improve warning message for compilers without counted_by support
>Cc: stable@vger.kernel.org # 6.6.x
>Reported-by: Nathan Chancellor <nathan@kernel.org>
>Closes: https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
>Reported-by: kernel test robot <oliver.sang@intel.com>
>Closes: https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com
>Link: https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b
>Suggested-by: Nathan Chancellor <nathan@kernel.org>
>Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
>Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>Tested-by: Nathan Chancellor <nathan@kernel.org>
>Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>---
> drivers/misc/lkdtm/bugs.c           |  2 +-
> include/linux/compiler_attributes.h | 13 -------------
> include/linux/compiler_types.h      | 19 +++++++++++++++++++
> init/Kconfig                        |  9 +++++++++
> lib/overflow_kunit.c                |  2 +-
> 5 files changed, 30 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
>index 62ba01525479..376047beea3d 100644
>--- a/drivers/misc/lkdtm/bugs.c
>+++ b/drivers/misc/lkdtm/bugs.c
>@@ -445,7 +445,7 @@ static void lkdtm_FAM_BOUNDS(void)
>
> 	pr_err("FAIL: survived access of invalid flexible array member index!\n");
>
>-	if (!__has_attribute(__counted_by__))
>+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
> 		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
> 			lkdtm_kernel_info);
> 	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
>diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
>index 32284cd26d52..c16d4199bf92 100644
>--- a/include/linux/compiler_attributes.h
>+++ b/include/linux/compiler_attributes.h
>@@ -94,19 +94,6 @@
> # define __copy(symbol)
> #endif
>
>-/*
>- * Optional: only supported since gcc >= 15
>- * Optional: only supported since clang >= 18
>- *
>- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
>- * clang: https://github.com/llvm/llvm-project/pull/76348
>- */
>-#if __has_attribute(__counted_by__)
>-# define __counted_by(member)		__attribute__((__counted_by__(member)))
>-#else
>-# define __counted_by(member)
>-#endif
>-

Why is the define of __counted_by moved from here (compiler_attributes.h)
to a different location (compiler_types.h) ?
I am asking this because I try to compile an out of tree kernel module with ofed headers.
in the ofed header of compiler_types.h there is an added include of types.h:

#include_next <linux/compiler_attributes.h>
#include <linux/types.h>

so what happen is that __counted_by is defined in types.h, and then I get a compilation error:

././include/linux/compiler_types.h:323: error: "__counted_by" redefined [-Werror]

I am not sure yet how this should be fixed.
Thank you,
Dafna





> /*
>  * Optional: not supported by gcc
>  * Optional: only supported since clang >= 14.0
>diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>index 1a957ea2f4fe..639be0f30b45 100644
>--- a/include/linux/compiler_types.h
>+++ b/include/linux/compiler_types.h
>@@ -323,6 +323,25 @@ struct ftrace_likely_data {
> #define __no_sanitize_or_inline __always_inline
> #endif
>
>+/*
>+ * Optional: only supported since gcc >= 15
>+ * Optional: only supported since clang >= 18
>+ *
>+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
>+ * clang: https://github.com/llvm/llvm-project/pull/76348
>+ *
>+ * __bdos on clang < 19.1.2 can erroneously return 0:
>+ * https://github.com/llvm/llvm-project/pull/110497
>+ *
>+ * __bdos on clang < 19.1.3 can be off by 4:
>+ * https://github.com/llvm/llvm-project/pull/112636
>+ */
>+#ifdef CONFIG_CC_HAS_COUNTED_BY
>+# define __counted_by(member)		__attribute__((__counted_by__(member)))
>+#else
>+# define __counted_by(member)
>+#endif
>+
> /*
>  * Apply __counted_by() when the Endianness matches to increase test coverage.
>  */
>diff --git a/init/Kconfig b/init/Kconfig
>index 530a382ee0fe..92f106cf5572 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -116,6 +116,15 @@ config CC_HAS_ASM_INLINE
> config CC_HAS_NO_PROFILE_FN_ATTR
> 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
>
>+config CC_HAS_COUNTED_BY
>+	# TODO: when gcc 15 is released remove the build test and add
>+	# a gcc version check
>+	def_bool $(success,echo 'struct flex { int count; int array[] __attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
>+	# clang needs to be at least 19.1.3 to avoid __bdos miscalculations
>+	# https://github.com/llvm/llvm-project/pull/110497
>+	# https://github.com/llvm/llvm-project/pull/112636
>+	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
>+
> config PAHOLE_VERSION
> 	int
> 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
>diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
>index 2abc78367dd1..5222c6393f11 100644
>--- a/lib/overflow_kunit.c
>+++ b/lib/overflow_kunit.c
>@@ -1187,7 +1187,7 @@ static void DEFINE_FLEX_test(struct kunit *test)
> {
> 	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
> 	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
>-#if __has_attribute(__counted_by__)
>+#ifdef CONFIG_CC_HAS_COUNTED_BY
> 	int expected_raw_size = sizeof(struct foo);
> #else
> 	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
>-- 
>2.47.0
>

