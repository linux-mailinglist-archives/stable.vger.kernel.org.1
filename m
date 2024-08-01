Return-Path: <stable+bounces-65123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48745943EE2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F4A1F225A5
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E501DC48C;
	Thu,  1 Aug 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt1qbj7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73E1DC49D;
	Thu,  1 Aug 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472509; cv=none; b=ED/Wpz8Ilt7zZjfjDdEawsAZsNBGfhCyGf1oQ7+zkeXBZB4iYkob5kOHPRjm4yAO+TYNPji2+3TmIABFKQeC87vpfTS8kWE/aGKlLDDC2OkaG50C4+/EObZl823Xkj/l9BjPH0G5R3WR4TQuAd6x+erNZKyDLhUNg3hnht4i7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472509; c=relaxed/simple;
	bh=307qREhbpyxkCHQgzbDT+5+r8N0fY6sOKVFVij9DM24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndYzwtkgC35TALSBBZ3Thwyfuipq1c/lIvQzJMb7nx16TOzgm2aUP3ZkksXBeladSS7rmDZwaPqqBnEGjMbCpPsj50nWFllDC2coCWRSjJrhB5pUWd7QUIhRS9qnnl2nZyFDdwTMMp3ZHn6ZjRouEFv+H+FRjMdtEEVDx6U5dDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt1qbj7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E471DC116B1;
	Thu,  1 Aug 2024 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472508;
	bh=307qREhbpyxkCHQgzbDT+5+r8N0fY6sOKVFVij9DM24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt1qbj7Z6gROkk23E/SFstEf6Qw6wt/TuNd0dh0HnTmTP0ePQlD4Lpzk4tnbieaLD
	 2ujmbo9A/VIPeLdyec2qBTSDCEIJQ7m7183pGKx49q33SWKwNZb8ZL8gDB56ubi7Yl
	 QI+IX5Eq9M2f5lmeckSkJ1qmcBg/AyImoVAfv+KcM7q8m4WfXkD/WEHkz8I4DR95Hg
	 ggVYFzdlBbLSgVdHH4aWAz5W77UVzrehACSbp9Eg+e6uK3kO4lzpioJKfGMGSQX1OX
	 QEwwEQi474IWnB5ZCud4tc7h4zAkPMUXMEOB6gI8jRKtvgyTr3JHG6/szURwZVArsz
	 Ru+g3koyhOhtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 33/47] ALSA: vmaster: Return error for invalid input values
Date: Wed, 31 Jul 2024 20:31:23 -0400
Message-ID: <20240801003256.3937416-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
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

[ Upstream commit 10457f5042b4890a667e2f15a2e783490dda44d2 ]

So far the vmaster code has been tolerant about the input values and
accepts any values by correcting internally.  But now our own selftest
starts complaining about this behavior, so let's be picky and change
the behavior to return -EINVAL for invalid input values instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/20240616073454.16512-2-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/vmaster.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index ab36f9898711a..24d6f2325605c 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -204,6 +204,12 @@ static int follower_put(struct snd_kcontrol *kcontrol,
 	err = follower_init(follower);
 	if (err < 0)
 		return err;
+	for (ch = 0; ch < follower->info.count; ch++) {
+		if (ucontrol->value.integer.value[ch] < follower->info.min_val ||
+		    ucontrol->value.integer.value[ch] > follower->info.max_val)
+			return -EINVAL;
+	}
+
 	for (ch = 0; ch < follower->info.count; ch++) {
 		if (follower->vals[ch] != ucontrol->value.integer.value[ch]) {
 			changed = 1;
@@ -344,6 +350,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
 	new_val = ucontrol->value.integer.value[0];
 	if (new_val == old_val)
 		return 0;
+	if (new_val < master->info.min_val || new_val > master->info.max_val)
+		return -EINVAL;
 
 	err = sync_followers(master, old_val, new_val);
 	if (err < 0)
-- 
2.43.0


