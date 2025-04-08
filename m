Return-Path: <stable+bounces-128864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DCA7FA08
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35297A9A1A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C02676EC;
	Tue,  8 Apr 2025 09:39:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695626561E
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105148; cv=none; b=CtF9RWJBf7kX+5Fv5yO+HlBX79VJvl/pexMFAGsZFrW2p28lj0O9c5hIyLkSxZY1/IUzyLZXwIr+Gq7dbyprpqQ7tshLbLGBlTSviJU0BB7Q8ugYWvnDCsv0p9uiHap4UwGrDzSYxceXSMPzKtHtms4rNzOmc+xA32E3DrqqL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105148; c=relaxed/simple;
	bh=8OMqvkdXvGn7EuAFdDAaMmjDA2x/JBt+ui9Adx5DAfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anObcoFZl1i2qbMaBHblPLJkNkOYKfKAD4H2fwhu1OJF/555xDBRz591iPEI0uVptrNvvIcq/JjyjXLEzOtEvrBIDfrfISsS18u8BRSg93mRSMMR7SkD0iUGgx+n3hFv1hhzwTq9ltTJAs98Hqx7SPEMkCE/EV170Ehfj2/v1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795CD1688;
	Tue,  8 Apr 2025 02:39:06 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B3223F59E;
	Tue,  8 Apr 2025 02:39:03 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Tue,  8 Apr 2025 15:08:52 +0530
Message-Id: <20250408093859.1205615-1-anshuman.khandual@arm.com>
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
already been merged upstream from 6.13 onwards.

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

 Documentation/arch/arm64/booting.rst |  22 ++++++
 arch/arm64/include/asm/el2_setup.h   |  25 +++++++
 arch/arm64/tools/sysreg              | 103 +++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

-- 
2.30.2


