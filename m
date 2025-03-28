Return-Path: <stable+bounces-126965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99106A750BF
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA71893DDC
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C71E47AE;
	Fri, 28 Mar 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roO8Lv/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654BE1E32DD;
	Fri, 28 Mar 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190009; cv=none; b=q8U8XrEnAb3EqVDYqukZU5mEEDKThn8ni7yRhSe3rrSP47b/0XPs8fUJrtGZe1ds+jznxANF1mdu4JMKT8QwEUsruLl3Y0/FLXe+8Bf3OZGr9vodiU4cEmVSAEuHPiBwwPnEnwb9JTGqaa5wR5S97Naw7kDqNT7yZU2cgciRPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190009; c=relaxed/simple;
	bh=J6y6kun0b/WOkdFoozDuJNbed7857mJ4vfc+MUpdEkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=if3bQH0MkkCNMt3+3a4qBix7EGD8Wa2UQ+OPA38TI0zee3oNUHy4gLq3Mj+0Po+hKHp4tRYgOelNyolZZchEUfp+nl4ZcStBwU5qxvQ0RNB0wovW5P7NepsQYHfZjyIF9lb1Zvohm1nfCOxUkvBfbwyVU3PfzqG/s9VtC0fuSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roO8Lv/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14245C4CEEB;
	Fri, 28 Mar 2025 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743190008;
	bh=J6y6kun0b/WOkdFoozDuJNbed7857mJ4vfc+MUpdEkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=roO8Lv/W6Ze3RNUd+uc/KcaOx471RG/J6D4v+91m9iRSHw963IBZZc/+vQ4PZ9Vdw
	 vYencK8psqe9SQfBigMEbLi8VezoZuTm3BgSZPCp6czoDfkVCL0tWiQ39xgIJiNZwp
	 zpY2uyZAF3b/1SwRhF1eANiKURP9uQysmWNCTFLXXtIsdWCUK8JT/p0kvev+1NImmJ
	 9UFfy95nGf1HO4KwXcDzKhWObHJ9dtysekWn6zMjS5gME9llJZVQd33WhXCnoHgi8S
	 TBWNIOuMcFFdRy8sNl6VZsmZCkl0sQrv1/+bpwhEnelet+I1grWFlG/zYD2N5t6CPb
	 WbmtbyXAPBdKQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 28 Mar 2025 12:26:31 -0700
Subject: [PATCH v3 1/2] include: Move typedefs in nls.h to their own header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-string-add-wcslen-for-llvm-opt-v3-1-a180b4c0c1c4@kernel.org>
References: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
In-Reply-To: <20250328-string-add-wcslen-for-llvm-opt-v3-0-a180b4c0c1c4@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=nathan@kernel.org;
 h=from:subject:message-id; bh=J6y6kun0b/WOkdFoozDuJNbed7857mJ4vfc+MUpdEkI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnPvn+x/hG5e0v6eqZr27LnfN+s+W3uSwsTzardkpFP6
 htPN7uc6ihlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATadzA8M9sx3JHzuSXa4uc
 Y3k+Zh72uMEvzprNG5h7bu9W4VcrFH4y/E9flXdpdknLvHc8dj9Pbn8l2/r7ldg1AxERywiZqu2
 zFvMDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

In order to allow commonly included headers such as string.h to access
typedefs such as wchar_t without running into issues with the rest of
the NLS library, refactor the typedefs out into their own header that
can be included in a much safer manner.

Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/nls.h       | 19 +------------------
 include/linux/nls_types.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/nls.h b/include/linux/nls.h
index e0bf8367b274..3d416d1f60b6 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -3,24 +3,7 @@
 #define _LINUX_NLS_H
 
 #include <linux/init.h>
-
-/* Unicode has changed over the years.  Unicode code points no longer
- * fit into 16 bits; as of Unicode 5 valid code points range from 0
- * to 0x10ffff (17 planes, where each plane holds 65536 code points).
- *
- * The original decision to represent Unicode characters as 16-bit
- * wchar_t values is now outdated.  But plane 0 still includes the
- * most commonly used characters, so we will retain it.  The newer
- * 32-bit unicode_t type can be used when it is necessary to
- * represent the full Unicode character set.
- */
-
-/* Plane-0 Unicode character */
-typedef u16 wchar_t;
-#define MAX_WCHAR_T	0xffff
-
-/* Arbitrary Unicode character */
-typedef u32 unicode_t;
+#include <linux/nls_types.h>
 
 struct nls_table {
 	const char *charset;
diff --git a/include/linux/nls_types.h b/include/linux/nls_types.h
new file mode 100644
index 000000000000..9479df1016da
--- /dev/null
+++ b/include/linux/nls_types.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NLS_TYPES_H
+#define _LINUX_NLS_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * Unicode has changed over the years.  Unicode code points no longer
+ * fit into 16 bits; as of Unicode 5 valid code points range from 0
+ * to 0x10ffff (17 planes, where each plane holds 65536 code points).
+ *
+ * The original decision to represent Unicode characters as 16-bit
+ * wchar_t values is now outdated.  But plane 0 still includes the
+ * most commonly used characters, so we will retain it.  The newer
+ * 32-bit unicode_t type can be used when it is necessary to
+ * represent the full Unicode character set.
+ */
+
+/* Plane-0 Unicode character */
+typedef u16 wchar_t;
+#define MAX_WCHAR_T	0xffff
+
+/* Arbitrary Unicode character */
+typedef u32 unicode_t;
+
+#endif /* _LINUX_NLS_TYPES_H */

-- 
2.49.0


