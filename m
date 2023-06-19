Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2697873546D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjFSK4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjFSKzf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59854201
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E01DB60B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FEC433C0;
        Mon, 19 Jun 2023 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172026;
        bh=0xN2024y5eBumexO6w8bxfJWZTX5fFIigehTN5xnpJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvVQ1Xgxh3IsgmakxGzVTLoM/madhruaAvANhCTrQLMdDPfOMlQgtlsTSb3gvddLp
         2ytlBa2Lpyy3iiiZFqSs1O0mVYw+BE4iA2p2eJbVqamPv8NUITKkehq7giz8zhSIgF
         MDLpBU7Te2FQrjUVa2PAmNNK2w2QOiZ0L9yE+ee4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 02/89] kernel.h: split out kstrtox() and simple_strtox() to a separate header
Date:   Mon, 19 Jun 2023 12:29:50 +0200
Message-ID: <20230619102138.392631375@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 4c52729377eab025b238caeed48994a39c3b73f2 ]

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out kstrtox() and
simple_strtox() helpers.

At the same time convert users in header and lib folders to use new
header.  Though for time being include new header back to kernel.h to
avoid twisted indirected includes for existing users.

[andy.shevchenko@gmail.com: fix documentation references]
  Link: https://lkml.kernel.org/r/20210615220003.377901-1-andy.shevchenko@gmail.com

Link: https://lkml.kernel.org/r/20210611185815.44103-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kars Mulder <kerneldev@karsmulder.nl>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/core-api/kernel-api.rst |   7 +-
 include/linux/kernel.h                | 143 +-----------------------
 include/linux/kstrtox.h               | 155 ++++++++++++++++++++++++++
 include/linux/string.h                |   7 --
 include/linux/sunrpc/cache.h          |   1 +
 lib/kstrtox.c                         |   5 +-
 lib/parser.c                          |   1 +
 7 files changed, 163 insertions(+), 156 deletions(-)
 create mode 100644 include/linux/kstrtox.h

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 741aa37dc1819..2a7444e3a4c21 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -24,11 +24,8 @@ String Conversions
 .. kernel-doc:: lib/vsprintf.c
    :export:
 
-.. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtol
-
-.. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtoul
+.. kernel-doc:: include/linux/kstrtox.h
+   :functions: kstrtol kstrtoul
 
 .. kernel-doc:: lib/kstrtox.c
    :export:
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 66948e1bf4fa6..cdd6ed5bbcf20 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
@@ -329,148 +330,6 @@ extern bool oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
-/* Internal, do not use. */
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
-int __must_check _kstrtol(const char *s, unsigned int base, long *res);
-
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
-
-/**
- * kstrtoul - convert a string to an unsigned long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign, but not a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtoul(). Return code must be checked.
-*/
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
-	 */
-	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
-	    __alignof__(unsigned long) == __alignof__(unsigned long long))
-		return kstrtoull(s, base, (unsigned long long *)res);
-	else
-		return _kstrtoul(s, base, res);
-}
-
-/**
- * kstrtol - convert a string to a long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign or a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtol(). Return code must be checked.
- */
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(long, long long) = 0.
-	 */
-	if (sizeof(long) == sizeof(long long) &&
-	    __alignof__(long) == __alignof__(long long))
-		return kstrtoll(s, base, (long long *)res);
-	else
-		return _kstrtol(s, base, res);
-}
-
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
-int __must_check kstrtoint(const char *s, unsigned int base, int *res);
-
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
-{
-	return kstrtoull(s, base, res);
-}
-
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
-{
-	return kstrtoll(s, base, res);
-}
-
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
-{
-	return kstrtouint(s, base, res);
-}
-
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
-{
-	return kstrtoint(s, base, res);
-}
-
-int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
-int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
-int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
-int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
-int __must_check kstrtobool(const char *s, bool *res);
-
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
-
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-
-/*
- * Use kstrto<foo> instead.
- *
- * NOTE: simple_strto<foo> does not check for the range overflow and,
- *	 depending on the input, may give interesting results.
- *
- * Use these functions if and only if you cannot use kstrto<foo>, because
- * the conversion ends on the first non-digit character, which may be far
- * beyond the supported range. It might be useful to parse the strings like
- * 10x50 or 12:21 without altering original string or temporary buffer in use.
- * Keep in mind above caveat.
- */
-
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
-
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
 
diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
new file mode 100644
index 0000000000000..529974e22ea79
--- /dev/null
+++ b/include/linux/kstrtox.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTRTOX_H
+#define _LINUX_KSTRTOX_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/* Internal, do not use. */
+int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+int __must_check _kstrtol(const char *s, unsigned int base, long *res);
+
+int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
+
+/**
+ * kstrtoul - convert a string to an unsigned long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtoul(). Return code must be checked.
+*/
+static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
+
+/**
+ * kstrtol - convert a string to a long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtol(). Return code must be checked.
+ */
+static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(long, long long) = 0.
+	 */
+	if (sizeof(long) == sizeof(long long) &&
+	    __alignof__(long) == __alignof__(long long))
+		return kstrtoll(s, base, (long long *)res);
+	else
+		return _kstrtol(s, base, res);
+}
+
+int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+int __must_check kstrtoint(const char *s, unsigned int base, int *res);
+
+static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
+{
+	return kstrtoull(s, base, res);
+}
+
+static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
+{
+	return kstrtoll(s, base, res);
+}
+
+static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
+{
+	return kstrtouint(s, base, res);
+}
+
+static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
+{
+	return kstrtoint(s, base, res);
+}
+
+int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
+int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
+int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
+int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
+int __must_check kstrtobool(const char *s, bool *res);
+
+int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
+int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
+int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
+int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
+int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
+int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
+int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
+int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
+
+static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
+{
+	return kstrtoull_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
+{
+	return kstrtoll_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
+{
+	return kstrtouint_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
+{
+	return kstrtoint_from_user(s, count, base, res);
+}
+
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: simple_strto<foo> does not check for the range overflow and,
+ *	 depending on the input, may give interesting results.
+ *
+ * Use these functions if and only if you cannot use kstrto<foo>, because
+ * the conversion ends on the first non-digit character, which may be far
+ * beyond the supported range. It might be useful to parse the strings like
+ * 10x50 or 12:21 without altering original string or temporary buffer in use.
+ * Keep in mind above caveat.
+ */
+
+extern unsigned long simple_strtoul(const char *,char **,unsigned int);
+extern long simple_strtol(const char *,char **,unsigned int);
+extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
+extern long long simple_strtoll(const char *,char **,unsigned int);
+
+static inline int strtobool(const char *s, bool *res)
+{
+	return kstrtobool(s, res);
+}
+
+#endif	/* _LINUX_KSTRTOX_H */
diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e4..0cef345a6e87a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
-
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
@@ -183,12 +182,6 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
-extern int kstrtobool(const char *s, bool *res);
-static inline int strtobool(const char *s, bool *res)
-{
-	return kstrtobool(s, res);
-}
-
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index d0965e2997b09..b134b2b3371cf 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
+#include <linux/kstrtox.h>
 #include <linux/proc_fs.h>
 
 /*
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 8504526541c13..53fa01fb75092 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -14,11 +14,12 @@
  */
 #include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/math64.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+
 #include "kstrtox.h"
 
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
diff --git a/lib/parser.c b/lib/parser.c
index f5b3e5d7a7f95..5c37d6345cb0a 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/parser.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-- 
2.39.2



