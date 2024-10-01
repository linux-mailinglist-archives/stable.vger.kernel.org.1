Return-Path: <stable+bounces-78465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E098BAF3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1ED1F22A51
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC31BF7F5;
	Tue,  1 Oct 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpqRCJ9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B719D88B
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781857; cv=none; b=Oc53oAh+Ra65Zots1XjXlm+oBhkR4IUeT5CoJE0UM6emfo6DE1/tVHFeNZO48VdsgepzyAqmAvqCtYQYbYH0f6kZ0w7Cb+sZnGmKjJ9YB36cRPN021BAqOQPyJqFhaZvGvdFPpsTZWQtcQbm9OKvmio4e50lYmw/no7+rTn8o2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781857; c=relaxed/simple;
	bh=x0Dv6LKZpLp2lcgUTxzkZX7yTjPsklLm2/mTgR6oJtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rz9/CL9PPJAA/pNJqkZRlnQSI4HMvYBkQDuIovvahNhISEJu+0qireGkr1b0gAxtPOglSmrEuwIkTHxCmp2/F84oboRYmnV37CgFH47XR9dM1XqlE/RET9kCtiWf5ax96cVce9oFnmHPkRDoNlmgZeZrMEH6sqbDP2pMAIAa9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpqRCJ9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FAAC4CEC6;
	Tue,  1 Oct 2024 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781857;
	bh=x0Dv6LKZpLp2lcgUTxzkZX7yTjPsklLm2/mTgR6oJtM=;
	h=Subject:To:Cc:From:Date:From;
	b=YpqRCJ9hpQi7MAZ2O+dY4Sh1qsfoF9mwxO/M09yJPfjWEeKG+DISZBs3AdtuJGd9O
	 X6J76s33z7gbqs1btQn3Q35xlPWkq3yXMHuOx8jMtSim6SEemCWW5H3tlOWOfz+Wt9
	 E/uHG7KTt6WAklGpJ9Vw5fgoYCCFM1G9i/a3Hvxk=
Subject: FAILED: patch "[PATCH] thermal: sysfs: Add sanity checks for trip temperature and" failed to apply to 6.11-stable tree
To: rafael.j.wysocki@intel.com,lukasz.luba@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:24:14 +0200
Message-ID: <2024100114-compare-delivery-d2c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 874b6476fa888e79e41daf7653384c8d70927b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100114-compare-delivery-d2c9@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

874b6476fa88 ("thermal: sysfs: Add sanity checks for trip temperature and hysteresis")
107280e1371f ("thermal: sysfs: Refine the handling of trip hysteresis changes")
afd84fb10ced ("thermal: sysfs: Get to trips via attribute pointers")

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


