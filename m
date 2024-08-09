Return-Path: <stable+bounces-66232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B694CEDA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22122281A63
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E31922DD;
	Fri,  9 Aug 2024 10:44:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8F191F65
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200252; cv=none; b=fPzeFr7FbUTEpSY1idy4XjFWbbnuhxjSySbRRn0p7Ehv50O6iN5CwzeAZvY9EfZv+BxOpiZYIX1HzHC4Aqu9IcZ/M4tLeAxrjp8/oF9k5BN7QWmYV1ih0yciNqj+SIo8788gzqEfD0U6WO3pko64SYdTxTU9le06KVYIm894s7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200252; c=relaxed/simple;
	bh=Y9vbl8qwEbZWfURGrArqXTKzu6PFfHrqq15A/Dqsj5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pf7OUYerwmjCdeLm8OdeFvg+2rkdIO3qvXqx5dHPpDkHstmN4mApn/Q2rgNHrDu4wKR1xOX9mX4E+epsZ2lGGvf+/sN4Oefddo9TpcCWpv7fjFiqz6M75ak91/4WD+BJZTS02GlXG1pt050oCWC08iZeT9R1G6FvGkmqQZ8cmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECDCF13D5;
	Fri,  9 Aug 2024 03:44:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D657A3F766;
	Fri,  9 Aug 2024 03:44:09 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	will@kernel.org
Subject: [PATCH 4.19.y 00/14]  arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 11:43:42 +0100
Message-Id: <20240809104356.3503412-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v4.19-only backport (based on v4.19.319) of the
upstream workaround for SSBS errata on Arm Ltd CPUs, as affected parts
are likely to be used with stable kernels.

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

This backport applies the patches which are not present in v4.19.y, and
as prerequisites backports the addition of spec_bar() and SB support,
HWCAP detection based on user-visible id register values. and the
addition of Neoverse-V2 MIDR values.

I have tested the backport (when applied to v4.19.319), ensuring that
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

Will Deacon (1):
  arm64: Add support for SB barrier and patch in over DSB; ISB sequences

 Documentation/arm64/silicon-errata.txt | 18 ++++++++
 arch/arm64/Kconfig                     | 38 ++++++++++++++++
 arch/arm64/include/asm/assembler.h     | 13 ++++++
 arch/arm64/include/asm/barrier.h       |  4 ++
 arch/arm64/include/asm/cpucaps.h       |  4 +-
 arch/arm64/include/asm/cputype.h       | 16 +++++++
 arch/arm64/include/asm/sysreg.h        |  6 +++
 arch/arm64/include/asm/uaccess.h       |  3 +-
 arch/arm64/include/uapi/asm/hwcap.h    |  1 +
 arch/arm64/kernel/cpu_errata.c         | 43 ++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 61 ++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c            |  1 +
 12 files changed, 197 insertions(+), 11 deletions(-)

-- 
2.30.2


