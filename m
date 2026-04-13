Return-Path: <stable+bounces-237156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBf/FFch3WneaAkAu9opvQ
	(envelope-from <stable+bounces-237156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 460763F081E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0033302B5BF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8D3168EE;
	Mon, 13 Apr 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/W7kb3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218313161AB;
	Mon, 13 Apr 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098733; cv=none; b=u0pMBcL8s9EJCeJgdWPLVz3rPBA1PDC/AefSp9G2KgrIbgJAT+CweZX98rDc5n/Xr7F+VcOGC6UYm9QX/mJQpchaEwzJYrwF4RgSNFD+9ulaojJyvvDsiqioCPbVsCrcR40H6EwlCeQ67Ploa2WtzuseKLMigUh+xDNAFX3pz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098733; c=relaxed/simple;
	bh=OUhokfpNUgToM8VFuvIcdUtGlmiaY92zZpfwbqaw74g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjDtRDaUjfMbATNY1VtBNmz5Kawc4broEdqOTurgNkLzfSHKe7N/NLhxMlV9+uXPR9mODIT0n6z+meYXEhYTYxA7QRKqub4tn0IvNUfemiXxEnmOqcArO77Dv6IDo2w/betRHRQHytbKQX39dNQ4C3aQfJ7b53aZFOQhY7Rwz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/W7kb3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D2C2BCB8;
	Mon, 13 Apr 2026 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098733;
	bh=OUhokfpNUgToM8VFuvIcdUtGlmiaY92zZpfwbqaw74g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/W7kb3qcQEaPb63GBfiA2AHpJbDCT6a9pG9KhnQDgHxdtdkrVTehFUVOmgw99s9X
	 VcpIl+910Ee6yf2hjQW/8mDlm4k4cJ3P6kLcXfWhwhoyICWO5+aKJxr21wvG1NclLk
	 LmRXhurZmhDkpjbgPE47SpMho/TSz168zY1mkEQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 066/491] ASoC: dont indicate error message for snd_soc_[pcm_]dai_xxx()
Date: Mon, 13 Apr 2026 17:55:11 +0200
Message-ID: <20260413155821.518138749@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237156-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 460763F081E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 62462e018220895267450155b188f5804f54c202 ]

All snd_soc_dai_xxx() and snd_soc_pcm_dai_xxx() itself
indicate error message if failed.
Its caller doesn't need to indicate duplicated error message.
This patch removes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87a6r5utaa.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 95bc5c225513 ("ASoC: soc-core: flush delayed work before removing DAIs and widgets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 16 +++-------------
 sound/soc/soc-dapm.c | 24 ++++++------------------
 sound/soc/soc-pcm.c  | 10 ++--------
 3 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 77f8d458406b0..8620e415f6fce 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1099,12 +1099,8 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 
 	/* create compress_device if possible */
 	ret = snd_soc_dai_compress_new(cpu_dai, rtd, num);
-	if (ret != -ENOTSUPP) {
-		if (ret < 0)
-			dev_err(card->dev, "ASoC: can't create compress %s\n",
-				dai_link->stream_name);
+	if (ret != -ENOTSUPP)
 		return ret;
-	}
 
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
@@ -1432,11 +1428,8 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
-		if (ret != 0 && ret != -ENOTSUPP) {
-			dev_warn(codec_dai->dev,
-				 "ASoC: Failed to set DAI format: %d\n", ret);
+		if (ret != 0 && ret != -ENOTSUPP)
 			return ret;
-		}
 	}
 
 	/*
@@ -1465,11 +1458,8 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 			fmt = inv_dai_fmt;
 
 		ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-		if (ret != 0 && ret != -ENOTSUPP) {
-			dev_warn(cpu_dai->dev,
-				 "ASoC: Failed to set DAI format: %d\n", ret);
+		if (ret != 0 && ret != -ENOTSUPP)
 			return ret;
-		}
 	}
 
 	return 0;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 175c8c264b62b..a3bebea5879b1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3856,11 +3856,9 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 		source = path->source->priv;
 
 		ret = snd_soc_dai_startup(source, substream);
-		if (ret < 0) {
-			dev_err(source->dev,
-				"ASoC: startup() failed: %d\n", ret);
+		if (ret < 0)
 			goto out;
-		}
+
 		snd_soc_dai_activate(source, substream->stream);
 	}
 
@@ -3869,11 +3867,9 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 		sink = path->sink->priv;
 
 		ret = snd_soc_dai_startup(sink, substream);
-		if (ret < 0) {
-			dev_err(sink->dev,
-				"ASoC: startup() failed: %d\n", ret);
+		if (ret < 0)
 			goto out;
-		}
+
 		snd_soc_dai_activate(sink, substream->stream);
 	}
 
@@ -3968,11 +3964,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
 
-			ret = snd_soc_dai_digital_mute(sink, 0,
-						       SNDRV_PCM_STREAM_PLAYBACK);
-			if (ret != 0 && ret != -ENOTSUPP)
-				dev_warn(sink->dev,
-					 "ASoC: Failed to unmute: %d\n", ret);
+			snd_soc_dai_digital_mute(sink, 0, SNDRV_PCM_STREAM_PLAYBACK);
 			ret = 0;
 		}
 		break;
@@ -3981,11 +3973,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
 
-			ret = snd_soc_dai_digital_mute(sink, 1,
-						       SNDRV_PCM_STREAM_PLAYBACK);
-			if (ret != 0 && ret != -ENOTSUPP)
-				dev_warn(sink->dev,
-					 "ASoC: Failed to mute: %d\n", ret);
+			snd_soc_dai_digital_mute(sink, 1, SNDRV_PCM_STREAM_PLAYBACK);
 			ret = 0;
 		}
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e52c030bd17a2..c82d653e6c378 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -821,10 +821,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		goto out;
 
 	ret = snd_soc_pcm_dai_prepare(substream);
-	if (ret < 0) {
-		dev_err(rtd->dev, "ASoC: DAI prepare error: %d\n", ret);
+	if (ret < 0)
 		goto out;
-	}
 
 	/* cancel any delayed stream shutdown that is pending */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -2414,8 +2412,6 @@ static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 				fe->dai_link->name);
 
 		err = snd_soc_pcm_dai_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_STOP);
-		if (err < 0)
-			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);
 	} else {
 		dev_dbg(fe->dev, "ASoC: trigger FE %s cmd stop\n",
 			fe->dai_link->name);
@@ -2492,10 +2488,8 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 				fe->dai_link->name);
 
 		ret = snd_soc_pcm_dai_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_START);
-		if (ret < 0) {
-			dev_err(fe->dev,"ASoC: bespoke trigger FE failed %d\n", ret);
+		if (ret < 0)
 			goto hw_free;
-		}
 	} else {
 		dev_dbg(fe->dev, "ASoC: trigger FE %s cmd start\n",
 			fe->dai_link->name);
-- 
2.51.0




