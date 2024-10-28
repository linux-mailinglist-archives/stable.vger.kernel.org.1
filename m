Return-Path: <stable+bounces-89017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F039B2DC1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DBF1F21B76
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C511DFDAA;
	Mon, 28 Oct 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQroCa56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6351DFD9C;
	Mon, 28 Oct 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112745; cv=none; b=EM5JH5pl/5N1SveGcUEbqPiHiiSQiTxo2zQOazdaPDXZ1ljnRkFawNkm4RBofnSNCKGzvEGUWCm7lFdMiR9sn3G3omDls9SfxCJKvRI/y5Htwvj4C9VP4YEmWSUDplBQbgj+Hirb8ugXXQqVRI4kLthteqB2cxe+31OmiID0N6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112745; c=relaxed/simple;
	bh=7lam01olvUb3QSFzRWm5ouSmAo57fVc3EtizsiBcnsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5WqZNgniutn3Y7ThUYuNPCtkPHKPJHA8eCIXPSxYRoL0XH36iV2LIp/tfqSLIAx+S1vybXVs1tZO2fusSEHudi76w9AgeT/KrufLnznkRKqXdLh5XFAeJ+iT3Psgk5lXB9kQYoOY2iFBPrL6slm5lAWlEjghBt7Wg7VxD6pmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQroCa56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3017DC4CEE7;
	Mon, 28 Oct 2024 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112745;
	bh=7lam01olvUb3QSFzRWm5ouSmAo57fVc3EtizsiBcnsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQroCa56iQzeXUL8nrps8MEdX0HTouT9bMBetWU5XncOJSI0GAFhR3nBkLJ+obTc/
	 A5Rs7oW72YN3J1wglamvxwgpUk2f96yd5ZryyxUklFbWMTFi77nue7Pc9j2PKhQqTH
	 DrtNlYfoabrkUsaPhTx+3/50NY9JDScVWW4QuBK3NGfeq8muAWHSkvWk/1oUw224HD
	 kBFdBOkY81xekuRuozptoHU8eZjWpog9MDF7CI8XbCkZW5J4/RZcoHC5kqAyeHE3Xf
	 biqEB5kAz1c3QEqoSwuD2Rp5/677wR5F2dNxRedpyVeav18l1kirKGg25nZTbsus7g
	 D7QjjBenbXcVg==
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
Subject: [PATCH AUTOSEL 6.6 03/15] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:51:59 -0400
Message-ID: <20241028105218.3559888-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index d0d8a01da9bdd..0cf9484183d43 100644
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


