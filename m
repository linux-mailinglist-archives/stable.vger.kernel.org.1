Return-Path: <stable+bounces-54693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8A90FF1F
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DCF1C20F99
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614E19FA99;
	Thu, 20 Jun 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y7/+Kz/c"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639BA3A1AC;
	Thu, 20 Jun 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873000; cv=none; b=jb9I+wFUlhNbImVhWMCEuVNESTPcOMILaRVNu8ef3zTM77ZVSozH+PLLm5vC4QuneaymIb3PTptwQc2ScXEtGnPxv/ozmF5oNAoo/11jbQhZyJJFx+5W14zuSWDb8sQtRSOXKMi0pTjHDpUzLY6Vwy2toP83kKYEgofTXaxn5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873000; c=relaxed/simple;
	bh=JyxXab3gh+wCGMjIW6vDCbjLfD//HftTPx3aJXGP3m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDdmlY2bNqncXVhZaNHAalBtx9LKikJNo06YaIGjqur0EX8kViZHABNK7r1591wjoBJ3hV+dTZfm2nqyMTLrEZdIcBlEQEHTHQJeEp1Xz+fcF+ItYE1Jl0/Qa86/ay1xb5F0IM14au6afl7usTL2KS8Qh8WevOGTaYboCiBajag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y7/+Kz/c; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 808192000D;
	Thu, 20 Jun 2024 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2OniZ6NTuy93VyAe8/Sk6MsW0dFYWJCYUEKa4O7/i0=;
	b=Y7/+Kz/c2jd/6tPcvE4E6ugSwG+0jYbXBS0aNFaULtDeHyZliwze4pTKKBYpKGOFnk4PGV
	V+eXJJgSOFwRhBinungwT/q9hAcrnHhSX3Wd3XjRnb/lEJX0MkYC2BeyAMahoDqNzoK4ZF
	/GjZ74Lw/mJ0XF5OrPMkaaort1alUt01luU3ORpix/o6+6fwJ1UEw8AtFm7KHawEhQUoBY
	9z2gXIW11ZJIRDy+aWdga+Jazrjwm+9BFM1/CTKr8U+OQkIP/1+63VOZQ/F2VlkQ17wfog
	CyeVK92Ty+SSqwldY65xQ0qcGjYBHYWT+II2yqH7dmbT7iIIW3zKknFlcGMf3w==
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
Subject: [PATCH 01/10] ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
Date: Thu, 20 Jun 2024 10:42:48 +0200
Message-ID: <20240620084300.397853-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
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


