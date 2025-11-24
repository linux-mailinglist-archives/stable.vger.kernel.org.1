Return-Path: <stable+bounces-196674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FAC7FFCA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFADD3A5108
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45E2F9C39;
	Mon, 24 Nov 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL4lxR/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E72741C0;
	Mon, 24 Nov 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981368; cv=none; b=HRTHLYwFIYJRST9LuCgU3J2Aubd3TLmMt4DUPYl8pbvacRPoWf5Z2tTALX6tFtI0bVH5SS/TuuE0tC25CPHkr9BG0+LqJhMugLsacflNY6xPJFndksO2uC91Cm1SsFSi+yi2y29+TNvdex5kPFwOROjrQKuf0aCChaju7ajtSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981368; c=relaxed/simple;
	bh=sAu9FWZfPAnQbhOVMjfAidsueJ0bqzfBo/Ls2FozWdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAm461j/9/+BlfLvbAmpp34ZYibazzLsheYXK0eRk9O0nb0NtD99SqIdPgRhOu5VBbP1FtEkkxVh0vHSyQHQwduG8a0Qeu/44+bGR/QAXmBj8UL5ccY4RGAHwpQX5QdfmTbLvMybfTe60cW+smLssLzHxrvBL3+i1dusmK/K68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL4lxR/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C8EC19421;
	Mon, 24 Nov 2025 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763981367;
	bh=sAu9FWZfPAnQbhOVMjfAidsueJ0bqzfBo/Ls2FozWdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LL4lxR/ViMDKm7bk5ZufX43qB1/uJsm+XG8Ow1lJVgL/rPr7DsavOUxf21Olcsmu3
	 7DuxnyG833LbYzPMo02f7XAfBa0jI1qJ/gDqEFqwI7sRft65CnojdLqtRacxFZRaSb
	 kllBb6+oCJq41cAEyeslmxwXki0kW6O5S6OkhmyH1o6usWCYptasGv0voZYnGFPdY3
	 pM27UitPowGIcIYRh5plcq0b+KRdLb90qzv9capWrbPnYe/vs6qOPSUMqwep0IYfRN
	 VBMUz0H0q4HMn2WcYjQniQpQmXP5tHJxDGvwFqPeKq6c3UGXU0oTyQEaHuFIBckIcY
	 o63+OriqdIcYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNU8N-0000000046f-15JZ;
	Mon, 24 Nov 2025 11:49:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	olivier moysan <olivier.moysan@st.com>,
	Wen Yang <yellowriver2010@hotmail.com>
Subject: [PATCH 1/4] ASoC: stm32: sai: fix device leak on probe
Date: Mon, 24 Nov 2025 11:49:05 +0100
Message-ID: <20251124104908.15754-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251124104908.15754-1-johan@kernel.org>
References: <20251124104908.15754-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the sync provider
device and its driver data during DAI probe on probe failures and on
unbind.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
Fixes: 1c3816a19487 ("ASoC: stm32: sai: add missing put_device()")
Cc: stable@vger.kernel.org	# 4.16: 1c3816a19487
Cc: olivier moysan <olivier.moysan@st.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index fa821e3fb427..7065aeb0e524 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -143,6 +143,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	}
 
 	sai_provider = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
@@ -159,7 +160,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
 
 error:
-	put_device(&pdev->dev);
 	of_node_put(np_provider);
 	return ret;
 }
-- 
2.51.2


