Return-Path: <stable+bounces-95270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6129D7647
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F350AB2B87F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086A1E764D;
	Sun, 24 Nov 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdKxrY14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF91E6DFF;
	Sun, 24 Nov 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456554; cv=none; b=XzRnIp5ShYVonCPe158HgDrf+eTp5AbOd7DE/JKXKMeydb+Qx3bgtonsUVYVIkCelbSvIp0rNEQySsrlEV/4moeAnMiKw6umYAPl9HFMElX8/1cdzl6AMsVC3xJERoiOqq4f0y8t9gAf5coGnpxgPVEbldprf57ygxIGrJDV6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456554; c=relaxed/simple;
	bh=04yNakbpqqGhkkZcOhhD+ztC5rZguONsJsQHM03BhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL8k46aj8TQr2HA2pkmEbVAs049zdshKc6++di+zCfXIewbOpic2rfg8PwC38HVLzA1KTq0kLSg5ZLUf6xTRCI3i+9wj2LbuS5YL6NZ9mDJoOL0O1HHjv5O89/rYL+DhtonTMOeil9ZmT8Gj102s8yEjHU1oM+eWtqfYk4Wen04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdKxrY14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7234AC4CED1;
	Sun, 24 Nov 2024 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456553;
	bh=04yNakbpqqGhkkZcOhhD+ztC5rZguONsJsQHM03BhMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdKxrY14Zw2J+7FJ/5stZcqBYDwZKMw9hs97eBu8iCzt1a8tmdzMdTm1hxG0o/n0s
	 piceb97Y+Xqa3kb6mN6FrN33Qa4HZYkqODWtFzaGEfPnoEKKW42UW3T7LJ0Vr8xkPd
	 p+ZaEgS+H3DJ0khxStNR0L7IaM0J4KuVdCIeovgQFHydmAaL7vUoUpxABaenrzs73G
	 3khbramtFco5+El1pk9OkxG7deusGEAEl6v7cmYK7DNNuM75xRbxXREaR+DqwueJew
	 sppJp0Vl+gM2jrbFsqC+1ZG+3HJlbjr5HNgakCTWe3KXIGPlvmPuAWArjgJ3GSgpPj
	 Zzp6wDxL1JEgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 02/28] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:55:02 -0500
Message-ID: <20241124135549.3350700-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 8a16b5cdae26207ff4c22834559384ad3d7bc970 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-4-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 82946ffcb6d21..9a767fbb86c95 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -533,6 +533,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


