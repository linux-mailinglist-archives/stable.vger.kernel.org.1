Return-Path: <stable+bounces-120112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAAA4C771
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD483ABBD4
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D858235C00;
	Mon,  3 Mar 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPodb99P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8130236450;
	Mon,  3 Mar 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019425; cv=none; b=gk+wXGnuu6eP9kA28MKgvBjZ8opzDDYGhUWzYkXbzNLMQ4hSGxAvVCoUHwjjAk7frz+KHBaVbcPLwZN6kkzOomDCu+p5bxRTEY9t+3qhyqAifZD7pTRQD8OMRdpj2hecOh2GWPCD0Lvfax+0kf1015UoYBgsz5A+FxYMyjY4r4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019425; c=relaxed/simple;
	bh=4BV+DfAitoOFS67rXvI7/vo+K9o3Nfm2wDbXPMUtLKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU/TelNg34Hqqzo6k1gpf3EncpPgcCcZx4Zwwc67SbSM2z7V70mwpuUS5wd1cu4gGRJ+aIx6b99yIvMeBsxtqdibb3X18VLtfwrusbW3y3KeWXn2PlN6O7xLaq9zQ29xXPCIDWjjGNLF29KKJ2HvFlOuVwoEdhKiIGy0Xjgu70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPodb99P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981F5C4CEE4;
	Mon,  3 Mar 2025 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019425;
	bh=4BV+DfAitoOFS67rXvI7/vo+K9o3Nfm2wDbXPMUtLKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPodb99PkHYX9FFLRHxvqFg9XbhwLBCF6uU3Bl4gMe9h/do8tiqA8cdaBIYhmJccL
	 hrjMiAWZYcY9KAv3FVXf4qPmWzKuphRgflaOJ4m75PqFLoK+HXQB+naMXZ8DADJ038
	 zW3YKZ23INpE6meX+NxKb5waCtX0U9kAg2Th60E0JnAia+nWN8U1lT0YAYLNVNEKrY
	 EMeeURYxJtC6FGaA5jumRcHcTymgF03ezqnTMGeVwui6MmgKsnDwaWXkUiBmxUEHif
	 Fb97nc1ex9SDSyEGfjW+jXJsqScv+t+2OPdd290ys+apFAXOjZENzcAEDd8DM+AGBS
	 4EJeJcU2AQaxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Breno Leitao <leitao@debian.org>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	bigeasy@linutronix.de,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 15/17] net: Handle napi_schedule() calls from non-interrupt
Date: Mon,  3 Mar 2025 11:29:47 -0500
Message-Id: <20250303162951.3763346-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 77e45145e3039a0fb212556ab3f8c87f54771757 ]

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* From a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

Other bare tasks context may end up ignoring the raised NET_RX vector
until the next random softirq handling opportunity, which may not
happen before a while if the CPU goes idle afterwards with the tick
stopped.

Such "misuses" have been detected on several places thanks to messages
of the kind:

	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"

For example:

       __raise_softirq_irqoff
        __napi_schedule
        rtl8152_runtime_resume.isra.0
        rtl8152_resume
        usb_resume_interface.isra.0
        usb_resume_both
        __rpm_callback
        rpm_callback
        rpm_resume
        __pm_runtime_resume
        usb_autoresume_device
        usb_remote_wakeup
        hub_event
        process_one_work
        worker_thread
        kthread
        ret_from_fork
        ret_from_fork_asm

And also:

* drivers/net/usb/r8152.c::rtl_work_func_t
* drivers/net/netdevsim/netdev.c::nsim_start_xmit

There is a long history of issues of this kind:

	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	330068589389 ("idpf: disable local BH when scheduling napi for marker packets")
	e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error")
	e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx napi schedule")
	c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx napi enable/schedule")
	970be1dff26d ("mt76: disable BH around napi_schedule() calls")
	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new  function to be called from threaded interrupt")
	e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()")
	83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
	bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
	8cf699ec849f ("mlx4: do not call napi_schedule() without care")
	ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule")

This shows that relying on the caller to arrange a proper context for
the softirqs to be handled while calling napi_schedule() is very fragile
and error prone. Also fixing them can also prove challenging if the
caller may be called from different kinds of contexts.

Therefore fix this from napi_schedule() itself with waking up ksoftirqd
when softirqs are raised from task contexts.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Francois Romieu <romieu@fr.zoreil.com>
Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de/
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250223221708.27130-1-frederic@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b09714761c62..7f755270ff1ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4610,7 +4610,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	 * we have to raise NET_RX_SOFTIRQ.
 	 */
 	if (!sd->in_net_rx_action)
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
-- 
2.39.5


