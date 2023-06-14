Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0ED719E24
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjFAN3b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjFAN3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7810C8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A05644F7
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75047C433EF;
        Thu,  1 Jun 2023 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626117;
        bh=6xgb183zFPM0RPDryLkRuJaTkwq07NbW5rx4e0sF5eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xr+M0FKM9RHrCb5hphNqMVtW9K2WOcXn33ZmH8o8N8FTWBSg+m+u9ew9xAgE9P7HF
         0z9JLV51ZsPHOyH5SSc9TGBwlMoI671PpjJnnUHXOWyCbT3oWWCiNPATIZlZ2Mvxxg
         i3KuXt6rlxMjfvzeCmVq31C5VFSA7j2jHIPSLyb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Botha <joe@atomic.ac>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH 6.1 37/42] Revert "thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function"
Date:   Thu,  1 Jun 2023 14:21:46 +0100
Message-Id: <20230601131940.716872568@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

This reverts commit a71f388045edbf6788a61f43e2cdc94b392a4ea3.

Commit a71f388045ed ("thermal/drivers/mellanox: Use generic
thermal_zone_get_trip() function") was backported as a dependency of the
fix in upstream commit 6d206b1ea9f4 ("mlxsw: core_thermal: Fix fan speed
in maximum cooling state"). However, it is dependent on changes in the
thermal core that were merged in v6.3. Without them, the mlxsw driver is
unable to register its thermal zone:

mlxsw_spectrum 0000:03:00.0: Failed to register thermal zone
mlxsw_spectrum 0000:03:00.0: cannot register bus device
mlxsw_spectrum: probe of 0000:03:00.0 failed with error -22

Fix this by reverting this commit and instead fix the small conflict
with the above mentioned fix. Tested using the test case mentioned in
the change log of the fix:

 # cat /sys/class/thermal/thermal_zone2/cdev0/type
 mlxsw_fan
 # echo 10 > /sys/class/thermal/thermal_zone2/cdev0/cur_state
 # cat /sys/class/hwmon/hwmon1/name
 mlxsw
 # cat /sys/class/hwmon/hwmon1/pwm1
 255

After setting the fan to its maximum cooling state (10), it operates at
100% duty cycle instead of being stuck at 0 RPM.

Fixes: a71f388045ed ("thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function")
Reported-by: Joe Botha <joe@atomic.ac>
Tested-by: Joe Botha <joe@atomic.ac>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  209 ++++++++++++++++-----
 1 file changed, 161 insertions(+), 48 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -36,39 +36,33 @@ enum mlxsw_thermal_trips {
 	MLXSW_THERMAL_TEMP_TRIP_HOT,
 };
 
-struct mlxsw_cooling_states {
+struct mlxsw_thermal_trip {
+	int	type;
+	int	temp;
+	int	hyst;
 	int	min_state;
 	int	max_state;
 };
 
-static const struct thermal_trip default_thermal_trips[] = {
+static const struct mlxsw_thermal_trip default_thermal_trips[] = {
 	{	/* In range - 0-40% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_NORM,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{
-		/* In range - 40-100% PWM */
-		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{	/* Warning */
-		.type		= THERMAL_TRIP_HOT,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
-	},
-};
-
-static const struct mlxsw_cooling_states default_cooling_states[] = {
-	{
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= 0,
 		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 	},
 	{
+		/* In range - 40-100% PWM */
+		.type		= THERMAL_TRIP_ACTIVE,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
-	{
+	{	/* Warning */
+		.type		= THERMAL_TRIP_HOT,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HOT,
 		.min_state	= MLXSW_THERMAL_MAX_STATE,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
@@ -84,8 +78,7 @@ struct mlxsw_thermal;
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	int module; /* Module or gearbox number */
 	u8 slot_index;
 };
@@ -105,8 +98,7 @@ struct mlxsw_thermal {
 	struct thermal_zone_device *tzdev;
 	int polling_delay;
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
 };
 
@@ -143,9 +135,9 @@ static int mlxsw_get_cooling_device_idx(
 static void
 mlxsw_thermal_module_trips_reset(struct mlxsw_thermal_module *tz)
 {
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = 0;
 }
 
 static int
@@ -187,12 +179,12 @@ mlxsw_thermal_module_trips_update(struct
 	 * by subtracting double hysteresis value.
 	 */
 	if (crit_temp >= MLXSW_THERMAL_MODULE_TEMP_SHIFT)
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp -
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp -
 					MLXSW_THERMAL_MODULE_TEMP_SHIFT;
 	else
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = emerg_temp;
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = emerg_temp;
 
 	return 0;
 }
@@ -209,11 +201,11 @@ static int mlxsw_thermal_bind(struct the
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &thermal->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0) {
 			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
@@ -267,6 +259,61 @@ static int mlxsw_thermal_get_temp(struct
 	return 0;
 }
 
+static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
+				       int trip,
+				       enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = thermal->trips[trip].type;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int *p_temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = thermal->trips[trip].temp;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	thermal->trips[trip].temp = temp;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int *p_hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	*p_hyst = thermal->trips[trip].hyst;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	thermal->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
@@ -275,6 +322,11 @@ static struct thermal_zone_device_ops ml
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
+	.get_trip_type	= mlxsw_thermal_get_trip_type,
+	.get_trip_temp	= mlxsw_thermal_get_trip_temp,
+	.set_trip_temp	= mlxsw_thermal_set_trip_temp,
+	.get_trip_hyst	= mlxsw_thermal_get_trip_hyst,
+	.set_trip_hyst	= mlxsw_thermal_set_trip_hyst,
 };
 
 static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
@@ -289,11 +341,11 @@ static int mlxsw_thermal_module_bind(str
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &tz->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0)
 			goto err_thermal_zone_bind_cooling_device;
@@ -381,10 +433,74 @@ static int mlxsw_thermal_module_temp_get
 	return 0;
 }
 
+static int
+mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
+				   enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = tz->trips[trip].type;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
+				   int trip, int *p_temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = tz->trips[trip].temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
+				   int trip, int temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	tz->trips[trip].temp = temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
+				   int *p_hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	*p_hyst = tz->trips[trip].hyst;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
+				   int hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	tz->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
@@ -414,6 +530,11 @@ static struct thermal_zone_device_ops ml
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_get_max_state(struct thermal_cooling_device *cdev,
@@ -495,8 +616,7 @@ mlxsw_thermal_module_tz_init(struct mlxs
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
 			 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-							module_tz->trips,
+	module_tz->tzdev = thermal_zone_device_register(tz_name,
 							MLXSW_THERMAL_NUM_TRIPS,
 							MLXSW_THERMAL_TRIP_MASK,
 							module_tz,
@@ -540,8 +660,6 @@ mlxsw_thermal_module_init(struct device
 	module_tz->parent = thermal;
 	memcpy(module_tz->trips, default_thermal_trips,
 	       sizeof(thermal->trips));
-	memcpy(module_tz->cooling_states, default_cooling_states,
-	       sizeof(thermal->cooling_states));
 	/* Initialize all trip point. */
 	mlxsw_thermal_module_trips_reset(module_tz);
 	/* Read module temperature and thresholds. */
@@ -637,8 +755,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlx
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
 			 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-						gearbox_tz->trips,
+	gearbox_tz->tzdev = thermal_zone_device_register(tz_name,
 						MLXSW_THERMAL_NUM_TRIPS,
 						MLXSW_THERMAL_TRIP_MASK,
 						gearbox_tz,
@@ -695,8 +812,6 @@ mlxsw_thermal_gearboxes_init(struct devi
 		gearbox_tz = &area->tz_gearbox_arr[i];
 		memcpy(gearbox_tz->trips, default_thermal_trips,
 		       sizeof(thermal->trips));
-		memcpy(gearbox_tz->cooling_states, default_cooling_states,
-		       sizeof(thermal->cooling_states));
 		gearbox_tz->module = i;
 		gearbox_tz->parent = thermal;
 		gearbox_tz->slot_index = area->slot_index;
@@ -812,7 +927,6 @@ int mlxsw_thermal_init(struct mlxsw_core
 	thermal->core = core;
 	thermal->bus_info = bus_info;
 	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
-	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
 	thermal->line_cards[0].slot_index = 0;
 
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);
@@ -862,8 +976,7 @@ int mlxsw_thermal_init(struct mlxsw_core
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
-						      thermal->trips,
+	thermal->tzdev = thermal_zone_device_register("mlxsw",
 						      MLXSW_THERMAL_NUM_TRIPS,
 						      MLXSW_THERMAL_TRIP_MASK,
 						      thermal,


