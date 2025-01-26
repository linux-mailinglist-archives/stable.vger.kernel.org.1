Return-Path: <stable+bounces-110591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266BEA1CA36
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFF18842C0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD7200114;
	Sun, 26 Jan 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KObkwSBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A620010A;
	Sun, 26 Jan 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903427; cv=none; b=iPEJPwou7FXApkDcyB001ZOxAs2DR03LMa1BxAYll7He9P8lJ30D0GFv7dhSrJo4IewFdi22KW1yWPVpJRbUwnURBd2ZuUYjHzL66TZ04bjA0dqBxbouJafk/sd0yCPPnGKKT2mx3LGHEefJaKb+WAC08JYJ3jnrul8iGeDJmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903427; c=relaxed/simple;
	bh=6g7CHfgjfoyNzNGehf5JAgqB8HRn0chL0blw5JjxKGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKHHZKJpUwX4Q9Te0S/23Lbs3BZrZbu/qb+rZN/r6CqGvszu4wfcrFdP8U3Ur+41QYNFl/qCyUa43CogVZzd2t/RFrjYHUJ0vdpLyuTpzkaWRD1hOmQMs9Lf2xtNxWN3iceKsO2QR5ZhHB0IQKuUWhHX3dynrz1gd5uJHLv4c1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KObkwSBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A891C4CED3;
	Sun, 26 Jan 2025 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903427;
	bh=6g7CHfgjfoyNzNGehf5JAgqB8HRn0chL0blw5JjxKGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KObkwSBvDTZvK9Sxa3sTTafnDgcxEVRffpVPAzYQ5jn1QGz/tP3RY2VOsYVL5Srq4
	 pUREXVAZ4w11BMTJZtHbQxipjVY1k3vIhRNt5ytfydT2szUbGm083HaM7bBATg97i+
	 4pmG2/aQPF30g5yUlUepBq5XZO5Y/iSh4a1g4jqzXY+EwvwKR/jYF9C2mP6HvRJKSI
	 MwViFsmYLv0LD2eetjjJ9Ldw8m9QBflvPIr6wEDm/ZAMg7xpmEPLCYhd6wilK8djlF
	 iSdFWlWVZoDGg8HePC6xwdv0trywrVQwj6dB+S2MsRQ5VuAtrr0sp5/pkEA4OirENP
	 dz76N56Vp2p+g==
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
Subject: [PATCH AUTOSEL 6.1 7/9] drm/bridge: it6505: fix HDCP encryption when R0 ready
Date: Sun, 26 Jan 2025 09:56:49 -0500
Message-Id: <20250126145651.943149-7-sashal@kernel.org>
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

[ Upstream commit 8c01b0bae2f9e58f2fee0e811cb90d8331986554 ]

When starting HDCP authentication, HDCP encryption should be enabled
when R0'is checked.

Change encryption enables time at R0' ready.
The hardware HDCP engine trigger is changed and the repeater KSV fails
will restart HDCP.

Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241230-v7-upstream-v7-6-e0fdd4844703@ite.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 32c401ab72a60..9ef0ce2c2d14a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2069,15 +2069,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
 			     ksv_list_check ? "pass" : "fail");
-	if (ksv_list_check) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-				HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
+	if (ksv_list_check)
 		return;
-	}
+
 timeout:
-	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
+	it6505_start_hdcp(it6505);
 }
 
 static void it6505_hdcp_work(struct work_struct *work)
@@ -2425,7 +2422,11 @@ static void it6505_irq_hdcp_ksv_check(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
+	DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
+	/* 1B01 HDCP encription should start when R0 is ready*/
+	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
+			HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
 	schedule_work(&it6505->hdcp_wait_ksv_list);
 }
 
-- 
2.39.5


