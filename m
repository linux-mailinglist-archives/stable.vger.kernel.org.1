Return-Path: <stable+bounces-111292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB5A22E57
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97FE3A3CA6
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F61E501C;
	Thu, 30 Jan 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMxa8/zT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165431BEF85;
	Thu, 30 Jan 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245586; cv=none; b=Pu9NOHFSwtixMdWJp9j07lXH/U6Y1dvC/RgZAkJU3FZ9YepHJLg8XV/js3vU+aMvJ5fztcu55h9c/684Xo8+BwGlrM3p6wzMpeX3ouVTeNrnm9+aQtpy5Qt9Vc4MZ4L+22JzfIKnOjCj1JyK9nCLryy/uDdXOPwCn69ifhXEYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245586; c=relaxed/simple;
	bh=A1wJzLROVrv99jLQwhAqzunw/sMwBV10QeA9NRYA1FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0jBctB46kZ//pKcm8UiuIvPl2GRLZqnQUH5ycbDJI8BEVosclqpGrpza7tl0PM0oCuAkR8dVbUN1XW7Dv1UVLXs6SAFGaTpiUnVtfJED6rFrl3mOA53xl27Fmk2fTfXt9mFh5/nKDFwb6MhrY2TB3UBQWcoRO+SEPmHv29Zg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMxa8/zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACFBC4CEE2;
	Thu, 30 Jan 2025 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245585;
	bh=A1wJzLROVrv99jLQwhAqzunw/sMwBV10QeA9NRYA1FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMxa8/zTTdHRy5oicoZMqkGjBGlf3gDnqjIXGCYlU/l5e4iDk5EN7dZp7wVpgye7i
	 Cg/2G3mjxShHlGhiME/y4cBWfYSzd4KyPWEdR7Pdm3HzagVBxQvbAAMt38oi/5tVPC
	 xKz+Q15BwlvM7Q7dYz2yBsE7zYkzWm7+Pg1/fRBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.13 17/25] HID: wacom: Initialize brightness of LED trigger
Date: Thu, 30 Jan 2025 14:59:03 +0100
Message-ID: <20250130133457.633100059@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
References: <20250130133456.914329400@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gerecke <jason.gerecke@wacom.com>

commit 88006b8eca63467cf1b28fed839f4954c578eeff upstream.

If an LED has a default_trigger set prior to being registered with
the subsystem, that trigger will be executed with a brightness value
defined by `trigger->brightness`. Our driver was not setting this
value, which was causing problems. It would cause the selected LED
to be turned off, as well as corrupt the hlv/llv values assigned to
other LEDs (since calling `wacom_led_brightness_set` will overite
these values).

This patch sets the value of `trigger->brightness` to an appropriate
value. We use `wacom_leds_brightness_get` to transform the llv/hlv
values into a brightness that is understood by the rest of the LED
subsystem.

Fixes: 822c91e72eac ("leds: trigger: Store brightness set by led_trigger_event()")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_sys.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1370,17 +1370,6 @@ static int wacom_led_register_one(struct
 	if (!name)
 		return -ENOMEM;
 
-	if (!read_only) {
-		led->trigger.name = name;
-		error = devm_led_trigger_register(dev, &led->trigger);
-		if (error) {
-			hid_err(wacom->hdev,
-				"failed to register LED trigger %s: %d\n",
-				led->cdev.name, error);
-			return error;
-		}
-	}
-
 	led->group = group;
 	led->id = id;
 	led->wacom = wacom;
@@ -1397,6 +1386,19 @@ static int wacom_led_register_one(struct
 		led->cdev.brightness_set = wacom_led_readonly_brightness_set;
 	}
 
+	if (!read_only) {
+		led->trigger.name = name;
+		if (id == wacom->led.groups[group].select)
+			led->trigger.brightness = wacom_leds_brightness_get(led);
+		error = devm_led_trigger_register(dev, &led->trigger);
+		if (error) {
+			hid_err(wacom->hdev,
+				"failed to register LED trigger %s: %d\n",
+				led->cdev.name, error);
+			return error;
+		}
+	}
+
 	error = devm_led_classdev_register(dev, &led->cdev);
 	if (error) {
 		hid_err(wacom->hdev,



