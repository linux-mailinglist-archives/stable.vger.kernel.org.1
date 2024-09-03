Return-Path: <stable+bounces-72878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03596A8DD
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA641C232B7
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741141D61AB;
	Tue,  3 Sep 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQhU4IZe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29C1D79BE;
	Tue,  3 Sep 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396226; cv=none; b=HKfkw2MYDMPKJ/ubUzKwUFOtXpotzGC0t9iYN6LOiJrX9s7/apNnPB1Annq5d+sCpf+4zaLJPpUsNvF6gNx1fSqGY4bYeFs/gGIjFru34ctnU8muR4RlRQyHL+IUSHOKSPxw3S7sfmUIXygT5puina81hr5T7nc6Y8letdzYpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396226; c=relaxed/simple;
	bh=gtQyC/y+R+KiSt4qyRBmXQZX240IC8QEuMrx6eyMMXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx8o8qyQfACDs6zYBcFrF2d7B0bOdu8VsGf5hEu9AduqavDp3ApG0lAUpRP6dfWTeGbKVi+nf5JjMtg/YTPyFrUaXBwNySaG4yeyzKU83kr+dWmjI2UlUmXcxl1k5lFiP9UKmjEbEpF8grvCmpz8/zfsSYOXrzOb/cGBSnbCbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQhU4IZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF13C4CEC5;
	Tue,  3 Sep 2024 20:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396226;
	bh=gtQyC/y+R+KiSt4qyRBmXQZX240IC8QEuMrx6eyMMXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQhU4IZe8AuSVYax1xuyS0kkAfZswbE7jr7PdaW+P07QyZwfIS7KePSfsW9zLpEtB
	 G0/zDGAVgq5DhF1sx7ZobvVhaEjqjGSEhZkFldUIeaoXNix6r4EDQOlcbPUoG4o+TK
	 g8DLLj7TZOBrP+tZUv6VSYOHi7ZZlvOY3k562WfKyxsSekHKBRJkqK0sD3jDnHOXr3
	 HrBsj77WM1AtxjfketUpvCEGhNRtV+tUjXe0xIslY8HF23kqzVcStWPvUGoAFLxi7a
	 y7x603EWM9SMDidb9zK1cqIWNZND5b8VY7jBK2PVEzN/laTCReMGROY92oUCl3OESs
	 mMwT/5hBDR/YA==
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
	krzysztof.kozlowski@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 02/20] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile
Date: Tue,  3 Sep 2024 15:23:34 -0400
Message-ID: <20240903192425.1107562-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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
index 5e14655c5617e..11f30b183520f 100644
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


