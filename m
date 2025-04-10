Return-Path: <stable+bounces-132035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE035A83777
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 05:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2C319E600D
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09E1F0E49;
	Thu, 10 Apr 2025 03:56:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC471E9B3C
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257365; cv=none; b=R1vF1RqWR7fyvyAj3isS9QWWxXJhR+TnE5qUb0z7YQBIWTW3GBL3QD3p/xXggloBt+evSl05v7SB1Ndk9784zs2JMnVJc1ELsmx6wpbonBB4O384Dbhk2sQpByN2qQJTdc+JWXhpe+2DNMp7n1fCh5wvXeggCGvRlpqMiXZZsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257365; c=relaxed/simple;
	bh=BAbvg5SU2qMERAapYyyZcMI2SBvxPB1XaHfLKZh0wdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCrjLpzcFnzNJOOKJqeSFFqss/VH8AJret5cqGjTKKze2v1Fcdroz8lcBWoGaANHpaAAq5dY7BtPRp6802uMEzC2OGrUHhAZBNF0aNgVafr3grvcdVJPQYiWHuSECsjSyM6Xvuu1l3r8BfUHiTwpFfgojQVi/RZVdB4tsbUNvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A505A152B;
	Wed,  9 Apr 2025 20:56:03 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4131A3F6A8;
	Wed,  9 Apr 2025 20:56:01 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.12.y 5/8] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Thu, 10 Apr 2025 09:25:40 +0530
Message-Id: <20250410035543.1518500-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250410035543.1518500-1-anshuman.khandual@arm.com>
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
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
index dfa388e6b6de..6e29235e0f44 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2702,6 +2702,12 @@ Field	1	AMEVCNTR00_EL0
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


