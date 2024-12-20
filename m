Return-Path: <stable+bounces-105482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BA9F9831
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A023189C438
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17A231A45;
	Fri, 20 Dec 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="att6DtjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E01231A40;
	Fri, 20 Dec 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714812; cv=none; b=IVnF21kPMI2FqE17OVFYtDp7j3vgpKSADv1fhk8UXkSHSY4H3nBmbwobUQ5cYeOeaPgJxszu+n4k6hrDlaAbP59ECrUVdaZ4Q90BBYOSitvre9JBq1oWOqchwfV5fpg5CrT+C/coIRmAj2yEY3SPtLAMGGBYEpdsab7SZtxNJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714812; c=relaxed/simple;
	bh=+RksARGPahzubdGx2rSc5OL3okhH51+QWgMRsAmcNQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEC57CnTlWs4+y563PNaRB4WCWhNx25UTruhxZNHGmNvBz3yYl84K7ytdcIz+G9CMX0qO5fpPKNdvJWkqMpEOpIKElZVtaAuSix1QxOjrFsNt+9Ck5MteC2Pz1/pXwSppYe6ewk4RvkJYaZ5EJmvsGbNjTqv3d7u82U5ZWLN88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=att6DtjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62351C4CECD;
	Fri, 20 Dec 2024 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714812;
	bh=+RksARGPahzubdGx2rSc5OL3okhH51+QWgMRsAmcNQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=att6DtjASHbU8Do2OcYtj1NhNGUkSUNEtrNsogZjuMJAGN+hyB15ldlkro19M72Ww
	 Yzb/sviQh5sPGoLn6RXQS1Q3sDIJQAfSe5IOjQCSvmaggf+YWzgB6AwWuLO+1DWls5
	 QgHBsNOmtmTzngxGNyk0jQ0YtzhKzonva2OWYdXjwJG3rCQB+aL7v6BRKogNtx4fUV
	 bWE79ZT3yazixkeFPlr1Dm+GmcoYgXUCyjBxEbXikniicc1iWkCJnIIqOFZtGCmWGr
	 lkyPKhL3VGD8EmOPvnLZZuqy7iFsRG7m8+8+kb+VC9gcOoJPFAXkVTMkmYW/lzvO/v
	 n20qXFmIGsOmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	hulianqin@vivo.com,
	mbarriolinares@gmail.com,
	lina@asahilina.net,
	wangdicheng@kylinos.cn,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] sound: usb: enable DSD output for ddHiFi TC44C
Date: Fri, 20 Dec 2024 12:13:10 -0500
Message-Id: <20241220171317.512120-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171317.512120-1-sashal@kernel.org>
References: <20241220171317.512120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
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
index ecb49ba8432c..87820cf7e821 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2209,6 +2209,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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


