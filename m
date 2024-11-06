Return-Path: <stable+bounces-89992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573619BDC58
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA61F249E9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40E1DED51;
	Wed,  6 Nov 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0vlrshT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E871DED4A;
	Wed,  6 Nov 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859109; cv=none; b=XXpxmRk56e1Ocoi0KAU1LCsaenR6kMTJVedl7y4PLQ1Yvbgdwfvl//T9ZAbCwoFQUeGkbdKXFFwsQlb+zbO315TzfF+2ecszKDxPbcCHsr4vEbiTAupH40mn13y6deoP9WHxvnL3ypv+6B109f5nf66DOTFybOPEzZpuNtmHrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859109; c=relaxed/simple;
	bh=qy5kpwvp5FoF/kDBdMOQEMr0kDst9jy3O5XZHrtXb10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nR6IcTd8uwxbdIilNii3FRupSvDnnadGwyHe7pRc5G49GrdH/fcKFwVI3vdv+6IfIUBnZsR9wG8/UlcaX6pTcR6HMao6zPuc+6x4BpdTrPheyiDQ/O7z4wqbgfsuzuCv6vVrKYD8CEUMQ6pkdHUb87V7xKWc/h+plbv12HY+Em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0vlrshT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68246C4CECF;
	Wed,  6 Nov 2024 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859109;
	bh=qy5kpwvp5FoF/kDBdMOQEMr0kDst9jy3O5XZHrtXb10=;
	h=From:To:Cc:Subject:Date:From;
	b=J0vlrshToFzqRPaeQMQCxKGeQFEjgkEZredjJXLwGc+h7LIyNHUmKDP2iOzgW9sS2
	 dyj66tc8wz1VCrAvMlfGFGN9pto8zIK49m6G3mf9mi7ndglawE0KO1igdw7gXUPRmz
	 u7vZSKX5OsKb+KHA7ueNsMlr1939ieVpIl38mbYTQ3C85ESTvBEtXtbFWt6CPTR0hD
	 c+umQrSsj9vJoRDaVelRfCizHbBXKs7iopQm3x6GXRiQRkqtfdA9WmkArgLc9c9kmK
	 Fi3U1xjXoKUlmEuxlg7job4vvL7FOTUThzAEC+noZBn2BXU2z0tbQuLEIpTJQjd7Rl
	 AI4bRbYyGTu3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jan@jschaer.ch
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: usb-audio: Add quirks for Dell WD19 dock" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:11:46 -0500
Message-ID: <20241106021146.182457-1-sashal@kernel.org>
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

The patch below does not apply to the v5.15-stable tree.
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





