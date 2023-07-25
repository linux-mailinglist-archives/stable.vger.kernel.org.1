Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC47612BD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjGYLFX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjGYLFL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B62689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CF161648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6102AC433C9;
        Tue, 25 Jul 2023 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282954;
        bh=SiDpIQ8awCGIUUwjWMAHcRQDhOhWUP0e0a7/Aiy0EdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09li8hhBlu4JZY1DJmjHrdNNpIyLDlDJptfRYWRnpyVA8JCgOIhuQ8uTyBh86HLtt
         AqC2MHkbi+f7DiNon5ZJOhbM3EduPcaUqhHoWvVPltTCExPdw92+51G79IvnlUymPi
         cNSby5H55iHEJ3RKb/tb0aKctmG3mceACnk1OZSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 086/183] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Date:   Tue, 25 Jul 2023 12:45:14 +0200
Message-ID: <20230725104511.063826461@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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
index 57d39de0962d7..5e5aea2360a87 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6935,7 +6935,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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



