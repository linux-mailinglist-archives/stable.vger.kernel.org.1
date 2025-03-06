Return-Path: <stable+bounces-121129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9936A53FB6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976EE3ABEFB
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14E13632B;
	Thu,  6 Mar 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ih2IGoUf"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876EA2770B;
	Thu,  6 Mar 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223745; cv=none; b=Vw+lCIWyPnwfjbQO71NZgxTmdqpJAXy3mOM2liKFDkkSUiBtF8p0NDV+3vRYB6xiYukKE/C+D47T+nmeM8YMWe8SkyJ05c89+A3Rwf+czuABP9QQCf7FJmNWT2acU9AScg8M16DqaInYjB6TSqxkUIGjoBunWtb0laCYQkX5nlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223745; c=relaxed/simple;
	bh=F0XXb4iUPu1XvvOAobCBy9leql9n9yFjBaF8VWM6p3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGzLsH5wHE0jnYK2To7tBFihEjRiaOVWwgAwg6JwkWJ7UO1KqyxLHcT9nrzlkM0w7kfHzS1odTw4CBNN4oDk7fSQkKm9vSF+W9vsX8LAbWe31sWnnDuofe/bgFcDKrndV7tAkFkWKfn7qdvFP73uQj52p5ErSqhIX0IZDGzMpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ih2IGoUf; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A0481C0005C0;
	Wed,  5 Mar 2025 17:08:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A0481C0005C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741223280;
	bh=F0XXb4iUPu1XvvOAobCBy9leql9n9yFjBaF8VWM6p3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ih2IGoUflq6BpRs8Zqk57pkfrk0e+x1WG7rq29jmwoPzd9ENUCzwHZY9zKYsrgvRF
	 8UJvLvERq/UhDjBq8+f2jBbN74yYHOYyZdrkbjRXXJ90srprZoid0zFUMEMQuUEIdx
	 1+c9YGzdILwdezECIO8DCJ3bj2RzDPyYNM0CapQw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id A5A394002F47;
	Wed,  5 Mar 2025 20:07:59 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH stable 5.4 1/3] overflow: Add __must_check attribute to check_*() helpers
Date: Wed,  5 Mar 2025 17:07:54 -0800
Message-Id: <20250306010756.719024-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306010756.719024-1-florian.fainelli@broadcom.com>
References: <20250306010756.719024-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

commit 9b80e4c4ddaca3501177ed41e49d0928ba2122a8 upstream

Since the destination variable of the check_*_overflow() helpers will
contain a wrapped value on failure, it would be best to make sure callers
really did check the return result of the helper. Adjust the macros to use
a bool-wrapping static inline that is marked with __must_check. This means
the macros can continue to have their type-agnostic behavior while gaining
the function attribute (that cannot be applied directly to macros).

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/202008151007.EF679DF@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 include/linux/overflow.h | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 63e7c77ba942..35af574d006f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -44,6 +44,16 @@
 #define is_non_negative(a) ((a) > 0 || (a) == 0)
 #define is_negative(a) (!(is_non_negative(a)))
 
+/*
+ * Allows for effectively applying __must_check to a macro so we can have
+ * both the type-agnostic benefits of the macros while also being able to
+ * enforce that the return value is, in fact, checked.
+ */
+static inline bool __must_check __must_check_overflow(bool overflow)
+{
+	return unlikely(overflow);
+}
+
 #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
  * For simplicity and code hygiene, the fallback code below insists on
@@ -53,32 +63,32 @@
  * alias for __builtin_add_overflow, but add type checks similar to
  * below.
  */
-#define check_add_overflow(a, b, d) ({		\
+#define check_add_overflow(a, b, d) __must_check_overflow(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_add_overflow(__a, __b, __d);	\
-})
+}))
 
-#define check_sub_overflow(a, b, d) ({		\
+#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_sub_overflow(__a, __b, __d);	\
-})
+}))
 
-#define check_mul_overflow(a, b, d) ({		\
+#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_mul_overflow(__a, __b, __d);	\
-})
+}))
 
 #else
 
@@ -191,21 +201,20 @@
 })
 
 
-#define check_add_overflow(a, b, d)					\
+#define check_add_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d))
+			__unsigned_add_overflow(a, b, d)))
 
-#define check_sub_overflow(a, b, d)					\
+#define check_sub_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d))
+			__unsigned_sub_overflow(a, b, d)))
 
-#define check_mul_overflow(a, b, d)					\
+#define check_mul_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d))
-
+			__unsigned_mul_overflow(a, b, d)))
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
@@ -228,7 +237,7 @@
  * '*d' will hold the results of the attempted shift, but is not
  * considered "safe for use" if false is returned.
  */
-#define check_shl_overflow(a, s, d) ({					\
+#define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
 	typeof(s) _s = s;						\
 	typeof(d) _d = d;						\
@@ -238,7 +247,7 @@
 	*_d = (_a_full << _to_shift);					\
 	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
 	(*_d >> _to_shift) != _a);					\
-})
+}))
 
 /**
  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
-- 
2.34.1


