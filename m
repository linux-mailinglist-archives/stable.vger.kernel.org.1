Return-Path: <stable+bounces-95016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE759D7247
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0FF163DB7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648D1CDFBE;
	Sun, 24 Nov 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tblzdnQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D11F7091;
	Sun, 24 Nov 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455689; cv=none; b=rWwyJZOwUX8QkmoWRbTaniTDgB6wjkL7LQIfTmshk1fFl3KFOROQPyQbGHzCxCzcebJnIsYYkaYpwEpELHlOpWMfwJn3XqTYv2crO/pFW4AV0PseszL7lTzgb9oSDAXQOV5zi3/lvPJBG2nE8BNUtIw+Tz19AvxuhDY30IAylCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455689; c=relaxed/simple;
	bh=oSIQvle1ew5pN7VwVsVScLef5rxVvT1ygF1+neTcx7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihEuy79DF6XIA7ggQrhQrNyGWDZdPsl/1qEvn8Cu3AbqZvz0k/AsX3tOHgmiY/uZnTBPgEf8yRCrw8Df8IlYIoZ6iz1qfOGcrLfD4Fa2TCZqN60lfFIGwl+y+YkiChJSJzLMW89NwUQZMTvceQ5/mKdyxHkDdHrELAqxV21Tr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tblzdnQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34DC4CECC;
	Sun, 24 Nov 2024 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455689;
	bh=oSIQvle1ew5pN7VwVsVScLef5rxVvT1ygF1+neTcx7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tblzdnQK6RIfUYPaSMzX1hRJhnoGS1bwDkIQx9QSERGQ00xxY6YXeSMJZ9gcWVlIE
	 YNa9A9db4Gm+8nlfdJli108ucK2uaQSNeXbleQcKog2V7f5fVeQUcMpe2xVR0Y2rAr
	 jBOlohSAhR6OwUb+iIqOdOCFk/uHpxkMHlkNNju0RaBaptqGw3DR5CUibD6ZiiFF3O
	 XCVuzJhA/6LHZtczywl8/9ZZ+NPD7AUV5CxbHHa4GyMnYwEmnIpT17JxpSSgbiaqB2
	 6B6RmooEeZq2ewtdZF3P3OyH9pLdojAte+AQUTuPDad42K2OxpZ7vyoZltnP7xLsaz
	 jOw5WkEr2QoJQ==
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
Subject: [PATCH AUTOSEL 6.11 13/87] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:37:51 -0500
Message-ID: <20241124134102.3344326-13-sashal@kernel.org>
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
index 10c06440c7e73..f1bb38f4e6734 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -473,6 +473,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


