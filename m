Return-Path: <stable+bounces-49770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D4D8FEEC8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C791C25ABE
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DB1C7D6F;
	Thu,  6 Jun 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMQe/im+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE141C6893;
	Thu,  6 Jun 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683700; cv=none; b=lpEn5lenhg7ei882muGsynrMW4RSDORQU+owUR5chSMQ+N78B0kHCaTiWvoCYHK1RGJK1rLokJ/feTD6sI+NZPtx+JAUHhi5NIc2t0V4H0FO7xh5ok8+F1hh8e4fLe7BjhwjKcl1etsTAX07FkCHINR+ZtgyjGteeZd4AmTYd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683700; c=relaxed/simple;
	bh=EKvlSGNJOgBL1vVCuXQgn3l1a2H12GoaMwTP7SrzAQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgQZBS39vXvO2ftgnBL6hRlC1CxBziLAoMj2OA09kKrR/+esFnX11ELmkTAOrH/kuUW5sEhIww2IOgBx0geLiNz99ChnphyYNcPpid/UjZcGAxKR/UVv88cGQumTMhhNrGcfP6fscZg/XLlf5FNM+C88IxCb3tv52Jjbb+k2DYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMQe/im+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80089C32786;
	Thu,  6 Jun 2024 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683700;
	bh=EKvlSGNJOgBL1vVCuXQgn3l1a2H12GoaMwTP7SrzAQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMQe/im+43uq9F0wz9+SNjFcGzHHAZtKy+S+lestEl0986rvYOcdWqXOrNjbIdUQP
	 KSOsB458/Jz9/DR+h2CLFCl+Mg2mRF0BPTPTGcqJggw4xoyP1q39AncR426mPBi/H0
	 n4QAOTvcr1/AAK1WyQUx+g1U0V0dAOqnYZqLGlus=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 622/744] ASoC: mediatek: mt8192: fix register configuration for tdm
Date: Thu,  6 Jun 2024 16:04:54 +0200
Message-ID: <20240606131752.445742977@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hsin-Te Yuan <yuanhsinte@chromium.org>

[ Upstream commit a85ed162f0efcfdd664954414a05d1d560cc95dc ]

For DSP_A, data is a BCK cycle behind LRCK trigger edge. For DSP_B, this
delay doesn't exist. Fix the delay configuration to match the standard.

Fixes: 52fcd65414abfc ("ASoC: mediatek: mt8192: support tdm in platform driver")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20240509-8192-tdm-v1-1-530b54645763@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index 9ce06821c7d0f..49440db370af0 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -566,10 +566,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_A) {
-		tdm_con |= 0 << DELAY_DATA_SFT;
+		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_B) {
-		tdm_con |= 1 << DELAY_DATA_SFT;
+		tdm_con |= 0 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	}
 
-- 
2.43.0




