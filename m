Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBDC7ECF0C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjKOTqG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjKOTqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB244D63
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCC3C433C7;
        Wed, 15 Nov 2023 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077555;
        bh=AQiWfGYHhJS6rsPt7ANRCcvV8ggfvuLKoB8pmo0REV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCVCydBa+CknDRPkThAJBJnGH1LhFyV0RdvVLUCfSjA8vI5ikCx6Qv0qvgdQBCBXp
         tAN9zM1lh6cfQ9zJ2+PUoY2UvvNpevmpTRETvmVGGoZMLct4OalFz2XiPnj1JLYA25
         P3nKgJPCbXWMWwI0qRPadXRzeGFejIYvF/5vTrLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tomas Glozar <tglozar@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 354/603] nd_btt: Make BTT lanes preemptible
Date:   Wed, 15 Nov 2023 14:14:59 -0500
Message-ID: <20231115191638.033449420@linuxfoundation.org>
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

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 36c75ce3bd299878fd9b238e9803d3817ddafbf3 ]

nd_region_acquire_lane uses get_cpu, which disables preemption. This is
an issue on PREEMPT_RT kernels, since btt_write_pg and also
nd_region_acquire_lane itself take a spin lock, resulting in BUG:
sleeping function called from invalid context.

Fix the issue by replacing get_cpu with smp_process_id and
migrate_disable when needed. This makes BTT operations preemptible, thus
permitting the use of spin_lock.

BUG example occurring when running ndctl tests on PREEMPT_RT kernel:

BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4903, name:
libndctl
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
[<ffffffffc1313db5>] nd_region_acquire_lane+0x15/0x90 [libnvdimm]
Call Trace:
 <TASK>
 dump_stack_lvl+0x8e/0xb0
 __might_resched+0x19b/0x250
 rt_spin_lock+0x4c/0x100
 ? btt_write_pg+0x2d7/0x500 [nd_btt]
 btt_write_pg+0x2d7/0x500 [nd_btt]
 ? local_clock_noinstr+0x9/0xc0
 btt_submit_bio+0x16d/0x270 [nd_btt]
 __submit_bio+0x48/0x80
 __submit_bio_noacct+0x7e/0x1e0
 submit_bio_wait+0x58/0xb0
 __blkdev_direct_IO_simple+0x107/0x240
 ? inode_set_ctime_current+0x51/0x110
 ? __pfx_submit_bio_wait_endio+0x10/0x10
 blkdev_write_iter+0x1d8/0x290
 vfs_write+0x237/0x330
 ...
 </TASK>

Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/region_devs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0a81f87f6f6c0..e2f1fb99707fc 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -939,7 +939,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
+	migrate_disable();
+	cpu = smp_processor_id();
 	if (nd_region->num_lanes < nr_cpu_ids) {
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
@@ -958,16 +959,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
 	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
+		unsigned int cpu = smp_processor_id();
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
 		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (--ndl_count->count == 0)
 			spin_unlock(&ndl_lock->lock);
-		put_cpu();
 	}
-	put_cpu();
+	migrate_enable();
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
-- 
2.42.0



