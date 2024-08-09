Return-Path: <stable+bounces-66156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51594CE17
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052801F227CF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F4197A7F;
	Fri,  9 Aug 2024 09:58:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7106719754D
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197485; cv=none; b=pYSONGAv5QCIeZ1cRKO6L2TQSkOt58/IIyJi9cbst/zBR0/29BK9Vse7wbRhXrFGHCyVYbEdF/hUu3bJKPV/EK7r4JMcmMvYEUnlbENmyUrqiVcoHcv58YtMq7t7gJPDtVae5psu7rzRRW++0HP+KGc2suClNOmlRR+86Sq0Ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197485; c=relaxed/simple;
	bh=R8ISXw84RlXTvCXdblaJbXYFBZdIxN3y7/2T2CqDby4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtnnOkRyT0poOJdtWws8pWXS7j09pquoR85QnCs7HR2YDnwMXy0uOH7Mnb2oy2gSEufwggPQ10xvRuG1TYrrhrShXlBLGYDBlmcJ+1pw3TSdEtj8+qMhDUtmkoMdLKnxjTYTNpnI4MxQBJhcg7jaEURP32R8J+N6qc98e8RnXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D24B13D5;
	Fri,  9 Aug 2024 02:58:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 742E03F766;
	Fri,  9 Aug 2024 02:58:02 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.6.y 02/13] arm64: barrier: Restore spec_bar() macro
Date: Fri,  9 Aug 2024 10:57:34 +0100
Message-Id: <20240809095745.3476191-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809095745.3476191-1-mark.rutland@arm.com>
References: <20240809095745.3476191-1-mark.rutland@arm.com>
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
index cf2987464c186..1ca947d5c9396 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,10 @@
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


