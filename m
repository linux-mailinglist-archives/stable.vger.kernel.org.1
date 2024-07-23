Return-Path: <stable+bounces-60767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1593A06B
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA31C281FAF
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A71514D4;
	Tue, 23 Jul 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBvcv0/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE914D28A
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737025; cv=none; b=Vq//+ZIfzpVvRjbC1TsyMQuNV3E6mCjlqbCdKnvj2hFXCrBZV2XQFME04ULnWaBBXVYrYEyklhbzdowu2brtC5eJTFqZ15aB2bOXXa/43XF7ylTfnHsraQPtu/X4WBMB+6eIN9xigsYpkoVNHkUWo6OyR4GGXkRfTXtl/MfY5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737025; c=relaxed/simple;
	bh=mS7rkiC1v0NsC4Zay0sN/LtsciXoDFRy3vzN1A+yQsE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lavEvrMLRSddqfZU/dHvxEb637RbF6sNJMPix4RTYVJC7N5m6T1b9FhIKsKh35PQqt7hzmn7bLb4DFrrqqPZb+/lzll6K3y5JYDN181addTwvDsihmxj1KR4kMP7v4qXwMIlKY8l1iqgIKVzGnCtfSXfQWffEMK+5UJ0afg3QbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBvcv0/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A03C4AF0A;
	Tue, 23 Jul 2024 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721737025;
	bh=mS7rkiC1v0NsC4Zay0sN/LtsciXoDFRy3vzN1A+yQsE=;
	h=Subject:To:Cc:From:Date:From;
	b=QBvcv0/FqHEMgWnT1hGpmyLHVe4AjFRxXaOuAs23Ya8/q+/+ThPqdvfoJEhQxgk7p
	 09kYD/+obKczqzPDF1JYRMHz32+qNomWXDx9x0X2/ycxamge3KCrH0fXS0fKGU1ZvO
	 uhJd0Vzedd6OiPMsuFx65dYtTQfocmrLDx4gKw3U=
Subject: FAILED: patch "[PATCH] thermal: core: Allow thermal zones to tell the core to ignore" failed to apply to 6.10-stable tree
To: rafael.j.wysocki@intel.com,ebiggers@kernel.org,oleksandr@natalenko.name,s.l-h@gmx.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 14:17:02 +0200
Message-ID: <2024072302-policy-spleen-3156@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e528be3c87be953b73e7826a2d7e4b837cbad39d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072302-policy-spleen-3156@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e528be3c87be ("thermal: core: Allow thermal zones to tell the core to ignore them")
7c8267275de6 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e528be3c87be953b73e7826a2d7e4b837cbad39d Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 17 Jul 2024 21:45:02 +0200
Subject: [PATCH] thermal: core: Allow thermal zones to tell the core to ignore
 them

The iwlwifi wireless driver registers a thermal zone that is only needed
when the network interface handled by it is up and it wants that thermal
zone to be effectively ignored by the core otherwise.

Before commit a8a261774466 ("thermal: core: Call monitor_thermal_zone()
if zone temperature is invalid") that could be achieved by returning
an error code from the thermal zone's .get_temp() callback because the
core did not really handle errors returned by it almost at all.
However, commit a8a261774466 made the core attempt to recover from the
situation in which the temperature of a thermal zone cannot be
determined due to errors returned by its .get_temp() and is always
invalid from the core's perspective.

That was done because there are thermal zones in which .get_temp()
returns errors to start with due to some difficulties related to the
initialization ordering, but then it will start to produce valid
temperature values at one point.

Unfortunately, the simple approach taken by commit a8a261774466,
which is to poll the thermal zone periodically until its .get_temp()
callback starts to return valid temperature values, is at odds with
the special thermal zone in iwlwifi in which .get_temp() may always
return an error because its network interface may always be down.  If
that happens, every attempt to invoke the thermal zone's .get_temp()
callback resulting in an error causes the thermal core to print a
dev_warn() message to the kernel log which is super-noisy.

To address this problem, make the core handle the case in which
.get_temp() returns 0, but the temperature value returned by it
is not actually valid, in a special way.  Namely, make the core
completely ignore the invalid temperature value coming from
.get_temp() in that case, which requires folding in
update_temperature() into its caller and a few related changes.

On the iwlwifi side, modify iwl_mvm_tzone_get_temp() to return 0
and put THERMAL_TEMP_INVALID into the temperature return memory
location instead of returning an error when the firmware is not
running or it is not of the right type.

Also, to clearly separate the handling of invalid temperature
values from the thermal zone initialization, introduce a special
THERMAL_TEMP_INIT value specifically for the latter purpose.

Fixes: a8a261774466 ("thermal: core: Call monitor_thermal_zone() if zone temperature is invalid")
Closes: https://lore.kernel.org/linux-pm/20240715044527.GA1544@sol.localdomain/
Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201761
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/4950004.31r3eYUQgx@rjwysocki.net
[ rjw: Rebased on top of the current mainline ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index ed0796aff722..d92470960b38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -621,8 +621,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	guard(mvm)(mvm);
 
 	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
-		return -ENODATA;
+	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+		/*
+		 * Tell the core that there is no valid temperature value to
+		 * return, but it need not worry about this.
+		 */
+		*temperature = THERMAL_TEMP_INVALID;
+		return 0;
+	}
 
 	ret = iwl_mvm_get_temp(mvm, &temp);
 	if (ret)
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8795187fbc52..f6e700e48aad 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -300,8 +300,6 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-	else if (tz->temperature == THERMAL_TEMP_INVALID)
-		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
 }
 
 static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
@@ -382,7 +380,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	td->threshold = trip->temperature;
 
 	if (tz->last_temperature >= old_threshold &&
-	    tz->last_temperature != THERMAL_TEMP_INVALID) {
+	    tz->last_temperature != THERMAL_TEMP_INIT) {
 		/*
 		 * Mitigation is under way, so it needs to stop if the zone
 		 * temperature falls below the low temperature of the trip.
@@ -417,27 +415,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	}
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
-{
-	int temp, ret;
-
-	ret = __thermal_zone_get_temp(tz, &temp);
-	if (ret) {
-		if (ret != -EAGAIN)
-			dev_warn(&tz->device,
-				 "failed to read out thermal zone (%d)\n",
-				 ret);
-		return;
-	}
-
-	tz->last_temperature = tz->temperature;
-	tz->temperature = temp;
-
-	trace_thermal_temperature(tz);
-
-	thermal_genl_sampling_temp(tz->id, temp);
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -452,7 +429,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->temperature = THERMAL_TEMP_INIT;
 	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
@@ -504,6 +481,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
+	int temp, ret;
 
 	if (tz->suspended)
 		return;
@@ -511,10 +489,29 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
-	update_temperature(tz);
+	ret = __thermal_zone_get_temp(tz, &temp);
+	if (ret) {
+		if (ret != -EAGAIN)
+			dev_info(&tz->device, "Temperature check failed (%d)\n", ret);
 
-	if (tz->temperature == THERMAL_TEMP_INVALID)
+		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
+		return;
+	} else if (temp <= THERMAL_TEMP_INVALID) {
+		/*
+		 * Special case: No valid temperature value is available, but
+		 * the zone owner does not want the core to do anything about
+		 * it.  Continue regular zone polling if needed, so that this
+		 * function can be called again, but skip everything else.
+		 */
 		goto monitor;
+	}
+
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
+	trace_thermal_temperature(tz);
+
+	thermal_genl_sampling_temp(tz->id, temp);
 
 	tz->notify_event = event;
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 30c0e78859a7..ba8e6fc807ca 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -133,6 +133,9 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+/* Initial thermal zone temperature. */
+#define THERMAL_TEMP_INIT	INT_MIN
+
 /*
  * Default delay after a failing thermal zone temperature check before
  * attempting to check it again.
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 81e019493557..aedb8369e2aa 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -163,6 +163,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	}
 
 	ret = __thermal_zone_get_temp(tz, temp);
+	if (!ret && *temp <= THERMAL_TEMP_INVALID)
+		ret = -ENODATA;
 
 unlock:
 	mutex_unlock(&tz->lock);


