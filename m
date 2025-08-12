Return-Path: <stable+bounces-167233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2117B22D2A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67BC7A82B5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DE2F8BF6;
	Tue, 12 Aug 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRX1jwWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF72F8BF5
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015684; cv=none; b=u39lL8MuFxlVY4cAIw95K7+/hojKm5qOjIxnrcq/h0XzjDNJpVO6mgoKp2JSefglcQkgQ53QCxNRJ6LthmGpCLv9/q+bBeISNsHFazuPIcWqZ2bXercYVAMX8/wN9GoB2lwakCk+ZmxpOE69fUGXGkFnWUCFM0x1jvFJ7CfSNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015684; c=relaxed/simple;
	bh=KEIc+EhLyS0Tk1srYE119a/UFTVUCx3M+3rN2E0kU8Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cjuDQiKxzWObVUS3Y/v5lley0mZnWXJQ0MR+c3oydjbGLIjCkz7CneeNv8n2OZjEXDVrBKZLzLEwJSLo9OmOxBM1YA1Q+CVAQCBcSrpXlfS6esgDpTMkB/dHYhX2xyBuIVvWg90zPOEgqfo8wtKKyHP1+DD3Kxyzg0rGp2qrKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRX1jwWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7BCC4CEF0;
	Tue, 12 Aug 2025 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015684;
	bh=KEIc+EhLyS0Tk1srYE119a/UFTVUCx3M+3rN2E0kU8Y=;
	h=Subject:To:Cc:From:Date:From;
	b=yRX1jwWu7AFXBD6buTS6K7l0mm3wfc37jNKOsEOswhPGeFWW32bUeec9tbMrZ/xSv
	 OrcI4x7Ifyhz1Bm+i4Hhj3NzYpSLr4aNxkSSfOeX7N7KKGTolMeZ+dt+pbNOlowyTu
	 yyQRoHbErShHoex9Tj6rUMY2+3ka8qVUnLI5hpVk=
Subject: FAILED: patch "[PATCH] HID: apple: avoid setting up battery timer for devices" failed to apply to 6.1-stable tree
To: gargaditya08@live.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:21:02 +0200
Message-ID: <2025081202-delirium-stubborn-aa45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c061046fe9ce3ff31fb9a807144a2630ad349c17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081202-delirium-stubborn-aa45@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c061046fe9ce3ff31fb9a807144a2630ad349c17 Mon Sep 17 00:00:00 2001
From: Aditya Garg <gargaditya08@live.com>
Date: Mon, 30 Jun 2025 12:37:13 +0000
Subject: [PATCH] HID: apple: avoid setting up battery timer for devices
 without battery

Currently, the battery timer is set up for all devices using hid-apple,
irrespective of whether they actually have a battery or not.

APPLE_RDESC_BATTERY is a quirk that indicates the device has a battery
and needs the battery timer. This patch checks for this quirk before
setting up the timer, ensuring that only devices with a battery will
have the timer set up.

Fixes: 6e143293e17a ("HID: apple: Report Magic Keyboard battery over USB")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 0639b1f43d88..8ab15a8f3524 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -933,10 +933,12 @@ static int apple_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
-	mod_timer(&asc->battery_timer,
-		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
-	apple_fetch_battery(hdev);
+	if (quirks & APPLE_RDESC_BATTERY) {
+		timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
+		mod_timer(&asc->battery_timer,
+			  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
+		apple_fetch_battery(hdev);
+	}
 
 	if (quirks & APPLE_BACKLIGHT_CTL)
 		apple_backlight_init(hdev);
@@ -950,7 +952,9 @@ static int apple_probe(struct hid_device *hdev,
 	return 0;
 
 out_err:
-	timer_delete_sync(&asc->battery_timer);
+	if (quirks & APPLE_RDESC_BATTERY)
+		timer_delete_sync(&asc->battery_timer);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -959,7 +963,8 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&asc->battery_timer);
+	if (asc->quirks & APPLE_RDESC_BATTERY)
+		timer_delete_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }


