Return-Path: <stable+bounces-66168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447994CE29
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15471F255FE
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD9191F65;
	Fri,  9 Aug 2024 10:02:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80C16D307
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197753; cv=none; b=sOGiijXEci5VQNYjxoSzDxoB89XuvspIkpWHSOW+PESc1kxQqwJgBtMRFnCIj4MFgqi3sx2aOh6T2Hn0CBdTgA6PoxZUwNDssj2FgV4Pu7PK7R2xEKimZa63DveLVNuaB3qNHttxPnLrrIUq5uUrSP/XpbSHGhB+pQUXlVoXnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197753; c=relaxed/simple;
	bh=h17MBfouG4Z4smSYN64FGaz43oPNcUFWi1ckYcspZBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/5tvINE5DoZtnV9kQpNH2g7bqQZYGXSIQgBDplmEoUI+mvzTnNXkDY4v/Ggkw7r9QA+tgotPNVmmuCUBs3Ci+I/Np/ptjjYsM0Mg94+NrAis2leCcvdsqc+8L5egmCnGjZ209k0wdErnMzXTAtLno1Mj9K1d1z9IQp15TSZfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF5713D5;
	Fri,  9 Aug 2024 03:02:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5B323F766;
	Fri,  9 Aug 2024 03:02:28 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.1.y 00/13] arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 11:02:10 +0100
Message-Id: <20240809100223.3476634-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v6.1-only backport (based on v6.1.103) of the upstream
workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely
to be used with stable kernels. This does not apply to earlier stable
trees, which will receive a separate backport.

The errata mean that an MSR to the SSBS special-purpose register does not
affect subsequent speculative instructions, permitting speculative store
bypassing for a window of time.

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

This backport applies the patches which are not present in v6.1.y and as
prerequisites backports the addition of the Neoverse-V2 MIDR values and
the restoration of the spec_bar() macro.

I have tested the backport (when applied to v6.1.103), ensuring that the
detection logic works and that the HWCAP and string in /proc/cpuinfo are
both hidden when the relevant errata are detected.

Mark.

Besar Wicaksono (1):
  arm64: Add Neoverse-V2 part

Mark Rutland (12):
  arm64: barrier: Restore spec_bar() macro
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

 Documentation/arm64/silicon-errata.rst | 36 ++++++++++++++++++++++++
 arch/arm64/Kconfig                     | 38 ++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h       |  4 +++
 arch/arm64/include/asm/cputype.h       | 16 +++++++++++
 arch/arm64/kernel/cpu_errata.c         | 31 +++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 12 ++++++++
 arch/arm64/kernel/proton-pack.c        | 12 ++++++++
 arch/arm64/tools/cpucaps               |  1 +
 8 files changed, 150 insertions(+)

-- 
2.30.2


