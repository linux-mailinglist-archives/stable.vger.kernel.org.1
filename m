Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408DE78F255
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjHaSPI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHaSPI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:15:08 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965CE5F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693505705; x=1725041705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4zo7WlATPmF2xv4WwQ/GIBHRA/GDsEb8ZgV9gSwdMU=;
  b=cAsMFFsaEcTJKSYU2tfpYaaiYRXFuC4YDpTu+Pwpkyha2rSMvAu2+ASG
   LcQ/jEcw+eknL4ToIYzb4lH7oI/VKQbySCu3EAdQOAsDwDceDXWBHMIjT
   kg4KmyLVoyhZhynMYXSqMtUf4rmg6dJnXFHT+2GoSSeyDotAmw2whvK5+
   Y=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="236460687"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:15:01 +0000
Received: from EX19MTAUEC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 9F98E40D56;
        Thu, 31 Aug 2023 18:14:59 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:49 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:48 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>, Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 4/5] cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset are updated
Date:   Thu, 31 Aug 2023 18:13:05 +0000
Message-ID: <9afa96de065eb71f21cc93739e8419cc0bebe80e.1693505570.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693505570.git.luizcap@amazon.com>
References: <cover.1693505570.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Commit 6667439f51c446fead5d991ff49b842a811a6195 upstream.

Similar to commit 3fb906e7fabb ("group/cpuset: Don't filter offline
CPUs in cpuset_cpus_allowed() for top cpuset tasks"), the whole set of
possible CPUs including offline ones should be used for setting cpumasks
for tasks in the top cpuset when a cpuset partition is modified as the
hotplug code won't update cpumasks for tasks in the top cpuset when
CPUs become online or offline.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 kernel/cgroup/cpuset.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8664b9c1edc8..91c4256a3da4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1209,7 +1209,9 @@ void rebuild_sched_domains(void)
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
  * effective cpuset's.  As this function is called with cpuset_rwsem held,
- * cpuset membership stays stable.
+ * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
+ * is used instead of effective_cpus to make sure all offline CPUs are also
+ * included as hotplug code won't update cpumasks for tasks in top_cpuset.
  */
 static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
@@ -1219,15 +1221,18 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
-		/*
-		 * Percpu kthreads in top_cpuset are ignored
-		 */
-		if (top_cs && (task->flags & PF_KTHREAD) &&
-		    kthread_is_per_cpu(task))
-			continue;
+		const struct cpumask *possible_mask = task_cpu_possible_mask(task);
 
-		cpumask_and(new_cpus, cs->effective_cpus,
-			    task_cpu_possible_mask(task));
+		if (top_cs) {
+			/*
+			 * Percpu kthreads in top_cpuset are ignored
+			 */
+			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
+				continue;
+			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
+		} else {
+			cpumask_and(new_cpus, possible_mask, cs->effective_cpus);
+		}
 		set_cpus_allowed_ptr(task, new_cpus);
 	}
 	css_task_iter_end(&it);
-- 
2.40.1

