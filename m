Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F4726AAC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjFGUTP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjFGUTF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370326A1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B8860F15
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A56C433EF;
        Wed,  7 Jun 2023 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169084;
        bh=SftzRtwTEFPiZgJQTcW27XiDG/Ojd+U3IFwd4o4KdNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpvJAZYrzt/UoWkFryYvC4XbfJVoH1deQy+2G0rA/4sitd8JtXBbxGaQIjuaRfNiC
         0WXFkbCMUPRwl5JIRbyRGddOQqHLSbMiPZfiLCFyVdZcYXNfvlsEoFt/IZut3v2z70
         SNFS2v1Cd3WStCzQPrKnNQTjhXFYc3bK3o8DBRpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/61] power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
Date:   Wed,  7 Jun 2023 22:15:15 +0200
Message-ID: <20230607200835.697886180@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 59a99cd462fbdf71f4e845e09f37783035088b4f ]

bq27xxx_external_power_changed() gets called when the charger is plugged
in or out. Rather then immediately scheduling an update wait 0.5 seconds
for things to stabilize, so that e.g. the (dis)charge current is stable
when bq27xxx_battery_update() runs.

Fixes: 740b755a3b34 ("bq27x00: Poll battery state")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 37b5743ce35e4..49d351027d0e8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1817,8 +1817,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->work);
-	schedule_delayed_work(&di->work, 0);
+	/* After charger plug in/out wait 0.5s for things to stabilize */
+	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
-- 
2.39.2



