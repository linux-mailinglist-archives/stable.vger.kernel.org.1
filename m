Return-Path: <stable+bounces-72856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37B96A8A0
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E699B23DE5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA91DB552;
	Tue,  3 Sep 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0zxmjU9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659B1DB537;
	Tue,  3 Sep 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396124; cv=none; b=W9rq2SFYGHEI2ir/t3gBj3T84NQHbRyNkMvQpz9ygSVS8SZo8W6UMy6tl/S2L1+HfI3eIWKFr9EJOlxBUh5jk0RL0hPogyUNatXzlArYcdnAyDn2FQ4nRkOsphT9QbMfv3Kp4F1TIGdJi0pD2QtoBX2qHdNnBmiZ+B7iC0r0UPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396124; c=relaxed/simple;
	bh=f77a1LdLPhKYcoJ9UhrtcEXRimOa6g5gNGHE4f1mX7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyL4NEqjNIi+261MMxhmRATRjHMeft0HmfS6kIPkMf1x81D5bOacN3TMfpvsJA3uXNuawDovWudrqw/QqB1De1hURZk6kV5045D5RaDGV0b4Z0Rzj+ksMcRRXd7EOImX+TzZmxo07qtCPD3fc70MQE7UUFr26NyGv2uuDoYZyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0zxmjU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB15C4CEC9;
	Tue,  3 Sep 2024 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396123;
	bh=f77a1LdLPhKYcoJ9UhrtcEXRimOa6g5gNGHE4f1mX7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0zxmjU9R9qHYTmD4lWdb8R9J2QcxNt3y2i3ulRoVsJrYgFXDcnqOyYXwWI2ASxRp
	 ELWstUDXBhF0ZplmpiqGNQdHWO7jM/IuqsgexFDOdzQMTEfNHke1jxxx4MTJsinG1J
	 gxDGpGtYNxAwYScxXLX6rnx9FLosd/ZqVWdoQeObqx2pq93U3ZD5nwB0irbPkjcFl4
	 XDeJCOfQcU46SiDMk9tLYnBf3B99XI+S4uyI8Rg/Sj/BHwu1alHQN0u9s30jxW+TnI
	 15cgK32QDyKjGxqxyeKMsqyhMdY3c6RiQf/drkUCbhyFzU+L9Qn5AZKY2I2DzK1YZi
	 De+VyLqJBo/7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: YR Yang <yr.yang@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kuninori.morimoto.gx@renesas.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 02/22] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile
Date: Tue,  3 Sep 2024 15:21:49 -0400
Message-ID: <20240903192243.1107016-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: YR Yang <yr.yang@mediatek.com>

[ Upstream commit ff9f065318e17a1a97981d9e535fcfc6ce5d5614 ]

Add AFE Control Register 0 to the volatile_register.
AFE_DAC_CON0 can be modified by both the SOF and ALSA drivers.
If this register is read and written in cache mode, the cached value
might not reflect the actual value when the register is modified by
another driver. It can cause playback or capture failures. Therefore,
it is necessary to add AFE_DAC_CON0 to the list of volatile registers.

Signed-off-by: YR Yang <yr.yang@mediatek.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Trevor Wu <trevor.wu@mediatek.com>
Link: https://patch.msgid.link/20240801084326.1472-1-yr.yang@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index ccb6c1f3adc7d..73e5c63aeec87 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2748,6 +2748,7 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_ASRC12_NEW_CON9:
 	case AFE_LRCK_CNT:
 	case AFE_DAC_MON0:
+	case AFE_DAC_CON0:
 	case AFE_DL2_CUR:
 	case AFE_DL3_CUR:
 	case AFE_DL6_CUR:
-- 
2.43.0


