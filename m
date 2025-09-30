Return-Path: <stable+bounces-182846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F5BAE2B7
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4D32511D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B726B0AE;
	Tue, 30 Sep 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e0XNhCO0"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E68287E
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253287; cv=none; b=gJTWwcCC9txLx3OEln9GDJ1oaANqQuTesBdeE6lbhjx4t2EeabBY7xqs6BIUYGkybiOhC6w63wnwe5j4x76uu9pZaAQheC3zFdkk/p0gP8co6VBvcgGDTBcMuBxQ/N2aHEsDrA5llxh34DD56B8+BBo4KDpwvcoFOM2WHVJPdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253287; c=relaxed/simple;
	bh=bN8050SeQ37WVbp086DyHKJ2gMBp8Gfpzlww6eit/+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Erwzb6ls1xnSyetyS30JSROMcgrvAaYmCpYUNc8qP8XTTZPj3C8Rd11ZmLZF4M4SOBq6cw7/Yj8ciBmfw76EQOsATqLaQZu/GWHgcVrOqWei0o49yn0ZYCHWkbxlfHVn2qiKuJk7kEdk1AGOYYannPMzoQxuBeP+fXuTKZBJUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e0XNhCO0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759253282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kb4vrT1IqfH/wEYBny1isKoOnot4x3idjBMooqMXDo0=;
	b=e0XNhCO0QY88WWEuyjnQYGLJAO+J9szaoUtDS/hwOGLW5j43As9+o/bLM4nQZrzLxQpPN4
	dH+lmj5LqCsHXt7krdDygNx8ZENZl+Vs5JD2LbgZT5JUU6Q4+CkWiq93HZ7AGDQqaKJvhU
	c+3UMMe+dTIZAN+PM3QPkBSFjcr8jUo=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 0/6] fix invalid sleeping in detect_cache_attributes()
Date: Wed,  1 Oct 2025 01:27:25 +0800
Message-Id: <cover.1759251543.git.wen.yang@linux.dev>
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

We also encountered the same issue on 6.1 stable branch,  and need to backport this series.

Pierre Gondois (6):
  cacheinfo: Use RISC-V's init_cache_level() as generic OF
    implementation
  cacheinfo: Return error code in init_of_cache_level()
  cacheinfo: Check 'cache-unified' property to count cache leaves
  ACPI: PPTT: Remove acpi_find_cache_levels()
  ACPI: PPTT: Update acpi_find_last_cache_level() to
    acpi_get_cache_info()
  arch_topology: Build cacheinfo from primary CPU

 arch/arm64/kernel/cacheinfo.c |  11 ++-
 arch/riscv/kernel/cacheinfo.c |  42 -----------
 drivers/acpi/pptt.c           |  93 +++++++++++++----------
 drivers/base/arch_topology.c  |  12 ++-
 drivers/base/cacheinfo.c      | 134 +++++++++++++++++++++++++++++-----
 include/linux/cacheinfo.h     |  11 ++-
 6 files changed, 196 insertions(+), 107 deletions(-)

-- 
2.25.1


