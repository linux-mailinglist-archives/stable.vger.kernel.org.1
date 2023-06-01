Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A2719D7E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjFANXx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjFANXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ABD1B5
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5722E64469
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FEAC433EF;
        Thu,  1 Jun 2023 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625820;
        bh=ncWtDGqcy0qJCKDJ2tPDV5aK6Txdd060JRdohn/53eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHoUag5qIYElYfMqEjZAKCz062KrWQsKpOpDo5WTiB7u1qnrqjDUjAJZiB1DvsX9y
         lmg0yffqrljmjb+UzXHZBh9CAAFDjuSKbJXRz9laxs4g3h0mHZVctFnPBcuMjecO8/
         JOb4pzTT6tpGAojbT5fT3EBkVEHdfkGTk3t1AK5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 10/22] power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
Date:   Thu,  1 Jun 2023 14:21:08 +0100
Message-Id: <20230601131934.216000375@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
References: <20230601131933.727832920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8984f66bd2bc3..235647b21af71 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2022,8 +2022,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
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



