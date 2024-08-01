Return-Path: <stable+bounces-65004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAE943D73
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD31D286270
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554871C8225;
	Thu,  1 Aug 2024 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flfh8wMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A116EB6F;
	Thu,  1 Aug 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471912; cv=none; b=sbXX+IfomJTV7Q3yNsVHDIr7vJnQpPN0EeZ24+hi+HJpE7M4pkiEWGt1RYeuEeOL7ZDoTu0mVfB0lqb4FU7DmANgVQIipsS+Un3A9mIuCaWWKaSXReAv6RKVYqDtwPvCJ4IBv0+euKr2qXnxlmVpw1Z7VAnqHHRS9m5Inw/CW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471912; c=relaxed/simple;
	bh=DhU5oocw+PZbBqrFo2Ki/w0vnBrHmQJUxZ4e3E27Fdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grvmtFIQ9gmIAh5y8l2CaJj9LPPL+mBoKUXP+mYJcl1icwpoDNgWgZgh+V5Dpa8zTHc1v1FNCpgXdADWTKAcZGAOo50t4JNFoK+4qyva01QCYwMhUCsG6HubBAGkJYHwUx8ptxXzoOh+Z9vpb8YsTvi5qapLKghCjaU//GI+roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flfh8wMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C93FC116B1;
	Thu,  1 Aug 2024 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471911;
	bh=DhU5oocw+PZbBqrFo2Ki/w0vnBrHmQJUxZ4e3E27Fdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Flfh8wMvPn/oDh9OoDcOFLQy+Sddd/GgqG8MoF1beW3d5rSqCdH0GEbOqTQ97q7Cx
	 aLpH/hCUOHbxOYaMg+rIV0eIFpLhC4JSat89WQJm8s8M9AANK7VLraVhI3qEuDXiJH
	 dIlDPG1D1n0zD5L9N7XlUO6mvDXpjSdp0NA2IA/uJHNuxc0wIX0iP7zNuVXjHMijGA
	 9d//aw5Eef8VARYKiCqB7EjfjqDregdFOWxBbVo6tOZnBLeNXeBwmygF6UpkKBPVPI
	 EKT8Tvnnk0gYDXRS59ITe0L/rpEXip8PVR5Tu8HnVn2vaQJiTR+leZEL/AurcfG2vV
	 gXQAxAs5l21JQ==
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
Subject: [PATCH AUTOSEL 6.6 58/83] ALSA: control: Apply sanity check of input values for user elements
Date: Wed, 31 Jul 2024 20:18:13 -0400
Message-ID: <20240801002107.3934037-58-sashal@kernel.org>
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
index 59c8658966d4c..dd4bdb39782cd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1553,12 +1553,16 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
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


