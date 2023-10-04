Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB9F7B894F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbjJDSYm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjJDSYl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897FA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E6C433C8;
        Wed,  4 Oct 2023 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443877;
        bh=qJMefuaV4J3Dv2BJ1ns09N/pb/5z5CgccdFmLDCJrlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fecDCqPBg/wdfQiGleuYpm4ddL8HC/SfGSQU44nuBBXoag9KEphfEdKl7qBlGMrqc
         v8K7IY1TPUTWJMiQeMulsvR9N4FbmOq++ToxJRP3OnaMiERNSoUkwcDa5KqwmzwfXh
         xm+Fc76UerY9VVAvk3IwFzbURq3fTSvkN//EI44o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 051/321] net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
Date:   Wed,  4 Oct 2023 19:53:16 +0200
Message-ID: <20231004175231.525169131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

[ Upstream commit 2a2dffd911d4139258b828b9c5056cb64b826758 ]

Inject fault while probing kunit-example-test.ko, the duprule which
is allocated by kzalloc in vcap_dup_rule() of
test_vcap_xn_rule_creator() is not freed, and it cause the memory leaks
below. Use vcap_del_rule() to free them as other functions do it.

unreferenced object 0xffff6eb4846f6180 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895522 (age 880.004s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 0a 00 00 00 f4 01 00 00  .'..............
    00 00 00 00 00 00 00 00 98 61 6f 84 b4 6e ff ff  .........ao..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000d2ac4ccb>] vcap_api_rule_insert_in_order_test+0xa4/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f6240 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 879.996s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 90 01 00 00  .'..............
    00 00 00 00 00 00 00 00 58 62 6f 84 b4 6e ff ff  ........Xbo..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<0000000052e6ad35>] vcap_api_rule_insert_in_order_test+0xbc/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f6300 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 879.996s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 18 63 6f 84 b4 6e ff ff  .........co..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<000000001b0895d4>] vcap_api_rule_insert_in_order_test+0xd4/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f63c0 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 880.012s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 c8 00 00 00  .'......(.......
    00 00 00 00 00 00 00 00 d8 63 6f 84 b4 6e ff ff  .........co..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000134c151f>] vcap_api_rule_insert_in_order_test+0xec/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc180 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 c8 00 00 00  .'..............
    00 00 00 00 00 00 00 00 98 c1 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000fa5f64d3>] vcap_api_rule_insert_reverse_order_test+0xc8/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc240 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 58 c2 5f 84 b4 6e ff ff  ........X._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000a7db42de>] vcap_api_rule_insert_reverse_order_test+0x108/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc300 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 90 01 00 00  .'......(.......
    00 00 00 00 00 00 00 00 18 c3 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000ea416c94>] vcap_api_rule_insert_reverse_order_test+0x150/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc3c0 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.020s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 32 00 00 00 f4 01 00 00  .'......2.......
    00 00 00 00 00 00 00 00 d8 c3 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000764a39b4>] vcap_api_rule_insert_reverse_order_test+0x198/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb484cd4240 (size 192):
  comm "kunit_try_catch", pid 413, jiffies 4294895543 (age 879.956s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 58 42 cd 84 b4 6e ff ff  ........XB...n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<0000000023976dd4>] vcap_api_rule_remove_in_front_test+0x158/0x658
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb484cd4300 (size 192):
  comm "kunit_try_catch", pid 413, jiffies 4294895543 (age 879.956s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 c8 00 00 00  .'......(.......
    00 00 00 00 00 00 00 00 18 43 cd 84 b4 6e ff ff  .........C...n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<000000000b4760ff>] vcap_api_rule_remove_in_front_test+0x170/0x658
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20

Fixes: dccc30cc4906 ("net: microchip: sparx5: Add KUNIT test of counters and sorted rules")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 99f04a53a442b..fe4e166de8a04 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1597,6 +1597,11 @@ static void vcap_api_rule_insert_in_order_test(struct kunit *test)
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 400, 6, 774);
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 771);
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 200, 2, 768);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
+	vcap_del_rule(&test_vctrl, &test_netdev, 400);
+	vcap_del_rule(&test_vctrl, &test_netdev, 500);
 }
 
 static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
@@ -1655,6 +1660,11 @@ static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
 		++idx;
 	}
 	KUNIT_EXPECT_EQ(test, 768, admin.last_used_addr);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 500);
+	vcap_del_rule(&test_vctrl, &test_netdev, 400);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
 }
 
 static void vcap_api_rule_remove_at_end_test(struct kunit *test)
@@ -1855,6 +1865,9 @@ static void vcap_api_rule_remove_in_front_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 786, test_init_start);
 	KUNIT_EXPECT_EQ(test, 8, test_init_count);
 	KUNIT_EXPECT_EQ(test, 794, admin.last_used_addr);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
 }
 
 static struct kunit_case vcap_api_rule_remove_test_cases[] = {
-- 
2.40.1



