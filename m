Return-Path: <stable+bounces-158978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A669AEE482
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975DD7B051E
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEC28DB67;
	Mon, 30 Jun 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dWBtVu5B"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409828B7F8
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300722; cv=none; b=axihkNuoyONYFu9w1ePDBhtwH/fdbPIYTF9GLzj8GIN3Ie0mOHfg3PdiT4vgOVGJC43R24jF4vW5bu59D5L++lzwoWYuQnqRVDPWuDey912pyJ2OhFw2qzo8gZVJ6qrJYObh3BSJsxbMuO05ObKaho/uK9Ladiwrp6EPOugGgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300722; c=relaxed/simple;
	bh=1AaP+XmU+SfB8zUGpcYWUKniS0b21j9iKK5sfgwedRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTpwlmw82aL27oRwqduZN2IrkTDzbsCfpfeq2MLWzzzoJLT3VODf23mS2MhG2LP3iUue6xTkVu36HmbH4flvFwj3fKYUJJWz/UqY33g8I7lDCqPQJAPFhkAwDnk8zxvhVKJqbDpMMLs/sinyikPmyiPh/UQjxmen1B2sdvdoD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dWBtVu5B; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.24])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8F1374076185;
	Mon, 30 Jun 2025 16:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8F1374076185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751300709;
	bh=YpaHIcJWDcCj3A1Ti0DCxZ5mBVOL6uYaWmXIR/rZdh4=;
	h=From:To:Cc:Subject:Date:From;
	b=dWBtVu5B8IonJxwhyJSEYalTuRhLWqOKmJJ3PsZO2oAQPwzMD05mJ+hee7xjuI8WP
	 jYb28Ep8Mgq/nitCCbAwLPUmhq2mhCBrCikszYpbUr1gJ/cw4OwhAT9U8MP9GMSFF9
	 bXxRDxOVTab5zGZSG9xmTK0icLeeOQYDSNK06NX4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg KH <gregkh@linuxfoundation.org>,
	Holger Dengler <dengler@linux.ibm.com>,
	David Airlie <airlied@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	lvc-project@linuxtesting.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 5.10 1/2] string.h: add array-wrappers for (v)memdup_user()
Date: Mon, 30 Jun 2025 19:24:44 +0300
Message-ID: <20250630162446.1407811-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

commit 313ebe47d75558511aa1237b6e35c663b5c0ec6f upstream.

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-3-pstanner@redhat.com
[ fp: fix small conflict in header includes; take linux/errno.h as well ]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

s390 and x86_64 allmodconfig build passed.

 include/linux/string.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0cef345a6e87..cd8c007ad3be 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,6 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
+#include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -13,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.50.0


