Return-Path: <stable+bounces-26302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F142870DF7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A0C1F21082
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD39200D4;
	Mon,  4 Mar 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3P3w3LR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5B8F58;
	Mon,  4 Mar 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588369; cv=none; b=aAy1YB4+Ru9Kj/PFaczCHOHa5FGqgm3JlobSNwG6b6g/1Zd8IjRjnH7DX2IYFc2zmyjaaox34FmneSPwjW6v39r46anFloW0VsuQDQOhPbVu2H9V/vdazHx35vSt6l2EP9fFWpl4cs1/m1MpKydU+rK+qwLcC3JGo2TiD223A8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588369; c=relaxed/simple;
	bh=ov//4nn9LVKjc8M5Loex2QhDVVm4/D3QgCZYYNuEoCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSdglYtj0Voa8xN3KeYUYjh+Yy+TFkzs5tkfc7X1iEFBPAfWctLYVTlMwfpP/Wb8knNhJnEWASaNEszEQVqEZh0ldETv6zcAPFYRQiwQwzFWIX0TVToryxeYo19w4uKiofCZtJCEDbJCMnPa+k48sT9NMPGV8bGjZbuvTg+jsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3P3w3LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F98C433C7;
	Mon,  4 Mar 2024 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588368;
	bh=ov//4nn9LVKjc8M5Loex2QhDVVm4/D3QgCZYYNuEoCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3P3w3LRAPMncmn2WUXvKtnlJlFCOwLsbKXimdNo5YRwFomn3e/fCVwhLuTXl1edZ
	 Pps+Z93oHHMNuow+sTUBfBc9AXcEH/VJux0m9As0zkvld5WWp2J8AnBSCXhJb4LwxC
	 qH21UuC/bSEsBqI8Axxg2JrHrRyu1PnJ4kwgxrYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/143] ASoC: soc.h: convert asoc_xxx() to snd_soc_xxx()
Date: Mon,  4 Mar 2024 21:22:46 +0000
Message-ID: <20240304211551.401468525@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 1d5a2b5dd0a8d2b2b535b5266699429dbd48e62f ]

ASoC is using 2 type of prefix (asoc_xxx() vs snd_soc_xxx()), but there
is no particular reason about that [1].
To reduce confusing, standarding these to snd_soc_xxx() is sensible.

This patch adds asoc_xxx() macro to keep compatible for a while.
It will be removed if all drivers were switched to new style.

Link: https://lore.kernel.org/r/87h6td3hus.wl-kuninori.morimoto.gx@renesas.com [1]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87fs3ks26i.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1382d8b55129 ("ASoC: qcom: Fix uninitialized pointer dmactl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-card.h |  4 ++--
 include/sound/soc.h      | 42 ++++++++++++++++++++++++++--------------
 sound/soc/soc-utils.c    |  4 ++--
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index e8ff2e089cd00..ecc02e955279f 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -115,8 +115,8 @@ struct snd_soc_dai *snd_soc_card_get_codec_dai(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *rtd;
 
 	for_each_card_rtds(card, rtd) {
-		if (!strcmp(asoc_rtd_to_codec(rtd, 0)->name, dai_name))
-			return asoc_rtd_to_codec(rtd, 0);
+		if (!strcmp(snd_soc_rtd_to_codec(rtd, 0)->name, dai_name))
+			return snd_soc_rtd_to_codec(rtd, 0);
 	}
 
 	return NULL;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 49ec688eed606..c1acc46529b9d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -774,37 +774,42 @@ struct snd_soc_dai_link {
 #endif
 };
 
+/* REMOVE ME */
+#define asoc_link_to_cpu	snd_soc_link_to_cpu
+#define asoc_link_to_codec	snd_soc_link_to_codec
+#define asoc_link_to_platform	snd_soc_link_to_platform
+
 static inline struct snd_soc_dai_link_component*
-asoc_link_to_cpu(struct snd_soc_dai_link *link, int n) {
+snd_soc_link_to_cpu(struct snd_soc_dai_link *link, int n) {
 	return &(link)->cpus[n];
 }
 
 static inline struct snd_soc_dai_link_component*
-asoc_link_to_codec(struct snd_soc_dai_link *link, int n) {
+snd_soc_link_to_codec(struct snd_soc_dai_link *link, int n) {
 	return &(link)->codecs[n];
 }
 
 static inline struct snd_soc_dai_link_component*
-asoc_link_to_platform(struct snd_soc_dai_link *link, int n) {
+snd_soc_link_to_platform(struct snd_soc_dai_link *link, int n) {
 	return &(link)->platforms[n];
 }
 
 #define for_each_link_codecs(link, i, codec)				\
 	for ((i) = 0;							\
 	     ((i) < link->num_codecs) &&				\
-		     ((codec) = asoc_link_to_codec(link, i));		\
+		     ((codec) = snd_soc_link_to_codec(link, i));		\
 	     (i)++)
 
 #define for_each_link_platforms(link, i, platform)			\
 	for ((i) = 0;							\
 	     ((i) < link->num_platforms) &&				\
-		     ((platform) = asoc_link_to_platform(link, i));	\
+		     ((platform) = snd_soc_link_to_platform(link, i));	\
 	     (i)++)
 
 #define for_each_link_cpus(link, i, cpu)				\
 	for ((i) = 0;							\
 	     ((i) < link->num_cpus) &&					\
-		     ((cpu) = asoc_link_to_cpu(link, i));		\
+		     ((cpu) = snd_soc_link_to_cpu(link, i));		\
 	     (i)++)
 
 /*
@@ -894,8 +899,11 @@ asoc_link_to_platform(struct snd_soc_dai_link *link, int n) {
 #define COMP_CODEC_CONF(_name)		{ .name = _name }
 #define COMP_DUMMY()			{ .name = "snd-soc-dummy", .dai_name = "snd-soc-dummy-dai", }
 
+/* REMOVE ME */
+#define asoc_dummy_dlc		snd_soc_dummy_dlc
+
 extern struct snd_soc_dai_link_component null_dailink_component[0];
-extern struct snd_soc_dai_link_component asoc_dummy_dlc;
+extern struct snd_soc_dai_link_component snd_soc_dummy_dlc;
 
 
 struct snd_soc_codec_conf {
@@ -1113,8 +1121,8 @@ struct snd_soc_pcm_runtime {
 	 * dais = cpu_dai + codec_dai
 	 * see
 	 *	soc_new_pcm_runtime()
-	 *	asoc_rtd_to_cpu()
-	 *	asoc_rtd_to_codec()
+	 *	snd_soc_rtd_to_cpu()
+	 *	snd_soc_rtd_to_codec()
 	 */
 	struct snd_soc_dai **dais;
 
@@ -1142,10 +1150,16 @@ struct snd_soc_pcm_runtime {
 	int num_components;
 	struct snd_soc_component *components[]; /* CPU/Codec/Platform */
 };
+
+/* REMOVE ME */
+#define asoc_rtd_to_cpu		snd_soc_rtd_to_cpu
+#define asoc_rtd_to_codec	snd_soc_rtd_to_codec
+#define asoc_substream_to_rtd	snd_soc_substream_to_rtd
+
 /* see soc_new_pcm_runtime()  */
-#define asoc_rtd_to_cpu(rtd, n)   (rtd)->dais[n]
-#define asoc_rtd_to_codec(rtd, n) (rtd)->dais[n + (rtd)->dai_link->num_cpus]
-#define asoc_substream_to_rtd(substream) \
+#define snd_soc_rtd_to_cpu(rtd, n)   (rtd)->dais[n]
+#define snd_soc_rtd_to_codec(rtd, n) (rtd)->dais[n + (rtd)->dai_link->num_cpus]
+#define snd_soc_substream_to_rtd(substream) \
 	(struct snd_soc_pcm_runtime *)snd_pcm_substream_chip(substream)
 
 #define for_each_rtd_components(rtd, i, component)			\
@@ -1154,11 +1168,11 @@ struct snd_soc_pcm_runtime {
 	     (i)++)
 #define for_each_rtd_cpu_dais(rtd, i, dai)				\
 	for ((i) = 0;							\
-	     ((i) < rtd->dai_link->num_cpus) && ((dai) = asoc_rtd_to_cpu(rtd, i)); \
+	     ((i) < rtd->dai_link->num_cpus) && ((dai) = snd_soc_rtd_to_cpu(rtd, i)); \
 	     (i)++)
 #define for_each_rtd_codec_dais(rtd, i, dai)				\
 	for ((i) = 0;							\
-	     ((i) < rtd->dai_link->num_codecs) && ((dai) = asoc_rtd_to_codec(rtd, i)); \
+	     ((i) < rtd->dai_link->num_codecs) && ((dai) = snd_soc_rtd_to_codec(rtd, i)); \
 	     (i)++)
 #define for_each_rtd_dais(rtd, i, dai)					\
 	for ((i) = 0;							\
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 9c746e4edef71..941ba0639a4e6 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -225,12 +225,12 @@ int snd_soc_component_is_dummy(struct snd_soc_component *component)
 		(component->driver == &dummy_codec));
 }
 
-struct snd_soc_dai_link_component asoc_dummy_dlc = {
+struct snd_soc_dai_link_component snd_soc_dummy_dlc = {
 	.of_node	= NULL,
 	.dai_name	= "snd-soc-dummy-dai",
 	.name		= "snd-soc-dummy",
 };
-EXPORT_SYMBOL_GPL(asoc_dummy_dlc);
+EXPORT_SYMBOL_GPL(snd_soc_dummy_dlc);
 
 static int snd_soc_dummy_probe(struct platform_device *pdev)
 {
-- 
2.43.0




