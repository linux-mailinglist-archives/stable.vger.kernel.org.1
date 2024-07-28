Return-Path: <stable+bounces-62283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A400493E7FC
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF292829A8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B014F121;
	Sun, 28 Jul 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJp3CHNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1414F118;
	Sun, 28 Jul 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182878; cv=none; b=sMffMhcj1vReo+ZXVrxeNcm4CSIx8X2tQxO3wOMMd+sKEoKWR6j/HYyRy1EM/xafBZO/Mb7JzIfGC6lsjwy3w8ijThOxwgTGfZqCzvsVUMq2ilwrD9nFMXoyyU802rr7OniLGvIj69qZhLU+F+xXa/qAgck9vR+jzx9cy3o7BtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182878; c=relaxed/simple;
	bh=mCQWVof3k+OA/hPelQk9vhigEC3sj6NOhINXFr37BJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n47Zt94OkA2BTfrV/7DtA2RH2k03oc6D2JTKmb5gEaGmLUSg6VjUy15nI/Fq4/16S4FB2AvzxA0b1z+bTCUyjDHpoj02XkaKlCFrk72787MzfymTy9pEN10R+eJYllHIgVePbBIJbqyeM9wiq7FhC+9wqRoMxFeNpr4rDsyWl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJp3CHNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FFFC4AF0B;
	Sun, 28 Jul 2024 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182878;
	bh=mCQWVof3k+OA/hPelQk9vhigEC3sj6NOhINXFr37BJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJp3CHNFKjTs8a++a81TBW/Kk6LR+xqCmx+zklSc+/GKd9vZ6hlSBaHUkznwqNcG4
	 OV14msgXNlkRbbIcdxEemuG5BizD1mEMuXTFYh6O7xJd0PebGMpyiR6sF7km57IPk2
	 rOGa9k8yAcDCnIUTZ3ShnHDS1taHijFKMKL83xxzeVyOnEGXFpeTcQINz060xVKegA
	 qlACqmS2vV5MLyoQFqfH7YK6y09EIETXFniMZJ2Uuy32zNvha3Vmp2w3tCLEyxllek
	 cJ7brKJwKwqziwUBiAJVSDJm+fN6DYvJ/aibjDMOHB0NddvsvmFTye/vID0QdZe5o/
	 YMk5w4N4p/DQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	xristos.thes@gmail.com,
	kl@kl.wtf,
	peter.ujfalusi@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/17] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:06:53 -0400
Message-ID: <20240728160709.2052627-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 409fc11646948..fd6b94b3b6386 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2014,6 +2014,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
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


