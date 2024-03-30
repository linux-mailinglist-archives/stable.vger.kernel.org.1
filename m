Return-Path: <stable+bounces-33818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A972892A1D
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F295728338B
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47C33DF;
	Sat, 30 Mar 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4Lfkzdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751E125B4
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792033; cv=none; b=MtZ2gsggJPa70VExhRcbKOcNCBAPkSBNFIJ/Yo3ZF97rZqCq+5pYDhORo2mLNv9ElGC0APOQiE8x19mPzxU+fCijGmMcByxdM71LeZ1I26BYpXPxME4f6JOIiuUKPWRI5lW4SLM64V2CGBaNyigT6dQvu6pujCzPtz8J6AZk4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792033; c=relaxed/simple;
	bh=8XfATJUqgHygkYHjl5Gxkeh8ACw1qYlNLAk9t48imSM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=STHU53V9FuelZYzZzfdmVsF7Z3Sq+tFADLvYLPdWdKIXbgcDWfvRE5t6eI4peDgn/EZd9bK9SIX3hIxQItHRXRUo4rAmkImfC/owiGp9lj3WFGrUPwgv6lC9QZYoCmz/iHlO2d7e0g4gltrZ5Llsip7t2upesswTRAdJmVCgzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4Lfkzdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA126C433C7;
	Sat, 30 Mar 2024 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711792033;
	bh=8XfATJUqgHygkYHjl5Gxkeh8ACw1qYlNLAk9t48imSM=;
	h=Subject:To:Cc:From:Date:From;
	b=L4LfkzdlZmDhAPiPP0LpjV3qdzU+k4kuS5zyXrfysykfJQB0I4KSAR8+/YOEghQcM
	 jB6rwZHy8HEtfcDPiXjoOcE2REV07bQ6deHhb703Xm8F5tVrfL4Nmw1ahtgaWzaGZz
	 7j+vz4xH5f7bPZjLJ/ajG0laCKMVtFNdWzCc36jE=
Subject: FAILED: patch "[PATCH] Revert "thermal: core: Don't update trip points inside the" failed to apply to 6.7-stable tree
To: daniel.lezcano@linaro.org,nfraprado@collabora.com,quic_manafm@quicinc.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:47:10 +0100
Message-ID: <2024033009-harmonica-veteran-127c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x f67cf45deedb118af302534643627ce59074e8eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033009-harmonica-veteran-127c@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f67cf45deedb118af302534643627ce59074e8eb Mon Sep 17 00:00:00 2001
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 25 Mar 2024 23:24:24 +0100
Subject: [PATCH] Revert "thermal: core: Don't update trip points inside the
 hysteresis range"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It has been reported the commit cf3986f8c01d3 introduced a regression
when the temperature is wavering in the hysteresis region. The
mitigation stops leading to an uncontrolled temperature increase until
reaching the critical trip point.

Here what happens:

 * 'throttle' is when the current temperature is greater than the trip
   point temperature
 * 'target' is the mitigation level
 * 'passive' is positive when there is a mitigation, zero otherwise
 * these values are computed in the step_wise governor

Configuration:

 trip point 1: temp=95°C, hyst=5°C (passive)
 trip point 2: temp=115°C, hyst=0°C (critical)
 governor: step_wise

 1. The temperature crosses the way up the trip point 1 at 95°C

   - trend=raising
   - throttle=1, target=1
   - passive=1
   - set_trips: low=90°C, high=115°C

 2. The temperature decreases but stays in the hysteresis region at
    93°C

   - trend=dropping
   - throttle=0, target=0
   - passive=1

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

 3. The temperature increases a bit but stays in the hysteresis region
    at 94°C (so below the trip point 1 temp 95°C)

   - trend=raising
   - throttle=0, target=0
   - passive=1

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

 4. The temperature decreases but stays in the hysteresis region at
    93°C

   - trend=dropping
   - throttle=0, target=THERMAL_NO_TARGET
   - passive=0

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

At this point, the 'passive' value is zero, there is no mitigation,
the temperature is in the hysteresis region, the next trip point is
115°C. As 'passive' is zero, the timer to monitor the thermal zone is
disabled. Consequently if the temperature continues to increase, no
mitigation will happen and it will reach the 115°C trip point and
reboot.

Before the optimization, the high boundary would have been 95°C, thus
triggering the mitigation again and rearming the polling timer.

The optimization make sense but given the current implementation of
the step_wise governor collaborating via this 'passive' flag with the
core framework it can not work.

From a higher perspective it seems like there is a problem between the
governor which sets a variable to be used by the core framework. That
sounds akward and it would make much more sense if the core framework
controls the governor and not the opposite. But as the devil hides in
the details, there are some subtilities to be addressed before.

Elaborating those would be out of the scope this changelog. So let's
stay simple and revert the change first to fixup all broken mobile
platforms.

This reverts commit cf3986f8c01d3 ("thermal: core: Don't update trip
points inside the hysteresis range") and takes a conflict with commit
0c0c4740c9d26 ("0c0c4740c9d2 thermal: trip: Use for_each_trip() in
__thermal_zone_set_trips()") in drivers/thermal/thermal_trip.c into
account.

Fixes: cf3986f8c01d3 ("thermal: core: Don't update trip points inside the hysteresis range")
Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Cc: 6.7+ <stable@vger.kernel.org> # 6.7+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 09f6050dd041..497abf0d47ca 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -65,7 +65,6 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	const struct thermal_trip *trip;
 	int low = -INT_MAX, high = INT_MAX;
-	bool same_trip = false;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -74,36 +73,22 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 		return;
 
 	for_each_trip(tz, trip) {
-		bool low_set = false;
 		int trip_low;
 
 		trip_low = trip->temperature - trip->hysteresis;
 
-		if (trip_low < tz->temperature && trip_low > low) {
+		if (trip_low < tz->temperature && trip_low > low)
 			low = trip_low;
-			low_set = true;
-			same_trip = false;
-		}
 
 		if (trip->temperature > tz->temperature &&
-		    trip->temperature < high) {
+		    trip->temperature < high)
 			high = trip->temperature;
-			same_trip = low_set;
-		}
 	}
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
 
-	/*
-	 * If "high" and "low" are the same, skip the change unless this is the
-	 * first time.
-	 */
-	if (same_trip && (tz->prev_low_trip != -INT_MAX ||
-	    tz->prev_high_trip != INT_MAX))
-		return;
-
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
 


