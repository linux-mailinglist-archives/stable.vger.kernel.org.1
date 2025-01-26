Return-Path: <stable+bounces-110572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD053A1CA35
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7493A9E70
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFA1FCFDF;
	Sun, 26 Jan 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/FM24as"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AF1FCFD9;
	Sun, 26 Jan 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903384; cv=none; b=FELCam4GXzSMxtZKm/zMAz7DAWcIeyoZABU/aUvozc4Ul2+NhN1Z1VmSWisFZxEg3mjcyNcityfoYIgagBQvozCrOrLTULjcnspkK1dAgSbDQuvaIFlzsjfAALflGnePVEiwV+SutS417tyJJr4vfbTopHnMiRJ9nNBjqsnms1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903384; c=relaxed/simple;
	bh=8F4QJ1WVnzs5ANYh3Hp5Fu5kYNIAs2i1oIvPnzWUJLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYMVpTBD56pi0Ru44DA9hE5tDTpYHaNfNoQTq3kMPMmBgw8Ui6fVxKLD5Bao+KJ52q9BWcdR0Ouo0QgNnVWOjP5gG24Jj8Uveqtv7qy8NX4UL+H60CCuuNh/mKhKNzO4RvQh/Afb3yHhJG7GlXaT7itIxyRCk9AZs9FSBGApDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/FM24as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64928C4CED3;
	Sun, 26 Jan 2025 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903383;
	bh=8F4QJ1WVnzs5ANYh3Hp5Fu5kYNIAs2i1oIvPnzWUJLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/FM24asPCFsonWGIQIMqvDehy2YYl6EzOsYRYwbHsA/6fzBoNUu7wDQLQbuVom9j
	 sdQ9kLkIAwzLM5hC6gorgitR/XB3F6X7tBVwqnttPx7Mf4GTva9Zzu+8t1UC1CalZ7
	 2OaL4QKAwuVWVtPiBdGz50cmE7uxCt1PB1JHdFfIPff6oMyJDOSVYC71+3iBZY1V6O
	 uvJ6WhYoIZ4RYwJtyxSTbZ+3BEx68/c4616F6kCweM73XrkgYpu6S8X2mZD/CqVWwP
	 dcIIwBBQR+8ZvRtAHLdE+ILFZX9Zr3cBrBLgbc1nTzRhWcLbH5J16UwIIbBsaoyI7U
	 5ZJVwoSZVqOXg==
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
Subject: [PATCH AUTOSEL 6.6 05/17] drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:00 -0500
Message-Id: <20250126145612.937679-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 8f5846b76d594..2381cd1cba879 100644
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


