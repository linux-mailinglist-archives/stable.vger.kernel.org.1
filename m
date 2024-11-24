Return-Path: <stable+bounces-94909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF89D7091
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF02162210
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A671ADFEB;
	Sun, 24 Nov 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVRTAI31"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0921AD418;
	Sun, 24 Nov 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455207; cv=none; b=EafcCCp6HIl3uHd3mWxsgvXkVCAIbSYRNTlv8tpJuuLU+txnsxMI2gIOUMpskDs6JRLUFwl+8xJsq+eG2Pir7Pl/YWYX33MqdDfx2qN0/U1T2MCFOjuB2aa+XackMmrBTJbNvJ+nBXWmh9UZJklsovFqMA8IM7V+ODJ/nihgsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455207; c=relaxed/simple;
	bh=jO5AzJo3i7bPYqNrNLSIMrs9XWl0JmO16EcI/YiPGms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udyeO5m/1G0srDG9ZkKyIBVh+ZbueckPmOiBsbY+i5saFidMNU5Xge+alSseoZC1kDOawONAlRIvWkgcGgFm3PDDfL6CYPIpeqby6Hc4FgPnxOwJuM4y4GlD04BOdxuv3NngoftHaWzkqDIlRuG1o94bIv0Ur/KaUKf/NXGqbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVRTAI31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC25C4CECC;
	Sun, 24 Nov 2024 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455207;
	bh=jO5AzJo3i7bPYqNrNLSIMrs9XWl0JmO16EcI/YiPGms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVRTAI31Z7AX7GfLl5X9kp/EVcRFD+q/MBaN4jbeaGalu8OeAs7LkUkG8d1e1LRWR
	 BdfJTyYKKpysHJYgjdfqRccGw40uVgrUCe1I+8Ev0gn8Sb8uflnBnXIn2BpzoDK2bL
	 LLZ17sfJ1otnQvZW8F7l8SkrPay0xizp/d3BxVHldZyHc0Q4wOTFlQvk1yD+0giUZE
	 LSmaelZTdNJXuo6+eH8BGGzaPg2L3bx68/DjFSLrPfC8axV2JRbQvGMyUYEt6A8M27
	 85+7IAJSEGrGgEjOHvBQNO1petLnwZVECSpaAEWE5jTsyHMSB4pPTNzXFkOafNp3SH
	 Moiw/WM4dvOag==
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
Subject: [PATCH AUTOSEL 6.12 013/107] drm/bridge: it6505: Enable module autoloading
Date: Sun, 24 Nov 2024 08:28:33 -0500
Message-ID: <20241124133301.3341829-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 87b8545fccc0a..f372c05360f2e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3505,6 +3505,7 @@ static const struct of_device_id it6505_of_match[] = {
 	{ .compatible = "ite,it6505" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, it6505_of_match);
 
 static struct i2c_driver it6505_i2c_driver = {
 	.driver = {
-- 
2.43.0


