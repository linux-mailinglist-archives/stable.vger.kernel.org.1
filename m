Return-Path: <stable+bounces-110559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AAEA1CA1E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C1E3AED92
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6F1B653C;
	Sun, 26 Jan 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akKLvUNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01D1FAC58;
	Sun, 26 Jan 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903355; cv=none; b=FIJ21Fd66n6LGmFhiesIQHLm+pE+tG/1v1eS+QGIQpiVsDtQFLrelMNLqlCrE6q/nkAWjYPli8VAX5Lx6aigyy39vNWmb3eKkt2gtM8tdGOOmK6YSdZc5R3ILbL1uyRCAoJEs0NRphEDfOuWPYYEeYzv2neYS9bF4/MIRBeC3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903355; c=relaxed/simple;
	bh=WgI30RpZeRgCtQtPJdBaywKaTQ0tBq7iGP79Wwb1shU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCnlMdrP9x0YjslNEEtWFT7I/PsgiXf+QIDYCzwqWwxUQfSV9tJ9mii2vgbcY0viMVTjpm0gGBm6oRuHyv61bkGBHOVhWEohq6Oif7CeWdou8MJD/0ebnyBqUY6ZrRpX5YvK/ZNS0lcExdnZMzNFGeQsZ2QP3RX5r8e7vPeLgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akKLvUNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A37C4CEE4;
	Sun, 26 Jan 2025 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903355;
	bh=WgI30RpZeRgCtQtPJdBaywKaTQ0tBq7iGP79Wwb1shU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akKLvUNNqDWYyp1jFps0Zza+aGzmDp8jMkUCk5ycYPPz2EnG6vDL/unrvoJY3RBwr
	 MLrbBYGf6KO6hTIl4dNsjZrm2aOAsIWQ42Orwd6VKuh8lLRs7I0elAemtLyIy/UXpU
	 4hMjM5iDkdlfPohCaqq8+LEwz9/1DQDFTmEoObHFOGDyP/EVZfOgQxDR/MUqQLNdWo
	 GL8MyGIJeHZ61hfyEKbYCmj8VeW8Z9IK88aOab4HDziNl+8Nkc/F3T5x5aGeU4SQSE
	 KJN8eNIQwe9OgPSRzBoRDw1dcgT5UsqjNKKdiEHy9WIgs+mdiZlArD2LYouWyKxYZj
	 z4pw0MxTmpYvQ==
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
Subject: [PATCH AUTOSEL 6.12 23/31] drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
Date: Sun, 26 Jan 2025 09:54:39 -0500
Message-Id: <20250126145448.930220-23-sashal@kernel.org>
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
index 008d86cc562af..e6ba2dcc4ad00 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -296,7 +296,7 @@
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


