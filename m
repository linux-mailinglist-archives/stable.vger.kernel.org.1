Return-Path: <stable+bounces-121304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EAAA55639
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33229174D83
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D348D26BDB5;
	Thu,  6 Mar 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpt/bbSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D925A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288276; cv=none; b=hvNyLzzvihcbNsk5ppLzxx+VEgiPLzIqvYBaT6xBkdE3ptakkKH7ziTNiX8fxyfbmx+V3CAkdWnHk1+lXmzRTYlF/LNH+vWlyXCY2dWF5I57RoWP3fuU/hFjzronzZZzY+DNalbELdaBVru+kh4XXx5WT3eV7R1jdUO7un7Gyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288276; c=relaxed/simple;
	bh=OxvKLNPFscSWo3CW1Gxj4dZPPkmjrDAI4ilx/4Y8coY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjoErT3xSIiP4TXgsKVru6yEv8/w0QYToaRGr4rHWp9ZlCjK7TTCTnnclfMT9vWagQS4//AbWCYEcn62S81bNvyA1qBN7iTmSg9hiA6JGoy3To1kwyABa1LHv/fIY2GApWAjRs90qSHgQFyPt7eEgyONACj6AH7hUGAUDsGQu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpt/bbSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8258CC4CEE4;
	Thu,  6 Mar 2025 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288276;
	bh=OxvKLNPFscSWo3CW1Gxj4dZPPkmjrDAI4ilx/4Y8coY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mpt/bbSpB+N5EiyLbEv5A0BEB5Ubpu9CUxrNyGrIoS2WZ650by7hQOiRYOIXMyfZi
	 G6cP+8+mi6bVq5kLI0JYHOUD3X3QwMPtmiVQOCpAgUCjuw/kzoNY/jqLIaaKkmkwqi
	 Bm4oUO/+3Horh2vTN/zXq0vWJb9EO5l/I9AuDVKT/jzTroui3wua8jWA1PsB2v7Jcq
	 ctnEc+jn/KuVrV8Wa/g/VRoIcww11y4hAf+z14Dh5bkn+c4V/0+SBS9d1GyOjfuIBF
	 MYfHQ1jTwhA5tKs4g09zNlCP7MSUlz2TNmwpCOcZ82z321cWupWptroeMELPVjNkVB
	 5+5kKmztMJS7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 3/3] overflow: Allow mixed type arguments
Date: Thu,  6 Mar 2025 14:11:14 -0500
Message-Id: <20250306130612-2c19142eb37b1aa2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306010756.719024-4-florian.fainelli@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 3/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: d219d2a9a92e39aa92799efe8f2aa21259b6dd82

WARNING: Author mismatch between patch and found commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d219d2a9a92e3 ! 1:  c363635d1c456 overflow: Allow mixed type arguments
    @@ Commit message
         Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
         Tested-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    [florian: Drop changes to lib/test_overflow.c]
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## include/linux/overflow.h ##
     @@ include/linux/overflow.h: static inline bool __must_check __must_check_overflow(bool overflow)
    - 	return unlikely(overflow);
      }
      
    + #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
     -/*
     - * For simplicity and code hygiene, the fallback code below insists on
     - * a, b and *d having the same type (similar to the min() and max()
    @@ include/linux/overflow.h: static inline bool __must_check __must_check_overflow(
     +#define check_mul_overflow(a, b, d)	\
     +	__must_check_overflow(__builtin_mul_overflow(a, b, d))
      
    - /** check_shl_overflow() - Calculate a left-shifted value and check overflow
    -  *
    -
    - ## lib/overflow_kunit.c ##
    -@@
    - #include <linux/types.h>
    - #include <linux/vmalloc.h>
    - 
    --#define DEFINE_TEST_ARRAY(t)			\
    --	static const struct test_ ## t {	\
    --		t a, b;				\
    --		t sum, diff, prod;		\
    --		bool s_of, d_of, p_of;		\
    --	} t ## _tests[]
    -+#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
    -+	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
    -+		t1 a;						\
    -+		t2 b;						\
    -+		t sum, diff, prod;				\
    -+		bool s_of, d_of, p_of;				\
    -+	} t1 ## _ ## t2 ## __ ## t ## _tests[]
    -+
    -+#define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
    - 
    - DEFINE_TEST_ARRAY(u8) = {
    - 	{0, 0, 0, 0, 0, false, false, false},
    -@@ lib/overflow_kunit.c: DEFINE_TEST_ARRAY(s64) = {
    - };
    - #endif
    - 
    --#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
    --	t _r;							\
    --	bool _of;						\
    --								\
    --	_of = check_ ## op ## _overflow(a, b, &_r);		\
    --	KUNIT_EXPECT_EQ_MSG(test, _of, of,			\
    -+#define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
    -+	int _a_orig = a, _a_bump = a + 1;				\
    -+	int _b_orig = b, _b_bump = b + 1;				\
    -+	bool _of;							\
    -+	t _r;								\
    -+									\
    -+	_of = check_ ## op ## _overflow(a, b, &_r);			\
    -+	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
    - 		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
    --		a, b, of ? "" : " not", #t);			\
    --	KUNIT_EXPECT_EQ_MSG(test, _r, r,			\
    -+		a, b, of ? "" : " not", #t);				\
    -+	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
    - 		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
    --		a, b, r, _r, #t);				\
    -+		a, b, r, _r, #t);					\
    -+	/* Check for internal macro side-effects. */			\
    -+	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
    -+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
    -+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
    - } while (0)
    - 
    --#define DEFINE_TEST_FUNC(t, fmt)					\
    --static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
    -+#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
    -+static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
    - {							   		\
    - 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
    - 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
    -@@ lib/overflow_kunit.c: static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
    - 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
    - }									\
    - 									\
    --static void t ## _overflow_test(struct kunit *test) {			\
    -+static void n ## _overflow_test(struct kunit *test) {			\
    - 	unsigned i;							\
    - 									\
    --	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
    --		do_test_ ## t(test, &t ## _tests[i]);			\
    -+	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
    -+		do_test_ ## n(test, &n ## _tests[i]);			\
    - 	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
    --		ARRAY_SIZE(t ## _tests), #t);				\
    -+		ARRAY_SIZE(n ## _tests), #n);				\
    - }
    - 
    -+#define DEFINE_TEST_FUNC(t, fmt)					\
    -+	DEFINE_TEST_FUNC_TYPED(t ## _ ## t ## __ ## t, t, fmt)
    -+
    - DEFINE_TEST_FUNC(u8, "%d");
    - DEFINE_TEST_FUNC(s8, "%d");
    - DEFINE_TEST_FUNC(u16, "%d");
    -@@ lib/overflow_kunit.c: DEFINE_TEST_FUNC(u64, "%llu");
    - DEFINE_TEST_FUNC(s64, "%lld");
    - #endif
    - 
    -+DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
    -+	{0, 0, 0, 0, 0, false, false, false},
    -+	{U8_MAX, 2, 1, U8_MAX - 2, U8_MAX - 1, true, false, true},
    -+	{U8_MAX + 1, 0, 0, 0, 0, true, true, false},
    -+};
    -+DEFINE_TEST_FUNC_TYPED(u32_u32__u8, u8, "%d");
    -+
    -+DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
    -+	{0, 0, 0, 0, 0, false, false, false},
    -+	{U32_MAX, 0, -1, -1, 0, true, true, false},
    -+};
    -+DEFINE_TEST_FUNC_TYPED(u32_u32__int, int, "%d");
    -+
    -+DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
    -+	{0, 0, 0, 0, 0, false, false, false},
    -+	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
    -+	{1, 2, 3, -1, 2, false, false, false},
    -+};
    -+DEFINE_TEST_FUNC_TYPED(u8_u8__int, int, "%d");
    -+
    -+DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
    -+	{0, 0, 0, 0, 0, false, false, false},
    -+	{1, 2, 3, U8_MAX, 2, false, true, false},
    -+	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
    -+};
    -+DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
    -+
    - static void overflow_shift_test(struct kunit *test)
    - {
    - 	int count = 0;
    -@@ lib/overflow_kunit.c: static void overflow_size_helpers_test(struct kunit *test)
    - }
    + #else
      
    - static struct kunit_case overflow_test_cases[] = {
    --	KUNIT_CASE(u8_overflow_test),
    --	KUNIT_CASE(s8_overflow_test),
    --	KUNIT_CASE(u16_overflow_test),
    --	KUNIT_CASE(s16_overflow_test),
    --	KUNIT_CASE(u32_overflow_test),
    --	KUNIT_CASE(s32_overflow_test),
    -+	KUNIT_CASE(u8_u8__u8_overflow_test),
    -+	KUNIT_CASE(s8_s8__s8_overflow_test),
    -+	KUNIT_CASE(u16_u16__u16_overflow_test),
    -+	KUNIT_CASE(s16_s16__s16_overflow_test),
    -+	KUNIT_CASE(u32_u32__u32_overflow_test),
    -+	KUNIT_CASE(s32_s32__s32_overflow_test),
    - /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
    - #if BITS_PER_LONG == 64
    --	KUNIT_CASE(u64_overflow_test),
    --	KUNIT_CASE(s64_overflow_test),
    -+	KUNIT_CASE(u64_u64__u64_overflow_test),
    -+	KUNIT_CASE(s64_s64__s64_overflow_test),
    - #endif
    -+	KUNIT_CASE(u32_u32__u8_overflow_test),
    -+	KUNIT_CASE(u32_u32__int_overflow_test),
    -+	KUNIT_CASE(u8_u8__int_overflow_test),
    -+	KUNIT_CASE(int_int__u8_overflow_test),
    - 	KUNIT_CASE(overflow_shift_test),
    - 	KUNIT_CASE(overflow_allocation_test),
    - 	KUNIT_CASE(overflow_size_helpers_test),
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

