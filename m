Return-Path: <stable+bounces-105445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2419F979D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2361651A0
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD82236FF;
	Fri, 20 Dec 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvYtBSeQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5C21B1BC;
	Fri, 20 Dec 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714726; cv=none; b=dJm+R5ajp27nxBOX3gcebUmOdC0ydvr3WVk1kMiGkj/t0lzZPfPSOFk8tQU5tOltQKbJCazAMpnr+gt3fhYotQFUwkiIQF46y4rhcGWvqB7zt4UEAR8zEECyTrt4Zi8Pif+UO/XzYsBOcE/FbxwkjvEA6Z2al7B3xetTZbao1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714726; c=relaxed/simple;
	bh=V8MsNF2pHK4scwAVSQrSca2Wn96I7L/2V/noAmt9mf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mv0OIxCndU1FXLcDS/x6Y2mJkPexBqDSN6qktEhnDsSmCN8M9GcMh3IIpnLc5cCuZ+PGWrdGVdhmIZiLL37yzAfg6737i36l0P2zefu6NT4ny8YrSNbTbStdXuGUJYj25imWPgj0AgcjBBd2LI9DJ/LDksNVf5iR39mOqbd5rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvYtBSeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22AFC4CECD;
	Fri, 20 Dec 2024 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714725;
	bh=V8MsNF2pHK4scwAVSQrSca2Wn96I7L/2V/noAmt9mf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvYtBSeQ7oqlbDGSdWZTQRLWSqcwLbPuRlqn+hJ0DUEfqPUV8y5gz9EnZ0x6MwctM
	 XbzahpIhb6G8XtVBF/AIJJZOwZzMMNqMYtTqwgkY35MfOx9wz2uDgm81awB2rJE6tD
	 7hra9AVJD92xURHcjWp7LlGoIV3ToOYZ/mQfbtshud7LCA8R2uKxDaUXevr9GSmgQz
	 veZi32mh2EryzXT3eJj04bKtdzsrR/rfCZNZZfYrxbg+NETqnSR3nKCv6oNN7g89a6
	 EUPGIFd/mWvsAVnTXWRxLkY1bzTpZXpXHKj7zzYv7DrXLhi9SyCcewAz8ajrikIfF4
	 8uM4mT9P/RyeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	wangdicheng@kylinos.cn,
	hulianqin@vivo.com,
	lina@asahilina.net,
	mbarriolinares@gmail.com,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/29] sound: usb: enable DSD output for ddHiFi TC44C
Date: Fri, 20 Dec 2024 12:11:14 -0500
Message-Id: <20241220171130.511389-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Adrian Ratiu <adrian.ratiu@collabora.com>

[ Upstream commit c84bd6c810d1880194fea2229c7086e4b73fddc1 ]

This is a UAC 2 DAC capable of raw DSD on intf 2 alt 4:

Bus 007 Device 004: ID 262a:9302 SAVITECH Corp. TC44C
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 [unknown]
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x262a SAVITECH Corp.
  idProduct          0x9302 TC44C
  bcdDevice            0.01
  iManufacturer           1 DDHIFI
  iProduct                2 TC44C
  iSerial                 6 5000000001
.......
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      32
      iInterface              0
	AudioStreaming Interface Descriptor:
          bLength                16
          bDescriptorType        36
          bDescriptorSubtype     1 (AS_GENERAL)
          bTerminalLink          3
          bmControls             0x00
          bFormatType            1
          bmFormats              0x80000000
          bNrChannels            2
          bmChannelConfig        0x00000000
          iChannelNames          0
.......

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
Link: https://patch.msgid.link/20241209090529.16134-1-adrian.ratiu@collabora.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 00101875d9a8..0e97d076a113 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2323,6 +2323,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2522, 0x0007, /* LH Labs Geek Out HD Audio 1V5 */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
+	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
-- 
2.39.5


