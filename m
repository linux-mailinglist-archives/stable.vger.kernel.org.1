Return-Path: <stable+bounces-132684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B89A8931F
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 06:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870721896AFC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66D266B5D;
	Tue, 15 Apr 2025 04:57:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD522FF2E
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693059; cv=none; b=tQbmklpJ6A9qW5XqzwhIIg0lv2cJ+kjHriAPi9Hxuogk2way0s4jt+zKRyZiTVGiGM72/7d2gcDYR6ueaVoEPtHLg8GtttUrZbEuKaENA2LYgKnDmRoJ6JJ0R2DA1a9box/ysOCaqIUG/c4FyZg+PGWSN4XMLFo3I5xnltkR2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693059; c=relaxed/simple;
	bh=oqTO0wct077jz+I/t+pPbeSZvfX/6twqZmvwZLlt6iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jn7dLNDD49XGknMCYWWdarpfGznmsHA4QV7nsfALBXe+C30l17NhPr/EOCghl5Z07aVnRMFByhr4YcHHq5HjbVQYsHf5+JSP+o/niHVE0neZLhBIVAj0kRB79vc00Z2AEn7AtNgGQocTkVeiMFiRYxCtOiu1UMaewaFJLxRLNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB36B15A1;
	Mon, 14 Apr 2025 21:57:33 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.49.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 868FA3F66E;
	Mon, 14 Apr 2025 21:57:32 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH V2 6.12.y 0/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Tue, 15 Apr 2025 10:27:21 +0530
Message-Id: <20250415045728.2248935-1-anshuman.khandual@arm.com>
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

Changes in V2:

- Dropped [PATCH 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
- Folded ID_AA64DFR0_EL1_PMUVer_V3P9 definition in arch/arm64/tools/sysreg which
  was added in commit 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0
  access control")

Anshuman Khandual (7):
  arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
  arm64/sysreg: Add register fields for HDFGRTR2_EL2
  arm64/sysreg: Add register fields for HDFGWTR2_EL2
  arm64/sysreg: Add register fields for HFGITR2_EL2
  arm64/sysreg: Add register fields for HFGRTR2_EL2
  arm64/sysreg: Add register fields for HFGWTR2_EL2
  arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9

 Documentation/arch/arm64/booting.rst |  22 ++++++
 arch/arm64/include/asm/el2_setup.h   |  25 +++++++
 arch/arm64/tools/sysreg              | 104 +++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

-- 
2.30.2


