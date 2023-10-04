Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534E7B894D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbjJDSYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbjJDSYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD5C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2E6C433C9;
        Wed,  4 Oct 2023 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443871;
        bh=FXEGiW3QwvFjgFTmrjMr26NQPI2iAvE3NkBHSMGCk9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpZ6YmxHivWAIGc+gZ/7iNFywAJOsKL/9gF4PD+ssbLQp/htsWWnveFsombf1dj3K
         O7azHownMMs9BTDZRKK6qJ0zUFPLqDj4X5TgpfWrcNo7qMN5MA8fulltfqGW2MrAGi
         C63zja9B6R/KS3OgkD4/oRgW1nN3okDgAmhZCkqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 049/321] net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()
Date:   Wed,  4 Oct 2023 19:53:14 +0200
Message-ID: <20231004175231.436101598@linuxfoundation.org>
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

[ Upstream commit 89e3af0277388f32d56915a6715c735e4afae5d6 ]

Inject fault while probing kunit-example-test.ko, the duprule which
is allocated in vcap_dup_rule() and the vcap enabled port which
is allocated in vcap_enable() of vcap_enable_lookups in
vcap_api_encode_rule_test() is not freed, and it cause the memory
leaks below.

Use vcap_enable_lookups() with false arg to free the vcap enabled
port as other drivers do it. And use vcap_del_rule() to
free the duprule.

unreferenced object 0xffff677a0278bb00 (size 64):
  comm "kunit_try_catch", pid 388, jiffies 4294895987 (age 1101.840s)
  hex dump (first 32 bytes):
    18 bd a5 82 00 80 ff ff 18 bd a5 82 00 80 ff ff  ................
    40 fe c8 0e be c6 ff ff 00 00 00 00 00 00 00 00  @...............
  backtrace:
    [<000000007d53023a>] slab_post_alloc_hook+0xb8/0x368
    [<0000000076e3f654>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000034d76721>] kmalloc_trace+0x40/0x164
    [<00000000013380a5>] vcap_enable_lookups+0x1c8/0x70c
    [<00000000bbec496b>] vcap_api_encode_rule_test+0x2f8/0xb18
    [<000000002c2bfb7b>] kunit_try_run_case+0x50/0xac
    [<00000000ff74642b>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<000000004af845ca>] kthread+0x124/0x130
    [<0000000038a000ca>] ret_from_fork+0x10/0x20
unreferenced object 0xffff677a027803c0 (size 192):
  comm "kunit_try_catch", pid 388, jiffies 4294895988 (age 1101.836s)
  hex dump (first 32 bytes):
    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
    00 00 00 00 00 00 00 00 d8 03 78 02 7a 67 ff ff  ..........x.zg..
  backtrace:
    [<000000007d53023a>] slab_post_alloc_hook+0xb8/0x368
    [<0000000076e3f654>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000034d76721>] kmalloc_trace+0x40/0x164
    [<00000000c1010131>] vcap_dup_rule+0x34/0x14c
    [<00000000d43c54a4>] vcap_add_rule+0x29c/0x32c
    [<0000000073f1c26d>] vcap_api_encode_rule_test+0x304/0xb18
    [<000000002c2bfb7b>] kunit_try_run_case+0x50/0xac
    [<00000000ff74642b>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<000000004af845ca>] kthread+0x124/0x130
    [<0000000038a000ca>] ret_from_fork+0x10/0x20

Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index f268383a75707..8c61a5dbce55f 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1439,6 +1439,10 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 	ret = list_empty(&is2_admin.rules);
 	KUNIT_EXPECT_EQ(test, false, ret);
 	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	vcap_enable_lookups(&test_vctrl, &test_netdev, 0, 0,
+			    rule->cookie, false);
+
 	vcap_free_rule(rule);
 
 	/* Check that the rule has been freed: tricky to access since this
@@ -1449,6 +1453,8 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, true, ret);
 	ret = list_empty(&rule->actionfields);
 	KUNIT_EXPECT_EQ(test, true, ret);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, id);
 }
 
 static void vcap_api_set_rule_counter_test(struct kunit *test)
-- 
2.40.1



