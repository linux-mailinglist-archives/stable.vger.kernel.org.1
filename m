Return-Path: <stable+bounces-178953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A13CB49882
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1E1BC61F2
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54031B83E;
	Mon,  8 Sep 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gZnKd5Je"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0230ACF0;
	Mon,  8 Sep 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356974; cv=none; b=XZa4O/tWf0WvVSmq+dINCoZSSQ5WTQvQdfreYbxCdpevpfQzN6mPx03dH4pXNCEj/cosbuUc5OSnuBakQiGBqCUgiR4461Jo0ap7QmUWTNrzAh92OB3DPICHrr5PDUN92QVdsBsxCXJO2fyvKZdNjPpHm+8jzmKDht+G7lKXt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356974; c=relaxed/simple;
	bh=zHdgNKydKxrw1fqRJFtZWEZd13udUyK6lu/VL/D0pMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJU0/v3P+On1SS09s3miwe5VctveABPf09oOfBHdfR9rZhXlVY/8hL0MH/1678NaaKhiTZalcTw9qge0xuLMsSyzk+3Q9hDvJlrBFiZeoeLqYA8Uc+w64NCoH8VgC5jc6M6Fwivjr6lAx8nM+sFwQs796c5OoyJcMhGKPGznHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gZnKd5Je; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 57CCFC0000F2;
	Mon,  8 Sep 2025 11:42:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 57CCFC0000F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1757356965;
	bh=zHdgNKydKxrw1fqRJFtZWEZd13udUyK6lu/VL/D0pMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gZnKd5Jecs8rqbYHprlxd/hMi6jxwtHbV31sGvJDDGKItghJE1WMLDKc6NrRY+2tU
	 sYmYjlCObbaHaObAXm10/ggE3it75EYA9pv+pmRA07zv5gEMI0T+cQXKljh9M+Edca
	 2llMRDkZxLSW1gS+UR4J5BG2T6+reHf1dazb3A5s=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 16D844002F44;
	Mon,  8 Sep 2025 14:42:44 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable <stable@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Ma Ke <make_ruc2021@163.com>,
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH stable 5.4] usb: hub: Fix flushing of delayed work used for post resume purposes
Date: Mon,  8 Sep 2025 11:42:33 -0700
Message-Id: <20250908184233.1596036-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 9bd9c8026341f75f25c53104eb7e656e357ca1a2 upstream

Delayed work that prevents USB3 hubs from runtime-suspending too early
needed to be flushed in hub_quiesce() to resolve issues detected on
QC SC8280XP CRD board during suspend resume testing.

This flushing did however trigger new issues on Raspberry Pi 3B+, which
doesn't have USB3 ports, and doesn't queue any post resume delayed work.

The flushed 'hub->init_work' item is used for several purposes, and
is originally initialized with a 'NULL' work function. The work function
is also changed on the fly, which may contribute to the issue.

Solve this by creating a dedicated delayed work item for post resume work,
and flush that delayed work in hub_quiesce()

Cc: stable <stable@kernel.org>
Fixes: a49e1e2e785f ("usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-usb/aF5rNp1l0LWITnEB@finisterre.sirena.org.uk
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SC8280XP CRD
Tested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250627164348.3982628-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[florian: adjust for lack of hub_{get,put} and timer_delete_sync]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/usb/core/hub.c | 21 ++++++++-------------
 drivers/usb/core/hub.h |  1 +
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1a2039d1b342..63bb62680362 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1030,12 +1030,11 @@ int usb_remove_device(struct usb_device *udev)
 
 enum hub_activation_type {
 	HUB_INIT, HUB_INIT2, HUB_INIT3,		/* INITs must come first */
-	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME, HUB_POST_RESUME,
+	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME,
 };
 
 static void hub_init_func2(struct work_struct *ws);
 static void hub_init_func3(struct work_struct *ws);
-static void hub_post_resume(struct work_struct *ws);
 
 static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 {
@@ -1059,12 +1058,6 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		goto init3;
 	}
 
-	if (type == HUB_POST_RESUME) {
-		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
-		kref_put(&hub->kref, hub_release);
-		return;
-	}
-
 	kref_get(&hub->kref);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1318,8 +1311,8 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		usb_autopm_get_interface_no_resume(
 			to_usb_interface(hub->intfdev));
 
-		INIT_DELAYED_WORK(&hub->init_work, hub_post_resume);
-		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+		queue_delayed_work(system_power_efficient_wq,
+				   &hub->post_resume_work,
 				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
 		return;
 	}
@@ -1344,9 +1337,10 @@ static void hub_init_func3(struct work_struct *ws)
 
 static void hub_post_resume(struct work_struct *ws)
 {
-	struct usb_hub *hub = container_of(ws, struct usb_hub, init_work.work);
+	struct usb_hub *hub = container_of(ws, struct usb_hub, post_resume_work.work);
 
-	hub_activate(hub, HUB_POST_RESUME);
+	usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+	kref_put(&hub->kref, hub_release);
 }
 
 enum hub_quiescing_type {
@@ -1374,7 +1368,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 
 	/* Stop hub_wq and related activity */
 	del_timer_sync(&hub->irq_urb_retry);
-	flush_delayed_work(&hub->init_work);
+	flush_delayed_work(&hub->post_resume_work);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -1921,6 +1915,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	hub->hdev = hdev;
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
+	INIT_DELAYED_WORK(&hub->post_resume_work, hub_post_resume);
 	INIT_WORK(&hub->events, hub_event);
 	spin_lock_init(&hub->irq_urb_lock);
 	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 1c455800f7d3..de29ce856953 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -69,6 +69,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
+	struct delayed_work	post_resume_work;
 	struct work_struct      events;
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;
-- 
2.34.1


