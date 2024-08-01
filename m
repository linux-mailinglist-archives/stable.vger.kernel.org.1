Return-Path: <stable+bounces-65003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97195943D72
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1913B27226
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2A1C7B9A;
	Thu,  1 Aug 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAcWabUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC21C7B92;
	Thu,  1 Aug 2024 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471909; cv=none; b=u5YizgtkhOk5HdMtILXAfnGcs1iqswKycZrBeS/AhyLtWaTxUmGa+ZLJaWDRhiACI7CInTa/fdLRrqPkEV3QrtkWje7QCejNsu/T0NcF7nfEzE2SUNK/8kKzGl5lUUO7iJY7oQvraQntipu5kpssG8uDoDyo2BfKLLh8QMp18V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471909; c=relaxed/simple;
	bh=+abVqAIafNoWsC9qgZBL7u6UVTgtQ33tSHOmvPl2Qs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFhNKpyqaemIeax6A2zPOm5XiXLjN5cxFHmLp7mu3Ol73m2OWit46rPjFBbY+zcfhKk+fG65jsYTANDm6/xJzI0bYKtb4KYM62H9Ze2zYu/jeoTKeznwXcOXQRNdr82S3xUzZ5f7YDrhtQ3pivKJ002sjM5T6tHyX+SZb5ILb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAcWabUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD25C32786;
	Thu,  1 Aug 2024 00:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471908;
	bh=+abVqAIafNoWsC9qgZBL7u6UVTgtQ33tSHOmvPl2Qs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAcWabUo3GE85X0t0XzhMt7XHU1vsYHTOrj6tLO6QdM5HgDdoOCleRIquIA/eLMi0
	 9ap3zSOdbQlE70ZMufTecQz5s0UlnyCCPD+CVYfz1qGFU0JQv4OALxjL9zZi/h8oOc
	 QrQxmPrBNTTLw3APiTbzQReqnS89IilCgTvhYooj4mGuXYjDba1iEAJwv7C1Xo/Xn4
	 3LtAnOGx2qhnKdYV7N+2BWBYZmehnYqLxFEMHA896VsFCuj41CjnkNLQM0/KGjoiWi
	 deRUr0vWhMR6HLQYYKYVJRfcwq37ckyTvPzT8z2PtcIFVEE10BDN8FWh/77h3MP7XF
	 upBiVqwcQz9zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 57/83] ALSA: vmaster: Return error for invalid input values
Date: Wed, 31 Jul 2024 20:18:12 -0400
Message-ID: <20240801002107.3934037-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
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
index 378d2c7c3d4af..4bc084b686d83 100644
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
@@ -372,6 +378,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
 	new_val = ucontrol->value.integer.value[0];
 	if (new_val == old_val)
 		return 0;
+	if (new_val < master->info.min_val || new_val > master->info.max_val)
+		return -EINVAL;
 
 	err = sync_followers(master, old_val, new_val);
 	if (err < 0)
-- 
2.43.0


