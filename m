Return-Path: <stable+bounces-127232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED0A76A2C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEDC16DBDB
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032E2459D7;
	Mon, 31 Mar 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RILn3aYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7024503C;
	Mon, 31 Mar 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432997; cv=none; b=iHfhjxQfG/vj3vV+lWIISYuDuPKE+Kg8c3ECPkyGKZP6irIDXLKvZ5ucX/v2wuQVdr6hxJpWMv/YUQIRzYtYhI8q7s00EU7tPFzEfPIYDYjDGWTfUtchj/UGWiB4ObWk/DeZBGREpZ89eYch+L+lM/zRTvWBkP1nxL1OiQ11bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432997; c=relaxed/simple;
	bh=5V0JRtWwgJQzXcyWqukn4RRTYehfdjVIp/fb/2hlxY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/n7ZHqGR6XL7MM1Bbjcfd6u4wprjQNFUMh2sP2T1bmsQNt8YDeVGAwRTXPRINuGkOa1tEyInXrT5YPuQI32BPYUCjaT/yRwnZIf3NwEJ50XdGeiVDWjC/4bTQVXkAtuWneuI2v1JdB/ISs818VYZVTjS7NEEvFjoPRGd+qwZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RILn3aYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE70C4CEE3;
	Mon, 31 Mar 2025 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432996;
	bh=5V0JRtWwgJQzXcyWqukn4RRTYehfdjVIp/fb/2hlxY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RILn3aYPvwhU7ahftrEp517TkZ1nxkJO8Zsn+q5ClStT54e5C8vUhUcvU9Dbp7YDd
	 Jc05UExLKxftBZBQa/QHSC2rv0Pj3Kq8HAeyEfk5GK3v3VcrActbvs4Mw2U4Vom5a+
	 40EcqFwhXWp+nr0oxSPIFQbfzV3mERjUgyIGczlTMDw4bs+ZIUfMtgq3UYAEFcTtkH
	 DtW24C2qyH2n+MQ2YQRvvzjrprXoPWaaO3M1kjkkooLMXpdFIhKSIzWWv9m5RTRN4e
	 h8nYSm46wyDLgG8j6Z3b8b3zkn8s6EbRuHRnQV0Iq8vyJ6xvJYUzgdHdJLCB9srW6a
	 2d318l6zD1+Lg==
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
Subject: [PATCH AUTOSEL 6.6 17/19] ALSA: usb-audio: Fix CME quirk for UF series keyboards
Date: Mon, 31 Mar 2025 10:55:58 -0400
Message-Id: <20250331145601.1705784-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145601.1705784-1-sashal@kernel.org>
References: <20250331145601.1705784-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 6d861046b582b..3059f814eb5c2 100644
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


