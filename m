Return-Path: <stable+bounces-16007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61A383E724
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48097B26A01
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5F5C8E4;
	Fri, 26 Jan 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eguqs9UD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19F59146
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312327; cv=none; b=C6kOmtuNYQ/ML2ZctLOx8QAJSoizwMxvrlGNHfsGioyyF7a5IMNlAFZaJKq3U5YRM3fh/F1q7LNhYqJDSAsFORyzQFL7TNAxklaUdpMHE4DYTc+8SGkINrbRYjaJQJu0+prC2nh0D4INsrO6/0o/rj++PIhW3zuWmWc2B7ulYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312327; c=relaxed/simple;
	bh=Mr6vIaPR5CbAwDl7sQi0cCj5ONPfMjAJFOLvRI/NJYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZXFDvljoA5Xf7NeYYJ8cy1Oz53cf9Vbr2JmCpl5CrcUI62Q9nq6qA7TA3ByNbYgHMr0uEZbwhcgP21hT7Yv0dSU5Q9IVnXlCas1wZ+scEqg0TQ9l3FDvlzDbk21lXmvI7MU8vgiBMdpt64nZaWmssxT5s5pwLYH1sN9GrrE04Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eguqs9UD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6357BC433F1;
	Fri, 26 Jan 2024 23:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312327;
	bh=Mr6vIaPR5CbAwDl7sQi0cCj5ONPfMjAJFOLvRI/NJYE=;
	h=Subject:To:Cc:From:Date:From;
	b=eguqs9UD2zM2TnGaeb1q7m5zD0gGBEfIkBLDfzi0ayVbbbM9hci4C5l3qnDbByJNA
	 s36qsawruSpDf4w1s1wk4J7++64eygfvyryRWwZ/WQsfckbpCYyAM1OApQZKbO2+lV
	 g02wYXsSB4MubZWZIOWObIXsfg55FxVm7ut1ppJg=
Subject: FAILED: patch "[PATCH] thermal: gov_power_allocator: avoid inability to reset a cdev" failed to apply to 6.6-stable tree
To: di.shen@unisoc.com,lukasz.luba@arm.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wvw@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:38:46 -0800
Message-ID: <2024012646-bulb-spur-7ae9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e95fa7404716f6e25021e66067271a4ad8eb1486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012646-bulb-spur-7ae9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e95fa7404716 ("thermal: gov_power_allocator: avoid inability to reset a cdev")
94be1d27aa8d ("thermal: gov_power_allocator: Use trip pointers instead of trip indices")
2c7b4bfadef0 ("thermal: core: Store trip pointer in struct thermal_instance")

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


