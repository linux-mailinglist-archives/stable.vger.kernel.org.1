Return-Path: <stable+bounces-191817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18EC2538B
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296054E3949
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBD34B1BD;
	Fri, 31 Oct 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm2uwPiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348634B1B9
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916335; cv=none; b=r9Xu9SuF1hyfOm7q+x7qmqs6QvhQZUIH/4kuX/CnzEaMYerwIPJ4ccn3rlsvCNji9NRMH22PL2BA6PtjnG46qINrITGGcsArFwRZlku6NAE1Q4U1KesH8YmrMIOnwnWczI2MD/MevZJqBjzzANGKOIMzMe1alA74ZEy6UEd+R5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916335; c=relaxed/simple;
	bh=Cpa+9EsngsvCDz1fehtMOVVa2WVoFwLvVRCNZ/LciO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3I9tadZbfGFB5Z4mg0+dc0GPku120dssTc55YRMgnumN8+gGFMxHl78Ugto3t1ak+NqFEcvsz6zkCCP2dUP1mcRV31n2Ojekpi7Zvot4MQs/fz2qwDKy5Br1OdfTgKR4Rb+j8Pqi5YG1H2SedYEL/0drmgy+8jyRGDgrM9Hk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm2uwPiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D83C4CEFD;
	Fri, 31 Oct 2025 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916334;
	bh=Cpa+9EsngsvCDz1fehtMOVVa2WVoFwLvVRCNZ/LciO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hm2uwPiLvmQRLfb4qYZPn7B8gRYtqS6x0u4YRlFbKu8hK/YHDxWimWVpmsScaWT3u
	 HZcv+OlQ2KJ8I0j3vTtbIbLIulpFN4Mo454i2hOsyArZl1gcOp3qMhFKJM6Wg2kNPJ
	 UR/LhqGxMUdsjRIz8OlfEmWYmxk9HYf5UnRZp6B36mKmdfnjfxHgyDkbxK21c3mf0z
	 oKMbklTMKExHd0K7nKhl3JzMKYzQ1DJKb7l1pGoTKJGuKCUKoYxW80CXmtix0IoeQ9
	 QhrCtcIMyA0Jb06gEUqvqSiW+dHRrrxDuPOp4ZyshDaimUeO/6INFdChZT+WRakjqX
	 j53Eif2apW1qQ==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.6.y 2/5] bits: introduce fixed-type GENMASK_U*()
Date: Fri, 31 Oct 2025 22:11:58 +0900
Message-ID: <20251031131203.973066-2-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4508; i=wbg@kernel.org; h=from:subject; bh=16qu+F/eCvDSqovJfRNmWV9dcCCZMJUuwYyfP7jsa0Q=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksm2cxL3cU7fv2x6xqCs/JuAtF6g4sTc3HtxXPczM36 Fm2JjOqo5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZhIERPD/4LWq11rzWXz7KWN P8lHLPny1smLd2m6qkGo8zWpCWwnvzAybOrMdc0r8l2jc1VgXveMm4VTvOcenTxn0d3124/uDxI qZAcA
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
index f7f5a783da2a..b2342eebc8d2 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,7 +15,6 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 9cbd9d0b853c..09e167bc4530 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -11,6 +11,7 @@
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
@@ -19,11 +20,40 @@
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


