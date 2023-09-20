Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A77A7C21
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjITL6T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjITL6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:58:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C56B6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:58:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9D8C433C8;
        Wed, 20 Sep 2023 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211092;
        bh=sI4sKj3VTWsXHpKOFeBHh16lQ4ASbjPx1cZCFRVi2TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08HYxHQZAHYAFnCCCDaNEmqhXf6tSWGNOlKyD/3ZZbdxaybjJEkKPPvRPyHDJ7Uh2
         TD7wovv76tXyQ6ERKM+6bo1SPMyxUwji6stj/6K1Lj3S5FwPzbPAiZBnunAPflZq3T
         K7VmBss4df41qXSFlrcoISAurSWDPRnt62lChngQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/139] panic: Reenable preemption in WARN slowpath
Date:   Wed, 20 Sep 2023 13:30:38 +0200
Message-ID: <20230920112839.443577444@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit cccd32816506cbac3a4c65d9dff51b3125ef1a03 ]

Commit:

  5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")

amended warn_slowpath_fmt() to disable preemption until the WARN splat
has been emitted.

However the commit neglected to reenable preemption in the !fmt codepath,
i.e. when a WARN splat is emitted without additional format string.

One consequence is that users may see more splats than intended.  E.g. a
WARN splat emitted in a work item results in at least two extra splats:

  BUG: workqueue leaked lock or atomic
  (emitted by process_one_work())

  BUG: scheduling while atomic
  (emitted by worker_thread() -> schedule())

Ironically the point of the commit was to *avoid* extra splats. ;)

Fix it.

Fixes: 5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ca5452afb456d..63e94f3bd8dcd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -695,6 +695,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
+		warn_rcu_exit(rcu);
 		return;
 	}
 
-- 
2.40.1



