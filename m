Return-Path: <stable+bounces-66154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08C94CE14
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF179283139
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621E197531;
	Fri,  9 Aug 2024 09:58:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38721191F80
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197481; cv=none; b=kO+FiDMQzHxTXTstJeYv/I1grw+bFzi5l+d4Lru4wwf+1dWRDWdwgZZV+H73RfD9SvFVigOFm/3uv8MOUGC04vnszlaEd3hY2C5sNVqpSwPW+NloysWueOjy9wzRjomIVm3WJFvM7l8si+8xxL2ljKj6z9R2ET8g+yvePSgQMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197481; c=relaxed/simple;
	bh=B0UnNbM4lqRRAbbFD8Dmf1RI0YFVJg1MR6YFxnXteio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVWFlC1EuOW6wdzYADK5URdzrpzKuh1Q+eQtxuakGakrZ+ZJBgKSfW64ZdMzUNLPwZbr8vZrYjM7DBYBBkL998A8qiqwTER4/twM5aguyvGjj55ONjLR9Fcnsqvj3BT7PdfscL/7Wcg+cVE8v1iqjvuBkCT2TmiZs0LLvx/pPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5754613D5;
	Fri,  9 Aug 2024 02:58:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 368593F766;
	Fri,  9 Aug 2024 02:57:58 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.6.y 0/13] arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 10:57:32 +0100
Message-Id: <20240809095745.3476191-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v6.6-only backport (based on v6.6.44) of the upstream
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

This backport applies the patches which are not present in v6.6.y, and
as prerequisites backports the addition of the Neoverse-V2 MIDR values
and the restoration of the spec_bar() macro.

I have tested the backport (when applied to v6.6.44), ensuring that the
detection logic works and that the HWCAP and string in /proc/cpuinfo are
both hidden when the relevant errata are detected.

Mark.Besar Wicaksono (1):
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

 Documentation/arch/arm64/silicon-errata.rst | 36 +++++++++++++++++++
 arch/arm64/Kconfig                          | 38 +++++++++++++++++++++
 arch/arm64/include/asm/barrier.h            |  4 +++
 arch/arm64/include/asm/cputype.h            | 16 +++++++++
 arch/arm64/kernel/cpu_errata.c              | 31 +++++++++++++++++
 arch/arm64/kernel/cpufeature.c              | 12 +++++++
 arch/arm64/kernel/proton-pack.c             | 12 +++++++
 arch/arm64/tools/cpucaps                    |  1 +
 8 files changed, 150 insertions(+)

-- 
2.30.2


