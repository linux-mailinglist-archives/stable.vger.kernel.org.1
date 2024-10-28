Return-Path: <stable+bounces-89052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CE9B2E29
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B09280A87
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB8320492E;
	Mon, 28 Oct 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUcmGRnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7F204086;
	Mon, 28 Oct 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112826; cv=none; b=cr4irIHebzHWHFbZXbVuFHx3wCeKQzUob+qDccKkD5M0RlGZy+bac6McJz4cH6DNukXRCs0xo1vTEdi2KrdjxfOutvnzp2UPPPFGe5pEDQqFIhpr+p6b1mPYMSUv7xsfQVT7ZxdRQfxyYZOHS5t9lz3sf8xK6sw54GlnY0Si1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112826; c=relaxed/simple;
	bh=v/yJgJ9CHq0ckMx8H6tzHK9iCJJWIhgHvJBlKLxKKok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4LwlZW8U2uBOJKb7IgckvP5FmWmAqax84nOpB5YuAjzIRGLimqfHu1bUSqZY0uwsxUPrLZZp+7INRFxC/GBBtA3fLZU5rAlE1ux1PkvVZ6wXJoiCcyKClh7T4ovDWwLAKUiPq0+TScayRqa2WqDQLrCnR6K0sWkLPstlCijw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUcmGRnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E66EC4CEC3;
	Mon, 28 Oct 2024 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112826;
	bh=v/yJgJ9CHq0ckMx8H6tzHK9iCJJWIhgHvJBlKLxKKok=;
	h=From:To:Cc:Subject:Date:From;
	b=pUcmGRnbpVI72Y9Mse8nsidUiBEdXY5TnHrmssxXPzPxFgTW/xx8q90MvM4PWUoMX
	 JWTOrJFWnRqfnKgAOkYiQGcD+6evDBJ4vfJsH9w6fMfQLdZWp9JbkxNjCUYu3nLmQE
	 OGNjghb7osyy6rxNTkCr4Ne05lIje13O5idSVlSGytmXN5mLcv0Q7+kUsytZ8ZIVMZ
	 QoikDFmsngjp4UZrlWNEaAqFhVGfwGQKKcjvRAiblcmeQXk02DIzy4BoE1s3MUVbxS
	 0h3QcZrIO+WAKmmLuccq4owpsUJUfVOyNL0F9BwC8y42rKrtViLdZZKNWeyGhz0rnD
	 UDyVG57e7ux1g==
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
Subject: [PATCH AUTOSEL 4.19 1/3] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:53:41 -0400
Message-ID: <20241028105343.3560809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index baa76337c33f3..e3c324467a9b4 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -77,10 +77,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
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


