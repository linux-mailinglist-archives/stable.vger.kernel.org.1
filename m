Return-Path: <stable+bounces-64953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B21943CF2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D4E1C21DD8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7412DDBA;
	Thu,  1 Aug 2024 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwsYS3la"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6212E1D1;
	Thu,  1 Aug 2024 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471701; cv=none; b=aCtp22q2GGcoeR8TvuNezIgmW4fPwrEi8FE6kNxZQ/iD2pYTGLfkX9BzSofJwfBwt2Q6Caw/Pz1OgktJQYQzzG6nMdKsmPWHxHlLO/v3WLb0R54WOcyMA/UevpIudutgKRrAd/NmfRj7VruJYAUnU0GKEQlPWRboz1TKqD75g9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471701; c=relaxed/simple;
	bh=QguivRKLzoN4BQOA5XDtIusgbfj2mBLpHJgCyBWtxiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kflxd8pW7paPTTHMLdkO2rQH+B74dUK5IIvSfP4dL7Z3p9Fh0V4+/91slXmCZnwcmHHHmr9rCeq/Q2rXsysuyQMyFN+jAJNr20LkWtsn0feog5J4XUuCVFdii7kWtoDePkMPz6OCYjX0m2l61ScrHmo3U9A+RLco0B55Yi4TJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwsYS3la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B52C4AF10;
	Thu,  1 Aug 2024 00:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471700;
	bh=QguivRKLzoN4BQOA5XDtIusgbfj2mBLpHJgCyBWtxiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwsYS3laYb678pQLc0s4IvJzPREB0EQer3SOmGFNNSv7WOR4es1RD298NTE8aPlmj
	 9YcjoxSmE3ubqLHzWLhVYuFFFeZn9f6c5ECtozdp8asaECZr0kDqVFbbvGuGkSZpdk
	 XGI5GiXqc0xzGt8V3xDmIFESYJ/aePp6kWZJCT55NT6faXjY7FKfgqJznDS9zaAuwx
	 PwOIwQXlsuvL/cFSm2pn2MCTHhreH13M5yHJJsCVIfFwlHJuqeeTle+tOnqClfmkda
	 gzDvEDJpOdu0IDwY4x1zPN1vvDiIDYrpaHR2fTw3/i9jJlQKSI5bz573MoW7obgXNq
	 y+2v9sqREYKsw==
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
Subject: [PATCH AUTOSEL 6.6 07/83] drm/amd/display: Check gpio_id before used as array index
Date: Wed, 31 Jul 2024 20:17:22 -0400
Message-ID: <20240801002107.3934037-7-sashal@kernel.org>
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
index 3ede6e02c3a78..2f8ca831afa2b 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -239,6 +239,9 @@ static bool is_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return false;
+
 	return service->busyness[id][en];
 }
 
@@ -247,6 +250,9 @@ static void set_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = true;
 }
 
@@ -255,6 +261,9 @@ static void set_pin_free(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = false;
 }
 
@@ -263,7 +272,7 @@ enum gpio_result dal_gpio_service_lock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
@@ -277,7 +286,7 @@ enum gpio_result dal_gpio_service_unlock(
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


