Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B87B3D3B
	for <lists+stable@lfdr.de>; Sat, 30 Sep 2023 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjI3AVh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 20:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjI3AV3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 20:21:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44501B1;
        Fri, 29 Sep 2023 17:21:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6A9C433C7;
        Sat, 30 Sep 2023 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696033286;
        bh=0VpC8Ck4QACR0UT/vB/uYef0P+ahdInotOaCj5B7X5E=;
        h=Date:To:From:Subject:From;
        b=krB86km1W2Txu671EyxuKiJYNGcojNXiNZY4a8EouitnKst4jQ8tsd0utw88DI0o2
         Sd+M1ITnrZc2X8QqGCIyIbeLysFrKquxt8wP8VIJ7AADF5PXMIGLqc9W8P10ri8vBW
         QhJEGcm+BSlRA8LF5H7Bkkzpopw+39Ye07psnOTI=
Date:   Fri, 29 Sep 2023 17:21:25 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        ruanjinjie@huawei.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-vaddr-test-fix-memory-leak-in-damon_do_test_apply_three_regions.patch removed from -mm tree
Message-Id: <20230930002126.4D6A9C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
has been removed from the -mm tree.  Its filename was
     mm-damon-vaddr-test-fix-memory-leak-in-damon_do_test_apply_three_regions.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Jinjie Ruan <ruanjinjie@huawei.com>
Subject: mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
Date: Mon, 25 Sep 2023 15:20:59 +0800

When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.

Since commit 9f86d624292c ("mm/damon/vaddr-test: remove unnecessary
variables"), the damon_destroy_ctx() is removed, but still call
damon_new_target() and damon_new_region(), the damon_region which is
allocated by kmem_cache_alloc() in damon_new_region() and the damon_target
which is allocated by kmalloc in damon_new_target() are not freed.  And
the damon_region which is allocated in damon_new_region() in
damon_set_regions() is also not freed.

So use damon_destroy_target to free all the damon_regions and damon_target.

    unreferenced object 0xffff888107c9a940 (size 64):
      comm "kunit_try_catch", pid 1069, jiffies 4294670592 (age 732.761s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 06 00 00 00 6b 6b 6b 6b  ............kkkk
        60 c7 9c 07 81 88 ff ff f8 cb 9c 07 81 88 ff ff  `...............
      backtrace:
        [<ffffffff817e0167>] kmalloc_trace+0x27/0xa0
        [<ffffffff819c11cf>] damon_new_target+0x3f/0x1b0
        [<ffffffff819c7d55>] damon_do_test_apply_three_regions.constprop.0+0x95/0x3e0
        [<ffffffff819c82be>] damon_test_apply_three_regions1+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff8881079cc740 (size 56):
      comm "kunit_try_catch", pid 1069, jiffies 4294670592 (age 732.761s)
      hex dump (first 32 bytes):
        05 00 00 00 00 00 00 00 14 00 00 00 00 00 00 00  ................
        6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b  kkkkkkkk....kkkk
      backtrace:
        [<ffffffff819bc492>] damon_new_region+0x22/0x1c0
        [<ffffffff819c7d91>] damon_do_test_apply_three_regions.constprop.0+0xd1/0x3e0
        [<ffffffff819c82be>] damon_test_apply_three_regions1+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff888107c9ac40 (size 64):
      comm "kunit_try_catch", pid 1071, jiffies 4294670595 (age 732.843s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 06 00 00 00 6b 6b 6b 6b  ............kkkk
        a0 cc 9c 07 81 88 ff ff 78 a1 76 07 81 88 ff ff  ........x.v.....
      backtrace:
        [<ffffffff817e0167>] kmalloc_trace+0x27/0xa0
        [<ffffffff819c11cf>] damon_new_target+0x3f/0x1b0
        [<ffffffff819c7d55>] damon_do_test_apply_three_regions.constprop.0+0x95/0x3e0
        [<ffffffff819c851e>] damon_test_apply_three_regions2+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff8881079ccc80 (size 56):
      comm "kunit_try_catch", pid 1071, jiffies 4294670595 (age 732.843s)
      hex dump (first 32 bytes):
        05 00 00 00 00 00 00 00 14 00 00 00 00 00 00 00  ................
        6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b  kkkkkkkk....kkkk
      backtrace:
        [<ffffffff819bc492>] damon_new_region+0x22/0x1c0
        [<ffffffff819c7d91>] damon_do_test_apply_three_regions.constprop.0+0xd1/0x3e0
        [<ffffffff819c851e>] damon_test_apply_three_regions2+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff888107c9af40 (size 64):
      comm "kunit_try_catch", pid 1073, jiffies 4294670597 (age 733.011s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 06 00 00 00 6b 6b 6b 6b  ............kkkk
        20 a2 76 07 81 88 ff ff b8 a6 76 07 81 88 ff ff   .v.......v.....
      backtrace:
        [<ffffffff817e0167>] kmalloc_trace+0x27/0xa0
        [<ffffffff819c11cf>] damon_new_target+0x3f/0x1b0
        [<ffffffff819c7d55>] damon_do_test_apply_three_regions.constprop.0+0x95/0x3e0
        [<ffffffff819c877e>] damon_test_apply_three_regions3+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff88810776a200 (size 56):
      comm "kunit_try_catch", pid 1073, jiffies 4294670597 (age 733.011s)
      hex dump (first 32 bytes):
        05 00 00 00 00 00 00 00 14 00 00 00 00 00 00 00  ................
        6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b  kkkkkkkk....kkkk
      backtrace:
        [<ffffffff819bc492>] damon_new_region+0x22/0x1c0
        [<ffffffff819c7d91>] damon_do_test_apply_three_regions.constprop.0+0xd1/0x3e0
        [<ffffffff819c877e>] damon_test_apply_three_regions3+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff88810776a740 (size 56):
      comm "kunit_try_catch", pid 1073, jiffies 4294670597 (age 733.025s)
      hex dump (first 32 bytes):
        3d 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00  =.......?.......
        6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b  kkkkkkkk....kkkk
      backtrace:
        [<ffffffff819bc492>] damon_new_region+0x22/0x1c0
        [<ffffffff819bfcc2>] damon_set_regions+0x4c2/0x8e0
        [<ffffffff819c7dbb>] damon_do_test_apply_three_regions.constprop.0+0xfb/0x3e0
        [<ffffffff819c877e>] damon_test_apply_three_regions3+0x21e/0x260
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff888108038240 (size 64):
      comm "kunit_try_catch", pid 1075, jiffies 4294670600 (age 733.022s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 03 00 00 00 6b 6b 6b 6b  ............kkkk
        48 ad 76 07 81 88 ff ff 98 ae 76 07 81 88 ff ff  H.v.......v.....
      backtrace:
        [<ffffffff817e0167>] kmalloc_trace+0x27/0xa0
        [<ffffffff819c11cf>] damon_new_target+0x3f/0x1b0
        [<ffffffff819c7d55>] damon_do_test_apply_three_regions.constprop.0+0x95/0x3e0
        [<ffffffff819c898d>] damon_test_apply_three_regions4+0x1cd/0x210
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20
    unreferenced object 0xffff88810776ad28 (size 56):
      comm "kunit_try_catch", pid 1075, jiffies 4294670600 (age 733.022s)
      hex dump (first 32 bytes):
        05 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
        6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b  kkkkkkkk....kkkk
      backtrace:
        [<ffffffff819bc492>] damon_new_region+0x22/0x1c0
        [<ffffffff819bfcc2>] damon_set_regions+0x4c2/0x8e0
        [<ffffffff819c7dbb>] damon_do_test_apply_three_regions.constprop.0+0xfb/0x3e0
        [<ffffffff819c898d>] damon_test_apply_three_regions4+0x1cd/0x210
        [<ffffffff829fce6a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
        [<ffffffff81237cf6>] kthread+0x2b6/0x380
        [<ffffffff81097add>] ret_from_fork+0x2d/0x70
        [<ffffffff81003791>] ret_from_fork_asm+0x11/0x20

Link: https://lkml.kernel.org/r/20230925072100.3725620-1-ruanjinjie@huawei.com
Fixes: 9f86d624292c ("mm/damon/vaddr-test: remove unnecessary variables")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/vaddr-test.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/damon/vaddr-test.h~mm-damon-vaddr-test-fix-memory-leak-in-damon_do_test_apply_three_regions
+++ a/mm/damon/vaddr-test.h
@@ -148,6 +148,8 @@ static void damon_do_test_apply_three_re
 		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
+
+	damon_destroy_target(t);
 }
 
 /*
_

Patches currently in -mm which might be from ruanjinjie@huawei.com are

mm-damon-core-test-fix-memory-leak-in-damon_new_region.patch
mm-damon-core-test-fix-memory-leak-in-damon_new_ctx.patch

