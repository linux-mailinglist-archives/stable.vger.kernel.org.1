Return-Path: <stable+bounces-95097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1C9D7592
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5DEBE2E86
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE82194AC;
	Sun, 24 Nov 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDKav+nM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B9219485;
	Sun, 24 Nov 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456010; cv=none; b=HIUSFPR3a+xevPFezmC6OATOgVbTxhiEFaBzNtiUEZeDgCL9/o2fI2po2K5m5qXlxcjBpzQ6GIm0+Uqf9mvD1f5zI3TEdfA+D5M3z5BtbkD4Uf/AFmho4Fi7nl/31L39ytZ3KQkh8bvVumw3kVJvA/q+SEn5OzhHisCdn329pE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456010; c=relaxed/simple;
	bh=amtzTJK3tFhkO9J6qjF77+DPWpImNhAeciDK4XQqCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub8L9m3vt4ixOcfxFq6U8E+z3ghkAMXEF0eqYezNkgRMycBxUCUtipN7HuhK/2OQpSkyg5Jolupv5MiYzcMzWuhIIV3jtnAcyw7CscRjUWr0IqNu4k2ZoCBBhGWY7y8xN9hNjtHVdcSkARdaN7WUkc5J5eUefMRgPVphVKfDiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDKav+nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C93C4CED3;
	Sun, 24 Nov 2024 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456010;
	bh=amtzTJK3tFhkO9J6qjF77+DPWpImNhAeciDK4XQqCXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDKav+nM1cnPJ3XstarVsnSnIkZkROvSu3NhP8HzvrJk0JEGUTuWnfF1s/Ps2HKoB
	 9iJa3gWw2jjEKKZv+JKBqiVbMrrU0czOACDQv+pgLLPvbjWbW+em1b+r6wV9OTNC9L
	 134KOdlWjaOmqVcTFovxDSAjXhf4h/DzE0rtPuLQx+yCl9Fnp/TWboRqIHU5KQeQWp
	 uwsGZ4ele2YAVFkrOukQ3axPH8xWUbwyz4TPkN82Ure/nZIBxiccl52gPFYZnBkg+t
	 t9C+vY6EXpZMjzvewNb+bIVqsduQhIRbjIjQ7Zkz0flMa3dzZrls4G/gVjGWg972Ry
	 vq8yr3a3aWEpw==
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
Subject: [PATCH AUTOSEL 6.6 07/61] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:44:42 -0500
Message-ID: <20241124134637.3346391-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index a2572fb311f08..753f261dad678 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -465,6 +465,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


