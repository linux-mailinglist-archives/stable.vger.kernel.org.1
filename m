Return-Path: <stable+bounces-188028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94080BF0600
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC0C189DF5D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA42EA146;
	Mon, 20 Oct 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq96LeqH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B92E2DD4
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954633; cv=none; b=mkPzlcj5njXYiFDQUnvWjcH0COOsrrbHngPBbTOVpW7y1UcMT9eGPdPrq/yYzwZsXFMTp1WkzC8PjqwfcYnN6/kqGek8Mu5NF7k+NjDcPm5OLXHKbu/3JfZXYOpdeqGKNxB9AMXU+WskH9my5dyt9l4JORtXhgurPf7MijlmXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954633; c=relaxed/simple;
	bh=lO3ZGWgXQV7OEi157RoQZmp+0QRH7ycenw5dcr8g0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI0FX/HsgARcLUcYZO8m2HU3f9FCzipoqDJNg+DT6JuufeYzqCuDEV8XaWRrIXCfZGJc3ushxraYTy7jL6QHsdTnTGPghjxT9sHYOQog6MDJb8RepSQT69UjcQQWWCwaL+9bPlIymWxvPGyx09hEJCQ3VkXJ36l6kbHAP1xk6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq96LeqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C462BC4CEF9;
	Mon, 20 Oct 2025 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760954632;
	bh=lO3ZGWgXQV7OEi157RoQZmp+0QRH7ycenw5dcr8g0Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq96LeqHmpJle+d9YnkwbE7wCYqOaPfQCLVpWyJLc3xhC9LZpKtsGkuCaZMPMiQPP
	 oXVuGIqM4R7OGrqb5ba99Ow0HW1uyjaEDC3oTXTkYl7RVGyfh60U2SIhub6xMTDFKp
	 aYwJ8mrEtfgnsUBrm5PlQSGZtXlAYlcmqIZ8LYc34vvw2dj6YI/E3KmhNpGL7t7SoZ
	 pniUjum0Q7CCyS7ylIyQGb6uuLrjqPg1nSidFoDCpYoA1HnLkd/GZHk6qWjWNeAVxk
	 Ids1FRHGOaGYyy53DmeaR/krwP2vcfgN9S7Z8Yrax3CQOnBr9VGhy3DTAhC+G4MgBI
	 pa/4O3KrlR7IQ==
From: bentiss@kernel.org
To: stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.17.y] HID: multitouch: fix sticky fingers
Date: Mon, 20 Oct 2025 12:03:35 +0200
Message-ID: <20251020100335.2863429-1-bentiss@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102007-puma-shawl-4634@gregkh>
References: <2025102007-puma-shawl-4634@gregkh>
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
index 22c6314a8843..7587a7748a82 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -92,9 +92,8 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -169,7 +168,11 @@ struct mt_device {
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
@@ -977,6 +980,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1008,12 +1012,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
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
@@ -1188,7 +1186,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1323,7 +1323,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1782,6 +1782,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1804,7 +1805,7 @@ static void mt_expired_timeout(struct timer_list *t)
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


