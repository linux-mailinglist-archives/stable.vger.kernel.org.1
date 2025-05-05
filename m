Return-Path: <stable+bounces-141025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4089AAB013
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C7D18886C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730B28DF34;
	Mon,  5 May 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCWaxXM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D9398291;
	Mon,  5 May 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487262; cv=none; b=X6R6UH6JG/7/B5d9RQ2D5NdiKe0Abrs8UPshTVCG1Ii1dojF/ttsMi9TrPjX9KVzJMFbkoAACKKaQsBsZ9HPszo2kjxnOWm30FybTqlq+bRWn4wsiQ4hi1C63/FjADIxplce+T22T39uVYhIrE1M5WaZpiDOMNerdWi178E5ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487262; c=relaxed/simple;
	bh=8VkDgy7h7NctUlOJ32G+sNnT5RE1+skhQBXvvbQiNlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S13b1n1B+4EnwR8j5GOr37kJDT9B20WZIxXkII1n1xVfhNVthcCMOLGDACsraLft+hX6WSiD3TAy10gDfhcxG3aSxWSU3LySFJ2j7N7oAPKXQs6lU970L4rMrp6Mgn6OM9S3DKU2M6KYQpAh01vOF0tNbkr4zByLTqmtzZl75nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCWaxXM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9BCC4CEEE;
	Mon,  5 May 2025 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487260;
	bh=8VkDgy7h7NctUlOJ32G+sNnT5RE1+skhQBXvvbQiNlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCWaxXM/PzJln9diMNkJxdxCphkvWsRJma+IV/Oepdp6YJZhJSQox7nZCzfbWJ7WD
	 kF1mAunVptfpm2k84lxYXMaGmXhPXUOmQo0NaLQtHNaHylyc8JnlBOyblcmulvjwAy
	 tZA71/NLUn+GAKtYWMMbsk9SeinsR23VsnsZZduw/J1j9dkKFpeETxXiZFefhHhCaF
	 4GEkMIE04dSUuGM7v86BCBwR4l/uiAY0f4Ll691BCfHlCDnEM3Fse0nyot6OdrL3Vr
	 N7pUx9PyPi/BnHxuFlMknd4Uq9kSiR8HMqMoDOVJnJqGZ7EDj6oEC7RkBqRBKUvUiV
	 4E34HNwyIVa+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 086/114] ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()
Date: Mon,  5 May 2025 19:17:49 -0400
Message-Id: <20250505231817.2697367-86-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 7f1186a8d738661b941b298fd6d1d5725ed71428 ]

snd_soc_dai_set_tdm_slot() calls .xlate_tdm_slot_mask() or
snd_soc_xlate_tdm_slot_mask(), but didn't check its return value.
Let's check it.

This patch might break existing driver. In such case, let's makes
each func to void instead of int.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87o6z7yk61.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dai.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 4705c3da6280f..f9aba413e4952 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -208,10 +208,11 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->xlate_tdm_slot_mask)
-		dai->driver->ops->xlate_tdm_slot_mask(slots,
-						      &tx_mask, &rx_mask);
+		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 	else
-		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+	if (ret)
+		goto err;
 
 	dai->tx_mask = tx_mask;
 	dai->rx_mask = rx_mask;
@@ -220,6 +221,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	    dai->driver->ops->set_tdm_slot)
 		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 						      slots, slot_width);
+err:
 	return soc_dai_ret(dai, ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
-- 
2.39.5


