Return-Path: <stable+bounces-110579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577AA1CA15
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4781887D16
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F81FE47E;
	Sun, 26 Jan 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSwV3FGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D021FE47A;
	Sun, 26 Jan 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903401; cv=none; b=br9JI9ZKxPgnolAmhW0o/SWuPTv0DoQqaxWDViZBfT304kOXgnJ+QaSMJZBdgmD/clKSjxyVlCGOQfDQben+eMsKcQt1wFOMqMsI4CQ4X/nmfUpqnBivIfyCD3hKXQVTrkhRjFpavKeGbPHTpAswA0Vy1grytvr0k2cAJ270VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903401; c=relaxed/simple;
	bh=PKMO1/Y/7zRa10cs8DLp14uWJAtZjNNP/fdlElXC5U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0FFyh9YdMpoQvbhm23AMPUJUbGdWB3Z/Ceih66HBPpG88EHyouAlyP+xkIPmVSbEurp2Kcb9URNVH41aHmH7W+1PVqkM743wrx/FqQf0+Vi5dLVddqatJXt/VK2Sg5PrWaKDSmZGPgS7MzsDII5JF+BuPdHodPbQzORutbdW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSwV3FGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45FC4CEE2;
	Sun, 26 Jan 2025 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903401;
	bh=PKMO1/Y/7zRa10cs8DLp14uWJAtZjNNP/fdlElXC5U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSwV3FGoa88ZKwGdMXsspMGjGimy8tiIEnXT3nZNjcqpajgBnswl8OpEoCqSU8BOH
	 AvRvVhoIb5h1gKA2NG2V1xZEoOZAQ76cvJ5f4zBnRsPVlr1/4nAdgZtdWGcQBg5uMy
	 09QubY2TXUPHNFtFykgmWrWb4H0sxWdSidC+KD4baBaZmbVvFEpBFEJFXXG9eHK+WM
	 PbDJCPj96tymSNV8ofUgTtdu+kuw+o5oOZhJYDdmU3+gocuwLK+blWqRXOaYFelQG4
	 GEGZf1STM1OMigVU4+TGsPaA6AsiZSqxqn4P7plNGvyApaNbjxS381TObx6HoFafp4
	 ZexSxCV3zsYOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hermes Wu <hermes.wu@ite.com.tw>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 12/17] drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
Date: Sun, 26 Jan 2025 09:56:07 -0500
Message-Id: <20250126145612.937679-12-sashal@kernel.org>
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

From: Hermes Wu <hermes.wu@ite.com.tw>

[ Upstream commit 85597bc0d70c287ba41f17d14d3d857a38a3d727 ]

A HDCP source device shall support max downstream to 127 devices.
Change definition MAX_HDCP_DOWN_STREAM_COUNT to 127

KSVs shall save for DRM blocked devices check.
This results in struct it6505 growth by ~0.5 KiB.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241230-v7-upstream-v7-4-e0fdd4844703@ite.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 26d3b9b843267..b7f70c8d14473 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -295,7 +295,7 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-- 
2.39.5


