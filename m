Return-Path: <stable+bounces-72868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC1096A8BE
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10FC1C239D4
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43461DB557;
	Tue,  3 Sep 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmOKG2Px"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1991D0177;
	Tue,  3 Sep 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396157; cv=none; b=bMijiNgb2dsGaRq7CQiaGHfLEqqY49O8Hy0jFZdFbEeQdgaC3PLwM5EwWjjge1bJBd0Ased6Ie5eBnb2LkihMjl6ASRmq0v3bQkNmyCBUikWVsk0GlhHni1qibwuCJrGEA8oXIf/jcf2hQ/EFFcUTpM+YcDKxtLYA4F8DN62qLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396157; c=relaxed/simple;
	bh=D79/0a6QlmtzBsbzw+AByUvzS5BoygBrnbpfafEmks0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCU2pj6Hgrv9Ay+izoddPkIYxLalnUrBx5wwWXSnj/YwfWxQIpHy1CLd84OwoI7jMg1HF+mLBEwTajaQYRDaSBoBe8h+R0ctltP0f/cCa0MnEsKgU7EPM1G2QgwRavXG3LCpdj6t/R3CkVR0o9GtDBtuu6qVT1bByJV68jS/RWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmOKG2Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF7FC4CEC5;
	Tue,  3 Sep 2024 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396157;
	bh=D79/0a6QlmtzBsbzw+AByUvzS5BoygBrnbpfafEmks0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmOKG2PxpaWWFQyH6GEW3tV0kz/FtPe8OhdUx0cWQkaK4Wlpr7/meh+2kY433QPjM
	 1uZrYY75rB0HrVwr3w2631XNIVtO2OvmlqVkQku6o3OdCAuTaD1ZJixwtXWWzeK4wC
	 vs81Tuyy9mMxhl7+cSq4uDGr8LaC0aZkrv9andEl279z0C9CCekpHShCVTa6HDveUa
	 X69XuN2FVUMjqUxkNK3UkG9kP6wbtcutBdsYk0pb7EY8wOd5a9ngIEHpSdDhYDXd+r
	 i6vhNxKDTqzyOGPPFXWAz+KVGO/2eUCsVow5EOd+AXiMZG2tgHOxuRAeVrmL43MPRp
	 5YsEfbc8Jqvtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	lvjianmin@loongson.cn,
	wangliupu@loongson.cn,
	maobibo@loongson.cn,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 14/22] LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE
Date: Tue,  3 Sep 2024 15:22:01 -0400
Message-ID: <20240903192243.1107016-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 274ea3563e5ab9f468c15bfb9d2492803a66d9be ]

Currently we call irq_set_noprobe() in a loop for all IRQs, but indeed
it only works for IRQs below NR_IRQS_LEGACY because at init_IRQ() only
legacy interrupts have been allocated.

Instead, we can define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE in asm/hwirq.h
and the core will automatically set the flag for all interrupts.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/hw_irq.h | 2 ++
 arch/loongarch/kernel/irq.c         | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd858..8156ffb674159 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c03514f4..adac8fcbb2aca 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -102,9 +102,6 @@ void __init init_IRQ(void)
 	mp_ops.init_ipi();
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
-- 
2.43.0


