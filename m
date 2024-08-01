Return-Path: <stable+bounces-65142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC0943F1B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715402832A9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED911BC091;
	Thu,  1 Aug 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNC4MY/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4341BC085;
	Thu,  1 Aug 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472625; cv=none; b=Rwwwz2bBHogPG9W6Sb6NhlJD0QLqHF6oziO3XXOtJ0rkVk9gSoJqMuXx7h/n7t3Cd/LVMWJmA4PT35vShJc9uiAfFiBKSHyzJKIz5ZvBriqk9m41ASoWI6O+jxcDwHMpERKGcWzok1h4NntAFLfUfqB/jzenT8tO3OsO+LQBOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472625; c=relaxed/simple;
	bh=1D1azyMO/AXJRSxn65ynbs/u2AQ4meR2oYzI//XDx+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YofYbTdrSmFwoH6Fit/j+xnAKuBGsdQhNTTTIu84N54Vu+6LdQEJwbrRZs4PA/k86Hs0cMMLCtTbShZIenyh1Q6jXZyDDkLofg8pasEkC1VSXLyPL1GYtcjbP+p9QekKfvKhL62RVOLVDH9i4G1DL7ghlJ+j91F6+bJnxIakGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNC4MY/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536EFC4AF0C;
	Thu,  1 Aug 2024 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472625;
	bh=1D1azyMO/AXJRSxn65ynbs/u2AQ4meR2oYzI//XDx+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNC4MY/rLmW7t9NPSW0U10Bc1EUzkrGyHo5S5N+ImtT23OSeh+EyvhJ/7HDEwekwu
	 JXsV/nobxk3JB3JWP7Ak/s0Obvu8VVzSB20fF2CWfNAWY9qC2XRSZstGC+xK6T7nuT
	 appZv+8PDpjdIl7UcgtiprMKxEv9tWuM3Y0o4mh9tZBpMRwx9gOp0r59B4/mFML0ec
	 YSGUf4f4jsEpdiMLo2o4Z4Fhg2hKJQaQn0LyClQvrcN8hBOHJw5yxuoZjegXtPpIJ/
	 O6gkbsRdEGdXEKixPENFVcGOJr3vGf2BR3lqcrgph876hNvXxDISeU8Kw3gGSbxMTs
	 nXlANlB5VBcRA==
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
Subject: [PATCH AUTOSEL 5.10 05/38] drm/amd/display: Check gpio_id before used as array index
Date: Wed, 31 Jul 2024 20:35:11 -0400
Message-ID: <20240801003643.3938534-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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


