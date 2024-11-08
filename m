Return-Path: <stable+bounces-91917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0269C1B3D
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D11F238B8
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110A1E9078;
	Fri,  8 Nov 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DiMckZJs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0F1E9074
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063028; cv=none; b=LMYYg8BQb5sosj7xeWwScUsXhG1r10URp2LiGNNfuZQKF3mkUIGrrS4cLFok7UHDD943RS9j/+nyPoUy3HSsjTnrqxzVKq3FVpVDjfPLcFnTjAI5j2Uzc2Tn0BfxYVAhfY+clGj0F1MPH5IxMKSNaXFx4phYacZDNgyPCIHQeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063028; c=relaxed/simple;
	bh=bWpWS6bGVe6tZgUu3YvQOkO2GLe4NObnCQ10WekbNFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTZdzwOrZR+iXTgHIUkk1LkhPYx461nTuhaPkFWL8Vhn1CEXZM7Tj0XnIg/Q21Du72123sqDCYwInw8dsjfH2KwG8+PHwo1M2a3uKSC5kczPYPwKP/9BxnRu1LURnsBxTZN8AFzOU1MuikjIoa2D/638Bq2BVu6sOKLokH32WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DiMckZJs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso301465466b.3
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 02:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731063024; x=1731667824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riCvVik/XH/zEeXyUG50vFcKVp4ajfewa26rpwBWd84=;
        b=DiMckZJs7ACfGM2ZQU9+Z8Yu8o/9tcakEEwKPCSRZpQLUw3jTwvzsvg7gS+DXKX0WB
         3YABT/yInAEKBtRMZWUBAi1Rl0zSr7W/JcVmGAvj4vA2/lmTerpWIDzVIyKiixPpjIyz
         f6L7hGl6Mi+KjN28WZKt1Vig3URF/s712+KhgxpRMch/1CGjO5Le9oNqzEacuRSrViT4
         eieC7Jk8avBRx0mS7w8ahdQNUmDeooWKceZOac18bL4BDdSDqAK1k+0iext/YymZlinh
         bk9Zlh0ELtYpQgGDvXU1+q4hVUIK7x0A33WoJtG6NQovnTDlVCHm7dBFdeP+udS0r5vz
         iFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731063024; x=1731667824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riCvVik/XH/zEeXyUG50vFcKVp4ajfewa26rpwBWd84=;
        b=r1/oWIw6KDILBO4CfG4etpNHwf0SIW8oy3uJa+14ruRgS/RgChLV4v3wutiCNmFs8q
         nlg2AVGG413Nq4rNHoPGXiLz0QYA8kIaRFZny15HkpR+LsxpFOlYvz2uIFm3W5pylV/V
         vNE70lLmw5yWL0KQ0RrHXduQsr0pcSuWHRvTTgSpAdM2z/47TZXxxl57T5NrLUiaOglN
         WTzMpyHIr5vr+jY4rI34pNA2yJXEhqfIFUGGYc0fo95hdmKVpMQNM4lz0qVd3gOsizJe
         x0VqYx01aNQX5NNUDXhXck+mAjABwmc2c1kY29sYJi9GMxQLzouu8gAtfrods53sVgQy
         qkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF2Ay7bF+wQ/5aFSHcbQikxzQOLn6lHWEVsaOMOBD0quQ1Z1odPi5SkESnku5fwlUiWNbv4fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQsKUcwreF54djSMoCPHCaFJSXho0XsDhxnAFtgza7OCiYDhq
	CaGalLpCVT85ghYWzgsMF9uQ16o91c0+1a48h2O7VDSjpRwMmUsO8MWoQ3MX0N8=
X-Google-Smtp-Source: AGHT+IGaJCroj2+zUZfminHTFhl+OKQZqp+8gJVCO0eimP29bQw5M/mW9bNfWu638LxY/7dOtdvIXg==
X-Received: by 2002:a17:906:ee8b:b0:a9a:1585:dd3b with SMTP id a640c23a62f3a-a9eeff0e35emr192664266b.21.1731063024276;
        Fri, 08 Nov 2024 02:50:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc574dsm220464866b.101.2024.11.08.02.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:50:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 06/25] ASoC: sh: rz-ssi: Terminate all the DMA transactions
Date: Fri,  8 Nov 2024 12:49:39 +0200
Message-Id: <20241108104958.2931943-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108104958.2931943-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108104958.2931943-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In case of full duplex the 1st closed stream doesn't benefit from the
dmaengine_terminate_async(). Call it after the companion stream is
closed.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 6efd017aaa7f..2d8721156099 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -415,8 +415,12 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
 	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi))
-		dmaengine_terminate_async(strm->dma_ch);
+	if (rz_ssi_is_dma_enabled(ssi)) {
+		if (ssi->playback.dma_ch)
+			dmaengine_terminate_async(ssi->playback.dma_ch);
+		if (ssi->capture.dma_ch)
+			dmaengine_terminate_async(ssi->capture.dma_ch);
+	}
 
 	rz_ssi_set_idle(ssi);
 
-- 
2.39.2


