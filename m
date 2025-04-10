Return-Path: <stable+bounces-132030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA582A83772
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 05:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F7119E32DF
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149801EF080;
	Thu, 10 Apr 2025 03:55:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A61E5734
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257352; cv=none; b=R8x6McEuwnG88AaGB2uXHX53YoxQUo2Nq25mt5Ew6WALzYfwBR1KhgNHGBOihmVGCIkhJodxYSoVbxnpTH/vpmEmFwnS7/d0zXr82G3zPYvODY65IgzAOwyPe8zW/exv4U5+rsWFda8yOWYYQbBBiJ+LL1OrUDzyAUaSlO/Vfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257352; c=relaxed/simple;
	bh=lP9fqgml5npI9Oe/4lGKmBM3ZMni5BbeeU4ZpRRWHPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvwJAvHbLfe06WztDMwG26pis8JLCCFe9mN+kb/Re+wwXMrk9f+KuMgvQowGHG7v1el0jLaqTSpSW8up4fjFLMzuFjie+1zWPtqHawPPmrWCMkFK6swLuqzWIW6tIyxwkYgHNJ942fGJV2QA56O6s8VdgaJc1nswxWLI2Z1A9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F34152B;
	Wed,  9 Apr 2025 20:55:49 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 57ADA3F6A8;
	Wed,  9 Apr 2025 20:55:47 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.12.y 0/8] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Thu, 10 Apr 2025 09:25:35 +0530
Message-Id: <20250410035543.1518500-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
being used in the kernel. This is required to prevent their EL1 access trap
into EL2.

The following commits that enabled access into FEAT_PMUv3p9 registers have
already been merged upstream from 6.12 onwards.

d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")

The sysreg patches in this series are required for the final patch which
fixes the actual problem.

Anshuman Khandual (7):
  arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
  arm64/sysreg: Add register fields for HDFGRTR2_EL2
  arm64/sysreg: Add register fields for HDFGWTR2_EL2
  arm64/sysreg: Add register fields for HFGITR2_EL2
  arm64/sysreg: Add register fields for HFGRTR2_EL2
  arm64/sysreg: Add register fields for HFGWTR2_EL2
  arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9

Rob Herring (Arm) (1):
  perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control

 Documentation/arch/arm64/booting.rst |  22 ++++++
 arch/arm/include/asm/arm_pmuv3.h     |   6 ++
 arch/arm64/include/asm/arm_pmuv3.h   |  10 +++
 arch/arm64/include/asm/el2_setup.h   |  25 ++++++
 arch/arm64/tools/sysreg              | 111 +++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c             |  29 ++++---
 include/linux/perf/arm_pmuv3.h       |   1 +
 7 files changed, 194 insertions(+), 10 deletions(-)

-- 
2.30.2


