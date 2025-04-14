Return-Path: <stable+bounces-132383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4566A87716
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4877A4EBC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6118A95A;
	Mon, 14 Apr 2025 04:59:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD854C6C
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744606745; cv=none; b=SUD9ZkozMlZ5KV0RKxmNP8XmKYGtSAsoJkiD9Ae9qW0rxkbILYGh5HQt8JPBML6G/1G2vxosr/O6BWyUk1VsmBRPGJT5N93HSeg5Atbm8HvY6zYkQsKqGLgUO1bWgulMG2SsqxXQ0d/WE+xw4rfrlLUydiLIEBItXTLRVRtImC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744606745; c=relaxed/simple;
	bh=M60aNgZr2+aU/tktj43a8ZO64pWhMgtjBdlzImLnCI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BXzO7f4Nt/zwai7R2s2wFUlnqEeESO8knKF0D4RKAZZqR3oUUEeKHbW4egfxJqie8o3IM9v+L5t66mjaAygvvu/JLpHq7Hc1lF/zDqEBJGOHN6bGylcp4rD2Oa3MF0rpzTrXZHyAJd4Gmn6bshdUSRnwlAhPpih4GjajoBR0FR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EBD01007;
	Sun, 13 Apr 2025 21:59:00 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33E7C3F66E;
	Sun, 13 Apr 2025 21:58:58 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH V2 6.14.y 0/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Mon, 14 Apr 2025 10:28:41 +0530
Message-Id: <20250414045848.2112779-1-anshuman.khandual@arm.com>
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

- Replaced [] with () for upstream commit reference across patches in response
  to the following warning from Sasha

  https://lore.kernel.org/stable/f1153021-846b-4fb1-8c4d-9fa813f982d3@arm.com/

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


