Return-Path: <stable+bounces-128881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D0A7FB05
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ACE3A779B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01426659F;
	Tue,  8 Apr 2025 09:56:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF91266B4B
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106186; cv=none; b=eype3frz2NDtvZONVKd731eNlI0g29pOcSgOzIRm5JknGGuR2WSDJg+cv9I4+u1LKwXq6TY4ZLPUsSNiIHCtWfo7236FYv1ngygvqEFMbWcPzwQgrBvCArEa6A14jcTkamFTm4QHlMh41d/P/LOLGrczaJan0eo16Ds0Lwiuxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106186; c=relaxed/simple;
	bh=S/InSRwpNLZI35GFTmyFT56mR5uhN0+AkkVT6cGTLv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZufWktOvgt33yldFf8UPQxjNpoB283IhUOPQ9hkjLAgJdvMAn42uEaGyBzDqrylkV1HUa2nA/z3GD9MTC79+oqJHF064wq2UvXO5p0B5g4ZEJpO+X+htUnTo2SKGNxOs54cPNk0LmV+6DNoWBZoHN5nC/gVA8MMB6QqcFJNd814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5031688;
	Tue,  8 Apr 2025 02:56:25 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BE903F6A8;
	Tue,  8 Apr 2025 02:56:22 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.14.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Tue,  8 Apr 2025 15:26:03 +0530
Message-Id: <20250408095606.1219230-5-anshuman.khandual@arm.com>
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

This adds register fields for HFGITR2_EL2 as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-5-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[cherry picked from commit 9401476f17747586a8bfb29abfdf5ade7a8bceef]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index f1c366866c93..0008ff35a655 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2872,6 +2872,12 @@ Field	1	AMEVCNTR00_EL0
 Field	0	AMCNTEN0
 EndSysreg
 
+Sysreg	HFGITR2_EL2	3	4	3	1	7
+Res0	63:2
+Field	1	nDCCIVAPS
+Field	0	TSBCSYNC
+EndSysreg
+
 Sysreg	ZCR_EL2	3	4	1	2	0
 Fields	ZCR_ELx
 EndSysreg
-- 
2.30.2


