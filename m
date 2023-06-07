Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE759726C8C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjFGUeY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjFGUeY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FD26A8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CF16454F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5480FC433D2;
        Wed,  7 Jun 2023 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170048;
        bh=/+eUa5+kn7ehQg7vebjwO8mF29PC1S1ROSXCn1Sgacs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ckC7AShKVLx7xDHbg02GjAgJaztzxY8dyUZ9zXiGr3tRI5uWQvFlGT0Y64kZkDnI
         AuwKcglPHakrjTh2Ug0wJgQ+cfujIjcUA2Ub5RCYGqHqV9++z2BX+biHvDdVbQk/EZ
         hhVDJ3SQV37QYKiX83Htv5MxG10fsxdR7RMMp6ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/88] power: supply: bq24190: Call power_supply_changed() after updating input current
Date:   Wed,  7 Jun 2023 22:15:22 +0200
Message-ID: <20230607200855.936951187@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
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

[ Upstream commit 77c2a3097d7029441e8a91aa0de1b4e5464593da ]

The bq24192 model relies on external charger-type detection and once
that is done the bq24190_charger code will update the input current.

In this case, when the initial power_supply_changed() call is made
from the interrupt handler, the input settings are 5V/0.5A which
on many devices is not enough power to charge (while the device is on).

On many devices the fuel-gauge relies in its external_power_changed
callback to timely signal userspace about charging <-> discharging
status changes. Add a power_supply_changed() call after updating
the input current. This allows the fuel-gauge driver to timely recheck
if the battery is charging after the new input current has been applied
and then it can immediately notify userspace about this.

Fixes: 18f8e6f695ac ("power: supply: bq24190_charger: Get input_current_limit from our supplier")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4859f82d7ef22..1a3624141c411 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1240,6 +1240,7 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	bq24190_charger_set_property(bdi->charger,
 				     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 				     &val);
+	power_supply_changed(bdi->charger);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
-- 
2.39.2



