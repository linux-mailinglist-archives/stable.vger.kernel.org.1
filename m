Return-Path: <stable+bounces-95157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FA9D73C0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F448286E5D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38461E0E01;
	Sun, 24 Nov 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZPr1GqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CC1E0DB3;
	Sun, 24 Nov 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456202; cv=none; b=MdPj3PCOYk/WAiXt1TX0YHBt1RXCVQM/R79Rkp+x6sh93tj3vf6j3Juulu2LI1X83ra3KwaYljm9b8S8JRuaZ7cG3qsLHVvtTO6f0X1oSF67eaDSrImtc//bTsN6vGT9bE+V/gyVMPWkFxBw5qQvns2WDv7+eG1K7XaQbKJaSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456202; c=relaxed/simple;
	bh=BO9i52WUyEz3+PWjDfMnShY+uRRX6tv+ECx6VexPcBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHj/qlbm7WeHHGkdxOXiW2xbVjy7qKI6tWetAWB9E7avDyii/hgiEfjszvYJkXxJzSjcAkCN234hID2vbvxZir4EDD5+7Iu6vH+L+ovVU64MXErV3OtcgYZGFz0tLaqVRFaWfLQxAEYzTYAelVVt/hmwE/YUZMbGTwBmKXkoeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZPr1GqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD268C4CECC;
	Sun, 24 Nov 2024 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456202;
	bh=BO9i52WUyEz3+PWjDfMnShY+uRRX6tv+ECx6VexPcBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZPr1GqNqFW4GsjU823VK2urGu7tyqdWh0Tl75f6y57uf51LWDmOcW/+I2Ont8YEx
	 p4WgfGW7myP8oD/fTEKFXKexEBhWohaY0wUI2zeMEMvulTrBlZEi+PihXQoaCiX0B5
	 I2zAVFPmrMdRuCtXcsX+KSKN1bO0RU280psKF/zTrqIKHgdvBD0EHLaY+s5YKl/Lyg
	 /88bp8BAts9UzS2g7kB4sZKwXHRQoAIufLg8IdkO0QMRN6Qcn1H/T5+XdkFvLHKRfJ
	 S5JmbS4LeMx08dcKMxHZOU4Gncc1gcdtj1/HJaEqmvAcpDvqGdWfJ6x6+RmP3DAN+0
	 eHWENsYfauxzA==
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
Subject: [PATCH AUTOSEL 6.1 06/48] drm/bridge: it6505: Enable module autoloading
Date: Sun, 24 Nov 2024 08:48:29 -0500
Message-ID: <20241124134950.3348099-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 292c4f6da04af..6932e7364d90c 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3349,6 +3349,7 @@ static const struct of_device_id it6505_of_match[] = {
 	{ .compatible = "ite,it6505" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, it6505_of_match);
 
 static struct i2c_driver it6505_i2c_driver = {
 	.driver = {
-- 
2.43.0


