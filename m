Return-Path: <stable+bounces-77195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F499859ED
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B641C21168
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA017A5A6;
	Wed, 25 Sep 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obBCxowC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677C18C005;
	Wed, 25 Sep 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264480; cv=none; b=NkoFMLnKAuxCIurLFEZzxiYcG2TbmqUiODKcGpgAPzh0dfq/31hrTlHLfi7C1rx/ojJ3TOQOogWA5+FW0cBEt0qumJqry2eMBhKAN5VS7CLcxHNAUMaQ8G8Zmqyug2fldfBTQgxRdHrTTBa5alE2vgQHnCLwFlbb5+g/8ZaS0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264480; c=relaxed/simple;
	bh=8iQiOAVNXUHyCbiiNGRuq1XzFRfxpDPAgY6p+xbcby0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rmq4LMuF7QBITJmhX91wqUgRRnodd0oJQ7Asfra5ztR0zDDS7aDPPSrKY/aOrXM0YPxym6CkuLqAe3kgacVJFEouEkssihZtYFoIlijfbnTTFjGyARfVGXXpnaExz+coxIcP/0IqBncTTvUpzWmzaurxBJ6DYmISKXDA8Lxvao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obBCxowC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73DDC4AF0B;
	Wed, 25 Sep 2024 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264480;
	bh=8iQiOAVNXUHyCbiiNGRuq1XzFRfxpDPAgY6p+xbcby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obBCxowCYAolIT2IJTiIxPfwF5JOIzdtuOeuL7Xd00K1U6f4UVipr404CdvV3S6+2
	 d/qdqrn7S54j/izYTbsNteZINfSw1XmlM1aj0DVnqJx0TNeZ77ia5qVQOOo7IK5Wta
	 YyTMNvAIqtxMUCu/Hit2DrfJEebQR9o5V8LU8CgMpKhw9IlKffOYcV4uf4VDW31SSP
	 LMBnxvFlDo53WIYCqlwQsvSPaRKVu+aIF8yCc8m1DxkIdUskTkzVa+zH5QzYm4nM7K
	 Lbn570GJHko1GusfuaNaitXw4uOxuxcW+KWkWUnYmv1Vc0jelkZrUTUzcGT7gQbm+3
	 W8vZWsTkmbuzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Pius <joshuapius@chromium.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	k.kosik@outlook.com,
	skend@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 097/244] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Wed, 25 Sep 2024 07:25:18 -0400
Message-ID: <20240925113641.1297102-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Joshua Pius <joshuapius@chromium.org>

[ Upstream commit a51c925c11d7b855167e64b63eb4378e5adfc11d ]

Specify shortnames for the following Logitech Devices: Rally bar, Rally
bar mini, Tap, MeetUp and Huddle.

Signed-off-by: Joshua Pius <joshuapius@chromium.org>
Link: https://patch.msgid.link/20240912152635.1859737-1-joshuapius@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 778de9244f1e7..9c411b82a218d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 	/* Creative/Toshiba Multimedia Center SB-0500 */
 	DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
 
+	/* Logitech Audio Devices */
+	DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
+	DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
+	DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
+	DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
+	DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
 	DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
-- 
2.43.0


