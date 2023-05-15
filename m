Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56349703999
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbjEORoI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244360AbjEORnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FF176CF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C944562E4A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF01C433D2;
        Mon, 15 May 2023 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172482;
        bh=JIbDUYnII4i271qjKieXGt2Oy4nzk7VKyLk58eaihxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddvd7lvGTfE5mSxqZvDNKBydCuPGLw+qoMuz866oAyp410DPVQz/OXlSMihyTGTyq
         7rBKuBqlHhE1vSSDvNzOloYrMcykZpqyRKMexnCiEX8cYhQMWiiEcc4PJKozX3iNc7
         7O/IU1nWAlXZr7nlbVMoWCwHJygf8+Wi4CxTJ4bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gusenleitner Klaus <gus@keba.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 129/381] tick/common: Align tick period with the HZ tick.
Date:   Mon, 15 May 2023 18:26:20 +0200
Message-Id: <20230515161742.654722493@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit e9523a0d81899361214d118ad60ef76f0e92f71d ]

With HIGHRES enabled tick_sched_timer() is programmed every jiffy to
expire the timer_list timers. This timer is programmed accurate in
respect to CLOCK_MONOTONIC so that 0 seconds and nanoseconds is the
first tick and the next one is 1000/CONFIG_HZ ms later. For HZ=250 it is
every 4 ms and so based on the current time the next tick can be
computed.

This accuracy broke since the commit mentioned below because the jiffy
based clocksource is initialized with higher accuracy in
read_persistent_wall_and_boot_offset(). This higher accuracy is
inherited during the setup in tick_setup_device(). The timer still fires
every 4ms with HZ=250 but timer is no longer aligned with
CLOCK_MONOTONIC with 0 as it origin but has an offset in the us/ns part
of the timestamp. The offset differs with every boot and makes it
impossible for user land to align with the tick.

Align the tick period with CLOCK_MONOTONIC ensuring that it is always a
multiple of 1000/CONFIG_HZ ms.

Fixes: 857baa87b6422 ("sched/clock: Enable sched clock early")
Reported-by: Gusenleitner Klaus <gus@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20230406095735.0_14edn3@linutronix.de
Link: https://lore.kernel.org/r/20230418122639.ikgfvu3f@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 92bf99d558b48..2b7448ae5b478 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -216,9 +216,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu = cpu;
 
-			tick_next_period = ktime_get();
+			next_p = ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -= rem;
+				next_p += TICK_NSEC;
+			}
+
+			tick_next_period = next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
-- 
2.39.2



