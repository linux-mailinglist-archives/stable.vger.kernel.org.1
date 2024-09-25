Return-Path: <stable+bounces-77426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0D985D20
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CD41C2509F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8631DA2EB;
	Wed, 25 Sep 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRW6zLyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E21B1426;
	Wed, 25 Sep 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265739; cv=none; b=IqyoWY9N73ZY6tEPD5eXuXmV99lE4oy2gtfKDH3Pa8F3QBva12wOTOT2sRRYqHr12xfSpwkIfvpH5MfOaA2Z7EeQMHfH4TUG3JZXPTFhDf9K+3Y2/ENKvNQ9ZHF2gpCae+nxHpKHMjwBlqz4VJKD6TkXL/LFf9XQwXpXSqwOF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265739; c=relaxed/simple;
	bh=8iQiOAVNXUHyCbiiNGRuq1XzFRfxpDPAgY6p+xbcby0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4l+pbaTqpoEtdcagpz6GTHV7bUM7Ctv1CKkL8DLQY/d//Tk59NHA3KHyNYkI1R+GQKfYVXj4XpjVp5Nyx3MVHI6bEuxojrKwFI0QnQQmGbNwYiNdfwmOCEk5+TKdewwQE9p018Vs+g2O8jqmr4M4ypwizq9GN4AHNi1QdlsHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRW6zLyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D161FC4CECE;
	Wed, 25 Sep 2024 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265739;
	bh=8iQiOAVNXUHyCbiiNGRuq1XzFRfxpDPAgY6p+xbcby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRW6zLyN7peMsZPWns5hCCq17ggJK+mMySkRa5QeZ8x6v0puTp6zkR+bu7vpcZz7/
	 XNrwGL0S31cscD6dwhBQaJHzBSAJunhZAyBkIrBbe5eUiiHZ7vwm7GWEpphO8TrMNN
	 R47xw61Brjaxlo7KNkAznyeaHVju00IIdebbpQZl5Txa0UayugDv8zM99PSHNEPlja
	 6orRyVRu6qU6kTwtXawr8mVYQuHuUXPyjb0iegdMgkTEvieiFHJs8Wj6wvQP4w7Z5m
	 j4Vjr2/dpYTOF1OVe1Sye5HwufK3VI+yCqcJ/mf5XhHg+lmZATDaKX+doszIkzpT58
	 9VQngXk3Z2BTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Pius <joshuapius@chromium.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	skend@chromium.org,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 081/197] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Wed, 25 Sep 2024 07:51:40 -0400
Message-ID: <20240925115823.1303019-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


