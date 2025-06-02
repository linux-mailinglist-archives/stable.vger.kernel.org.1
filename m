Return-Path: <stable+bounces-148669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3651ACA5AD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3407188D29C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C8308086;
	Sun,  1 Jun 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRGhZZlX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55D26C398;
	Sun,  1 Jun 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821058; cv=none; b=TB/POjr4MK/ragAEmH1kd4NC/THhQ+b6Kaur6i/e6vYaPFfDTFaGaW9fw2JI24rfAVEyJn0Ov6NIJcGzy4+owbSUmsZqQRI2XrafpkH5SyLiZj9/php2ccLrCWorrpAsWyeaRreO2VjWuelaTJMOfj7xKsA1jh1ugwc00BL5Rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821058; c=relaxed/simple;
	bh=PZXekloZst164va3gdtMUsb5TqdDdEpP6i7c1kQ7+HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1EdY+c1/G84skT6G+X5iCBKlbwpAC0OzqZeaBc2LyzQeRolkmIHgwMW4TQqRccbAoh/X8nEmoN+P1xNlNPNIMWbuGjXMysLguTGQgX7r+QFG6jagC/QhW2+OEynnQJJrKyNxrSSy6gluGyQbVcWMDMhqggo30p5YZddocLbnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRGhZZlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E809C4CEF2;
	Sun,  1 Jun 2025 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821058;
	bh=PZXekloZst164va3gdtMUsb5TqdDdEpP6i7c1kQ7+HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRGhZZlXs1D1N6XH286C9atz8pnVG9CywB5JZYCEuXqLyYRIc+4nk0QuZyvnlleLZ
	 yZISdfhhnHRK7ZrQX3SKZgMv8RlK+CDclhxSTnyMDusVlB6Qve+eqw6J+ysEpKuAzL
	 /dio175dPD645a8DO0+pDd9Q2EttMToBQ21hO81SEQi/NR2pDASATuENcj0bGdqlgS
	 gnbCwh4fceLQ+/PlWrUN5TvLPOAYl4JHIxLv8gxgUEHZK3wYOaBVZD7wmZW9UKHEUO
	 GRVbUq92M9ochrPcs2j+YEwq4jVRKH/Lx28GlUQALs1YLlFdRRyFKTYooIPWcynA6v
	 n+X1Usb4w6Dsw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	linux@weissschuh.net,
	nathan@kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 91/93] tools/nolibc: use intmax definitions from compiler
Date: Sun,  1 Jun 2025 19:33:58 -0400
Message-Id: <20250601233402.3512823-91-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit e5407c0820ea5fa7117b85ed32b724af73156d63 ]

The printf format checking in the compiler uses the intmax types from
the compiler, not libc. This can lead to compiler errors.

Instead use the types already provided by the compiler.

Example issue with clang 19 for arm64:

nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uintmax_t' (aka 'unsigned long long') [-Werror,-Wformat]

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Analysis of the Code Changes The commit makes
a targeted fix to resolve compiler format checking errors by changing
the intmax type definitions in `tools/include/nolibc/stdint.h`: ```c
-typedef int64_t intmax_t; -typedef uint64_t uintmax_t; +typedef
__INTMAX_TYPE__ intmax_t; +typedef __UINTMAX_TYPE__ uintmax_t; ``` ##
Why This Should Be Backported ### 1. **Fixes Real Compilation Errors**
The commit addresses actual compiler errors that prevent successful
builds, as demonstrated by the clang 19 error message: ``` nolibc-
test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned
long') but the argument has type 'uintmax_t' (aka 'unsigned long long')
[-Werror,-Wformat] ``` This is a critical build breakage, not just a
warning. ### 2. **Small, Contained, Low-Risk Change** - Only changes 2
lines of code in a single header file - Does not modify any algorithms
or control flow - Uses well-established compiler built-ins that have
been available for decades - No risk of behavioral changes beyond fixing
the type compatibility issue ### 3. **Follows Established Pattern** The
change aligns with existing practice in the same file, which already
uses `__SIZE_TYPE__` for `size_t` definition. This demonstrates that
using compiler built-ins for fundamental types is the established
approach in nolibc. ### 4. **Cross-Platform Compatibility Fix** The
issue particularly affects: - Different compiler backends (GCC vs Clang)
- Different architectures where `long` vs `long long` sizes vary
(especially arm64) - Cross-compilation scenarios - Builds with strict
format checking enabled (`-Wformat -Werror`) ### 5. **Comparison with
Similar Commits** Looking at the reference commits provided: - **Similar
Commit #4** (Status: YES): Also fixes integer type issues in nolibc for
platform compatibility - **Similar Commit #5** (Status: YES): Also fixes
printf format mismatches with explicit stable tree marking (`Cc:
stable@vger.kernel.org`) This commit follows the same pattern of fixing
type/format compatibility issues that have been deemed worthy of
backporting. ### 6. **Tools Subsystem Stability** While this is in the
tools directory, nolibc is used for: - Kernel testing infrastructure -
Minimal userspace environments - Cross-compilation toolchains - Kernel
selftests Breaking builds in these contexts can impact kernel
development workflows across different platforms. ### 7. **No
Architectural Changes** The commit: - Doesn't introduce new features -
Doesn't change APIs - Doesn't modify kernel core functionality - Simply
ensures type consistency between compiler and library definitions ##
Conclusion This is exactly the type of targeted bug fix that stable
trees are designed for: it fixes a real compilation issue that affects
users, uses a minimal and safe approach, follows established patterns,
and has no risk of introducing regressions. The fix ensures that nolibc
can be compiled successfully across different compiler/architecture
combinations, which is essential for kernel development infrastructure.

 tools/include/nolibc/stdint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index cd79ddd6170e0..b052ad6303c38 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -39,8 +39,8 @@ typedef   size_t      uint_fast32_t;
 typedef  int64_t       int_fast64_t;
 typedef uint64_t      uint_fast64_t;
 
-typedef  int64_t           intmax_t;
-typedef uint64_t          uintmax_t;
+typedef __INTMAX_TYPE__    intmax_t;
+typedef __UINTMAX_TYPE__  uintmax_t;
 
 /* limits of integral types */
 
-- 
2.39.5


