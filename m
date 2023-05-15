Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2967F703B1B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbjEOR7U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbjEOR67 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BB1A3BC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1202D62FD9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06606C433D2;
        Mon, 15 May 2023 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173388;
        bh=mfpvP2kMpjsqrnywGnQtk/T1Asy2JIxAwVXTDRWh6LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXyWmAaicoxKG1qNeEyVZYzMlRXXeYRl49JYGbicQpILEQFxRAAVesgWH3dXIPEGA
         /r/AF0zob5Q/DA3nqndQ6857mIjQc8ZVa74N2twXuL69ZzUdhMsEDMVOnRPce8Alza
         PlvH7+WJEZZ1EKRg/Y99Ifgus+6ZL1dGduanhBVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 071/282] tick/sched: Optimize tick_do_update_jiffies64() further
Date:   Mon, 15 May 2023 18:27:29 +0200
Message-Id: <20230515161724.361704409@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 7a35bf2a6a871cd0252cd371d741e7d070b53af9 ]

Now that it's clear that there is always one tick to account, simplify the
calculations some more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.565663056@linutronix.de
Stable-dep-of: e9523a0d8189 ("tick/common: Align tick period with the HZ tick.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index eaeeb4bb1f8ab..3b00167656d78 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -53,7 +53,7 @@ static ktime_t last_jiffies_update;
  */
 static void tick_do_update_jiffies64(ktime_t now)
 {
-	unsigned long ticks = 0;
+	unsigned long ticks = 1;
 	ktime_t delta;
 
 	/*
@@ -91,20 +91,21 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	write_seqcount_begin(&jiffies_seq);
 
-	last_jiffies_update = ktime_add(last_jiffies_update, tick_period);
-
 	delta = ktime_sub(now, tick_next_period);
 	if (unlikely(delta >= tick_period)) {
 		/* Slow path for long idle sleep times */
 		s64 incr = ktime_to_ns(tick_period);
 
-		ticks = ktime_divns(delta, incr);
+		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
+	} else {
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 	}
 
-	do_timer(++ticks);
+	do_timer(ticks);
 
 	/*
 	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
-- 
2.39.2



