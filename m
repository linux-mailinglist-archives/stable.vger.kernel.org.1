Return-Path: <stable+bounces-66144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86094CDF5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B5D284B8C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC2192B71;
	Fri,  9 Aug 2024 09:51:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698F191F71
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197089; cv=none; b=Uz4dQ4sDFPnVkjiNcGyQ/xnbECmK21fYs09ASlvlsTvLnJHT6Q5JeXhbCxt3vpg4aoJDJhe0z1mT9XuH67D4GMifqcpLE+yFJE//47Ubtxyw+jCngcaMrGPROOsUvy6Ypm/9oHUIRr6uoh/Q/8TczRBxIqxexNL69SjsYRNk10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197089; c=relaxed/simple;
	bh=QCuDKdxH88AHY123x/AgAvmHXoh0aMFA73UYe7WJQ6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HuFgxU6hbuNiv5c4/NaoVVEr7+FGm2AvVnEvqbQAwNY65+4JbR5rhN6kFI4a6Hae8sLqyhWZ0+RY/6v0m25NMnO3PY7td902v+T0bxyWF+9RmdKJMypEvBn5zJS7pcI8BZGFHK3QIpzOLruX+mTUO7armLEA/5UywkESQLxuJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A6C13D5;
	Fri,  9 Aug 2024 02:51:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 741973F766;
	Fri,  9 Aug 2024 02:51:26 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.10.y 0/8] arm64: errata: Speculative SSBS workaround
Date: Fri,  9 Aug 2024 10:51:12 +0100
Message-Id: <20240809095120.3475335-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v6.10-only backport (based on v6.10.3) of the upstream
workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely to be
used with stable kernels. This does not apply to earlier stable trees, which
will receive a separate backport.

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

This backport applies the patches which are not present in v6.10.y.

I have tested the backport (when applied to v6.10.3), ensuring that the
detection logic works and that the HWCAP and string in /proc/cpuinfo are
both hidden when the relevant errata are detected.

Mark.

Mark Rutland (8):
  arm64: cputype: Add Cortex-X3 definitions
  arm64: cputype: Add Cortex-A720 definitions
  arm64: cputype: Add Cortex-X925 definitions
  arm64: errata: Unify speculative SSBS errata logic
  arm64: errata: Expand speculative SSBS workaround
  arm64: cputype: Add Cortex-X1C definitions
  arm64: cputype: Add Cortex-A725 definitions
  arm64: errata: Expand speculative SSBS workaround (again)

 Documentation/arch/arm64/silicon-errata.rst | 34 ++++++++++-
 arch/arm64/Kconfig                          | 62 ++++++++++-----------
 arch/arm64/include/asm/cpucaps.h            |  2 +-
 arch/arm64/include/asm/cputype.h            | 10 ++++
 arch/arm64/kernel/cpu_errata.c              | 26 ++++++---
 arch/arm64/kernel/proton-pack.c             |  2 +-
 6 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.30.2


