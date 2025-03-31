Return-Path: <stable+bounces-127143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AABA76982
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274323B3A56
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AA21A42D;
	Mon, 31 Mar 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUK1U7cD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC7218AA3;
	Mon, 31 Mar 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432770; cv=none; b=fvqnDHc9rH0U0J/StZvFC6vkxguByNyoVxvluEAGdqfi7aTEFrEMUdvz9e4mSoVHxwtQiEgj+5BydYbfpuD9hLhuvwSHBgvG4Xz2yQCd18IUN9sq8OFLsJl6wdVe4LfMCVsABm7GFg1hjCo+trAK6dqE6sKFqHfpQZ2WgIEiWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432770; c=relaxed/simple;
	bh=yuUMbbdYjnlLnW7qcBa4ymooKDLZ8qgAPimz0TsDkn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoS83L6ZnfoBnfHWvDyyCo/4Jd6BUNBN849Wtvu2wYoNTxZ8eRGpzpPv+PUUNYPxwzoS01xjYOcdxRB9fOCKcsCiSgF5S4DTbfa5QSD/x6Nzv+Pr+el7X59EV9nmMOuDY4+oxlAHiKA6dRbXeHUOqpD6F0fn1Dg+KyMO/f60REU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUK1U7cD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D2C4CEEB;
	Mon, 31 Mar 2025 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432769;
	bh=yuUMbbdYjnlLnW7qcBa4ymooKDLZ8qgAPimz0TsDkn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUK1U7cDQDq5E2yCg97TZHyTZuAPwwXONRdqYt8UqiUlXwfGGsHot5qhoBAYAXNp4
	 +Q/WqVzcOj5VEjRPE6KjAppAHnjmH3774yG789RdupA3wneNjUomcfM37JFIu9dq9X
	 UiywenajLN+/p53BlIwY/Au9cSP0Mla7aiRZpjSTDCs1wCsBVEkBMKDSNaRnDEVBHg
	 W8Jm4sMLnQGQilXbVyprydGBlWwuiX9l20cR4w906IxHkrRkYOaJPwatSooJYVVxJH
	 vvGOirKH3ZxsfVYoOWTWl2DDq0ZYSWI5N6E7PNYe0CRSPba2zgrj8p5bvuO/cNUdUi
	 e2y7Vi5x3WWKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 02/27] ASoC: SOF: topology: Use krealloc_array() to replace krealloc()
Date: Mon, 31 Mar 2025 10:52:20 -0400
Message-Id: <20250331145245.1704714-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit a05143a8f713d9ae6abc41141dac52c66fca8b06 ]

Use krealloc_array() to replace krealloc() with multiplication.
krealloc_array() has multiply overflow check, which will be safer.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20250117014343.451503-1-zhangheng@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 688cc7ac17148..dc9cb83240678 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1273,8 +1273,8 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
 			struct snd_sof_tuple *new_tuples;
 
 			num_tuples += token_list[object_token_list[i]].count * (num_sets - 1);
-			new_tuples = krealloc(swidget->tuples,
-					      sizeof(*new_tuples) * num_tuples, GFP_KERNEL);
+			new_tuples = krealloc_array(swidget->tuples,
+						    num_tuples, sizeof(*new_tuples), GFP_KERNEL);
 			if (!new_tuples) {
 				ret = -ENOMEM;
 				goto err;
-- 
2.39.5


