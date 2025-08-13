Return-Path: <stable+bounces-169408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D3B24C4F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DD418841ED
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE461EDA2A;
	Wed, 13 Aug 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIdwVKra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DE72606
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096290; cv=none; b=iRsYMC5YUh2MB1Im742a/xy9B9eU6DpddGblXjKljVJZdfizxEu1Cq1WCvTsGqG2tZu4r2AUQKi1zRUjtzswmrYhNAS3bxKoa0dovgnlvHyUfX/hr2dJtzQvFPTdzqtSFy/hVAxRw313q4iOEbA1prtCxaaYOuiNQtLYigHx/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096290; c=relaxed/simple;
	bh=GIIrIMvWhwCHmhXWFv4XJo30GtLBI9DLoVRM+nlgUEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPKU6eabBC+07I3qhUtjGRxm3i6VB0A/vx3URZgkbN7wPJbxOFxkpft0fmIxWWxCbaiYVQftTgmPYX00zXxdSSuo34+Mw0M1lGEnpqBZN3sZoIj3vimtxnS/rxlwyP9wQ2G7tQCZsRQM9qvML64AduSixaSCcDF4tnG1113VKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIdwVKra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C394AC4CEED;
	Wed, 13 Aug 2025 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096290;
	bh=GIIrIMvWhwCHmhXWFv4XJo30GtLBI9DLoVRM+nlgUEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIdwVKraqA5Eriw/pL7+eAkqoZNDJU355DnsvuHmkFUgdLpCeWVkoNOO4bGRGKcMT
	 aVt3z5+cFRn+++Sh3HpAqE4QIFzntQ+1XqhP408QJMRt6SMbeSxh3oqKQsjpwEYdgt
	 bstBQC1kgCQ/H6Do7NtX7N2e/EwuLJFAP996tBJKToJQlCe94G8/gncLXk45g53/6L
	 hBBKNgSpEtnIVIUro5XbJZk0vIbbQcvFOrABUOGmwe97nHvegSuwCfvF2PbkWg/IZU
	 WsvtTU2YJzhLcXsApdWXAP0IEytdYBQddW9KJoH4Y9nTvmxLvb7CM8NAz3u2I66p8q
	 LA6Fj/NoPoXQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()
Date: Wed, 13 Aug 2025 10:44:47 -0400
Message-Id: <20250813144447.2048274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081244-chokehold-itunes-2e5a@gregkh>
References: <2025081244-chokehold-itunes-2e5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 8a15ca0ca51399b652b1bbb23b590b220cf03d62 ]

During communication with Focusrite Scarlett Gen 2/3/4 USB audio
interfaces, -EPROTO is sometimes returned from scarlett2_usb_tx(),
snd_usb_ctl_msg() which can cause initialisation and control
operations to fail intermittently.

This patch adds up to 5 retries in scarlett2_usb(), with a delay
starting at 5ms and doubling each time. This follows the same approach
as the fix for usb_set_interface() in endpoint.c (commit f406005e162b
("ALSA: usb-audio: Add retry on -EPROTO from usb_set_interface()")),
which resolved similar -EPROTO issues during device initialisation,
and is the same approach as in fcp.c:fcp_usb().

Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
Closes: https://github.com/geoffreybennett/linux-fcp/issues/41
Cc: stable@vger.kernel.org
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://patch.msgid.link/aIdDO6ld50WQwNim@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Applied retry logic around snd_usb_ctl_msg() instead of scarlett2_usb_tx() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 6d8ef3aa99b5..3b225430bfad 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -118,6 +118,8 @@
 #define SCARLETT2_MIXER_MAX_VALUE \
 	((SCARLETT2_MIXER_MAX_DB - SCARLETT2_MIXER_MIN_DB) * 2)
 
+#include <linux/delay.h>
+
 /* map from (dB + 80) * 2 to mixer value
  * for dB in 0 .. 172: int(8192 * pow(10, ((dB - 160) / 2 / 20)))
  */
@@ -591,6 +593,8 @@ static int scarlett2_usb(
 	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
 	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
 	struct scarlett2_usb_packet *req = NULL, *resp = NULL;
+	int retries = 0;
+	const int max_retries = 5;
 	int err = 0;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -614,6 +618,7 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 			usb_sndctrlpipe(mixer->chip->dev, 0),
 			SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ,
@@ -624,6 +629,10 @@ static int scarlett2_usb(
 			req_buf_size);
 
 	if (err != req_buf_size) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err(
 			mixer->chip,
 			"Scarlett Gen 2 USB request result cmd %x was %d\n",
-- 
2.39.5


