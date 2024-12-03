Return-Path: <stable+bounces-98144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886539E2A7B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5939C162310
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A7A1FC7C6;
	Tue,  3 Dec 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26OAUp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851471FA840
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249587; cv=none; b=SnaEPZTREwD/YiWtFfGb6FQYHGQkXFCjmG95PPUq2DbzNZnUyOf8yyOcnobMQg9DnBSU4GWC6cJoh3NMKctxoqf6IdfHu/Or5gUV70Vh2kKWdY3UyXgnoZA+y01PBLAqRyGDVY1MlGfOhKhhYmEL5EcdgR7GEDbwfFPgfb8KPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249587; c=relaxed/simple;
	bh=qLsGyyWHddAJIGqhcafat1lla4GPmK3yLf+SvyW8PcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8/eR6hDc8ZJundWuneNJzQYXAlAZCKJf7fCEkFdapz5Tgd8MYCwVNa/W9sZhQLt8SeZhg7FqYIUvl+hlm1bZFi53rrgPPSz6A7mBGY/BvBYmxsoV6zlrWDkKF5cb1yNL2/mhGl4ZaXaslvFYAPoTlb3YjvMPrr6HZMIYHRulw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26OAUp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F886C4CECF;
	Tue,  3 Dec 2024 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249587;
	bh=qLsGyyWHddAJIGqhcafat1lla4GPmK3yLf+SvyW8PcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n26OAUp84ehMw8oPXz2CJNTsfEhkOo+Xgqwn98702xHPPsvVPF+Sn1WFD24O53lzQ
	 3XJ6OO7v/d+erXXZo/+HFTfZDFJYerA9EtKykw/HzyvnChIMsA5hxZ+vavE96Yfz5a
	 i1IlWn7PaJj58ozbZ1kdec3V9nHAOeVRsOf3KZTyDaTd7EbO5X3K2V2IiHiV6IsN0x
	 xBUT6/uNd7pTDbRFKWiGsurkV3Eu7FTUTLi2heh1cL4NERH/uvjKq22Mg3+5rHVfr2
	 oRZ8VPFxr4NlvvPDdyIWdNl8NMofAPEkzwEiTiiOpTwGi5RO6PPLLJio+EccHTF3kb
	 p8polMq7RafrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Hendrik Farr <kernel@jfarr.cc>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Tue,  3 Dec 2024 13:13:04 -0500
Message-ID: <20241202122847-9d04cc548d1b3f9d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202162307.325302-1-kernel@jfarr.cc>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: f06e108a3dc53c0f5234d18de0bd224753db5019


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f06e108a3dc53 ! 1:  22bf799c95105 Compiler Attributes: disable __counted_by for clang < 19.1.3
    @@ Metadata
      ## Commit message ##
         Compiler Attributes: disable __counted_by for clang < 19.1.3
     
    +    commit f06e108a3dc53c0f5234d18de0bd224753db5019 upstream.
    +
         This patch disables __counted_by for clang versions < 19.1.3 because
         of the two issues listed below. It does this by introducing
         CONFIG_CC_HAS_COUNTED_BY.
    @@ Commit message
         Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
         Link: https://lore.kernel.org/r/20241029140036.577804-2-kernel@jfarr.cc
         Signed-off-by: Kees Cook <kees@kernel.org>
    +    (cherry picked from commit f06e108a3dc53c0f5234d18de0bd224753db5019)
    +    Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
     
      ## drivers/misc/lkdtm/bugs.c ##
     @@ drivers/misc/lkdtm/bugs.c: static void lkdtm_FAM_BOUNDS(void)
    @@ drivers/misc/lkdtm/bugs.c: static void lkdtm_FAM_BOUNDS(void)
      	pr_err("FAIL: survived access of invalid flexible array member index!\n");
      
     -	if (!__has_attribute(__counted_by__))
    +-		pr_warn("This is expected since this %s was built a compiler supporting __counted_by\n",
     +	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
    - 		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
    ++		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
      			lkdtm_kernel_info);
      	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
    + 		pr_expected_config(CONFIG_UBSAN_TRAP);
     
      ## include/linux/compiler_attributes.h ##
     @@
    @@ include/linux/compiler_attributes.h
      #endif
      
     -/*
    -- * Optional: only supported since gcc >= 15
    +- * Optional: only supported since gcc >= 14
     - * Optional: only supported since clang >= 18
     - *
     - *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
    -- * clang: https://github.com/llvm/llvm-project/pull/76348
    +- * clang: https://reviews.llvm.org/D148381
     - */
     -#if __has_attribute(__counted_by__)
     -# define __counted_by(member)		__attribute__((__counted_by__(member)))
    @@ include/linux/compiler_types.h: struct ftrace_likely_data {
     +# define __counted_by(member)
     +#endif
     +
    - /*
    -  * Apply __counted_by() when the Endianness matches to increase test coverage.
    -  */
    + /* Section for code which can't be instrumented at all */
    + #define __noinstr_section(section)					\
    + 	noinline notrace __attribute((__section__(section)))		\
     
      ## init/Kconfig ##
     @@ init/Kconfig: config CC_HAS_ASM_INLINE
    @@ init/Kconfig: config CC_HAS_ASM_INLINE
      config PAHOLE_VERSION
      	int
      	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
    -
    - ## lib/overflow_kunit.c ##
    -@@ lib/overflow_kunit.c: static void DEFINE_FLEX_test(struct kunit *test)
    - {
    - 	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
    - 	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
    --#if __has_attribute(__counted_by__)
    -+#ifdef CONFIG_CC_HAS_COUNTED_BY
    - 	int expected_raw_size = sizeof(struct foo);
    - #else
    - 	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

