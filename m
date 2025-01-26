Return-Path: <stable+bounces-110532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C028EA1C9AE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C5C7A3168
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694301F75A9;
	Sun, 26 Jan 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGgeH8Bo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3017C21C;
	Sun, 26 Jan 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903279; cv=none; b=JZ5Qud54JfAO+Jfps8BcQtMdF9CkW8uk3BZF4dW8CPRPXcG05HxMng6XPtTOVOVdrmcSHznXyboxe5TYmSToZiEknTG33EjLOgNDhr3Wnk02GiLdTMKHgo33E7ZFnfEy+Y5w9bEdyTDdpVhE4tWjOMwO2e9A2kk+tZd3Sa2o/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903279; c=relaxed/simple;
	bh=eckG5toLTQPqqD02jkGSCRDr0Q0LbjtdTQQ2/RBc5bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAYEcp7j8eiK0ia6u0pLZuVQDa/MZu2j43ja1BDSH8yJWfswNhuyLj4vowgb2B1MJAfnhpnGhYFy4V1SnNzeKevXStiahsmB0XWBmmQVzChoSvUMUEpdKs6Y+N/qM2wwh3R1ceg9XDSO2c1kL2VPgYYGgn+giJxSRdv3Rf6TsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGgeH8Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ED3C4CEE2;
	Sun, 26 Jan 2025 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903278;
	bh=eckG5toLTQPqqD02jkGSCRDr0Q0LbjtdTQQ2/RBc5bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGgeH8Bo7CWpr7tECTmMyR/8TMxY5ywbysc9NOUbQZhrxE3uL7VvP6tooxK3ln7j2
	 t+HqK4PzCG0LTHfxquWTYqFnXGQbj+INkRmf3SiG5OMdNmbKoz2NObzhWbT2GSRUHu
	 wP09X6cA2I3DHo94MZ1Vw1mmR41982Q1Tz9DysLKDGz7FbKkbtat68SbuIDPjM2fAs
	 MppUfWbcJvvalCafSQLzJAuHTrT6l/VHe1GmJTOWRHMBN3kU0fJecnAYTLNL34/N7T
	 p9WblF5W6MPpZtB0NYLtpTOZpvVaJ121SqNmd0kb8bj52Y38+6KnJoSr9y0KfXg6rg
	 vQZngN2uxDcwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hermes Wu <hermes.wu@ite.com.tw>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Subject: [PATCH AUTOSEL 6.13 30/34] drm/bridge: it6505: fix HDCP CTS KSV list wait timer
Date: Sun, 26 Jan 2025 09:53:06 -0500
Message-Id: <20250126145310.926311-30-sashal@kernel.org>
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

From: Hermes Wu <hermes.wu@ite.com.tw>

[ Upstream commit 9f9eef9ec1a2b57d95a86fe81df758e8253a7766 ]

HDCP must disabled encryption and restart authentication after
waiting KSV for 5s.
The original method uses a counter in a waitting loop that may
wait much longer than it is supposed to.
Use time_after() for KSV wait timeout.

Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241230-v7-upstream-v7-9-e0fdd4844703@ite.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1daa069d71f73..427b32aee6ff3 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2061,12 +2061,13 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     hdcp_wait_ksv_list);
 	struct device *dev = it6505->dev;
-	unsigned int timeout = 5000;
-	u8 bstatus = 0;
+	u8 bstatus;
 	bool ksv_list_check;
+	/* 1B-04 wait ksv list for 5s */
+	unsigned long timeout = jiffies +
+				msecs_to_jiffies(5000) + 1;
 
-	timeout /= 20;
-	while (timeout > 0) {
+	for (;;) {
 		if (!it6505_get_sink_hpd_status(it6505))
 			return;
 
@@ -2075,13 +2076,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 		if (bstatus & DP_BSTATUS_READY)
 			break;
 
-		msleep(20);
-		timeout--;
-	}
+		if (time_after(jiffies, timeout)) {
+			DRM_DEV_DEBUG_DRIVER(dev, "KSV list wait timeout");
+			goto timeout;
+		}
 
-	if (timeout == 0) {
-		DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait failed");
-		goto timeout;
+		msleep(20);
 	}
 
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
-- 
2.39.5


