Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38879BABE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349133AbjIKVco (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjIKOyi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60111E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FE9C433C7;
        Mon, 11 Sep 2023 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444073;
        bh=/ve7Vj1FGlxihhcU9MJNREFRmyNfety+eiIqhN5fi3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khIQMM8JtrxiekGmSBMXAf0oRzbtu+MnFpSqh+3a/uSfluB1yXM8apTvf4jKA1bQq
         VmA2pwFBr0k5zp2e9TTCkQA7h9N+srILeFv/WPVCQAmWPHJGaRyKX63c++zbYYlArV
         l13ZWtsa7IXh9ozyvX9Q2pi6vszotWDmCmmQUanM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Wen Yang <wenyang.linux@foxmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 600/737] tick/rcu: Fix false positive "softirq work is pending" messages
Date:   Mon, 11 Sep 2023 15:47:39 +0200
Message-ID: <20230911134707.297884260@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Gortmaker <paul.gortmaker@windriver.com>

[ Upstream commit 96c1fa04f089a7e977a44e4e8fdc92e81be20bef ]

In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle") the
new function report_idle_softirq() was created by breaking code out of the
existing can_stop_idle_tick() for kernels v5.18 and newer.

In doing so, the code essentially went from a one conditional:

	if (a && b && c)
		warn();

to a three conditional:

	if (!a)
		return;
	if (!b)
		return;
	if (!c)
		return;
	warn();

But that conversion got the condition for the RT specific
local_bh_blocked() wrong. The original condition was:

   	!local_bh_blocked()

but the conversion failed to negate it so it ended up as:

        if (!local_bh_blocked())
		return false;

This issue lay dormant until another fixup for the same commit was added
in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
This commit realized the ratelimit was essentially set to zero instead
of ten, and hence *no* softirq pending messages would ever be issued.

Once this commit was backported via linux-stable, both the v6.1 and v6.4
preempt-rt kernels started printing out 10 instances of this at boot:

  NOHZ tick-stop error: local softirq work is pending, handler #80!!!

Remove the negation and return when local_bh_blocked() evaluates to true to
bring the correct behaviour back.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Wen Yang <wenyang.linux@foxmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230818200757.1808398-1-paul.gortmaker@windriver.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4df14db4da490..87015e9deacc9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1045,7 +1045,7 @@ static bool report_idle_softirq(void)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-	if (!local_bh_blocked())
+	if (local_bh_blocked())
 		return false;
 
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
-- 
2.40.1



