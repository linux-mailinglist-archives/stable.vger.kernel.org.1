Return-Path: <stable+bounces-65097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C5943E5D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA452838CB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07D1A38E7;
	Thu,  1 Aug 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRv56J8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EE14A60E;
	Thu,  1 Aug 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472407; cv=none; b=fmWMO4fo4f39A8wTwo7qN9h+x0R9Lydi9MixmWmoEHGTxRjh+DZYk9ONW7S0ZQAI+3RbT7fW08m3dBiLCbQvBKoNyH3FcwCJx8nyWz7F7c0FG/ZvbqVR+N1Tf46MiIOTDoRuFUDwF8Sm/3lnReMIFOTNOvtBCI3qZODVsooqoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472407; c=relaxed/simple;
	bh=1D1azyMO/AXJRSxn65ynbs/u2AQ4meR2oYzI//XDx+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Enr3qIc2UXomPLscVlpHwEtK3f8SQ6zwCCqYtHNDVf7FCwAQ98hia7vVZNtxbgxzXRRbDFij8/PQUrb9x4h+WwF7KBYt/Jcx/umVZE2IZddkXkqyayCS2MpikR7nAAfeLtjXOtXFEK6ORqlAMSpVPbJnvMTRuvmz8xymyb7npmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRv56J8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0887C116B1;
	Thu,  1 Aug 2024 00:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472406;
	bh=1D1azyMO/AXJRSxn65ynbs/u2AQ4meR2oYzI//XDx+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRv56J8UL2viF+E6uX/43P00UqjIeq2CP7cfZPnvj4oIywXb6ODoVOt4zYlb/VmwR
	 PCJztgjX1Xn0R03D+4UNid3GMCUO0z637x752WfF1RmAfdQLnJHfcybL3iKt/+Q7ug
	 se2jy8vDIGLzmwwBhqJbJiL4clYandM5if7rZ7iMIEZ6Sh2Pb0eCXYmHFNuyPjOfuU
	 rNYeHlJjD20hSvP1+jFmkEILMxJaekVMwyj4u70sn7Ltc6y9BnPnA6w130Sx0KfoU4
	 EAHKAsGoc2oco6hgVb6b1iR6dst4cnZeSzKLMkswqauC4ZIlVVYN8Zjjc3nWrh+ZEz
	 twE6koJJPEQzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
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
	hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 07/47] drm/amd/display: Check gpio_id before used as array index
Date: Wed, 31 Jul 2024 20:30:57 -0400
Message-ID: <20240801003256.3937416-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 2a5626eeb3b5eec7a36886f9556113dd93ec8ed6 ]

[WHY & HOW]
GPIO_ID_UNKNOWN (-1) is not a valid value for array index and therefore
should be checked in advance.

This fixes 5 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index dae8e489c8cf4..a7c92c64490c5 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -241,6 +241,9 @@ static bool is_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return false;
+
 	return service->busyness[id][en];
 }
 
@@ -249,6 +252,9 @@ static void set_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = true;
 }
 
@@ -257,6 +263,9 @@ static void set_pin_free(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = false;
 }
 
@@ -265,7 +274,7 @@ enum gpio_result dal_gpio_service_lock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
@@ -279,7 +288,7 @@ enum gpio_result dal_gpio_service_unlock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
-- 
2.43.0


