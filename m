Return-Path: <stable+bounces-169432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18253B24EA8
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45AF18890F3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8D286D69;
	Wed, 13 Aug 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j09Fl+cK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273F286D62
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100555; cv=none; b=snWgBNzIKD+zGHdVa+Lu9mTscFgAoFw1d3JA9qvH5P2MNSNiON+L93R2llzuZgl+O4P112sETPlZ25H0F1tpzyHlBqjRX1WcUIo6NQiSsZifixe1fXvynvEfAOVm4CpIpy9CGkqthYwqPrYowp+Ffruz/sgIxWxksMAVtpLnn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100555; c=relaxed/simple;
	bh=zYTLanYT1OsG/PIur8uERAqhnN6cIvHBsGTUDepi0Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsJbLf6AOvrNVDgSPDZ95AuSwrvMN2XdSp6E9JaRzkxokpOtdhy4+zrG2rsGp9QCx89pb1/zQVXRZQ/gLLV6v+sxHYgUBDevCxF/n19risCyHy/nWV4atSH179XEEckqd5k/jVL4sxFS55GJZ6G3YzjXstEZylQ2PK5S8aGWtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j09Fl+cK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8EC4CEEB;
	Wed, 13 Aug 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755100554;
	bh=zYTLanYT1OsG/PIur8uERAqhnN6cIvHBsGTUDepi0Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j09Fl+cKdI875zybFb1l9D7jS821WJYYG41JiiGzc0+TGI/yNJrwVhBEJTE/Q7oNI
	 lvYPs4+VfI3jK9+I9/gyAoTcxRYGbtFpDTeQxdkVpUARG75NtzxKYiLoP//WjsYlXX
	 CoChLizLors0F0+Q0+6IsG9GH704lLAAgtGLKe6iIWdZP3aiSuQjXzUO1/efd1PSWA
	 Wf96mzgk9ZDXprxu6EEOuGsYQNCqOxmfUQwPV/j6z2Q1pyHw1hZ8uBgrJNieTm07YO
	 cfU8kG7yM71iifwI5a85h4/QbhOi/Yu2ccYyFFGMOdcYk/WlMhDr4VMn9Mnt/o3Opd
	 gXRah7cnPdAdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()
Date: Wed, 13 Aug 2025 11:55:06 -0400
Message-Id: <20250813155506.2051597-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081244-epileptic-value-7d4e@gregkh>
References: <2025081244-epileptic-value-7d4e@gregkh>
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
[ Applied retry logic directly in scarlett2_usb() instead of scarlett2_usb_tx() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 1b7c7b754c38..1c31a9d21d42 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -95,6 +95,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/moduleparam.h>
+#include <linux/delay.h>
 
 #include <sound/control.h>
 #include <sound/tlv.h>
@@ -591,6 +592,8 @@ static int scarlett2_usb(
 	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
 	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
 	struct scarlett2_usb_packet *req = NULL, *resp = NULL;
+	int retries = 0;
+	const int max_retries = 5;
 	int err = 0;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -614,6 +617,7 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 			usb_sndctrlpipe(mixer->chip->dev, 0),
 			SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ,
@@ -624,6 +628,10 @@ static int scarlett2_usb(
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


