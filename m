Return-Path: <stable+bounces-94930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F529D70F2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6191629F4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BF192B86;
	Sun, 24 Nov 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck1zLRPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA019259D;
	Sun, 24 Nov 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455307; cv=none; b=A/eIXHpn7yS00TP734sRh+aYtpsJ0q3LsVCDvXfUFnnnB+a1PMqQ9sSO/4Y1Iw0VmVFra9R/OCQEfZnfF9zwrdKHM+nq1Qzd9HXVK0sbm1jAz3k1WosCiU9EuSCZliYykQq0eD1yuBi2qZoltJJcuV+AyvCfPJpSUxyq+abpp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455307; c=relaxed/simple;
	bh=2anxHsz/SZySMW4OBHpARWhGlY5VdP5awuCbrZY+VmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU0gOJ8DC9cStPTCZKvSBJLNYElHFOs0ov14Z9+QvJa3s3VTYyFJGxhzEuqc+dmN1PbeuP0tTPeUUGZpSPs/9qOncHdvSZPfLuFy2u380tZrta7LDvfMBLEp2DEMIGuGu/RakyCQqO38z0JDcPMczOAKj5ceVK/G8rzg2kNVNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck1zLRPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F81C4CECC;
	Sun, 24 Nov 2024 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455306;
	bh=2anxHsz/SZySMW4OBHpARWhGlY5VdP5awuCbrZY+VmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ck1zLRPs9tOH5fq21JIiphvThtNmH+wkYya+LFx1mHqau0lSK43Xfr/9ZY050UdMZ
	 Ty8l5zHSKZfVZVUpTRvklw95HsuiB9irkZ91jjsESIerCjKXspqrKv0BoFhgLPT6Rl
	 veQRYr8cFI+E9OeAKnzhgEZE80+VnpGM9dJ96xspoFRNr6o7nITu4bS4MdrRU1cGly
	 oQz9LRGcOvyHZNdVBqTAvk7xmkbQ2qzPxhCIUgD4rmpj6Uw2X26PmVoSFRs6JDZ9uj
	 IBe/I0G55HwhcdX51foupM0zN9tHZdhh7qndvEXvEWKNkFGtC6cZ3dvuOTNuGabzj4
	 Qut6qYHd6Ngyg==
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
	alex.hung@amd.com,
	srinivasan.shanmugam@amd.com,
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
Subject: [PATCH AUTOSEL 6.12 034/107] drm/amd/display: Full exit out of IPS2 when all allow signals have been cleared
Date: Sun, 24 Nov 2024 08:28:54 -0500
Message-ID: <20241124133301.3341829-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 1e7de0f03290a..ec5009f411eb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1294,6 +1294,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 		memset(&new_signals, 0, sizeof(new_signals));
 
+		new_signals.bits.allow_idle = 1; /* always set */
+
 		if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
 		    dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
 			new_signals.bits.allow_pg = 1;
@@ -1389,7 +1391,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		 */
 		dc_dmub_srv->needs_idle_wake = false;
 
-		if (prev_driver_signals.bits.allow_ips2 &&
+		if ((prev_driver_signals.bits.allow_ips2 || prev_driver_signals.all == 0) &&
 		    (!dc->debug.optimize_ips_handshake ||
 		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
 			DC_LOG_IPS(
@@ -1450,7 +1452,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (prev_driver_signals.bits.allow_ips1) {
+		if (prev_driver_signals.bits.allow_ips1 || prev_driver_signals.all == 0) {
 			DC_LOG_IPS(
 				"wait for IPS1 commit clear (ips1_commit=%u ips2_commit=%u)",
 				ips_fw->signals.bits.ips1_commit,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ebcf68bfae2b3..7835100b37c41 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -747,7 +747,8 @@ union dmub_shared_state_ips_driver_signals {
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


