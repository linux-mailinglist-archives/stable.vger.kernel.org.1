Return-Path: <stable+bounces-95202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8F9D7425
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2019A166598
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD519DF66;
	Sun, 24 Nov 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syWNvvrU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA671F95BC;
	Sun, 24 Nov 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456345; cv=none; b=QErnIc/2Y3B9z9iu/YMeeBxEO4/DON47sAJXwovgLrlnwyP+g9akU1YT0Ll0MYg2dYzmMDIUFJL5Wiylqv6f5M1WvpVUTXXv+heDpssH3T78465D2OQThai+T8cM5PE5wWBgdLPx8KP5ukCVGTVA9H6HLSW927Rnj4hqpUkRbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456345; c=relaxed/simple;
	bh=9JaCCIdUZHjSxva3xUAum/147aWyXEHfeQTyh23xfpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knb3W6YnPpYAkBd3eLpUIc+0UIpRCWwBLRJWlGCQmZODndE0fUueib/ofxMG17kDvEZJgtYTl/CUx2ftVHwPyEs0kXmkpv6/euJ7lsQOeWqa9wDQ1biIOUtyZifYgb0ruvszl1y0DE9Fd1nRmlowoxRogzdJeRn5BTtgtUSHtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syWNvvrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17682C4CED1;
	Sun, 24 Nov 2024 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456345;
	bh=9JaCCIdUZHjSxva3xUAum/147aWyXEHfeQTyh23xfpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syWNvvrUEczx3hKDzQC5u9lUImL0bcHWZXA5W7p4Yq+7LpuvLPgv8ehWrEDRxWRdN
	 0lyEdN9x10/PeDr2HXlLT2wtsovWkzvHvAZbVoHcP2f5RJhiiHtbJoeXH9l7ierA04
	 DK909fL8KHG/cMGIOt2pFZbKF/WqcNOspr6l09imV0qfZrsOJLMHzjNkZ0uuATFeMu
	 7Tiudhq/bUQmUxt4wk5u/AMDNB17IdMKI9RiJp8UiM6Ob/j4a+Uf0KnxgChCtmbIl5
	 SqM0KM9eEEuHEsGSu1nNutToqJw9cU6uyouxo8pMap+SeTq7/jxcclem0tSHZt7ohG
	 IWMGNfEwHZPQg==
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
Subject: [PATCH AUTOSEL 5.15 03/36] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:51:17 -0500
Message-ID: <20241124135219.3349183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index e60566a5739c7..be14d7961f2e4 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -475,6 +475,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


