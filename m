Return-Path: <stable+bounces-127249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27725A76A98
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52807188E51E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428824F587;
	Mon, 31 Mar 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLu1ciS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B224EF9C;
	Mon, 31 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433037; cv=none; b=fKpniY6XcTH3vtguvzPgoavtag/hAUQ/EwxNRb14bSUdDTgA66VKAGLhHHJY64RZvuyuGwacF01Xe4dc0H5kuNhBNI5RVIfkuXkCJTJmH8fNuhY3Z13h1i6SOSguJoTjFKhufsEtCcRp3o1ujO2+DG9tfljB1psuMEVhPrBdOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433037; c=relaxed/simple;
	bh=KQSJXLYwSE/418EK1ln86kVxwcc8jSxMSv/4d0Qg01s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6lerFmjdzOyKa1okX++ajrrO28Bn1jTc+PlrRYB13MF1plY4a0Jm5FbZ5wH82XqB2Qyd7drEH2U3K/8UNyHTiMhQNceRw5eWQCYkohwLQjRBIN8AAsRo8FHxoXhAaUxQE2N6mudZmL+IGoAeU/sINhQIMnLVwTLt4LFkupWDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLu1ciS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484F0C4CEE3;
	Mon, 31 Mar 2025 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433036;
	bh=KQSJXLYwSE/418EK1ln86kVxwcc8jSxMSv/4d0Qg01s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLu1ciS3tOcRx05CbRNz7rSON7g08sRtRN8ZoXYPqlOKOS0rSJ7HjIAAGT3MKpPfC
	 UB+CVob8pJF+9O6y5tkhgzDx+sfnMUz0LjQwFrrWuU7zM9991PvG5tzkoAkzUtDpbZ
	 A623vNlKU+7RkXmaPzYtc9V4KgfqYc/4bNEVsLVIUtN+5M4bsp+iBkeyo++6N65M2F
	 oEo06PrzNTANuBX+6uQhFOizg+3WmiJwQM4pXJJRwWi8i8xvqlHSdk32QxQOUVZUCY
	 qTaALsdh3WSvS6JRu9dHvR/xe41ldMffEKkBLvl4A/PWuKT9/Xt0uxawXIbWfu0dI0
	 NRsz1nTA8vEmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricard Wanderlof <ricard2013@butoba.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/6] ALSA: usb-audio: Fix CME quirk for UF series keyboards
Date: Mon, 31 Mar 2025 10:57:03 -0400
Message-Id: <20250331145703.1706165-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145703.1706165-1-sashal@kernel.org>
References: <20250331145703.1706165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Ricard Wanderlof <ricard2013@butoba.net>

[ Upstream commit c2820405ba55a38932aa2177f026b70064296663 ]

Fix quirk for CME master keyboards so it not only handles
sysex but also song position pointer, MIDI timing clock, start
and stop messages, and active sensing. All of these can be
output by the CME UF series master keyboards.

Tested with a CME UF6 in a desktop Linux environment as
well as on the Zynthian Raspberry Pi based platform.

Signed-off-by: Ricard Wanderlof <ricard2013@butoba.net>
Link: https://patch.msgid.link/20250313-cme-fix-v1-1-d404889e4de8@butoba.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index a56c1a69b422a..c6586da43a048 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -489,16 +489,84 @@ static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
 
 /*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
- * single USB packet preceded by a 0x0F byte.
+ * single USB packet preceded by a 0x0F byte, as are system realtime
+ * messages and MIDI Active Sensing.
+ * Also, multiple messages can be sent in the same packet.
  */
 static void snd_usbmidi_cme_input(struct snd_usb_midi_in_endpoint *ep,
 				  uint8_t *buffer, int buffer_length)
 {
-	if (buffer_length < 2 || (buffer[0] & 0x0f) != 0x0f)
-		snd_usbmidi_standard_input(ep, buffer, buffer_length);
-	else
-		snd_usbmidi_input_data(ep, buffer[0] >> 4,
-				       &buffer[1], buffer_length - 1);
+	int remaining = buffer_length;
+
+	/*
+	 * CME send sysex, song position pointer, system realtime
+	 * and active sensing using CIN 0x0f, which in the standard
+	 * is only intended for single byte unparsed data.
+	 * So we need to interpret these here before sending them on.
+	 * By default, we assume single byte data, which is true
+	 * for system realtime (midi clock, start, stop and continue)
+	 * and active sensing, and handle the other (known) cases
+	 * separately.
+	 * In contrast to the standard, CME does not split sysex
+	 * into multiple 4-byte packets, but lumps everything together
+	 * into one. In addition, CME can string multiple messages
+	 * together in the same packet; pressing the Record button
+	 * on an UF6 sends a sysex message directly followed
+	 * by a song position pointer in the same packet.
+	 * For it to have any reasonable meaning, a sysex message
+	 * needs to be at least 3 bytes in length (0xf0, id, 0xf7),
+	 * corresponding to a packet size of 4 bytes, and the ones sent
+	 * by CME devices are 6 or 7 bytes, making the packet fragments
+	 * 7 or 8 bytes long (six or seven bytes plus preceding CN+CIN byte).
+	 * For the other types, the packet size is always 4 bytes,
+	 * as per the standard, with the data size being 3 for SPP
+	 * and 1 for the others.
+	 * Thus all packet fragments are at least 4 bytes long, so we can
+	 * skip anything that is shorter; this also conveniantly skips
+	 * packets with size 0, which CME devices continuously send when
+	 * they have nothing better to do.
+	 * Another quirk is that sometimes multiple messages are sent
+	 * in the same packet. This has been observed for midi clock
+	 * and active sensing i.e. 0x0f 0xf8 0x00 0x00 0x0f 0xfe 0x00 0x00,
+	 * but also multiple note ons/offs, and control change together
+	 * with MIDI clock. Similarly, some sysex messages are followed by
+	 * the song position pointer in the same packet, and occasionally
+	 * additionally by a midi clock or active sensing.
+	 * We handle this by looping over all data and parsing it along the way.
+	 */
+	while (remaining >= 4) {
+		int source_length = 4; /* default */
+
+		if ((buffer[0] & 0x0f) == 0x0f) {
+			int data_length = 1; /* default */
+
+			if (buffer[1] == 0xf0) {
+				/* Sysex: Find EOX and send on whole message. */
+				/* To kick off the search, skip the first
+				 * two bytes (CN+CIN and SYSEX (0xf0).
+				 */
+				uint8_t *tmp_buf = buffer + 2;
+				int tmp_length = remaining - 2;
+
+				while (tmp_length > 1 && *tmp_buf != 0xf7) {
+					tmp_buf++;
+					tmp_length--;
+				}
+				data_length = tmp_buf - buffer;
+				source_length = data_length + 1;
+			} else if (buffer[1] == 0xf2) {
+				/* Three byte song position pointer */
+				data_length = 3;
+			}
+			snd_usbmidi_input_data(ep, buffer[0] >> 4,
+					       &buffer[1], data_length);
+		} else {
+			/* normal channel events */
+			snd_usbmidi_standard_input(ep, buffer, source_length);
+		}
+		buffer += source_length;
+		remaining -= source_length;
+	}
 }
 
 /*
-- 
2.39.5


