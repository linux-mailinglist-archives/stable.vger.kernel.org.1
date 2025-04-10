Return-Path: <stable+bounces-132074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C604A83E82
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF10A000BC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F0214209;
	Thu, 10 Apr 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i6veY8PT"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AD211A15;
	Thu, 10 Apr 2025 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276616; cv=none; b=Ij2ns+OntR/e2ARHYhGM9mINddoS1AoP4FjoKcTnypZonOQauPF5PLb4/qGuZj7JQaCoZe3TO5vY9MPvUDFOAUsTvEnC+j0Qkv05oxFV0bd2peSpwKDfh0087OXKTK2oTrUEe96lx4zF+egnngb7p2hJEusVWDLRqMLKQ5XovZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276616; c=relaxed/simple;
	bh=Q0sDdEVcdEJLglwYH0aiKB1V9YcHBKpRD1ntJPPD0Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxoqrOdhasMtbfT3afXJN15a2J6glQpCon/D5eDwMhkwd37tMdxEsfEkMHqc+yjaMhN6Bzg/Bichnc2DcMm9uG2sQ4Qk9gIc+vzqvGM3kkCNjqIkyjejR8y0w/2ioQid70bb6/dlh4t/qwKEuLTC9BeuJ+OH4/UBAYIs0HqIv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i6veY8PT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B255443137;
	Thu, 10 Apr 2025 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744276611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RXfF9Y2cL7mQps/DxKXkwK8dk0p3899KyBTvvn4p4qo=;
	b=i6veY8PTN1LEUXtwSuGCybJctp3ofui6noGnAgCrwivJm7wnzEx4/nl/OWX21frLWAFICV
	UDmM25RlWSD8H7n4RQakUQ8m8hOIjrYTYvN9o1HnFW1BxrcSS4RxYaSzTtvh98fu88MnVq
	bSN9QUa+rQp7CauSazRquc+NGeYm3obSid6U5RfcS6Pcoc0OLuenkzr8eGPxypTb0vSg4h
	m7nQXa5daQvowErjxtL2HlRGzrk883ee/O4LvODlr+ZiAuUl0iSqP25v4DA/uYhjqrIdcu
	FC5qYX1WbyeDSbnnOUQ629Dgf4XIdN5J+APuvKaDFe3VCs+wm5U69rVh2QJoVw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on TRIGGER_START event
Date: Thu, 10 Apr 2025 11:16:43 +0200
Message-ID: <20250410091643.535627-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeetkeffjedvieffteeugeetueevteduieekvdevgfeugefhveetleduheekgffgnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehshhgvnhhgjhhiuhdrfigrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepighiuhgsohdrnfgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehfv
 ghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohhlvghothhsuhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgii
X-GND-Sasl: herve.codina@bootlin.com

On SNDRV_PCM_TRIGGER_START event, audio data pointers are not reset.

This leads to wrong data buffer usage when multiple TRIGGER_START are
received and ends to incorrect buffer usage between the user-space and
the driver. Indeed, the driver can read data that are not already set by
the user-space or the user-space and the driver are writing and reading
the same area.

Fix that resetting data pointers on each SNDRV_PCM_TRIGGER_START events.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index b2979290c973..5614a8b909ed 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -250,6 +250,9 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		bitmap_zero(prtd->chans_pending, 64);
+		prtd->buffer_ended = 0;
+		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
+
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			for (i = 0; i < prtd->channels; i++)
 				prtd->qmc_dai->chans[i].prtd_tx = prtd;
-- 
2.49.0


