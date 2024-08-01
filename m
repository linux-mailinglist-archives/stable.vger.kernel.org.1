Return-Path: <stable+bounces-65072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB720943E0F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD03D1C21B52
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE519DFA4;
	Thu,  1 Aug 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS6gH3cW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68068132111;
	Thu,  1 Aug 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472250; cv=none; b=eCRAGwOXipFR7jesSLtK0leBCdT71Rv3GMj/JdAWq8WCJ3YP5NOCfQz+KqZN58ADmZlfqP958QX5kE56/10tFcOxQOotFq0wsdYS8EYTTzHKNLiwbyQYq91LDYvWOhpaVvTVgtzsMe0z+YjDZi2b2vY8Cru4GEHsrs5lCEwmZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472250; c=relaxed/simple;
	bh=dA6SUaOM8ZUdtfmX8iKTHsOdPq/3dC4vnr1HvU3RJbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu8ghO2xVoGpM6RaSDM+P9IdJGaLLmHaUz/B9wCqhdlGx/wK/Wh79RdLa3Xl/hkFG2KyST/2+UJ0iKVDKrW2tYz4X64ayl4DRaohiNQDlyqTFknBVdLCJzp+oQag5gI66USHTX8vghIRHeJ29/zVFwrFTC/XRE6c8efvOSenXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS6gH3cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6691C116B1;
	Thu,  1 Aug 2024 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472250;
	bh=dA6SUaOM8ZUdtfmX8iKTHsOdPq/3dC4vnr1HvU3RJbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kS6gH3cWZX71nJFCpFig1ZtPSqVjRpWLkHWGLtT2qPIi/cTPk8JlwyiHudZYceb1T
	 sLCZ2hixOK1iFxNFEFidpDVSiHAD5bB9FeHYmVlqJtnX1Oe3/w2M3jyKcU4lGdphZ8
	 mRGlquAutPaSEeL3ViFWCh1MRqRbcbukS1e3XsQsBeUvJ/Em5rkfgAkohZhWdjHswf
	 9Gve5w23MLEl8BdlodX+UGE1PbHWluDfMcJoXWYnZVvvmpmcu4Pg/Cr4hHDyUF982a
	 FZ1Mhzwxvb/rQt4GxNj+L9Y7WirLSfHfcSj1khg4GIcXTSkWqNfFbKexQ6d8ntLveX
	 yYoKBPYwlVKXQ==
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
Subject: [PATCH AUTOSEL 6.1 43/61] ALSA: control: Apply sanity check of input values for user elements
Date: Wed, 31 Jul 2024 20:26:01 -0400
Message-ID: <20240801002803.3935985-43-sashal@kernel.org>
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
index 82aa1af1d1d87..92266c97238da 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1477,12 +1477,16 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
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


