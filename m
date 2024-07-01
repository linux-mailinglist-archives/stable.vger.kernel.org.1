Return-Path: <stable+bounces-56210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9191DDF9
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 13:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E54C1F20F55
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0814B943;
	Mon,  1 Jul 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fY5JNPPN"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84C14A086;
	Mon,  1 Jul 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833521; cv=none; b=jzS3isBIy34WH3UY0xOixyrJweu5YdF0WK6K98u2QfcE0i37V4XpM2oQdHW9HBJ/UxKPbfgLPZTQtD/rHIXAcHd/tVuDa4LmXcR9K70Ab50FhemIcL8fpi61sp660Bed9N8sPKyOS2Or611EwwiaVaSp6nVIlOXkhEnv1Wlqr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833521; c=relaxed/simple;
	bh=JyxXab3gh+wCGMjIW6vDCbjLfD//HftTPx3aJXGP3m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkyVSaMxwF6Yed7oBasfRElin+FhEiDzH0qB4fRZFRnvnccxbBzqBkVvNKRCHWxKFPzX1NjKyjo3Djk3/YiqvkhouKlPR2S9G7WeRgV4ZX0le7VCW3FS4fXhN2wDu203y6nPWK68jN5McGUBx9aFYegs1GhV7X8xanm335379pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fY5JNPPN; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5EB47240002;
	Mon,  1 Jul 2024 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719833511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2OniZ6NTuy93VyAe8/Sk6MsW0dFYWJCYUEKa4O7/i0=;
	b=fY5JNPPNTUPd+3WwdpltqYwI63mL9XXxlIkXhbS6hKe5rdPZ4lvBOQfo5N0juytrcdShcz
	MmlHt9VD3Xu6TUoWvSWvKIMPGLqmySiXL6B/mRONseF5N76usRmMgMq8+2+PrH1sU2w3S8
	0gh+G3GYDDEnDNJ6AZ+3xsfj5zl5VEIhgmsX2ykfDBZTLsfkVq8fqSWHvbYaguK1hhfpGl
	1BaL2FMf4IVKA9yB+WQGAGqUR64suAfhLN2M3peUznZjgN6NtROnfFLuFEPF61HfZ28Uj4
	xj40osEIqZmE25n5f5YKzg9JLX9Io/Myd1eOjD1HLLLvMdWMvDZhSoqNN4mmDQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/10] ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
Date: Mon,  1 Jul 2024 13:30:28 +0200
Message-ID: <20240701113038.55144-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701113038.55144-1-herve.codina@bootlin.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked.

Fix this lack and check the returned value.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index bfaaa451735b..dd90ef16fa97 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -604,6 +604,8 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 
 	qmc_dai->name = devm_kasprintf(qmc_audio->dev, GFP_KERNEL, "%s.%d",
 				       np->parent->name, qmc_dai->id);
+	if (!qmc_dai->name)
+		return -ENOMEM;
 
 	qmc_dai->qmc_chan = devm_qmc_chan_get_byphandle(qmc_audio->dev, np,
 							"fsl,qmc-chan");
-- 
2.45.0


