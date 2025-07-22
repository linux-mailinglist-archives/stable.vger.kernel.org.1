Return-Path: <stable+bounces-163916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971FB0DC4F
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34240565726
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C22E266B;
	Tue, 22 Jul 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSXN918q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF8289839;
	Tue, 22 Jul 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192631; cv=none; b=Qwn2mOY6Wn0AJN78HTAA8dViCcBwJRUrNKXdTfzwjW/oenKKSa+efRt5LmppZ0hDrJmnasZO5WxXifgosClqqg8Y4UKTqjVKrjqnhfsNzzvWL8KbzvII5W5rgu9319kweqvO/oyZfSxP9g5SdWy9ZINGCcu1T3FLnCGGvD6xGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192631; c=relaxed/simple;
	bh=9bxVJENcGbSj5q4/cUcZ+gju1rMZK2tspPFqXWsYDBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNpS1T9En/nyiZ1wgb7J32Yb/VNG5ZoSYoWC+Fj2nGhFB7aULutHjpi5pqK+XcZDr5YHObWAYIiqTSSUO+RXoXsYEzd+7LaD1TiVoFlDHwG4Hzv63BYTJJ/efpK1jT6p8n9fjOPDFETHhsbWGaL9QBwEv+nQmuJTbuSWw3ZXh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSXN918q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E3C4CEEB;
	Tue, 22 Jul 2025 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192631;
	bh=9bxVJENcGbSj5q4/cUcZ+gju1rMZK2tspPFqXWsYDBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSXN918qiajWkPVOxXKXfAnb04SiOnDADnJTEJFRX08PXUvjpt5Y7gRMoXttbxVq9
	 cjgwfoRxEEIyhGqJYuLKe+uAm1z1Qiyy6Xu+POWwJErjxRs5pFxxKrNXauU1rmjCWJ
	 GooWyLPZbYo1y8hvvuOR0MIt4umabjOrlbKqmPyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Kovacs <Alexander.Kovacs@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.12 012/158] thunderbolt: Fix wake on connect at runtime
Date: Tue, 22 Jul 2025 15:43:16 +0200
Message-ID: <20250722134341.191651570@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 58d71d4242ce057955c783a14c82270c71f9e1e8 upstream.

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
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c |    8 ++++----
 drivers/thunderbolt/tb.h     |    2 +-
 drivers/thunderbolt/usb4.c   |   12 +++++-------
 3 files changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -3437,7 +3437,7 @@ void tb_sw_set_unplugged(struct tb_switc
 	}
 }
 
-static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
 	if (flags)
 		tb_sw_dbg(sw, "enabling wakeup: %#x\n", flags);
@@ -3445,7 +3445,7 @@ static int tb_switch_set_wake(struct tb_
 		tb_sw_dbg(sw, "disabling wakeup\n");
 
 	if (tb_switch_is_usb4(sw))
-		return usb4_switch_set_wake(sw, flags);
+		return usb4_switch_set_wake(sw, flags, runtime);
 	return tb_lc_set_wake(sw, flags);
 }
 
@@ -3521,7 +3521,7 @@ int tb_switch_resume(struct tb_switch *s
 		tb_switch_check_wakes(sw);
 
 	/* Disable wakes */
-	tb_switch_set_wake(sw, 0);
+	tb_switch_set_wake(sw, 0, true);
 
 	err = tb_switch_tmu_init(sw);
 	if (err)
@@ -3602,7 +3602,7 @@ void tb_switch_suspend(struct tb_switch
 		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
 	}
 
-	tb_switch_set_wake(sw, flags);
+	tb_switch_set_wake(sw, flags, runtime);
 
 	if (tb_switch_is_usb4(sw))
 		usb4_switch_set_sleep(sw);
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1299,7 +1299,7 @@ int usb4_switch_read_uid(struct tb_switc
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 			  size_t size);
 bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags);
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime);
 int usb4_switch_set_sleep(struct tb_switch *sw);
 int usb4_switch_nvm_sector_size(struct tb_switch *sw);
 int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -403,12 +403,12 @@ bool usb4_switch_lane_bonding_possible(s
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
@@ -438,13 +438,11 @@ int usb4_switch_set_wake(struct tb_switc
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



