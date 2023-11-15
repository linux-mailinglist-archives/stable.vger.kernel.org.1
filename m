Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147B7ED6BB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjKOWDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjKOWDL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A311A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C5C433C7;
        Wed, 15 Nov 2023 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085787;
        bh=k9CQFcI8kcrniqo5/rDbHLJ0t2pNsD41OyW3+JH/kiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zlUVS2e4hzDbjuP9tCXzHY+9JywTpskl/8fXrECTVG4/WmhwhzhctMun/qB3gz4V
         ZKXkXlDjbUzMg50wHGDj9bDkFxmTl+a1eGIH3OwEiGz/hiwucZ1Bq6hoDpVo0w7Qb7
         TH02q0zuGUPTl/bUYJyJDR085sMVsugt+8Jkcxkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 053/119] sched/rt: Provide migrate_disable/enable() inlines
Date:   Wed, 15 Nov 2023 17:00:43 -0500
Message-ID: <20231115220134.274562896@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 66630058e56b26b3a9cf2625e250a8c592dd0207 ]

Code which solely needs to prevent migration of a task uses
preempt_disable()/enable() pairs. This is the only reliable way to do so
as setting the task affinity to a single CPU can be undone by a
setaffinity operation from a different task/process.

RT provides a seperate migrate_disable/enable() mechanism which does not
disable preemption to achieve the semantic requirements of a (almost) fully
preemptible kernel.

As it is unclear from looking at a given code path whether the intention is
to disable preemption or migration, introduce migrate_disable/enable()
inline functions which can be used to annotate code which merely needs to
disable migration. Map them to preempt_disable/enable() for now. The RT
substitution will be provided later.

Code which is annotated that way documents that it has no requirement to
protect against reentrancy of a preempting task. Either this is not
required at all or the call sites are already serialized by other means.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/878slclv1u.fsf@nanos.tec.linutronix.de
Stable-dep-of: 36c75ce3bd29 ("nd_btt: Make BTT lanes preemptible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/preempt.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bbb68dba37cc8..bc3f1aecaa194 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,4 +322,34 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration,
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+static __always_inline void migrate_disable(void)
+{
+	preempt_disable();
+}
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested, only the outermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+static __always_inline void migrate_enable(void)
+{
+	preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
-- 
2.42.0



