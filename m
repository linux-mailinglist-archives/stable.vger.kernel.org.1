Return-Path: <stable+bounces-217272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFiYN36slWlZTgIAu9opvQ
	(envelope-from <stable+bounces-217272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:11:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADE1563B9
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9B33014759
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45B306D36;
	Wed, 18 Feb 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c1zF88ol"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C033033E1
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416700; cv=none; b=h45qj9evREdmvv1oqH4nQ72xNNF3gOs8+2Opql9N2jqtJ85YW57JB5ffBZ1chDd6TuZTtmiLH1Z/3UmR97sIwiihPYlsBWWOQLpw68WZGDg/etNh/GQb0/Nothg+/InuKWl3K9Y/0lGyIPihG5ou7Lm7opy3mgRYcl26u+0NXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416700; c=relaxed/simple;
	bh=Pw3fZI9b2cVPG5utxMZwIpqznAduVP02xmFaGRrThcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EctshZZCuOg6+zL8UCm8ZFir0oqw20evYzRzrfquvLnOpjUlgUlkQRTMBI5UGsMyw6Fda+//2hzR3Cu58WgSycdE82DFCdeO3V7onHP3FZ3aLbK4EMnF63cfoaLv+f7aiuWL12zfHHgMVQVT26SPBTbdS6F9nKDbkZc6bJV1F9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c1zF88ol; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E01B54E40F58;
	Wed, 18 Feb 2026 12:11:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD63F60738;
	Wed, 18 Feb 2026 12:11:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4017710368B5D;
	Wed, 18 Feb 2026 13:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771416693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SZ+4RuppPKjR3qQWfgPnGLn2XDy90FMtkHwzrPksBgw=;
	b=c1zF88olfwh1e55esZHyUrYZ+A3rMtmzliwOZXO+KyGGXeKaDqg40ijVi9lrUnuqFiEk/4
	Xi3uoRvk8S3j2gnY8aMHuHqFYJWFVN+KuYtCy1Ug9gtujt5He178rzVmmxt56zf2K4Fmzm
	1BJJStUSs22nNRBxxiBMsTOKuc7lbAxZ8N1WLNDYwBGXPJVR2wkVL3rwTcEJ7bsvKRTwhf
	L7VLCoDqloOcMw85Leht4X/Pfy0sVCiWiVaGpxk0dc0NbOBtNTMnM6F7Bs5E+JnRhITVt0
	lGE7T/Dhc6y2erlYRpYaGMOw0pd5tai0rtChvut1WSMk6GpzK5UOSlAkvsvw8A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 18 Feb 2026 13:11:24 +0100
Subject: [PATCH] Revert "ASoC: rockchip: i2s_tdm: Re-add the set_sysclk
 callback"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-snd-rk3308-i2s-revert-set_sysclk-v1-1-79ab787f88ac@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGuslWkC/x2NwQqDMBAFf0X23IUkFtH+SimiyWtdlLTsSqmI/
 27ocQ4zs5NBBUa3aifFV0zeuYC/VBSnIb/AkgpTcKFxwbdsObHOde1almBcHOjKhrW3zeIyM5L
 rYtP5K/xIJfNRPOX3X9wfx3EC2kzycnIAAAA=
X-Change-ID: 20260218-snd-rk3308-i2s-revert-set_sysclk-ed09c6914e1b
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217272-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,perex.cz,suse.com,sntech.de,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 41ADE1563B9
X-Rspamd-Action: no action

This reverts commit 5323186e2e8d33c073fad51e24f18e2d6dbae2da.

The reverted commit broke this driver for the RK3308 I2S.

The 'arecord -Vmono -d 2 -c 8 -f S16_LE -r 96000 /dev/null' command on
RK3308 now results in:

  rockchip-i2s-tdm ff320000.i2s: ASoC error (-22): at snd_soc_dai_hw_params() on ff320000.i2s
   ff320000.i2s-rk3308-hifi: ASoC error (-22): at __soc_pcm_hw_params() on ff320000.i2s-rk3308-hifi

Tested on:

 * Radxa Rock Pi S
 * Upstream Linux kernel
 * arm64 defconfig

Tested kernel versions:

 * v6.12: OK
 * 5323186e2e8d (commit being reverted): FAIL
 * 5323186e2e8d^: OK
 * 21cfbeae7d7c (commit being reverted, on stable/linux-6.12.y): FAIL
 * 21cfbeae7d7c^: OK
 * v6.19: FAIL
 * v6.19 + 'git revert 5323186e2e8d': OK
 * v6.19-11566-g254edc893f3a (current master as of today): FAIL
 * v6.19-11566-g254edc893f3a (current master as of today) + this revert: OK

Fixes: 5323186e2e8d ("ASoC: rockchip: i2s_tdm: Re-add the set_sysclk callback")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/DGB6VK7LC8N7.322SYGWZXPL5W@bootlin.com/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 770b9bfbb384..b056d72e61ff 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -22,6 +22,7 @@
 
 #define DRV_NAME "rockchip-i2s-tdm"
 
+#define DEFAULT_MCLK_FS				256
 #define CH_GRP_MAX				4  /* The max channel 8 / 2 */
 #define MULTIPLEX_CH_MAX			10
 
@@ -69,8 +70,6 @@ struct rk_i2s_tdm_dev {
 	bool has_playback;
 	bool has_capture;
 	struct snd_soc_dai_driver *dai;
-	unsigned int mclk_rx_freq;
-	unsigned int mclk_tx_freq;
 };
 
 static int to_ch_num(unsigned int val)
@@ -618,27 +617,6 @@ static int rockchip_i2s_trcm_mode(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
-				       unsigned int freq, int dir)
-{
-	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
-
-	if (i2s_tdm->clk_trcm) {
-		i2s_tdm->mclk_tx_freq = freq;
-		i2s_tdm->mclk_rx_freq = freq;
-	} else {
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-			i2s_tdm->mclk_tx_freq = freq;
-		else
-			i2s_tdm->mclk_rx_freq = freq;
-	}
-
-	dev_dbg(i2s_tdm->dev, "The target mclk_%s freq is: %d\n",
-		stream ? "rx" : "tx", freq);
-
-	return 0;
-}
-
 static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params,
 				      struct snd_soc_dai *dai)
@@ -653,19 +631,15 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 
 		if (i2s_tdm->clk_trcm == TRCM_TX) {
 			mclk = i2s_tdm->mclk_tx;
-			mclk_rate = i2s_tdm->mclk_tx_freq;
 		} else if (i2s_tdm->clk_trcm == TRCM_RX) {
 			mclk = i2s_tdm->mclk_rx;
-			mclk_rate = i2s_tdm->mclk_rx_freq;
 		} else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			mclk = i2s_tdm->mclk_tx;
-			mclk_rate = i2s_tdm->mclk_tx_freq;
 		} else {
 			mclk = i2s_tdm->mclk_rx;
-			mclk_rate = i2s_tdm->mclk_rx_freq;
 		}
 
-		err = clk_set_rate(mclk, mclk_rate);
+		err = clk_set_rate(mclk, DEFAULT_MCLK_FS * params_rate(params));
 		if (err)
 			return err;
 
@@ -825,7 +799,6 @@ static const struct snd_soc_dai_ops rockchip_i2s_tdm_dai_ops = {
 	.hw_params = rockchip_i2s_tdm_hw_params,
 	.set_bclk_ratio	= rockchip_i2s_tdm_set_bclk_ratio,
 	.set_fmt = rockchip_i2s_tdm_set_fmt,
-	.set_sysclk = rockchip_i2s_tdm_set_sysclk,
 	.set_tdm_slot = rockchip_dai_tdm_slot,
 	.trigger = rockchip_i2s_tdm_trigger,
 };

---
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260218-snd-rk3308-i2s-revert-set_sysclk-ed09c6914e1b

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


