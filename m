Return-Path: <stable+bounces-77190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C19859DE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8991C237CD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFD18BB88;
	Wed, 25 Sep 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrNe73YZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FE18B498;
	Wed, 25 Sep 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264451; cv=none; b=TERrmRo3HArbBJv2O5++MJjVj0GtN7gEEKUfRh6QrrbAJKxxv8joJHlb6jCs8vTYmUWsZ12ayjN/fpm1QYhRBx8MMhvZecerfyoNqYZC8FMETttQliGSUPCLUooW9oGVQwKgOHG8hGOZ9ZABn15qWCwJBp+2+Uh4tv1/uctFJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264451; c=relaxed/simple;
	bh=tB7i75v0HrDGr1kVG2XPQpvuz5zlm9lnCQ+wUEPabVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3eDQsdPaicJkwqXYvv4mwwpsPzrxJBf5MyK9ztLuhNddVX8bsutkGnLhVkKPXJVoekrm5m9qhHQvAyjFAhJcA/GyqtWcuyYO1X5DR2DyHLXdML/657vsit3Ef7+3rqdL3mzT6JwUObd8iR2l2WlVGhKk0HNSz3I3FanzNrpXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrNe73YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EDFC4AF0C;
	Wed, 25 Sep 2024 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264450;
	bh=tB7i75v0HrDGr1kVG2XPQpvuz5zlm9lnCQ+wUEPabVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrNe73YZhm1zEnXLDMR5AYRFwcnnuAtwvxgv5v3YV2714TYkgocv5egoQoJDDTAz/
	 RHYl5mpMxZ35O7X3345X9UgZlA5Qqoz4evl7XNXY39CncnPbm2w5m/29xEeLD9DU6a
	 MlBlCP1c9bTu/6hLm812NSH3T6GQyaizkXK8AZ/JQ8vOb4dDfrWxIGA30A2zjAMRPg
	 dtlx7Jh7tCOK98xnGQ5yKNO4E3hhyEVGwyqtFxbzaRosC0wM+NNndHsqIFGzkVpkLL
	 20uh/A1kXdLqt89pYQDxnd44eWwC5jwHCkGstzOieOZ3N0pkU2y8SIydkMkL+itNit
	 xdowoRMRa2kbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	mbarriolinares@gmail.com,
	cyan.vtb@gmail.com,
	soyjuanarbol@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 092/244] ALSA: usb-audio: Define macros for quirk table entries
Date: Wed, 25 Sep 2024 07:25:13 -0400
Message-ID: <20240925113641.1297102-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 0c3ad39b791c2ecf718afcaca30e5ceafa939d5c ]

Many entries in the USB-audio quirk tables have relatively complex
expressions.  For improving the readability, introduce a few macros.
Those are applied in the following patch.

Link: https://patch.msgid.link/20240814134844.2726-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index aaa6a515d0f8a..e3a25f4f68792 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -35,6 +35,83 @@
 	.bInterfaceClass = USB_CLASS_AUDIO, \
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 
+/* Quirk .driver_info, followed by the definition of the quirk entry;
+ * put like QUIRK_DRIVER_INFO { ... } in each entry of the quirk table
+ */
+#define QUIRK_DRIVER_INFO \
+	.driver_info = (unsigned long)&(const struct snd_usb_audio_quirk)
+
+/*
+ * Macros for quirk data entries
+ */
+
+/* Quirk data entry for ignoring the interface */
+#define QUIRK_DATA_IGNORE(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_IGNORE_INTERFACE
+/* Quirk data entry for a standard audio interface */
+#define QUIRK_DATA_STANDARD_AUDIO(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_STANDARD_INTERFACE
+/* Quirk data entry for a standard MIDI interface */
+#define QUIRK_DATA_STANDARD_MIDI(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_STANDARD_INTERFACE
+/* Quirk data entry for a standard mixer interface */
+#define QUIRK_DATA_STANDARD_MIXER(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_STANDARD_MIXER
+
+/* Quirk data entry for Yamaha MIDI */
+#define QUIRK_DATA_MIDI_YAMAHA(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_YAMAHA
+/* Quirk data entry for Edirol UAxx */
+#define QUIRK_DATA_EDIROL_UAXX(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_EDIROL_UAXX
+/* Quirk data entry for raw bytes interface */
+#define QUIRK_DATA_RAW_BYTES(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_RAW_BYTES
+
+/* Quirk composite array terminator */
+#define QUIRK_COMPOSITE_END	{ .ifnum = -1 }
+
+/* Quirk data entry for composite quirks;
+ * followed by the quirk array that is terminated with QUIRK_COMPOSITE_END
+ * e.g. QUIRK_DATA_COMPOSITE { { quirk1 }, { quirk2 },..., QUIRK_COMPOSITE_END }
+ */
+#define QUIRK_DATA_COMPOSITE \
+	.ifnum = QUIRK_ANY_INTERFACE, \
+	.type = QUIRK_COMPOSITE, \
+	.data = &(const struct snd_usb_audio_quirk[])
+
+/* Quirk data entry for a fixed audio endpoint;
+ * followed by audioformat definition
+ * e.g. QUIRK_DATA_AUDIOFORMAT(n) { .formats = xxx, ... }
+ */
+#define QUIRK_DATA_AUDIOFORMAT(_ifno)	    \
+	.ifnum = (_ifno),		    \
+	.type = QUIRK_AUDIO_FIXED_ENDPOINT, \
+	.data = &(const struct audioformat)
+
+/* Quirk data entry for a fixed MIDI endpoint;
+ * followed by snd_usb_midi_endpoint_info definition
+ * e.g. QUIRK_DATA_MIDI_FIXED_ENDPOINT(n) { .out_cables = x, .in_cables = y }
+ */
+#define QUIRK_DATA_MIDI_FIXED_ENDPOINT(_ifno) \
+	.ifnum = (_ifno),		      \
+	.type = QUIRK_MIDI_FIXED_ENDPOINT,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a MIDIMAN MIDI endpoint */
+#define QUIRK_DATA_MIDI_MIDIMAN(_ifno) \
+	.ifnum = (_ifno),	       \
+	.type = QUIRK_MIDI_MIDIMAN,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a EMAGIC MIDI endpoint */
+#define QUIRK_DATA_MIDI_EMAGIC(_ifno) \
+	.ifnum = (_ifno),	      \
+	.type = QUIRK_MIDI_EMAGIC,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+
+/*
+ * Here we go... the quirk table definition begins:
+ */
+
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-- 
2.43.0


