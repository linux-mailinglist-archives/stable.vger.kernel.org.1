Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810337ECCB2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjKOTcT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjKOTb7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD761A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A687C433C9;
        Wed, 15 Nov 2023 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076716;
        bh=vL5sD+wXikLpB0SNAPvF/KJGavoA5i8niOhW5vRw8t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZW6VC3nmghqg4kAMWmb+sICSM1gc93pbbfdkhj1c3hsx/sFDVlKwpicAgEsCu4tG
         uNexRBNzYJOLipQtYUJPO4GcoY2aozMO/5l5hRo2JbPBn9zv0z4v4fI8eFFKVPyWeN
         rvHpLVUUM4UhNp/njh28aRXJ2gcTw72y5WzhLIOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yicong Yang <yangyicong@hisilicon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/603] sched/topology: Fix sched_numa_find_nth_cpu() in CPU-less case
Date:   Wed, 15 Nov 2023 14:09:08 -0500
Message-ID: <20231115191613.361360889@linuxfoundation.org>
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

[ Upstream commit 617f2c38cb5ce60226042081c09e2ee3a90d03f8 ]

When the node provided by user is CPU-less, corresponding record in
sched_domains_numa_masks is not set. Trying to dereference it in the
following code leads to kernel crash.

To avoid it, start searching from the nearest node with CPUs.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Reported-by: Yicong Yang <yangyicong@hisilicon.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-4-yury.norov@gmail.com

Closes: https://lore.kernel.org/lkml/CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com/T/
Closes: https://lore.kernel.org/lkml/ZMHSNQfv39HN068m@yury-ThinkPad/T/#mf6431cb0b7f6f05193c41adeee444bc95bf2b1c4
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c089..423d08947962c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2122,12 +2122,16 @@ static int hop_cmp(const void *a, const void *b)
  */
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	struct __cmp_key k = { .cpus = cpus, .node = node, .cpu = cpu };
+	struct __cmp_key k = { .cpus = cpus, .cpu = cpu };
 	struct cpumask ***hop_masks;
 	int hop, ret = nr_cpu_ids;
 
 	rcu_read_lock();
 
+	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
+	node = numa_nearest_node(node, N_CPU);
+	k.node = node;
+
 	k.masks = rcu_dereference(sched_domains_numa_masks);
 	if (!k.masks)
 		goto unlock;
-- 
2.42.0



