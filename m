Return-Path: <stable+bounces-62322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D251493E873
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D50B280D0F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A479B8E;
	Sun, 28 Jul 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqnFHHIg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462F18FDCA;
	Sun, 28 Jul 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183026; cv=none; b=r7+xijgzJGouhzuXsSdO+dC++R/TcLUywWPjm76gOmszANFzfjXWF535HPT+kq6wUlOEPU5zfEYUyRHAnc7VzTqWz4csdDso9r3hBjnW533790q8yPsLW7yl4jZYeeX9P7JOZZ5a3ZvyXX00BMKwyYtpkbjFt90c0bms7pOY9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183026; c=relaxed/simple;
	bh=BHaPwhf8KofwFKOBg7cQP8G10M+wldC++Wz8UvunJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC6v7wDlJIb1PqEsaSe88sQiMjYrP6UNsSr0lJ7b3u7XpDiH6iPFUC1v0X0/iYtrVDMj6agLsEAuwwnUVUcb8zE1VMaPyJ5sD0xL/nU5RNoG0vEMzonzl+ubu7nCxNT8x7vsWHWWBxgI0lyaIiToaWtz5XYYkn31RzmPVZhW0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqnFHHIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFDFC32782;
	Sun, 28 Jul 2024 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183026;
	bh=BHaPwhf8KofwFKOBg7cQP8G10M+wldC++Wz8UvunJHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqnFHHIgurCzBiBqFlEL5QM/qxV5rJfEFTMXqZaSgpxEguWMSc5KbZoT3GGARePmU
	 CmsVZTQ5kJerSJjAEziXOI+4glpofflSrgHp6lJQArfUhIZT49mq+hyYUGasbl8EI0
	 jz3NHwqo+S+7609sSp4yysq2Tgd+KEubrNvaZluTB84chp8QAtjZ5mKkWPNDewIbir
	 asf9owLwFHiu1tFI2tl6CW8faMLvE3Gadc+QN2AC4SLc9npJVviHPo2mVc2clKMDln
	 aIE8AUMawqm0jKb7PINeeor+P8TuxnaNckIRdFXRcuhCaPazpTQ7u8ABFHdU1Zzyz5
	 u5w2fl50fYNQA==
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
Subject: [PATCH AUTOSEL 5.10 11/11] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:09:44 -0400
Message-ID: <20240728160954.2054068-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index b598f8f0d06ec..8826a588f5ab8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1932,6 +1932,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
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


