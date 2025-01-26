Return-Path: <stable+bounces-110518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D1A1C9A2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FAF1663BB
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291651E1A32;
	Sun, 26 Jan 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiLechLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85011A76DE;
	Sun, 26 Jan 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903244; cv=none; b=iX+KfTL9l2BFM7QKWw9X7y7P4mWaKkY+4Re2e3epvKv67+etDcsYYlAt0c18NmUPl3W5izHj26PuMNEzd/a529fDy6VWDQPPOeB8V1ONyZCPJkR631VafVDOV4u7dHkPbO1lbqJIa1oYG0wtkNrHMUoJjvXrPsxxo44MIkEUKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903244; c=relaxed/simple;
	bh=sXPl/L98og/V3vDZJrbZHCZOChEie7JwWBgO4at0US8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJ0zVShXc0WnEQp2TRRu0Lwv0T/uoJK0ThaznzcUDLlK55IW7PBYY8Xn2S2VlQPHBbbHbDWE2TO+cquQj5o8V2eYiMPa7xWnRTqs1ZdYeB63Xa2wztrW/KVJiJCuc60Fl/4q3DIdaNv/jF8UKj6jS8Gnc9PBaiPPYgkojSWeQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiLechLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6BC4CED3;
	Sun, 26 Jan 2025 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903244;
	bh=sXPl/L98og/V3vDZJrbZHCZOChEie7JwWBgO4at0US8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiLechLQ5UEltdkrt/vD6n49dneo+ntvHFtVotYCrjJZlOt9aKSl8f+F3hmrLonE6
	 cYxPOFt0l1rj7uJ4xsHmEb524ea/6NVhwX1+1u3DeRXljSbfcWq68IU/+ScrQdhO9o
	 PRToVVxJXr++S1QBLBgLBvoQZCfhsSz9qe5Ah/8foG8IYnTtss8C9fMsh2aUvjPM/u
	 0t84VKgfRqMy+LKY9rAKwF/KTNvnd7uMlla+fIfbh7toxkH2jDigBTrQoFIR5TekNQ
	 U2Ps95iYrSdiosbnXjArDbzaifnEGYKijQ0qIssawXspdO7lHQs72GEGHKu+xMWS0d
	 ufZJ0mqZXgt0Q==
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
Subject: [PATCH AUTOSEL 6.13 16/34] drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:52 -0500
Message-Id: <20250126145310.926311-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 35ae3f0e8f51f..940083e5d2ddb 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1450,8 +1450,10 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
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


