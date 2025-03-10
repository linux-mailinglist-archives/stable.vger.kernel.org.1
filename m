Return-Path: <stable+bounces-122315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BAA59EF1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5E188B2EC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1923026D;
	Mon, 10 Mar 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z4fThMJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DE1DE89C;
	Mon, 10 Mar 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628147; cv=none; b=FiwQn9KgOm3wD9UST8uWZKVX7YjSMAAS63L22j01I5I0SrMtjpJrfRKFw1QnlGxhz4wTS10pSH1+g8jH1flBleKDh/0qR9+0VnP6lvTpzgXJWiAS8v7q6Bgg/CLGl1ws908R1WlBIb63R3QKjLcymg7Wy/6DgcsanEXArZ2jyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628147; c=relaxed/simple;
	bh=9s1Q0EWvNI0b42lTfgVxa3dnCrWEmt6PONkCZO8Fkfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj34zB45OQiWaPSh9SSKg4mGnc8sTTCC348PsY9vfX5JlWFdPfzlBet5eCOjYTEEwPCIcswSexgsVWG6R1m5OCbob13EKk/sqFM1dvfodP2uNteD7/jsTg4adRrqTHdEiLZAb/0jYBr4IUhdcXUamUYNyKCP3mnV8VU11Ib1Wm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z4fThMJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9425EC4CEE5;
	Mon, 10 Mar 2025 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628147;
	bh=9s1Q0EWvNI0b42lTfgVxa3dnCrWEmt6PONkCZO8Fkfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z4fThMJVPuAHkOtGzHrkW972dvxT4zcSTXcScs7NnQsCERGItKsNQ0aJLAPZoJBRD
	 Snaho8zT+hh+ZoCyRV7cvJW8IFvE+f0vjxD1RBZX2kX9bo/snbS15YWEcv8Y81dheE
	 HoXAxrf8TwWSFeZ+RFz7TjvITv3p5lfDdkt3JlFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 071/145] ALSA: usx2y: validate nrpacks module parameter on probe
Date: Mon, 10 Mar 2025 18:06:05 +0100
Message-ID: <20250310170437.616698445@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 172a0f509723fe4741d4b8e9190cf434b18320d8 ]

The module parameter defines number of iso packets per one URB. User is
allowed to set any value to the parameter of type int, which can lead to
various kinds of weird and incorrect behavior like integer overflows,
truncations, etc. Number of packets should be a small non-negative number.

Since this parameter is read-only, its value can be validated on driver
probe.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Link: https://patch.msgid.link/20250303100413.835-1-m.masimov@mt-integration.ru
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usbusx2y.c      | 11 +++++++++++
 sound/usb/usx2y/usbusx2y.h      | 26 ++++++++++++++++++++++++++
 sound/usb/usx2y/usbusx2yaudio.c | 27 ---------------------------
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4c4ce0319d624..0fe989a633769 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -151,6 +151,12 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
+module_param(nrpacks, int, 0444);
+MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
+#endif
+
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
  */
@@ -433,6 +439,11 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+	if (nrpacks < 0 || nrpacks > USX2Y_NRPACKS_MAX)
+		return -EINVAL;
+#endif
+
 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 8d82f5cc2fe1c..0538c457921e6 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -7,6 +7,32 @@
 
 #define NRURBS	        2
 
+/* Default value used for nr of packs per urb.
+ * 1 to 4 have been tested ok on uhci.
+ * To use 3 on ohci, you'd need a patch:
+ * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
+ * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
+ *
+ * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
+ * Bigger is safer operation, smaller gives lower latencies.
+ */
+#define USX2Y_NRPACKS 4
+
+#define USX2Y_NRPACKS_MAX 1024
+
+/* If your system works ok with this module's parameter
+ * nrpacks set to 1, you might as well comment
+ * this define out, and thereby produce smaller, faster code.
+ * You'd also set USX2Y_NRPACKS to 1 then.
+ */
+#define USX2Y_NRPACKS_VARIABLE 1
+
+#ifdef USX2Y_NRPACKS_VARIABLE
+extern int nrpacks;
+#define nr_of_packs() nrpacks
+#else
+#define nr_of_packs() USX2Y_NRPACKS
+#endif
 
 #define URBS_ASYNC_SEQ 10
 #define URB_DATA_LEN_ASYNC_SEQ 32
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 5197599e7aa61..98d0e8edc9832 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -28,33 +28,6 @@
 #include "usx2y.h"
 #include "usbusx2y.h"
 
-/* Default value used for nr of packs per urb.
- * 1 to 4 have been tested ok on uhci.
- * To use 3 on ohci, you'd need a patch:
- * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
- * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
- *
- * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
- * Bigger is safer operation, smaller gives lower latencies.
- */
-#define USX2Y_NRPACKS 4
-
-/* If your system works ok with this module's parameter
- * nrpacks set to 1, you might as well comment
- * this define out, and thereby produce smaller, faster code.
- * You'd also set USX2Y_NRPACKS to 1 then.
- */
-#define USX2Y_NRPACKS_VARIABLE 1
-
-#ifdef USX2Y_NRPACKS_VARIABLE
-static int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
-#define  nr_of_packs() nrpacks
-module_param(nrpacks, int, 0444);
-MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
-#else
-#define nr_of_packs() USX2Y_NRPACKS
-#endif
-
 static int usx2y_urb_capt_retire(struct snd_usx2y_substream *subs)
 {
 	struct urb	*urb = subs->completed_urb;
-- 
2.39.5




