Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BF713E5F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjE1TfK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjE1TfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677C10A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A1861DFD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2E8C433EF;
        Sun, 28 May 2023 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302492;
        bh=CKaavuVwpesSYcF8tqwT9QrLkyFKL6cCL28Tl2heQUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wP76KX714BOxIULDKrR6QP/5rBdmrl0k1mDyGEL3N/MpPVoMy2xFIOVdMDevNm9RF
         yPM5yoLI8wdYUT/5Wu82dGeIibHlz7Xh89UdMQQiI396PeRLW4p8ESS5J0Zol6F/nT
         aaXFjgibkKw+KOIIfx+q/x8MtREn/TapEqDUlSZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 025/119] power: supply: axp288_fuel_gauge: Fix external_power_changed race
Date:   Sun, 28 May 2023 20:10:25 +0100
Message-Id: <20230528190836.182826520@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
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

commit f8319774d6f1567d6e7d03653174ab0c82c5c66d upstream.

fuel_gauge_external_power_changed() dereferences info->bat,
which gets sets in axp288_fuel_gauge_probe() like this:

  info->bat = devm_power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where fuel_gauge_external_power_changed() may get called while
info->bat has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in info->bat,
so fuel_gauge_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

Fixes: 30abb3d07929 ("power: supply: axp288_fuel_gauge: Take lock before updating the valid flag")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/axp288_fuel_gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 05f413178462..3be6f3b10ea4 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -507,7 +507,7 @@ static void fuel_gauge_external_power_changed(struct power_supply *psy)
 	mutex_lock(&info->lock);
 	info->valid = 0; /* Force updating of the cached registers */
 	mutex_unlock(&info->lock);
-	power_supply_changed(info->bat);
+	power_supply_changed(psy);
 }
 
 static struct power_supply_desc fuel_gauge_desc = {
-- 
2.40.1



