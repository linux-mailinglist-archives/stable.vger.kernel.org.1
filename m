Return-Path: <stable+bounces-3002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82467FC728
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DD6B2520A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4B44C67;
	Tue, 28 Nov 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8qw7WMk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD044379;
	Tue, 28 Nov 2023 21:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02443C43140;
	Tue, 28 Nov 2023 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205702;
	bh=QYx+sqJaBAxqnn+BdYiCgC+ZZ4qHM1FSzDwVmX1i7z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8qw7WMkyWdeYu/7ZQD7n3r7C4YB2OVakLWWspvDEWI8HcxxlVq2Q/t5BAS6c+Uh5
	 MTrlJW1OCQGjW2qUzadhjDyJj5Ywybllb4ECPa+HexOH0xBV5whp2S01Ka5y3fcTGV
	 DG1WXy/jNozD5gJMaHtvwU/xQhD7IYbNYhuvgCyBQFzIoDXBx+0UG21CkKhmeZl0y0
	 +jueLXDZDAS+mFpm+IEpjSTfY/H+7sZwejGLF8uh24BHren+Duq/L4irFC9jGKe8NS
	 7MNbLwxM+lIQtkMHpShbcYdI0h3RS5wHHg5RS8jPzJykyJeJgkdAibPVOBijY+wRuK
	 6cj0WLs5ZA7gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	peterz@infradead.org,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 16/25] LoongArch: Implement constant timer shutdown interface
Date: Tue, 28 Nov 2023 16:07:32 -0500
Message-ID: <20231128210750.875945-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit

From: Bibo Mao <maobibo@loongson.cn>

[ Upstream commit d43f37b73468c172bc89ac4824a1511b411f0778 ]

When a cpu is hot-unplugged, it is put in idle state and the function
arch_cpu_idle_dead() is called. The timer interrupt for this processor
should be disabled, otherwise there will be pending timer interrupt for
the unplugged cpu, so that vcpu is prevented from giving up scheduling
when system is running in vm mode.

This patch implements the timer shutdown interface so that the constant
timer will be properly disabled when a CPU is hot-unplugged.

Reviewed-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/time.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index d2b7d5df132a9..150df6e17bb6a 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -58,14 +58,16 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
+static int constant_set_state_periodic(struct clock_event_device *evt)
 {
+	unsigned long period;
 	unsigned long timer_config;
 
 	raw_spin_lock(&state_lock);
 
-	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
-	timer_config &= ~CSR_TCFG_EN;
+	period = const_clock_freq / HZ;
+	timer_config = period & CSR_TCFG_VAL;
+	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
 	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
@@ -73,16 +75,14 @@ static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_periodic(struct clock_event_device *evt)
+static int constant_set_state_shutdown(struct clock_event_device *evt)
 {
-	unsigned long period;
 	unsigned long timer_config;
 
 	raw_spin_lock(&state_lock);
 
-	period = const_clock_freq / HZ;
-	timer_config = period & CSR_TCFG_VAL;
-	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
+	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config &= ~CSR_TCFG_EN;
 	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
@@ -90,11 +90,6 @@ static int constant_set_state_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_shutdown(struct clock_event_device *evt)
-{
-	return 0;
-}
-
 static int constant_timer_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	unsigned long timer_config;
@@ -156,7 +151,7 @@ int constant_clockevent_init(void)
 	cd->rating = 320;
 	cd->cpumask = cpumask_of(cpu);
 	cd->set_state_oneshot = constant_set_state_oneshot;
-	cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
+	cd->set_state_oneshot_stopped = constant_set_state_shutdown;
 	cd->set_state_periodic = constant_set_state_periodic;
 	cd->set_state_shutdown = constant_set_state_shutdown;
 	cd->set_next_event = constant_timer_next_event;
-- 
2.42.0


