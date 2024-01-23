Return-Path: <stable+bounces-14640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA318381F8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A0A28A27F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958056468;
	Tue, 23 Jan 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DromsfFc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E114E1D2;
	Tue, 23 Jan 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974021; cv=none; b=YO1qRbAcyOavu5O51Oo0Y28TFI+LZ3P/kSYZ3RVK+zIszlH0YgnADgbW+fNUXIVxmVTzCMvXfwja0qNuGfCaryPXzuX0xs+TytlXBaSa3GryZUU2oHWIaAFxjPnLkZsMZnFhY9XiIpiubzwRKgljGCuwKo04/Dq57+Wy26gIVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974021; c=relaxed/simple;
	bh=hhGZqW6P78V3edxME/Kj8zpRZDXQIPxTIg7ZTCwlEhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlxlPISq3Vx6mx3yaIddtaWBFdDd8Ia9LBGVDB1KGDuPzlKSsLjUQ63GIiYkvRB3cm1/sFl5ngtTdMI2yAnIAuy+MTKjXbIeQzj8FLkoVSCwiP1U1Os8GKJLB0BTXwcjm3aDZ7b+n4deeGJUIqF+BEkEe01vgz6W8n9PEgVbbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DromsfFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05A8C433C7;
	Tue, 23 Jan 2024 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974020;
	bh=hhGZqW6P78V3edxME/Kj8zpRZDXQIPxTIg7ZTCwlEhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DromsfFcufH6X80DPuIIiYTWvMTW5JPvrtChfYD1h0GW1r1pNvnU1ZljZTtp5oTIr
	 fVK35C1HeTyXNX2fbxvyBI3mQrNUXLQXTZq+lkzY3n6WhbJHtvKjatbqLfAzbNmiPv
	 LdN+OBMsc+DagGzRGHJtJkUJTzBEHnBTeJqDbDEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 005/583] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
Date: Mon, 22 Jan 2024 15:50:56 -0800
Message-ID: <20240122235812.400556155@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit edc8fc01f608108b0b7580cb2c29dfb5135e5f0e ]

intel_idle_irq() re-enables IRQs very early. As a result, an interrupt
may fire before mwait() is eventually called. If such an interrupt queues
a timer, it may go unnoticed until mwait returns and the idle loop
handles the tick re-evaluation. And monitoring TIF_NEED_RESCHED doesn't
help because a local timer enqueue doesn't set that flag.

The issue is mitigated by the fact that this idle handler is only invoked
for shallow C-states when, presumably, the next tick is supposed to be
close enough. There may still be rare cases though when the next tick
is far away and the selected C-state is shallow, resulting in a timer
getting ignored for a while.

Fix this with using sti_mwait() whose IRQ-reenablement only triggers
upon calling mwait(), dealing with the race while keeping the interrupt
latency within acceptable bounds.

Fixes: c227233ad64c (intel_idle: enable interrupts before C1 on Xeons)
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lkml.kernel.org/r/20231115151325.6262-3-frederic@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/mwait.h | 11 +++++++++--
 drivers/idle/intel_idle.c    | 19 +++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..bae83810505b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -115,8 +115,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
-			__mwait(eax, ecx);
+
+		if (!need_resched()) {
+			if (ecx & 1) {
+				__mwait(eax, ecx);
+			} else {
+				__sti_mwait(eax, ecx);
+				raw_local_irq_disable();
+			}
+		}
 	}
 	current_clr_polling();
 }
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ea5a6a14c553..45500d2d5b4b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -131,11 +131,12 @@ static unsigned int mwait_substates __initdata;
 #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
 
 static __always_inline int __intel_idle(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index)
+					struct cpuidle_driver *drv,
+					int index, bool irqoff)
 {
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
-	unsigned long ecx = 1; /* break on interrupt flag */
+	unsigned long ecx = 1*irqoff; /* break on interrupt flag */
 
 	mwait_idle_with_hints(eax, ecx);
 
@@ -159,19 +160,13 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
 static __cpuidle int intel_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index)
 {
-	return __intel_idle(dev, drv, index);
+	return __intel_idle(dev, drv, index, true);
 }
 
 static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv, int index)
 {
-	int ret;
-
-	raw_local_irq_enable();
-	ret = __intel_idle(dev, drv, index);
-	raw_local_irq_disable();
-
-	return ret;
+	return __intel_idle(dev, drv, index, false);
 }
 
 static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
@@ -184,7 +179,7 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	if (smt_active)
 		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
-	ret = __intel_idle(dev, drv, index);
+	ret = __intel_idle(dev, drv, index, true);
 
 	if (smt_active)
 		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
@@ -196,7 +191,7 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
 				       struct cpuidle_driver *drv, int index)
 {
 	fpu_idle_fpregs();
-	return __intel_idle(dev, drv, index);
+	return __intel_idle(dev, drv, index, true);
 }
 
 /**
-- 
2.43.0




