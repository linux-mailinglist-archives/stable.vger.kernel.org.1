Return-Path: <stable+bounces-62266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8EA93E7C5
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4081C21182
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3C14263B;
	Sun, 28 Jul 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmLw0aYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E216EB7D;
	Sun, 28 Jul 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182812; cv=none; b=UzI4C/Z/2JBheqaMWUhmWg0e3DEdkjZcqZuwCR6JP/60ie4ewLmDLqSMpUzk8k/LBRp1f0guu6USZ0oBWygg05s91oVG6LHVGca3Y0k54Gd2Sg/JmIG6KxURsGEfhxPPrJ0ew7EyRmaoYFevroutyeXrfl+NUsuXnZi0y39PeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182812; c=relaxed/simple;
	bh=mCQWVof3k+OA/hPelQk9vhigEC3sj6NOhINXFr37BJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W59U0a1x8P6PdxJGeMcoJyMUyQHewH4NsAp4jG9cFOvJTgIZI2/O+liq4Qx7kco+BF7PfnH3iMkkyE+tHZKIhyzaZboI1+edkUSoxSW+QSoGt6nG9RrPodyMQKWv5uFZMDKdZfeaopg3qHrP8yZ4+MnjNzEWRnrq9xUW3H8wATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmLw0aYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC102C4AF0B;
	Sun, 28 Jul 2024 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182812;
	bh=mCQWVof3k+OA/hPelQk9vhigEC3sj6NOhINXFr37BJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmLw0aYA3vX/JvoLnm4QaaBnybbi1JcNpiICpRU6B0vo8CTos6+MeNRlGG6MZp7sB
	 eaN/I4brta/0bvTwa+FFKemZs+ubPP/A0pQlg8sWFFPlFFSZibqMgJFH8vfwZinrTn
	 fwO47WNRAtXtVjjpygQtCKbVNAVRE8m39ucLOmjAFvOwMhrh1kJ9TZN+L7TlWEm3cR
	 Q1DCi+qfT+G3yT+5a5ArAVPIbJKaRdbeuIKbrtx8KSqJwNEvw9XV7ujoFhJCuzOCZC
	 oEWNklWPacHp4JSM3eOBj44BxyQI4gd2f57XQM/oE2AqvDHWh4uZTmu9L33ctO3Rap
	 73E79HNyaEvDQ==
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
Subject: [PATCH AUTOSEL 6.10 23/23] ALSA: usb: Fix UBSAN warning in parse_audio_unit()
Date: Sun, 28 Jul 2024 12:05:04 -0400
Message-ID: <20240728160538.2051879-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


