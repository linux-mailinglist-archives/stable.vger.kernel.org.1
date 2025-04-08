Return-Path: <stable+bounces-128878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AAA7FB04
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9A3BAD02
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB226869E;
	Tue,  8 Apr 2025 09:56:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C46126659F
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106178; cv=none; b=oEun3psnMIMUhXVOSGOhyFBlz5AqK2yWm6vj55T/716Y3UNirLjFl4J88+K4t1DclyXo0JaITgqMhqOmQRiCnVwk3T+825gonTNbVbHSQU0sEpK2S2HkBSurvAM7vrCbKpWx+8LRK571oXS5sYwRNQ79Z+bHvc/VxfsQWPYkdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106178; c=relaxed/simple;
	bh=iwyJwYp8M5dFr1SRSSf2e3fYskJnAS+lYcN55VFvO8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/dw+nZKNFw4Gt3Ot7XaBycAwBGL3LIT2kcgelwg4z8EAzRRm+TRUPSEsmuqaV3LTHREyUeFlgZ5+1NO86TBb2LMAIp5n41PEPkKh5BEtudQVp+CB19fW3YT1wC5sg9oBGp9eQdoFRACTRyC5ZBPcc2Dd5gsrIEOUkahe8oaPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0CC1688;
	Tue,  8 Apr 2025 02:56:16 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DF453F6A8;
	Tue,  8 Apr 2025 02:56:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.14.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Tue,  8 Apr 2025 15:26:00 +0530
Message-Id: <20250408095606.1219230-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408095606.1219230-1-anshuman.khandual@arm.com>
References: <20250408095606.1219230-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates ID_AA64MMFR0_EL1 register fields as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 762ee084b37c..13479c5a9b1b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1664,6 +1664,7 @@ EndEnum
 UnsignedEnum	59:56	FGT
 	0b0000	NI
 	0b0001	IMP
+	0b0010	FGT2
 EndEnum
 Res0	55:48
 UnsignedEnum	47:44	EXS
@@ -1725,6 +1726,7 @@ Enum	3:0	PARANGE
 	0b0100	44
 	0b0101	48
 	0b0110	52
+	0b0111	56
 EndEnum
 EndSysreg
 
-- 
2.30.2


