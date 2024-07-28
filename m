Return-Path: <stable+bounces-62311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61A893E852
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7861F1F214BA
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3A18D4BB;
	Sun, 28 Jul 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF4aJjtP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777118D4B4;
	Sun, 28 Jul 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182983; cv=none; b=ENzxkVdaASRPnvsGof0DcdItBw4jlVI6egVKJR4iAgys44HyyGOjSfgsiA1viEmhqHAkghcQCs2ZycWjwYSxbjZsBUGvh35+3yAiqNMGWGSzJNBWB3tsb2z2zS3OtvJTHNZ8cJG/K4rEqSalAmcZ0vHDdE7YHOwcyE6tSLLnIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182983; c=relaxed/simple;
	bh=3M1mydcj+1vt01K91UiclDWJtHhgmUtBXw6S4fzmyT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/Jgr4VruR3nE5R/Kceo+SXe8C2E9WLfyf/Kl+LZ7U8eWpIQPlpHxtGY+kXc9n1VfZHUAIkyeqkVoJUt8jZyW6ED/RVLnPd3HKHPNs60q9ghkrkHf2YsZBLj44EVGxqUwG+y9OoMuaOmymJgon90Ti0fCDW0C1n96OJX+I/nc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF4aJjtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC42DC4AF0A;
	Sun, 28 Jul 2024 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182983;
	bh=3M1mydcj+1vt01K91UiclDWJtHhgmUtBXw6S4fzmyT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SF4aJjtPvZi1TMTLw/I1druNiT34YWA8pU87lwWCThhUT3HZOTZpSqxCeKtSuSuCx
	 G1urTeYsJFZHZlrsjVhY1neRA/pRpklIWOoWP9JNOAt/P6p7gi7XCt3N+I4L4doXkr
	 cAchkT6J/dw/RlCAvzOJq2ngp+rjQwhZ00geUlNGeYR8gBwkhoUDFGP5nn8yC8Z7cX
	 vLXcH01w9zF3OSeZ8j3/8vf2czSF9/dVIGR72jZzd6TB5rqY3BNIWX5PYRXZ7ZvlU+
	 mCBSd/rwSAQJRYrMNMCMiuhyfBtKY6F5KXI1oAQyB0P1/ADpI7p0EDFpjI+xvSWaPf
	 C4cI5KUckgQag==
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
Subject: [PATCH AUTOSEL 5.15 13/13] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:08:55 -0400
Message-ID: <20240728160907.2053634-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160907.2053634-1-sashal@kernel.org>
References: <20240728160907.2053634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index d818eee53c90a..f10634dc118d6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1985,6 +1985,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
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


