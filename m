Return-Path: <stable+bounces-95015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6983F9D76A4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AEB65370
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867B1F7080;
	Sun, 24 Nov 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBDmE1eU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBE1CCB50;
	Sun, 24 Nov 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455688; cv=none; b=GczjEV8+2IcAhIBheG73M1xmJnEECCHnYu62IGdYOSq1zQDPrqTnXSGtZ1Yoa3YLRgq8VpBHMZxIwCKWp7XSofjXpk4AVSa6+TqskRo+lnBJjnZgw7j5KxM+bKJcmtnpCtCLrngdBQd6cw6/LpFHDJ+yjff8jYH1rM6YulkeB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455688; c=relaxed/simple;
	bh=+mgO4zxazPw6puBzlIsxt/P+iinaBz3zCv4Hm76Re7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaQsjE963CSR/9Z67dcE+fd5CW+jdxoQ2kY/nNkdyY8RT89GCTWA5cRMJ1NKaXsfB3i7AuLJw0U1AGUbUtaeHyHmfR2SjPoKbiiwVb27ceINMzwqkNYXEaTPWb2OYOhAtQ3zrui5e+hnn8aTDHvYDlMATVUXCBBvWKnEarc8PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBDmE1eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22317C4CED6;
	Sun, 24 Nov 2024 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455687;
	bh=+mgO4zxazPw6puBzlIsxt/P+iinaBz3zCv4Hm76Re7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBDmE1eUQ+fEZF8AyK+fE80MMYLYbNbRUYC9N0vFGR1bcjz89pN1pdv1JSyoIPW8K
	 ySn3Uqc0U0XYKXGUN2KHisZl9FYd1ddAZCE8yqpA1WEN8sOKqyIv7KwVoXNHeZbosR
	 gb5fpL2jR724Yg/4+24yejwAGqDM4ms1ifnjY46NZqxW994YlgHS9aiL5Ym+XI0sMF
	 ZM0BTPtnavNVpuLS4HYdaCdFy3s8NM5WSRDIbnKxTX8Wh4F/5hTr1CyYSqEXOxbbdK
	 4Sn38A7IfdEKJ9b6xXkYo6zmvJBcMis1yC1S95G+F2FlNw6omIbQDa6NKTuK/XgVZq
	 h6Fi+5fKrXQWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 12/87] drm/bridge: it6505: Enable module autoloading
Date: Sun, 24 Nov 2024 08:37:50 -0500
Message-ID: <20241124134102.3344326-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 1e2ab24cd708b1c864ff983ee1504c0a409d2f8e ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-2-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1e1c06fdf2064..eef5ad449c16b 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3498,6 +3498,7 @@ static const struct of_device_id it6505_of_match[] = {
 	{ .compatible = "ite,it6505" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, it6505_of_match);
 
 static struct i2c_driver it6505_i2c_driver = {
 	.driver = {
-- 
2.43.0


