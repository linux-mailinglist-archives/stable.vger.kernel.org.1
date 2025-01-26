Return-Path: <stable+bounces-110550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B01CA1C9DC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71DC188636D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B31F9EBD;
	Sun, 26 Jan 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXEkjqZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566611F9A91;
	Sun, 26 Jan 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903331; cv=none; b=iS7AF2WD65hpXvW2yn7YmukQ8FXGRhjA8mOxtsmauDZeREfnzv+zoIuOPDAOnqYx5absIaJu70XA53L2QkqH0Nx+cG/6Xq5zeWPk1m6EIm5yKaTLFZxmhkCC14t6gOMM9ZgVCgSVgokMkOEQOf48GzcybKdJRWLoLb6uYEEJHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903331; c=relaxed/simple;
	bh=8NvNMF1dJ78P663aKgCxnDkjp/Dwyz2QoZs73ndSuJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkKAXir3WMM3M3Xf/I9+TL4bH61jBQttPNspkjl1sYdErTAbv5BS5dLijjwiV9d4+kBaIkHGYky/POUcQuu/3WXUMLBj5f5igr7gtt2Cw4QKQDHS53Yr0uF2obDd/r04d/gzhILeYLjHKB1iDIEphhCH8vAw/o3tq5NXOZArDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXEkjqZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE98BC4CEE2;
	Sun, 26 Jan 2025 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903331;
	bh=8NvNMF1dJ78P663aKgCxnDkjp/Dwyz2QoZs73ndSuJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXEkjqZTj9SsbCLMcbjQqIVsEWDVxHT7hh425s344XLESGLuBw3knn9N1l51Z3/rS
	 1HJc1zU+5vIaumEo/pofy9bJnQXn0yDPrGVABRGddO/o1vDIs+4NlkTd/GF2oAjoMT
	 AAZZM/Q0unXGN6nL8/AcrGngFoFRalC/AYyayhqQPNVbMj7O9OE7gn1GIPxCBHjj1w
	 85lkhGrYcjHc7g36yRqorYQ2/R0xTW+rkGWaHvkS/kCU7I3M+dn9tFmQr9GxSTt6RW
	 oy1thCxKwvYW3aypEqgd0LrXzSbBZVFCDFpPoCxl+7bpxrAjquo1N6qfwp1THrlYJF
	 zPdSBLUKBMrKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ple@baylibre.com,
	neil.armstrong@linaro.org,
	andrzej.hajda@intel.com,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 14/31] drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:30 -0500
Message-Id: <20250126145448.930220-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 39ead6e02ea7d19b421e9d42299d4293fed3064e ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-3-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 925e42f46cd87..0f8d3ab30daa6 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1452,8 +1452,10 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
 		dev_dbg(dev, "No connector present, passing empty EDID data");
 		memset(buf, 0, len);
 	} else {
+		mutex_lock(&ctx->connector->eld_mutex);
 		memcpy(buf, ctx->connector->eld,
 		       min(sizeof(ctx->connector->eld), len));
+		mutex_unlock(&ctx->connector->eld_mutex);
 	}
 	mutex_unlock(&ctx->lock);
 
-- 
2.39.5


