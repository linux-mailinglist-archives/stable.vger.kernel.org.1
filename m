Return-Path: <stable+bounces-154833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3FAE0F0F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB0117F9B8
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B225EF82;
	Thu, 19 Jun 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwkzE02N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A830E852;
	Thu, 19 Jun 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369127; cv=none; b=Aw1o4qdw4Pd6aJHYXbJsf3qs/nmu9/rouaKzmZY+ecSl8ielMJMptxkGUb8Zx/jTbZqpMnesash6CvbJfgv7D07NYCDT+8WjHJRoHlWUhnpVlYya+3zGP2zGDeVRgVMF+phX4D6ctsE4P90UBTwBPjrQVIl74lU0FKXbpjv4LXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369127; c=relaxed/simple;
	bh=YNyiPSE7HZZ87s/g6MlC+lW8J3v+Jf82ttdx8O3KidQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qel8n5Lx/xrCdXvVFdnNj7+VlHg80kFtpJuiJUx7JywpXhlSJQbAUramhqpCO8bzcJ4ekO5ANHZW73BOoWmFDKkgoFf94gAZrJ7MDEOkGXiWDkIaWqfT+Jk/03ZwzYuSbkTHWi5TYy9krZeC28+H+s2lzvtZe4XN6VQNt1CBCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwkzE02N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2979C4CEEA;
	Thu, 19 Jun 2025 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750369125;
	bh=YNyiPSE7HZZ87s/g6MlC+lW8J3v+Jf82ttdx8O3KidQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YwkzE02Ne6Rlysam6Jyz+qemzG5r+V1TuUx4ounYzbzeyqx46cjJgNm1DUej0Xwrt
	 /zVmG8tOJDFAvViQDBjgq2y8CivnOOo9R9y8IftYukwL9fhJfhX0b6YRtMPc3J8PHF
	 qBx3LhsG3rrgnsT0jZdPE579j928l628WvRZJvrTMn4E8Ejkhpwtu5+/l45BwDGRZJ
	 peX2qtqHxgPAUICAg3EvS9zZlxGhBxw0bJkdrKt1rg2bVHgAsoAAHxYnsSAU3peY1v
	 +tER/KHTJErr69sUw30b6EYD506YY9KNS8bQVrfk1iLmFdmh5+VsaZmaCR7pcvIgyG
	 MDgBSgxPjQJTQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com
Cc: stable@vger.kernel.org,
	Alexander Kovacs <Alexander.Kovacs@amd.com>,
	mika.westerberg@linux.intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH v3] thunderbolt: Fix wake on connect at runtime
Date: Thu, 19 Jun 2025 16:38:30 -0500
Message-ID: <20250619213840.2388646-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
fixated on the USB4 port sysfs wakeup file not working properly to control
policy, but it had an unintended side effect that the sysfs file controls
policy both at runtime and at suspend time. The sysfs file is supposed to
only control behavior while system is suspended.

Pass whether programming a port for runtime into usb4_switch_set_wake()
and if runtime then ignore the value in the sysfs file.

Cc: stable@vger.kernel.org
Reported-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
Tested-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
Fixes: 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * fix a suspend failure
v2:
 * Fix kdoc issue reported by lkp robot
---
 drivers/thunderbolt/switch.c |  8 ++++----
 drivers/thunderbolt/tb.h     |  2 +-
 drivers/thunderbolt/usb4.c   | 12 +++++-------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 28febb95f8fa1..e9809fb57c354 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -3437,7 +3437,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 	}
 }
 
-static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
 	if (flags)
 		tb_sw_dbg(sw, "enabling wakeup: %#x\n", flags);
@@ -3445,7 +3445,7 @@ static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 		tb_sw_dbg(sw, "disabling wakeup\n");
 
 	if (tb_switch_is_usb4(sw))
-		return usb4_switch_set_wake(sw, flags);
+		return usb4_switch_set_wake(sw, flags, runtime);
 	return tb_lc_set_wake(sw, flags);
 }
 
@@ -3521,7 +3521,7 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
 		tb_switch_check_wakes(sw);
 
 	/* Disable wakes */
-	tb_switch_set_wake(sw, 0);
+	tb_switch_set_wake(sw, 0, true);
 
 	err = tb_switch_tmu_init(sw);
 	if (err)
@@ -3603,7 +3603,7 @@ void tb_switch_suspend(struct tb_switch *sw, bool runtime)
 		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
 	}
 
-	tb_switch_set_wake(sw, flags);
+	tb_switch_set_wake(sw, flags, runtime);
 
 	if (tb_switch_is_usb4(sw))
 		usb4_switch_set_sleep(sw);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 87afd5a7c504b..f503bad864130 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1317,7 +1317,7 @@ int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 			  size_t size);
 bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags);
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime);
 int usb4_switch_set_sleep(struct tb_switch *sw);
 int usb4_switch_nvm_sector_size(struct tb_switch *sw);
 int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index fce3c0f2354a7..fdae76c8f728e 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -403,12 +403,12 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
  * usb4_switch_set_wake() - Enabled/disable wake
  * @sw: USB4 router
  * @flags: Wakeup flags (%0 to disable)
+ * @runtime: Wake is being programmed during system runtime
  *
  * Enables/disables router to wake up from sleep.
  */
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
-	struct usb4_port *usb4;
 	struct tb_port *port;
 	u64 route = tb_route(sw);
 	u32 val;
@@ -438,13 +438,11 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 			val |= PORT_CS_19_WOU4;
 		} else {
 			bool configured = val & PORT_CS_19_PC;
-			usb4 = port->usb4;
+			bool wakeup = runtime || device_may_wakeup(&port->usb4->dev);
 
-			if (((flags & TB_WAKE_ON_CONNECT) &&
-			      device_may_wakeup(&usb4->dev)) && !configured)
+			if ((flags & TB_WAKE_ON_CONNECT) && wakeup && !configured)
 				val |= PORT_CS_19_WOC;
-			if (((flags & TB_WAKE_ON_DISCONNECT) &&
-			      device_may_wakeup(&usb4->dev)) && configured)
+			if ((flags & TB_WAKE_ON_DISCONNECT) && wakeup && configured)
 				val |= PORT_CS_19_WOD;
 			if ((flags & TB_WAKE_ON_USB4) && configured)
 				val |= PORT_CS_19_WOU4;
-- 
2.43.0


