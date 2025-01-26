Return-Path: <stable+bounces-110779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B4A1CC63
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625E01638A9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A80246329;
	Sun, 26 Jan 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkeXsR+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921491F9A9E;
	Sun, 26 Jan 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904157; cv=none; b=ZnGMQuenZm5Jgh5rHdSoYBSccvh1XJGDwlfjRzWmli4wtwrvkGh0lrmdlfIJ7UQblB9nCFgE7kv7Mo+sfrVubrvzGz51K3NCR83eCWHna8d1Yx9hgeL/cXWSuSxjRuZpDEoplIrPD0qfWBQIU2KrFOm+WpM1MDFs3/s5w9mtoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904157; c=relaxed/simple;
	bh=+kL57kN2RT78xP5rKDIeEPIuAKWMXRnmhHbVyIqLx98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtTI1SVdoSEh3SUSO7ou1aZUbOiqVBSx+b2p4B3mkYlL5Lsft+i4uAjFBsVkcSztZSQ7L3e+ucKM5OXfuZEIM7IDqHq0X03++yYg/zob4sgTTwdJ3oQhHDSxgUrk//lPTeAQ7R0RiuYn+igVkXmEn/GCRQe9sr0uhcj6H71BNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkeXsR+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4BBC4CED3;
	Sun, 26 Jan 2025 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904157;
	bh=+kL57kN2RT78xP5rKDIeEPIuAKWMXRnmhHbVyIqLx98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkeXsR+1iVfLZ5JIn5n9W/x7OKVJ+sZ2X/X42Qul+jyiSfJgElPUavz3R/ghHxVCj
	 G0LyREQzxf8k82yqoPxZaAedz4jI5cmKbllJeojfrYYIh0+w4aeuryCaMMh/7hIGYM
	 n5O2y1Nip6DVYv/fwCATm0U4TWO+MHiTIdluCUjBbKukerRHfTxduoVY25hl+kcnGn
	 TDtRQgqG2b0U9LSy0rc4W3edZZwsiq/j6ZEPpjXpowaLWeFgbvaFZnbi9s11y3VUV1
	 VzzKjTXeeWl+TPEB8b75fCxDV1Fg/dG3Kekqa7SdD+cCh1JyWEpCZ4KdURl705E09h
	 DYIMWrqzs94mQ==
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
Subject: [PATCH AUTOSEL 6.1 5/8] ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback
Date: Sun, 26 Jan 2025 10:08:57 -0500
Message-Id: <20250126150902.962837-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150902.962837-1-sashal@kernel.org>
References: <20250126150902.962837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
 sound/soc/soc-pcm.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f3964060a0447..3f998a09fc42e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -906,7 +906,13 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 		snd_soc_dai_digital_mute(dai, 0, substream->stream);
 
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
@@ -918,6 +924,13 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
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
 
@@ -2422,7 +2435,13 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
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
@@ -2459,7 +2478,13 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
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


