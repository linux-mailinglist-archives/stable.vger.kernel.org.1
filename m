Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B959703919
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbjEORiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbjEORij (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194E1B0A6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BE662DBD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800B1C433EF;
        Mon, 15 May 2023 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172163;
        bh=nvpK3xtzGPEVfwmc8hR9Ood9k+o3Hlt9ZxIpL473IDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3A0EiqS38Guowl07Bq+5mNW51cSOqhlgXFPaG78A8RVh3HQHxYBRZgi4r76fJ8NM
         ihwiNY6bgoI+0TjwkY6hbgswXgSMEx+lJn0Cf9k1gyS5ExdcsGs+ghkVCuq+wZlYOr
         8slfRp+FZhsReFSSbkPWka6UXZim0dJohKaY3eLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 037/381] ring-buffer: Sync IRQ works before buffer destruction
Date:   Mon, 15 May 2023 18:24:48 +0200
Message-Id: <20230515161738.486991176@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 675751bb20634f981498c7d66161584080cc061e upstream.

If something was written to the buffer just before destruction,
it may be possible (maybe not in a real system, but it did
happen in ARCH=um with time-travel) to destroy the ringbuffer
before the IRQ work ran, leading this KASAN report (or a crash
without KASAN):

    BUG: KASAN: slab-use-after-free in irq_work_run_list+0x11a/0x13a
    Read of size 8 at addr 000000006d640a48 by task swapper/0

    CPU: 0 PID: 0 Comm: swapper Tainted: G        W  O       6.3.0-rc1 #7
    Stack:
     60c4f20f 0c203d48 41b58ab3 60f224fc
     600477fa 60f35687 60c4f20f 601273dd
     00000008 6101eb00 6101eab0 615be548
    Call Trace:
     [<60047a58>] show_stack+0x25e/0x282
     [<60c609e0>] dump_stack_lvl+0x96/0xfd
     [<60c50d4c>] print_report+0x1a7/0x5a8
     [<603078d3>] kasan_report+0xc1/0xe9
     [<60308950>] __asan_report_load8_noabort+0x1b/0x1d
     [<60232844>] irq_work_run_list+0x11a/0x13a
     [<602328b4>] irq_work_tick+0x24/0x34
     [<6017f9dc>] update_process_times+0x162/0x196
     [<6019f335>] tick_sched_handle+0x1a4/0x1c3
     [<6019fd9e>] tick_sched_timer+0x79/0x10c
     [<601812b9>] __hrtimer_run_queues.constprop.0+0x425/0x695
     [<60182913>] hrtimer_interrupt+0x16c/0x2c4
     [<600486a3>] um_timer+0x164/0x183
     [...]

    Allocated by task 411:
     save_stack_trace+0x99/0xb5
     stack_trace_save+0x81/0x9b
     kasan_save_stack+0x2d/0x54
     kasan_set_track+0x34/0x3e
     kasan_save_alloc_info+0x25/0x28
     ____kasan_kmalloc+0x8b/0x97
     __kasan_kmalloc+0x10/0x12
     __kmalloc+0xb2/0xe8
     load_elf_phdrs+0xee/0x182
     [...]

    The buggy address belongs to the object at 000000006d640800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 584 bytes inside of
     freed 1024-byte region [000000006d640800, 000000006d640c00)

Add the appropriate irq_work_sync() so the work finishes before
the buffers are destroyed.

Prior to the commit in the Fixes tag below, there was only a
single global IRQ work, so this issue didn't exist.

Link: https://lore.kernel.org/linux-trace-kernel/20230427175920.a76159263122.I8295e405c44362a86c995e9c2c37e3e03810aa56@changeid

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 15693458c4bc ("tracing/ring-buffer: Move poll wake ups into ring buffer code")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1644,6 +1644,8 @@ static void rb_free_cpu_buffer(struct ri
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1750,6 +1752,8 @@ ring_buffer_free(struct trace_buffer *bu
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 


