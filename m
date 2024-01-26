Return-Path: <stable+bounces-16008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3383E722
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2014E1C27F18
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502B5C8FC;
	Fri, 26 Jan 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qtw9s0Us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4F5BADE
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312329; cv=none; b=YwEMhY/a5M9jaYA/OJhiCEMX9Qm79fdBXY+7rpwBr1TSsyNHemUAVJ7xz61J3fQoyczHFmhQgftwuYZSF8Ww28vcNrJDf664yDKhzRjj1sDCoNKFwVncZJPwdRC3r5MVeSswhsiare4SQiRM1hmRJv+7A7qqprI1DwBXFS5FL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312329; c=relaxed/simple;
	bh=fWIuBjd689YtEK7EuPyg/kHwapS63vz8PwgrjAqW6nY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qOe1QxYU9TxkKGbIYKtJdMBWmXrfSy5Vwuaf8ZrAd8WrApiempANNpcpUXrWAfJGwulUkjPF+Qtvb0ee/qIVeqDy6YVi2/aYi54GmFO4h4PwQTq6MBYGr/NKCY35pNYa/7BlgVqPnMwEwngCePkm7wDeax/ErjuQBcWzDtBwN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qtw9s0Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB27C43390;
	Fri, 26 Jan 2024 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312329;
	bh=fWIuBjd689YtEK7EuPyg/kHwapS63vz8PwgrjAqW6nY=;
	h=Subject:To:Cc:From:Date:From;
	b=qtw9s0UsPmA0rMTg+hhN6m9ooWAq+AiOPwaCeQ8kSPUHPtL5CrVTR9HNzyiurDp+S
	 4OsHgNZAUw2+v+RJ3/R/9gfnjK7hzpQXPJ0WLbqGmplA46jusO6DOKYD2He2RKnDRT
	 KUKe00geFsPiP7uxkZJrVnP4HZhC3w2icoRkcFvk=
Subject: FAILED: patch "[PATCH] thermal: gov_power_allocator: avoid inability to reset a cdev" failed to apply to 6.1-stable tree
To: di.shen@unisoc.com,lukasz.luba@arm.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wvw@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:38:48 -0800
Message-ID: <2024012648-impending-gala-16f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e95fa7404716f6e25021e66067271a4ad8eb1486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012648-impending-gala-16f2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e95fa7404716 ("thermal: gov_power_allocator: avoid inability to reset a cdev")
94be1d27aa8d ("thermal: gov_power_allocator: Use trip pointers instead of trip indices")
2c7b4bfadef0 ("thermal: core: Store trip pointer in struct thermal_instance")
790930f44289 ("thermal: core: Introduce thermal_cooling_device_update()")
c43198af05cf ("thermal: core: Introduce thermal_cooling_device_present()")
5b8de18ee902 ("thermal/core: Move the thermal trip code to a dedicated file")
e6ec64f85237 ("thermal/drivers/qcom: Fix set_trip_temp() deadlock")
1fa86b0a3692 ("thermal/drivers/qcom: Use generic thermal_zone_get_trip() function")
7f725a23f2b7 ("thermal/core/governors: Use thermal_zone_get_trip() instead of ops functions")
2e38a2a981b2 ("thermal/core: Add a generic thermal_zone_set_trip() function")
7c3d5c20dc16 ("thermal/core: Add a generic thermal_zone_get_trip() function")
91b3aafc2238 ("thermal/core: Remove thermal_zone_set_trips()")
05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex")
1c439dec359c ("thermal/core: Introduce locked version of thermal_zone_device_update")
a365105c685c ("thermal: sysfs: Reuse cdev->max_state")
c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e95fa7404716f6e25021e66067271a4ad8eb1486 Mon Sep 17 00:00:00 2001
From: Di Shen <di.shen@unisoc.com>
Date: Wed, 10 Jan 2024 19:55:26 +0800
Subject: [PATCH] thermal: gov_power_allocator: avoid inability to reset a cdev

Commit 0952177f2a1f ("thermal/core/power_allocator: Update once
cooling devices when temp is low") adds an update flag to avoid
triggering a thermal event when there is no need, and the thermal
cdev is updated once when the temperature is low.

But when the trips are writable, and switch_on_temp is set to be a
higher value, the cooling device state may not be reset to 0,
because last_temperature is smaller than switch_on_temp.

For example:
First:
switch_on_temp=70 control_temp=85;
Then userspace change the trip_temp:
switch_on_temp=45 control_temp=55 cur_temp=54

Then userspace reset the trip_temp:
switch_on_temp=70 control_temp=85 cur_temp=57 last_temp=54

At this time, the cooling device state should be reset to 0.
However, because cur_temp(57) < switch_on_temp(70)
last_temp(54) < switch_on_temp(70)  ---->  update = false,
update is false, the cooling device state can not be reset.

Using the observation that tz->passive can also be regarded as the
temperature status, set the update flag to the tz->passive value.

When the temperature drops below switch_on for the first time, the
states of cooling devices can be reset once, and tz->passive is updated
to 0. In the next round, because tz->passive is 0, cdev->state will not
be updated.

By using the tz->passive value as the "update" flag, the issue above
can be solved, and the cooling devices can be updated only once when the
temperature is low.

Fixes: 0952177f2a1f ("thermal/core/power_allocator: Update once cooling devices when temp is low")
Cc: 5.13+ <stable@vger.kernel.org> # 5.13+
Suggested-by: Wei Wang <wvw@google.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 7b6aa265ff6a..81e061f183ad 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -762,7 +762,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz,
 
 	trip = params->trip_switch_on;
 	if (trip && tz->temperature < trip->temperature) {
-		update = tz->last_temperature >= trip->temperature;
+		update = tz->passive;
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);


