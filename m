Return-Path: <stable+bounces-126766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF945A71CFB
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A77C840D5B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC51204583;
	Wed, 26 Mar 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6C9TknM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0E2040A9;
	Wed, 26 Mar 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009579; cv=none; b=ImuhOFfyltHiErCb9e3IShFP1LhLR0MxprMsL7zp4GplskeDP8XXCfcC4dGsNOer2bm4fMUyvGQgeOSCMSa3kKMXlKddU+91r9Hqga1rkZK1XT2M3Ki0rzTG2lj8Vq4gNt3Md6nzPovJLOSdCBpOUi2KSE7jjS/2/RrZvyUR/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009579; c=relaxed/simple;
	bh=oMWE79HdrGxa1KMv6bx0+sXnyICeQbf7kRdyS1Zdqbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hds79Wh1LjElM4zKn/gJWKtEPw7xaApwbsuGgHomRUrk5GfQqbZ2pieAjWXz1dGroIqgPKaZpMP4FVkffdtqi1I0A75sOjQi4gzU74wqusdAmtAShqilH8zFiHD/fUhaLcc+uVqTWaKSFQVi3SmdgJOJ2gvNUnNFQoau0JGJyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6C9TknM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85457C4CEE8;
	Wed, 26 Mar 2025 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009578;
	bh=oMWE79HdrGxa1KMv6bx0+sXnyICeQbf7kRdyS1Zdqbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B6C9TknMyxzfZe6z/2Yh1Z6IS6/A+7IoUAvHGyZi3ijdZn1R1lWcH7B5SDS/4JEpg
	 OWvPnkZejvnhlKDd8KpJjCmKC18d0GbqNuxz+kKxme5CRNBtjFOWVn6eXjnxWP3pu8
	 9bPnR7xftNxgVdHnNg0RcQzHGLBa6ym4OpDpA6T6K20A9hivXEhyXaoW4EQT3V7WXJ
	 0LiBkJrqhL6KvXqpdXmqh5b6HWVVUrrcSs89lRjyq1rerSsr8jlHhygnOmFW5VTyPI
	 I3rT0yCPcfdX19JONuQAziXs7jsgolH8kBkGc6VyeNNqYdrdULt8/5J9/XoO/DSkMF
	 g+bqQ2+k6WThg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 26 Mar 2025 09:32:31 -0700
Subject: [PATCH v2 1/2] include: Move typedefs in nls.h to their own header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-string-add-wcslen-for-llvm-opt-v2-1-d864ab2cbfe4@kernel.org>
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
In-Reply-To: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=nathan@kernel.org;
 h=from:subject:message-id; bh=oMWE79HdrGxa1KMv6bx0+sXnyICeQbf7kRdyS1Zdqbk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlPzFUTlry5zht35Mj7sqkvpn+I0r10a8/P0zcPT2xn8
 FN6K874oKOUhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBMpECIkWHX5sd6B1v8+5x1
 qi8+XbbsWfScq0tsDzQyn3ESam8LeTKZkWH7N71vLSnHNtZbcJidNWxVVd+0bc/GpeEpEVklm5q
 5LFkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

In order to allow commonly included headers such as string.h to access
typedefs such as wchar_t without running into issues with the rest of
the NLS library, refactor the typedefs out into their own header that
can be included in a much safer manner.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/nls.h       | 19 +------------------
 include/linux/nls_types.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

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
index 000000000000..8caefdba19b1
--- /dev/null
+++ b/include/linux/nls_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NLS_TYPES_H
+#define _LINUX_NLS_TYPES_H
+
+#include <linux/types.h>
+
+/* Unicode has changed over the years.  Unicode code points no longer
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


