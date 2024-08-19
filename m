Return-Path: <stable+bounces-69474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF495667C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF1D1C21803
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372415C12C;
	Mon, 19 Aug 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aztcALA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AA148FE0
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058739; cv=none; b=pWaVHFpElf+b3SLgk3lQMC1YYXmo49JwROUd+Kdqc8+i/MfW7jBSgXjpcs1gW9OBVzGEaf1iRfQx3e2SfRjRRmN0GxPBOLPHUXMHA2wgqrWVIj+5h4JlQrsASEPyxm7lm5hxUFBHO6v8sKhOP+G/LKAO8HcyPF2x1CQciAZUYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058739; c=relaxed/simple;
	bh=nKH0XTvCIN9gwlGCMCi28S02x2knn5wNi0Snt4K8eZQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kNBsuBAy9aIKIqV9Di8r4CnVeDKbWjyTofltGtkiGebqw6wlclfJD2JpANGNQdKckj1LAkTR6g03WyZ/4bU/IBeEIp2bfJsAmdpJF/aNzTjVhhNc3p6mQwyoENCqVmHGcDkAEIAMeDB7k3iUGVH111sajZzjYmvmVRvSqNh6aNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aztcALA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B435C4AF0C;
	Mon, 19 Aug 2024 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058739;
	bh=nKH0XTvCIN9gwlGCMCi28S02x2knn5wNi0Snt4K8eZQ=;
	h=Subject:To:Cc:From:Date:From;
	b=aztcALA99kQ2War0v3QPvMftrx1zoYpjV533hR7aVzsH6l8wwOqFu3P9M0Djw6Gzd
	 a4vuXUMygsVKtyaWXsNNbRA6WUvbVYlFl+N5RRuiGPhUpk49cZjgtXjSLnsm9g1sHI
	 k+gU7tgWVwy9sS09mCbU+qw5DCUN9ZOm9iaCNtuI=
Subject: FAILED: patch "[PATCH] thermal: gov_bang_bang: Use governor_data to reduce overhead" failed to apply to 6.10-stable tree
To: rafael.j.wysocki@intel.com,peter@piie.net,rui.zhang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:12:16 +0200
Message-ID: <2024081916-anguished-snooze-7b66@gregkh>
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
git cherry-pick -x 6e6f58a170ea98e44075b761f2da42a5aec47dfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081916-anguished-snooze-7b66@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

6e6f58a170ea ("thermal: gov_bang_bang: Use governor_data to reduce overhead")
5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
84248e35d9b6 ("thermal: gov_bang_bang: Split bang_bang_control()")
b9b6ee6fe258 ("thermal: gov_bang_bang: Call __thermal_cdev_update() directly")
2c637af8a74d ("thermal: gov_bang_bang: Drop unnecessary cooling device target state checks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e6f58a170ea98e44075b761f2da42a5aec47dfb Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 13 Aug 2024 16:29:11 +0200
Subject: [PATCH] thermal: gov_bang_bang: Use governor_data to reduce overhead
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After running once, the for_each_trip_desc() loop in
bang_bang_manage() is pure needless overhead because it is not going to
make any changes unless a new cooling device has been bound to one of
the trips in the thermal zone or the system is resuming from sleep.

For this reason, make bang_bang_manage() set governor_data for the
thermal zone and check it upfront to decide whether or not it needs to
do anything.

However, governor_data needs to be reset in some cases to let
bang_bang_manage() know that it should walk the trips again, so add an
.update_tz() callback to the governor and make the core additionally
invoke it during system resume.

To avoid affecting the other users of that callback unnecessarily, add
a special notification reason for system resume, THERMAL_TZ_RESUME, and
also pass it to __thermal_zone_device_update() called during system
resume for consistency.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Kästle <peter@piie.net>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Link: https://patch.msgid.link/2285575.iZASKD2KPV@rjwysocki.net

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index bc55e0698bfa..daed67d19efb 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -86,6 +86,10 @@ static void bang_bang_manage(struct thermal_zone_device *tz)
 	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 
+	/* If the code below has run already, nothing needs to be done. */
+	if (tz->governor_data)
+		return;
+
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
 
@@ -107,11 +111,25 @@ static void bang_bang_manage(struct thermal_zone_device *tz)
 				bang_bang_set_instance_target(instance, 0);
 		}
 	}
+
+	tz->governor_data = (void *)true;
+}
+
+static void bang_bang_update_tz(struct thermal_zone_device *tz,
+				enum thermal_notify_event reason)
+{
+	/*
+	 * Let bang_bang_manage() know that it needs to walk trips after binding
+	 * a new cdev and after system resume.
+	 */
+	if (reason == THERMAL_TZ_BIND_CDEV || reason == THERMAL_TZ_RESUME)
+		tz->governor_data = NULL;
 }
 
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
 	.trip_crossed	= bang_bang_control,
 	.manage		= bang_bang_manage,
+	.update_tz	= bang_bang_update_tz,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 95c399f94744..e6669aeda1ff 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1728,7 +1728,8 @@ static void thermal_zone_device_resume(struct work_struct *work)
 
 	thermal_debug_tz_resume(tz);
 	thermal_zone_device_init(tz);
-	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_governor_update_tz(tz, THERMAL_TZ_RESUME);
+	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
 
 	complete(&tz->resume);
 	tz->resuming = false;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25fbf960b474..b86ddca46b9e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -55,6 +55,7 @@ enum thermal_notify_event {
 	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
 	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
 	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
+	THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep */
 };
 
 /**


