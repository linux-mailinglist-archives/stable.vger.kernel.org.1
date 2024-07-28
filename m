Return-Path: <stable+bounces-62333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07DF93E893
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758B6B22DCF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B511922F3;
	Sun, 28 Jul 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4ruFJSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFEF7FBB7;
	Sun, 28 Jul 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183064; cv=none; b=VhXebyKWZpZpaBS1nTjSIASmvjf0thTcQSRO2Tt8cTyynTmBMqVzGFH4WD74R/ia+fhmWV/cIitBbxlP3c95AFF6T2xPvOk75mKiwwMYKoMi0U7gpIbR71kj1iftbSaIzAthMOJ+X70uD35tP3IuVYqA+uEAF+ketkE4OxtTFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183064; c=relaxed/simple;
	bh=k4+eVN+vaw5dF351vpZrGQ3K9Lgs02TzdsKCOYRzh68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNafbdFUY8WoaWqsW8pKbPTlhS9gTJ1vWKJPOPdHXEt1MHp0KgQ23tc6TFkT1yi+JpaPZb5O4QkRDb4qZfMrLKe4pMeVuHwAWHVlSz1+Og010P6nEKLSr/DaFeBtwUwiPQoMjuC5VZAX/XlEbPOGvzgf7hFSgPO52c54dD3CNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4ruFJSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B8C4AF0A;
	Sun, 28 Jul 2024 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183064;
	bh=k4+eVN+vaw5dF351vpZrGQ3K9Lgs02TzdsKCOYRzh68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4ruFJSAC1cRNomquyIQrWbp+wmjlurc7rIGX3B28muXX8P/SSpbBucDK3zRHc+3o
	 VsMW7tjiEbpt6L+KHdJD9/cKVaKjMvPT6htf3TNlhfzMqV86DUFUMrwTxV0dtaG7Hl
	 vU9aX4p/rJit6OAF0q7qCWTkcLAqC46+zMLB/HQt3FB3Oaa4aFflwaNxOq5gTkiNkD
	 7Fq9quS4KWp4Z9PlwX1wvqf2Yz/PoTR2kacHZtnPQ1t1afKepaoG9fHGzOXgSUUhV+
	 vWpvVBJPz0iRqS/cD3Hl7CWsafjfu1kc+rplKGojYIcfv0XTl9d3L1VyhN32E9vXS2
	 pzJIwoYnQoKHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	xristos.thes@gmail.com,
	peter.ujfalusi@linux.intel.com,
	kl@kl.wtf,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/4] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:10:53 -0400
Message-ID: <20240728161055.2054513-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161055.2054513-1-sashal@kernel.org>
References: <20240728161055.2054513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 6c8cdce8156be..fbfb729212d3b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1921,6 +1921,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
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


