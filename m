Return-Path: <stable+bounces-208185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31DD145ED
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD8A30341CE
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C502FD689;
	Mon, 12 Jan 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izfanSSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0E37BE84
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238787; cv=none; b=fQ/BbLm5gC3xljwdIyOIK15XZD9MWESEe7/KnAfXqm/bcyBy0a64vuQkc54JND4GzFCc4LxG8ZAVFuxNrB5eCpYE8maRarVgapXjjdd5B3Vx118Vkjti9vYslkn/IDXRpuzK0qyfQ33W4mK6IszEqT/Ls5EDdCM3ZY0Ci5/GEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238787; c=relaxed/simple;
	bh=ddONS9IoHJJtKlcNp2vMisZsMh5tzNM0h0tOQUdNNsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAwuy1ekJo0WACqlne141bpBpJ80nWZxfBSasToB3SkwkN2EBp/tHwLM90DOAvoEEawOu3qJ8ybxw47ckmmeoja9fgVx+2+6ILH3bkFepLV9P7DT7JLZPpFNbvHBl4dEMSFFA4TibISixrZODD9hMW9K6ULljhNEruJ2AQds/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izfanSSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104DEC16AAE;
	Mon, 12 Jan 2026 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768238786;
	bh=ddONS9IoHJJtKlcNp2vMisZsMh5tzNM0h0tOQUdNNsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izfanSSxL1aEYpowV4FDX8RVtQGxu4ZvxEdqszKuRIzauOrUWslqalQIf2PM72LSV
	 c3lx1fYlJUtNP64WIdCLGYC28XgDzbSz8p3JNWNLbmUEJ9DxCR3u0SjxnvQT/gjILZ
	 OuKzt4SC/wOa5gzi66GiNYQGU1MujI3c7Tuj+zoG/uWj6OFhQiovpKgZPZ7N8LykDS
	 3CVESjxPGQXCc30eknOz72yLcL/MzRwBSdx1lH2qwHwtrbNqw55wuGAyTseFRdm/xP
	 1+a25cpite2vPJyJvBbQRiKhnesGYMs/guWpVLvF29cFMXOeXFPNB9ilpZB1yRu5++
	 xHaRxrdhmqNsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	William Breathitt Gray <wbg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Date: Mon, 12 Jan 2026 12:26:24 -0500
Message-ID: <20260112172624.816367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011244-unbaked-pajamas-9c74@gregkh>
References: <2026011244-unbaked-pajamas-9c74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 23f9485510c338476b9735d516c1d4aacb810d46 ]

An IRQ handler can either be IRQF_NO_THREAD or acquire spinlock_t, as
CONFIG_PROVE_RAW_LOCK_NESTING warns:
=============================
[ BUG: Invalid wait context ]
6.18.0-rc1+git... #1
-----------------------------
some-user-space-process/1251 is trying to lock:
(&counter->events_list_lock){....}-{3:3}, at: counter_push_event [counter]
other info that might help us debug this:
context-{2:2}
no locks held by some-user-space-process/....
stack backtrace:
CPU: 0 UID: 0 PID: 1251 Comm: some-user-space-process 6.18.0-rc1+git... #1 PREEMPT
Call trace:
 show_stack (C)
 dump_stack_lvl
 dump_stack
 __lock_acquire
 lock_acquire
 _raw_spin_lock_irqsave
 counter_push_event [counter]
 interrupt_cnt_isr [interrupt_cnt]
 __handle_irq_event_percpu
 handle_irq_event
 handle_simple_irq
 handle_irq_desc
 generic_handle_domain_irq
 gpio_irq_handler
 handle_irq_desc
 generic_handle_domain_irq
 gic_handle_irq
 call_on_irq_stack
 do_interrupt_handler
 el0_interrupt
 __el0_irq_handler_common
 el0t_64_irq_handler
 el0t_64_irq

... and Sebastian correctly points out. Remove IRQF_NO_THREAD as an
alternative to switching to raw_spinlock_t, because the latter would limit
all potential nested locks to raw_spinlock_t only.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20251117151314.xwLAZrWY@linutronix.de/
Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20251118083603.778626-1-alexander.sverdlin@siemens.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/counter/interrupt-cnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 8514a87fcbee0..0492fce974e1b 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -208,8 +208,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
-			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-			       dev_name(dev), priv);
+			       IRQF_TRIGGER_RISING, dev_name(dev), priv);
 	if (ret)
 		return ret;
 
-- 
2.51.0


