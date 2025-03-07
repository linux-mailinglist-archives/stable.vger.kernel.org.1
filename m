Return-Path: <stable+bounces-121380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C38A5687A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5EA189847F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B7218EB9;
	Fri,  7 Mar 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yl1wTmCw"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC028E8;
	Fri,  7 Mar 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353001; cv=none; b=lFuRXEzKK8S67p0gg5Qj9RjU2GnSdImQW2FE054ddEgK88ePlGHS4b5A86MBix7Zme9jFYXvW2+d2IuNPvgUKHZL3oetcvz31XgOVxun4EEr5UWoEihaNqOCJ7SYviyyFWRAkgynQxOLeAxZbWgAQ4vq0jp+JI53ZLsVu1WxXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353001; c=relaxed/simple;
	bh=61W0DVgUYGDHwdQnl98upOBa9S56v+QGmP8p3pP1OVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTZ9SF1vEfvgXR3gDhx/wYfwjXnsBYjLK070vVN2qgxZccURobaf6Ni5D3w44OT6gZMTWb1o40Ry/hRe9YM6M+He42l/wqUawk47gEV1eqvdKnBZtfZXwsbdTevQd37f6jlerv7RUr0LospWDajYblf4tSFKt/qP6TaappdcY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yl1wTmCw; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C1DF7C0000F6;
	Fri,  7 Mar 2025 05:09:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C1DF7C0000F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741352998;
	bh=61W0DVgUYGDHwdQnl98upOBa9S56v+QGmP8p3pP1OVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yl1wTmCw9hus0D2UYql7XBFu5cOykadRflAEKL5Cp+L1CX9xi4zdtPjOjj0b8q4Nj
	 vtKaJMZcm0uScvNW68mdfhjf1+4NOXgXce/MpGhgI16Gf4yksVIq3STnZRAniI7xiM
	 kz/PsFwT0GGKWpuNiPb2ZE9tEqbltWjcX9ZsYAKs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id A15C94003021;
	Fri,  7 Mar 2025 08:09:57 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-hardening@vger.kernel.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH stable v5.4 v2 3/3] overflow: Allow mixed type arguments
Date: Fri,  7 Mar 2025 05:09:53 -0800
Message-Id: <20250307130953.3427986-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307130953.3427986-1-florian.fainelli@broadcom.com>
References: <20250307130953.3427986-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

commit d219d2a9a92e39aa92799efe8f2aa21259b6dd82 upstream

When the check_[op]_overflow() helpers were introduced, all arguments
were required to be the same type to make the fallback macros simpler.
However, now that the fallback macros have been removed[1], it is fine
to allow mixed types, which makes using the helpers much more useful,
as they can be used to test for type-based overflows (e.g. adding two
large ints but storing into a u8), as would be handy in the drm core[2].

Remove the restriction, and add additional self-tests that exercise
some of the mixed-type overflow cases, and double-check for accidental
macro side-effects.

[1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
[2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Tested-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
[florian: Drop changes to lib/test_overflow.c]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 include/linux/overflow.h | 72 +++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index d1dd039fe1c3..54788a3cdcf5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -55,40 +55,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 }
 
 #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 #else
 
-- 
2.34.1


