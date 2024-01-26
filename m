Return-Path: <stable+bounces-16009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C183E723
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107B01F29756
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF045BAC0;
	Fri, 26 Jan 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZIGTnW5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504825C8E5
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312331; cv=none; b=eg+ReL1Wdti8xjdYK33a/SfVh1MrLTura2p2K792MnnoUzgb6DvKMwjdYEG7X8P1M/N2tDfRVnI00nYAShLwm08ilZ1f1Fwg1wR0exrWCyFqw885TrF3Ix/1ZQpzHgEfcPnwcFwfPd+kwQY6cHUUxosDp7fN3XJQf9DxGA0nUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312331; c=relaxed/simple;
	bh=CSROQSR/p+mavNAABvg2Bfi88P/L70zC2TRcjvolrJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jIUc9vGtcBFDVlGRYmsCb8PzRCEso8nHmmmpHsISqzeCsH/jXLsQhgymwCTWGmUXYKJTq0m9M0+N7hqv+ipgLyvzTglE8bQOw4BmQinD/e68Hj6eLi3JkSw3Fz4o9vo44Stkk3B+JzZkfgJKzi7wp2r2NRMw2YpsQxIsL2wmVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZIGTnW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E0C433C7;
	Fri, 26 Jan 2024 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312331;
	bh=CSROQSR/p+mavNAABvg2Bfi88P/L70zC2TRcjvolrJg=;
	h=Subject:To:Cc:From:Date:From;
	b=OZIGTnW5k/9Sb+MfD3jOlQ55jtt2wbksoPdlJzfK3H276o5IKZnaAl9LM6MXU8NLj
	 PjG10Ic99QqK7a7ggSq0PRdlZ29T94eyK13rb3gpeE6/vDzXN7rzZTgmTeqnrF8czv
	 8t1HSnv0Ii3+4SxdQd4lCaVQ/yBfdcovfo0Shk4Q=
Subject: FAILED: patch "[PATCH] thermal: gov_power_allocator: avoid inability to reset a cdev" failed to apply to 5.15-stable tree
To: di.shen@unisoc.com,lukasz.luba@arm.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wvw@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:38:50 -0800
Message-ID: <2024012650-unfrozen-jukebox-4be8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e95fa7404716f6e25021e66067271a4ad8eb1486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012650-unfrozen-jukebox-4be8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
597f500fde76 ("thermal/core: Add a check before calling set_trip_temp()")
a930da9bf583 ("thermal/core: Move the mutex inside the thermal_zone_device_update() function")
670a5e356cb6 ("thermal/core: Move the thermal zone lock out of the governors")
63561fe36b09 ("thermal/governors: Group the thermal zone lock inside the throttle function")

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


