Return-Path: <stable+bounces-170069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97351B2A219
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B633AF57E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73C31770C;
	Mon, 18 Aug 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wo+Xcl5P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB726F2AF;
	Mon, 18 Aug 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521411; cv=none; b=AQr9uAIm8S8eEvaK3fc02CF3vr2TXCsfDSQ/WlYskMNfeqMvZfc0zjBkDZpUnKVsATPbU3iVy8eL1qBXWs+wB4PUGc23vWGoZuKdOkEbzXkBLeSGuoic9/DOI6yI+eRlkCGoxbAlvN3wn1ZNIvlXUJ1/+tyDcc2GndrAeks4ueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521411; c=relaxed/simple;
	bh=hK7mYambFNHRh6d+36E7DoftwHMIdph5qt3+5vTbrD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st/RiF92ht7F92iLpv1AnXDvRZ7AP2lokDZzkZKcb9dRuamJq/QEodZo2Rm4UFC4z3HLk1HQmoPnmTUZdZnWh6ZttcpGi3cnEOQRRepwD10zQO4vQMIMsrsT2C7zLFdIRwV0Re6PUZDwMEVwS3Km6/iOgCHQJOSXHxtvK2g4DYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wo+Xcl5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C4C4CEF1;
	Mon, 18 Aug 2025 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521411;
	bh=hK7mYambFNHRh6d+36E7DoftwHMIdph5qt3+5vTbrD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wo+Xcl5PAaOroGa64qPNbtXudMhSXPc+OTadEcEdVmKlkF92SXjSh8N/O8jkCyyHh
	 +st0sfY6jsMvZgYlhFE/WL7HTaGrXWoPeeXB0Z3C13Iu7vMUYzuiRm8tD16hLeeX9Q
	 qAK8hFrvNj3MUCtq1VxOD4rBFL2K13LsSdBGQPLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.12 013/444] Revert "leds: trigger: netdev: Configure LED blink interval for HW offload"
Date: Mon, 18 Aug 2025 14:40:39 +0200
Message-ID: <20250818124449.399860651@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: Daniel Golle <daniel@makrotopia.org>

commit 26f732791f2bcab18f59c61915bbe35225f30136 upstream.

This reverts commit c629c972b310af41e9e072febb6dae9a299edde6.

While .led_blink_set() would previously put an LED into an unconditional
permanently blinking state, the offending commit now uses same operation
to (also?) set the blink timing of the netdev trigger when offloading.

This breaks many if not all of the existing PHY drivers which offer
offloading LED operations, as those drivers would just put the LED into
blinking state after .led_blink_set() has been called.

Unfortunately the change even made it into stable kernels for unknown
reasons, so it should be reverted there as well.

Fixes: c629c972b310a ("leds: trigger: netdev: Configure LED blink interval for HW offload")
Link: https://lore.kernel.org/linux-leds/c6134e26-2e45-4121-aa15-58aaef327201@lunn.ch/T/#m9d6fe81bbcb273e59f12bbedbd633edd32118387
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/6dcc77ee1c9676891d6250d8994850f521426a0f.1752334655.git.daniel@makrotopia.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/trigger/ledtrig-netdev.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -68,7 +68,6 @@ struct led_netdev_data {
 	unsigned int last_activity;
 
 	unsigned long mode;
-	unsigned long blink_delay;
 	int link_speed;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_link_modes);
 	u8 duplex;
@@ -87,10 +86,6 @@ static void set_baseline_state(struct le
 	/* Already validated, hw control is possible with the requested mode */
 	if (trigger_data->hw_control) {
 		led_cdev->hw_control_set(led_cdev, trigger_data->mode);
-		if (led_cdev->blink_set) {
-			led_cdev->blink_set(led_cdev, &trigger_data->blink_delay,
-					    &trigger_data->blink_delay);
-		}
 
 		return;
 	}
@@ -459,11 +454,10 @@ static ssize_t interval_store(struct dev
 			      size_t size)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
-	struct led_classdev *led_cdev = trigger_data->led_cdev;
 	unsigned long value;
 	int ret;
 
-	if (trigger_data->hw_control && !led_cdev->blink_set)
+	if (trigger_data->hw_control)
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 0, &value);
@@ -472,13 +466,9 @@ static ssize_t interval_store(struct dev
 
 	/* impose some basic bounds on the timer interval */
 	if (value >= 5 && value <= 10000) {
-		if (trigger_data->hw_control) {
-			trigger_data->blink_delay = value;
-		} else {
-			cancel_delayed_work_sync(&trigger_data->work);
+		cancel_delayed_work_sync(&trigger_data->work);
 
-			atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
-		}
+		atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
 		set_baseline_state(trigger_data);	/* resets timer */
 	}
 



