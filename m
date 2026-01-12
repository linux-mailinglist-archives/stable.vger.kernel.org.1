Return-Path: <stable+bounces-208082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54AD11EDE
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF79301595C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50830F801;
	Mon, 12 Jan 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lwk6gGTO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2E2BEC34
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214147; cv=none; b=Y6Z3u8HL0OoJ5bImXz1EWZrd9pZvsASP22LB+R2tn3z5m4yRINeyPw6fiZnk2ooaPdmL32wGH9/0mBlYgGn8DoBzb7OB8WlONnIt9Ml8BwRbb47Ck1APNE6xF7HjatyPozf8jagNC8T/HK7cduk2YPek8Nv9ZGMdo4vZRI/NAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214147; c=relaxed/simple;
	bh=7Lrh1AjnERzTbFjE00ygtkj2sFVSWuuHlc5qsouQs98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c62IEtXxYp/zYw9pihWXB/6ry8mUBrs5l10YxijmgOxEBOTEPveTD8iOWnA5l3aTPeHwaN4dTQDFmqbFR2wXHy8PX/09sf7vkhoxB0zbx/oX29X6CirSEKoq3FEOe0OZ4/NECw4XcGjrElbt8v3sZ1uvgfFfnu+xvg9WyVK+PnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lwk6gGTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D25C16AAE;
	Mon, 12 Jan 2026 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214147;
	bh=7Lrh1AjnERzTbFjE00ygtkj2sFVSWuuHlc5qsouQs98=;
	h=Subject:To:Cc:From:Date:From;
	b=Lwk6gGTOdr48xljgaFpgeR4H9wiXE3vrKz+mUcXLh55Pvpaw4SMIbwYB1VMyEeNVF
	 GpfyrjIn5tAwnonISwi5+jwvg8obt1klLcyNY8su2Bjet01UktGx0a+dpQYvQabyjd
	 mDHsiwCEbF0dSs0giMCjpf4SnHQVD1kqIjLvUx6A=
Subject: FAILED: patch "[PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag" failed to apply to 5.15-stable tree
To: alexander.sverdlin@gmail.com,alexander.sverdlin@siemens.com,bigeasy@linutronix.de,o.rempel@pengutronix.de,wbg@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:35:44 +0100
Message-ID: <2026011244-unbaked-pajamas-9c74@gregkh>
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
git cherry-pick -x 23f9485510c338476b9735d516c1d4aacb810d46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011244-unbaked-pajamas-9c74@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23f9485510c338476b9735d516c1d4aacb810d46 Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Tue, 18 Nov 2025 09:35:48 +0100
Subject: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

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

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 6c0c1d2d7027..e6100b5fb082 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -229,8 +229,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
-			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-			       dev_name(dev), counter);
+			       IRQF_TRIGGER_RISING, dev_name(dev), counter);
 	if (ret)
 		return ret;
 


