Return-Path: <stable+bounces-105468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257359F97EC
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9569A169CFC
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF6D22D4DB;
	Fri, 20 Dec 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYxslLZp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26022D4D6;
	Fri, 20 Dec 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714779; cv=none; b=FtabkdqLNYL0wE7uGSTZJQOMJ76VPh8D2IJTT+i1uasm3JOuO2R2VKbFTrl53/0t75BTuS5g4oSgUxcJhWybiueDhZYROD4NTRgqtHwgcbjkBEMRu60AVHlRrs51yqUKwP97OipZMsMUxD7fgI9Wk5nR7B1QYEq9Y0ui0pPrJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714779; c=relaxed/simple;
	bh=GQDLHIvFvGO/jdNnDglKo4iI+0W7g+HaPInTOjq1rqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2fWK/NmsjM0iKHlRLp4LuNCspmD3BMXvutztq2Ij/Km+GAYEBzVfHQyuqvuJk1DVU1/l6oB7YrSF0t4fUK4rR6UnrWhRG1B6oQaybMmh599NguEFWYLrsp2DfCCfqv10srmOb3senK1OAs3xBM6t2hZp0Y077lti0fSwrXaHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYxslLZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C31C4CED3;
	Fri, 20 Dec 2024 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714779;
	bh=GQDLHIvFvGO/jdNnDglKo4iI+0W7g+HaPInTOjq1rqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYxslLZpIhOeGHXMTEZht14EILl9f+nAwSmo4s8Z9aP9sC9z0qqYYkEK6rrVYioqz
	 Fw/eGb7NxECQpmD4IvnsNtq3RnxsoXRfdwaP8kDUYfry2M/l/4agnbOzQTMn4DKgiQ
	 UGWawyv+DRfyf+pG/dQyjHVe2rPHZganJ+rtq+pyUNhCZk2W5FtSuo0LmslORPU2ti
	 uwFeAXQVpbFAe/VrKZFrsiDOFEQh3ItrhLyDwULDkt1XqJeFTfR8nrVrGlBlrAKzVQ
	 lMxyG0KM3rjoiCGNY/dPYs8jkwjqwqOPwbtgwU1jlgUNKSjjST95rtYxwq7brjXPQQ
	 8nvdn0gUSzYEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	hulianqin@vivo.com,
	lina@asahilina.net,
	wangdicheng@kylinos.cn,
	mbarriolinares@gmail.com,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/16] sound: usb: enable DSD output for ddHiFi TC44C
Date: Fri, 20 Dec 2024 12:12:31 -0500
Message-Id: <20241220171240.511904-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
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
index 65c44649c067..b359f933c62c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2211,6 +2211,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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


