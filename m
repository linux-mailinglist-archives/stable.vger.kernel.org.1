Return-Path: <stable+bounces-64909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19913943C35
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E1E281468
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973241A8BE7;
	Thu,  1 Aug 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUdugZsl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE614B95F;
	Thu,  1 Aug 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471394; cv=none; b=kPscdYQiWdCDERHC7HrUI62FsiuCvxh4fn5oTI6ETgiUFOsOH9062RdjPUlruRe0HeJtzEP8fcVRmTnVqy92e+J1AVRVeb5PssNpyGsqmO9DQdGlXpj2inwUgHBU856snlXDnLlkTBec2FaLAWHg7EDpAx5CnTvS7S24RFT757s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471394; c=relaxed/simple;
	bh=V4Kcgb0nUBZTrD5W899N/HFd0MuzKFq4G9y3UypF5Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pobMgOTZ6mz4INXstlrXgK085FG6tj4/xbccNo6sXXuF0Lc9jprLVgPdmdcw+812VecDfB9kWOaYuBx8xUN/eU82NDdcZvYZ6i0m5FavNEutup8ZrnavP44hQwu31v2TEcjqPCJRWQgTI/3usDulcTQRE/eSVBVAcUcJ3vyKBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUdugZsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2181DC4AF10;
	Thu,  1 Aug 2024 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471394;
	bh=V4Kcgb0nUBZTrD5W899N/HFd0MuzKFq4G9y3UypF5Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUdugZsl6D/+vFCuIdJWOF3sruPoMg1evs/P+TXLpQfXnaF9lpoQPuHLYoQ/VG3Fi
	 zbYCmVdzv4YqoDPv5Bld0dpKViFy0Ht7yHvK43Nx1ipyv5ELeAopBE9Kd22Ozio2U+
	 cTJPOSa6mih9Nscoo7CfZth7cyNZr570ieccIuZ0rR+0CmoxldcAlKAJdDi1kj7sVM
	 pNNQr9oUOC1K/2vYx37CTepATsEn2Iy7wGnS+cyhuYJukgi+ymuNIPsxR2l8GEbDgE
	 khr4zo1rL31h7ntWcMZcNANYr+Lek56AmLP0//Ie75YLzpQkz9HLNZ6xqVz01iAIrd
	 rJVSvhe2mOX5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 084/121] ALSA: vmaster: Return error for invalid input values
Date: Wed, 31 Jul 2024 20:00:22 -0400
Message-ID: <20240801000834.3930818-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
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
index 04a57f7be6ea4..c657659b236c4 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -198,6 +198,12 @@ static int follower_put(struct snd_kcontrol *kcontrol,
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
@@ -365,6 +371,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
 	new_val = ucontrol->value.integer.value[0];
 	if (new_val == old_val)
 		return 0;
+	if (new_val < master->info.min_val || new_val > master->info.max_val)
+		return -EINVAL;
 
 	err = sync_followers(master, old_val, new_val);
 	if (err < 0)
-- 
2.43.0


