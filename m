Return-Path: <stable+bounces-64910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7902943C39
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D978D1C20F70
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153261AB53C;
	Thu,  1 Aug 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUeonDye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0B1AB51B;
	Thu,  1 Aug 2024 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471397; cv=none; b=rHHf+MvlNBbF2SzFt2rdRxIvfeOPtwXL/SiT0oTjZ2ywHUEXCo5lMWQLGafu9iBbqGCSqJV9Ycv9YK8GjVip9wrsQJZFjm1YAS1gxWt3itc1BUgKD2+80f9MLSpMtt1ZjZidM/KDTM3Od66GVmsO7pQ1GBR1tWu+3yenHOX9D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471397; c=relaxed/simple;
	bh=TIr3vGxb1s5vlja4H1LMOzhTPMwN4tl6f3+1Atf2mJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVpMWjGpuet3oWetET16JjQ+HVfjPeRttJOSnRgKrOKeNZs6Lr8Uo1KSCu2OZNZEjkHil1lipjum8HjHiNxKsJSTfxV1ONpQPAB7y2dBS7pQ+u4Sdohq2TEXFJcVIYkqNJar5MJGRyD6ThLIe3+SxkNGYwIzBW05oZNnhCXkgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUeonDye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C20C116B1;
	Thu,  1 Aug 2024 00:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471397;
	bh=TIr3vGxb1s5vlja4H1LMOzhTPMwN4tl6f3+1Atf2mJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUeonDyeSY63bAtZxSFUj4hCWcTu6xJzmeZt4bY2zYXvfciMBbY7nGysA1A3lwEgW
	 xpa2ITaPzXL7NQ17v7Uq32aR8koOpiyZ6h4CYELr+Sh2JlOi+5pfGET/lvVR9H+ze7
	 jIe3IPOD1GYkB1T7WFZiQ/sUTqCKXVTkcNjPRoz//SVOu6usAOK29Q0WAp+cuYSvxR
	 V20iDhxymHWLTMUKYwByh50dnLWuzCCi2OCWGVjEVlU82dBpinwyEax8KZAkp6CpW/
	 l1+zPnQytb7tWMQnIJ73dxzGQOjZ4JmETbqujYY8kv83WUaEgc00a4Q1QS0LLH1P+Q
	 YyoH9sZBO3EdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	cujomalainey@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 085/121] ALSA: control: Apply sanity check of input values for user elements
Date: Wed, 31 Jul 2024 20:00:23 -0400
Message-ID: <20240801000834.3930818-85-sashal@kernel.org>
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

[ Upstream commit 50ed081284fe2bfd1f25e8b92f4f6a4990e73c0a ]

Although we have already a mechanism for sanity checks of input values
for control writes, it's not applied unless the kconfig
CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
Nevertheless, it still makes sense to apply the same check for user
elements despite of its cost, as that's the only way to filter out the
invalid values; the user controls are handled solely in ALSA core
code, and there is no corresponding driver, after all.

This patch adds the same input value validation for user control
elements at its put callback.  The kselftest will be happier with this
change, as the incorrect values will be bailed out now with errors.

For other normal controls, the check is applied still only when
CONFIG_SND_CTL_INPUT_VALIDATION is set.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/20240616073454.16512-4-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb0c60044f7b3..1dd2337e29300 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1480,12 +1480,16 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
+	int err, change;
 	struct user_element *ue = kcontrol->private_data;
 	unsigned int size = ue->elem_data_size;
 	char *dst = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
+	err = sanity_check_input_values(ue->card, ucontrol, &ue->info, false);
+	if (err < 0)
+		return err;
+
 	change = memcmp(&ucontrol->value, dst, size) != 0;
 	if (change)
 		memcpy(dst, &ucontrol->value, size);
-- 
2.43.0


