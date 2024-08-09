Return-Path: <stable+bounces-66218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B294CEBC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAE280E4F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B8190490;
	Fri,  9 Aug 2024 10:34:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98C191F7F
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199674; cv=none; b=KQc5fEihXVTklOk7wOWQLeUjwpJ/TUiBf25+NAOhOkMR7WR2nO/3zV0FORNXDuLdY4jOHSB6IN96fnhjfThTVPyna1ypVU4M8bti3P0QvOFyICYdLCOIpvjn3GjPJeuGzVASuZx9p9FE473aZno9amFP1WrfdHI3WqPKEsb+eio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199674; c=relaxed/simple;
	bh=jPSLshS6iaLdkoazDSL9hn8CyjgdYklgkLx31Ta7ECY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ll1GBOHToDWgOiV5nMAH7kRFBtZwNfSi0io0gneWOcEYEf3NoBIBdjLv08vDE+ThN1LzziZg8+3E3/090Zhe1Ef7bEzMLf6Yb1wCQGurRZ73+gbpDh97DOuAIApF90f+OZ1X1hh6hNhrcUngHK0X5RRqSbYWnzZ/EnOeMcEc/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA3DC13D5;
	Fri,  9 Aug 2024 03:34:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEEEF3F766;
	Fri,  9 Aug 2024 03:34:31 -0700 (PDT)
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
Subject: [PATCH 5.4.y 00/13] arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 11:34:13 +0100
Message-Id: <20240809103426.3478542-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v5.4-only backport (based on v5.4.281) of the upstream
workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely
to be used with stable kernels. This does not apply to earlier stable
trees, which will receive a separate backport.

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

This backport applies the patches which are not present in v5.4.y, and
as prerequisites backports HWCAP detection based on user-visible id
register values and the addition of Neoverse-V2 MIDR values. The
spec_bar() macro exists in v5.4.y as its removal was not backported, and
hence it doesn't need to be restored.

I have tested the backport (when applied to v5.4.281), ensuring that the
detection logic works and that the HWCAP and string in /proc/cpuinfo are
both hidden when the relevant errata are detected.

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
 arch/arm64/kernel/cpu_errata.c         | 44 +++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 48 ++++++++++++++++++++++----
 6 files changed, 177 insertions(+), 8 deletions(-)

-- 
2.30.2


