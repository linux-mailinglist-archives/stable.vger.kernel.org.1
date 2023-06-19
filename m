Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E323735211
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFSKaI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFSKaH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA01CA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D0C60B3E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C88BC433C0;
        Mon, 19 Jun 2023 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170605;
        bh=IMSxW+BwXyy3mU+PMSOaQL+UkXZIvUYyfiSk3WvHIoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPHwlWYLPqT8u8zXdROwTSuqtc8haDT2Q7Lc0BkoEa57qny7mZvtWS1bo2ordxjnE
         RX9sHcE64aWUe0nznuTBY/swD8YcmT0/2XPdjx+kpuZA7ws0nqtSpKclAHaA0ftcKF
         /Kz7CD9nokL0aYiX9yc09LocqDHqxUlTrY6WPPS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <Evan.Quan@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/32] power: supply: Fix logic checking if system is running from battery
Date:   Mon, 19 Jun 2023 12:28:54 +0200
Message-ID: <20230619102127.828493927@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
References: <20230619102127.461443957@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 95339f40a8b652b5b1773def31e63fc53c26378a ]

The logic used for power_supply_is_system_supplied() counts all power
supplies and assumes that the system is running from AC if there is
either a non-battery power-supply reporting to be online or if no
power-supplies exist at all.

The second rule is for desktop systems, that don't have any
battery/charger devices. These systems will incorrectly report to be
powered from battery once a device scope power-supply is registered
(e.g. a HID device), since these power-supplies increase the counter.

Apart from HID devices, recent dGPUs provide UCSI power supplies on a
desktop systems. The dGPU by default doesn't have anything plugged in so
it's 'offline'. This makes power_supply_is_system_supplied() return 0
with a count of 1 meaning all drivers that use this get a wrong judgement.

To fix this case adjust the logic to also examine the scope of the power
supply. If the power supply is deemed a device power supply, then don't
count it.

Cc: Evan Quan <Evan.Quan@amd.com>
Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 409ecff1a51a7..67766b500325f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -349,6 +349,10 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
+	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
+		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
+			return 0;
+
 	(*count)++;
 	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
 		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
@@ -367,8 +371,8 @@ int power_supply_is_system_supplied(void)
 				      __power_supply_is_system_supplied);
 
 	/*
-	 * If no power class device was found at all, most probably we are
-	 * running on a desktop system, so assume we are on mains power.
+	 * If no system scope power class device was found at all, most probably we
+	 * are running on a desktop system, so assume we are on mains power.
 	 */
 	if (count == 0)
 		return 1;
-- 
2.39.2



