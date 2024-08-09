Return-Path: <stable+bounces-66170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC894CE2B
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32891C22385
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFA1922DB;
	Fri,  9 Aug 2024 10:02:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21616D307
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197756; cv=none; b=ECLYUKurqgAGsTDU5ZPVX5HhU2u/wICDjVhQo9CycQt+4N08/vm1KwZshutU1Fk8sm6+a5QDti+2SLB+8xWK0wgXvm9cZlZZRQmHeW/ZQO+CnkfltD4g3vJJHTkF8cLwxVE0V4VJMbJT3600+FH704TyYDtI8ifIj3n5nKNmGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197756; c=relaxed/simple;
	bh=IyXRHMphFYgOHd5TicRyHb200/QEke11OgJqLQdLDtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3gHgT/ecXQ7oCOlukFpBHdkfun5r0TcTbCRwxRbTjNjo4+mEPn1igoNAyMpkEL+ILgweNz6Byw/LRKMaWWd/C4diG9SGuNDc6DkstQ+eOo5l9F3qTCFM0zeOIq5b8s5bmpD/r5rnm5T5VKW2X3pTwqQCPbqo52Q5s26R8RNhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E903A13D5;
	Fri,  9 Aug 2024 03:03:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2FA73F766;
	Fri,  9 Aug 2024 03:02:33 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.1.y 02/13] arm64: barrier: Restore spec_bar() macro
Date: Fri,  9 Aug 2024 11:02:12 +0100
Message-Id: <20240809100223.3476634-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809100223.3476634-1-mark.rutland@arm.com>
References: <20240809100223.3476634-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ebfc726eae3f31bdb5fae1bbd74ef235d71046ca ]

Upcoming errata workarounds will need to use SB from C code. Restore the
spec_bar() macro so that we can use SB.

This is effectively a revert of commit:

  4f30ba1cce36d413 ("arm64: barrier: Remove spec_bar() macro")

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240508081400.235362-2-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/barrier.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 2cfc4245d2e2d..e22ec44d50f5f 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -38,6 +38,10 @@
  */
 #define dgh()		asm volatile("hint #6" : : : "memory")
 
+#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						 SB_BARRIER_INSN"nop\n",	\
+						 ARM64_HAS_SB))
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #define pmr_sync()						\
 	do {							\
-- 
2.30.2


