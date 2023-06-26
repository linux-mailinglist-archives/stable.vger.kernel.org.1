Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B173E970
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjFZSgE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjFZSgD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF999
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB20C60F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F5C433C9;
        Mon, 26 Jun 2023 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804561;
        bh=xNQ54ytPvumoCeiLgJc7OnP+1PsgOlLIuIcEDfadQF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hUw8/aU5C8HQPPDiw9l9TqK+KLof9PNTmDX1uQkk17euvMPIhhqyWDPGsWAXfeQC
         Mk01Thmu3XLXD9wChlhtmAlcah+x96UA3E4A4NgxuCChlDjVrCZCi0MoIw9FrSxH5J
         JRyx4WpTyFSAv0BAOT4OGZPIefF3uwEINMsI5KcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mathias Krause <minipli@grsecurity.net>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Richard W.M. Jones" <rjones@redhat.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 5.4 07/60] tick/common: Align tick period during sched_timer setup
Date:   Mon, 26 Jun 2023 20:11:46 +0200
Message-ID: <20230626180739.855278973@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 13bb06f8dd42071cb9a49f6e21099eea05d4b856 upstream.

The tick period is aligned very early while the first clock_event_device is
registered. At that point the system runs in periodic mode and switches
later to one-shot mode if possible.

The next wake-up event is programmed based on the aligned value
(tick_next_period) but the delta value, that is used to program the
clock_event_device, is computed based on ktime_get().

With the subtracted offset, the device fires earlier than the exact time
frame. With a large enough offset the system programs the timer for the
next wake-up and the remaining time left is too small to make any boot
progress. The system hangs.

Move the alignment later to the setup of tick_sched timer. At this point
the system switches to oneshot mode and a high resolution clocksource is
available. At this point it is safe to align tick_next_period because
ktime_get() will now return accurate (not jiffies based) time.

[bigeasy: Patch description + testing].

Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
Reported-by: Mathias Krause <minipli@grsecurity.net>
Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
Suggested-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Acked-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com
Link: https://lore.kernel.org/r/20230615091830.RxMV2xf_@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-common.c |   13 +------------
 kernel/time/tick-sched.c  |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -216,19 +216,8 @@ static void tick_setup_device(struct tic
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu = cpu;
-
-			next_p = ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -= rem;
-				next_p += TICK_NSEC;
-			}
-
-			tick_next_period = next_p;
+			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -129,8 +129,19 @@ static ktime_t tick_init_jiffy_update(vo
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update == 0)
+	if (last_jiffies_update == 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period += TICK_NSEC - rem;
+
 		last_jiffies_update = tick_next_period;
+	}
 	period = last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);


