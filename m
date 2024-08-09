Return-Path: <stable+bounces-66199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EB94CE6F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF521C21E0E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6441917D0;
	Fri,  9 Aug 2024 10:17:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D541C6E
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198668; cv=none; b=e7W1kNXuLoctuEwa8eiHhk/HbBKHcrZL/6cxyjw/6aniiqTMPdsGM4N/J3ZjWjH4L5xtyXcqlt20/vsYQimNhQolz3j1NiKu05bU7KmkwzdUtFiBA9UgR7AUHQzaYRD8FZmW/jxi2Po9I1r1Rb/hI5Hm6ppNKBsX+iu/IjRPFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198668; c=relaxed/simple;
	bh=CWc5iWXdecks53Wdttu/vEjHuU8NI8xxqFyMLQIDmMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esoDkg4iA4xFqbZtz8O+SbF9leKmq8FEtsFKs/pUknx6PpcbJ80uSLQ/GVK3h04vkYUAUFNmtEdJLIIlBeR5RPnjZjIEjI2tSMtUXpYiuv+AaEDOZJ8A6IWs04oERGTDxp26D+ggBydUkia48M4JXLetad0vXZ+Ee79GHVvMzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11AF2168F;
	Fri,  9 Aug 2024 03:18:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 152993F766;
	Fri,  9 Aug 2024 03:17:43 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10.y 00/13] arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 11:17:26 +0100
Message-Id: <20240809101739.3477931-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v5.10-only backport (based on v5.10.223) of the
upstream workaround for SSBS errata on Arm Ltd CPUs, as affected parts
are likely to be used with stable kernels. This does not apply to
earlier stable trees, which will receive a separate backport.

The errata mean that an MSR to the SSBS special-purpose register does
not affect subsequent speculative instructions, permitting speculative
store bypassing for a window of time.

The upstream support was original posted as:

* https://lore.kernel.org/linux-arm-kernel/20240508081400.235362-1-mark.rutland@arm.com/
  "arm64: errata: Add workaround for Arm errata 3194386 and 3312417"
  Present in v6.10

* https://lore.kernel.org/linux-arm-kernel/20240603111812.1514101-1-mark.rutland@arm.com/
  "arm64: errata: Expand speculative SSBS workaround"
  Present in v6.11-rc1

* https://lore.kernel.org/linux-arm-kernel/20240801101803.1982459-1-mark.rutland@arm.com/
  "arm64: errata: Expand speculative SSBS workaround (again)"
  Present in v6.11-rc2

This backport applies the patches which are not present in v5.10.y, and
as prerequisites backports HWCAP detection based on user-visible id
register values and the addition of Neoverse-V2 MIDR values. The
spec_bar() macro exists in v5.10.y as its removal was not backported,
and hence it doesn't need to be restored.

I have tested the backport (when applied to v5.10.223), ensuring that
the detection logic works and that the HWCAP and string in /proc/cpuinfo
are both hidden when the relevant errata are detected.

Mark.

Besar Wicaksono (1):
  arm64: Add Neoverse-V2 part

James Morse (1):
  arm64: cpufeature: Force HWCAP to be based on the sysreg visible to
    user-space

Mark Rutland (11):
  arm64: cputype: Add Cortex-X4 definitions
  arm64: cputype: Add Neoverse-V3 definitions
  arm64: errata: Add workaround for Arm errata 3194386 and 3312417
  arm64: cputype: Add Cortex-X3 definitions
  arm64: cputype: Add Cortex-A720 definitions
  arm64: cputype: Add Cortex-X925 definitions
  arm64: errata: Unify speculative SSBS errata logic
  arm64: errata: Expand speculative SSBS workaround
  arm64: cputype: Add Cortex-X1C definitions
  arm64: cputype: Add Cortex-A725 definitions
  arm64: errata: Expand speculative SSBS workaround (again)

 Documentation/arm64/silicon-errata.rst | 36 +++++++++++++++++++
 arch/arm64/Kconfig                     | 38 ++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/include/asm/cputype.h       | 16 +++++++++
 arch/arm64/kernel/cpu_errata.c         | 31 +++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 48 ++++++++++++++++++++++----
 arch/arm64/kernel/proton-pack.c        | 12 +++++++
 7 files changed, 176 insertions(+), 8 deletions(-)

-- 
2.30.2


