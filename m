Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851827ECF1D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjKOTq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjKOTq1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556012C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E21C433C7;
        Wed, 15 Nov 2023 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077584;
        bh=n10BeVaDGW7hXcSa2rV9kMJU6UJOJ5kUiaYAZ4ZdUdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzl6P6PPtuAFQN0gktUocsARwHzqOXE0qZoh/iZazCZIkEtLjT9hizcuUbhlOVrSt
         /qLQ7XiLOhRwcuM9aVeDIM5E8ZzDC5vLPciaGvZj8oOy02myh/jJhmmORa751dlpdS
         P0zvT9Z64ZAlHWst4oD0prQWNg6glwbaOnopNGt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 391/603] HID: uclogic: Fix a work->entry not empty bug in __queue_work()
Date:   Wed, 15 Nov 2023 14:15:36 -0500
Message-ID: <20231115191640.214342902@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit d45f72b3c275101a620dd69881343e0dda72f877 ]

When CONFIG_HID_UCLOGIC=y and CONFIG_KUNIT_ALL_TESTS=y, launch
kernel and then the below work->entry not empty bug occurs.

In hid_test_uclogic_exec_event_hook_test(), the filter->work is not
initialized to be added to p.event_hooks->list, and then the
schedule_work() in uclogic_exec_event_hook() will call __queue_work(),
which check whether the work->entry is empty and cause the below
warning call trace.

So call INIT_WORK() with a fake work to solve the issue. After applying
this patch, the below work->entry not empty bug never occurs.

 WARNING: CPU: 0 PID: 2177 at kernel/workqueue.c:1787 __queue_work.part.0+0x780/0xad0
 Modules linked in:
 CPU: 0 PID: 2177 Comm: kunit_try_catch Tainted: G    B   W        N 6.6.0-rc2+ #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:__queue_work.part.0+0x780/0xad0
 Code: 44 24 20 0f b6 00 84 c0 74 08 3c 03 0f 8e 52 03 00 00 f6 83 00 01 00 00 02 74 6f 4c 89 ef e8 c7 d8 f1 02 f3 90 e9 e5 f8 ff ff <0f> 0b e9 63 fc ff ff 89 e9 49 8d 57 68 4c 89 e6 4c 89 ff 83 c9 02
 RSP: 0000:ffff888102bb7ce8 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: ffff888106b8e460 RCX: ffffffff84141cc7
 RDX: 1ffff11020d71c8c RSI: 0000000000000004 RDI: ffff8881001d0118
 RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed1020576f92
 R10: 0000000000000003 R11: ffff888102bb7980 R12: ffff888106b8e458
 R13: ffff888119c38800 R14: 0000000000000000 R15: ffff8881001d0100
 FS:  0000000000000000(0000) GS:ffff888119c00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffff888119506000 CR3: 0000000005286001 CR4: 0000000000770ef0
 DR0: ffffffff8fdd6ce0 DR1: ffffffff8fdd6ce1 DR2: ffffffff8fdd6ce3
 DR3: ffffffff8fdd6ce5 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0xc9/0x260
  ? __queue_work.part.0+0x780/0xad0
  ? report_bug+0x345/0x400
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x14/0x40
  ? asm_exc_invalid_op+0x16/0x20
  ? _raw_spin_lock+0x87/0xe0
  ? __queue_work.part.0+0x780/0xad0
  ? __queue_work.part.0+0x249/0xad0
  queue_work_on+0x48/0x50
  uclogic_exec_event_hook.isra.0+0xf7/0x160
  hid_test_uclogic_exec_event_hook_test+0x2f1/0x5d0
  ? try_to_wake_up+0x151/0x13e0
  ? uclogic_exec_event_hook.isra.0+0x160/0x160
  ? _raw_spin_lock_irqsave+0x8d/0xe0
  ? __sched_text_end+0xa/0xa
  ? __sched_text_end+0xa/0xa
  ? migrate_enable+0x260/0x260
  ? kunit_try_run_case_cleanup+0xe0/0xe0
  kunit_generic_run_threadfn_adapter+0x4a/0x90
  ? kunit_try_catch_throw+0x80/0x80
  kthread+0x2b5/0x380
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x70
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>

Fixes: a251d6576d2a ("HID: uclogic: Handle wireless device reconnection")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>
Link: https://lore.kernel.org/r/20231009064245.3573397-3-ruanjinjie@huawei.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-uclogic-core-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-uclogic-core-test.c b/drivers/hid/hid-uclogic-core-test.c
index 2bb916226a389..cb274cde3ad23 100644
--- a/drivers/hid/hid-uclogic-core-test.c
+++ b/drivers/hid/hid-uclogic-core-test.c
@@ -56,6 +56,11 @@ static struct uclogic_raw_event_hook_test test_events[] = {
 	},
 };
 
+static void fake_work(struct work_struct *work)
+{
+
+}
+
 static void hid_test_uclogic_exec_event_hook_test(struct kunit *test)
 {
 	struct uclogic_params p = {0, };
@@ -77,6 +82,8 @@ static void hid_test_uclogic_exec_event_hook_test(struct kunit *test)
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filter->event);
 		memcpy(filter->event, &hook_events[n].event[0], filter->size);
 
+		INIT_WORK(&filter->work, fake_work);
+
 		list_add_tail(&filter->list, &p.event_hooks->list);
 	}
 
-- 
2.42.0



