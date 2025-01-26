Return-Path: <stable+bounces-110589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1408A1CA31
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C6818887BD
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F21FFC58;
	Sun, 26 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcPTD62Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5B1FFC52;
	Sun, 26 Jan 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903424; cv=none; b=piS7uP3hLayObJYgcpsfkz2mh06pkMItGxmxknDYkg4ltIsf5k4oYIkxLqCr3YSQySG7VgEgfTFuYHPpawtQxfJjBW42p1R3BZ3woh0iq+JOrWtNaMiEV0cg/ik6R5HPSErAz7u2nGGGogMYDUb9wYsAtFRtX9o4evYH2S2d7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903424; c=relaxed/simple;
	bh=MvhPhwpDMbr1Ot4y7wq+dH0S+d3TKlF9sW4YFGWa0uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xf1OFntgj5AzGUmcTm/4ygXvUk5erHLhmu5hdQT6dxlZ0Wsr4kwtxGjRkWKHOj8yNel2SjuhkowliiW36qePw822FzWo+um3YOnFh9uUUAoUc2WFvHL4wmMJ1HZxilgpUS1T//77a4+47UDghWVOyHP49wud9L0n0g1EaRFeKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcPTD62Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D1C4CEE3;
	Sun, 26 Jan 2025 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903423;
	bh=MvhPhwpDMbr1Ot4y7wq+dH0S+d3TKlF9sW4YFGWa0uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcPTD62Z3JEZf9GwLAaNgOzpv3BcFhgx0811yhGJwUMf3V/ojp+yFyBCpUnBBiRpo
	 eWe6CnuvG3CRDWfckOehfCZblRBGTnTyIpf0XV1CdvV6Tbt1ED5jGYATRXLSK2KenG
	 HsB13xR98IVeJ6SRjdEBs+rZtH35MQZR68afb2b/ajRdcOhOdC6+p5e8sOkrQZRxZc
	 TI+NfXAMKMq/QQlAoiISVuCAzWqqwTjwLtg7ZyW40OGSJS40c5T7CYNznkfTqlbmZ0
	 sJsp8ION8dNc9sf0WPlknBK9/4t1hYbmRiEqYT0GeOpGv1MVOGSCX1pU3v4Y9CilV2
	 u2WN2aMbL5bxQ==
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
Subject: [PATCH AUTOSEL 6.1 5/9] drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
Date: Sun, 26 Jan 2025 09:56:47 -0500
Message-Id: <20250126145651.943149-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145651.943149-1-sashal@kernel.org>
References: <20250126145651.943149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 5a23277be4445..3a15cd170fe4d 100644
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


