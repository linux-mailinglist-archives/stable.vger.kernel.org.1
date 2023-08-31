Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2378F252
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbjHaSOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHaSOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:14:15 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAA2E5F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693505654; x=1725041654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SaJZSiuBZksibfTJ4SNjQp3OxNIr6K2lqUr4AjALD1M=;
  b=lPzUfV/k62Zj1T9fp2jZRcMgi6irjO+EnGPEgk0u7O70a7/pZtlwi9o0
   POaO4s32+ukMJq8GtTxheQYElz1mKkVEuzFYVNGaVDXdLbivsxyTphW+d
   D6GX5VZlZqNClLpYJYCE3+ogvHc+SLqX4cG2YknBb6ZNTgALtFj/JSzO5
   s=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="669728731"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:14:13 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 0A7C6A09E7;
        Thu, 31 Aug 2023 18:14:11 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:11 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 18:14:09 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>, Aaron Tomlin <atomlin@atomlin.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 2/5] cgroup/cpuset: no need to explicitly init a global static variable
Date:   Thu, 31 Aug 2023 18:13:03 +0000
Message-ID: <fd743ff8b4f3a5367814c967347b63a8e681ff0a.1693505570.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693505570.git.luizcap@amazon.com>
References: <cover.1693505570.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
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

From: Daniel Vacek <neelx@redhat.com>

Commit 21786e5cb375a1e58a9175fee423e1d7f892d965 upstream.

cpuset_rwsem is a static variable defined with DEFINE_STATIC_PERCPU_RWSEM().
It's initialized at build time and so there's no need for explicit runtime
init leaking one percpu int.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0496b88fcd63..4baae4b3c9a0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3391,8 +3391,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 
 int __init cpuset_init(void)
 {
-	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
-
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
-- 
2.40.1

