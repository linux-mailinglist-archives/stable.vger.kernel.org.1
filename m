Return-Path: <stable+bounces-121649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B13A58A4B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7703A8C1C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE17E18C322;
	Mon, 10 Mar 2025 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxgsY5x9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C817A2E8
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572876; cv=none; b=ka0UeI1n8O22Gik3qLcJSZxhPfvw0bPT0KSWPCd71FhxJElf53IAebyalk2IxN/oTj/vBEnm9qhkMmoQI6lKTUgR+bThM3VVaPFgcifC2FVrv/F5/OlnELNyq1PD9U9aYDVKzdyhbLl9Myg+REBn4bzXeeBvHdxTsk2GYtT68fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572876; c=relaxed/simple;
	bh=NmP2idozMX8rI0FXFUWrzgRugyFIqOX53Qa76jxLs40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrydIGSIvOwiJs2uhp6yFaX2ND7lhMeDr4gLvPIOjCVxIyNvuK+FaJKt4WDjaROGbcjFHk5aJRslJYFF7z5ZZckjDBZhaP5sM4DaC6BOIbnpV1+RBVq3d1iyuzky9IezgFe2LIdHiWZzwhO0SzDIL+4JwqP80G6VvWQxuNkwF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxgsY5x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6317C4CEE3;
	Mon, 10 Mar 2025 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572876;
	bh=NmP2idozMX8rI0FXFUWrzgRugyFIqOX53Qa76jxLs40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxgsY5x9l8cN83Lxhqz8+Yy+OyblGS8JfVvz3ZIB896BLhNLCTfbubzHrTZeYSJHs
	 aZBSYzBYbXOvbRePNJU2TPt6xrHRb/5Rpd6ISgepZdEhSlmZXHDw566kfL1Tp/Lvy5
	 y9eEc9qAGH0h3RETf2hJF2Qbx3zoTYBxfyjQgh+oxFhIQrxERvpa2PthrmMxlL5aFR
	 J0JrVEs17SHW14TBKKDFcbOFm2noiktD7TD3oJ6n5L91Q582wcWogI/Gcj+N4PegqE
	 6DAoz84PchW9K9cb64XsR6L7Owsb3C2KpgB6zTAeQTTqy2ANv1rIlcXuiypcq7LUix
	 YTvyOIOlhDAHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v5.4 v2 3/3] overflow: Allow mixed type arguments
Date: Sun,  9 Mar 2025 22:14:34 -0400
Message-Id: <20250309204923-a78859ad63c49372@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307130953.3427986-4-florian.fainelli@broadcom.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: d219d2a9a92e39aa92799efe8f2aa21259b6dd82

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d219d2a9a92e3 ! 1:  060e28cfd618f overflow: Allow mixed type arguments
    @@ Metadata
      ## Commit message ##
         overflow: Allow mixed type arguments
     
    +    commit d219d2a9a92e39aa92799efe8f2aa21259b6dd82 upstream
    +
         When the check_[op]_overflow() helpers were introduced, all arguments
         were required to be the same type to make the fallback macros simpler.
         However, now that the fallback macros have been removed[1], it is fine
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

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

