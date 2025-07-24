Return-Path: <stable+bounces-164559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93055B0FF7B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 06:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA80172D82
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD501E9B35;
	Thu, 24 Jul 2025 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5qLtPke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC41A83F8
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753330425; cv=none; b=XqsIiUA9+RBKlSYITWA0B8Z4WXddMRZ5a9Y6/oO1nW7fqlK/BT0HHfEtiLHoDcY29kvzcMaCZ0ixILgI3lrkMh9WdL6DcL4O8noLFyPdLSPZRuISGlTza6kwiC6xEi3jLm7Jwd/Wmay5tLsnNnGB8RiEK1A7rGeTovlL+8xT1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753330425; c=relaxed/simple;
	bh=CbQ2bDDKaZOJDLOQdlF66t6IrtiCT3G/16Q+Q3l8XLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He1N19bkuZ8t8nriYqNs6YPjfCHkHOoUBiGKN40/LWuK0UBu1qbCgB4f84e+cWyHq0iLBQD5R6KtqyHjhAfj4wHCl+UpG7cW0NpNVwHZrRcR5j8ipilvukE01HqDZIWfDTUErxzvsbHzV9etrKWNNIV+FHZiWlLldhXvXjWcnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5qLtPke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D740C4CEED;
	Thu, 24 Jul 2025 04:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753330423;
	bh=CbQ2bDDKaZOJDLOQdlF66t6IrtiCT3G/16Q+Q3l8XLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5qLtPke6WrF6MwxspB4ryT2p58rizv+you2wyyiWJVWrd61PfWTAO8SVX4xt/tnO
	 Eug11EqTbXyrvmruW6Gy3VKGiC7HK4byX/QOstp/7tubtdNK0wLTZnlWRyHpADGPzF
	 k3Oy3LT6bLfSkchTTNc14D70EIvCezYCtlMkGkPVrG2YK2DP+qqGdSPjHUHdw/G9Gu
	 DksM0c17xsNavspw/AhxTlw/p59g1YRTKBhY/V62Nxj+5Qajn5oz+S+dwYwTUWeAED
	 xYNTomABMMat+d1JieGGShMVZ+MslDU0J1r8mTCRAb0Ssb2sQMtq3LBk+kMUSCvf/V
	 ssjEzRucuKJQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT
Date: Thu, 24 Jul 2025 00:13:39 -0400
Message-Id: <20250724041339.1297276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062008-carrousel-lazily-2f19@gregkh>
References: <2025062008-carrousel-lazily-2f19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

[ Upstream commit f4a8f561d08e39f7833d4a278ebfb12a41eef15f ]

When enabling PREEMPT_RT, the gpio_keys_irq_timer() callback runs in
hard irq context, but the input_event() takes a spin_lock, which isn't
allowed there as it is converted to a rt_spin_lock().

[ 4054.289999] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[ 4054.290028] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
...
[ 4054.290195]  __might_resched+0x13c/0x1f4
[ 4054.290209]  rt_spin_lock+0x54/0x11c
[ 4054.290219]  input_event+0x48/0x80
[ 4054.290230]  gpio_keys_irq_timer+0x4c/0x78
[ 4054.290243]  __hrtimer_run_queues+0x1a4/0x438
[ 4054.290257]  hrtimer_interrupt+0xe4/0x240
[ 4054.290269]  arch_timer_handler_phys+0x2c/0x44
[ 4054.290283]  handle_percpu_devid_irq+0x8c/0x14c
[ 4054.290297]  handle_irq_desc+0x40/0x58
[ 4054.290307]  generic_handle_domain_irq+0x1c/0x28
[ 4054.290316]  gic_handle_irq+0x44/0xcc

Considering the gpio_keys_irq_isr() can run in any context, e.g. it can
be threaded, it seems there's no point in requesting the timer isr to
run in hard irq context.

Relax the hrtimer not to use the hard context.

Fixes: 019002f20cb5 ("Input: gpio-keys - use hrtimer for release timer")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Link: https://lore.kernel.org/r/20250528-gpio_keys_preempt_rt-v2-1-3fc55a9c3619@foss.st.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/gpio_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 22a91db645b8f..525c311ddb181 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -493,7 +493,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 	if (bdata->release_delay)
 		hrtimer_start(&bdata->release_timer,
 			      ms_to_ktime(bdata->release_delay),
-			      HRTIMER_MODE_REL_HARD);
+			      HRTIMER_MODE_REL);
 out:
 	spin_unlock_irqrestore(&bdata->lock, flags);
 	return IRQ_HANDLED;
@@ -633,7 +633,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		bdata->release_delay = button->debounce_interval;
 		hrtimer_init(&bdata->release_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
+			     CLOCK_REALTIME, HRTIMER_MODE_REL);
 		bdata->release_timer.function = gpio_keys_irq_timer;
 
 		isr = gpio_keys_irq_isr;
-- 
2.39.5


