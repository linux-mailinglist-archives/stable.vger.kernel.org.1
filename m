Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68397713F8F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjE1Tqz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjE1Tqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA9B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA7B61F81
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4E0C433EF;
        Sun, 28 May 2023 19:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303199;
        bh=NzSuCDquSRyGSL/9He700VpgzWy155VEdg4950KBWAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji91i4n7yK3ee9kn+SceYD23l0QCAKKNnmlFmZwhyzPna0+Oi8wc99s4CR15Lkcj+
         LD8zegbAQmwr+Ra8QgpBjX23Nkk8JJwdhINF3/h36tOWzbgYIcpY5eNPxPKNc7GbtT
         15gDb1wy6mLiyWwy9nXdVkuMRZI63ldgc2fPbEkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.10 194/211] power: supply: leds: Fix blink to LED on transition
Date:   Sun, 28 May 2023 20:11:55 +0100
Message-Id: <20230528190848.320352928@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit e4484643991e0f6b89060092563f0dbab9450cbb upstream.

When a battery's status changes from charging to full then
the charging-blink-full-solid trigger tries to change
the LED from blinking to solid/on.

As is documented in include/linux/leds.h to deactivate blinking /
to make the LED solid a LED_OFF must be send:

"""
         * Deactivate blinking again when the brightness is set to LED_OFF
         * via the brightness_set() callback.
"""

led_set_brighness() calls with a brightness value other then 0 / LED_OFF
merely change the brightness of the LED in its on state while it is
blinking.

So power_supply_update_bat_leds() must first send a LED_OFF event
before the LED_FULL to disable blinking.

Fixes: 6501f728c56f ("power_supply: Add new LED trigger charging-blink-solid-full")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/power_supply_leds.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -34,8 +34,9 @@ static void power_supply_update_bat_leds
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
-		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_FULL);
+		/* Going from blink to LED on requires a LED_OFF event to stop blink */
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);


