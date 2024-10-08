Return-Path: <stable+bounces-81869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4879949DB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED6A1C21018
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0E1D9586;
	Tue,  8 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rSjyQF7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EDEEC8;
	Tue,  8 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390409; cv=none; b=P6suQLQjibEcpHu7aUH1YVBu4drRfVV2y8+cmA0uRGq5DC2z0H6sJRoEv1D9JZg8GA18hsfPSuJALSNyvvvM+ww9mwU3fsgg2Av3elM/goQEJUWsx2T9bJkx3bMEvWoVgexY5/GizNg0JujD2N8TNsIe2wSyXxHNMbbIQcDJkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390409; c=relaxed/simple;
	bh=zCaee3QTrbY1PfuOjGEIEtwWqBM4gHt6Br+sobM/WoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVSJiFeXQHDCbhj9pdGYqXsh5DER5mbddCU3KIOturxQFhGoBof6/nX3033EkCypsYuR97eYIg6j3+R+4wzO6utCyO6cuyhoxxjZRtvXCzCkPAjzmFesXznHa+Hlo6zpdLgErCwySPyQrUgLOzG9iG9uH/Ekolib300qALryRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rSjyQF7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A4EC4CEC7;
	Tue,  8 Oct 2024 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390409;
	bh=zCaee3QTrbY1PfuOjGEIEtwWqBM4gHt6Br+sobM/WoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSjyQF7NYvAqi7qBQymiLiTOfqr3TlUeMicoiA3ZXgMLtmLJS6qSoHucrWlfcjtln
	 +ilPo9s9ctph/bmO7s85RRReY44YIToUFgnHhaeKQaOVt/NuHsOBVFe8Afsme9ihNC
	 R7VTE47YeKA7hL45BH5U64J3qficxFzjQjya8sgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 280/482] powerpc/vdso: Fix VDSO data access when running in a non-root time namespace
Date: Tue,  8 Oct 2024 14:05:43 +0200
Message-ID: <20241008115659.299092686@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit c73049389e58c01e2e3bbfae900c8daeee177191 ]

When running in a non-root time namespace, the global VDSO data page
is replaced by a dedicated namespace data page and the global data
page is mapped next to it. Detailed explanations can be found at
commit 660fd04f9317 ("lib/vdso: Prepare for time namespace support").

When it happens, __kernel_get_syscall_map and __kernel_get_tbfreq
and __kernel_sync_dicache don't work anymore because they read 0
instead of the data they need.

To address that, clock_mode has to be read. When it is set to
VDSO_CLOCKMODE_TIMENS, it means it is a dedicated namespace data page
and the global data is located on the following page.

Add a macro called get_realdatapage which reads clock_mode and add
PAGE_SIZE to the pointer provided by get_datapage macro when
clock_mode is equal to VDSO_CLOCKMODE_TIMENS. Use this new macro
instead of get_datapage macro except for time functions as they handle
it internally.

Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Closes: https://lore.kernel.org/all/ZtnYqZI-nrsNslwy@zx2c4.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/vdso_datapage.h | 15 +++++++++++++++
 arch/powerpc/kernel/asm-offsets.c        |  2 ++
 arch/powerpc/kernel/vdso/cacheflush.S    |  2 +-
 arch/powerpc/kernel/vdso/datapage.S      |  4 ++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a585c8e538ff0..939daf6b695ef 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -111,6 +111,21 @@ extern struct vdso_arch_data *vdso_data;
 	addi	\ptr, \ptr, (_vdso_datapage - 999b)@l
 .endm
 
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+
+.macro get_realdatapage ptr scratch
+	get_datapage \ptr
+#ifdef CONFIG_TIME_NS
+	lwz	\scratch, VDSO_CLOCKMODE_OFFSET(\ptr)
+	xoris	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@h
+	xori	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@l
+	cntlzw	\scratch, \scratch
+	rlwinm	\scratch, \scratch, PAGE_SHIFT - 5, 1 << PAGE_SHIFT
+	add	\ptr, \ptr, \scratch
+#endif
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f029755f9e69a..0c5c0fbf62417 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -346,6 +346,8 @@ int main(void)
 #else
 	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
 #endif
+	OFFSET(VDSO_CLOCKMODE_OFFSET, vdso_arch_data, data[0].clock_mode);
+	DEFINE(VDSO_CLOCKMODE_TIMENS, VDSO_CLOCKMODE_TIMENS);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index 0085ae464dac9..3b2479bd2f9a1 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_realdatapage	r10, r11
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
index db8e167f01667..2b19b6201a33a 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_realdatapage	r3, r11
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_realdatapage	r3, r11
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
-- 
2.43.0




