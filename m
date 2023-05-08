Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7B6FA5BD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjEHKMy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjEHKMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F093988D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61536623F0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC7C433EF;
        Mon,  8 May 2023 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540755;
        bh=i3y76EWp5NGs1WkLc1DvpsMEnYO7+/5ydEuK5KyTw/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkwG/lew6+Quv1XexAp+5mBa8hpJkMChGZMyXt8zlIMubxME+OnPt6idl813QKVAC
         kw36PaOR3lfUjhPxHZ2B2WfsUFYz1RvByRoVPLZtjL0k1Qb6c8cJyEOjIswIFmljmd
         eUbPYULLT4zsdK06mJdTqMRfQ1z4YaCg1JfbXRto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 453/611] spmi: Add a check for remove callback when removing a SPMI driver
Date:   Mon,  8 May 2023 11:44:55 +0200
Message-Id: <20230508094436.881772102@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jishnu Prakash <quic_jprakash@quicinc.com>

[ Upstream commit b56eef3e16d888883fefab47425036de80dd38fc ]

When removing a SPMI driver, there can be a crash due to NULL pointer
dereference if it does not have a remove callback defined. This is
one such call trace observed when removing the QCOM SPMI PMIC driver:

 dump_backtrace.cfi_jt+0x0/0x8
 dump_stack_lvl+0xd8/0x16c
 panic+0x188/0x498
 __cfi_slowpath+0x0/0x214
 __cfi_slowpath+0x1dc/0x214
 spmi_drv_remove+0x16c/0x1e0
 device_release_driver_internal+0x468/0x79c
 driver_detach+0x11c/0x1a0
 bus_remove_driver+0xc4/0x124
 driver_unregister+0x58/0x84
 cleanup_module+0x1c/0xc24 [qcom_spmi_pmic]
 __do_sys_delete_module+0x3ec/0x53c
 __arm64_sys_delete_module+0x18/0x28
 el0_svc_common+0xdc/0x294
 el0_svc+0x38/0x9c
 el0_sync_handler+0x8c/0xf0
 el0_sync+0x1b4/0x1c0

If a driver has all its resources allocated through devm_() APIs and
does not need any other explicit cleanup, it would not require a
remove callback to be defined. Hence, add a check for remove callback
presence before calling it when removing a SPMI driver.

Link: https://lore.kernel.org/r/1671601032-18397-2-git-send-email-quic_jprakash@quicinc.com
Fixes: 6f00f8c8635f ("mfd: qcom-spmi-pmic: Use devm_of_platform_populate()")
Fixes: 5a86bf343976 ("spmi: Linux driver framework for SPMI")
Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20230413223834.4084793-7-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spmi/spmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 55381592bb5a6..e73d3017863cb 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -350,7 +350,8 @@ static void spmi_drv_remove(struct device *dev)
 	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
 
 	pm_runtime_get_sync(dev);
-	sdrv->remove(to_spmi_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_spmi_device(dev));
 	pm_runtime_put_noidle(dev);
 
 	pm_runtime_disable(dev);
-- 
2.39.2



