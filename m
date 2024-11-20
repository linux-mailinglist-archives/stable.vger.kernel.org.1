Return-Path: <stable+bounces-94414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A19D3D32
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B511F21CE2
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D081BE87B;
	Wed, 20 Nov 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F85Rqb+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2141A4F1B;
	Wed, 20 Nov 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111682; cv=none; b=G/xC/gZpJmfrqG0YuYwWKxQGNZtKUcHDTT9ixmjAA2sd7qlKMXKBBHButBEriTuK8mOEpbYlS9nzY7tG5Jsn5H5a8nRdzlcW6uDhQHA/PJekUBMF/XyyUXry9riL4jfSFL7Pht1VttFT5Y/LYeDsyRVrfnuUPiS0oRsJ53rzIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111682; c=relaxed/simple;
	bh=5tirlQc/hnOU3dP9O95i4Ihq5j3Nj4ozZzupoTOod6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8Of9CSh8hrjBNOwB48qeW0BCFpbLkua/8z/qFJ9Eq06ro0I+9F8t3jmKFIcFl/ZwuZXb+s/YTTYdnx03t9z+rzv+7/Y5Tpk8G10CjRIp1VZTlxjybMMwNo62MeMfhsBUpPvFS6d4jd8heoU1fDyjJHIAqDbzQtkU/Uva6SqjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F85Rqb+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF1C4CECD;
	Wed, 20 Nov 2024 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111681;
	bh=5tirlQc/hnOU3dP9O95i4Ihq5j3Nj4ozZzupoTOod6U=;
	h=From:To:Cc:Subject:Date:From;
	b=F85Rqb+UkL19209YsRHjz6jZ5w4qqPmYQpW2mGDr8XdIMVL20NyE46CM7rwe3bnvU
	 kh5gknfgUMOQMpbq41cTjpauMbQE/0FkedCbOY0lwTI/nc4COu7WJS9txhGn5VprLv
	 HcuIxxKdqfK5HtkIc5IJtLtdM6Fr8XXfl5gfTvTmxK01Oe5NBHqK3qJU2yjGxsUn5/
	 7Zh9bRYU4lLP4ZEP/hL1mQzRuVo6tNFgMDu8NrMxbhxyCj39p7A0P8oeAFUoGY7bvM
	 0sGUWYaCHtg31k1Hhc8kfHxt0JSPKxGhbYlLfqL2B93kfG95yqfCP1KJ+5knISZGVo
	 Qo2qmyx3ItL1w==
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
Subject: [PATCH AUTOSEL 5.15 1/4] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
Date: Wed, 20 Nov 2024 09:07:44 -0500
Message-ID: <20241120140758.1769473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index dd98b4e13edac..4690b44987c05 100644
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


