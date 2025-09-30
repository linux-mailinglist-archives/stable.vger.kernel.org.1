Return-Path: <stable+bounces-182271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED45BAD713
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C414A3C4D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAD306D54;
	Tue, 30 Sep 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPteIkFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E330506C;
	Tue, 30 Sep 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244405; cv=none; b=h+72bOTMpbXwxYxhQvShlBSdHXffwS6EjEeGkpNgIJ/GGDQvZKp/Zp26C2mL3Bk8nOoFToCEZFCuwkcKF4f/70jA9KTbsNtTxgRzvRM7xTgWOk+L4iI0KFX5wCgjNIxfyPfNiV09eooxP5r0FOubi5UPPMBCORuxClcDYzfrP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244405; c=relaxed/simple;
	bh=0DkEjN08FXjPwlrGIkQTaFGgAfmyz0BLHANnMZ/XIr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDdLWjNdkFPuUFKhhaEQpiagbJjhdCZHcjNIFq3X0z/bjZMu+M7i5Ctx4rEsU/2wkdpBVRKDpmUiPm6Z4LwzPUQXtsmEbAg3W3o/ceMKCkh8K4obyfvvMuqiLUgC/eY5c6XqjhaCPDA50pP1Obw7cU+17uz6YX89nVY2MT7oi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPteIkFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA36C4CEF0;
	Tue, 30 Sep 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244405;
	bh=0DkEjN08FXjPwlrGIkQTaFGgAfmyz0BLHANnMZ/XIr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zPteIkFPK+LG6XKVZM0uRnzEzyMERmV/9J2qKFp7LjZMxgRQWunbpLeQsGdo/fpEq
	 T+4XImF3n64ZEZGAfy+l0NwlxjnceQehFplhxHauo5++f+p4iBRWiLq2lTMQnzG/Vk
	 7sS41IPvTQ5qdEYwLGolSg68MrtS+6HhSgAsmAvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 088/122] ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
Date: Tue, 30 Sep 2025 16:46:59 +0200
Message-ID: <20250930143826.595638426@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 9cea7425595697802e8d55a322a251999554b8b1 ]

Adding a memory barrier before wake_up() in
snd_usb_soundblaster_remote_complete() is supposed to ensure the write
to mixer->rc_code is visible in wait_event_interruptible() from
snd_usb_sbrc_hwdep_read().

However, this is not really necessary, since wake_up() is just a wrapper
over __wake_up() which already executes a full memory barrier before
accessing the state of the task to be waken up.

Drop the redundant call to wmb() and implicitly fix the checkpatch
complaint:

  WARNING: memory barrier without comment

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250526-dualsense-alsa-jack-v1-8-1a821463b632@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 9243094cc0637..29ef56323a7a2 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -208,7 +208,6 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
-- 
2.51.0




