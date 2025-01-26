Return-Path: <stable+bounces-110560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3B7A1CA1F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A843A33EC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAE1FBC9A;
	Sun, 26 Jan 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5LNLTnS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6A1FBC93;
	Sun, 26 Jan 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903357; cv=none; b=Lo+TyXdEqRuUkWDJcMUnV6w/rlqw9EPMnE1fH4Q2ZSUu3u6uhf0ziyVpaiR1HbYXu1fRWuCwBg5HebIzXMBQpZr3FrtL+XnS7RmvB29wjTrP/0GITzoAMV7MpY0DIgHiZhxzhULMH6bQSodVDsPOAV308yrj7Ao1m1BMwUBPCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903357; c=relaxed/simple;
	bh=BssESIkw06CVRogxAwU7ifDk0FhlJJHOfQEIwD4Dfbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH45+qjVXd5acn+r8hFdsHiYif2NhHD4LUZrGWc5FRVDLkRRoO1X+PPCwBBoXkYFL8jFM0JN9bsCYPGuic3kHclWEVBockCyQ5Hz1pUQZCRJc3VZFZUiaFfM/hFW1h1f69FOe5CD8gIJj4l3RvcENkfYG0IaZNwGIKxe6Mun2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5LNLTnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C264C4CED3;
	Sun, 26 Jan 2025 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903357;
	bh=BssESIkw06CVRogxAwU7ifDk0FhlJJHOfQEIwD4Dfbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5LNLTnStb2RPxb5dy0DKhYFKND8MJJhT65AOdGoe6jst64fVtQ3d1AqHLAYV/eqS
	 brKKl2da29iZzu5FSKE8PB289KUcpXPrA/f5l03NFgeNucWhAK13p0m4kookT3MwHr
	 9b/gaZ8Xyn3gtcOyZhijDkdgpIp79AnlKgFef3hrgI39nm+vaLKErOGu1sRvSkJyV/
	 HNlKCbZThcAEbnehJBF6hu9SrS1SkXGZbOUaTk84URuzMIzORFIa4698OydHIqSVk5
	 6FNO/97eifAKyze30UVKAXZg72I6+q1LD3bWvxWYEAhN3UYuoYFY9YPsz/M2VunMxJ
	 majDjB5K7tklw==
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
Subject: [PATCH AUTOSEL 6.12 24/31] drm/bridge: it6505: fix HDCP Bstatus check
Date: Sun, 26 Jan 2025 09:54:40 -0500
Message-Id: <20250126145448.930220-24-sashal@kernel.org>
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

[ Upstream commit 0fd2ff47d8c207fa3173661de04bb9e8201c0ad2 ]

When HDCP is activated,
a DisplayPort source receiving CP_IRQ from the sink
shall check Bstatus from DPCD and process the corresponding value

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241230-v7-upstream-v7-5-e0fdd4844703@ite.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e6ba2dcc4ad00..e8dac873a92c9 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2312,14 +2312,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
 
 	if (dp_irq_vector & DP_CP_IRQ) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
-				HDCP_TRIGGER_CPIRQ);
-
 		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
 		if (bstatus < 0)
 			return bstatus;
 
 		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
+
+		/*Check BSTATUS when recive CP_IRQ */
+		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
+		    it6505->hdcp_status == HDCP_AUTH_GOING)
+			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
+					HDCP_TRIGGER_CPIRQ);
+		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
+			 it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_start_hdcp(it6505);
 	}
 
 	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
-- 
2.39.5


