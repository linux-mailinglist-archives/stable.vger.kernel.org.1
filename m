Return-Path: <stable+bounces-90037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5F9BDCCC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DFF1C23063
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FAE2185A9;
	Wed,  6 Nov 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6RgL8I1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F82185A1;
	Wed,  6 Nov 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859266; cv=none; b=dGItQf0uKvTvY2NhHJ9a3n//nAW9tA3oZOfl4qP99DpRIdOEta5TJ4a579SAc61Z1mRUE7Rkuh0DLPnm+TViMFEbOy+N1q02kUx8dzMKzw16eKhFKzCBUfl5ENeDZeA9ZRRpiBy0OksxelNFTQn5DsXcJ4uJSsgCIgCVy70n3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859266; c=relaxed/simple;
	bh=IbuP/LKdrsbrbtM90xkAeC+BN6cpvOVM5z5987hH2OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aSEVLKXeOTACdrEw/PquvmfbX/1qFYyQeVwAzhI08xZnMhbkDUahk56szhOnied1s1ZgDbHUz6noMiAvnrSkT4UAfhngF0FbqHBN/1PGlTsQRA6MbKTjkZ2+DyXPT0b7Vyvje0sW70lbwvMGN0rpHmflccgpRKh/w7sUFTga+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6RgL8I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4394DC4CED2;
	Wed,  6 Nov 2024 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859266;
	bh=IbuP/LKdrsbrbtM90xkAeC+BN6cpvOVM5z5987hH2OE=;
	h=From:To:Cc:Subject:Date:From;
	b=c6RgL8I1/g4Dc0WP8osiiWCTts/j3aJ41JX2UfCkm8nF/oi87e5E/Wc1FWL3XqJhl
	 TyyhtiWqYJ8D3rY4MPNSHRuYlSRQ4fj9LOvIv2cqtf1aggKOXD4/03IIlLshYbqaTv
	 Aa/NhWLk0FSFLvHYjysaAryedFoMHt343rx2U984Vn7HirCD3t2Q8h7VQCqLcc1P2D
	 y0qRzpHeRV8q3esA6bzM8GmTSKNvWPR0SkCQUcAcpzBoOWedmfcH/WP+oMR8klDyjr
	 Vwy9RsxSrbHfQAH/+JoMXq6sqvSJAmQI7w9w9Y6IOuXHXGDSyXl7ajPSbPF2/voHsQ
	 oYneUI2qiJS5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jan@jschaer.ch
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: usb-audio: Add quirks for Dell WD19 dock" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:23 -0500
Message-ID: <20241106021423.184239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4413665dd6c528b31284119e3571c25f371e1c36 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>
Date: Tue, 29 Oct 2024 23:12:49 +0100
Subject: [PATCH] ALSA: usb-audio: Add quirks for Dell WD19 dock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The WD19 family of docks has the same audio chipset as the WD15. This
change enables jack detection on the WD19.

We don't need the dell_dock_mixer_init quirk for the WD19. It is only
needed because of the dell_alc4020_map quirk for the WD15 in
mixer_maps.c, which disables the volume controls. Even for the WD15,
this quirk was apparently only needed when the dock firmware was not
updated.

Signed-off-by: Jan Schär <jan@jschaer.ch>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241029221249.15661-1-jan@jschaer.ch
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 2a9594f34dac6..6456e87e2f397 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4042,6 +4042,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x0bda, 0x402e): /* Dell WD19 dock */
+		err = dell_dock_mixer_create(mixer);
+		break;
 
 	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
 	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */
-- 
2.43.0





