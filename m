Return-Path: <stable+bounces-128866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CBA7FA20
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2AE3A5029
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8A267702;
	Tue,  8 Apr 2025 09:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D67264FB0
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105153; cv=none; b=gaWwJlX+Hc9+2IlkT5jB9+yY2VmU+6TC4sbYvKy3DtstR7SBF577/g2MjwF2w+sDtNN7Ze/q+7o9huAips4B9N70ZZaxsknIneH6lSRYl/NVrqlTQuBHC0rYXH4YKNpgSOVRl2EUpwozumigJxoMzwVe7VKq76WFsgxDkNRns08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105153; c=relaxed/simple;
	bh=E9rnUSlzMyU2UdRF2Sv9+K/HEGxoJVxHLq+as1pG/B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqwuaWSVQrvSK9ZzfFUA8YOgGsqcWfhC7/89acuZ8vVgzbphMD18tATRmFuDyAuzJ+JH93ihZlR7MEQw4prutvYD0XChxSRKj/VYNfucZYdR5+BB/qrD6/L2QSdUSF7V9wZo+MY8h02zlWZTvExUlX3yAjbBvqpcWsc9ELwYUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C3AD16A3;
	Tue,  8 Apr 2025 02:39:12 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F40693F59E;
	Tue,  8 Apr 2025 02:39:08 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.13.y 2/7] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Tue,  8 Apr 2025 15:08:54 +0530
Message-Id: <20250408093859.1205615-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408093859.1205615-1-anshuman.khandual@arm.com>
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HDFGRTR2_EL2 as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-3-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[cherry picked from commit 44844551670cff70a8aa5c1cde27ad1e0367e009]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a6cbe0dcd63b..9ce8602dd40f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2546,6 +2546,35 @@ Field	1	ICIALLU
 Field	0	ICIALLUIS
 EndSysreg
 
+Sysreg HDFGRTR2_EL2	3	4	3	1	0
+Res0	63:25
+Field	24	nPMBMAR_EL1
+Field	23	nMDSTEPOP_EL1
+Field	22	nTRBMPAM_EL1
+Res0	21
+Field	20	nTRCITECR_EL1
+Field	19	nPMSDSFR_EL1
+Field	18	nSPMDEVAFF_EL1
+Field	17	nSPMID
+Field	16	nSPMSCR_EL1
+Field	15	nSPMACCESSR_EL1
+Field	14	nSPMCR_EL0
+Field	13	nSPMOVS
+Field	12	nSPMINTEN
+Field	11	nSPMCNTEN
+Field	10	nSPMSELR_EL0
+Field	9	nSPMEVTYPERn_EL0
+Field	8	nSPMEVCNTRn_EL0
+Field	7	nPMSSCR_EL1
+Field	6	nPMSSDATA
+Field	5	nMDSELR_EL1
+Field	4	nPMUACR_EL1
+Field	3	nPMICFILTR_EL0
+Field	2	nPMICNTR_EL0
+Field	1	nPMIAR_EL1
+Field	0	nPMECR_EL1
+EndSysreg
+
 Sysreg HDFGRTR_EL2	3	4	3	1	4
 Field	63	PMBIDR_EL1
 Field	62	nPMSNEVFR_EL1
-- 
2.30.2


