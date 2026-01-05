Return-Path: <stable+bounces-204839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FFCF493B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5BFE3009133
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E740314A60;
	Mon,  5 Jan 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eez2Xcqx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407130EF7E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627196; cv=none; b=QuW3ahqFPxuNY66KneZRnppov6NX/e6V4OzSVQIj13F2m4PXDNq/pYpKaKf5mZtPmkYWh0lqyZiKjUFIlPgQ2/2spn5fgF4YAo3yreqT3XNpQ6JdS/64uDog8XFz7G2SCWMQEeNvN1kEFTcW2T6viWauXf56Es2rd9bFdO/NlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627196; c=relaxed/simple;
	bh=moZyJtisyATthSCbZqwm2UGhsTVhGXtFq3OMJPRVnvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL9oipx0MPEVi3leTHYlAhIA95TsbNu5TTG2pq4mL5sUa486uJQLyftwVxa0aHmDnWzjaXYfOj51x8cirZvcRLInlan5Q74WiPSyv5QaTjGjoQ1cFtDH1+9sb73dQGTFg6R5J3ahPonmsWQROa3yKPzFc7pNrZKGzPER4tKg24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eez2Xcqx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so845119a12.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767627190; x=1768231990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nyTYjqM4L5f+3KbddnkLD/eRy3G1Yb3ej525lsqQIU=;
        b=eez2Xcqx7uAy0sLIIIuV9ngJSM2bB/JU0oE0eCfq+3fa9obk4TYC4RztG/4Xeu+Sqv
         zXkJ6djDp4CfeMwO2kQJPJ/3aYzlVIZEwQRwSLlzPy1bazyCjZzoBbQwX+gAwovc7w2L
         /ZdHdPLPOZBp9uSZzxyQKRwxb6Q8j5SnymglFdyYQnBWI49/D5lrYtgyMx+dkzSTKSbo
         7LzYd60GmYTzIHafUdOHiWFuFoFt7SYK+Kh3m2zbY+MPrebq9jNKfg9psKlQe1vzJuXR
         1a1D4hhZ73IqO+jyabtuZeo6Zgs2yxE2fJHi1/cVlUpBYjOtiLP7E3G4Aa3WAeL/lzxa
         JniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767627190; x=1768231990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nyTYjqM4L5f+3KbddnkLD/eRy3G1Yb3ej525lsqQIU=;
        b=pmXgoe++Kf1va2k1eig7bwdV63v9YA7p/7/tiLQeviHC6GPwGqo2xldhQ6h3Tr403D
         IPpFPzOVfO1EavavY9wu+dX6ltoABAWvTGUYxMb5Ke4zINY+n0TmDxYXKZ+rzhIWbjcl
         Bi6sQJ5q+KDu4lOpTNI9n8D/AfP9Qi6H1Pg8cF/4n+Ur9tAmoPe1TmyyNqqcvfQPNque
         jaBwewzQpz/U/jkm2ZPn52GklEJvFLbA+cRccHgdSP5D1PXRy2rAuceHs4WVI4GSR26o
         umnPM0RXMspfDbPYWuCfxZiDqZeRjAFSMTxkqd9Cz1WQyd9s1Eone/mz3gStCcrDR05t
         ifDQ==
X-Gm-Message-State: AOJu0YxYM2oMufh1Q2XrTNQ9yUDkYtQAFBwBByK+U5ADN1bQmP/RZn//
	WH3jZUWVnuJu7cJoP+39w2d26FE7GjKH4+40F/LUDuWRtbD7+sJRwC9gGsab7g==
X-Gm-Gg: AY/fxX4K2KlXjLolJgLlV4c5cNgnYW2pTI6aRoAkT7EIRJLkeKEHdZbAX0wEPYnVLHy
	Gb1wys9vhjJdRWu2noRMC5jDW0h/QiHaHdacXFl1ayD3FH/Cre29Rd0UHrlBa6HtcKmOm3B2hun
	84VOQyECXNbL5fHVL4hmJkOdh69CmaUztDq+9Tsyb6d2hzccphSEn94HlfvnB6dEgAT6GZwJQa7
	lJGZBW2dVmy9qE8zmXihNYANjNso4bN6piMkr0Z5GgpoZZlkHqqYhWpMSSceiYbsLN03vmuprxT
	cugNGpPKLAQig1Wx1Op8D1qZP3EwO63uCNIQIUyUwuGpw3HTE9y6hMyEhf2D1Qv6bG0eJQcAZv0
	FX/fhQ6UKjJs+ZA9n8G/Kbl049PJoRPb1TAJW3T8JSRREbBEbPlSqw6XPE8rOZsCgKsiWNAO1uS
	2ILEHang0fTg0i+twWnAgAUejLkkPyoXI=
X-Google-Smtp-Source: AGHT+IG9eIYHJHxS9p7fSGTKzDNQ99BZzExWforDggxMTrMuCe4bMLgcUU4LmFY7A92yc6SAqNynLg==
X-Received: by 2002:a05:6402:5206:b0:64d:34a3:4df7 with SMTP id 4fb4d7f45d1cf-64d34a35198mr41823362a12.19.1767627189715;
        Mon, 05 Jan 2026 07:33:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f05:51:bdf:3930])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65075a26079sm90809a12.1.2026.01.05.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:33:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	stable@kernel.org,
	Tony Tang <tony.tang.ks@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12.y] ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
Date: Mon,  5 Jan 2026 15:33:04 +0000
Message-ID: <20260105153304.252300-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026010507-corned-slain-8ffe@gregkh>
References: <2026010507-corned-slain-8ffe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 52a525011cb8e293799a085436f026f2958403f9 ]

The full duplex audio starts with half duplex mode and then switch to
full duplex mode (another FIFO reset) when both playback/capture
streams available leading to random audio left/right channel swap
issue. Fix this channel swap issue by detecting the full duplex
condition by populating struct dup variable in startup() callback
and synchronize starting both the play and capture at the same time
in rz_ssi_start().

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114073709.4376-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rz-ssi.c | 51 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 4f483bfa584f..0076aa729fad 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -132,6 +132,12 @@ struct rz_ssi_priv {
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
 	bool dma_rt;
 
+	struct {
+		bool tx_active;
+		bool rx_active;
+		bool one_stream_triggered;
+	} dup;
+
 	/* Full duplex communication support */
 	struct {
 		unsigned int rate;
@@ -352,13 +358,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
-	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
-		rz_ssi_is_stream_running(&ssi->capture);
+	is_full_duplex = ssi->dup.tx_active && ssi->dup.rx_active;
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
 	if (!is_full_duplex) {
 		ssifcr &= ~0xF;
-	} else {
+	} else if (ssi->dup.one_stream_triggered) {
 		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 		rz_ssi_set_idle(ssi);
 		ssifcr &= ~SSIFCR_FIFO_RST;
@@ -394,12 +399,16 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			      SSISR_RUIRQ), 0);
 
 	strm->running = 1;
-	if (is_full_duplex)
-		ssicr |= SSICR_TEN | SSICR_REN;
-	else
+	if (!is_full_duplex) {
 		ssicr |= is_play ? SSICR_TEN : SSICR_REN;
-
-	rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+	} else if (ssi->dup.one_stream_triggered) {
+		ssicr |= SSICR_TEN | SSICR_REN;
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		ssi->dup.one_stream_triggered = false;
+	} else {
+		ssi->dup.one_stream_triggered = true;
+	}
 
 	return 0;
 }
@@ -897,6 +906,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int rz_ssi_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = true;
+	else
+		ssi->dup.rx_active = true;
+
+	return 0;
+}
+
+static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = false;
+	else
+		ssi->dup.rx_active = false;
+}
+
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
 				      unsigned int channels,
 				      unsigned int sample_width,
@@ -962,6 +995,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.startup	= rz_ssi_startup,
+	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
 	.set_fmt	= rz_ssi_dai_set_fmt,
 	.hw_params	= rz_ssi_dai_hw_params,
-- 
2.43.0


