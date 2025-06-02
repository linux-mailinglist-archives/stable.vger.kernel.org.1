Return-Path: <stable+bounces-148667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17AACA5A7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5615188BA98
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D823076FC;
	Sun,  1 Jun 2025 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLMxTy0h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A73076F0;
	Sun,  1 Jun 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821056; cv=none; b=Zcz3hbvZBADIrP0gv+D54aFQMBdpRUw2o98RdeSMGfM9JBQuGNpHyuxc/sx7KYWB4yBc6VOzs7pM2FNWBKMtuhMVDMVxZL+xS4GMpt54HD8JLEiLcWrvMcuVR+uzX6pTaWLYQYhBDmCphZ3C+J0Y01S8cPSz2keU9CbtZ/6hP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821056; c=relaxed/simple;
	bh=thK2wQvgnbDDySYNTbUyRKwBLSa7IQj4ZrqmNYWBxak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnKv3rDj7GzbDO7uCnXk9fGVPyxTUAJKsDEXL3xDoKO9vQKvt52xR3r/quJif18cyXkSh5dGInA1+W5Z768kJLML5tupPdMogvkY+1HNfjs593gZR05ygIqA2ZJNMYfOz2sC4hURrRiCnqG+Oc54+YrP8Hqg3VM8Ojh4I09pq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLMxTy0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79595C4CEEE;
	Sun,  1 Jun 2025 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821055;
	bh=thK2wQvgnbDDySYNTbUyRKwBLSa7IQj4ZrqmNYWBxak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLMxTy0h6WgMuJLkQWEa/CT3N62k1G54EeWMgQfveO/vI/r43hCXHEjWuNHphNije
	 St2XfiQILkBOBjouIL+uqzQzIdmi5tUrQzgJk9+4EGvjQ/B1N77JAwrJpP0bFkd+oj
	 vzYOtVsCFOCQHY/9psaAOK2euIhyRD6tl3QtYuFpxBVX4pBNjZegNQ219bNykyNPa+
	 5yk40I8K+cY3rMX+Rfat8IMVEeH6U5IdATfs3TVyLb7hg9ZUQzGRQ0y9KMTe+hTNMl
	 TCuzebrZItBvtHSoMijfnjHqb2m8I0vHcX0+SaPf/OPs9nEKw3HAB+jTU9IKeM+1cX
	 iW5MVCtyOnj/Q==
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
Subject: [PATCH AUTOSEL 6.12 89/93] power: supply: bq27xxx: Retrieve again when busy
Date: Sun,  1 Jun 2025 19:33:56 -0400
Message-Id: <20250601233402.3512823-89-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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

Based on my thorough analysis of the commit and examination of the
kernel source code, here is my assessment: **YES** This commit should be
backported to stable kernel trees for the following extensive reasons:
## Primary Analysis ### 1. **Significant User-Facing Bug Fix** The
commit fixes a substantial functional issue where the bq27xxx battery
driver incorrectly returns `-ENODEV` (device not found) when the battery
gauge is merely temporarily busy with `-EBUSY`. This causes: -
**Application Confusion**: Battery monitoring applications and power
management daemons interpret `-ENODEV` as "battery removed/missing"
rather than "device temporarily busy" - **Persistent Wrong State**: The
incorrect ENODEV state persists until the next periodic update
(potentially 5+ seconds), during which all battery properties appear
unavailable - **User Experience Impact**: Users may see incorrect "no
battery detected" warnings or lose power management functionality ### 2.
**Technical Correctness Improvement** The changes fix semantically
incorrect error handling: **In bq27xxx_battery.c (line 2066):** -
**Before**: `return -ENODEV;` when `di->cache.flags < 0` - **After**:
`return di->cache.flags;` (returns actual error code like `-EBUSY`,
`-EIO`) This change ensures applications receive the correct error code
and can make informed decisions about retry logic or user notifications.
**In bq27xxx_battery_i2c.c:** - Adds bounded retry mechanism (max 3
attempts) for `-EBUSY` conditions - Uses appropriate 10ms delay between
retries - Falls back to returning the actual error if retries fail ###
3. **Low Risk Assessment** The changes are well-contained and follow
established kernel patterns: - **Bounded Retries**: Maximum 3 retries
with 10ms delays prevent infinite loops - **Existing Patterns**: Similar
retry mechanisms exist in other I2C drivers throughout the kernel -
**Fallback Safety**: If retries fail, the real error code is properly
propagated - **No ABI Changes**: The power supply interface remains the
same; only error semantics improve ### 4. **Alignment with Stable Tree
Criteria** This commit meets all stable tree requirements: - **Important
Bug Fix**: Resolves user-impacting functional issue - **Small and
Contained**: Changes are minimal and localized to one driver - **No
Architectural Changes**: Uses existing error handling patterns - **Clear
Side Effects**: Improved error reporting with bounded retry behavior -
**Subsystem Confined**: Limited to power supply bq27xxx driver ### 5.
**Comparison with Historical Precedents** Looking at the provided
similar commits, this change aligns with accepted backport patterns: -
Similar to "Fix bq27xxx_battery_update() race condition" (Status: YES) -
fixes driver robustness - Similar to "make status more robust" (Status:
YES) - improves reliability - Unlike "fix reporting critical level"
(Status: NO) which was a flag precedence fix ### 6. **Real-World
Impact** This fix addresses a common scenario in embedded systems and
laptops where: - Multiple applications access battery information
simultaneously - I2C bus contention can cause temporary EBUSY conditions
- Battery monitoring is critical for power management decisions - Users
expect consistent battery status reporting ## Conclusion This commit
represents exactly the type of important bug fix that stable trees are
designed to include: it resolves a significant user-facing issue with
minimal risk, follows established patterns, and improves the robustness
of a critical hardware interface. The semantic correction from ENODEV to
proper error codes, combined with sensible retry logic, makes this a
clear candidate for backporting.

 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1a20c775489c7..871f03d160c53 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2062,7 +2062,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
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


