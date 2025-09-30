Return-Path: <stable+bounces-182752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF80BADD95
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64113AFF09
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557892FD1DD;
	Tue, 30 Sep 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7uCtc//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C725D1F7;
	Tue, 30 Sep 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245974; cv=none; b=I0bmt7t+y/s2r/FLz89wgumFsWVy/v9CohXwLBUWtUNioLBLQLDEZblK9MzqXBOMWTWZKMyk2xo9JwiGzXZRPGdE4utsUf7EZMlJJd1MFzjLGGrAAGQUwvqIrdQS9e7P9iD6qOkB4oWan6wSbixrUFOpsZyXHKjoBcSOZEoZcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245974; c=relaxed/simple;
	bh=YuKMosl45f2r8ecPsu2zEw15ardC5cEUDe/1t0hWlP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiDVgs/yPZ1oF9q3BIgxjcOYI8DDC5b/y50hpln89Zyrt0b+KM9fB4L9QN+ud90Q4QrkxF+VOBv7pxE/K6zvym4vIhJUDFHF1IqW0kJRGgYJ7TP6pt7YJ7AEG4acbAapcMxkCB7xqcE4wgN45wQK7epdd5CxvC5l+LaT66EgGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7uCtc//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C0FC4CEF0;
	Tue, 30 Sep 2025 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245973;
	bh=YuKMosl45f2r8ecPsu2zEw15ardC5cEUDe/1t0hWlP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7uCtc//MY0NiPVOskkhJaU2MgId/JZ2eKKKNt8CzQKG1zi0ySa32wPEU+my0E+Rj
	 r01gnx3IzUm5p365NBuUPoVogwYRNgX8cC/mc2GiEq14NUWFVaZUXIOAzzkhifdo+X
	 7asdHsF52k+Ic2UhkJreeqH5rpYBvCSXuTPP0MSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 14/89] ALSA: usb-audio: Convert comma to semicolon
Date: Tue, 30 Sep 2025 16:47:28 +0200
Message-ID: <20250930143822.461052507@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 9ca30a1b007d5fefb5752428f852a2d8d7219c1c ]

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20250612060228.1518028-1-nichen@iscas.ac.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index b495c9ccb56ca..2ee91469e6f73 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -761,9 +761,9 @@ static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
 
 	mei->ih.event = snd_dualsense_ih_event;
 	mei->ih.match = snd_dualsense_ih_match;
-	mei->ih.connect = snd_dualsense_ih_connect,
-	mei->ih.disconnect = snd_dualsense_ih_disconnect,
-	mei->ih.start = snd_dualsense_ih_start,
+	mei->ih.connect = snd_dualsense_ih_connect;
+	mei->ih.disconnect = snd_dualsense_ih_disconnect;
+	mei->ih.start = snd_dualsense_ih_start;
 	mei->ih.name = name;
 	mei->ih.id_table = mei->id_table;
 
-- 
2.51.0




