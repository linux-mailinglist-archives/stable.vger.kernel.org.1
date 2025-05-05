Return-Path: <stable+bounces-139794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B6AA9FB7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5146D1881778
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68067288CBA;
	Mon,  5 May 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTuWlL7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C62798E9;
	Mon,  5 May 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483350; cv=none; b=KGpZri4bHZREV2fv12mGZXmHKXyGVbBrOXe262A0X/sgwW0YRB0JYCENG6PE5NMNiTVz2ehi+5YdntDvR2gOVQz/Gjj+jFYbCIkuW91ZeTAxCblQJoXQp8HjXdo6nIDysG2hZq+8Y0Ob6k/qNKSYqEmPuPJoq2C8sredAPPYNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483350; c=relaxed/simple;
	bh=8aLFjEIcejOdEoMp0Exgz0jeYPGe4skXNfMWrYIFIC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkISHlw0aWQGILtA2jQt7P1myXdPeWS97K0Ly1pkoXKpyX8xExojIIiNI95/gbFn8fG4TJnb5TAzmjbmlEiWgP6WYTTLh1tdbxSk4AppkEK7tdxt7w3EsE97f6oLyjD7Xyix0WswHO8XtKdZdyEth/6sqzIcJt0Z26dR4Z05J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTuWlL7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB5C4CEE4;
	Mon,  5 May 2025 22:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483350;
	bh=8aLFjEIcejOdEoMp0Exgz0jeYPGe4skXNfMWrYIFIC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTuWlL7R7GdvyTiiRUvtCmhy3eGDnVXDNiI+QYLFW0dXKZRqPX6YUkRFaWp89vDH6
	 tyEcFritpzy0o2+WNNVJk+5iK48FiVLfKhmoLOrHARyaoSLTshiXs+OK2v2IwHLUgY
	 VDTqhGxZUlB9fMxYNo5icCGm4nNq6gnrUnVytvVw6pceI2zWpVhq4+LN4+Opb6rFyc
	 tU4wXKg1fdvqOUVCO9RJuUQAj+pOv8hS7poYHB8CyXbkcMv1hL0mnbL10CwVB5P2zm
	 gWpSAHRPKNDSkGQXPAslIZd3oVOaBLd4Mmm0rK69araihHiZt2/0sxCjiPjEi9hBDx
	 WqaerW3J2Ho1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	jesse@rivosinc.com,
	ajones@ventanamicro.com,
	cleger@rivosinc.com,
	samuel.holland@sifive.com,
	andybnac@gmail.com,
	inochiama@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 047/642] RISC-V: add vector extension validation checks
Date: Mon,  5 May 2025 18:04:23 -0400
Message-Id: <20250505221419.2672473-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit 9324571e9eea231321acf0a3d0fbc85a6e0f6ff6 ]

Using Clement's new validation callbacks, support checking that
dependencies have been satisfied for the vector extensions. From the
kernel's perfective, it's not required to differentiate between the
conditions for all the various vector subsets - it's the firmware's job
to not report impossible combinations. Instead, the kernel only has to
check that the correct config options are enabled and to enforce its
requirement of the d extension being present for FPU support.

Since vector will now be disabled proactively, there's no need to clear
the bit in elf_hwcap in riscv_fill_hwcap() any longer.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20250312-eclair-affluent-55b098c3602b@spud
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/cpufeature.h |  3 ++
 arch/riscv/kernel/cpufeature.c      | 60 +++++++++++++++++++----------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 19defdc2002d8..f56b409361fbe 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -56,6 +56,9 @@ void __init riscv_user_isa_enable(void);
 #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
 	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
 			    ARRAY_SIZE(_bundled_exts), NULL)
+#define __RISCV_ISA_EXT_BUNDLE_VALIDATE(_name, _bundled_exts, _validate) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
+			    ARRAY_SIZE(_bundled_exts), _validate)
 
 /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
 #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40ac72e407b68..76a3b34d7a707 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -109,6 +109,38 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
+				       const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_vector_float_validate(const struct riscv_isa_ext_data *data,
+					   const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	/*
+	 * The kernel doesn't support systems that don't implement both of
+	 * F and D, so if any of the vector extensions that do floating point
+	 * are to be usable, both floating point extensions need to be usable.
+	 *
+	 * Since this function validates vector only, and v/Zve* are probed
+	 * after f/d, there's no need for a deferral here.
+	 */
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
 				 const unsigned long *isa_bitmap)
 {
@@ -326,12 +358,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
-	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
-	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
-					  riscv_ext_zicbom_validate),
-	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
-					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
@@ -372,11 +402,11 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
-	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
-	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
-	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
-	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
-	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zve32x, RISCV_ISA_EXT_ZVE32X, riscv_ext_vector_x_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts, riscv_ext_vector_x_validate),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
@@ -960,16 +990,6 @@ void __init riscv_fill_hwcap(void)
 		riscv_v_setup_vsize();
 	}
 
-	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
-		/*
-		 * ISA string in device tree might have 'v' flag, but
-		 * CONFIG_RISCV_ISA_V is disabled in kernel.
-		 * Clear V flag in elf_hwcap if CONFIG_RISCV_ISA_V is disabled.
-		 */
-		if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
-			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
-	}
-
 	memset(print_str, 0, sizeof(print_str));
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
-- 
2.39.5


