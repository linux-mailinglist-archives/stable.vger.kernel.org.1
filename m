Return-Path: <stable+bounces-94418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B91979D3D41
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FB0B2BDC2
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536E1C3046;
	Wed, 20 Nov 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTwssYdD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC71A0AF5;
	Wed, 20 Nov 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111702; cv=none; b=QHW03DFXyypbcQ7B1phgXTeTnDYNj+Mwv6pJiyqcow6+njymmQLZjvZaFt8qunuuidbd0vSWmeTeyS2gGZ3xgrx854Leq0nydtc3jzUFmd2QFuBCSdcQCOV3tVG0vOKIbDpg19/UYXk9oMb5WaEpFKh7uJ7pChYU/8mnGk71KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111702; c=relaxed/simple;
	bh=VstkH05uqdS4tFT/JcIuoivGt2q90EsE9V2hlAMjfdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFQOyE782WPp7xDknhOkKcGfDWQ0RBX391BPeB8ZpRGEgwgok3dhRcH05eNEt/4vdQhnQLmq2/u8JriFx/+WHMpdzgGgcgkK0l/7KiyusOOoc7L7eVRtqxqUJwMytAX0Dv05F3n6lRDdU264mywn6wM7A3KVApf3zm3iZf8p948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTwssYdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77841C4CECD;
	Wed, 20 Nov 2024 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111701;
	bh=VstkH05uqdS4tFT/JcIuoivGt2q90EsE9V2hlAMjfdo=;
	h=From:To:Cc:Subject:Date:From;
	b=LTwssYdDov6qATfHJIMXQRu28WgNhPRbFtLBsMEpRcfZYEmQmO4CTbYsXvKM8dJQL
	 RqnTHkvszijV+PZZg91fgLSS5Dp8IQocWwVvyeyK5ZcknUnT1gVoCT21UFzG5Vq99q
	 mWb7Z6FHXUoJDRWIN3h8NKBr7llb3NfgBQg8hE3aU/YbW/rh9b9rwUxQbl2H0jI/mz
	 Lkr/Hewv3WxtXhdWW6Cbf3Gxy1TewwvOizl3vhzo15o+YHhNA0Nfcev/Yy5C0u8kjE
	 G0IO6wprfHLgSW7W+zJrj/utEO45oI7fBiGstkQYxBDxQjz+wMtohCpBf+JRYt8m1H
	 /An+mhn1gWx+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eryk Zagorski <erykzagorski@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	mbarriolinares@gmail.com,
	cyan.vtb@gmail.com,
	soyjuanarbol@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/3] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
Date: Wed, 20 Nov 2024 09:08:11 -0500
Message-ID: <20241120140819.1769699-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Eryk Zagorski <erykzagorski@gmail.com>

[ Upstream commit 6f891ca15b017707840c9e7f5afd9fc6cfd7d8b1 ]

This patch switches the P-125 quirk entry to use a composite quirk as the
P-125 supplies both MIDI and Audio like many of the other Yamaha
keyboards

Signed-off-by: Eryk Zagorski <erykzagorski@gmail.com>
Link: https://patch.msgid.link/20241111164520.9079-2-erykzagorski@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c6104523dd79c..119c0bde74464 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -350,7 +350,6 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
-YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
@@ -485,6 +484,19 @@ YAMAHA_DEVICE(0x1718, "P-125"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x1718),
+	QUIRK_DRIVER_INFO {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "P-125", */
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),
-- 
2.43.0


