Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C37611E2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjGYK5Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjGYK4s (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637C54209
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5286165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F69EC433C8;
        Tue, 25 Jul 2023 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282462;
        bh=dxNttj5Dv/drFPUSKj0UkdUqEjgAOkT5mId0OUFvOBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Oe/NeLH6PeDNjVdu+NV+ksafZx8U3cdPvD8ktynqO0J2BXqKODLTZF8fZ0LFv28k
         2EsSg+6yT6G0AEMaYt1T7N/sdZSSLBHmiktBmj5VFogIABSBbv5cAHRdL3FmZaVI+J
         pU2O7twNllQbsO6M35+9Y3jDmaB4+E62z+I/DjDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 139/227] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Date:   Tue, 25 Jul 2023 12:45:06 +0200
Message-ID: <20230725104520.611814311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit ae2ad293d6be143ad223f5f947cca07bcbe42595 ]

When checking whether a recently used CPU can be a potential idle
candidate, recent_used_cpu should be used to test p->cpus_ptr as
p->recent_used_cpu is not equal to recent_used_cpu and candidate
decision is made based on recent_used_cpu here.

Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230620080747.359122-1-linmiaohe@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e427056b440bb..dacb56d7e9147 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7174,7 +7174,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
 	}
-- 
2.39.2



