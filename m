Return-Path: <stable+bounces-98601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F119E48DB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4927828270A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA36207675;
	Wed,  4 Dec 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRKKX5uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65051206F02;
	Wed,  4 Dec 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354772; cv=none; b=tZuOkZvNRJOx4bVd+FqFq9qo5VD7ocCKSemUUD7jPrD3H6q9tvkxsKE1YlTjFQoIBRsFd2j2yNGNUoR6l4h01/IcHBnhMJ43qYuJ5SnquX/tXbC0ztJc+OsmHFzgFQO8mqjsfQFzCT4ecSprm7ZuNEG7FlYNjCXyWi0w9kTnHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354772; c=relaxed/simple;
	bh=V9u7XI+QSVXRCVDSdLlxcWtcxujY49M4RdlhubV46Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFSPLTUp/Hyr1OrUZGQdF7Gn0KsfZPS8eAmwczAbw/tBipCSDP9BIKvSemxpCmfQUQT8f6DxsBwOE8ay8uSgrfZRV0VqphiMZW+etV3p7tiLMkE3Dec+XVNVwMzaDz6P2In1JZnUnyDoJJdheOjyWfsKq35pyW1LqTHikO1MmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRKKX5uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769DBC4CECD;
	Wed,  4 Dec 2024 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354771;
	bh=V9u7XI+QSVXRCVDSdLlxcWtcxujY49M4RdlhubV46Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRKKX5uCVdA2HHsSVFeL8cCWUyjPigYgZ0u5323CpppSWQGPqEUS3tZtMwbNWDKxw
	 b9wlkK67MlJvDBdRLTyII8/v7OLDtolB7KzkUsRdFz6nhrv42xE/z6cD9sJaQhZ/oh
	 jOMqXgM0sbPqdKSL7BaNVKC1uKWcumVWnf3msG2H9RG3dxfpYm4BN78yguJjnmCfHb
	 wXxG+pRFV2bi/SsCHytSViu/sQqnxYrfhpbC7iOgdDMKnDJ+G+VbbMlAeqlLGKL15k
	 Vl6NspqX9LPxJKkQh4yqVwlbOLsEU6gdCEVQtPJ9IpkwwW8sMs2mnHLNlJurm2TR2a
	 POAehfq2BXBHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tangyouling@loongson.cn,
	yangtiezhu@loongson.cn,
	hejinyang@loongson.cn,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 3/3] LoongArch: Fix sleeping in atomic context for PREEMPT_RT
Date: Wed,  4 Dec 2024 17:14:39 -0500
Message-ID: <20241204221445.2247192-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221445.2247192-1-sashal@kernel.org>
References: <20241204221445.2247192-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 88fd2b70120d52c1010257d36776876941375490 ]

Commit bab1c299f3945ffe79 ("LoongArch: Fix sleeping in atomic context in
setup_tlb_handler()") changes the gfp flag from GFP_KERNEL to GFP_ATOMIC
for alloc_pages_node(). However, for PREEMPT_RT kernels we can still get
a "sleeping in atomic context" error:

[    0.372259] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    0.372266] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    0.372268] preempt_count: 1, expected: 0
[    0.372270] RCU nest depth: 1, expected: 1
[    0.372272] 3 locks held by swapper/1/0:
[    0.372274]  #0: 900000000c9f5e60 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x524/0x1c60
[    0.372294]  #1: 90000000087013b8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x50/0x140
[    0.372305]  #2: 900000047fffd388 (&zone->lock){+.+.}-{3:3}, at: __rmqueue_pcplist+0x30c/0xea0
[    0.372314] irq event stamp: 0
[    0.372316] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.372322] hardirqs last disabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
[    0.372329] softirqs last  enabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
[    0.372335] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.372341] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc7+ #1891
[    0.372346] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
[    0.372349] Stack : 0000000000000089 9000000005a0db9c 90000000071519c8 9000000100388000
[    0.372486]         900000010038b890 0000000000000000 900000010038b898 9000000007e53788
[    0.372492]         900000000815bcc8 900000000815bcc0 900000010038b700 0000000000000001
[    0.372498]         0000000000000001 4b031894b9d6b725 00000000055ec000 9000000100338fc0
[    0.372503]         00000000000000c4 0000000000000001 000000000000002d 0000000000000003
[    0.372509]         0000000000000030 0000000000000003 00000000055ec000 0000000000000003
[    0.372515]         900000000806d000 9000000007e53788 00000000000000b0 0000000000000004
[    0.372521]         0000000000000000 0000000000000000 900000000c9f5f10 0000000000000000
[    0.372526]         90000000076f12d8 9000000007e53788 9000000005924778 0000000000000000
[    0.372532]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
[    0.372537]         ...
[    0.372540] Call Trace:
[    0.372542] [<9000000005924778>] show_stack+0x38/0x180
[    0.372548] [<90000000071519c4>] dump_stack_lvl+0x94/0xe4
[    0.372555] [<900000000599b880>] __might_resched+0x1a0/0x260
[    0.372561] [<90000000071675cc>] rt_spin_lock+0x4c/0x140
[    0.372565] [<9000000005cbb768>] __rmqueue_pcplist+0x308/0xea0
[    0.372570] [<9000000005cbed84>] get_page_from_freelist+0x564/0x1c60
[    0.372575] [<9000000005cc0d98>] __alloc_pages_noprof+0x218/0x1820
[    0.372580] [<900000000593b36c>] tlb_init+0x1ac/0x298
[    0.372585] [<9000000005924b74>] per_cpu_trap_init+0x114/0x140
[    0.372589] [<9000000005921964>] cpu_probe+0x4e4/0xa60
[    0.372592] [<9000000005934874>] start_secondary+0x34/0xc0
[    0.372599] [<900000000715615c>] smpboot_entry+0x64/0x6c

This is because in PREEMPT_RT kernels normal spinlocks are replaced by
rt spinlocks and rt_spin_lock() will cause sleeping. Fix it by disabling
NUMA optimization completely for PREEMPT_RT kernels.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 56bf1dd5358aa..526310ec73c7e 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -292,7 +292,7 @@ static void setup_tlb_handler(int cpu)
 		/* Avoid lockdep warning */
 		rcu_cpu_starting(cpu);
 
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
 		vec_sz = sizeof(exception_handlers);
 
 		if (pcpu_handlers[cpu])
-- 
2.43.0


