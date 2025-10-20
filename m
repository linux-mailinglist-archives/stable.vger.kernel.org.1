Return-Path: <stable+bounces-188213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A271BF2BBD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D2A4037F7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048E3321B3;
	Mon, 20 Oct 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="moRAzkFl"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F72BF01D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981815; cv=none; b=pv3K3Wc8IkQ5xx+mlOIZHOU1kqRFXtxnhikk3hnaogZmfQ04kGI2FJDfCNTiOh2RfoEqjGyv+xAMskfRCc/ajLFdGpMPmFm7Ju76mgbW7vhTFV3TgxzQzuTDbAA9SDfwBW3PR8+cJkqpEmMABOVUZWwo75MV6KCFiIfdLguIt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981815; c=relaxed/simple;
	bh=dYm2VT6HovKs9iSJ8sfHShheGsi1bRhftyF2pbvKzsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZ42rViqb1d0Gndh43bzYa2V2rgQyfjVwsUkxyibWqcxcMItlRIWqD015nfkLjYbLipdEmJTXLb8TlvVxlI/1lp0Zwp+HfDGSjEsNoDDmIbrO/KRhnDHBO+oOvLTCy74/SUQWzcaDf97dPzbT4lYaa1qmRpq9C2lTAqeThTzr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=moRAzkFl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Qwe8VbI9XVCJwO0+Ko/cYezStCoCTp/oRmW9pVIvRE=;
	b=moRAzkFlS2C/m4zmFuz3GpdA0wZUDR/AFhoorSiouCRuWYYpXhel3ZXdG7RqqEPvHRgYiR
	B1sJWDT3Veg4Fh0hIdTE0NaC0rdnqlSfWJ9vedtQw2cqCWQpoPv7vOT0vzNCtnElgat0t7
	c1zjfgKdXQn39EL6L7cy8dEn7pWEzH0=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 v2 00/10] fix invalid sleeping in detect_cache_attributes()
Date: Tue, 21 Oct 2025 01:36:14 +0800
Message-Id: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
in the CPU hotplug path")
adds a call to detect_cache_attributes() to populate the cacheinfo
before updating the siblings mask. detect_cache_attributes() allocates
memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
kernels, on secondary CPUs, this triggers a:
  'BUG: sleeping function called from invalid context'
as the code is executed with preemption and interrupts disabled:

 | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
 | in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
 | preempt_count: 1, expected: 0
 | RCU nest depth: 1, expected: 1
 | 3 locks held by swapper/111/0:
 |  #0:  (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
 |  #1:  (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
 |  #2:  (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
 | irq event stamp: 0
 | hardirqs last  enabled at (0):  0x0
 | hardirqs last disabled at (0):  copy_process+0x5dc/0x1ab8
 | softirqs last  enabled at (0):  copy_process+0x5dc/0x1ab8
 | softirqs last disabled at (0):  0x0
 | Preemption disabled at:
 |  migrate_enable+0x30/0x130
 | CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
 | Call trace:
 |  __kmalloc+0xbc/0x1e8
 |  detect_cache_attributes+0x2d4/0x5f0
 |  update_siblings_masks+0x30/0x368
 |  store_cpu_topology+0x78/0xb8
 |  secondary_start_kernel+0xd0/0x198
 |  __secondary_switched+0xb0/0xb4


Pierre fixed this issue in the upstream 6.3 and the original series is follows:
https://lore.kernel.org/all/167404285593.885445.6219705651301997538.b4-ty@arm.com/

We also encountered the same issue on 6.1 stable branch, and need to backport this series:
cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
cacheinfo: Return error code in init_of_cache_level()
cacheinfo: Check 'cache-unified' property to count cache leaves
ACPI: PPTT: Remove acpi_find_cache_levels()
ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
arch_topology: Build cacheinfo from primary CPU

And there was a non-trivial number of follow-on fixes for patches in this
series, as pointed out by Greg in the 6.1.156-RC1 review:
cacheinfo: Initialize variables in fetch_cache_info()
cacheinfo: Fix LLC is not exported through sysfs
drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

Finally, Jon discovered an issue in the Tegra platform caused by these patches:
https://lore.kernel.org/all/046f08cb-0610-48c9-af24-4804367df177@nvidia.com/
So we also need to backport the following patch:
arm64: tegra: Update cache properties

K Prateek Nayak (1):
  drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

Pierre Gondois (8):
  cacheinfo: Use RISC-V's init_cache_level() as generic OF
    implementation
  cacheinfo: Return error code in init_of_cache_level()
  cacheinfo: Check 'cache-unified' property to count cache leaves
  ACPI: PPTT: Remove acpi_find_cache_levels()
  ACPI: PPTT: Update acpi_find_last_cache_level() to
    acpi_get_cache_info()
  arch_topology: Build cacheinfo from primary CPU
  cacheinfo: Initialize variables in fetch_cache_info()
  arm64: tegra: Update cache properties

Yicong Yang (1):
  cacheinfo: Fix LLC is not exported through sysfs

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  15 +++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |   1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  33 +++++
 arch/arm64/kernel/cacheinfo.c            |  11 +-
 arch/riscv/kernel/cacheinfo.c            |  42 ------
 drivers/acpi/pptt.c                      |  93 ++++++++------
 drivers/base/arch_topology.c             |  12 +-
 drivers/base/cacheinfo.c                 | 156 +++++++++++++++++++----
 include/linux/cacheinfo.h                |  11 +-
 9 files changed, 262 insertions(+), 112 deletions(-)

-- 
2.25.1


