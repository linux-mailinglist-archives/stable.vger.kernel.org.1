Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E97A3C61
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbjIQUa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbjIQUaP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:30:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2410F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:30:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B2FC433C9;
        Sun, 17 Sep 2023 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982609;
        bh=tYYVPHbMwcLAZa1Yj31q+8kxawqVHR5jQhnqBo4gkIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLqRo6Sx71MCUDsKSoyCiE1NKmpy7OnwvCBmJmXRg4c12jT/y02/ujAcdv6XeUJxE
         0oS2LaQMdgks5rMZlyKmu/XHQxWx/O2kGn+FqwceyUC7vxnmNmZ0cNmS7mC2c8zQrL
         CscYXpPSXMtLYQdDe5DkIJy4bOT2m6u3+ZmGwqa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 300/511] tracing: Fix race issue between cpu buffer write and swap
Date:   Sun, 17 Sep 2023 21:12:07 +0200
Message-ID: <20230917191121.077187942@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 3163f635b20e9e1fb4659e74f47918c9dddfe64e ]

Warning happened in rb_end_commit() at code:
	if (RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing)))

  WARNING: CPU: 0 PID: 139 at kernel/trace/ring_buffer.c:3142
	rb_commit+0x402/0x4a0
  Call Trace:
   ring_buffer_unlock_commit+0x42/0x250
   trace_buffer_unlock_commit_regs+0x3b/0x250
   trace_event_buffer_commit+0xe5/0x440
   trace_event_buffer_reserve+0x11c/0x150
   trace_event_raw_event_sched_switch+0x23c/0x2c0
   __traceiter_sched_switch+0x59/0x80
   __schedule+0x72b/0x1580
   schedule+0x92/0x120
   worker_thread+0xa0/0x6f0

It is because the race between writing event into cpu buffer and swapping
cpu buffer through file per_cpu/cpu0/snapshot:

  Write on CPU 0             Swap buffer by per_cpu/cpu0/snapshot on CPU 1
  --------                   --------
                             tracing_snapshot_write()
                               [...]

  ring_buffer_lock_reserve()
    cpu_buffer = buffer->buffers[cpu]; // 1. Suppose find 'cpu_buffer_a';
    [...]
    rb_reserve_next_event()
      [...]

                               ring_buffer_swap_cpu()
                                 if (local_read(&cpu_buffer_a->committing))
                                     goto out_dec;
                                 if (local_read(&cpu_buffer_b->committing))
                                     goto out_dec;
                                 buffer_a->buffers[cpu] = cpu_buffer_b;
                                 buffer_b->buffers[cpu] = cpu_buffer_a;
                                 // 2. cpu_buffer has swapped here.

      rb_start_commit(cpu_buffer);
      if (unlikely(READ_ONCE(cpu_buffer->buffer)
          != buffer)) { // 3. This check passed due to 'cpu_buffer->buffer'
        [...]           //    has not changed here.
        return NULL;
      }
                                 cpu_buffer_b->buffer = buffer_a;
                                 cpu_buffer_a->buffer = buffer_b;
                                 [...]

      // 4. Reserve event from 'cpu_buffer_a'.

  ring_buffer_unlock_commit()
    [...]
    cpu_buffer = buffer->buffers[cpu]; // 5. Now find 'cpu_buffer_b' !!!
    rb_commit(cpu_buffer)
      rb_end_commit()  // 6. WARN for the wrong 'committing' state !!!

Based on above analysis, we can easily reproduce by following testcase:
  ``` bash
  #!/bin/bash

  dmesg -n 7
  sysctl -w kernel.panic_on_warn=1
  TR=/sys/kernel/tracing
  echo 7 > ${TR}/buffer_size_kb
  echo "sched:sched_switch" > ${TR}/set_event
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  ```

To fix it, IIUC, we can use smp_call_function_single() to do the swap on
the target cpu where the buffer is located, so that above race would be
avoided.

Link: https://lore.kernel.org/linux-trace-kernel/20230831132739.4070878-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Fixes: f1affcaaa861 ("tracing: Add snapshot in the per_cpu trace directories")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 92b381aab8f2b..380ae34a9a0b3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7496,6 +7496,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static void tracing_swap_cpu_buffer(void *tr)
+{
+	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+}
+
 static ssize_t
 tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		       loff_t *ppos)
@@ -7554,13 +7559,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
 			break;
-		local_irq_disable();
 		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
+			local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-		else
-			update_max_tr_single(tr, current, iter->cpu_file);
-		local_irq_enable();
+			local_irq_enable();
+		} else {
+			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
+						 (void *)tr, 1);
+		}
 		break;
 	default:
 		if (tr->allocated_snapshot) {
-- 
2.40.1



