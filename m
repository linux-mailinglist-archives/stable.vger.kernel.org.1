Return-Path: <stable+bounces-77609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C1985F19
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6880A1C25BB0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18A188004;
	Wed, 25 Sep 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJMwupMM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F3154BEC;
	Wed, 25 Sep 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266467; cv=none; b=L6Yek9Zky/BsFwKvOxNyPmFjF12zt1SIvU0n87MdHe8UpjxynkGqdu+kQZtSB18/Ik6oQdHHxjtW+yBIZQx1n8CWo7ktZaezKu7FWzny12ts/npWWy0nHSs5YtCPKQNfPwEHLcJ42WiMPiXBYkTWkfxHyGoksb2GDvH2NrH1yD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266467; c=relaxed/simple;
	bh=UksBq5Wm/jucyYI+1KZJ9gV4dQSVhNxud9o6232EW6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfSuk+0lUBWn9oQa4kJa7KKMrxRN3DOBWRp3zaxhwJVfVySp07cnjOFSrtpZAUrwaj3p5hZujT5yCFWsMHRiuBNjr7VDWy6CeeagB7aq1QBQ80B/b83EgcJ8D0aCHkoUMRehvB5KXyG8NZSBh6K28Pr8YKVYVoUDlXy+Zp20YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJMwupMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4C1C4CEC3;
	Wed, 25 Sep 2024 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266467;
	bh=UksBq5Wm/jucyYI+1KZJ9gV4dQSVhNxud9o6232EW6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJMwupMMsWwV67Fr4pf35E6LLUATNpFojfDnx7J2MKGpPU62q9wecuQyciBL/lJkM
	 l25fk2VpscY0YrvQcVFnEBFTZVTdbymKcR5FzmWxY+zNceTrbI74yjxjK/5PEtQcRt
	 arMqMdlRJEinhMo83ist0C1xmvIuNTHztzIZ1a9l7GRhKf63DgywG+pylPfAdylVpL
	 aAitpGNEumRn/DRWcYjA1VY0GVPSxXshBGo2sYb+2npZQNY3kWvhV3jtXq225MiuQO
	 tLK/SU38Y+MJ6xOFyotjxXFrUvJ2m7R4fUm5sfHIXE/EeVwGjnfJjGznUu70aHgSJI
	 +h2hwuSAJ/syA==
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
Subject: [PATCH AUTOSEL 6.6 062/139] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Wed, 25 Sep 2024 08:08:02 -0400
Message-ID: <20240925121137.1307574-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 7c98cc831b8d9..753fb47d25913 100644
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


