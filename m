Return-Path: <stable+bounces-46760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5B8D0B24
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CC9B21E8D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575F61FCD;
	Mon, 27 May 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m24eh1xB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6017E90E;
	Mon, 27 May 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836788; cv=none; b=R/UystBTdPJP8t1Z+jo5n8boYzydxz5g+voN0ns2/pkvpYJPc9uQraUH1J3LUsJpzNTy1kEE8hNUBEs/+Pc/civdhP9Fg83pMxrauR5ZaTOfP1D8Ofc4k5Un+7AxBCtDrsaHRQjnRRNWWT7VhpgqteA3oo7XmpaS5f1riqyFak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836788; c=relaxed/simple;
	bh=omJT04MiZWvgAmEshlQrvq32ORe6WKeLpHoz7HwXuOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEV+4ZOaMt4xg9cmEO+EldPeLItli1ZJ8QWVorwNKkv0Ig95Dwh9Iif6Qp5mA3kFQyYFqg35FMpnXwRYPif3WIja9gzG3W7kZCb1a9LjzuFuNLXX3atY5UdjZIdCaGUZFK31uK7Kwxdyez2jxFLoefeoVL/BxAnZFbKz+URi854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m24eh1xB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B5AC2BBFC;
	Mon, 27 May 2024 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836788;
	bh=omJT04MiZWvgAmEshlQrvq32ORe6WKeLpHoz7HwXuOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m24eh1xB1YNVy4sYbXRQSsc5yptjzE2ifj7HBlf7wRYTPuOqZyWMUK3R61zv72EDL
	 xUN/65qW2yn840QLFMOFYo6zAwsPr0O3lCineedeq2Fkx9mj5ebVsXSnshaJAwYSpw
	 GenI+OgX9m3cHS1rPce1R0TT+vjR40BC2AxWRuWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 181/427] thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()
Date: Mon, 27 May 2024 20:53:48 +0200
Message-ID: <20240527185619.126950782@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 31a0fa0019b022024cc082ae292951a596b06f8c ]

If cdev_dt_seq_show() runs before the first state transition of a cooling
device, it will not print any state residency information for it, even
though it might be reasonably expected to print residency information for
the initial state of the cooling device.

For this reason, rearrange the code to get the initial state of a cooling
device at the registration time and pass it to thermal_debug_cdev_add(),
so that the latter can create a duration record for that state which will
allow cdev_dt_seq_show() to print its residency information.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c    |  9 +++++++--
 drivers/thermal/thermal_debugfs.c | 12 ++++++++++--
 drivers/thermal/thermal_debugfs.h |  4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 015d41a9a368b..38b7d02384d7c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -898,6 +898,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
+	unsigned long current_state;
 	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -935,6 +936,10 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret)
 		goto out_cdev_type;
 
+	ret = cdev->ops->get_cur_state(cdev, &current_state);
+	if (ret)
+		goto out_cdev_type;
+
 	thermal_cooling_device_setup_sysfs(cdev);
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -948,6 +953,8 @@ __thermal_cooling_device_register(struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
+	thermal_debug_cdev_add(cdev, current_state);
+
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 
@@ -963,8 +970,6 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
-	thermal_debug_cdev_add(cdev);
-
 	return cdev;
 
 out_cooling_dev:
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 2891d2ab4875c..403f74d663dce 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -468,8 +468,9 @@ void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
  * Allocates a cooling device object for debug, initializes the
  * statistics and create the entries in sysfs.
  * @cdev: a pointer to a cooling device
+ * @state: current state of the cooling device
  */
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state)
 {
 	struct thermal_debugfs *thermal_dbg;
 	struct cdev_debugfs *cdev_dbg;
@@ -486,9 +487,16 @@ void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
 		INIT_LIST_HEAD(&cdev_dbg->durations[i]);
 	}
 
-	cdev_dbg->current_state = 0;
+	cdev_dbg->current_state = state;
 	cdev_dbg->timestamp = ktime_get();
 
+	/*
+	 * Create a record for the initial cooling device state, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the first state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, state);
+
 	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
 			    thermal_dbg, &tt_fops);
 
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
index 155b9af5fe870..c28bd4c114124 100644
--- a/drivers/thermal/thermal_debugfs.h
+++ b/drivers/thermal/thermal_debugfs.h
@@ -2,7 +2,7 @@
 
 #ifdef CONFIG_THERMAL_DEBUGFS
 void thermal_debug_init(void);
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
 void thermal_debug_tz_add(struct thermal_zone_device *tz);
@@ -14,7 +14,7 @@ void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
 void thermal_debug_update_temp(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
-static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 						   int state) {}
-- 
2.43.0




