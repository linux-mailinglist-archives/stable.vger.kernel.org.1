Return-Path: <stable+bounces-134544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3EA93530
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951741B64FFB
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683C26982E;
	Fri, 18 Apr 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aGomBioL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AF26FA54
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968192; cv=none; b=NqXLWB8HBTdluQ8uLOMQfMrb/hBiloIj6pA8t8Dzndw6fyBzucNm0CFWkJS/I7cJ4r9bLmrLlI1ItLeIRW6im8jWPOy0Ua23gXA/J607BkITevpMJa/z/jbJXilr/vt0n1yokGesK0Dc8itxLuQZP7EHCZPubonTI+SNP6JE8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968192; c=relaxed/simple;
	bh=dZUTVczhkvzkfkMw2ChU0X1Y96vJRZzaNbEE3jeFDpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tayum34uZmbe1RXGY4dNmhz/34WbV1QjpbnDlFRJ1czslURf5Ybcr4ExUutV6O9AXDpvf2vbdItEM9gF9YqfTg1bs4FlFrMkjtWDbLbFhi/HI4zMvaqQPhBeVwvlSFzxBYCyFfSf0kInxhNVDh7HgK3Er8uJ6DmmQhzismymb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aGomBioL; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zf8SM2r3Hzpxg;
	Fri, 18 Apr 2025 11:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744968179;
	bh=/ThC9uJv81Ivb9y0c25x42xEpmRtpYPRPrQ/+I/OLi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGomBioL0F0fj1XJ7kSoiJyKgzqxhGHhYburbngFu9B3fZHZ5+6/OsXOMxG+6NKZB
	 ZUb+1wUjGG+foClXgoD+zK6XHAi5ZeYR9eL90NKSK/R2EegiWPa+Jw0COq+wLU6/bJ
	 RJk/8uhCWZg9PunqHM9ninQzc4EckpHnDCqDaiOs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zf8SL68pQzKPT;
	Fri, 18 Apr 2025 11:22:58 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH 6.6.y] landlock: Add the errata interface
Date: Fri, 18 Apr 2025 11:22:49 +0200
Message-ID: <20250418092249.1989854-1-mic@digikod.net>
In-Reply-To: <2025041711-awoke-petted-a885@gregkh>
References: <2025041711-awoke-petted-a885@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Some fixes may require user space to check if they are applied on the
running kernel before using a specific feature.  For instance, this
applies when a restriction was previously too restrictive and is now
getting relaxed (e.g. for compatibility reasons).  However, non-visible
changes for legitimate use (e.g. security fixes) do not require an
erratum.

Because fixes are backported down to a specific Landlock ABI, we need a
way to avoid cherry-pick conflicts.  The solution is to only update a
file related to the lower ABI impacted by this issue.  All the ABI files
are then used to create a bitmask of fixes.

The new errata interface is similar to the one used to get the supported
Landlock ABI version, but it returns a bitmask instead because the order
of fixes may not match the order of versions, and not all fixes may
apply to all versions.

The actual errata will come with dedicated commits.  The description is
not actually used in the code but serves as documentation.

Create the landlock_abi_version symbol and use its value to check errata
consistency.

Update test_base's create_ruleset_checks_ordering tests and add errata
tests.

This commit is backportable down to the first version of Landlock.

Fixes: 3532b0b4352c ("landlock: Enable user space to infer supported features")
Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250318161443.279194-3-mic@digikod.net
(cherry picked from commit 15383a0d63dbcd63dc7e8d9ec1bf3a0f7ebf64ac)
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/landlock.h                |  2 +
 security/landlock/errata.h                   | 87 ++++++++++++++++++++
 security/landlock/setup.c                    | 30 +++++++
 security/landlock/setup.h                    |  3 +
 security/landlock/syscalls.c                 | 22 ++++-
 tools/testing/selftests/landlock/base_test.c | 46 ++++++++++-
 6 files changed, 185 insertions(+), 5 deletions(-)
 create mode 100644 security/landlock/errata.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 81d09ef9aa50..f82a66361a1e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -38,9 +38,11 @@ struct landlock_ruleset_attr {
  *
  * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
  *   version.
+ * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/errata.h b/security/landlock/errata.h
new file mode 100644
index 000000000000..f26b28b9873d
--- /dev/null
+++ b/security/landlock/errata.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Errata information
+ *
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ERRATA_H
+#define _SECURITY_LANDLOCK_ERRATA_H
+
+#include <linux/init.h>
+
+struct landlock_erratum {
+	const int abi;
+	const u8 number;
+};
+
+/* clang-format off */
+#define LANDLOCK_ERRATUM(NUMBER) \
+	{ \
+		.abi = LANDLOCK_ERRATA_ABI, \
+		.number = NUMBER, \
+	},
+/* clang-format on */
+
+/*
+ * Some fixes may require user space to check if they are applied on the running
+ * kernel before using a specific feature.  For instance, this applies when a
+ * restriction was previously too restrictive and is now getting relaxed (for
+ * compatibility or semantic reasons).  However, non-visible changes for
+ * legitimate use (e.g. security fixes) do not require an erratum.
+ */
+static const struct landlock_erratum landlock_errata_init[] __initconst = {
+
+/*
+ * Only Sparse may not implement __has_include.  If a compiler does not
+ * implement __has_include, a warning will be printed at boot time (see
+ * setup.c).
+ */
+#ifdef __has_include
+
+#define LANDLOCK_ERRATA_ABI 1
+#if __has_include("errata/abi-1.h")
+#include "errata/abi-1.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 2
+#if __has_include("errata/abi-2.h")
+#include "errata/abi-2.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 3
+#if __has_include("errata/abi-3.h")
+#include "errata/abi-3.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 4
+#if __has_include("errata/abi-4.h")
+#include "errata/abi-4.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+/*
+ * For each new erratum, we need to include all the ABI files up to the impacted
+ * ABI to make all potential future intermediate errata easy to backport.
+ *
+ * If such change involves more than one ABI addition, then it must be in a
+ * dedicated commit with the same Fixes tag as used for the actual fix.
+ *
+ * Each commit creating a new security/landlock/errata/abi-*.h file must have a
+ * Depends-on tag to reference the commit that previously added the line to
+ * include this new file, except if the original Fixes tag is enough.
+ *
+ * Each erratum must be documented in its related ABI file, and a dedicated
+ * commit must update Documentation/userspace-api/landlock.rst to include this
+ * erratum.  This commit will not be backported.
+ */
+
+#endif
+
+	{}
+};
+
+#endif /* _SECURITY_LANDLOCK_ERRATA_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 0f6113528fa4..8b46e8748b8a 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -6,11 +6,13 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
 
 #include "common.h"
 #include "cred.h"
+#include "errata.h"
 #include "fs.h"
 #include "ptrace.h"
 #include "setup.h"
@@ -24,8 +26,36 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+int landlock_errata __ro_after_init;
+
+static void __init compute_errata(void)
+{
+	size_t i;
+
+#ifndef __has_include
+	/*
+	 * This is a safeguard to make sure the compiler implements
+	 * __has_include (see errata.h).
+	 */
+	WARN_ON_ONCE(1);
+	return;
+#endif
+
+	for (i = 0; landlock_errata_init[i].number; i++) {
+		const int prev_errata = landlock_errata;
+
+		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
+				 landlock_abi_version))
+			continue;
+
+		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
+		WARN_ON_ONCE(prev_errata == landlock_errata);
+	}
+}
+
 static int __init landlock_init(void)
 {
+	compute_errata();
 	landlock_add_cred_hooks();
 	landlock_add_ptrace_hooks();
 	landlock_add_fs_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..420dceca35d2 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -11,7 +11,10 @@
 
 #include <linux/lsm_hooks.h>
 
+extern const int landlock_abi_version;
+
 extern bool landlock_initialized;
+extern int landlock_errata;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 336bedaa3af6..eb23df4e836c 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -150,7 +150,9 @@ static const struct file_operations ruleset_fops = {
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
+ * @flags: Supported value:
+ *         - %LANDLOCK_CREATE_RULESET_VERSION
+ *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
@@ -159,6 +161,10 @@ static const struct file_operations ruleset_fops = {
  * 0, then the returned value is the highest supported Landlock ABI version
  * (starting at 1).
  *
+ * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
+ * 0, then the returned value is a bitmask of fixed issues for the current
+ * Landlock ABI version.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -181,9 +187,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EOPNOTSUPP;
 
 	if (flags) {
-		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
-		    !size)
-			return LANDLOCK_ABI_VERSION;
+		if (attr || size)
+			return -EINVAL;
+
+		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
+			return landlock_abi_version;
+
+		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
+			return landlock_errata;
+
 		return -EINVAL;
 	}
 
@@ -213,6 +225,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
+const int landlock_abi_version = LANDLOCK_ABI_VERSION;
+
 /*
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 5aa7d2feab10..b06410bd1aa1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -98,10 +98,54 @@ TEST(abi_version)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+/*
+ * Old source trees might not have the set of Kselftest fixes related to kernel
+ * UAPI headers.
+ */
+#ifndef LANDLOCK_CREATE_RULESET_ERRATA
+#define LANDLOCK_CREATE_RULESET_ERRATA (1U << 1)
+#endif
+
+TEST(errata)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int errata;
+
+	errata = landlock_create_ruleset(NULL, 0,
+					 LANDLOCK_CREATE_RULESET_ERRATA);
+	/* The errata bitmask will not be backported to tests. */
+	ASSERT_LE(0, errata);
+	TH_LOG("errata: 0x%x", errata);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      NULL, 0,
+			      LANDLOCK_CREATE_RULESET_VERSION |
+				      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA |
+						      1 << 31));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 /* Tests ordering of syscall argument checks. */
 TEST(create_ruleset_checks_ordering)
 {
-	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
+	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
 	const int invalid_flag = last_flag << 1;
 	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
-- 
2.49.0


