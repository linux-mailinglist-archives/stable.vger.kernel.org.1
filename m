Return-Path: <stable+bounces-2968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF57FC6DE
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B061C21578
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6D42A8C;
	Tue, 28 Nov 2023 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZJQ5F91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8644367;
	Tue, 28 Nov 2023 21:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C50C433CA;
	Tue, 28 Nov 2023 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205631;
	bh=WC3ZNUMc0KkG5elTrcbpJ6cdL4mgiViegpDo+7f1EXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZJQ5F91PLk6eUEWuGCwlzTMAENuJOuXGC0uW05U53XKkjO+sm23IyxEHbHp6k+Cs
	 tknxXMIXkrkHv5oHLvr+ajdz3pystdtsYbr++/EI9yb7mo0axZYoMMbFE1wmd7QGOq
	 Vr8y9K7R1rMCUjgreeV0w1GaLUuTlKiG4IxRkWFViIt1ayQK1h9HeGnw1wi8U73+1Y
	 paUPSRBPl5sVnvUZr2/3hliy1l5I5sRTTUjrxfGHbQYXhON4cjJKuHDDf/7OD7/i7q
	 tde3Y+rjpKd/14YpwNYQm+U6OBAOWIx60kVNwODj+4/tb3IPxAF6KnKxHLpsyIbtbh
	 jknyedAt8iA/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	peterz@infradead.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 22/40] LoongArch: Implement constant timer shutdown interface
Date: Tue, 28 Nov 2023 16:05:28 -0500
Message-ID: <20231128210615.875085-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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
index 3064af94db9c2..e7015f7b70e37 100644
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
@@ -161,7 +156,7 @@ int constant_clockevent_init(void)
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


