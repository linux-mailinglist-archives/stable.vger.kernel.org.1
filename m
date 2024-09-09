Return-Path: <stable+bounces-73971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704CF970EB7
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8211C21E7B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF6171658;
	Mon,  9 Sep 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQ4hX2F2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0F2AD00
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865242; cv=none; b=kgQNdjX2h0yWZoWA4BMWVO4iqU7pDnyNPesc8P/R5RZlVue9aajC/2hyNWMhbJxSnrb26+mc4pbLFCYY8vZEtTraoGtJbEm2VxASPjkNQarjZV4sjhyhrhtos/7cUEPoeZyiOwTJek/jvVtC62Mr5hKsIOOZQnUw4IL0mSy6uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865242; c=relaxed/simple;
	bh=bOtBNabWFstuBU96kRE3vRoe8wjQ+/Nus0/aXdjE0mw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E4u7VUJV3bHRjFiF/m8aBBfPldwtgJ48j4UkRGnZVNoI8YVkK1iZMa/0FC5rT4u40y6rNJDa2m/Ditkz1KAUuQEmpMXy0J5irsfPZ2FcThhgtopIv1pSq4/Xmp8Tf9cBxiCnflRdyn+F//HnzM/FZbZFGrHW3CHLzo0CHL8Pd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQ4hX2F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF4DC4CEC5;
	Mon,  9 Sep 2024 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725865242;
	bh=bOtBNabWFstuBU96kRE3vRoe8wjQ+/Nus0/aXdjE0mw=;
	h=Subject:To:Cc:From:Date:From;
	b=NQ4hX2F2QZzV1IOWVynjsRCo3Nn0frXp1lB3Bje/GvSPTRmMwb4tpxAARaunGPGZL
	 yPnL0kf4Pt07Cr9jHrH31T/RtRwSdPS3r/RFHv48Zuusd3yo5yZMO5iSlpbOUax0H+
	 55tbUueiv0QUC7nfC0AKh19sWFMt2hkBJm9+XBDY=
Subject: FAILED: patch "[PATCH] clocksource/drivers/timer-of: Remove percpu irq related code" failed to apply to 4.19-stable tree
To: daniel.lezcano@linaro.org,ubizjak@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 09:00:39 +0200
Message-ID: <2024090938-resale-impose-3699@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 471ef0b5a8aaca4296108e756b970acfc499ede4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090938-resale-impose-3699@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

471ef0b5a8aa ("clocksource/drivers/timer-of: Remove percpu irq related code")
0f1a7b3fac05 ("timer-of: don't use conditional expression with mixed 'void' types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 471ef0b5a8aaca4296108e756b970acfc499ede4 Mon Sep 17 00:00:00 2001
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 19 Aug 2024 12:03:35 +0200
Subject: [PATCH] clocksource/drivers/timer-of: Remove percpu irq related code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC's named address space checks errors out with:

drivers/clocksource/timer-of.c: In function ‘timer_of_irq_exit’:
drivers/clocksource/timer-of.c:29:46: error: passing argument 2 of
‘free_percpu_irq’ from pointer to non-enclosed address space
  29 |                 free_percpu_irq(of_irq->irq, clkevt);
     |                                              ^~~~~~
In file included from drivers/clocksource/timer-of.c:8:
./include/linux/interrupt.h:201:43: note: expected ‘__seg_gs void *’
but argument is of type ‘struct clock_event_device *’
 201 | extern void free_percpu_irq(unsigned int, void __percpu *);
     |                                           ^~~~~~~~~~~~~~~
drivers/clocksource/timer-of.c: In function ‘timer_of_irq_init’:
drivers/clocksource/timer-of.c:74:51: error: passing argument 4 of
‘request_percpu_irq’ from pointer to non-enclosed address space
  74 |                                    np->full_name, clkevt) :
     |                                                   ^~~~~~
./include/linux/interrupt.h:190:56: note: expected ‘__seg_gs void *’
but argument is of type ‘struct clock_event_device *’
 190 |                    const char *devname, void __percpu *percpu_dev_id)

Sparse warns about:

timer-of.c:29:46: warning: incorrect type in argument 2 (different address spaces)
timer-of.c:29:46:    expected void [noderef] __percpu *
timer-of.c:29:46:    got struct clock_event_device *clkevt
timer-of.c:74:51: warning: incorrect type in argument 4 (different address spaces)
timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
timer-of.c:74:51:    got struct clock_event_device *clkevt

It appears the code is incorrect as reported by Uros Bizjak:

"The referred code is questionable as it tries to reuse
the clkevent pointer once as percpu pointer and once as generic
pointer, which should be avoided."

This change removes the percpu related code as no drivers is using it.

[Daniel: Fixed the description]

Fixes: dc11bae785295 ("clocksource/drivers: Add timer-of common init routine")
Reported-by: Uros Bizjak <ubizjak@gmail.com>
Tested-by: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20240819100335.2394751-1-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..420202bf76e4 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -25,10 +25,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
 
 	struct clock_event_device *clkevt = &to->clkevt;
 
-	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
-	else
-		free_irq(of_irq->irq, clkevt);
+	free_irq(of_irq->irq, clkevt);
 }
 
 /**
@@ -42,9 +39,6 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  * - Get interrupt number by name
  * - Get interrupt number by index
  *
- * When the interrupt is per CPU, 'request_percpu_irq()' is called,
- * otherwise 'request_irq()' is used.
- *
  * Returns 0 on success, < 0 otherwise
  */
 static __init int timer_of_irq_init(struct device_node *np,
@@ -69,12 +63,9 @@ static __init int timer_of_irq_init(struct device_node *np,
 		return -EINVAL;
 	}
 
-	ret = of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
-		request_irq(of_irq->irq, of_irq->handler,
-			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
-			    np->full_name, clkevt);
+	ret = request_irq(of_irq->irq, of_irq->handler,
+			  of_irq->flags ? of_irq->flags : IRQF_TIMER,
+			  np->full_name, clkevt);
 	if (ret) {
 		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
 		return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..01a2c6b7db06 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -11,7 +11,6 @@
 struct of_timer_irq {
 	int irq;
 	int index;
-	int percpu;
 	const char *name;
 	unsigned long flags;
 	irq_handler_t handler;


