Return-Path: <stable+bounces-191794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD91C242D5
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 056104EE767
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CC329E51;
	Fri, 31 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZVao87P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D553594A
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903227; cv=none; b=ZOFekyKtUnuEMEqVw5eytqMFxjDhOzArrbVk6t0yEfZZAKBpmFSqlrEvmui7IYvBWbsgAuk72MMsUaxbNQGDUu0Fp3dOAkucXS8pZfYXl16r6MFxPkLez58k/liGx0yE7L6oTUmq1orvKSKMVlfej0RCMNfsjj1iXieJ42E7H90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903227; c=relaxed/simple;
	bh=MBfy/i0i1c8hmV89IOtfZ6gEEN29ZcK8IdM6x2mkd98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chMiOzqeb5KJ+VEJ5JjniduYoqhX4uElrH8NgKebRPtMXfOlDdy5+/j/+405Falhl0GOog0boSjz3fDE4lG9C6XKOCRURt5xcUqWU4W5Ys8TF2+aQG8G8spiiYc8dkBT01OFLLWJ0BygyEFIiJuQUm87OHbOH0ISHlRXREe/42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZVao87P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DD2C4CEF8;
	Fri, 31 Oct 2025 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761903227;
	bh=MBfy/i0i1c8hmV89IOtfZ6gEEN29ZcK8IdM6x2mkd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZVao87P+GLpMmF2UwsZbyKqNBSMtFVhsgYVvu+tkhlrvVxjfjhE8D5f9TAmDA4Cl
	 TJsGF7DuAgvbVbbgqdRXmE/G2tjYnQzI89Aj7XxDLwr8KPd2uIylqkKPwu8wXkrjgT
	 IqYaI2Ua8ag+4WgLity5PEYemJfpzVx5Ytre5WY8hGHfQZYoFv3BLpl6YpD5A0Dvkz
	 O6Tc5DsSM0FFnZy5wKF1FU78whI4rriU3MbOaAT7lION200nKwBQuj3KhBVPPUyyaO
	 zWagsm4TFxmyV9OGmCCywHfVdrRqrdQqcbrbZPtw4jxbAMami13IxeLi8DFYmaLF6K
	 bAkSmIk0Sb2EA==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.12.y 2/5] bits: introduce fixed-type GENMASK_U*()
Date: Fri, 31 Oct 2025 18:33:16 +0900
Message-ID: <20251031093326.517803-2-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-shortage-tabby-5157@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4459; i=wbg@kernel.org; h=from:subject; bh=QIvY5u4lpdRTAOd/0F3vYnlKtpmIVtH7J4trVWXF0Fw=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksTdyfFLcuMiqeudj6S1+s7KmDXisslk1MzTHbVvz9W lEJo2hTRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjARW0FGhnlqQlrzvr/JOhFu ZWlYERJ8X95O5taKvOSvRitsFKN5jjL8Fe4qmXRSMvPadY/3p1YuV0rpXf3+yEe1xzZrL+4+tMq +mAkA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 19408200c094858d952a90bf4977733dc89a4df5 ]

Add GENMASK_TYPE() which generalizes __GENMASK() to support different
types, and implement fixed-types versions of GENMASK() based on it.
The fixed-type version allows more strict checks to the min/max values
accepted, which is useful for defining registers like implemented by
i915 and xe drivers with their REG_GENMASK*() macros.

The strict checks rely on shift-count-overflow compiler check to fail
the build if a number outside of the range allowed is passed.
Example:

  #define FOO_MASK GENMASK_U32(33, 4)

will generate a warning like:

  include/linux/bits.h:51:27: error: right shift count >= width of type [-Werror=shift-count-overflow]
     51 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
        |                           ^~

The result is casted to the corresponding fixed width type. For
example, GENMASK_U8() returns an u8. Note that because of the C
promotion rules, GENMASK_U8() and GENMASK_U16() will immediately be
promoted to int if used in an expression. Regardless, the main goal is
not to get the correct type, but rather to enforce more checks at
compile time.

While GENMASK_TYPE() is crafted to cover all variants, including the
already existing GENMASK(), GENMASK_ULL() and GENMASK_U128(), for the
moment, only use it for the newly introduced GENMASK_U*(). The
consolidation will be done in a separate change.

Co-developed-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Stable-dep-of: 2ba5772e530f ("gpio: idio-16: Define fixed direction of the GPIO lines")
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 include/linux/bitops.h |  1 -
 include/linux/bits.h   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index ba35bbf07798..65d084abbc2c 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -8,7 +8,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 18143b536d9d..b48aa3209c2e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -12,6 +12,7 @@
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
@@ -20,11 +21,40 @@
  */
 #if !defined(__ASSEMBLY__)
 
+/*
+ * Missing asm support
+ *
+ * GENMASK_U*() depend on BITS_PER_TYPE() which relies on sizeof(),
+ * something not available in asm. Nevertheless, fixed width integers is a C
+ * concept. Assembly code can rely on the long and long long versions instead.
+ */
+
 #include <linux/build_bug.h>
+#include <linux/overflow.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
 		__is_constexpr((l) > (h)), (l) > (h), 0)))
 
+/*
+ * Generate a mask for the specified type @t. Additional checks are made to
+ * guarantee the value returned fits in that type, relying on
+ * -Wshift-count-overflow compiler check to detect incompatible arguments.
+ * For example, all these create build errors or warnings:
+ *
+ * - GENMASK(15, 20): wrong argument order
+ * - GENMASK(72, 15): doesn't fit unsigned long
+ * - GENMASK_U32(33, 15): doesn't fit in a u32
+ */
+#define GENMASK_TYPE(t, h, l)					\
+	((t)(GENMASK_INPUT_CHECK(h, l) +			\
+	     (type_max(t) << (l) &				\
+	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
+
+#define GENMASK_U8(h, l)	GENMASK_TYPE(u8, h, l)
+#define GENMASK_U16(h, l)	GENMASK_TYPE(u16, h, l)
+#define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
+#define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
+
 #else /* defined(__ASSEMBLY__) */
 
 /*
-- 
2.51.0


