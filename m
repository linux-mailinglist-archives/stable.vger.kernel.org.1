Return-Path: <stable+bounces-65071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B58943E0C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CDF1C2142C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C231D4171;
	Thu,  1 Aug 2024 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4TiB2/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D71D4169;
	Thu,  1 Aug 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472246; cv=none; b=GdueRIVFAM3gH/YS8F+pS3BmNTyUNfhIDZK8AQd63pvyMIAiqXWiDn98lbzYLlylTvmueY5OW0ff0RQVtXztEogFDz+d8aRLqDo3p6unVY5wPPoKXExUKi73LOnvXQLSDdkau2qdgh+bsyg5drZ/PoXwkVnupDNtXCAQ27SPcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472246; c=relaxed/simple;
	bh=zea6lzRx4uDEN6AQ26mHTJ1keGNuC+w2mmC3WzU+Rds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEE3jDl+awvkT/NVKDpz7hMfnAb1qOz1PIb52tiixAz4+hqvQ2nd5fn9lI/m0V57B+VZJiEixutapZOFzAWfP95Uh9kBngi9NPX5B4HhidoojmG407s8I2k809i4KJXp7qVqz5v7RG0LoYbP/gwbhNxjC9UQQFFi0CpjIK0FNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4TiB2/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D25C4AF0E;
	Thu,  1 Aug 2024 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472246;
	bh=zea6lzRx4uDEN6AQ26mHTJ1keGNuC+w2mmC3WzU+Rds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4TiB2/HlO9+audh5WklgYjQukMxcg8X3J9FtxOIyn/WFLa0da+4z3Am2y66m6lU9
	 5WIadf28HvKzBW78TmMZp8zGpZQUBKvc/hMBn5Pi9c025qUMsYHH/yzrJaY7iuc9nC
	 PtYHQN2kNr7KI04Kwsm9QCHl4wtu7CXddmeJTPzCM/Ql4XBI9pv2yXLMjZdpbr7fDq
	 B/QdXZZyE8FagS3QQ8vVUhbQB6STtJ8K0jyA0Db7/Qsz+PmM9Lu3bv4ByXiVKVknmp
	 12QHfN6iXkZokKQ9uYCqfMf6OxsJuxBaYi8ZMtWgD8UDW4qXVIk4OnGrjekbJ8TfnU
	 +BqToI3CL96Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 42/61] ALSA: vmaster: Return error for invalid input values
Date: Wed, 31 Jul 2024 20:26:00 -0400
Message-ID: <20240801002803.3935985-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
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
index d0f11f37889b5..4f1b208576a34 100644
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


