Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F135079BC24
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358203AbjIKWIL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbjIKOVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA95DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:21:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA5C433C8;
        Mon, 11 Sep 2023 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442107;
        bh=imaKPJQO5/J4reW2CGAVltD3XLwVzM9mOk8s/bFsPXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=demS73melVbi30LJWE48XmiDYhQSGQXXmimruCmgL5/tIL5HAA+A/5Pney4A6s+lf
         1a5pxlUFOJBVyw14ES2Pk/sth5I3OJFQVg/mi6JkuYavggUF0cHgsU+VWdbxAVCW+/
         VZUEdzrIFHkYVWf7qLrqppdCoo7sL4OTk/c3y95o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6.5 649/739] cpu/hotplug: Prevent self deadlock on CPU hot-unplug
Date:   Mon, 11 Sep 2023 15:47:28 +0200
Message-ID: <20230911134709.232054777@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 2b8272ff4a70b866106ae13c36be7ecbef5d5da2 upstream.

Xiongfeng reported and debugged a self deadlock of the task which initiates
and controls a CPU hot-unplug operation vs. the CFS bandwidth timer.

    CPU1      			                 	 CPU2

T1 sets cfs_quota
   starts hrtimer cfs_bandwidth 'period_timer'
T1 is migrated to CPU2
						T1 initiates offlining of CPU1
Hotplug operation starts
  ...
'period_timer' expires and is re-enqueued on CPU1
  ...
take_cpu_down()
  CPU1 shuts down and does not handle timers
  anymore. They have to be migrated in the
  post dead hotplug steps by the control task.

						T1 runs the post dead offline operation
					      	T1 is scheduled out
						T1 waits for 'period_timer' to expire

T1 waits there forever if it is scheduled out before it can execute the hrtimer
offline callback hrtimers_dead_cpu().

Cure this by delegating the hotplug control operation to a worker thread on
an online CPU. This takes the initiating user space task, which might be
affected by the bandwidth timer, completely out of the picture.

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yu Liao <liaoyu15@huawei.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com
Link: https://lore.kernel.org/r/87h6oqdq0i.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1467,8 +1467,22 @@ out:
 	return ret;
 }
 
+struct cpu_down_work {
+	unsigned int		cpu;
+	enum cpuhp_state	target;
+};
+
+static long __cpu_down_maps_locked(void *arg)
+{
+	struct cpu_down_work *work = arg;
+
+	return _cpu_down(work->cpu, 0, work->target);
+}
+
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
+	struct cpu_down_work work = { .cpu = cpu, .target = target, };
+
 	/*
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
@@ -1477,7 +1491,15 @@ static int cpu_down_maps_locked(unsigned
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-	return _cpu_down(cpu, 0, target);
+
+	/*
+	 * Ensure that the control task does not run on the to be offlined
+	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 */
+	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
 }
 
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)


