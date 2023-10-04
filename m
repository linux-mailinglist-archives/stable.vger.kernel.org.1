Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA937B88AA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJDSSY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjJDSJR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C75AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8190EC433C7;
        Wed,  4 Oct 2023 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442952;
        bh=E7QxiAPEeTOF/Ud2NRJpA9LrAt87n0yyKzEFyeQgc7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWzKcWb1gEzYV0zts62lGgE4GhebTxrluhSAxhbxCCWfbljFNRBKxg4QpaPnwPlNq
         ZGTBpXs0KFQPPj5u7nBNgSpUr0tUW3qcLzOr7C7ShXc7t5qZh8Iq3Nen3H0zsslO/3
         CwYSJYNwQkgjCfe10PMfZMI9K+ErYTq7w9I6mkgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.15 168/183] sched/rt: Fix live lock between select_fallback_rq() and RT push
Date:   Wed,  4 Oct 2023 19:56:39 +0200
Message-ID: <20231004175211.078918781@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit fc09027786c900368de98d03d40af058bcb01ad9 upstream.

During RCU-boost testing with the TREE03 rcutorture config, I found that
after a few hours, the machine locks up.

On tracing, I found that there is a live lock happening between 2 CPUs.
One CPU has an RT task running, while another CPU is being offlined
which also has an RT task running.  During this offlining, all threads
are migrated. The migration thread is repeatedly scheduled to migrate
actively running tasks on the CPU being offlined. This results in a live
lock because select_fallback_rq() keeps picking the CPU that an RT task
is already running on only to get pushed back to the CPU being offlined.

It is anyway pointless to pick CPUs for pushing tasks to if they are
being offlined only to get migrated away to somewhere else. This could
also add unwanted latency to this task.

Fix these issues by not selecting CPUs in RT if they are not 'active'
for scheduling, using the cpu_active_mask. Other parts in core.c already
use cpu_active_mask to prevent tasks from being put on CPUs going
offline.

With this fix I ran the tests for days and could not reproduce the
hang. Without the patch, I hit it in a few hours.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230923011409.3522762-1-joel@joelfernandes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/cpupri.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -102,6 +102,7 @@ static inline int __cpupri_find(struct c
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit


