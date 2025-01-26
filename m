Return-Path: <stable+bounces-110760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C6A1CC2C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5829C165F71
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3242343C5;
	Sun, 26 Jan 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q71B+XuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1D2343B6;
	Sun, 26 Jan 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904108; cv=none; b=Q8PNHgJjnhum53SQdhDHNBfTQO+sIQ7VMSb8g9td6sRdKTo+B9OTOVVqj5NUE543fGuKzfJOBWyiHxVU0KmhyduddydQbS1a1GSkc/nCD0tUHrfbzaW2WXesyihjDa0umj5GS94ykUhGyMIi+jeUMTxWL03AdMj1WZx+F3yKIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904108; c=relaxed/simple;
	bh=V0jYxOHmKXTRrJAAYyaDP3rjDSUT8r0AAqZXubMnO9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsdC1dNKGpaDmYP5wAyv/3lgcC3HoU/gHmO7v35HJB/pvqvWL3NS+pyVYIy6IkglsCPcwPJTElSgNeU+MzSRvjixV9PMVwIeUWb1M2Fm5/GrG9cWwRfELwH83oXZM6cQqX1w2CWRUMS799i/Ik+N01NgvafdbDiJlsd5URWWHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q71B+XuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90364C4CED3;
	Sun, 26 Jan 2025 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904108;
	bh=V0jYxOHmKXTRrJAAYyaDP3rjDSUT8r0AAqZXubMnO9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q71B+XuXOZ42nNs/WOxp+KndsBFbmy8ybPyiyRf5kxc1e/Mcd/be54g52mbQERjNK
	 ab75NcE9EtoE8NEdH24AUkR+Nn/l9/314zfvB3GJFggGgM9WKGRchb8193fhPIz9oh
	 FCYhcn5NSyyWDVZhyIBR6Bd7LgG6n39ugtqnnTJi89B0i/rqSZZ6Nc1yvG20xHBwLg
	 AIwp+eFMlxP1R48mpirKhe6RbUG7en09oc3az1G092563hlVICqJrq87mB+RSfZ6nU
	 x6iuIh2cXYI67H+PE++WPoNAOu+Fs3K45mzIyKyfqdNuXlsRPTXWHZAuJIgycXCLAj
	 Top6J++65H86g==
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
Subject: [PATCH AUTOSEL 6.12 09/14] ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback
Date: Sun, 26 Jan 2025 10:07:56 -0500
Message-Id: <20250126150803.962459-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 7a59121fc323c..1102599403c53 100644
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
@@ -1001,7 +1000,13 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
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
@@ -1013,6 +1018,13 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
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
 
@@ -2554,7 +2566,13 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
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
@@ -2594,7 +2612,13 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
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


