Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB25D7A3A00
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbjIQT5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbjIQT5H (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F13F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C65C433C7;
        Sun, 17 Sep 2023 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980621;
        bh=oBvDjh8jQSw8VSGougWxxafuSCSst34B5Z0jnZ34Zdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOKNLTOHaGRYF+hp3bZQCpykJ1vh8dfZgJ6BRi3JVpP+hjTTu489s+CANnKhR5+0o
         eBSarH8IvTcPJkAx8n+UhbhcZMgciTDhWI61Z0mdUxa6Wy/Mi+4nTO4l6E5hMOARzK
         IpQ3tKCfzEmBui+1p2lnxU3KXAYiiPhQRLowdKW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 246/285] kunit: Fix wild-memory-access bug in kunit_free_suite_set()
Date:   Sun, 17 Sep 2023 21:14:06 +0200
Message-ID: <20230917191059.852823396@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 2810c1e99867a811e631dd24e63e6c1e3b78a59d ]

Inject fault while probing kunit-example-test.ko, if kstrdup()
fails in mod_sysfs_setup() in load_module(), the mod->state will
switch from MODULE_STATE_COMING to MODULE_STATE_GOING instead of
from MODULE_STATE_LIVE to MODULE_STATE_GOING, so only
kunit_module_exit() will be called without kunit_module_init(), and
the mod->kunit_suites is no set correctly and the free in
kunit_free_suite_set() will cause below wild-memory-access bug.

The mod->state state machine when load_module() succeeds:

MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
	 ^						|
	 |						| delete_module
	 +---------------- MODULE_STATE_GOING <---------+

The mod->state state machine when load_module() fails at
mod_sysfs_setup():

MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
	^						|
	|						|
	+-----------------------------------------------+

Call kunit_module_init() at MODULE_STATE_COMING state to fix the issue
because MODULE_STATE_LIVE is transformed from it.

 Unable to handle kernel paging request at virtual address ffffff341e942a88
 KASAN: maybe wild-memory-access in range [0x0003f9a0f4a15440-0x0003f9a0f4a15447]
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000441ea000
 [ffffff341e942a88] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
 Modules linked in: kunit_example_test(-) cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
 CPU: 3 PID: 2035 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230828+ #136
 Hardware name: linux,dummy-virt (DT)
 pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kfree+0x2c/0x70
 lr : kunit_free_suite_set+0xcc/0x13c
 sp : ffff8000829b75b0
 x29: ffff8000829b75b0 x28: ffff8000829b7b90 x27: 0000000000000000
 x26: dfff800000000000 x25: ffffcd07c82a7280 x24: ffffcd07a50ab300
 x23: ffffcd07a50ab2e8 x22: 1ffff00010536ec0 x21: dfff800000000000
 x20: ffffcd07a50ab2f0 x19: ffffcd07a50ab2f0 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: ffffcd07c24b6764
 x14: ffffcd07c24b63c0 x13: ffffcd07c4cebb94 x12: ffff700010536ec7
 x11: 1ffff00010536ec6 x10: ffff700010536ec6 x9 : dfff800000000000
 x8 : 00008fffefac913a x7 : 0000000041b58ab3 x6 : 0000000000000000
 x5 : 1ffff00010536ec5 x4 : ffff8000829b7628 x3 : dfff800000000000
 x2 : ffffff341e942a80 x1 : ffffcd07a50aa000 x0 : fffffc0000000000
 Call trace:
  kfree+0x2c/0x70
  kunit_free_suite_set+0xcc/0x13c
  kunit_module_notify+0xd8/0x360
  blocking_notifier_call_chain+0xc4/0x128
  load_module+0x382c/0x44a4
  init_module_from_file+0xd4/0x128
  idempotent_init_module+0x2c8/0x524
  __arm64_sys_finit_module+0xac/0x100
  invoke_syscall+0x6c/0x258
  el0_svc_common.constprop.0+0x160/0x22c
  do_el0_svc+0x44/0x5c
  el0_svc+0x38/0x78
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194
 Code: aa0003e1 b25657e0 d34cfc42 8b021802 (f9400440)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x4d0742200000 from 0xffff800080000000
 PHYS_OFFSET: 0xffffee43c0000000
 CPU features: 0x88000203,3c020000,1000421b
 Memory Limit: none
 Rebooting in 1 seconds..

Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 84e4666555c94..e8c9dd9d73a30 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -744,12 +744,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
-		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
+		kunit_module_init(mod);
+		break;
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-- 
2.40.1



