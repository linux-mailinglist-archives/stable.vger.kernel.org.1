Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8078F253
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjHaSOk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHaSOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:14:40 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FEE5F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693505678; x=1725041678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nbz9dGyWpP5ey0v693rABf4c1f6rHdtF9EF7ICVjTU=;
  b=FHZd7mqeClpp+lMaoAIQKYLqRI4MDdPpStwl6PhQvjO9Bkt3V65PI0G2
   BFRa/GLo4hOIQuQ6xCy1qvr/jrZ+QxLhZKz67zWxsZhqHIMk0AAzDQdtD
   AQwo1NBL0IyE+S2uoWhYmcJQb47yenuRtbXzabO82a46C0Zy0E4s9tN6R
   o=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="602065972"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:14:36 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 4A77C805D8;
        Thu, 31 Aug 2023 18:14:33 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:30 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:29 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 3/5] cgroup/cpuset: Skip task update if hotplug doesn't affect current cpuset
Date:   Thu, 31 Aug 2023 18:13:04 +0000
Message-ID: <4aa99a5713f910d87e813971457b88cddb0f02c7.1693505570.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693505570.git.luizcap@amazon.com>
References: <cover.1693505570.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Commit df59b72cd8fb8ca00301f47e65853efed195d23f upstream.

If a hotplug event doesn't affect the current cpuset, there is no point
to call hotplug_update_tasks() or hotplug_update_tasks_legacy(). So
just skip it.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4baae4b3c9a0..8664b9c1edc8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3613,6 +3613,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
+	if (!cpus_updated && !mems_updated)
+		goto unlock;	/* Hotplug doesn't affect this cpuset */
 
 	if (mems_updated)
 		check_insane_mems_config(&new_mems);
@@ -3624,6 +3626,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
+unlock:
 	percpu_up_write(&cpuset_rwsem);
 }
 
-- 
2.40.1

