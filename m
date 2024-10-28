Return-Path: <stable+bounces-89049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC359B2E21
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE341C23BB0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288C20401E;
	Mon, 28 Oct 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZoK+lID"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F31DB362;
	Mon, 28 Oct 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112819; cv=none; b=Vv0qk/2xMqMJboiOBz8kMS5h2ni02qRu+OxhrzBAVib9+ZVJEc38RbwpUSNKYgkdp/LtrX+6dEM3VFgkyDGdmAL3zRQPMBFpKS9dF+k69asvX0Msp1MdeLLphJsQlIKeQhkvivF7MQzqMl0oHa7JLW3ZZtpvE16AIOdnSV4RR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112819; c=relaxed/simple;
	bh=6WZXQ1MujIT4FRtqwHDvxkdeBFqBLQzEoNLj7/HKqes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTD5AuoeVlv7PBu3rxVexHPNiVyUHPVa1dnXVPsbzeL0KZnWbLF+KK792OepbXtPqxllI7L1o0SXg0+CAgivY228nZ2X3nCKk3galcsjGzZahWBpSro40oecqX4sq+R69i7kDFCcamcbgMwwZn1Xr6oqmWyCxmWk1DxJvsGBmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZoK+lID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA3C4CEC3;
	Mon, 28 Oct 2024 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112819;
	bh=6WZXQ1MujIT4FRtqwHDvxkdeBFqBLQzEoNLj7/HKqes=;
	h=From:To:Cc:Subject:Date:From;
	b=jZoK+lIDLFXPL2exrRQ+9KKXs+iIoQuaziH4qMOaqbzXi5e5X6Am6dQze7Sl4Zcf7
	 4UrTXyXw8CXB22etHDkOeXl6i5MZ3xtQW8W0sjzRL3XV3GLM6hda/nZci7gHkXupCL
	 EOjKmY8XJ2E9knwmt/iAakolDlo/ew8ql3WrTu0FlT9sYhvcYivsfV1YLg8e5zxarm
	 ch5WGpba15Xsc1iXklRFW4UZA0do7v2JkkX3n5oDswfHwqUw7sMRS0k+DdjqpaGgTZ
	 3BjPnqK/3Y6QBD1canGAzIQe3hLYq8NSgdy6ZpBvNLjcrRpjQJARliTbsXDdVFvnD8
	 aNLkR63ScwKfA==
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
Subject: [PATCH AUTOSEL 5.4 1/3] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:53:33 -0400
Message-ID: <20241028105336.3560730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 33ade79fa032e..4904f48de612d 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -98,10 +98,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
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


