Return-Path: <stable+bounces-154682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF0ADF0A0
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 17:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2824C3BB806
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED12EE60A;
	Wed, 18 Jun 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsS3jV6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF02EE5FA;
	Wed, 18 Jun 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258766; cv=none; b=Y8CKtCyQ0eKps+m8INz2twlHVr5L/TLPqyHuWgz13jr3JuBtEM/AjCmLAaN3gB9vDby9ujzTazGdP93Z+DrzA1P/YvderletT0BFvrhVb2I2Kjg4oSz1dUmyTu1iNG56bMknYOwhKqDoywmtXXWsaFMgseUqirnlYMIPALRQ3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258766; c=relaxed/simple;
	bh=cs1Db0BDfz/bQuqwYQJOMaP+w8CnoTTGki8npIoLIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVL/Yb38flR1v8DZ2f2DBzvXpMgKMe+KtiLjmXdUoDnmX9S9genR8de8nHve25rLiQWT0rkKAn+N7xdfiqNB1rq3LpUaCW643g5EYokQvRq9055nT9uEj2Ao654h/z7ANvVaztVSwYKJJoWD+XAWpOFOG9lHIJU6iG2IFwRmGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsS3jV6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B5C4CEE7;
	Wed, 18 Jun 2025 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258765;
	bh=cs1Db0BDfz/bQuqwYQJOMaP+w8CnoTTGki8npIoLIOE=;
	h=From:To:Cc:Subject:Date:From;
	b=gsS3jV6HFZ+H3A4EMbzUIxkGB7epfFYHqz4qyqxW7SygDAM5HJ6OHUDvITGR19z6O
	 8QWT5wX43EijcvniFfIa4syGusXgkZc2MTQZpdBXYBGZjWms71eDk0QXL1yJBZbwjF
	 DUQGKra8bnh1u6Qmvpb88740gu+tgmUyFgCvnOzptQzvkH8KDVpRqxzad2Xij4SaWZ
	 vjiB7K5nD8ctXjAl+d1v1Y4hq8Jso7YjN0NP8w9So2ojV78KmkXF380vRYrRBFhPC7
	 uxWDVbpfg/p81oiawEDZUVh4p6420sZ1CiZtprzMRkdiYNuc2LR444AqPGVUHFpBCi
	 qM2L5e78i9z/A==
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
Subject: [PATCH] thunderbolt: Fix wake on connect at runtime
Date: Wed, 18 Jun 2025 09:59:10 -0500
Message-ID: <20250618145911.3266251-1-superm1@kernel.org>
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
 drivers/thunderbolt/switch.c | 8 ++++----
 drivers/thunderbolt/tb.h     | 2 +-
 drivers/thunderbolt/usb4.c   | 9 ++++-----
 3 files changed, 9 insertions(+), 10 deletions(-)

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
index fce3c0f2354a7..e7d8cf0c1da1b 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -406,7 +406,7 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
  *
  * Enables/disables router to wake up from sleep.
  */
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
 	struct usb4_port *usb4;
 	struct tb_port *port;
@@ -438,13 +438,12 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 			val |= PORT_CS_19_WOU4;
 		} else {
 			bool configured = val & PORT_CS_19_PC;
+			bool wakeup = runtime || device_may_wakeup(&usb4->dev);
 			usb4 = port->usb4;
 
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


