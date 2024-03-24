Return-Path: <stable+bounces-30538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C587A889239
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EFC2935F9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5125ED50;
	Mon, 25 Mar 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffNA3ML8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC0273D9E;
	Sun, 24 Mar 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323329; cv=none; b=t7NC/EXbV3gKJeiUfNl3lOmTORAIMkuojeR8RQUkkGFj3L2J3JWdBrTEQ9bziYzwp7jyf16n45ZffX2vRLoJTkJ2mZgmmtYIQlBX/2p6ZSoUvPXGe/gXSWfzE/Ni7mjoeu+GSEUZusNmI1+2M5Oq+7QnoCHk7YMjeyl7LCl8v7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323329; c=relaxed/simple;
	bh=sYDEOH0SIb1oJ1rax5oz64WlqG7l/xYsPg5+CTtP2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZumohjGa8nu/XAAAqXnwsR6/24mP++sbIqRQfZL8JO/R7Tb8z9mAc/jHnOHSkTLr3eK/jF7SKkWkW9ktZFXc1iaCj5zludIzsIuPo2eyBWVGq3xiC4ycw0mtXmOlcuH2tdcbVeuj/4fV1UyJltte7UQ2tQszrj1Cnf+fbnSFlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffNA3ML8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B64CC43390;
	Sun, 24 Mar 2024 23:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323327;
	bh=sYDEOH0SIb1oJ1rax5oz64WlqG7l/xYsPg5+CTtP2AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffNA3ML843gxEdbhiOQMPhTbeAagJ9VnOdEDqFa8OG4ThCkJ4z85H9Larc9CLpN+j
	 7TXqaUDrU7voCRqTG3vBXv+iAfriXq0X1ejlFZZOtVp7GeIeTE4zGH4vmE/yWi/NVU
	 VKPR/H8eqTEB1mRnugB1TkqyohuYvPZLQsza0DtoWcURC2qjYmqJ1DWc26LqWo2evU
	 Jb6hPSoc3vwflqWHtcYoonN8VaVdztmnMoJLbRv94vDca+E+k+vl9OM0Gx1AlvoeoP
	 V1XNChr5oy2dqXusbfv2yT1pRSrAqgUSUy2iLhh47o6bceS8LhfHN74kcUDGht1uEh
	 3IS0m33wTDmrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/317] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 19:30:08 -0400
Message-ID: <20240324233458.1352854-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 779f7097d336c..9f8929cfada22 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2901,8 +2901,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0


