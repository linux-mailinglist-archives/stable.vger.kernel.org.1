Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0760D79BB0C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjIKV7X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbjIKOGZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3675120
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61C7C433C7;
        Mon, 11 Sep 2023 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441180;
        bh=OJ0JVI/R068BfEcwIEc2CSn7/li1VdXA+EPea4HnHSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqAV8YQ0RW4YCRwCYTGP0G0k3YY53mPAKVt4EbDXR0ZaDMo350DRd8j3sl+eY7so5
         KaIDBs60XyFLtItmRE43AO0PE1twbUFCbVhQUoaCaMiFPuL0b+sF/fOxFDaJBouq5D
         yCLf88+EALKRlBsHfFUjzBfJtz6dq8rhdOvOuX1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 323/739] audit: fix possible soft lockup in __audit_inode_child()
Date:   Mon, 11 Sep 2023 15:42:02 +0200
Message-ID: <20230911134700.125716126@linuxfoundation.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream commit b59bc6e37237e37eadf50cd5de369e913f524463 ]

Tracefs or debugfs maybe cause hundreds to thousands of PATH records,
too many PATH records maybe cause soft lockup.

For example:
  1. CONFIG_KASAN=y && CONFIG_PREEMPTION=n
  2. auditctl -a exit,always -S open -k key
  3. sysctl -w kernel.watchdog_thresh=5
  4. mkdir /sys/kernel/debug/tracing/instances/test

There may be a soft lockup as follows:
  watchdog: BUG: soft lockup - CPU#45 stuck for 7s! [mkdir:15498]
  Kernel panic - not syncing: softlockup: hung tasks
  Call trace:
   dump_backtrace+0x0/0x30c
   show_stack+0x20/0x30
   dump_stack+0x11c/0x174
   panic+0x27c/0x494
   watchdog_timer_fn+0x2bc/0x390
   __run_hrtimer+0x148/0x4fc
   __hrtimer_run_queues+0x154/0x210
   hrtimer_interrupt+0x2c4/0x760
   arch_timer_handler_phys+0x48/0x60
   handle_percpu_devid_irq+0xe0/0x340
   __handle_domain_irq+0xbc/0x130
   gic_handle_irq+0x78/0x460
   el1_irq+0xb8/0x140
   __audit_inode_child+0x240/0x7bc
   tracefs_create_file+0x1b8/0x2a0
   trace_create_file+0x18/0x50
   event_create_dir+0x204/0x30c
   __trace_add_new_event+0xac/0x100
   event_trace_add_tracer+0xa0/0x130
   trace_array_create_dir+0x60/0x140
   trace_array_create+0x1e0/0x370
   instance_mkdir+0x90/0xd0
   tracefs_syscall_mkdir+0x68/0xa0
   vfs_mkdir+0x21c/0x34c
   do_mkdirat+0x1b4/0x1d4
   __arm64_sys_mkdirat+0x4c/0x60
   el0_svc_common.constprop.0+0xa8/0x240
   do_el0_svc+0x8c/0xc0
   el0_svc+0x20/0x30
   el0_sync_handler+0xb0/0xb4
   el0_sync+0x160/0x180

Therefore, we add cond_resched() to __audit_inode_child() to fix it.

Fixes: 5195d8e217a7 ("audit: dynamically allocate audit_names when not enough space is in the names array")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d3..8dfd581cd5543 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2456,6 +2456,8 @@ void __audit_inode_child(struct inode *parent,
 		}
 	}
 
+	cond_resched();
+
 	/* is there a matching child entry? */
 	list_for_each_entry(n, &context->names_list, list) {
 		/* can only match entries that have a name */
-- 
2.40.1



