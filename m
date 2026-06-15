Return-Path: <stable+bounces-263281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pm81EDQRMGpLMwUAu9opvQ
	(envelope-from <stable+bounces-263281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:50:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF576875CC
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VvRJcm+j;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263281-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263281-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6998A3018796
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069B3FC5A0;
	Mon, 15 Jun 2026 14:47:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CD3FC5A3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:47:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534840; cv=none; b=eC5LvoWeGQJWfVmTuLk2reluyUMh232fh3jfXn+nb0ye6XctMhs3SrmzCaXAuYbBQ1YFLmyVKGs7mCAKBy7jtdYF3WKG2pAUiEbYBvdstopAtQQ8Bp78pE8pzaNXWdCoPWEd9G/4xx/LCnBmp7WFgpgh254qMwNGOOazyvtqGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534840; c=relaxed/simple;
	bh=ZAzfIV8Do5h45Cn2fV0baLO6sfPPDzL3izxEkCBJXwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TF3kFs12ovHKlzeqruZCYUDvpfXv1VY2xr270e7LhtMtUhFH7DLMCTWkGNJKa3lTPt6O+Y137+L+aFW8L5FDaVL6TcxJ+zpIpI4YbJT9UUoOqi9QURgJ0DZ5G6EZghBzvR2xaADve6l1Z2z1yAYkdo05piFizgjIg2I3I7KpGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvRJcm+j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B27F1F00A3A;
	Mon, 15 Jun 2026 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534839;
	bh=c0wbcOHJEmaK1GzGQWa85vvuoTRXeJKX/aXuP79W538=;
	h=Subject:To:Cc:From:Date;
	b=VvRJcm+jg1vsxc55Rb9jHsWfpd85Gm+cHSFRXckjnMeVqt4Vaf5nZutJh1sy3lsKE
	 Lnbx/h8VtEIeTTyiOU7C5/ZgL1FZ65Z/woD71/Zz7GrvXMQH2ZerNn59UmC3gZUpMY
	 2PJCS2DIrssm35BRmr9D0vvQjK8QPhCNGod7lTqU=
Subject: FAILED: patch "[PATCH] ASoC: fsl_sai: Support multiple data channel enable bits" failed to apply to 6.1-stable tree
To: shengjiu.wang@nxp.com,broonie@kernel.org,nicoleotsuka@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:37:57 +0200
Message-ID: <2026061556-earwig-outward-aaaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shengjiu.wang@nxp.com,m:broonie@kernel.org,m:nicoleotsuka@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDF576875CC


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 770f58d7d2c58b8ff31d3694ce14a785c2e75009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061556-earwig-outward-aaaf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 770f58d7d2c58b8ff31d3694ce14a785c2e75009 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Tue, 1 Sep 2020 19:01:08 +0800
Subject: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits

One data channel is one data line. From imx7ulp, the SAI IP is
enhanced to support multiple data channels.

If there is only two channels input and slots is 2, then enable one
data channel is enough for data transfer. So enable the TCE/RCE and
transmit/receive mask register according to the input channels and
slots configuration.

Move the data channel enablement from startup() to hw_params().

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 62c5fdb678fc..38c7bcbb361d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -443,6 +443,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 slots = (channels == 1) ? 2 : channels;
 	u32 slot_width = word_width;
 	int adir = tx ? RX : TX;
+	u32 pins;
 	int ret;
 
 	if (sai->slots)
@@ -451,6 +452,8 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	if (sai->slot_width)
 		slot_width = sai->slot_width;
 
+	pins = DIV_ROUND_UP(channels, slots);
+
 	if (!sai->is_slave_mode) {
 		if (sai->bclk_ratio)
 			ret = fsl_sai_set_bclk(cpu_dai, tx,
@@ -501,13 +504,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR5_FBT_MASK, val_cr5);
 	}
 
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
+			   FSL_SAI_CR3_TRCE_MASK,
+			   FSL_SAI_CR3_TRCE((1 << pins) - 1));
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 			   FSL_SAI_CR5_FBT_MASK, val_cr5);
-	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
+	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
+		     ~0UL - ((1 << min(channels, slots)) - 1));
 
 	return 0;
 }
@@ -517,6 +524,10 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int ofs = sai->soc_data->reg_offset;
+
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
+			   FSL_SAI_CR3_TRCE_MASK, 0);
 
 	if (!sai->is_slave_mode &&
 			sai->mclk_streams & BIT(substream->stream)) {
@@ -651,14 +662,9 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int ofs = sai->soc_data->reg_offset;
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int ret;
 
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
-			   FSL_SAI_CR3_TRCE_MASK,
-			   FSL_SAI_CR3_TRCE);
-
 	/*
 	 * EDMA controller needs period size to be a multiple of
 	 * tx/rx maxburst
@@ -675,17 +681,6 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
-{
-	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int ofs = sai->soc_data->reg_offset;
-	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
-			   FSL_SAI_CR3_TRCE_MASK, 0);
-}
-
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
@@ -695,7 +690,6 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
 	.startup	= fsl_sai_startup,
-	.shutdown	= fsl_sai_shutdown,
 };
 
 static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 6aba7d28f5f3..5f630be74853 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -109,7 +109,7 @@
 #define FSL_SAI_CR2_DIV_MASK	0xff
 
 /* SAI Transmit and Receive Configuration 3 Register */
-#define FSL_SAI_CR3_TRCE	BIT(16)
+#define FSL_SAI_CR3_TRCE(x)     ((x) << 16)
 #define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
 #define FSL_SAI_CR3_WDFL(x)	(x)
 #define FSL_SAI_CR3_WDFL_MASK	0x1f


