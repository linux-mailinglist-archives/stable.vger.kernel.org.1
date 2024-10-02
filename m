Return-Path: <stable+bounces-79325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B398D7AB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A751C215AB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E101D049A;
	Wed,  2 Oct 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lAN430xq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267D1D043E;
	Wed,  2 Oct 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877112; cv=none; b=ZbRGwBJZNx1YkLsolCGbUKd0BK4ajAfFCrgHLo3bGD8Yg5XcSFtAn8nvfLlsEOaPu9s5FZIiDPmlrI00uXntsAvG5gC8beqwDL+ijM4amrHVgCiEsX+WdaVKkfMJMR7/9H492dlKyJzTuHcRBg3UuattPeXJPAoKKdwgePFw83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877112; c=relaxed/simple;
	bh=C3CQsRM5tPpiW6C5ars0VE053Aea42KYs/gXc2LyE7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDlPtpGx/kZNh1mwbHbNh6nHUPDgjZg5eSROz/NeGAmtxVNbwEtM8uBPNw0GjveO5rsUMAqwuBYnfX3OdQo4Q+nHYeOn8O+jRRqGvZ2aSGqkzmUQhX2uYyxTbyAVdh05nXwDpvaO5pTHXCWh5e9TrrJKqM58rROxYGZ1bnKQGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lAN430xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF922C4CEC2;
	Wed,  2 Oct 2024 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877112;
	bh=C3CQsRM5tPpiW6C5ars0VE053Aea42KYs/gXc2LyE7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAN430xqrR8uEimrhe71A82mpzLqS0wL+P8m6OI21mLbciLEqL1rqWtCaTJ3wPH8c
	 5QNvlOPzY2iJzxcSEWq/8yHK0/SgRqHnwXL9cru5GjDVqJ3EgwrwFxKK3+tBVwvfDq
	 WmH4MKXKpWFsGujADqXpVygIRejn/Dbs6QLzmKv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 669/695] thermal: core: Store trip sysfs attributes in thermal_trip_desc
Date: Wed,  2 Oct 2024 15:01:07 +0200
Message-ID: <20241002125849.215366533@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

[ Upstream commit 66b263306a86c0f2d3cdb44e3722db6cff3a32b3 ]

Instead of allocating memory for trip point sysfs attributes separately,
store them in struct thermal_trip_desc for each trip individually which
allows a few extra memory allocations to be avoided.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/46571375.fMDQidcC6G@rjwysocki.net
Stable-dep-of: 874b6476fa88 ("thermal: sysfs: Add sanity checks for trip temperature and hysteresis")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.h  |  23 +++----
 drivers/thermal/thermal_sysfs.c | 105 +++++++++++---------------------
 2 files changed, 46 insertions(+), 82 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4cf2b7230d04b..5be8bef41b926 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,8 +15,20 @@
 #include "thermal_netlink.h"
 #include "thermal_debugfs.h"
 
+struct thermal_attr {
+	struct device_attribute attr;
+	char name[THERMAL_NAME_LENGTH];
+};
+
+struct thermal_trip_attrs {
+	struct thermal_attr type;
+	struct thermal_attr temp;
+	struct thermal_attr hyst;
+};
+
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct thermal_trip_attrs trip_attrs;
 	struct list_head notify_list_node;
 	int notify_temp;
 	int threshold;
@@ -56,9 +68,6 @@ struct thermal_governor {
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @resume:	resume completion
- * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
- * @trip_type_attrs:	attributes for trip points for sysfs: trip type
- * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
  * @num_trips:	number of trip points the thermal zone supports
@@ -102,9 +111,6 @@ struct thermal_zone_device {
 	struct completion removal;
 	struct completion resume;
 	struct attribute_group trips_attribute_group;
-	struct thermal_attr *trip_temp_attrs;
-	struct thermal_attr *trip_type_attrs;
-	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
 	int num_trips;
@@ -188,11 +194,6 @@ int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
-struct thermal_attr {
-	struct device_attribute attr;
-	char name[THERMAL_NAME_LENGTH];
-};
-
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {
 	return cdev->ops->get_requested_power && cdev->ops->state2power &&
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 72b302bf914e3..f12d5d47da9bd 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -382,87 +382,55 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  */
 static int create_trip_attrs(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td;
 	struct attribute **attrs;
-
-	/* This function works only for zones with at least one trip */
-	if (tz->num_trips <= 0)
-		return -EINVAL;
-
-	tz->trip_type_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_type_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_type_attrs)
-		return -ENOMEM;
-
-	tz->trip_temp_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_temp_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_temp_attrs) {
-		kfree(tz->trip_type_attrs);
-		return -ENOMEM;
-	}
-
-	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-				      sizeof(*tz->trip_hyst_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_hyst_attrs) {
-		kfree(tz->trip_type_attrs);
-		kfree(tz->trip_temp_attrs);
-		return -ENOMEM;
-	}
+	int i;
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
-	if (!attrs) {
-		kfree(tz->trip_type_attrs);
-		kfree(tz->trip_temp_attrs);
-		kfree(tz->trip_hyst_attrs);
+	if (!attrs)
 		return -ENOMEM;
-	}
 
+	i = 0;
 	for_each_trip_desc(tz, td) {
-		int indx = thermal_zone_trip_id(tz, &td->trip);
+		struct thermal_trip_attrs *trip_attrs = &td->trip_attrs;
 
 		/* create trip type attribute */
-		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_type", indx);
+		snprintf(trip_attrs->type.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_type", i);
 
-		sysfs_attr_init(&tz->trip_type_attrs[indx].attr.attr);
-		tz->trip_type_attrs[indx].attr.attr.name =
-						tz->trip_type_attrs[indx].name;
-		tz->trip_type_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
-		attrs[indx] = &tz->trip_type_attrs[indx].attr.attr;
+		sysfs_attr_init(&trip_attrs->type.attr.attr);
+		trip_attrs->type.attr.attr.name = trip_attrs->type.name;
+		trip_attrs->type.attr.attr.mode = S_IRUGO;
+		trip_attrs->type.attr.show = trip_point_type_show;
+		attrs[i] = &trip_attrs->type.attr.attr;
 
 		/* create trip temp attribute */
-		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_temp", indx);
-
-		sysfs_attr_init(&tz->trip_temp_attrs[indx].attr.attr);
-		tz->trip_temp_attrs[indx].attr.attr.name =
-						tz->trip_temp_attrs[indx].name;
-		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
+		snprintf(trip_attrs->temp.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_temp", i);
+
+		sysfs_attr_init(&trip_attrs->temp.attr.attr);
+		trip_attrs->temp.attr.attr.name = trip_attrs->temp.name;
+		trip_attrs->temp.attr.attr.mode = S_IRUGO;
+		trip_attrs->temp.attr.show = trip_point_temp_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
-			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_temp_attrs[indx].attr.store =
-							trip_point_temp_store;
+			trip_attrs->temp.attr.attr.mode |= S_IWUSR;
+			trip_attrs->temp.attr.store = trip_point_temp_store;
 		}
-		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[i + tz->num_trips] = &trip_attrs->temp.attr.attr;
 
-		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_hyst", indx);
+		snprintf(trip_attrs->hyst.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_hyst", i);
 
-		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
-		tz->trip_hyst_attrs[indx].attr.attr.name =
-					tz->trip_hyst_attrs[indx].name;
-		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
+		sysfs_attr_init(&trip_attrs->hyst.attr.attr);
+		trip_attrs->hyst.attr.attr.name = trip_attrs->hyst.name;
+		trip_attrs->hyst.attr.attr.mode = S_IRUGO;
+		trip_attrs->hyst.attr.show = trip_point_hyst_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
-			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_hyst_attrs[indx].attr.store =
-					trip_point_hyst_store;
+			trip_attrs->hyst.attr.attr.mode |= S_IWUSR;
+			trip_attrs->hyst.attr.store = trip_point_hyst_store;
 		}
-		attrs[indx + tz->num_trips * 2] =
-					&tz->trip_hyst_attrs[indx].attr.attr;
+		attrs[i + 2 * tz->num_trips] = &trip_attrs->hyst.attr.attr;
+		i++;
 	}
 	attrs[tz->num_trips * 3] = NULL;
 
@@ -479,13 +447,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
  */
 static void destroy_trip_attrs(struct thermal_zone_device *tz)
 {
-	if (!tz)
-		return;
-
-	kfree(tz->trip_type_attrs);
-	kfree(tz->trip_temp_attrs);
-	kfree(tz->trip_hyst_attrs);
-	kfree(tz->trips_attribute_group.attrs);
+	if (tz)
+		kfree(tz->trips_attribute_group.attrs);
 }
 
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
-- 
2.43.0




