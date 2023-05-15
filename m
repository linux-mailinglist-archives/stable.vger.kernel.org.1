Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F53703992
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbjEORnr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbjEORna (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA291692C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ACB862D81
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08480C433EF;
        Mon, 15 May 2023 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172151;
        bh=2qOU6uqbXmfYZm3AIRQ2JImAfz9VO9L+yhmNZ1tGyJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWUb8Lf+KcEqS/fX0Pceq4MacBGiXGqArDkm4zAua1yqNNMUPblDsDFsneauldr3l
         CqHTHp11EXin8xSwkM7eyAVQNcyuIIwriWGeeHhUTk76br+1m9ItVkxjM0Z6WVVUUi
         LeAbzFIWelhjddcNnxtKH6KFNvKXgelpbESdg/vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zqiang <qiang1.zhang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 060/381] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Mon, 15 May 2023 18:25:11 +0200
Message-Id: <20230515161739.538609887@linuxfoundation.org>
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

From: Zqiang <qiang1.zhang@intel.com>

[ Upstream commit db7b464df9d820186e98a65aa6a10f0d51fbf8ce ]

This commit adds checks for the TICK_DEP_MASK_RCU_EXP bit, thus enabling
RCU expedited grace periods to actually force-enable scheduling-clock
interrupts on holdout CPUs.

Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 19abb6c3eb73f..40e9b5a12732d 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -368,7 +368,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e4e0d032126bc..378096fc8c560 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -213,6 +213,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
-- 
2.39.2



