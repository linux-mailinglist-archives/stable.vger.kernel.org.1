Return-Path: <stable+bounces-95031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C79D7265
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07C6164533
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EE1D3629;
	Sun, 24 Nov 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slA+J4u0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDF1D416B;
	Sun, 24 Nov 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455770; cv=none; b=rauAb/ap5VsDtP+oZTf6ZOcoByU5Ma1RYRGktu06M18mIC60BbdGjgKQk7LGiLyLli3q7WgoAZGGWXShHccNFoTzg8pXGnSeIXTaKkhhw1TM8TFiABot95q28lj9Glzw3h2sbHdx7zez1q39UC6veBc2ba/+fP7Xehizr3UZZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455770; c=relaxed/simple;
	bh=F+p26doWYpDgZEoHldUcIHGk7EkIGKnXv5DpO/XzrC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxE2k095/s5mBAgoosLZzwalzXeMxR/ZmKZ9ftqlWmBAa9TMxypyGL2gVhmg3KRvsJ49iGPh4IKEC1zs4yPNzVmMmOIW/cvBChcwpbgYQvRvR4wIP9fY5NWa1D4Ma3T25hHrtQx5Tp4zl15gbDzzfKapuL7QkBzaWtVPkylxUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slA+J4u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F23C4CECC;
	Sun, 24 Nov 2024 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455770;
	bh=F+p26doWYpDgZEoHldUcIHGk7EkIGKnXv5DpO/XzrC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slA+J4u0w2J5tbu4jLYJ4QVAC3FelYgC2PoUS4jYekhdFxeSQnpvd+Sf2ZGad2czX
	 NzNTjNGy8I8OUSIYam3ZeLn0o+ds4/n8HjI1nQPGANjQZibbc2DGmBzEtI3TbnVppw
	 gP/JFoxWelfe7TTUw2ZVUCxcc3E3ljtviJBVh5B/7f6CePSp7hLUohnkOx7929SWUD
	 269QccOwSlrd+yG36X/KRtcr1LfK8z8AO5bIEZLkX/YvtpUeYkNRx+DQ/y8EuaVwC3
	 3+tr53ek7RZsRPeuzOa91sAU9A3yNjC4Oe4dB+Wsinyoowu50A7l65iWWuaAEsh6RB
	 CiWGrVRS0Hbww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Chen <leo.chen@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wayne.lin@amd.com,
	alvin.lee2@amd.com,
	dillon.varone@amd.com,
	srinivasan.shanmugam@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	Ovidiu.Bunea@amd.com,
	Roman.Li@amd.com,
	samson.tam@amd.com,
	anthony.koo@amd.com,
	zaeem.mohamed@amd.com,
	chiahsuan.chung@amd.com,
	ChunTao.Tso@amd.com,
	Syed.Hassan@amd.com,
	aric.cyr@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 28/87] drm/amd/display: Full exit out of IPS2 when all allow signals have been cleared
Date: Sun, 24 Nov 2024 08:38:06 -0500
Message-ID: <20241124134102.3344326-28-sashal@kernel.org>
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

From: Leo Chen <leo.chen@amd.com>

[ Upstream commit 0fe33e115fec305c35c66b78ad26e3755ab54b9c ]

[Why]
A race condition occurs between cursor movement and vertical interrupt control
thread from OS, with both threads trying to exit IPS2.
Vertical interrupt control thread clears the prev driver allow signal while not fully
finishing the IPS2 exit process.

[How]
We want to detect all the allow signals have been cleared before we perform the full exit.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 6 ++++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ded13026c8ff7..c46100c83d0a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1291,6 +1291,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 		memset(&new_signals, 0, sizeof(new_signals));
 
+		new_signals.bits.allow_idle = 1; /* always set */
+
 		if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
 		    dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
 			new_signals.bits.allow_pg = 1;
@@ -1386,7 +1388,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		 */
 		dc_dmub_srv->needs_idle_wake = false;
 
-		if (prev_driver_signals.bits.allow_ips2 &&
+		if ((prev_driver_signals.bits.allow_ips2 || prev_driver_signals.all == 0) &&
 		    (!dc->debug.optimize_ips_handshake ||
 		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
 			DC_LOG_IPS(
@@ -1447,7 +1449,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (prev_driver_signals.bits.allow_ips1) {
+		if (prev_driver_signals.bits.allow_ips1 || prev_driver_signals.all == 0) {
 			DC_LOG_IPS(
 				"wait for IPS1 commit clear (ips1_commit=%d ips2_commit=%d)",
 				ips_fw->signals.bits.ips1_commit,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5ff0a865705f5..a11bfef3ab50d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -743,7 +743,8 @@ union dmub_shared_state_ips_driver_signals {
 		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_ips2 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_z10 : 1; /**< 1 if Z10 is allowed */
-		uint32_t reserved_bits : 28; /**< Reversed bits */
+		uint32_t allow_idle : 1; /**< 1 if driver is allowing idle */
+		uint32_t reserved_bits : 27; /**< Reversed bits */
 	} bits;
 	uint32_t all;
 };
-- 
2.43.0


