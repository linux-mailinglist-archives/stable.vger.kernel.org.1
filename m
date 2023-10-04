Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBACF7B8AAB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjJDShl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbjJDShj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38865C6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71581C433C7;
        Wed,  4 Oct 2023 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444655;
        bh=a7E03Y7soHooSTbwByKqnomtkGOh7ABeEdRyVJhcbDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpv6vpFq5M3R8YDPJtg0eFnX/XlNGpiXID1jVNruDaPxUzzvNK9KQdEph+3v4pj15
         6bAvAfLxhsNY4OljjnKByD1GrJiAg8bRskWa7CW4WImDqOTu6BoY3YMNenjKJFqCYu
         WLc7gFO+Z2KV44xawtjBks54M0pqD+QDqpKpgnvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Hansson <newbyte@disroot.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.5 310/321] power: supply: ab8500: Set typing and props
Date:   Wed,  4 Oct 2023 19:57:35 +0200
Message-ID: <20231004175243.659066897@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

commit dc77721ea4aa1e8937e2436f230b5a69065cc508 upstream.

I had the following weird phenomena on a mobile phone: while
the capacity in /sys/class/power_supply/ab8500_fg/capacity
would reflect the actual charge and capacity of the battery,
only 1/3 of the value was shown on the battery status
indicator and warnings for low battery appeared.

It turns out that UPower, the Freedesktop power daemon,
will average all the power supplies of type "battery" in
/sys/class/power_supply/* if there is more than one battery.

For the AB8500, there was "battery" ab8500_fg, ab8500_btemp
and ab8500_chargalg. The latter two don't know anything
about the battery, and should not be considered. They were
however averaged and with the capacity of 0.

Flag ab8500_btemp and ab8500_chargalg with type "unknown"
so they are not averaged as batteries.

Remove the technology prop from ab8500_btemp as well, all
it does is snoop in on knowledge from another supply.

After this the battery indicator shows the right value.

Cc: Stefan Hansson <newbyte@disroot.org>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ab8500_btemp.c    |    9 +--------
 drivers/power/supply/ab8500_chargalg.c |    2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -115,7 +115,6 @@ struct ab8500_btemp {
 static enum power_supply_property ab8500_btemp_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_TEMP,
 };
 
@@ -532,12 +531,6 @@ static int ab8500_btemp_get_property(str
 		else
 			val->intval = 1;
 		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		if (di->bm->bi)
-			val->intval = di->bm->bi->technology;
-		else
-			val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = ab8500_btemp_get_temp(di);
 		break;
@@ -662,7 +655,7 @@ static char *supply_interface[] = {
 
 static const struct power_supply_desc ab8500_btemp_desc = {
 	.name			= "ab8500_btemp",
-	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.type			= POWER_SUPPLY_TYPE_UNKNOWN,
 	.properties		= ab8500_btemp_props,
 	.num_properties		= ARRAY_SIZE(ab8500_btemp_props),
 	.get_property		= ab8500_btemp_get_property,
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1720,7 +1720,7 @@ static char *supply_interface[] = {
 
 static const struct power_supply_desc ab8500_chargalg_desc = {
 	.name			= "ab8500_chargalg",
-	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.type			= POWER_SUPPLY_TYPE_UNKNOWN,
 	.properties		= ab8500_chargalg_props,
 	.num_properties		= ARRAY_SIZE(ab8500_chargalg_props),
 	.get_property		= ab8500_chargalg_get_property,


