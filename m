Return-Path: <stable+bounces-69472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CF956679
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6781F22BA3
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF315C132;
	Mon, 19 Aug 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LeARzJJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D115E5BD
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058728; cv=none; b=DxoQ2lgONyyfiKCOb+dTWu2v/AwCXOYLlUCXqCvOOKJuI9AHa3q7DDyerGSLomIup8yaKofo1T9qxVbk7L+Fuco4Zgjb2jnpmEKgUijTrRV66x/TKFUKzBZb/bO9lFgGQ6TlcLIBF5aMz8H0AkT/G2jXQZMxnSDBvYxI22w9GXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058728; c=relaxed/simple;
	bh=RdEYg1ShGktrfdB/XXs+DdVZneqV2fsO8lcmbtRxZik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LT/CpVIHK+/ULFepLHpKKgUUJllkzkSa0YcrO+QmORA+mgbxnt4vIiecObDRdddN55soL8gePoEuRA940d2X+equFmXJAmpxtYpKISHUEGDIezXN3c2gZ0npruXrwFaZRj2Rk6doUtjo/M2cyLRj0yjYA7Gq3zuYXV2oeCAAxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LeARzJJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6BFC4AF0C;
	Mon, 19 Aug 2024 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058727;
	bh=RdEYg1ShGktrfdB/XXs+DdVZneqV2fsO8lcmbtRxZik=;
	h=Subject:To:Cc:From:Date:From;
	b=LeARzJJzYjntPlHGZvIKa315oOvntO/A1mQfAL/oDXvO4vT4x8iNh4CB+D4iF9i6q
	 jRWkX7StGENc6q0cgoH7PyDJvrI4GxubLHEyURC+RgpqfSrdPpv/5JwYb8r9I4XOaF
	 M1CkYDxuXh46m7/A8QljhHqHwGf0GElVwaDbo3k0=
Subject: FAILED: patch "[PATCH] thermal: gov_bang_bang: Split bang_bang_control()" failed to apply to 6.10-stable tree
To: rafael.j.wysocki@intel.com,peter@piie.net,rui.zhang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:12:04 +0200
Message-ID: <2024081904-sprite-urologist-d8e9@gregkh>
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
git cherry-pick -x 84248e35d9b60e03df7276627e4e91fbaf80f73d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081904-sprite-urologist-d8e9@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

84248e35d9b6 ("thermal: gov_bang_bang: Split bang_bang_control()")
b9b6ee6fe258 ("thermal: gov_bang_bang: Call __thermal_cdev_update() directly")
2c637af8a74d ("thermal: gov_bang_bang: Drop unnecessary cooling device target state checks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84248e35d9b60e03df7276627e4e91fbaf80f73d Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 13 Aug 2024 16:26:42 +0200
Subject: [PATCH] thermal: gov_bang_bang: Split bang_bang_control()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the setting of the thermal instance target state from
bang_bang_control() into a separate function that will be also called
in a different place going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Kästle <peter@piie.net>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Link: https://patch.msgid.link/3313587.aeNJFYEL58@rjwysocki.net

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index b9474c6af72b..87cff3ea77a9 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -13,6 +13,27 @@
 
 #include "thermal_core.h"
 
+static void bang_bang_set_instance_target(struct thermal_instance *instance,
+					  unsigned int target)
+{
+	if (instance->target != 0 && instance->target != 1 &&
+	    instance->target != THERMAL_NO_TARGET)
+		pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
+			 instance->target, instance->name);
+
+	/*
+	 * Enable the fan when the trip is crossed on the way up and disable it
+	 * when the trip is crossed on the way down.
+	 */
+	instance->target = target;
+
+	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
+
+	mutex_lock(&instance->cdev->lock);
+	__thermal_cdev_update(instance->cdev);
+	mutex_unlock(&instance->cdev->lock);
+}
+
 /**
  * bang_bang_control - controls devices associated with the given zone
  * @tz: thermal_zone_device
@@ -54,25 +75,8 @@ static void bang_bang_control(struct thermal_zone_device *tz,
 		tz->temperature, trip->hysteresis);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
-		if (instance->target != 0 && instance->target != 1 &&
-		    instance->target != THERMAL_NO_TARGET)
-			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
-				 instance->target, instance->name);
-
-		/*
-		 * Enable the fan when the trip is crossed on the way up and
-		 * disable it when the trip is crossed on the way down.
-		 */
-		instance->target = crossed_up;
-
-		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
-
-		mutex_lock(&instance->cdev->lock);
-		__thermal_cdev_update(instance->cdev);
-		mutex_unlock(&instance->cdev->lock);
+		if (instance->trip == trip)
+			bang_bang_set_instance_target(instance, crossed_up);
 	}
 }
 


