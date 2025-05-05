Return-Path: <stable+bounces-140074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D5AAA4AE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF891631BD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860D30426D;
	Mon,  5 May 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUe0sSJ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5483304267;
	Mon,  5 May 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484050; cv=none; b=BDz6mPVFYx5hEBgQa+n6G6Ob01gvodlS5RWbfMhglYrlX2VW4a8gaKmphCkrBnqWfFD8luJbdZu8XIrKxkVNWy40VG9L0QLzK70/LDeBMaWStGS3OY5UfZEx4BcrjGGPjRnZTDRDcFfqC2PhYR+qELDnVw/+WhU9tZM/DdOu1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484050; c=relaxed/simple;
	bh=O2mn++1uinwWnkH+yXKQUTW2RQxr5fSjFwSzt/Zof3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk+gQCEYnZHBMhGGTOoqjly1Jrr6q6T1DH8MKVe35pD9KYt5pyk8lYboPz68Hx7HZtKbXT2lkz9SVm52xwPZR5o244wXNRjTniLn7NPSnPHI0QlLQ9fh8S6goxSxhmkUOhx7mAPAUtzpv80OGIbuUDAN6DdJ/zfCk0s7T/pivwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUe0sSJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0311BC4CEEE;
	Mon,  5 May 2025 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484049;
	bh=O2mn++1uinwWnkH+yXKQUTW2RQxr5fSjFwSzt/Zof3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUe0sSJ+XKyxl4qs3xU5BRxi+hmw+bh1G+S2GNH2V/bqcZ0Bq3QeMK9diLwCR64Xg
	 O0iiHfFH8AvZLTG+ZA4Ftzx6r0JCAJSkUqeYUdnobwBVQ2/14G0/uInYfeVaOkDZ+L
	 bEBOX2HOjrQRMwM8K6CfStFLuLd9b9KXMNwUF8mwHB8ZI6DoUpXnaTnoYABC4xmwoI
	 hi+qQ+AkXoxloZNJoOYi5+4tZvmfHPQJZsnBvSg7Aw1Htow4exTvZB2cz79tpd6YcC
	 KzD+PTaHhtYXEhg8+Sr3lu87yZgDijOr1FkUX+tDnPK7Tdxn7511nVQLHk8IlxGomI
	 n6digc7vayjvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	ckeepax@opensource.cirrus.com,
	Parker.Yang@mediatek.com,
	yr.yang@mediatek.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 327/642] ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as non-volatile
Date: Mon,  5 May 2025 18:09:03 -0400
Message-Id: <20250505221419.2672473-327-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 7d87bde21c73731ddaf15e572020f80999c38ee3 ]

The DMIC_GAINx_CUR registers contain the current (as in present) gain of
each DMIC. During capture, this gain will ramp up until a target value
is reached, and therefore the register is volatile since it is updated
automatically by hardware.

However, after capture the register's value returns to the value that
was written to it. So reading these registers returns the current gain,
and writing configures the initial gain for every capture.

>From an audio configuration perspective, reading the instantaneous gain
is not really useful. Instead, reading back the initial gain that was
configured is the desired behavior. For that reason, consider the
DMIC_GAINx_CUR registers as non-volatile, so the regmap's cache can be
used to retrieve the values, rather than requiring pm runtime resuming
the device.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20250225-genio700-dmic-v2-3-3076f5b50ef7@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 73e5c63aeec87..d36520c6272dd 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2855,10 +2855,6 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_DMIC3_SRC_DEBUG_MON0:
 	case AFE_DMIC3_UL_SRC_MON0:
 	case AFE_DMIC3_UL_SRC_MON1:
-	case DMIC_GAIN1_CUR:
-	case DMIC_GAIN2_CUR:
-	case DMIC_GAIN3_CUR:
-	case DMIC_GAIN4_CUR:
 	case ETDM_IN1_MONITOR:
 	case ETDM_IN2_MONITOR:
 	case ETDM_OUT1_MONITOR:
-- 
2.39.5


