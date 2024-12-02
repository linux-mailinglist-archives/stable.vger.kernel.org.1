Return-Path: <stable+bounces-96155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D69E0BD3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BDC1618E8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA961DE3C8;
	Mon,  2 Dec 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3SUtQ1+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF151DE3C0
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166959; cv=none; b=ef8286pTVAjiW80XvzF8iqZwajLo3rhLxx+4lOaDc9/Ezv+v+g9uP2aYCb4pG2MhaJdZMxSrivqDNLiVlvCkU3DFhAJLGwnFdgnat32rmbIZ3WLEq5/pXlv5L/MRo2JjSFsLvpgoHLYKxoAs1qgc+GiXSwCMDIbHONFJnB7ssBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166959; c=relaxed/simple;
	bh=qLsGyyWHddAJIGqhcafat1lla4GPmK3yLf+SvyW8PcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRYi6ZA+hGSIYrmFXNE/wHoIfnmKhs4gnWsZc8ZqRLMxcsCNypfNYCoPPy5zOlBfZ9TO4P7AslUACwsEbX1Rl8TobJYqbX43z+v7PA1MPMbB7gwoN6Zy+rh9B1YrJgoPPsqdocgq5IkUuEMwFpxt0+qeI+rjFPYW1HOkMEOrFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3SUtQ1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4069C4CED1;
	Mon,  2 Dec 2024 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166958;
	bh=qLsGyyWHddAJIGqhcafat1lla4GPmK3yLf+SvyW8PcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3SUtQ1+KNZu5ECqH/TnKdGPVKOJqcuZqCQ3GwZgGy1qrluyqlpO0PQLjHen+jEI5
	 nTpeTUAHVTzP/LBt70EjfFGI3ddd36HYtAhTyLg0kB2sPcEcFFw+SnwxjgSB7O9Qki
	 BDHDCuzPD/y7MnbR3brfMkbfeFhKRUslpF/lP+d/AqEvyhrBpBBYnxRTkwka77NAbA
	 TOor89Sz3VYXG5lo1VFkRykX9XWrKTalDDYjigw/eWanSmtulVYqGKnXAKZfKyWqYy
	 A65NyC/H7NEPbhTCfO0Ans8Ay573FR/frwClIi40ojpLzL1rd+weKu9+fE2+hs1SjH
	 afS+gFfx0qltw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Hendrik Farr <kernel@jfarr.cc>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Mon,  2 Dec 2024 14:15:56 -0500
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

