Return-Path: <stable+bounces-111320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38FA22E74
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3626A1689CA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B61E2853;
	Thu, 30 Jan 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzP/kwXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54DC13D;
	Thu, 30 Jan 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245668; cv=none; b=B6UMoUVNMpXf6FMT14uqW+kTYP8MxmRU2/KaKXCed3KloS44dry2IhySmX1Kj4XnGjZRX6eBy/DAUSN47kJrQbCQ6tkok1d0DkMUPs6VKGXZ8a8G920PePsnZ0iv5AmtYTn1JzUsHDTYZg/Sh6YgGNKjJainqak41PKhyoOwWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245668; c=relaxed/simple;
	bh=3aM9dJmSgIbBB1lfnLd2hJnoP8LM3NjcGV9nRbVHbcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebrpTROvhUDV//cpQ72U+2U9xD23+llxHMGtqJ0r83yU5MfpAvkyZl53U68+sKKqmbAGq/zfxzOQSmxv2kJ5kC+b/hYc+qvRBFoDsue/asi3YN0ZeFHiumnzEgp28k1+tAWfIwRfcQPrJb+tPI6Gs+XJ8YPakP7QlkOXLjWYAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzP/kwXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B0CC4CEE0;
	Thu, 30 Jan 2025 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245667;
	bh=3aM9dJmSgIbBB1lfnLd2hJnoP8LM3NjcGV9nRbVHbcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzP/kwXqicKAOzrVdlrKG0ny6uqne8GzKswfSJn0bA4pSTgzbpiOw+/z9XZgbT8Sj
	 G3NmP+g4KHMjh+KLBPpGDXeJEsnV14aN7HM1+16Y+LaiZM7EL4cxylDyWbCtohk3XF
	 83tUeRkt5H5Ap8/7jIPxHyHF/VgVOWVS+2tAcoYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marian Postevca <posteuca@mutex.one>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 02/40] ASoC: codecs: es8316: Fix HW rate calculation for 48Mhz MCLK
Date: Thu, 30 Jan 2025 14:59:02 +0100
Message-ID: <20250130133459.799816621@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133459.700273275@linuxfoundation.org>
References: <20250130133459.700273275@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marian Postevca <posteuca@mutex.one>

[ Upstream commit 85c9ac7a56f731ecd59317c822cb6295464444cc ]

For 48Mhz MCLK systems the calculation of the HW rate is broken,
and will not produce even one sane rate. Since es83xx supports
the option to halve MCLK, calculate also rates with MCLK/2.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
Link: https://patch.msgid.link/20241227202751.244954-1-posteuca@mutex.one
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 61729e5b50a8e..f508df01145bf 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -39,7 +39,9 @@ struct es8316_priv {
 	struct snd_soc_jack *jack;
 	int irq;
 	unsigned int sysclk;
-	unsigned int allowed_rates[ARRAY_SIZE(supported_mclk_lrck_ratios)];
+	/* ES83xx supports halving the MCLK so it supports twice as many rates
+	 */
+	unsigned int allowed_rates[ARRAY_SIZE(supported_mclk_lrck_ratios) * 2];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
 	bool jd_inverted;
 };
@@ -386,6 +388,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 		if (freq % ratio == 0)
 			es8316->allowed_rates[count++] = freq / ratio;
+
+		/* We also check if the halved MCLK produces a valid rate
+		 * since the codec supports halving the MCLK.
+		 */
+		if ((freq / ratio) % 2 == 0)
+			es8316->allowed_rates[count++] = freq / ratio / 2;
 	}
 
 	if (count) {
-- 
2.39.5




