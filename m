Return-Path: <stable+bounces-84254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92899CF46
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD228C52F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC70115DBBA;
	Mon, 14 Oct 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMO4vXC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A341AB51B;
	Mon, 14 Oct 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917365; cv=none; b=omxmx3dCkQ9xOLiJ83QqJxl26l0Mb44iJihGtW0cWnrijkPy+/2uqYRyHoZLK2CYDN0TXrBFLTuyQgvVJRH6LRtQVBWXgW1n1QrpVz7qY0FSUjZHBKY9YCmdawI1ccZO88VrbiAlhcFA80TW8YFwF4dpDuEgzMWuXQoXypr3mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917365; c=relaxed/simple;
	bh=QMhv7oqlZZ9kk+7Jhm4nA2WTeV8kHu2b4NAieOngwmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeMrOfPuoEVxPUOxYVKDgxIVxkYDaGrI46ZvwGRkw4gJV4drTXe5Gh/7pSP7MBT7C0lhCi4R2oijD1w3mX5Wrc+ynxvKyCrpAWOmLWBQJSEmmywwizPyXjiWMG8NUz+ywTvvjfRNzc67E1Npi0VIoo9EBSjzqYM9iyswFllvjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMO4vXC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC390C4CEC3;
	Mon, 14 Oct 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917365;
	bh=QMhv7oqlZZ9kk+7Jhm4nA2WTeV8kHu2b4NAieOngwmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMO4vXC6t8FuSaxvAcczJR6nSI4NyQ1S07iT7+veOxH+euKZZ3Y01so25ncvdf/d7
	 YoGnm/sAazLGL1YJ50jOXregwHmQngP0mQfSLmSopp7ofH2GWdiVlGElDvJbRVRySD
	 SI7sg1bsQ2R7rursQUCF83Rp00k4BeTTX5B83en8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/798] kselftest/arm64: signal: fix/refactor SVE vector length enumeration
Date: Mon, 14 Oct 2024 16:09:30 +0200
Message-ID: <20241014141218.588155367@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 5225b6562b9a7dc808d5a1e465aaf5e2ebb220cd ]

Currently a number of SVE/SME related tests have almost identical
functions to enumerate all supported vector lengths. However over time
the copy&pasted code has diverged, allowing some bugs to creep in:
- fake_sigreturn_sme_change_vl reports a failure, not a SKIP if only
  one vector length is supported (but the SVE version is fine)
- fake_sigreturn_sme_change_vl tries to set the SVE vector length, not
  the SME one (but the other SME tests are fine)
- za_no_regs keeps iterating forever if only one vector length is
  supported (but za_regs is correct)

Since those bugs seem to be mostly copy&paste ones, let's consolidate
the enumeration loop into one shared function, and just call that from
each test. That should fix the above bugs, and prevent similar issues
from happening again.

Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240821164401.3598545-1-andre.przywara@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/signal/Makefile |  2 +-
 .../selftests/arm64/signal/sve_helpers.c      | 56 +++++++++++++++++++
 .../selftests/arm64/signal/sve_helpers.h      | 21 +++++++
 .../testcases/fake_sigreturn_sme_change_vl.c  | 32 +++--------
 .../testcases/fake_sigreturn_sve_change_vl.c  | 30 ++--------
 .../arm64/signal/testcases/ssve_regs.c        | 36 +++---------
 .../arm64/signal/testcases/ssve_za_regs.c     | 36 +++---------
 .../arm64/signal/testcases/sve_regs.c         | 32 +++--------
 .../arm64/signal/testcases/za_no_regs.c       | 32 +++--------
 .../arm64/signal/testcases/za_regs.c          | 36 +++---------
 10 files changed, 132 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.c
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.h

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a2..edb3613513b8a 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -23,7 +23,7 @@ $(TEST_GEN_PROGS): $(PROGS)
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 COMMON_SOURCES := test_signals.c test_signals_utils.c testcases/testcases.c \
-	signals.S
+	signals.S sve_helpers.c
 COMMON_HEADERS := test_signals.h test_signals_utils.h testcases/testcases.h
 
 .SECONDEXPANSION:
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.c b/tools/testing/selftests/arm64/signal/sve_helpers.c
new file mode 100644
index 0000000000000..0acc121af3062
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#include <stdbool.h>
+#include <kselftest.h>
+#include <asm/sigcontext.h>
+#include <sys/prctl.h>
+
+unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls)
+{
+	int vq, vl;
+	int pr_set_vl = use_sme ? PR_SME_SET_VL : PR_SVE_SET_VL;
+	int len_mask = use_sme ? PR_SME_VL_LEN_MASK : PR_SVE_VL_LEN_MASK;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(pr_set_vl, vq * 16);
+		if (vl == -1)
+			return KSFT_FAIL;
+
+		vl &= len_mask;
+
+		/*
+		 * Unlike SVE, SME does not require the minimum vector length
+		 * to be implemented, or the VLs to be consecutive, so any call
+		 * to the prctl might return the single implemented VL, which
+		 * might be larger than 16. So to avoid this loop never
+		 * terminating,  bail out here when we find a higher VL than
+		 * we asked for.
+		 * See the ARM ARM, DDI 0487K.a, B1.4.2: I_QQRNR and I_NWYBP.
+		 */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	if (nvls < min_vls) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return KSFT_SKIP;
+	}
+
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.h b/tools/testing/selftests/arm64/signal/sve_helpers.h
new file mode 100644
index 0000000000000..50948ce471cc6
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#ifndef __SVE_HELPERS_H__
+#define __SVE_HELPERS_H__
+
+#include <stdbool.h>
+
+#define VLS_USE_SVE	false
+#define VLS_USE_SME	true
+
+extern unsigned int vls[];
+extern unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls);
+
+#endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
index ebd5815b54bba..cb8c051b5c8f2 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
@@ -6,44 +6,28 @@
  * handler, this is not supported and is expected to segfault.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SME_VL_LEN_MASK;
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
-
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
index e2a452190511f..e1ccf8f85a70c 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
@@ -12,40 +12,22 @@
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
+	if (res == KSFT_SKIP)
 		td->result = KSFT_SKIP;
-		return false;
-	}
 
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_sve_change_vl(struct tdescr *td,
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index c6b17c47cac4c..05dfbfc7c5b51 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -6,51 +6,31 @@
  * set up as expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_ssve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
index 1f62621794d50..ffefb24d16e9e 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -6,51 +6,31 @@
  * signal frames is set up as expected when enabled simultaneously.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
index 8b16eabbb7697..8143eb1c58c18 100644
--- a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_sve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
index 4d6f94b6178f3..ce26e9c2fa5e3 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index 174ad66566964..b9e13f27f1f9a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -6,51 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_za_regs(void)
-- 
2.43.0




