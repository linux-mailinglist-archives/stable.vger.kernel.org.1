Return-Path: <stable+bounces-69473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16E395667B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05911C21757
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296015ECC5;
	Mon, 19 Aug 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbZeGHqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4B15ECC0
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058734; cv=none; b=drCfVM3pa0Vw4uWcbBSuKyQuw+HLPT6mhGrkTz0V8Cn5kR+h+HBnapDZxozY7fC0/T4an2NzcUTeSewBM2SYdHInqqe2UVBhsKHraPr1ML1EkBBHIr1W4cdphMlQ2vGiu2jx9gBiRt4Eydhz3i7Dco+z/DuycDI8DhEZmEQTtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058734; c=relaxed/simple;
	bh=SEnAOkig0iNNecG/Aghfy/Y0NRPwcnVGbOK8vCOiOVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a0FKGmEKP7Go3iisRkzg1FR8mVYiuzjD6t175zYkSjCqBnBU0NJwZzUIhuqmVunhbYsQROYT/KVA0R/SkNJJ2j0OZGpacaMdCniivrPxl7PIz+4gryO3iBsWKmHDsUsNXLWtH/5RqnfoMcAmouW6q9i3mNOv9gORZ1QHwWNcuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbZeGHqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA519C4AF09;
	Mon, 19 Aug 2024 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058734;
	bh=SEnAOkig0iNNecG/Aghfy/Y0NRPwcnVGbOK8vCOiOVM=;
	h=Subject:To:Cc:From:Date:From;
	b=cbZeGHqKodlF/cxmtFunXBkPQsxcIjQz3RYz1xOWfJpokKYQpG5SznDuKzeV06Bbh
	 17Xmz3rzUDP8RZVXfVyJ/TUAsj80Jz1gMAQL0pHUBdBv3hRasOJK43CWyn3gCUJwra
	 c+nY3au4Oz/+5iHUSMgzztxvBavV9mUP21n4jN24=
Subject: FAILED: patch "[PATCH] thermal: gov_bang_bang: Add .manage() callback" failed to apply to 6.10-stable tree
To: rafael.j.wysocki@intel.com,peter@piie.net,rui.zhang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:12:11 +0200
Message-ID: <2024081911-parlor-reformer-542a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5f64b4a1ab1b0412446d42e1fc2964c2cdb60b27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081911-parlor-reformer-542a@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
84248e35d9b6 ("thermal: gov_bang_bang: Split bang_bang_control()")
b9b6ee6fe258 ("thermal: gov_bang_bang: Call __thermal_cdev_update() directly")
2c637af8a74d ("thermal: gov_bang_bang: Drop unnecessary cooling device target state checks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f64b4a1ab1b0412446d42e1fc2964c2cdb60b27 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 13 Aug 2024 16:27:33 +0200
Subject: [PATCH] thermal: gov_bang_bang: Add .manage() callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After recent changes, the Bang-bang governor may not adjust the
initial configuration of cooling devices to the actual situation.

Namely, if a cooling device bound to a certain trip point starts in
the "on" state and the thermal zone temperature is below the threshold
of that trip point, the trip point may never be crossed on the way up
in which case the state of the cooling device will never be adjusted
because the thermal core will never invoke the governor's
.trip_crossed() callback.  [Note that there is no issue if the zone
temperature is at the trip threshold or above it to start with because
.trip_crossed() will be invoked then to indicate the start of thermal
mitigation for the given trip.]

To address this, add a .manage() callback to the Bang-bang governor
and use it to ensure that all of the thermal instances managed by the
governor have been initialized properly and the states of all of the
cooling devices involved have been adjusted to the current zone
temperature as appropriate.

Fixes: 530c932bdf75 ("thermal: gov_bang_bang: Use .trip_crossed() instead of .throttle()")
Link: https://lore.kernel.org/linux-pm/1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net/
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Kästle <peter@piie.net>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Link: https://patch.msgid.link/8419356.T7Z3S40VBb@rjwysocki.net

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 87cff3ea77a9..bc55e0698bfa 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -26,6 +26,7 @@ static void bang_bang_set_instance_target(struct thermal_instance *instance,
 	 * when the trip is crossed on the way down.
 	 */
 	instance->target = target;
+	instance->initialized = true;
 
 	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
@@ -80,8 +81,37 @@ static void bang_bang_control(struct thermal_zone_device *tz,
 	}
 }
 
+static void bang_bang_manage(struct thermal_zone_device *tz)
+{
+	const struct thermal_trip_desc *td;
+	struct thermal_instance *instance;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (tz->temperature >= td->threshold ||
+		    trip->temperature == THERMAL_TEMP_INVALID ||
+		    trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT)
+			continue;
+
+		/*
+		 * If the initial cooling device state is "on", but the zone
+		 * temperature is not above the trip point, the core will not
+		 * call bang_bang_control() until the zone temperature reaches
+		 * the trip point temperature which may be never.  In those
+		 * cases, set the initial state of the cooling device to 0.
+		 */
+		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+			if (!instance->initialized && instance->trip == trip)
+				bang_bang_set_instance_target(instance, 0);
+		}
+	}
+}
+
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
 	.trip_crossed	= bang_bang_control,
+	.manage		= bang_bang_manage,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);


