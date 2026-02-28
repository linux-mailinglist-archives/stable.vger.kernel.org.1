Return-Path: <stable+bounces-220182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF7aIBguo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 947831C561C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B733307D716
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF44BCAB2;
	Sat, 28 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emF7yaKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8B4BCAAB;
	Sat, 28 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300089; cv=none; b=MOlaPd0vf1IGmOHW2oHkS2g3N08Cl/HvulKf6ai0sOV231XSvx6usLBd30p651EBnk0XBABkptAWkJRMns9bwTW3Ib6NEt2gJep/b7D/wx8VGRhzusUokkQgT9efsTFrf8AB8KO5sReq5Lcn3xp2NpYKZO6Xc5ObDGy1nXWX1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300089; c=relaxed/simple;
	bh=ekwY7CiqwLp2u9VBMcGssaKBwBUJCQ7Kk2xOjUl9ol8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPIAk0+sWT8tf+bUT7A037U/LrLXR6TxJ+kshRq6aooBmRaC6ezLi249BPskzpn4imTdvN3l7NCMwPM2bYiDeDSotxHoSw9z+RtipZGpu4HrdX/pukamQoeKDCtf2tFPZ/elIJnimDH/YmPAVp2vnpBT+ZGnI4Xq+VXYCLDpY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emF7yaKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80CDC19424;
	Sat, 28 Feb 2026 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300089;
	bh=ekwY7CiqwLp2u9VBMcGssaKBwBUJCQ7Kk2xOjUl9ol8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emF7yaKelSf9jCNN7JPz9iosWL/ieNd+hlXRAMn0huFbFCOfNbSP9bax+8Dw1nZ1k
	 3urNAdQLYKUldZuxUZFtHszXnu1/4OEdpwqOp+MgOIoCRQt99FqKJgItpUtrcj2z+U
	 Bu2e1ck3GdOCIX4VqShFgnTeIRlH99NQrlpCP53h7oDkQutNu/A3XkFsuS4QzSoNB0
	 ov0e3RIAYm63AJjFAvzBUiDW6rslSjSgkh2R3Z1q6KxWIsigDEb0Jyx0iHH+Gxvmf8
	 MMBvmTncxr/v3mSjjq6URHMua54C7CGo7HEFhhNDhfmFuiy2i6tocvB/l6sP+22hCI
	 E4ggyCl+loryw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 104/844] clocksource/drivers/sh_tmu: Always leave device running after probe
Date: Sat, 28 Feb 2026 12:20:17 -0500
Message-ID: <20260228173244.1509663-105-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,linaro.org:email,ragnatech.se:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 947831C561C
X-Rspamd-Action: no action

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit b1278972b08e480990e2789bdc6a7c918bc349be ]

The TMU device can be used as both a clocksource and a clockevent
provider. The driver tries to be smart and power itself on and off, as
well as enabling and disabling its clock when it's not in operation.
This behavior is slightly altered if the TMU is used as an early
platform device in which case the device is left powered on after probe,
but the clock is still enabled and disabled at runtime.

This has worked for a long time, but recent improvements in PREEMPT_RT
and PROVE_LOCKING have highlighted an issue. As the TMU registers itself
as a clockevent provider, clockevents_register_device(), it needs to use
raw spinlocks internally as this is the context of which the clockevent
framework interacts with the TMU driver. However in the context of
holding a raw spinlock the TMU driver can't really manage its power
state or clock with calls to pm_runtime_*() and clk_*() as these calls
end up in other platform drivers using regular spinlocks to control
power and clocks.

This mix of spinlock contexts trips a lockdep warning.

    =============================
    [ BUG: Invalid wait context ]
    6.18.0-arm64-renesas-09926-gee959e7c5e34 #1 Not tainted
    -----------------------------
    swapper/0/0 is trying to lock:
    ffff000008c9e180 (&dev->power.lock){-...}-{3:3}, at: __pm_runtime_resume+0x38/0x88
    other info that might help us debug this:
    context-{5:5}
    1 lock held by swapper/0/0:
    ccree e6601000.crypto: ARM CryptoCell 630P Driver: HW version 0xAF400001/0xDCC63000, Driver version 5.0
     #0: ffff8000817ec298
    ccree e6601000.crypto: ARM ccree device initialized
     (tick_broadcast_lock){-...}-{2:2}, at: __tick_broadcast_oneshot_control+0xa4/0x3a8
    stack backtrace:
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-arm64-renesas-09926-gee959e7c5e34 #1 PREEMPT
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    Call trace:
     show_stack+0x14/0x1c (C)
     dump_stack_lvl+0x6c/0x90
     dump_stack+0x14/0x1c
     __lock_acquire+0x904/0x1584
     lock_acquire+0x220/0x34c
     _raw_spin_lock_irqsave+0x58/0x80
     __pm_runtime_resume+0x38/0x88
     sh_tmu_clock_event_set_oneshot+0x84/0xd4
     clockevents_switch_state+0xfc/0x13c
     tick_broadcast_set_event+0x30/0xa4
     __tick_broadcast_oneshot_control+0x1e0/0x3a8
     tick_broadcast_oneshot_control+0x30/0x40
     cpuidle_enter_state+0x40c/0x680
     cpuidle_enter+0x30/0x40
     do_idle+0x1f4/0x280
     cpu_startup_entry+0x34/0x40
     kernel_init+0x0/0x130
     do_one_initcall+0x0/0x230
     __primary_switched+0x88/0x90

For non-PREEMPT_RT builds this is not really an issue, but for
PREEMPT_RT builds where normal spinlocks can sleep this might be an
issue. Be cautious and always leave the power and clock running after
probe.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251202221341.1856773-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/sh_tmu.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index beffff81c00f3..3fc6ed9b56300 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -143,16 +143,6 @@ static void sh_tmu_start_stop_ch(struct sh_tmu_channel *ch, int start)
 
 static int __sh_tmu_enable(struct sh_tmu_channel *ch)
 {
-	int ret;
-
-	/* enable clock */
-	ret = clk_enable(ch->tmu->clk);
-	if (ret) {
-		dev_err(&ch->tmu->pdev->dev, "ch%u: cannot enable clock\n",
-			ch->index);
-		return ret;
-	}
-
 	/* make sure channel is disabled */
 	sh_tmu_start_stop_ch(ch, 0);
 
@@ -174,7 +164,6 @@ static int sh_tmu_enable(struct sh_tmu_channel *ch)
 	if (ch->enable_count++ > 0)
 		return 0;
 
-	pm_runtime_get_sync(&ch->tmu->pdev->dev);
 	dev_pm_syscore_device(&ch->tmu->pdev->dev, true);
 
 	return __sh_tmu_enable(ch);
@@ -187,9 +176,6 @@ static void __sh_tmu_disable(struct sh_tmu_channel *ch)
 
 	/* disable interrupts in TMU block */
 	sh_tmu_write(ch, TCR, TCR_TPSC_CLK4);
-
-	/* stop clock */
-	clk_disable(ch->tmu->clk);
 }
 
 static void sh_tmu_disable(struct sh_tmu_channel *ch)
@@ -203,7 +189,6 @@ static void sh_tmu_disable(struct sh_tmu_channel *ch)
 	__sh_tmu_disable(ch);
 
 	dev_pm_syscore_device(&ch->tmu->pdev->dev, false);
-	pm_runtime_put(&ch->tmu->pdev->dev);
 }
 
 static void sh_tmu_set_next(struct sh_tmu_channel *ch, unsigned long delta,
@@ -552,7 +537,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		goto err_clk_unprepare;
 
 	tmu->rate = clk_get_rate(tmu->clk) / 4;
-	clk_disable(tmu->clk);
 
 	/* Map the memory resource. */
 	ret = sh_tmu_map_memory(tmu);
@@ -626,8 +610,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
  out:
 	if (tmu->has_clockevent || tmu->has_clocksource)
 		pm_runtime_irq_safe(&pdev->dev);
-	else
-		pm_runtime_idle(&pdev->dev);
 
 	return 0;
 }
-- 
2.51.0


