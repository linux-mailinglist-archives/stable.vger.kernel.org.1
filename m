Return-Path: <stable+bounces-89039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9C9B2E04
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552311C2290C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CDD20110B;
	Mon, 28 Oct 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt6yO9F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCA2010F2;
	Mon, 28 Oct 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112796; cv=none; b=dQR3eZeM4mqo+mWrQnEiBwMjt1lv2WG8payq00OqrdI066gEKIYLCD/FV153SDIgdsK/cDzdPd3ZcOThwdd+4C7n73HQNKL7MVd4yHjP2PaaRtOGLq0s+bfVAO/0WyOyhGtYofeH0N3y8wnotPATge69WOvFp3RNbX9/hsqhpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112796; c=relaxed/simple;
	bh=j3zZ92dY82Nr/+aVlMhvLc9sqirmrpWoRsvNNmGHFR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+KPzSL7hnd6MKUaf82J0xp2C+Pk/mwrw2/XO4rj8nNoZ2YjDgJZqK4AQbRPtMy4kZ4qzDNeOLSHharzJ2LmDn+3N7YgMhxm6Tir59jCE/ft7XSy6GoBnjQaGFJByH/CEP8m268xOwvOPY33y1WOXjtwuuNXW1+vCcC/oXItdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt6yO9F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B7AC4CEC3;
	Mon, 28 Oct 2024 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112795;
	bh=j3zZ92dY82Nr/+aVlMhvLc9sqirmrpWoRsvNNmGHFR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rt6yO9F7+K0HQuoyn9WKX7Bknz1rtiZUROVGA7OK6gyus8waslVn1aV8f91K6VaFQ
	 68oGazvDjfeQcOQSN8mSWGiTdwn7cWhYYPz5YBZdyFSjJyxjOBzWa4om9+0gmuFysw
	 7XDpI715libQtffaCUwYLUzkeXDog3qXpTsPuUk2BDos/r9SystUQxbeoeEwahjEdJ
	 opEf75QOkEFOB+hIUTCuhyH6O6QVKj7rwV5vLX8VYcQtEvjWmmO43oYrAHrDj+884T
	 yl2U/swoW6L+o4YBTOtEAOhggqNqub8FRG6tUmEve8thUz5fdnSO9MA9BF1Pg7Yf1h
	 Ixig9JmHMwgpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 2/7] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:53:04 -0400
Message-ID: <20241028105311.3560419-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105311.3560419-1-sashal@kernel.org>
References: <20241028105311.3560419-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 54c805c1eb264c839fa3027d0073bb7f323b0722 ]

Irq handler need to be executed as fast as possible, so
the log in irq handler is better to use dev_dbg which needs
to be enabled when debugging.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://patch.msgid.link/1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 763f5f0592af1..2c2e1a5489225 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -119,10 +119,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
 
 	if (esr & ESAI_ESR_RFF_MASK)
-		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
+		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
 
 	if (esr & ESAI_ESR_TFE_MASK)
-		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
+		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
 
 	if (esr & ESAI_ESR_TLS_MASK)
 		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");
-- 
2.43.0


