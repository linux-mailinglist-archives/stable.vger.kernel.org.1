Return-Path: <stable+bounces-110563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D6A1CA2A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CA63A924E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8711FBE9D;
	Sun, 26 Jan 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRsXVoUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF81FBEAE;
	Sun, 26 Jan 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903363; cv=none; b=Sl65J1orSekjtR2mW3kDCOmgEjHrD1/PDfB7K7f9EE7yR2EYMgxZQxa+xFF7RfqnTu/eYcEjzl64twnbQ76pOKS3u9XGtgxW5B9QkuK32SVADCHwrbDsDETAKm8hSC6wxgTh/2udWMhEOdF1gTk1FQd7/JCUmh5MPf62b/0RzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903363; c=relaxed/simple;
	bh=eckG5toLTQPqqD02jkGSCRDr0Q0LbjtdTQQ2/RBc5bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ry/5sHX+mqsZZnxlqY/KMsDYJ96Uc6EfWUvEbpl0pp//pgO02LqFyvwYJDZcY79MvFcLTZ7CNR3ACD5BRUbL9wLVBz6Yw5gV5ygHanV8CUbx0vR92cMatEUejuO9OOXeZqDPdEivM4OGkQxrW07jYAq2rgTNO1vb7gjEhKB0Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRsXVoUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A7C4CED3;
	Sun, 26 Jan 2025 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903363;
	bh=eckG5toLTQPqqD02jkGSCRDr0Q0LbjtdTQQ2/RBc5bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRsXVoUxql+Pye6XqFHRXn+I5zNYwWfXh68tuvjSEP9/CEIF/s4wdK70k9r3ePc2v
	 UbAeJEtlJjfeH2j710Hwdb/tiIzdT29MQk39HZ05lEiVH3pS3zCoQhcUbLZKcDC/wl
	 F5rOfS1Gya4lZOhpqtkfKHRSFVshB7r/gjirjllpBgX8pN0mmg3yPb2O1U5Fz2yA/I
	 j1CjgW7YQ2D47lpqG1z2F7LP/LSaKPFU3h8jQL3oiHF6H3nc+7ZEmjgPFCiLDWhV3T
	 ORYoIOijsoyksL4TvNb1pV2+YTdQQBt14zp9cjye8NSVXf2KijIvYgbtGtfUU42URc
	 mzEFl/qLVEwwA==
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
Subject: [PATCH AUTOSEL 6.12 27/31] drm/bridge: it6505: fix HDCP CTS KSV list wait timer
Date: Sun, 26 Jan 2025 09:54:43 -0500
Message-Id: <20250126145448.930220-27-sashal@kernel.org>
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


