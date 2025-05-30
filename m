Return-Path: <stable+bounces-148181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E897CAC8E0A
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6881A9E41C6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EA235073;
	Fri, 30 May 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if81/KWq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADD235064;
	Fri, 30 May 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608759; cv=none; b=cRV0oDeCrbpeT7uppAlPYV+R88JJApwFwD9jVEuVGFhsIgi5zqlxSsfIQssjoYmv4t3Ae2K97kJ2AKGNUMX6d7/rHavEyF2md0+taxgsq4tDhKj/YErTdiRXBJ8mRNFRQuZbVcJo1jsj/RZKrd80bikqV706CSRTHZba2Ppt6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608759; c=relaxed/simple;
	bh=/JmaFHCdGV4lgLDVoId7ufPnTOktRZrAVesfxtEAkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5M771RSqdutZvrOJnACSF8tCrUFfYVTALg8pV6jjx0vmbvGm2eA3AMhi1L+D8VMGKDXvTpuiRpgOn93esa3JqAkkn46Gk4hFwJmrWdGVjHlA9rzOmwKsbjlH94AHDZWzmWQNgOhT0fVwudhEpocc4mnLydd+suMJXPWdoQHt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if81/KWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CEAC4CEEB;
	Fri, 30 May 2025 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608758;
	bh=/JmaFHCdGV4lgLDVoId7ufPnTOktRZrAVesfxtEAkoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=if81/KWqTTnKdc/D5A6t3+I89QC48hFOjpeo94zdsAfJJ897qCyHxjNfj3GgWlu7l
	 J4KWSXfLzSD4xgKEeCgo50PoVI9yWb/dRRdDVfkSeKcDcRspgMUvdGNK+WTGAdjBt9
	 ziL1jgEbZJM8PisJSh3IdKFvWZ3CoWBmq9fVo2kXCZRXqLQLh51saHFh8w47kIu4Ki
	 ybCwQo2ftcEC+0By1wunnWALToazZ4JJos1m0szXaCgS7BQD0kKew98afJVRg/bcUb
	 Ze9+4FQZkzj8/lo+jLodPYqEgOmEv706bZvTbYm6yDhMvNfn99n1qfmq2m2/mvRAGX
	 77kcVqFrs3ucw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jerry Lv <Jerry.Lv@axis.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 19/30] power: supply: bq27xxx: Retrieve again when busy
Date: Fri, 30 May 2025 08:38:41 -0400
Message-Id: <20250530123852.2574030-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123852.2574030-1-sashal@kernel.org>
References: <20250530123852.2574030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Jerry Lv <Jerry.Lv@axis.com>

[ Upstream commit f16d9fb6cf03fdbdefa41a8b32ba1e57afb7ae3d ]

Multiple applications may access the battery gauge at the same time, so
the gauge may be busy and EBUSY will be returned. The driver will set a
flag to record the EBUSY state, and this flag will be kept until the next
periodic update. When this flag is set, bq27xxx_battery_get_property()
will just return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the I2C to update the flag is as expected, for
the gauge typically recovers from busy state within a few milliseconds.
If still failed to access the gauge, the real error code would be returned
instead of ENODEV (as suggested by Pali Rohár).

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
Link: https://lore.kernel.org/r/20250415-foo-fix-v2-1-5b45a395e4cc@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Detailed Analysis: ### 1. **User-Visible Bug Fix** ✅ The commit fixes a
clear user-visible issue where multiple applications accessing the
battery gauge simultaneously receive confusing `-ENODEV` errors instead
of actual battery data or proper error codes. This directly impacts
battery monitoring applications and system power management tools. ###
2. **Code Changes Analysis** **bq27xxx_battery.c change:** ```c -return
-ENODEV; +return di->cache.flags; ``` This single-line change stops
masking real error codes with generic `-ENODEV`, allowing applications
to see the actual error (like `-EBUSY`) and handle it appropriately.
**bq27xxx_battery_i2c.c changes:** - Adds retry logic with up to 3
attempts when encountering `-EBUSY` - Uses standard `usleep_range(10000,
11000)` for 10ms delays - Implements proper loop structure with explicit
break conditions ### 3. **Small and Contained** ✅ The changes are
minimal and focused: - No architectural modifications - No changes to
driver interfaces or APIs - Limited to error handling improvement within
the same subsystem ### 4. **Low Regression Risk** ✅ - Uses established
kernel patterns (`usleep_range`, retry counters) - No timing changes to
critical paths - Battery gauges typically recover from busy state within
milliseconds - Maintains backward compatibility ### 5. **Historical
Precedent** ✅ Analysis of similar bq27xxx commits shows consistent
backporting: - "Fix race condition" (Similar Commit #4): **YES** -
Similar I2C access improvement - "After charger plug in/out wait 0.5s"
(Similar Commit #5): **YES** - Similar stability fix - "make status more
robust" (Similar Commit #2): **YES** - Similar robustness improvement
### 6. **Follows Kernel Conventions** ✅ - Standard I2C retry mechanisms
are common in the kernel - Proper error code propagation instead of
masking - Code reviewed by subsystem maintainer (Pali Rohár) - Uses
kernel-standard delay functions ### 7. **System Impact** **Improves
stability** by: - Preventing userspace confusion from misleading error
codes - Gracefully handling concurrent access scenarios - Better error
reporting for debugging - No negative side effects identified ### 8.
**Risk Assessment** **Very Low Risk:** - No memory management changes -
No locking mechanism modifications - Standard retry pattern with bounded
attempts - Preserves all existing functionality This commit represents
an ideal stable backport candidate: it fixes a real user-visible bug
with minimal, well-understood code changes that follow established
kernel patterns and have strong historical precedent for backporting in
this driver subsystem.

 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2f31d750a4c1e..93dcebbe11417 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2131,7 +2131,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ba0d22d904295..868e95f0887e1 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


