Return-Path: <stable+bounces-96575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8509E208D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F73928A3F2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9791F7560;
	Tue,  3 Dec 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CV2YBFZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7E1F76AC;
	Tue,  3 Dec 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237965; cv=none; b=F9Bw4AWxHEktXAybRzBHGKlgPs3XOXJi7wk24NJ9W2nychN+6boOQ/qYivh8VBApuKJqXAMEWPKrNqy8K8gE0g8LQDtAuGBJV8K41XJ3MHxiDldaLAKbh83psDQ3Vesv3tfSytk9dyo8SJljbxBbsKOOygJikBN6omXhn1znEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237965; c=relaxed/simple;
	bh=rg+7XL++qRDYEKNj/sAKyHmYZScjv1w7ZDRsWzKRHHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyD/Zd/Fbb3iDxvy5VcEVewdS/SC8K18NWx9zqU/JHkpId+jpgm0X1JNJpL0fYrJmB/MlKaFqUjnf0F9/NWSLJsTRU0z3E4dmEKUfEpTRyNtjJHSHtysylUlJ8GDTBJ23crDd6BAUuJ+3wmOaI+IsF/YeinC5BHojmFfLfevGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CV2YBFZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D05C4CECF;
	Tue,  3 Dec 2024 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733237965;
	bh=rg+7XL++qRDYEKNj/sAKyHmYZScjv1w7ZDRsWzKRHHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CV2YBFZx94G6iwWhdc3IHATBpgU3RbLrjJy1WC/bHxTWUdn/5sNo6Xs3W40gKHcJq
	 QlFsl+oAx7Il+l/9aeXNqNhUufOys+OufokIZPvQxvISBcqn5D37f44Am69lgpurWh
	 HFblssBydNwLXZsqhvTxzjr50B6CtEDFlIX+aGOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 102/817] thermal: core: Mark thermal zones as initializing to start with
Date: Tue,  3 Dec 2024 15:34:34 +0100
Message-ID: <20241203143959.689002637@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 7837fa8115e0273d3cfbd3d17b3f7b7291ceac08 ]

After thermal_zone_device_register_with_trips() has called
device_register() and it has registered the new thermal zone device
with the driver core, user space may access its sysfs attributes and,
among other things, it may enable the thermal zone before it is ready.

To address this, introduce a new thermal zone state flag for
initialization and set it before calling device_register() in
thermal_zone_device_register_with_trips().  This causes
__thermal_zone_device_update() to return early until the new flag
is cleared.

To clear it when the thermal zone is ready, introduce a new
function called thermal_zone_init_complete() that will also invoke
__thermal_zone_device_update() after clearing that flag (both under the
thernal zone lock) and make thermal_zone_device_register_with_trips()
call the new function instead of checking need_update and calling
thermal_zone_device_update() when it is set.

After this change, if user space enables the thermal zone prematurely,
__thermal_zone_device_update() will return early for it until
thermal_zone_init_complete() is called.  In turn, if the thermal zone
is not enabled by user space before thermal_zone_init_complete() is
called, the __thermal_zone_device_update() call in it will return early
because the thermal zone has not been enabled yet, but that function
will be invoked again by thermal_zone_device_set_mode() when the thermal
zone is enabled and it will not return early this time.

The checking of need_update is not necessary any more because the
__thermal_zone_device_update() calls potentially triggered by cooling
device binding take place before calling thermal_zone_init_complete(),
so they all will return early, which means that
thermal_zone_init_complete() must call __thermal_zone_device_update()
in case the thermal zone is enabled prematurely by user space.

Fixes: 203d3d4aa482 ("the generic thermal sysfs driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/9360231.CDJkKcVGEf@rjwysocki.net
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 16 +++++++++++++---
 drivers/thermal/thermal_core.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7218bcbaf656e..91512a8cb49d9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1351,6 +1351,16 @@ int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+static void thermal_zone_init_complete(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
+
+	tz->state &= ~TZ_STATE_FLAG_INIT;
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	mutex_unlock(&tz->lock);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1474,6 +1484,8 @@ thermal_zone_device_register_with_trips(const char *type,
 	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
+	tz->state = TZ_STATE_FLAG_INIT;
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
@@ -1534,9 +1546,7 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	mutex_unlock(&thermal_list_lock);
 
-	/* Update the new thermal zone and mark it as already updated. */
-	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_init_complete(tz);
 
 	thermal_notify_tz_create(tz);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1cf722ba4b71d..1605a930814a5 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -63,6 +63,7 @@ struct thermal_governor {
 
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
+#define	TZ_STATE_FLAG_INIT	BIT(2)
 
 #define TZ_STATE_READY		0
 
-- 
2.43.0




