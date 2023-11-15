Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923917ECCB4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjKOTcV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjKOTcD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC11B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3483AC433C9;
        Wed, 15 Nov 2023 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076719;
        bh=xzYDLOre1aBVogJc1v1s63FGmUlv7+M2j/UgiRob7D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTa0zjqmjJJyyMrVlVWVhADNvfUoTZxzg0GzUaD8iU68To8s34jsiaBGKRF8VyF7V
         hUil3+Ol/P+lHro6/hc70uNIWeTQaLn3OVMsmUaIwVJjKd+egY+6QTIlJvz1NX+RQH
         bBANMNwUR6FgJA4K0fBPkeNxk97/SDnRDh884F3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/603] sched/topology: Fix sched_numa_find_nth_cpu() in non-NUMA case
Date:   Wed, 15 Nov 2023 14:09:09 -0500
Message-ID: <20231115191613.425390619@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yury Norov <yury.norov@gmail.com>

[ Upstream commit 8ab63d418d4339d996f80d02a00dbce0aa3ff972 ]

When CONFIG_NUMA is enabled, sched_numa_find_nth_cpu() searches for a
CPU in sched_domains_numa_masks. The masks includes only online CPUs,
so effectively offline CPUs are skipped.

When CONFIG_NUMA is disabled, the fallback function should be consistent.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-5-yury.norov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index fea32377f7c77..52f5850730b3e 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -251,7 +251,7 @@ extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int
 #else
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	return cpumask_nth(cpu, cpus);
+	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
 static inline const struct cpumask *
-- 
2.42.0



