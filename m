Return-Path: <stable+bounces-183332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C1BB826B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4F8B346D00
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0817253B73;
	Fri,  3 Oct 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax4elnlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B7253951
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524940; cv=none; b=JwYhFMbpVK7dLPNMe1t7dVCcKMjlvxQMWBj6FvlTs9qXRIzJ1c86n/zGXucXYOZcOD2uRlq6t1nQdkgwRtBPqjOuXuz0Bwua6oP304E+qSthvqtwL0ZSThi6uXOhmYxNTnFL7H2eQ37fDfWIHV9uVqXD/nvmNUJRv85xSki/lAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524940; c=relaxed/simple;
	bh=2YVS0bxkYB7GaTeSYgGEgQffDmNiJwuwRw4+Je3UG+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjKXrXTEyO5vZ8+AlOHAEz5d9D7ZZhntN7e8JxY8CFpsCnUVyE4qW/d7hEN9RB16uSxjQ3SOnrrxuyZl4e3FC2CetoDxI7fwxv3/QT1h9mTFphREv/vsa8s8WfdIUE87nPBJ5qYMW2AB31ULzdZmB177V6OMADEBDM5PZ54It4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax4elnlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD46C4CEF5;
	Fri,  3 Oct 2025 20:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524940;
	bh=2YVS0bxkYB7GaTeSYgGEgQffDmNiJwuwRw4+Je3UG+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax4elnlPrr5ME5jT++Ka60C/QzlgbpXqkeEo/R2RNZwlvi5qyM07oeN5rN3hdKwR6
	 JZ8141viL027e3u4qfDnWhYopFiiLtUtE2MSOIQBkGuLWAsqZVSq31209HNEyi8N6u
	 zJYrvPrjAP/Ggd0cAN17aL4CApFWdf62t+5a4NJj7xqm/4CZAFywj1bLTDLbIdwCT/
	 eVfAKJDtnae9MVB5ygi05O0SmKKBoF7bgZVXmkdun01Mnip2F8Ev3aLhWxK3vIGmhb
	 XtEp8yI8Hb+EhcM5Dm40ca6t61OYZIbYBjNtDHUcPlhJkASjmOZwK61RHXqIF6PUFX
	 Vgkv1QsfRfe7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Flavius Georgescu <pretoriano.mp@gmail.com>,
	Chris Vandomelen <chris@sightworks.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/4] media: rc: Add support for another iMON 0xffdc device
Date: Fri,  3 Oct 2025 16:55:34 -0400
Message-ID: <20251003205537.3386848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100320-pout-unwired-1096@gregkh>
References: <2025100320-pout-unwired-1096@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Flavius Georgescu <pretoriano.mp@gmail.com>

[ Upstream commit cf330691668a3bee37b8ac8212709b3ccdd87997 ]

The device it's an iMON UltraBay (0x98 in config byte) with LCD,
IR and dual-knobs front panel.

To work properly the device also require its own key table,
and repeat suppression for all buttons.

Signed-off-by: Flavius Georgescu <pretoriano.mp@gmail.com>
Co-developed-by: Chris Vandomelen <chris@sightworks.com>
Signed-off-by: Chris Vandomelen <chris@sightworks.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Stable-dep-of: fa0f61cc1d82 ("media: rc: fix races with imon_disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/imon.c | 61 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 38f6dd12d8706..be4f92d4e6b6b 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -83,6 +83,7 @@ struct imon_usb_dev_descr {
 	__u16 flags;
 #define IMON_NO_FLAGS 0
 #define IMON_NEED_20MS_PKT_DELAY 1
+#define IMON_SUPPRESS_REPEATED_KEYS 2
 	struct imon_panel_key_table key_table[];
 };
 
@@ -149,8 +150,9 @@ struct imon_context {
 	struct timer_list ttimer;	/* touch screen timer */
 	int touch_x;			/* x coordinate on touchscreen */
 	int touch_y;			/* y coordinate on touchscreen */
-	struct imon_usb_dev_descr *dev_descr; /* device description with key
-						 table for front panels */
+	const struct imon_usb_dev_descr *dev_descr;
+					/* device description with key */
+					/* table for front panels */
 };
 
 #define TOUCH_TIMEOUT	(HZ/30)
@@ -315,6 +317,32 @@ static const struct imon_usb_dev_descr imon_DH102 = {
 	}
 };
 
+/* imon ultrabay front panel key table */
+static const struct imon_usb_dev_descr ultrabay_table = {
+	.flags = IMON_SUPPRESS_REPEATED_KEYS,
+	.key_table = {
+		{ 0x0000000f0000ffeell, KEY_MEDIA },      /* Go */
+		{ 0x000000000100ffeell, KEY_UP },
+		{ 0x000000000001ffeell, KEY_DOWN },
+		{ 0x000000160000ffeell, KEY_ENTER },
+		{ 0x0000001f0000ffeell, KEY_AUDIO },      /* Music */
+		{ 0x000000200000ffeell, KEY_VIDEO },      /* Movie */
+		{ 0x000000210000ffeell, KEY_CAMERA },     /* Photo */
+		{ 0x000000270000ffeell, KEY_DVD },        /* DVD */
+		{ 0x000000230000ffeell, KEY_TV },         /* TV */
+		{ 0x000000050000ffeell, KEY_PREVIOUS },   /* Previous */
+		{ 0x000000070000ffeell, KEY_REWIND },
+		{ 0x000000040000ffeell, KEY_STOP },
+		{ 0x000000020000ffeell, KEY_PLAYPAUSE },
+		{ 0x000000080000ffeell, KEY_FASTFORWARD },
+		{ 0x000000060000ffeell, KEY_NEXT },       /* Next */
+		{ 0x000100000000ffeell, KEY_VOLUMEUP },
+		{ 0x010000000000ffeell, KEY_VOLUMEDOWN },
+		{ 0x000000010000ffeell, KEY_MUTE },
+		{ 0, KEY_RESERVED },
+	}
+};
+
 /*
  * USB Device ID for iMON USB Control Boards
  *
@@ -1261,9 +1289,11 @@ static u32 imon_mce_key_lookup(struct imon_context *ictx, u32 scancode)
 
 static u32 imon_panel_key_lookup(struct imon_context *ictx, u64 code)
 {
-	int i;
+	const struct imon_panel_key_table *key_table;
 	u32 keycode = KEY_RESERVED;
-	struct imon_panel_key_table *key_table = ictx->dev_descr->key_table;
+	int i;
+
+	key_table = ictx->dev_descr->key_table;
 
 	for (i = 0; key_table[i].hw_code != 0; i++) {
 		if (key_table[i].hw_code == (code | 0xffee)) {
@@ -1547,7 +1577,6 @@ static void imon_incoming_packet(struct imon_context *ictx,
 	u32 kc;
 	u64 scancode;
 	int press_type = 0;
-	long msec;
 	ktime_t t;
 	static ktime_t prev_time;
 	u8 ktype;
@@ -1649,14 +1678,16 @@ static void imon_incoming_packet(struct imon_context *ictx,
 	spin_lock_irqsave(&ictx->kc_lock, flags);
 
 	t = ktime_get();
-	/* KEY_MUTE repeats from knob need to be suppressed */
-	if (ictx->kc == KEY_MUTE && ictx->kc == ictx->last_keycode) {
-		msec = ktime_ms_delta(t, prev_time);
-		if (msec < ictx->idev->rep[REP_DELAY]) {
+	/* KEY repeats from knob and panel that need to be suppressed */
+	if (ictx->kc == KEY_MUTE ||
+	    ictx->dev_descr->flags & IMON_SUPPRESS_REPEATED_KEYS) {
+		if (ictx->kc == ictx->last_keycode &&
+		    ktime_ms_delta(t, prev_time) < ictx->idev->rep[REP_DELAY]) {
 			spin_unlock_irqrestore(&ictx->kc_lock, flags);
 			return;
 		}
 	}
+
 	prev_time = t;
 	kc = ictx->kc;
 
@@ -1844,6 +1875,14 @@ static void imon_get_ffdc_type(struct imon_context *ictx)
 		dev_info(ictx->dev, "0xffdc iMON Inside, iMON IR");
 		ictx->display_supported = false;
 		break;
+	/* Soundgraph iMON UltraBay */
+	case 0x98:
+		dev_info(ictx->dev, "0xffdc iMON UltraBay, LCD + IR");
+		detected_display_type = IMON_DISPLAY_TYPE_LCD;
+		allowed_protos = RC_PROTO_BIT_IMON | RC_PROTO_BIT_RC6_MCE;
+		ictx->dev_descr = &ultrabay_table;
+		break;
+
 	default:
 		dev_info(ictx->dev, "Unknown 0xffdc device, defaulting to VFD and iMON IR");
 		detected_display_type = IMON_DISPLAY_TYPE_VFD;
@@ -1975,10 +2014,12 @@ static struct rc_dev *imon_init_rdev(struct imon_context *ictx)
 
 static struct input_dev *imon_init_idev(struct imon_context *ictx)
 {
-	struct imon_panel_key_table *key_table = ictx->dev_descr->key_table;
+	const struct imon_panel_key_table *key_table;
 	struct input_dev *idev;
 	int ret, i;
 
+	key_table = ictx->dev_descr->key_table;
+
 	idev = input_allocate_device();
 	if (!idev)
 		goto out;
-- 
2.51.0


