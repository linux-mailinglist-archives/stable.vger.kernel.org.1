Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BC7ECDCF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjKOTig (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjKOTif (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C219E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C043C433C8;
        Wed, 15 Nov 2023 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077111;
        bh=75zDVOLMp1emhx1lf2Xyl4bVdgqog2LJG4HBuEFAM4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbDKiNE9cxkXMaGUlNXDLac8/aTnE8lPGuEll4axGpxbQlw1c8sSOw+01F34rV79e
         raPF+Q7Kz0BLegfBf4bhTVw9AbTnn6yE5Bg642nvVLA1gxZ3g7GK4W02Lx411uftJz
         qlXkMmRcLTJ+VnMopj4vf2rgeACk6iuiVU9mmeHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 128/603] thermal: core: Dont update trip points inside the hysteresis range
Date:   Wed, 15 Nov 2023 14:11:13 -0500
Message-ID: <20231115191622.096173425@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit cf3986f8c01d355490d0ac6024391b989a9d1e9d ]

When searching for the trip points that need to be set, the nearest
higher trip point's temperature is used for the high trip, while the
nearest lower trip point's temperature minus the hysteresis is used for
the low trip. The issue with this logic is that when the current
temperature is inside a trip point's hysteresis range, both high and low
trips will come from the same trip point. As a consequence instability
can still occur like this:
* the temperature rises slightly and enters the hysteresis range of a
  trip point
* polling happens and updates the trip points to the hysteresis range
* the temperature falls slightly, exiting the hysteresis range, crossing
  the trip point and triggering an IRQ, the trip points are updated
* repeat

So even though the current hysteresis implementation prevents
instability from happening due to IRQs triggering on the same
temperature value, both ways, it doesn't prevent it from happening due
to an IRQ on one way and polling on the other.

To properly implement a hysteresis behavior, when inside the hysteresis
range, don't update the trip points. This way, the previously set trip
points will stay in effect, which will in a way remember the previous
state (if the temperature signal came from above or below the range) and
therefore have the right trip point already set.

The exception is if there was no previous trip point set, in which case
a previous state doesn't exist, and so it's sensible to allow the
hysteresis range as trip points.

The following logs show the current behavior when running on a real
machine:

[  202.524658] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
   203.562817: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37979
[  203.562845] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000
   204.176059: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37979 temp=40028
[  204.176089] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
   205.226813: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40028 temp=38652
[  205.226842] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000

And with this patch applied:

[  184.933415] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
   185.981182: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37872
   186.744685: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37872 temp=40058
[  186.744716] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
   187.773284: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40058 temp=38698

Fixes: 060c034a9741 ("thermal: Add support for hardware-tracked trip points")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_trip.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 024e2e365a26b..597ac4144e331 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -55,6 +55,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	struct thermal_trip trip;
 	int low = -INT_MAX, high = INT_MAX;
+	bool same_trip = false;
 	int i, ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -63,6 +64,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 		return;
 
 	for (i = 0; i < tz->num_trips; i++) {
+		bool low_set = false;
 		int trip_low;
 
 		ret = __thermal_zone_get_trip(tz, i , &trip);
@@ -71,18 +73,31 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 		trip_low = trip.temperature - trip.hysteresis;
 
-		if (trip_low < tz->temperature && trip_low > low)
+		if (trip_low < tz->temperature && trip_low > low) {
 			low = trip_low;
+			low_set = true;
+			same_trip = false;
+		}
 
 		if (trip.temperature > tz->temperature &&
-		    trip.temperature < high)
+		    trip.temperature < high) {
 			high = trip.temperature;
+			same_trip = low_set;
+		}
 	}
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
 
+	/*
+	 * If "high" and "low" are the same, skip the change unless this is the
+	 * first time.
+	 */
+	if (same_trip && (tz->prev_low_trip != -INT_MAX ||
+	    tz->prev_high_trip != INT_MAX))
+		return;
+
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
 
-- 
2.42.0



