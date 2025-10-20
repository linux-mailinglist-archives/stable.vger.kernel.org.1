Return-Path: <stable+bounces-188048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF1BF14D4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882BC3A4748
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A182C0F7D;
	Mon, 20 Oct 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om6Loj2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277E258CE1
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964207; cv=none; b=B4uTOL08w3jocrPDxZ4wSq/aG78RQcn/uZG/xAqTPNkGR3AbZ0Xps2B5359BzuAC8dqMG8hYMDqNmwNkzzhiSypp6g/VGFaDj+XeDouFBNN3Pq1d+0evkCJBoENLckwnoGv9TUYUYVtIhUu3Tfcrk+IpnPZW1PI5D/EpskH9tnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964207; c=relaxed/simple;
	bh=wjqu4HxXWrcnrCXlwNsdCBRW602tgURiBD8P4oztI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stgDZXradzkh8FrlXwauPUGIM/C4dCDcX0BIoIRDpJG1fJNt8XRa9vvmwiQSu+kyAq5jW8+a0xsF4yMEcIMOoaN8+A1vjjH8zElHJE4sgsfUZatEZ0cDdkrxmO/IyBVE7oNM/3apD1kD5LwEX5UCm/Fxmb5UOxBqA6KTLaGXhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om6Loj2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE4C4CEF9;
	Mon, 20 Oct 2025 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964206;
	bh=wjqu4HxXWrcnrCXlwNsdCBRW602tgURiBD8P4oztI9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=om6Loj2WlUw1CRSXlQU0IiKowLTZZxmK9sErC2HZhHiTmU/MdrBG+SFEuC3wW+wac
	 sIegcbGpAAwUPlDKYOz6Qr0EzLP4d+YdRuNj88J9OSCbnf4Qm5AvTdDaGuHINXgv6z
	 ZRWEIfJjk3OVCNS6cgA7hFYNowLHWbbwVBPVh35AtdPi/xSJvxFcGwi/6Q+XWPgX4x
	 Cjujb8N9Tj2BU7SU8Z1CQQqdJOavxtWyQaMpSH8Vj5S0zpbhUt6vEpEe7MOMifytIP
	 OohcRGNInueBcWEqHbL6jIC0no3U9q9buIxxk+68pLNaBAFRjNafXFDThF1KGMpNFm
	 y4EXW4i25qIdQ==
From: bentiss@kernel.org
To: stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.12.y] HID: multitouch: fix sticky fingers
Date: Mon, 20 Oct 2025 14:43:15 +0200
Message-ID: <20251020124315.2908333-1-bentiss@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102008-likewise-rubbing-d48b@gregkh>
References: <2025102008-likewise-rubbing-d48b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

commit 46f781e0d151844589dc2125c8cce3300546f92a upstream.

The sticky fingers quirk (MT_QUIRK_STICKY_FINGERS) was only considering
the case when slots were not released during the last report.
This can be problematic if the firmware forgets to release a finger
while others are still present.

This was observed on the Synaptics DLL0945 touchpad found on the Dell
XPS 9310 and the Dell Inspiron 5406.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-multitouch.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5c424010bc02..0667a24576fc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -83,9 +83,8 @@ enum latency_mode {
 	HID_LATENCY_HIGH = 1,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -160,7 +159,11 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
+					 * first 8 bits are reserved for keeping the slot
+					 * states, this is fine because we only support up
+					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
@@ -941,6 +944,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -972,12 +976,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-
-	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
-		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	else
-		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_compute_timestamp(struct mt_application *app, __s32 value)
@@ -1152,7 +1150,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1287,7 +1287,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1734,6 +1734,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1756,7 +1757,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
-- 
2.51.0


