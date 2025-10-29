Return-Path: <stable+bounces-191630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7CC1B340
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F491B21E1F
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEB283682;
	Wed, 29 Oct 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aLF0q0Oz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBE283142
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747115; cv=none; b=SC0ISvzzs/MGVuWNBJSI9wJwwaJHYaGB1wTF115uayvBTxdHBZ5o0KVtIxQkE2pwOmiWRwxDU2Ue/+GU3jtomZlL4oqzsGGAwwRyVp2HVG1lUC8XIbBWDEnyQW4wwKIRenNTvHQurWmQ0xYynhrT/uv72i3of8XwghksPWGFHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747115; c=relaxed/simple;
	bh=syzyZO/mJBKfFjprlnJbjqObQo3iQm+ErRfFxq3DXAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guPvz05M4n165YXl31B1871OpKs6Dadp8gpdsHjkGtVB4GvzSB1xCDAPeCHu1opwv9oMa+EXpFZf1aDEJpxVa0IhxjQBX/SB+OcNDkbSla/wiBi0QgUvibnzWySAGaZ5NFLWDriX1TIAX/T5AZkfkBhfw7OgB48Rrr5syNEmlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aLF0q0Oz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4298a028de6so705689f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761747112; x=1762351912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp6r0mmEiz+yEn07q0vDicoMrtrxWqGLSLuaBkcXGQs=;
        b=aLF0q0OzTId9NZLe36VsKpLHpZnT+JaFchqNfRd5UQeMwitv/AqoFAPIcCuYyEkplI
         eXyv/kAWNvzcjVD0JA/DVzbLAKp52WrUC/CmrXgPIMMPA2ElFZ0OvSKp3euqSOZy3kul
         xdHCGHtt+UyBxS/LJ82aWqmy0l0mE5B0/QTTeJxsD0cheCJV+3tuE3bd2/1r8qdzINk+
         OCuQH6OqRrMY8NoJcvY9QwEyIdFRxTXqOsBLNLtHQZkoTFoVEWkhhxlfAiCGzuiIHJNx
         2Pv5j6Gu3tpApdoWKor4/Fxd18DLWof6x5139r2gKQODR9ryHW/BnTGJALSSljyNneK+
         pL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747112; x=1762351912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp6r0mmEiz+yEn07q0vDicoMrtrxWqGLSLuaBkcXGQs=;
        b=EVw1t4wSOEPyEr0AI/mpJiJaLkBlFKn0LBKF8xXq3Wmt6l4w2xYEMCJvaOhSJIYlCK
         u5mcTfylevAEFsCm/HqxVx+7r3KoxlyUzGEAvaSV/dfalMHjoTJqG/4kgR2VFHjHIzjU
         k9r0GcLyQ6OdqPu1yAsVRETEDqKnQrKqWdC6Db2aMnB23zHvlsfKBf8pCzeEtjs1CcEs
         TXlN9WvTA/IvHNScSdpky/8I0Vi+M3kI8fhEXENgYxAj7NZ9ZH96HZ8F64SXrvkZmAJ0
         xswEf/lQ/jAZGqDjmavD6vqVzXhvOhZiwL4oWDmh4r4v63d3oaN6Fj7pMjdrobUlaOUN
         JcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZXoFlR5M7kWHQPC8sVC1NRgcVq2jlUDrqvgMP3O2Rsg++lGn8fyrPjIWEaYNrZGQkorkQw4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/n23lSiM40xD3E2SN1ZMPNzn7WTNl/M+izNBzpDCTWYCFf4u
	asYuSD8lRIoIBZznONS8wJ809uDQYpaeiGWkNNxEdCC79JKkM8+z3l87WadzFSG4Nfc=
X-Gm-Gg: ASbGnctlFRp4D2VoHPd8fzsPQXmkisCcGPCqd4xBosdY2SerKNLcw8zaPe2mxDkeNtk
	zRJFrOW6OqsdJdttAYmuU9+OuIn7h+uU3qnwqtadGHjDh4YTaYbXzyFmgoYBtaLjuUVK+iYW/d8
	8QOXCi8kSyCcOTBjrZ3xhbwO8G9qAwL9C0aja1mRDai/re1ZWe5sPml2gcHQvo72TJ2DOFH46iu
	y5bbIaOwvqTIOvpYdN7OOz4Vq37gfZj45wxCHtg65tQS9a2iXuH8uFB6Qb6+cV6sUKZ+4FcYARk
	9K8o/eOIME3OfYwO6pqvNfchgRFOA7S/Oi7CWsmD4slO9GdeKhguuUS9gsVEcdU9Pe9yohniMWa
	mmCZTfaIQgJhTHim+0cgQbmPPraisCBEk+4UfxCRb+lNSnfznw6thIDcG21/iHL79WWh7+Ki0Xq
	jpV6ZHQ2PvP6JadYjtJuspJHOWOFvWDkGL6mEA50CqcVT451yUX6Y315Otlk4l
X-Google-Smtp-Source: AGHT+IF0Hr0vldeCHlMvpdjLo7kANvDVUkMSknePlPVoEwlL5eF+LbbvELXIRDurzNHdmZ/2Jwl5Lw==
X-Received: by 2002:a05:6000:401e:b0:411:3c14:3ad9 with SMTP id ffacd0b85a97d-429aeb09960mr3002731f8f.21.1761747112092;
        Wed, 29 Oct 2025 07:11:52 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9c6sm27076286f8f.36.2025.10.29.07.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:11:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
Date: Wed, 29 Oct 2025 16:11:34 +0200
Message-ID: <20251029141134.2556926-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

When the driver supports DMA, it enqueues four DMA descriptors per
substream before the substream is started. New descriptors are enqueued in
the DMA completion callback, and each time a new descriptor is queued, the
dma_buffer_pos is incremented.

During suspend, the DMA transactions are terminated. There might be cases
where the four extra enqueued DMA descriptors are not completed and are
instead canceled on suspend. However, the cancel operation does not take
into account that the dma_buffer_pos was already incremented.

Previously, the suspend code reinitialized dma_buffer_pos to zero, but this
is not always correct.

To avoid losing any audio periods during suspend/resume and to prevent
clip sound, save the completed DMA buffer position in the DMA callback and
reinitialize dma_buffer_pos on resume.

Cc: stable@vger.kernel.org
Fixes: 1fc778f7c833a ("ASoC: renesas: rz-ssi: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index e00940814157..81b883e8ac92 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -85,6 +85,7 @@ struct rz_ssi_stream {
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
+	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
@@ -215,6 +216,7 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 	rz_ssi_set_substream(strm, substream);
 	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
+	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
 
@@ -437,6 +439,10 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter = current_period;
 	}
+
+	strm->completed_dma_buf_pos += runtime->period_size;
+	if (strm->completed_dma_buf_pos >= runtime->buffer_size)
+		strm->completed_dma_buf_pos = 0;
 }
 
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
@@ -778,10 +784,14 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	return -ENODEV;
 }
 
-static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
+static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
+	struct snd_pcm_substream *substream = strm->substream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
+	strm->dma_buffer_pos = strm->completed_dma_buf_pos + runtime->period_size;
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture))
 		return 0;
@@ -794,16 +804,6 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
 				ssi->hw_params_cache.channels);
 }
 
-static void rz_ssi_streams_suspend(struct rz_ssi_priv *ssi)
-{
-	if (rz_ssi_is_stream_running(&ssi->playback) ||
-	    rz_ssi_is_stream_running(&ssi->capture))
-		return;
-
-	ssi->playback.dma_buffer_pos = 0;
-	ssi->capture.dma_buffer_pos = 0;
-}
-
 static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
@@ -813,7 +813,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = rz_ssi_trigger_resume(ssi);
+		ret = rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
 
@@ -852,7 +852,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		rz_ssi_stop(ssi, strm);
-		rz_ssi_streams_suspend(ssi);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.43.0


