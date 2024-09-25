Return-Path: <stable+bounces-77607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EA985F16
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152171C25B5D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60E21BB18;
	Wed, 25 Sep 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH/jxCIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0321BB13;
	Wed, 25 Sep 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266460; cv=none; b=bOpnvBX6yumOzqa/A1lAj2rW7Mb83uMGka/G3IFnhd78YwfpdR//SG4LI9xHeSHMeEl1DqwAfkd/fmoGXfF6w0YPIDl70UoA5bcRgLoRyfVUiCUsobeWm1JiKpHVgFJrf/F7PzepT+TetV12zBtyedcg/1es9Pq5A3KZKiplEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266460; c=relaxed/simple;
	bh=/XCEKjT89FGc9vPVMRfm3gldBbuWxP4STtXkdU4otkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+6tmy6lx9C57CAblDboIJ/Ho+R5HOT8+e3eWfaOZsGDyJOKPwGOe4Nkh9IHl22l4v/a4kTSjVqmwvTgmLvuQKIPBrlKS8uIxs3DDfMvHNXUFTadZm+Ro7nUec9j2hFpflK3GaxXt0z7y9GNfbq5N86tqdGE5iH7cLyHrNBaZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH/jxCIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE1AC4CEC3;
	Wed, 25 Sep 2024 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266459;
	bh=/XCEKjT89FGc9vPVMRfm3gldBbuWxP4STtXkdU4otkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH/jxCInoSSCf3+9GkS0v/51XfblyhgPMa/EuSqprHs9xPVdaK9aQ8zutoqy2qkfe
	 pPs5sfSIvKpK/k8YWaIav7SVOZSiTr0DHsXWHK2cT/nLztvciQoR58gbuhNWP2KuAv
	 IwJofFD+bTmGsEV/PTPnnfEif5NAgx115awqTKn9X2M1lTrS/12+B5KBe4ifLSX44L
	 4FNGX9rI7apQ6uMBFJtduo5RE7h3nlrn8LlkO5IQerf/Jpzv4oRTT5/+4xq2DyiowG
	 SzSOns0HmPEl7EPmU5L38QV5uH0HeG63LluHnZbYJ7EVo33YUU/FG3lIk8otghAito
	 0pqis9sTbKT8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	mbarriolinares@gmail.com,
	soyjuanarbol@gmail.com,
	cyan.vtb@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 060/139] ALSA: usb-audio: Define macros for quirk table entries
Date: Wed, 25 Sep 2024 08:08:00 -0400
Message-ID: <20240925121137.1307574-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index d2aa97a5c438c..a0063caa769c5 100644
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


