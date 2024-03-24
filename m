Return-Path: <stable+bounces-30155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1B888FA7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977F11F278A2
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CE2114B3;
	Sun, 24 Mar 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stxtTzvg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F7153832;
	Sun, 24 Mar 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321703; cv=none; b=WLDdxFX0+IxZVw1Wn2WuN03lOwSCWx0h9k45X2v154ceNjpI4JoWTikE6Wh6YPElFosP1iBBLY5cr14h6Kw6kLaZ12JfLUZYcEyO8r8iG6kCrtRhELrVOgSuS5yBDKoh53eXsOYC5Uz8BMPb3v/F/pv7rBwt5KVG3oP/2WRH3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321703; c=relaxed/simple;
	bh=jyV1TX5A+7iSqnqRUOa2/4OWZvNsUm6BFOPjlQ3iHEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtbNlRQ46w0mEP7tMX8zerTShS4yuDIRvJ0nCumyKOLAfq9V11FR72I3UOAbiAsc222QYzASqcyVjjPvzgDznD09UGimDNlUlZmm1I8AryW7QEEiEQoxSNRmFZAQFci67B1OfCRZufA5gagXcM73zVOIHyeDahPjoqs/yro2WS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stxtTzvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21782C433C7;
	Sun, 24 Mar 2024 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321701;
	bh=jyV1TX5A+7iSqnqRUOa2/4OWZvNsUm6BFOPjlQ3iHEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stxtTzvgVYWKDjo5VfteUOxUrgvZsYpbnwcHIh6uHktSWG/tMWI7IALqmkksTZ0eG
	 d+9G8qTjyTVUcymeijDGYsNkNZGB+yfxHdF610HpIqCXhFTU4fn0x4PP6zL/7BAlHb
	 Z/ai/57/hUy4JJbtr4Psjrjb3IcD7pGpxh8TNNODA0Bz0+IwMyxUfWP7mOCxuANfHl
	 AmOHxppxRzAmVfbBNz3lNGrvzlDr3jcgo88U8PmbXxzk7MHZmuUESrUi1xH2GERsiG
	 wWT+JIU9mOXmFS7CEYlj5RtzDMmw1I1PAnhRfkNaRf+K/006M6rv3fru9J2SZNPkjF
	 ukQXsoV3ewrIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 430/638] powerpc/ps3: Fix lv1 hcall assembly for ELFv2 calling convention
Date: Sun, 24 Mar 2024 18:57:47 -0400
Message-ID: <20240324230116.1348576-431-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 6735fef14c1f089ae43fd6d43add818b7ff682a8 ]

Stack-passed parameters begin at a different offset in the caller's
stack in the ELFv2 ABI.

Reported-by: Geoff Levand <geoff@infradead.org>
Fixes: 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian builds")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231227072405.63751-2-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/ppc_asm.h  |  6 ++++--
 arch/powerpc/platforms/ps3/hvcall.S | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index e7792aa135105..041ee25955205 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -201,11 +201,13 @@
 
 #ifdef CONFIG_PPC64_ELF_ABI_V2
 #define STK_GOT		24
-#define __STK_PARAM(i)	(32 + ((i)-3)*8)
+#define STK_PARAM_AREA	32
 #else
 #define STK_GOT		40
-#define __STK_PARAM(i)	(48 + ((i)-3)*8)
+#define STK_PARAM_AREA	48
 #endif
+
+#define __STK_PARAM(i)	(STK_PARAM_AREA + ((i)-3)*8)
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
 #ifdef CONFIG_PPC64_ELF_ABI_V2
diff --git a/arch/powerpc/platforms/ps3/hvcall.S b/arch/powerpc/platforms/ps3/hvcall.S
index 509e30ad01bb4..59ea569debf47 100644
--- a/arch/powerpc/platforms/ps3/hvcall.S
+++ b/arch/powerpc/platforms/ps3/hvcall.S
@@ -714,7 +714,7 @@ _GLOBAL(_##API_NAME)				\
 	std	r4, 0(r11);			\
 	ld	r11, -16(r1);			\
 	std	r5, 0(r11);			\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r6, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
@@ -746,22 +746,22 @@ _GLOBAL(_##API_NAME)				\
 	mflr	r0;				\
 	std	r0, 16(r1);			\
 						\
-	std	r10, 48+8*7(r1);		\
+	std	r10, STK_PARAM_AREA+8*7(r1);	\
 						\
 	li	r11, API_NUMBER;		\
 	lv1call;				\
 						\
-	ld	r11, 48+8*7(r1);		\
+	ld	r11, STK_PARAM_AREA+8*7(r1);	\
 	std	r4, 0(r11);			\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r5, 0(r11);			\
-	ld	r11, 48+8*9(r1);		\
+	ld	r11, STK_PARAM_AREA+8*9(r1);	\
 	std	r6, 0(r11);			\
-	ld	r11, 48+8*10(r1);		\
+	ld	r11, STK_PARAM_AREA+8*10(r1);	\
 	std	r7, 0(r11);			\
-	ld	r11, 48+8*11(r1);		\
+	ld	r11, STK_PARAM_AREA+8*11(r1);	\
 	std	r8, 0(r11);			\
-	ld	r11, 48+8*12(r1);		\
+	ld	r11, STK_PARAM_AREA+8*12(r1);	\
 	std	r9, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
@@ -777,7 +777,7 @@ _GLOBAL(_##API_NAME)				\
 	li      r11, API_NUMBER;		\
 	lv1call;				\
 						\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r4, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
-- 
2.43.0


