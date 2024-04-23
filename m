Return-Path: <stable+bounces-41178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EC8AFA96
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02FD1F2975F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D5147C9B;
	Tue, 23 Apr 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oaCN5uWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F31143891;
	Tue, 23 Apr 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908730; cv=none; b=WGzWsSg0miiHtzt7AFH+XxrGZFa0Z6EQ5JVDol/6XqhvzaBvpAAMojXQIq0Sj0uboY0aoCRat5JE8TWPjoIIXW8OUJp6FgZ9IAMElT3PhnhapYiMThvSe8vd+5pV68uHSg1orvagN4trE9NgDRgO98Q5bTpfoUzy+T6hK6qh3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908730; c=relaxed/simple;
	bh=a35MloweNs0zFBodwVbtWmTIRxaVZtkVarUdvzdIn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbA3mFetd3Scn3B5xbJOdUmRBvJKBUn0IUKLtatQviOtBYkJpiV5ng+4AoGUcKxhfGDzh9doOdng8J7i/2NVKmKlo46ZLR7GwObOVUBjY5FYgPtLUucr4JaN60JopnLuJcI2gOLkuafmpVO4rsrkn9V7OVWKybS6gLDo3RBdQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oaCN5uWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BD3C32786;
	Tue, 23 Apr 2024 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908730;
	bh=a35MloweNs0zFBodwVbtWmTIRxaVZtkVarUdvzdIn64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaCN5uWj77Ecm4+RF2ymuNyZGgqkcfV1am1qeWtxlhnOy0AvxxkNIpNb+tUdipBGk
	 wNcQ5Z8ew1DMN9CpIMLXLCiPJqUuJStljoZiL+JSIodYFWdHtcx2uK9kjVLd9tQoZ2
	 LeTsA1vnFnBrwIIOSWnideMWpfaHdIOgd7kl89yE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 079/141] ALSA: scarlett2: Rename scarlett_gen2 to scarlett2
Date: Tue, 23 Apr 2024 14:39:07 -0700
Message-ID: <20240423213855.759052560@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geoffrey D. Bennett <g@b4.vu>

[ Upstream commit efc3d7d20361cc59325a9f0525e079333b4459c0 ]

This driver was originally developed for the Focusrite Scarlett Gen 2
series. Since then Focusrite have used a similar protocol for their
Gen 3, Gen 4, Clarett USB, Clarett+, and Vocaster series.

Let's call this common protocol the "Scarlett 2 Protocol" and rename
the driver to scarlett2 to not imply that it is restricted to Gen 2
series devices.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/e1ad7f69a1e20cdb39094164504389160c1a0a0b.1698342632.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                          |  2 +-
 sound/usb/Makefile                                   |  2 +-
 sound/usb/mixer_quirks.c                             |  4 ++--
 .../usb/{mixer_scarlett_gen2.c => mixer_scarlett2.c} | 12 +++++++-----
 sound/usb/mixer_scarlett2.h                          |  7 +++++++
 sound/usb/mixer_scarlett_gen2.h                      |  7 -------
 6 files changed, 18 insertions(+), 16 deletions(-)
 rename sound/usb/{mixer_scarlett_gen2.c => mixer_scarlett2.c} (99%)
 create mode 100644 sound/usb/mixer_scarlett2.h
 delete mode 100644 sound/usb/mixer_scarlett_gen2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bbfedb0b20938..ecf4d0c8f446e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8031,7 +8031,7 @@ M:	Geoffrey D. Bennett <g@b4.vu>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
-F:	sound/usb/mixer_scarlett_gen2.c
+F:	sound/usb/mixer_scarlett2.c
 
 FORCEDETH GIGABIT ETHERNET DRIVER
 M:	Rain River <rain.1986.08.12@gmail.com>
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 9ccb21a4ff8a8..64a718c766a7a 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -12,7 +12,7 @@ snd-usb-audio-objs := 	card.o \
 			mixer.o \
 			mixer_quirks.o \
 			mixer_scarlett.o \
-			mixer_scarlett_gen2.o \
+			mixer_scarlett2.o \
 			mixer_us16x08.o \
 			mixer_s1810c.o \
 			pcm.o \
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a331732fed890..c8d48566e1759 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -33,7 +33,7 @@
 #include "mixer.h"
 #include "mixer_quirks.h"
 #include "mixer_scarlett.h"
-#include "mixer_scarlett_gen2.h"
+#include "mixer_scarlett2.h"
 #include "mixer_us16x08.h"
 #include "mixer_s1810c.h"
 #include "helper.h"
@@ -3453,7 +3453,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x820a): /* Focusrite Clarett+ 2Pre */
 	case USB_ID(0x1235, 0x820b): /* Focusrite Clarett+ 4Pre */
 	case USB_ID(0x1235, 0x820c): /* Focusrite Clarett+ 8Pre */
-		err = snd_scarlett_gen2_init(mixer);
+		err = snd_scarlett2_init(mixer);
 		break;
 
 	case USB_ID(0x041e, 0x323b): /* Creative Sound Blaster E1 */
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett2.c
similarity index 99%
rename from sound/usb/mixer_scarlett_gen2.c
rename to sound/usb/mixer_scarlett2.c
index cbdef89ab987f..bcb8b76174065 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *   Focusrite Scarlett Gen 2/3 and Clarett USB/Clarett+ Driver for ALSA
+ *   Focusrite Scarlett 2 Protocol Driver for ALSA
+ *   (including Scarlett 2nd Gen, 3rd Gen, Clarett USB, and Clarett+
+ *   series products)
  *
  *   Supported models:
  *   - 6i6/18i8/18i20 Gen 2
@@ -149,7 +151,7 @@
 #include "mixer.h"
 #include "helper.h"
 
-#include "mixer_scarlett_gen2.h"
+#include "mixer_scarlett2.h"
 
 /* device_setup value to allow turning MSD mode back on */
 #define SCARLETT2_MSD_ENABLE 0x02
@@ -4251,7 +4253,7 @@ static const struct scarlett2_device_entry *get_scarlett2_device_entry(
 	return entry;
 }
 
-static int snd_scarlett_gen2_controls_create(
+static int snd_scarlett2_controls_create(
 	struct usb_mixer_interface *mixer,
 	const struct scarlett2_device_entry *entry)
 {
@@ -4339,7 +4341,7 @@ static int snd_scarlett_gen2_controls_create(
 	return 0;
 }
 
-int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
+int snd_scarlett2_init(struct usb_mixer_interface *mixer)
 {
 	struct snd_usb_audio *chip = mixer->chip;
 	const struct scarlett2_device_entry *entry;
@@ -4378,7 +4380,7 @@ int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
 		entry->series_name,
 		USB_ID_PRODUCT(chip->usb_id));
 
-	err = snd_scarlett_gen2_controls_create(mixer, entry);
+	err = snd_scarlett2_controls_create(mixer, entry);
 	if (err < 0)
 		usb_audio_err(mixer->chip,
 			      "Error initialising %s Mixer Driver: %d",
diff --git a/sound/usb/mixer_scarlett2.h b/sound/usb/mixer_scarlett2.h
new file mode 100644
index 0000000000000..d209362cf41a6
--- /dev/null
+++ b/sound/usb/mixer_scarlett2.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __USB_MIXER_SCARLETT2_H
+#define __USB_MIXER_SCARLETT2_H
+
+int snd_scarlett2_init(struct usb_mixer_interface *mixer);
+
+#endif /* __USB_MIXER_SCARLETT2_H */
diff --git a/sound/usb/mixer_scarlett_gen2.h b/sound/usb/mixer_scarlett_gen2.h
deleted file mode 100644
index 668c6b0cb50a6..0000000000000
--- a/sound/usb/mixer_scarlett_gen2.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __USB_MIXER_SCARLETT_GEN2_H
-#define __USB_MIXER_SCARLETT_GEN2_H
-
-int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer);
-
-#endif /* __USB_MIXER_SCARLETT_GEN2_H */
-- 
2.43.0




