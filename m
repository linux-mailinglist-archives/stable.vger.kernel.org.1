Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7878F250
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjHaSNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHaSNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:13:37 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4876E63
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693505615; x=1725041615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HdbG0+hIU4uAEWs7h5jH0T2ajrx7/ktUXU4xM8qsj0o=;
  b=G2nsSE/rOPlP9CsJzXC3c2WniimPJhghcDMkAfoT3axx9k1YPioQFKT+
   UM5cS1aEc6yb4zB8yjUFqqW6Dkij/iIMowa/sEAQCW4aCXE4uVQUrJH6Z
   mA29pR1HvOqgvj6ZImh7652UQy741eNswlBAQ6rWoqlDBKMjXNu7fsHdj
   E=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="669728573"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:13:35 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id C6A958A0C6;
        Thu, 31 Aug 2023 18:13:33 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:13:33 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:13:31 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>, Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 0/5] Backport "sched cpuset: Bring back cpuset_mutex"
Date:   Thu, 31 Aug 2023 18:13:01 +0000
Message-ID: <cover.1693505570.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

When using KVM on systems that require iTLB multihit mitigation enabled[1],
we're observing very high latency (70ms+) in KVM_CREATE_VM ioctl() in 6.1
kernel in comparison to older stable kernels such as 5.10. This is true even
when using favordynmods mount option.

We debugged this down to the cpuset controller trying to acquire cpuset_rwsem
in cpuset_can_attach(). This happens because KVM creates a worker thread which
calls cgroup_attach_task_all() during KVM_CREATE_VM. I don't know if
favordynmods is supposed to cover this case or not, but removing cpuset_rwsem
certainly solves the issue.

For the backport I tried to pick as many dependent commits as required to avoid
conflicts. I would highly appreciate review from cgroup people.

Tests performed:
 * Measured latency in KVM_CREATE_VM ioctl(), it goes down to less than 1ms
 * Ran the cgroup kselftest tests, got same results with or without this series
    * However, some tests such as test_memcontrol and test_kmem are failing
      in 6.1. This probably needs to be looked at
    * To make test_cpuset_prs.sh work, I had to increase the timeout on line
      592 to 1 second. With this change, the test runs and passes
 * I run our downstream test suite against our downstream 6.1 kernel with this
   series applied, it passed

 [1] For the case where the CPU is not vulnerable to iTLB multihit we can
     simply disable the iTLB multihit mitigation in KVM which avoids this
     whole situation. Disabling the mitigation is possible since upstream
     commit 0b210faf337 which I plan to backport soon

Daniel Vacek (1):
  cgroup/cpuset: no need to explicitly init a global static variable

Juri Lelli (1):
  sched/cpuset: Bring back cpuset_mutex

Waiman Long (3):
  cgroup/cpuset: Optimize cpuset_attach() on v2
  cgroup/cpuset: Skip task update if hotplug doesn't affect current
    cpuset
  cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset
    are updated

 include/linux/cpuset.h |   8 +-
 kernel/cgroup/cpuset.c | 211 +++++++++++++++++++++++------------------
 kernel/sched/core.c    |  22 +++--
 3 files changed, 139 insertions(+), 102 deletions(-)

-- 
2.40.1

