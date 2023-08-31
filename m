Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1EF78F251
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbjHaSOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHaSOH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:14:07 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D941E5F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693505644; x=1725041644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PTLJERIyGgw3F4vCpMkD1VMdxbbj1G769+qINUFWQ8=;
  b=J5kHglmUpuhVVSF0bSVg7NhUwRD1bS9C8Wbo/ADKaK9i5PHSwh05O2pg
   qVl9lZo8wv2EGK7QZYjuDWvHraRb5YY16s7jOx/MCMA7Ho/mTTK/ZNEev
   PqdYA3ooGPKoLfkEeLkHkPVWxlngZttsWY/MmbSg/EJzzFloJHKAqEbTw
   E=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="26290900"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:14:03 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 5593060D01;
        Thu, 31 Aug 2023 18:14:03 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:13:52 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:13:50 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>, Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 1/5] cgroup/cpuset: Optimize cpuset_attach() on v2
Date:   Thu, 31 Aug 2023 18:13:02 +0000
Message-ID: <aa6ac969399786c818ff794728bd3db957b7f066.1693505570.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693505570.git.luizcap@amazon.com>
References: <cover.1693505570.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
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

Commit 7fd4da9c1584be97ffbc40e600a19cb469fd4e78 upstream.

It was found that with the default hierarchy, enabling cpuset in the
child cgroups can trigger a cpuset_attach() call in each of the child
cgroups that have tasks with no change in effective cpus and mems. If
there are many processes in those child cgroups, it will burn quite a
lot of cpu cycles iterating all the tasks without doing useful work.

Optimizing this case by comparing between the old and new cpusets and
skip useless update if there is no change in effective cpus and mems.
Also mems_allowed are less likely to be changed than cpus_allowed. So
skip changing mm if there is no change in effective_mems and
CS_MEMORY_MIGRATE is not set.

By inserting some instrumentation code and running a simple command in
a container 200 times in a cgroup v2 system, it was found that all the
cpuset_attach() calls are skipped (401 times in total) as there was no
change in effective cpus and mems.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 kernel/cgroup/cpuset.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e276db722845..0496b88fcd63 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2553,12 +2553,28 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
+	bool cpus_updated, mems_updated;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	percpu_down_write(&cpuset_rwsem);
+	cpus_updated = !cpumask_equal(cs->effective_cpus,
+				      oldcs->effective_cpus);
+	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	/*
+	 * In the default hierarchy, enabling cpuset in the child cgroups
+	 * will trigger a number of cpuset_attach() calls with no change
+	 * in effective cpus and mems. In that case, we can optimize out
+	 * by skipping the task iteration and update.
+	 */
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+	    !cpus_updated && !mems_updated) {
+		cpuset_attach_nodemask_to = cs->effective_mems;
+		goto out;
+	}
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
@@ -2567,9 +2583,14 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	/*
 	 * Change mm for all threadgroup leaders. This is expensive and may
-	 * sleep and should be moved outside migration path proper.
+	 * sleep and should be moved outside migration path proper. Skip it
+	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
+	 * not set.
 	 */
 	cpuset_attach_nodemask_to = cs->effective_mems;
+	if (!is_memory_migrate(cs) && !mems_updated)
+		goto out;
+
 	cgroup_taskset_for_each_leader(leader, css, tset) {
 		struct mm_struct *mm = get_task_mm(leader);
 
@@ -2592,6 +2613,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		}
 	}
 
+out:
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
 	cs->attach_in_progress--;
-- 
2.40.1

