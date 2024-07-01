Return-Path: <stable+bounces-56179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD091D549
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955B9B208B9
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC651157478;
	Mon,  1 Jul 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO8mmfOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B373BBF0;
	Mon,  1 Jul 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792870; cv=none; b=n8FhGFQg7YG2gnjozf77M7h0yPQorwkbK3rqGw79XTYk2N7T86XmG66Jrjlu6J2p/XPvZc1a0vEDtskQfCqK4tJihfovd2x+gsfr1hnWScrLHP4bP9Sv5ac1UpKJsiDmzc2rjkSRU+Igq9JMiXAxi7wUNB4/VtrDLYdVGsDPImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792870; c=relaxed/simple;
	bh=gAwPxAKbg8PEZROdsVDkt95Izpw5QxPLcCZ5sF8CjpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6rwi9hYg1FFbcHrYyiqJ3oxUaT0RiO/uNf0fg8j/t/hIocG1TLiUE5OkIc2tHRNh5PRDrOsOiNOcGnTgpMFj2WL97W3vawedD3Q/WCR4/rOjKRPFhK2MWtuU6wJDIiNRMMSyyirGazJ2Kan6rxzGw1t0incemU4S9JyZDPjDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO8mmfOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A201CC32786;
	Mon,  1 Jul 2024 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792870;
	bh=gAwPxAKbg8PEZROdsVDkt95Izpw5QxPLcCZ5sF8CjpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO8mmfOFZVWSa5O8TmZU7LVw7AtSfJa1nXm72NgA6JxJ9zlhiGYV9P2MXVvXkw4gU
	 W2zzlm8BmjesrHUbBucP4gkNkr7LnWVM9hca7DZZS+nb1RkhB2klSKnd0UX394CxVP
	 mNthG2Ld+T0sVG5MmQEZiJu16Hf7sHpaa2Hj7bd6BAqXBnsFuLPkzp1LiUb72NHeif
	 jt/r4aP7jiBX81RFtybkjHLJJ9crL/qQWxvvT/wBqOLmWBFjD81tSPXCREwMDm2qRl
	 byB6z/P4rW5VpQE5M4JgV8fiNuIEES2vjOL7nFweIYo2TG01xYc+jpDdCDWWqpXEvw
	 wnRSw9M46isYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/5] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:14:14 -0400
Message-ID: <20240701001420.2921203-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001420.2921203-1-sashal@kernel.org>
References: <20240701001420.2921203-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.96
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 70794b9563fe011988bcf6a081af9777e63e8d37 ]

If it enter to runtime D3 state, it didn't shutup Headset MIC pin.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/8d86f61e7d6f4a03b311e4eb4e5caaef@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a7104f72cabd..2723b0f2f0bb9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,10 +583,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
+	case 0x10ec0285:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
+	case 0x10ec0295:
 	case 0x10ec0298:
 		alc_headset_mic_no_shutup(codec);
 		break;
-- 
2.43.0


