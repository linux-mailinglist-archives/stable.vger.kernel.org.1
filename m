Return-Path: <stable+bounces-110745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C1A1CC0D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605FC163DD6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77C18734F;
	Sun, 26 Jan 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz44NNRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38521F8AC6;
	Sun, 26 Jan 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904072; cv=none; b=or0gk7y1nVg8SuciOGjrjDbiWMcsP9Y/ZSCTs6tVXbiX3bXBG5CeQRBGtquFaKI71uDmOFORGWqi1r0f18qDJ801NSEUvcjRbcBI3fd5UiOsGgqhgOs+yUwIsEMVQu6OgvndciO929P+XtJlPhZ/Dt70xz/tV0vXgpGhpQLy8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904072; c=relaxed/simple;
	bh=gJXcKjX+JqmbnPTps19HdNStQEU0s2YLvyg0n8gqDmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIK1cDZZGwUUY3ThA+fs+bOx37L7+pz9qHeijYXf4E7fe2hxdl5bj9Dxl1pfDiUuIgaINCXkmsLv8H1jxD+NNHIEPwzan3zTCsI2/RqIElTsFdhjyenbg1qdrFR9C8RzU5Z1nNQ+vA+UVLDMRbQqobbmQ1/qu/WTQzszPra5DIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz44NNRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD1C4CEE2;
	Sun, 26 Jan 2025 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904071;
	bh=gJXcKjX+JqmbnPTps19HdNStQEU0s2YLvyg0n8gqDmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cz44NNRAAKULG0wzVkb3ScMRayppg36uBtc3/HbErLz6fUFVp5q1i7dFGthPFjC58
	 JNd2VXU7n2lx+jTGPyuZPqHYEdmQ2+C3i2IVPqLArrNBXY7h2ujBna1vUegd3t1sDK
	 xcxJQTwYfhHytWOuf9QFZE+UI2VrfQPqsdPFbJk/Q5zT56EGG8PXcRcBTdpuRbdimX
	 wCvn/6usjd++0hDS0cQBARo3z39lSRyzHSWvOffBUAYYs2lOBn4fM7fBAG5dFMXwq/
	 ZEwxlglY3U0mXuG7lWSrGKxJnQc6471REM5eZE31naZHNmIUTpuntaNrnL5CCcRqo4
	 /ScexOPb1TSyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 10/16] ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback
Date: Sun, 26 Jan 2025 10:07:12 -0500
Message-Id: <20250126150720.961959-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 301c26a018acb94dd537a4418cefa0f654500c6f ]

commit 1f5664351410 ("ASoC: lower "no backend DAIs enabled for ... Port"
log severity") ignores -EINVAL error message on common soc_pcm_ret().
It is used from many functions, ignoring -EINVAL is over-kill.

The reason why -EINVAL was ignored was it really should only be used
upon invalid parameters coming from userspace and in that case we don't
want to log an error since we do not want to give userspace a way to do
a denial-of-service attack on the syslog / diskspace.

So don't use soc_pcm_ret() on .prepare callback is better idea.

Link: https://lore.kernel.org/r/87v7vptzap.wl-kuninori.morimoto.gx@renesas.com
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87bjxg8jju.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1150455619aa4..88b3ad5a25520 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -38,7 +38,6 @@ static inline int _soc_pcm_ret(struct snd_soc_pcm_runtime *rtd,
 	switch (ret) {
 	case -EPROBE_DEFER:
 	case -ENOTSUPP:
-	case -EINVAL:
 		break;
 	default:
 		dev_err(rtd->dev,
@@ -986,7 +985,13 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 	}
 
 out:
-	return soc_pcm_ret(rtd, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 /* PCM prepare ops for non-DPCM streams */
@@ -998,6 +1003,13 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dpcm_mutex_lock(rtd);
 	ret = __soc_pcm_prepare(rtd, substream);
 	snd_soc_dpcm_mutex_unlock(rtd);
+
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
 	return ret;
 }
 
@@ -2539,7 +2551,13 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 	}
 
-	return soc_pcm_ret(fe, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
@@ -2579,7 +2597,13 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	snd_soc_dpcm_mutex_unlock(fe);
 
-	return soc_pcm_ret(fe, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
-- 
2.39.5


