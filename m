Return-Path: <stable+bounces-105493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F829F983A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A219624DA
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80008235C4F;
	Fri, 20 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh4QbdRB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39720235C46;
	Fri, 20 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714837; cv=none; b=h5OWYx/vuY6avrizKELJRtSAuP+9sIw2zRidQkFTiG7krR32MC82KR45r6LRhe/PYw43gd2IMsRk8KPhS5oBcc3THqF5Ku6sR4okMAYyg9u3ZvKt1mkcQ1jj73auKhuimVXOuOiBCCoCJINHYRGi5YRU2lszWVOf53o1wNn2QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714837; c=relaxed/simple;
	bh=J14W3KpqoxnqKYn+j4Sjkup2w5CDusFn8R1TLXW2xlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol+VvWr63yPUbOSXMV0zawJOQs+laWJSQLVU739jEcSjH/Nu4PG5a2py/frl/znGLlUbfjkGqFmr/pvzfsEaJxeFAHAxDtUlm5k5oGd331IZzejhMQfBE6KO8fppzFOqW3TbzLRYEIifHFikNvcFYKnfiGurzRrr1JU3hBQdbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh4QbdRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3DC4CED3;
	Fri, 20 Dec 2024 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714837;
	bh=J14W3KpqoxnqKYn+j4Sjkup2w5CDusFn8R1TLXW2xlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh4QbdRBMYj44LVOgOXB+3IzyLOxQakcCbhm7hStXwRy1hjPt84PI9walZGWqEcYn
	 bdFcbYtn7UIKtoN85dGECf+P/4RAS0u3kL30DjZvzAegQuFiAqqmEmbJoDdzXm45n1
	 KFncQ+0Jx/Nod/e4W1xm/8KpnT4toC9qC31FbbwVOuMTdJcVczK8i7P96TmWIlFEcp
	 HhOjFQsfOe5CV4L0VVd3gbkz6aL3CBD6cbHbUQjwEMLkVHTjrUHbNLrLG2qmpvsDSr
	 eaybJy17/p9kNf/pikaZHPgMatkTPl+93zrR1R79SOLaStWjd6g3lYlWloLBMC0ZT7
	 K92CmvA9at8fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	wangdicheng@kylinos.cn,
	hulianqin@vivo.com,
	mbarriolinares@gmail.com,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/9] sound: usb: enable DSD output for ddHiFi TC44C
Date: Fri, 20 Dec 2024 12:13:42 -0500
Message-Id: <20241220171347.512287-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171347.512287-1-sashal@kernel.org>
References: <20241220171347.512287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
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
index 9d98a0e6a9f4..8841251f7331 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1903,6 +1903,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2522, 0x0007, /* LH Labs Geek Out HD Audio 1V5 */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
+	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
-- 
2.39.5


