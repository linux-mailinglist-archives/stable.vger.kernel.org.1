Return-Path: <stable+bounces-64962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C7943D08
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37682874E4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9334154426;
	Thu,  1 Aug 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHql4OdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BF153824;
	Thu,  1 Aug 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471752; cv=none; b=ajerRACM3aRzREnM0teyLR+q7EnicTfdmXZD4MN8BjklVJMB9qSpfYpHdQR6VF03h5GMPbiyD15SmOm2LwkMPUv29ETzNKWagEvy4Gv4HUzHmNujmWkEzC4Lsqp+Wmt+nyE+ArV6s8QkRURU3YUBwtTFUYNuD2jeMAHfIsuu58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471752; c=relaxed/simple;
	bh=8Cx5YxP0p8yCWtM9LldCAc2RHlHB0BD+5/0AT9HxaVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPfMpjQtPv5WyKNUg13Ra/drj3DDmnP6FAs/RKvnHK/6QOkB3xs5bRJ6R1DwTE/me8gqycp1jmgbZvN17P2oqB8H+MFiJIjamkdOIVK3C9kMM0nZ0geJ3uZ06LqxwlzYKG+O2PM5D42ZR4QRXl+oG1cpyq8VcbUhzTEVVEB8uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHql4OdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D6C116B1;
	Thu,  1 Aug 2024 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471752;
	bh=8Cx5YxP0p8yCWtM9LldCAc2RHlHB0BD+5/0AT9HxaVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHql4OdUnGhJWfpG1wY45LpOo6oGTA1z2FAd3COG3WkAZ6fJVcXeVoJw6/qq64sOl
	 //ufP7aywkFrqGTwLQzAGTK/yToL4XCnvf+cEUQzIRo9rInyOR1yixUSlu+fJ9HibW
	 kFL5CHmQjNCZ9VFcSfNwyDGhzsaZRyGqKwWr2In3n89HdSKWjfGVfSudn3UT94v1Fs
	 Wbr8lDl9vGthVBNr6YawpdapJ44Ro86LTNKgnELneJj0Mqhl5UyEcaei3pXoYgMbW0
	 Vk8EQROyjjvGmcicWVEvqz+UEyABA86ncp7rWkUj/1fPiCXjV9jqHdMKrHePQESrLt
	 +Z0a46U+Enu8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 16/83] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
Date: Wed, 31 Jul 2024 20:17:31 -0400
Message-ID: <20240801002107.3934037-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit c6077aa66fa230d12f37fef01161ef080d13b726 ]

[Why]
For subtraction, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change variable type to int32_t.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 2f8ca831afa2b..f2037d78f71ab 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -56,7 +56,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -112,7 +112,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
-- 
2.43.0


