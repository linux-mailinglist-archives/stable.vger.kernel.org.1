Return-Path: <stable+bounces-154992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9C0AE15FF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12CB4A56BB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFA2367C3;
	Fri, 20 Jun 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pd87NPz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B721FF31
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408104; cv=none; b=nJtJeClBGdsIPlnFwyPvZHkw4n8/8VO8qQnmMHi1IjiCnPP/ArXUFeCvHICQB+zaV6Y5PBq3Fw6n6q6xfgA8goqVccgj45d0ALaHmf/lcbfbBVR9Zd6HyzrALa3+ZOPpPjrg0/g9wO2EA861/4UTOBpGrTZjwFm+QQ+pDNn1lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408104; c=relaxed/simple;
	bh=ihLMiFFvaCyTZardSn3eKhe3/JpFDY//rDoGR3cFvwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k2/zmJwS+eSTRprTCJvfm1o9D80jnO6Qak6zmcZm16k7kImoLSibWRXMzH1P7pJ+guFcye+jp3IvcLbx3Ly8CDx2US0St/b/2bGQmUPcfDtqR7koe+WGQwugasrvcIXRbZKXHgtgtDCLXlNHzY3dr5sVAISznf6yAlVGKyahXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pd87NPz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99266C4CEE3;
	Fri, 20 Jun 2025 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408104;
	bh=ihLMiFFvaCyTZardSn3eKhe3/JpFDY//rDoGR3cFvwI=;
	h=Subject:To:Cc:From:Date:From;
	b=Pd87NPz+hDlvFrYETkOb1XmxgBwDuxIy7qh6bqCxXpAdFpgjmbUPMLEca8mhNkWBG
	 SDNo4bIqKHEHEu+7TlnABhAzLl+DwoqMKdZvdkWyUOqicQV6Sqv6hVQbCQiIaHJiXH
	 LrmbyGH7C09+lU+OQw8JGZWON//icy0aoel8NcGs=
Subject: FAILED: patch "[PATCH] Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT" failed to apply to 5.15-stable tree
To: fabrice.gasnier@foss.st.com,bigeasy@linutronix.de,dmitry.torokhov@gmail.com,gatien.chevallier@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:28:08 +0200
Message-ID: <2025062008-carrousel-lazily-2f19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f4a8f561d08e39f7833d4a278ebfb12a41eef15f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062008-carrousel-lazily-2f19@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4a8f561d08e39f7833d4a278ebfb12a41eef15f Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 30 May 2025 15:36:43 -0700
Subject: [PATCH] Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

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

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5c39a217b94c..d884538107c9 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -486,7 +486,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 	if (bdata->release_delay)
 		hrtimer_start(&bdata->release_timer,
 			      ms_to_ktime(bdata->release_delay),
-			      HRTIMER_MODE_REL_HARD);
+			      HRTIMER_MODE_REL);
 out:
 	return IRQ_HANDLED;
 }
@@ -628,7 +628,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		bdata->release_delay = button->debounce_interval;
 		hrtimer_setup(&bdata->release_timer, gpio_keys_irq_timer,
-			      CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
+			      CLOCK_REALTIME, HRTIMER_MODE_REL);
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;


