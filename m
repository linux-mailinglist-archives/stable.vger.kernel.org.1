Return-Path: <stable+bounces-62329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ACB93E887
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF974280CA8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666419149B;
	Sun, 28 Jul 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNQaGNbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65E191491;
	Sun, 28 Jul 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183052; cv=none; b=GW9i1W4SbJdmlo515vgsrE6RO3hZ0YpNa3/8JDy1iP2PfCydajX5tzXAq3941tazOKQzSd9thb4wGsbxRNbx/46mqm8uoGLI88LDBX5cNXKAKMrfdofP/nLQ6sBp4rsGK08VU1fqPr2FiK85zAF36Vld5IZDKq5xzFnC8FKYJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183052; c=relaxed/simple;
	bh=Juop5UgddgfGEmjsO6T3nbpR8y3z1NUs4nxOCY+2TZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE8JlifaPhqbBCuRQXp/1WNRf5BEvtF12CAxHp11pRcxNL4672oIDykC3hvsFdHlKC7rJ8kwpbPNkeZhAhEus6ScXZSSIa7T3dpJKadUdTngOMZpkoy/d4Cp5RIRoxP94ylzCq6MEXIP3GU75P3sYRUSyLtdzpNckfrv1qtM8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNQaGNbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BB0C32782;
	Sun, 28 Jul 2024 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183052;
	bh=Juop5UgddgfGEmjsO6T3nbpR8y3z1NUs4nxOCY+2TZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNQaGNbBQIWKiWLhotT3H0HI49llE9glgkGtdrxnczVc83nj5+E/mY/2k2IF8t8Ew
	 gJIdUkN1A4wmkMdZScZZ6nibeT2Lz+lEEwz3rpzJlpAC+IgEMT8rImwqtDQVh6oQHN
	 hnYCEprcAYaV+iq8HrsUcT2oRT2vr25pfgAf7BP1t70D6Bg0Bkb6jMBrnIjwnTcrf7
	 5nNdp38WAaGBmcPur7VeUjFdTpXCAiIpnKfcgpqHIkL6hUcryVzIQHdgcMNshVvrlu
	 48Mlzxe2O7cvRMOrVKoPUt4dep2tIYOLsAD/o5rgUv4gCobteg2vYyfx0+KSVMwjiz
	 62pHuUdBVHpZg==
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
Subject: [PATCH AUTOSEL 5.4 7/7] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:10:27 -0400
Message-ID: <20240728161033.2054341-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161033.2054341-1-sashal@kernel.org>
References: <20240728161033.2054341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 67eb1293fa155..1374a4e093b3f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1906,6 +1906,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
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


