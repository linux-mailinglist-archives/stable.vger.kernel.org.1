Return-Path: <stable+bounces-157487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DDAE5458
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487C31BC11A0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E83223DC1;
	Mon, 23 Jun 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQW2TRq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367F6136;
	Mon, 23 Jun 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715988; cv=none; b=QtD2NjK//PqaiDVNbTmnJT2VGke9+Iv44tXsU2E3rHavD8twGKBZXnAUMdQEUx5TldPLUmgKOFp84aKlScopJEO9qi5BDu8XWSz/xHsswaqvm/PZtcKBVoYpObknAWBHmefk+idmq2wkwIQtUYmTpEHYGHzibzUDDo8vsILejbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715988; c=relaxed/simple;
	bh=LFxYaxx5eHpzj0KUixUlgm+MHT+6mn3RQeTI9bkJsO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnN4p4YZ1Ga9mF7fsFuAaklCo1nPzIxyuGJFVuRrb2nupG9pElMAO4kQwQXspdXFut6QPQ/BLe1OnFdEAc/g3FK6Nzhyw/J2vY5sxc+HQW1zAMitshfeW1vGgRQu1gvgyi1eZ8Ds7QmBkvTgzbJWcAnEz3siWlovTtZ41vdKxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQW2TRq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8768CC4CEEA;
	Mon, 23 Jun 2025 21:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715987;
	bh=LFxYaxx5eHpzj0KUixUlgm+MHT+6mn3RQeTI9bkJsO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQW2TRq/gLHQ17o77jcbbktavbfQJpEitTQXuZqAwLYDrIdime2SRZdyQquYLSqCs
	 uVKvID5FjRv39XMQf4Ohgfhm9J4e7Arnu0Q9Idtc/bZU2zjb1qDE2OegK8rQgDx7z2
	 VL5Ot0pBye6DycVgNJPKh9+d1E+H5Cx5782aANTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangdicheng <wangdicheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 233/290] ALSA: usb-audio: Rename ALSA kcontrol PCM and PCM1 for the KTMicro sound card
Date: Mon, 23 Jun 2025 15:08:14 +0200
Message-ID: <20250623130633.936279347@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangdicheng <wangdicheng@kylinos.cn>

commit 93adf20ff4d6e865e0b974110d3cf2f07c057177 upstream.

PCM1 not in Pulseaudio's control list; standardize control to
"Speaker" and "Headphone".

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250613063636.239683-1-wangdich9700@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_maps.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -383,6 +383,13 @@ static const struct usbmix_name_map ms_u
 	{ 0 }   /* terminator */
 };
 
+/* KTMicro USB */
+static struct usbmix_name_map s31b2_0022_map[] = {
+	{ 23, "Speaker Playback" },
+	{ 18, "Headphone Playback" },
+	{ 0 }
+};
+
 /* ASUS ROG Zenith II with Realtek ALC1220-VB */
 static const struct usbmix_name_map asus_zenith_ii_map[] = {
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad - broken response, disabled */
@@ -692,6 +699,11 @@ static const struct usbmix_ctl_map usbmi
 		.id = USB_ID(0x045e, 0x083c),
 		.map = ms_usb_link_map,
 	},
+	{
+		/* KTMicro USB */
+		.id = USB_ID(0X31b2, 0x0022),
+		.map = s31b2_0022_map,
+	},
 	{ 0 } /* terminator */
 };
 



