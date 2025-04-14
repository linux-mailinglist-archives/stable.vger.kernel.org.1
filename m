Return-Path: <stable+bounces-132388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33BA87719
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5553816F216
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E053919CC0A;
	Mon, 14 Apr 2025 04:59:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594454C6C
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744606757; cv=none; b=WJS3EDxuJ0qfxWy+ia2CRZdIID0WuRXujOc0fr+easGkqEeGWiSv+SX2waEGr6HtQjpvShMGat7oEdcnCF0wWiwQhGknKtgbh2MwhLVV44Su5ew8uL/fgYNEy5IdWoC6L7PMAG6rNbvLnb2fchrXKEdwgSBzfcMew/kt/AiSTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744606757; c=relaxed/simple;
	bh=SPavhNh3Btyo9GBD4sC1UwlGSyccDWggTbnViwMBm/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG7BQxD4+LojIO/wwmEnfFkubhH1P9Rj+NEFulStgIN9Lxwo4DKyHRzByr+ufcsAaYxV3dFTdRq+I28PveCjw26I/yclUsh6hej8DheE2M+/x4XNVZ3pzd1UVpIMDlf6N37+Na3xKCv68BguX9+Bvu54783Ie3tCcdZsdgeIRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951181688;
	Sun, 13 Apr 2025 21:59:14 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89AFF3F66E;
	Sun, 13 Apr 2025 21:59:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH V2 6.14.y 5/7] arm64/sysreg: Add register fields for HFGRTR2_EL2
Date: Mon, 14 Apr 2025 10:28:46 +0530
Message-Id: <20250414045848.2112779-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414045848.2112779-1-anshuman.khandual@arm.com>
References: <20250414045848.2112779-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HFGRTR2_EL2 as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-6-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 59236089ad5243377b6905d78e39ba4183dc35f5)
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0008ff35a655..cae085317b8c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2700,6 +2700,25 @@ Field	1	nPMIAR_EL1
 Field	0	nPMECR_EL1
 EndSysreg
 
+Sysreg	HFGRTR2_EL2	3	4	3	1	2
+Res0	63:15
+Field	14	nACTLRALIAS_EL1
+Field	13	nACTLRMASK_EL1
+Field	12	nTCR2ALIAS_EL1
+Field	11	nTCRALIAS_EL1
+Field	10	nSCTLRALIAS2_EL1
+Field	9	nSCTLRALIAS_EL1
+Field	8	nCPACRALIAS_EL1
+Field	7	nTCR2MASK_EL1
+Field	6	nTCRMASK_EL1
+Field	5	nSCTLR2MASK_EL1
+Field	4	nSCTLRMASK_EL1
+Field	3	nCPACRMASK_EL1
+Field	2	nRCWSMASK_EL1
+Field	1	nERXGSR_EL1
+Field	0	nPFAR_EL1
+EndSysreg
+
 Sysreg HDFGRTR_EL2	3	4	3	1	4
 Field	63	PMBIDR_EL1
 Field	62	nPMSNEVFR_EL1
-- 
2.30.2


