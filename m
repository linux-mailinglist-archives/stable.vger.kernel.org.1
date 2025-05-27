Return-Path: <stable+bounces-146416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B9AC4678
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 04:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433C53A34EF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267B21ABB0;
	Tue, 27 May 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7e7Qg4o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE6219A8E;
	Tue, 27 May 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313502; cv=none; b=CrsyjoDaEpniwpuPrK7fjedKP8IhB2hoEnl6pMtwlvPnIB5/GTG3ZDfeMQxP9pADxBANZSQmOI9ByHVU8F60/0PuQNfuda6tIYAapMDWAkLmpU32e/KgrJBn190zRLyinNQNMzhuwaCtxCY9Gth0Jfale1mvSquKR1wadu/AXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313502; c=relaxed/simple;
	bh=R2PEg6plFRcyhmnGEeEdIgJYv6gYkuVOVbWsNXQo9OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pAiRDcmpofmG0ZIZfTKxR634JrTfzbboHb8XZKYLbJcbjn8X1zDHR2N5enLoOxW7yAakjMyIhlNgJqVhUxfGAfI43txCh7LriVJHXnwh07+fEud7a6rHmVP5xFFJBNwIzNEt/+fCU8D4wYlTPIoVB1oFggnKavDInEQXEJn+IRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7e7Qg4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EB3C4CEE7;
	Tue, 27 May 2025 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748313501;
	bh=R2PEg6plFRcyhmnGEeEdIgJYv6gYkuVOVbWsNXQo9OI=;
	h=From:To:Cc:Subject:Date:From;
	b=m7e7Qg4oAUiOPj8w8sQEjKOU60MP1US+MiGt9gjnMYVX1E0GaTkWDTGHOAW3/s8Pq
	 SYQYfKZLVNHr8+m3uhNXJZAtSsM6j/pG/i3kJ2d7iEPHgnLTajM1wJiH0KEaRFbJ13
	 P8PkJW51nUq771AXKiUNxXg0Fp9zApTmvyE9BIcqyRTkFKJJBMRxNAUFXIrN9tYgf4
	 Yj4hUklGDbOKlk8tNVmFBtUlR8AZRRxSvcDHD9II4ZqYiTimw6Vqek/MwjLkTm0MIG
	 jT73FZZY1ST1FOHot0dBQ+8ZqUWoJdK8bmn5YKXOOcbpvVza1UxPsoTHwyXEYugk+0
	 XD4+38k6GAZ+A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Valtteri Koskivuori <vkoskiv@gmail.com>,
	Jonathan Woithe <jwoithe@just42.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/2] platform/x86: fujitsu-laptop: Support Lifebook S2110 hotkeys
Date: Mon, 26 May 2025 22:38:18 -0400
Message-Id: <20250527023819.1017446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Valtteri Koskivuori <vkoskiv@gmail.com>

[ Upstream commit a7e255ff9fe4d9b8b902023aaf5b7a673786bb50 ]

The S2110 has an additional set of media playback control keys enabled
by a hardware toggle button that switches the keys between "Application"
and "Player" modes. Toggling "Player" mode just shifts the scancode of
each hotkey up by 4.

Add defines for new scancodes, and a keymap and dmi id for the S2110.

Tested on a Fujitsu Lifebook S2110.

Signed-off-by: Valtteri Koskivuori <vkoskiv@gmail.com>
Acked-by: Jonathan Woithe <jwoithe@just42.net>
Link: https://lore.kernel.org/r/20250509184251.713003-1-vkoskiv@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/fujitsu-laptop.c | 33 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 80929380ec7e3..04ccfdd99e277 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -17,13 +17,13 @@
 /*
  * fujitsu-laptop.c - Fujitsu laptop support, providing access to additional
  * features made available on a range of Fujitsu laptops including the
- * P2xxx/P5xxx/S6xxx/S7xxx series.
+ * P2xxx/P5xxx/S2xxx/S6xxx/S7xxx series.
  *
  * This driver implements a vendor-specific backlight control interface for
  * Fujitsu laptops and provides support for hotkeys present on certain Fujitsu
  * laptops.
  *
- * This driver has been tested on a Fujitsu Lifebook S6410, S7020 and
+ * This driver has been tested on a Fujitsu Lifebook S2110, S6410, S7020 and
  * P8010.  It should work on most P-series and S-series Lifebooks, but
  * YMMV.
  *
@@ -102,7 +102,11 @@
 #define KEY2_CODE			0x411
 #define KEY3_CODE			0x412
 #define KEY4_CODE			0x413
-#define KEY5_CODE			0x420
+#define KEY5_CODE			0x414
+#define KEY6_CODE			0x415
+#define KEY7_CODE			0x416
+#define KEY8_CODE			0x417
+#define KEY9_CODE			0x420
 
 /* Hotkey ringbuffer limits */
 #define MAX_HOTKEY_RINGBUFFER_SIZE	100
@@ -450,7 +454,7 @@ static const struct key_entry keymap_default[] = {
 	{ KE_KEY, KEY2_CODE,            { KEY_PROG2 } },
 	{ KE_KEY, KEY3_CODE,            { KEY_PROG3 } },
 	{ KE_KEY, KEY4_CODE,            { KEY_PROG4 } },
-	{ KE_KEY, KEY5_CODE,            { KEY_RFKILL } },
+	{ KE_KEY, KEY9_CODE,            { KEY_RFKILL } },
 	/* Soft keys read from status flags */
 	{ KE_KEY, FLAG_RFKILL,          { KEY_RFKILL } },
 	{ KE_KEY, FLAG_TOUCHPAD_TOGGLE, { KEY_TOUCHPAD_TOGGLE } },
@@ -474,6 +478,18 @@ static const struct key_entry keymap_p8010[] = {
 	{ KE_END, 0 }
 };
 
+static const struct key_entry keymap_s2110[] = {
+	{ KE_KEY, KEY1_CODE, { KEY_PROG1 } }, /* "A" */
+	{ KE_KEY, KEY2_CODE, { KEY_PROG2 } }, /* "B" */
+	{ KE_KEY, KEY3_CODE, { KEY_WWW } },   /* "Internet" */
+	{ KE_KEY, KEY4_CODE, { KEY_EMAIL } }, /* "E-mail" */
+	{ KE_KEY, KEY5_CODE, { KEY_STOPCD } },
+	{ KE_KEY, KEY6_CODE, { KEY_PLAYPAUSE } },
+	{ KE_KEY, KEY7_CODE, { KEY_PREVIOUSSONG } },
+	{ KE_KEY, KEY8_CODE, { KEY_NEXTSONG } },
+	{ KE_END, 0 }
+};
+
 static const struct key_entry *keymap = keymap_default;
 
 static int fujitsu_laptop_dmi_keymap_override(const struct dmi_system_id *id)
@@ -511,6 +527,15 @@ static const struct dmi_system_id fujitsu_laptop_dmi_table[] = {
 		},
 		.driver_data = (void *)keymap_p8010
 	},
+	{
+		.callback = fujitsu_laptop_dmi_keymap_override,
+		.ident = "Fujitsu LifeBook S2110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S2110"),
+		},
+		.driver_data = (void *)keymap_s2110
+	},
 	{}
 };
 
-- 
2.39.5


