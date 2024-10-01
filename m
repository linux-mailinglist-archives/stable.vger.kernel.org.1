Return-Path: <stable+bounces-78466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE298BAF4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CDB1C22ABD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA51BF7FA;
	Tue,  1 Oct 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M21Qp8W9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F431BF7EE
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781866; cv=none; b=l28wMDhbiGNbySoHR+Z+e4xy17DaHviWjWxj6N6Bb9/JjqKNlsHftCxt05y161bE8bI6j5jDdO/mn2LxpcZL2PuAFvrX+ud+tzWd71k/p6fAknJx/9CWaI0vxSsBOyexntiokS9D3CEv4f1LQ4diU97VJVW7TeR1gWey/OmbM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781866; c=relaxed/simple;
	bh=iwAEm2LdV9P+79Ehbyv4DfcSnPkTZ7W0lfOxaH7omE4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XOgKYXrGzJc+44sM2+4A166HN4EZFlHmtIabmlq0ZFUTUGY17GqiwOyHKuj8KLQyamjAMB1TpWVs0mBg45BjwpgU8O6XAwZNv/PaB7fkaEWDkYet1xk921jByW4lrgPM395A+K4LVxfEKTVYE5WcxzPAq0VvZW109jvlPIDs2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M21Qp8W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88064C4CEC6;
	Tue,  1 Oct 2024 11:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781865;
	bh=iwAEm2LdV9P+79Ehbyv4DfcSnPkTZ7W0lfOxaH7omE4=;
	h=Subject:To:Cc:From:Date:From;
	b=M21Qp8W92CkHYVbWFXq3LtUIGA0P/AW6uastUk3kwGIdeGHUUTNwAbtLuWuH5x9HF
	 i+0InPRfKcxis6GwPar4pjsnfEZ9nd9BK2PwsBvPHydYzTtMuHvPqA8WRZ0uBp7T8o
	 +PozqRExxcTCBzqzjv68s4QCUZaIjQmco4dF4VU0=
Subject: FAILED: patch "[PATCH] thermal: sysfs: Add sanity checks for trip temperature and" failed to apply to 6.10-stable tree
To: rafael.j.wysocki@intel.com,lukasz.luba@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:24:15 +0200
Message-ID: <2024100115-support-data-8f0e@gregkh>
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
git cherry-pick -x 874b6476fa888e79e41daf7653384c8d70927b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100115-support-data-8f0e@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

874b6476fa88 ("thermal: sysfs: Add sanity checks for trip temperature and hysteresis")
107280e1371f ("thermal: sysfs: Refine the handling of trip hysteresis changes")
afd84fb10ced ("thermal: sysfs: Get to trips via attribute pointers")
0728c810873e ("thermal: trip: Pass trip pointer to .set_trip_temp() thermal zone callback")
a52641bc6293 ("thermal: trip: Use READ_ONCE() for lockless access to trip properties")
f41f23b0cae1 ("thermal: trip: Use common set of trip type names")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 874b6476fa888e79e41daf7653384c8d70927b90 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Mon, 26 Aug 2024 18:21:59 +0200
Subject: [PATCH] thermal: sysfs: Add sanity checks for trip temperature and
 hysteresis

Add sanity checks for new trip temperature and hysteresis values to
trip_point_temp_store() and trip_point_hyst_store() to prevent trip
point threshold from falling below THERMAL_TEMP_INVALID.

However, still allow user space to pass THERMAL_TEMP_INVALID as the
new trip temperature value to invalidate the trip if necessary.

Also allow the hysteresis to be updated when the temperature is invalid
to allow user space to avoid having to adjust hysteresis after a valid
temperature has been set, but in that case just change the value and do
nothing else.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/12528772.O9o76ZdvQC@rjwysocki.net

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index b740b60032ee..197ae1262466 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -111,18 +111,26 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	if (temp != trip->temperature) {
-		if (tz->ops.set_trip_temp) {
-			ret = tz->ops.set_trip_temp(tz, trip, temp);
-			if (ret)
-				goto unlock;
-		}
+	if (temp == trip->temperature)
+		goto unlock;
 
-		thermal_zone_set_trip_temp(tz, trip, temp);
-
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	/* Arrange the condition to avoid integer overflows. */
+	if (temp != THERMAL_TEMP_INVALID &&
+	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID) {
+		ret = -EINVAL;
+		goto unlock;
 	}
 
+	if (tz->ops.set_trip_temp) {
+		ret = tz->ops.set_trip_temp(tz, trip, temp);
+		if (ret)
+			goto unlock;
+	}
+
+	thermal_zone_set_trip_temp(tz, trip, temp);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+
 unlock:
 	mutex_unlock(&tz->lock);
 
@@ -152,15 +160,33 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	if (hyst != trip->hysteresis) {
-		thermal_zone_set_trip_hyst(tz, trip, hyst);
+	if (hyst == trip->hysteresis)
+		goto unlock;
 
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	/*
+	 * Allow the hysteresis to be updated when the temperature is invalid
+	 * to allow user space to avoid having to adjust hysteresis after a
+	 * valid temperature has been set, but in that case just change the
+	 * value and do nothing else.
+	 */
+	if (trip->temperature == THERMAL_TEMP_INVALID) {
+		WRITE_ONCE(trip->hysteresis, hyst);
+		goto unlock;
 	}
 
+	if (trip->temperature - hyst <= THERMAL_TEMP_INVALID) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	thermal_zone_set_trip_hyst(tz, trip, hyst);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+
+unlock:
 	mutex_unlock(&tz->lock);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static ssize_t


