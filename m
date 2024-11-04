Return-Path: <stable+bounces-89630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7939BB1CB
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FB3B25025
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF81B4F2F;
	Mon,  4 Nov 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJjAAZpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB81B4F1C;
	Mon,  4 Nov 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717502; cv=none; b=Zkv9RcWr5PAMggFuBu+9SG5u/QT1htnxGgDx4BiUhP+KxqrqL4Qjndm1248AASVT6HqjOUcLfhXifjF/rYRfFXNVLr68lBRTuOW9Wjct890xlktJ0onncXIy9/6t23Gass1TwiilDmPkwGgnpEqQatS0CyYPtrNJmRBmoKk36Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717502; c=relaxed/simple;
	bh=A1eAkzyOIOiq24BAVQfGndHmmHhzGaLA3wDADHEU4yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQRuyVBsOh3BK5e/OInOPykHcoa+ZdzK+uWGV7LGitBd9cccjRPkZFMWV/wFYsgHEfz/HzBXXiyN8QresGKjuttoXSnoI2HecSXHAzjmIm1dvDESlYm9pQsS9Kt5eUAVFewOIR9xDVIvb/pq8pmEfg2zHSHETGU1CexAs5iH9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJjAAZpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8575BC4CECE;
	Mon,  4 Nov 2024 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717502;
	bh=A1eAkzyOIOiq24BAVQfGndHmmHhzGaLA3wDADHEU4yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJjAAZpaNszCfqM4SHGdEdt2DaBNGnYiamxOd3fUxtpFixSdRmmEioyI9fE3htOL3
	 Zjj2YERVWe/tO4tjK82QH/UwVOJf0eb2JFW4rh9yZi8a7D1GyfQYo58xB1r7z9lJi4
	 MIDirbGJ6VzawswDSXg99y66Ogf9fuKwPWLIbMU702wm6EmnWIvQO+B81fSs7nBT+D
	 4V/BBWPc3lEC9lHsjkwdsM1371kEiXYXkCICjijtCm2K0AAob48aTlkOiIet7Cj0PU
	 gqECrVL7x6wENapp+9vykzMF2KuVzsU0XPA5bbH27RRF3vvEDhQFYx6u2uVW5+1jY1
	 Uqe24YPeQLwDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Adam Skladowski <a39.skl@gmail.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 17/21] ASoC: codecs: wcd937x: add missing LO Switch control
Date: Mon,  4 Nov 2024 05:49:53 -0500
Message-ID: <20241104105048.96444-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Alexey Klimov <alexey.klimov@linaro.org>

[ Upstream commit 041db4bbe04e8e0b48350b3bbbd9a799794d5c1e ]

The wcd937x supports also AUX input but the control that sets correct
soundwire port for this is missing. This control is required for audio
playback, for instance, on qrb4210 RB2 board as well as on other
SoCs.

Reported-by: Adam Skladowski <a39.skl@gmail.com>
Reported-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Suggested-by: Adam Skladowski <a39.skl@gmail.com>
Suggested-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://patch.msgid.link/20241022033132.787416-2-alexey.klimov@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd937x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index af296b77a723a..63b25c321a03d 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2049,6 +2049,8 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
 	SOC_SINGLE_EXT("HPHR Switch", WCD937X_HPH_R, 0, 1, 0,
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("LO Switch", WCD937X_LO, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
 
 	SOC_SINGLE_EXT("ADC1 Switch", WCD937X_ADC1, 1, 1, 0,
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
-- 
2.43.0


