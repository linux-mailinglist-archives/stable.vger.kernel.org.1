Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744E73E91B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjFZSco (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjFZSc3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB39DC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DD260F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EF2C433C0;
        Mon, 26 Jun 2023 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804341;
        bh=smyZdL5ee86kJ3+kmLSfZD3L3ijeQnQ7ASqNsAvwRuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFs8YVy93P/TWfuMGlYJ7TMQnByrxs/v8wwWmQaSp5c6GyvY8vMFuz5EzTxZFM4Ny
         9t2k7EMnYSGUjWTLk3qP577OkJ0ZY8AT7hM70cPJlw97RL9yXqj2Kks89bS8LwSomH
         cChROy6Ba5prYLUCy7mXldObikV1Xwca4NpwAZ74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Allen Zhong <allen@atr.me>,
        Patil Rajesh Reddy <Patil.Reddy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 124/170] platform/x86/amd/pmf: Register notify handler only if SPS is enabled
Date:   Mon, 26 Jun 2023 20:11:33 +0200
Message-ID: <20230626180806.120531206@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 146b6f6855e7656e8329910606595220c761daac ]

Power source notify handler is getting registered even when none of the
PMF feature in enabled leading to a crash.

...
[   22.592162] Call Trace:
[   22.592164]  <TASK>
[   22.592164]  ? rcu_note_context_switch+0x5e0/0x660
[   22.592166]  ? __warn+0x81/0x130
[   22.592171]  ? rcu_note_context_switch+0x5e0/0x660
[   22.592172]  ? report_bug+0x171/0x1a0
[   22.592175]  ? prb_read_valid+0x1b/0x30
[   22.592177]  ? handle_bug+0x3c/0x80
[   22.592178]  ? exc_invalid_op+0x17/0x70
[   22.592179]  ? asm_exc_invalid_op+0x1a/0x20
[   22.592182]  ? rcu_note_context_switch+0x5e0/0x660
[   22.592183]  ? acpi_ut_delete_object_desc+0x86/0xb0
[   22.592186]  ? acpi_ut_update_ref_count.part.0+0x22d/0x930
[   22.592187]  __schedule+0xc0/0x1410
[   22.592189]  ? ktime_get+0x3c/0xa0
[   22.592191]  ? lapic_next_event+0x1d/0x30
[   22.592193]  ? hrtimer_start_range_ns+0x25b/0x350
[   22.592196]  schedule+0x5e/0xd0
[   22.592197]  schedule_hrtimeout_range_clock+0xbe/0x140
[   22.592199]  ? __pfx_hrtimer_wakeup+0x10/0x10
[   22.592200]  usleep_range_state+0x64/0x90
[   22.592203]  amd_pmf_send_cmd+0x106/0x2a0 [amd_pmf bddfe0fe3712aaa99acce3d5487405c5213c6616]
[   22.592207]  amd_pmf_update_slider+0x56/0x1b0 [amd_pmf bddfe0fe3712aaa99acce3d5487405c5213c6616]
[   22.592210]  amd_pmf_set_sps_power_limits+0x72/0x80 [amd_pmf bddfe0fe3712aaa99acce3d5487405c5213c6616]
[   22.592213]  amd_pmf_pwr_src_notify_call+0x49/0x90 [amd_pmf bddfe0fe3712aaa99acce3d5487405c5213c6616]
[   22.592216]  notifier_call_chain+0x5a/0xd0
[   22.592218]  atomic_notifier_call_chain+0x32/0x50
...

Fix this by moving the registration of source change notify handler only
when SPS(Static Slider) is advertised as supported.

Reported-by: Allen Zhong <allen@atr.me>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217571
Fixes: 4c71ae414474 ("platform/x86/amd/pmf: Add support SPS PMF feature")
Tested-by: Patil Rajesh Reddy <Patil.Reddy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230622060309.310001-1-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index dc9803e1a4b9b..73d2357e32f8e 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -297,6 +297,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 	/* Enable Static Slider */
 	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
 		amd_pmf_init_sps(dev);
+		dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
+		power_supply_reg_notifier(&dev->pwr_src_notifier);
 		dev_dbg(dev->dev, "SPS enabled and Platform Profiles registered\n");
 	}
 
@@ -315,8 +317,10 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 
 static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 {
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR))
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		power_supply_unreg_notifier(&dev->pwr_src_notifier);
 		amd_pmf_deinit_sps(dev);
+	}
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_AUTO_MODE)) {
 		amd_pmf_deinit_auto_mode(dev);
@@ -399,9 +403,6 @@ static int amd_pmf_probe(struct platform_device *pdev)
 	apmf_install_handler(dev);
 	amd_pmf_dbgfs_register(dev);
 
-	dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
-	power_supply_reg_notifier(&dev->pwr_src_notifier);
-
 	dev_info(dev->dev, "registered PMF device successfully\n");
 
 	return 0;
@@ -411,7 +412,6 @@ static int amd_pmf_remove(struct platform_device *pdev)
 {
 	struct amd_pmf_dev *dev = platform_get_drvdata(pdev);
 
-	power_supply_unreg_notifier(&dev->pwr_src_notifier);
 	amd_pmf_deinit_features(dev);
 	apmf_acpi_deinit(dev);
 	amd_pmf_dbgfs_unregister(dev);
-- 
2.39.2



