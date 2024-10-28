Return-Path: <stable+bounces-89046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DD9B2E18
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF5C280F4B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E22036F2;
	Mon, 28 Oct 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEHycxlm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBE2036E3;
	Mon, 28 Oct 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112811; cv=none; b=P7+RDeQar3Y0esrGPPHx365U8eNuTftXw7ycgM6azSK2gBsJmSK6XYoDDvBtaJqG3OzNFmJ2RhuZDyDaFvaP6Cx50F2h+wI2XLuPKlXgYaKmq3xZ2zCOzTdjHJW4ong8aLSemSdur2BtF777Ctdujfh9k29MsPp0QPpu2TSuRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112811; c=relaxed/simple;
	bh=pquUi3GFsc2qWnsQ6j4Q1aC0V0bSxG/2pY7Vq/C+t2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrw9XWhQtfPrHikY4SRv+YVSl/cFVcyFUpm/d5WScanh76XOFLWGrszEa69ynUNHXNXA0yWjAfxMIuJ/213fifxGm13u11SHETuMb4ZW/Qsalb6/w9zayD9WorKel8To02V1svt7sp1eyny9s/sPrf0JreVWEkaM5iLoIMR7u3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEHycxlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D311C4CEE4;
	Mon, 28 Oct 2024 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112811;
	bh=pquUi3GFsc2qWnsQ6j4Q1aC0V0bSxG/2pY7Vq/C+t2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEHycxlm+i7MHY0rVAl+iEESXM2ovJf2vko+qZk12U8M5gWWXxaZ08yctIzkrlvIa
	 PB6siduA/9hgXInWSETU2XXjCZho/lIBLx6hbBPPx2O7lMXRORdARNOTfC1G/4yvMQ
	 jvJ7jQrl4q4vyfWO16KjcbdkrTjhw+ReEV5TPzhyhQ3PvnWxelibks6zvZY2vbYUc0
	 zbPZtlPx9YXLr17jwypxrTFFyxWBaziSCI/NoZluG8pLxTTydt7pMmpgDee8+rtDRH
	 yhVRBAMO49TTSHPX/bQybASShd/W2MF5dLepp2O2kKGSOC5N5kC1q5XYZGA+5BTSly
	 EDU/70zrJMUqQ==
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
Subject: [PATCH AUTOSEL 5.10 2/4] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:53:23 -0400
Message-ID: <20241028105327.3560637-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105327.3560637-1-sashal@kernel.org>
References: <20241028105327.3560637-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index 9f5f217a96077..cd215cec726be 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -124,10 +124,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
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


