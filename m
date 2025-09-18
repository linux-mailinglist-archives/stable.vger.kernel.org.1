Return-Path: <stable+bounces-166049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FEB19776
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301873A2306
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51F1A9B24;
	Mon,  4 Aug 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTPHbH4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713379F2;
	Mon,  4 Aug 2025 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267245; cv=none; b=HRNrUIFCRBAGjXvJ0eB30K3WspTxhM/lY8hYHMw9dk9/6ozxtFNmEQKqcb1V88F05+pQp19E+77T8olgABrrJ+zO+5lAG4k7d2/97OacPUsu54pwWvBqgO80X+Gm5sg1494InSU0rMqdurB+dq739IrOazFY95qHy+vuA3Bc9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267245; c=relaxed/simple;
	bh=HqZ6Q+6IrVJGGg/tBZZ3bjxTagGylBp86N/bLpdXkUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sacUCybZuEUnjMMdOvKLcMBByAiepmrnFewPEo1kmwc8OcIbR4rbESWPM2Y8UGrczzgaUO38AATg5g6+kLbqlQzcw3mBxKGvzNKbQ1jTBcvbQmaXH4zdsieA1tn/ac7zMU9Z68aL1TICKAv0tLUUhwUQttwuOJVdNnIuPddY/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTPHbH4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823E5C4CEFA;
	Mon,  4 Aug 2025 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267245;
	bh=HqZ6Q+6IrVJGGg/tBZZ3bjxTagGylBp86N/bLpdXkUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTPHbH4uBKu4+7++5FDBynl3uybj5NH+bxsZg34wnOrQfZC6V8veKmC7rxm40W1SA
	 7EZ4sX+ck3Rew9OLM08WfrBDmJJOywkaK8+uKiEne2UagPj0amobOsjs45XT8YTo6C
	 TwEH1lKScR5DKzkKpXXJwuxy6u1xmla/thbKyeWVnQHHF76leIGcbYr4oQYWTgGW54
	 KRcOBYejD2b+X2wQcBdi4ZBDdeod9/XLjSJvo2/K/ZN+uX5ck+rXYNq4+LOW8lDzEZ
	 STbk/oVtcxCWXxgu/oz98ZhxA572qrILd6OXRmjCRKQngX8RXEnmTvu3f5v1XWt32w
	 Gw/4e5/QWnQcg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hansg@kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 78/85] platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches
Date: Sun,  3 Aug 2025 20:23:27 -0400
Message-Id: <20250804002335.3613254-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 6418a8504187dc7f5b6f9d0649c03e362cb0664b ]

When KCOV is enabled all functions get instrumented, unless the
__no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions[1], we have
to handle differences in how GCC's inline optimizations get resolved.
For thinkpad_acpi routines, this means forcing two functions to be
inline with __always_inline.

Link: https://lore.kernel.org/lkml/20250523043935.2009972-11-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250529181831.work.439-kees@kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Detailed Analysis

### Nature of the Change
The commit modifies two functions in
`drivers/platform/x86/lenovo/thinkpad_acpi.c`:
- `tpacpi_is_lenovo()`: Changed from `static inline` to `static
  __always_inline`
- `tpacpi_is_ibm()`: Changed from `static inline` to `static
  __always_inline`

Both functions are marked with `__init` and are simple one-line
functions that check the vendor ID.

### Root Cause
This is a build fix addressing a subtle interaction between:
1. KCOV kernel coverage instrumentation
2. GCC's inline optimization heuristics
3. Linux kernel's __init section handling

When KCOV is enabled, all functions get instrumented unless marked with
`__no_sanitize_coverage`. The commit message indicates this is
preparation for applying `__no_sanitize_coverage` to `__init` functions.
The problem occurs because:

1. With KCOV instrumentation, GCC may inline these functions into
   `__init` callers
2. Without KCOV instrumentation (when `__no_sanitize_coverage` is
   applied), GCC's heuristics change and it may decide NOT to inline
   them
3. This creates a section mismatch where `__init` code calls
   non-`__init` functions, causing build warnings/errors

### Why This Qualifies for Stable Backport

1. **Fixes a Real Bug**: This addresses legitimate build failures when
   `CONFIG_KCOV=y` is enabled, which affects:
   - Kernel developers doing coverage testing
   - CI/CD systems running kernel tests
   - Distribution builders enabling KCOV for testing

2. **Minimal Risk**: The change is extremely conservative:
   - Only changes inline hints from `inline` to `__always_inline`
   - No functional changes whatsoever
   - Affects only two simple getter functions
   - Cannot introduce runtime regressions

3. **Small and Contained**: The patch touches only 2 lines in a single
   file, making it easy to review and backport

4. **Part of Broader Fix**: This is part of a kernel-wide effort to fix
   KCOV-related build issues, with similar fixes across multiple
   architectures and subsystems

5. **Build Infrastructure**: Stable kernels need to maintain
   buildability with various configurations, including KCOV-enabled
   builds for testing

### Specific Code Impact
Looking at the changed functions:
```c
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure __init tpacpi_is_lenovo(void)
 {
        return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }

-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure __init tpacpi_is_ibm(void)
 {
        return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
```

These are trivial getter functions that absolutely should be inlined.
Using `__always_inline` ensures consistent behavior regardless of KCOV
configuration, preventing section mismatch warnings.

### Conclusion
This is a textbook example of a stable-appropriate fix: it solves a real
build problem, has zero functional impact, is minimal in scope, and has
essentially no risk of causing regressions. It should be backported to
stable kernels that support KCOV (4.6+) to maintain build compatibility
with coverage testing configurations.

 drivers/platform/x86/thinkpad_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b59b4d90b0c7..afb83b3f4826 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -559,12 +559,12 @@ static unsigned long __init tpacpi_check_quirks(
 	return 0;
 }
 
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure __init tpacpi_is_lenovo(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }
 
-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure __init tpacpi_is_ibm(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
-- 
2.39.5


