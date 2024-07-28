Return-Path: <stable+bounces-62298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CF93E828
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622E81C2165D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03141181339;
	Sun, 28 Jul 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2FJ0e40"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BF17F4EC;
	Sun, 28 Jul 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182934; cv=none; b=byXrweV+XVyMc0Y5R+naUfI+QXvysMjQutOigpgX/Ei/fh0rW+bnmS1pFztH4yp1EmmLPbL2jV5Pz7CgN4kQBZwRYiQAyM5wfpRhcnOBHVAqMR3zbq+806MvGpoxOAXYls4LQHYDSSSoaRdQ16l53QXxWAsaPvfiJYcB8O91VCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182934; c=relaxed/simple;
	bh=ExrVCeksod6JyAy+Xk0beiYQTUgn6IodPc0Grk+vbB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEoM2rx4lJpAWmkuVdCgzJDogXjau++bFAW9mAYnZdhKgpLXEZrJkTVrrWOSDDS8/LPbaVWUNnlJ2hhVP6QT1tB7MEwVtjCc3RcLoNrYyk3xrENHuYr20oU2K+7m/ela8TVTFWu4m26zrUIDGInPdSsnFzBAYV7LUo6gJfHHOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2FJ0e40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38197C4AF0F;
	Sun, 28 Jul 2024 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182934;
	bh=ExrVCeksod6JyAy+Xk0beiYQTUgn6IodPc0Grk+vbB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2FJ0e40FQ/n8qMlDHfCtdUFPFMA2hvhnyfr+ZNoL4x/VGtHmXbgYP50Kf7R6ZykK
	 fR+YDY+26baVXl5vyizkdQe+xiLNGwmjAjePlsdqn91Ylnm8vXZku2UIkqH3FuKK3y
	 K0pbumulfhu2Pnk2P5T14UyjcVBlQxVqEx/oW/cT/V2l/kNlbHo1rkypZ7MYXQW1Dy
	 MweFWeM4uMWeCq64Zo9BaR7mw1GmyDTSPm+gQ+KGga1sk9GS7RDBw5jNJdLHYhV8yB
	 WaEuklxZ9cW64ckWRTl4ZqPhZBXX+uesJ4c+HuSSHXZPDqNhTMVXdEDbR3G90j0IdM
	 H2JttF7NeZVtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	peter.ujfalusi@linux.intel.com,
	xristos.thes@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/15] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:07:59 -0400
Message-ID: <20240728160813.2053107-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 2f38cf730caedaeacdefb7ff35b0a3c1168117f9 ]

A malformed USB descriptor may pass the lengthy mixer description with
a lot of channels, and this may overflow the 32bit integer shift
size, as caught by syzbot UBSAN test.  Although this won't cause any
real trouble, it's better to address.

This patch introduces a sanity check of the number of channels to bail
out the parsing when too many channels are found.

Reported-by: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/0000000000000adac5061d3c7355@google.com
Link: https://patch.msgid.link/20240715123619.26612-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 783a2493707ea..3ed56b5a26c37 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2016,6 +2016,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		bmaControls = ftr->bmaControls;
 	}
 
+	if (channels > 32) {
+		usb_audio_info(state->chip,
+			       "usbmixer: too many channels (%d) in unit %d\n",
+			       channels, unitid);
+		return -EINVAL;
+	}
+
 	/* parse the source unit */
 	err = parse_audio_unit(state, hdr->bSourceID);
 	if (err < 0)
-- 
2.43.0


