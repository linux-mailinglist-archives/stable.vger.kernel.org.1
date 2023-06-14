Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC86726BDA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjFGU2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjFGU2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEC212E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB55644A6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15D7C433EF;
        Wed,  7 Jun 2023 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169711;
        bh=PL5YkkxDopVi/OtCOZgD3QlHw6UwRKmbEf/QV+E828c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIWAKY/a2LdBOEvr53rk618bpxTKNHNHVEhcOdDRlViFTHRi2UCqh33DUW7NLrprG
         erFxViXqDO/F5X/dHPdZ43bdvN+MAhm/fS/DivZHR6fhupYH6h97nXvriXXBQssfAz
         q8jy4AEMnXfI3uCin3ixosyoH9so189U50Jm1A3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 184/286] drivers: base: cacheinfo: Fix shared_cpu_map changes in event of CPU hotplug
Date:   Wed,  7 Jun 2023 22:14:43 +0200
Message-ID: <20230607200929.286784952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: K Prateek Nayak <kprateek.nayak@amd.com>

[ Upstream commit 126310c9f669c9a8c875a3e5c2292299ca90225d ]

While building the shared_cpu_map, check if the cache level and cache
type matches. On certain systems that build the cache topology based on
the instance ID, there are cases where the same ID may repeat across
multiple cache levels, leading inaccurate topology.

In event of CPU offlining, the cache_shared_cpu_map_remove() does not
consider if IDs at same level are being compared. As a result, when same
IDs repeat across different cache levels, the CPU going offline is not
removed from all the shared_cpu_map.

Below is the output of cache topology of CPU8 and it's SMT sibling after
CPU8 is offlined on a dual socket 3rd Generation AMD EPYC processor
(2 x 64C/128T) running kernel release v6.3:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu136/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu136/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list: 9-15,136-143

CPU8 is removed from index0 (L1i) but remains in the shared_cpu_list of
index1 (L1d) and index2 (L2). Since L1i, L1d, and L2 are shared by the
SMT siblings, and they have the same cache instance ID, CPU 2 is only
removed from the first index with matching ID which is index1 (L1i) in
this case. With this fix, the results are as expected when performing
the same experiment on the same system:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu136/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index1/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index2/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list: 9-15,136-143

When rebuilding topology, the same problem appears as
cache_shared_cpu_map_setup() implements a similar logic. Consider the
same 3rd Generation EPYC processor: CPUs in Core 1, that share the L1
and L2 caches, have L1 and L2 instance ID as 1. For all the CPUs on
the second chiplet, the L3 ID is also 1 leading to grouping on CPUs from
Core 1 (1, 17) and the entire second chiplet (8-15, 24-31) as CPUs
sharing one cache domain. This went undetected since x86 processors
depended on arch specific populate_cache_leaves() method to repopulate
the shared_cpus_map when CPU came back online until kernel release
v6.3-rc5.

Fixes: 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared caches at different levels")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20230508084115.1157-2-kprateek.nayak@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/cacheinfo.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ea8f416852bd9..6351db6ecb57f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -380,6 +380,16 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 				continue;/* skip if itself or no cacheinfo */
 			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
@@ -411,6 +421,16 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
-- 
2.39.2



