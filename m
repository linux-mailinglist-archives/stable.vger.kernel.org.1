Return-Path: <stable+bounces-105483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39A9F984F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111D5189A556
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF3231C8B;
	Fri, 20 Dec 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+jydAwE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC7231C85;
	Fri, 20 Dec 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714815; cv=none; b=LSghxBrxPjaW1VaPZG4Bdf+z69VFT9Fik8ZiWMop1qk8uMBpUqiK3QAh+WOpV1WW99Rie3MJj1+UnZjS+ZkBV81gk6zcBuC9SgERs8aQU7rIB2JW8+DeJvf6MDlNvrby9WlPd1hE2h9LD1XwAFChp1EtxtVp2YAQJHvBRIKIJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714815; c=relaxed/simple;
	bh=he1Bkg3qoCJGI2LggxCuifYJzrOSubH4SexUF/l4PMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptEaSl9gdxohkGV10vX1SjY+hbpIpuVydatGkrsTUxBewt2fHjD/VHwkPNqUckGz7xoMyaJRynGlZeGfQXcfDgfFRNP0cUaguWWwKypFCUt8nFDbI6vm+popxNKO7WwxBNosyXPk6qbz6idymDYSXWQHcPXojJRSTUa4QkZWMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+jydAwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1344DC4CECD;
	Fri, 20 Dec 2024 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714815;
	bh=he1Bkg3qoCJGI2LggxCuifYJzrOSubH4SexUF/l4PMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+jydAwEHr4XIozsdM9MpXyv1KSxWcz6wSJL+TRCIsmyCwyYaOBwFrYOODNcUpLWq
	 m1rEJQWoDBmErjG8OO+c75hj0kQ8aY2nypmSuvZpvYG/1ym5aeJLZYgYT2YxvchzT4
	 TL22w76hq02QH5hqHIZ1FgBDmziPGlcFFnrEdwSG75kJiLssQIDh4bHDEB3QUgwhou
	 zBuPrjdXZiqQRWr8ZbYwUxjQTVqS/A9ph/CI0DmRXSc5aV17T5DouoBuvgRitS1ox+
	 R0WQhZoGV+Sz+exGr/SxTux1tx+6tHGMP5AoolgGNYQEfhfLSotyS2cjLBeYdO0eBr
	 0Su5qSyjSHU8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	alexander@tsoy.me,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/12] sound: usb: format: don't warn that raw DSD is unsupported
Date: Fri, 20 Dec 2024 12:13:11 -0500
Message-Id: <20241220171317.512120-6-sashal@kernel.org>
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

[ Upstream commit b50a3e98442b8d72f061617c7f7a71f7dba19484 ]

UAC 2 & 3 DAC's set bit 31 of the format to signal support for a
RAW_DATA type, typically used for DSD playback.

This is correctly tested by (format & UAC*_FORMAT_TYPE_I_RAW_DATA),
fp->dsd_raw = true; and call snd_usb_interface_dsd_format_quirks(),
however a confusing and unnecessary message gets printed because
the bit is not properly tested in the last "unsupported" if test:
if (format & ~0x3F) { ... }

For example the output:

usb 7-1: new high-speed USB device number 5 using xhci_hcd
usb 7-1: New USB device found, idVendor=262a, idProduct=9302, bcdDevice=0.01
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
usb 7-1: Product: TC44C
usb 7-1: Manufacturer: TC44C
usb 7-1: SerialNumber: 5000000001
hid-generic 0003:262A:9302.001E: No inputs registered, leaving
hid-generic 0003:262A:9302.001E: hidraw6: USB HID v1.00 Device [DDHIFI TC44C] on usb-0000:08:00.3-1/input0
usb 7-1: 2:4 : unsupported format bits 0x100000000

This last "unsupported format" is actually wrong: we know the
format is a RAW_DATA which we assume is DSD, so there is no need
to print the confusing message.

This we unset bit 31 of the format after recognizing it, to avoid
the message.

Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
Link: https://patch.msgid.link/20241209090529.16134-2-adrian.ratiu@collabora.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3b45d0ee7693..3b3a5ea6fcbf 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -60,6 +60,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
 			/* flag potentially raw DSD capable altsettings */
 			fp->dsd_raw = true;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC2_FORMAT_TYPE_I_RAW_DATA;
 		}
 
 		format <<= 1;
@@ -71,8 +73,11 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = as->bBitResolution;
 		sample_bytes = as->bSubslotSize;
 
-		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC3_FORMAT_TYPE_I_RAW_DATA;
+		}
 
 		format <<= 1;
 		break;
-- 
2.39.5


