Return-Path: <stable+bounces-65040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9093B943DC4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DF11C21DCB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D418952E;
	Thu,  1 Aug 2024 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrbnUyOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAC1494B3;
	Thu,  1 Aug 2024 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472135; cv=none; b=fzw7+/NmE7r42oPKdQYZmaIUP28vIJjVhr39osCtzku9Fskhzs9l74Zovln1TALGKftnFOwOIArWclHhvCIKe0Sl+PzgFNmvu03KQH6OZMGIWP4vKv888YRUkCVDquzSUsCIlBFruTGpQT+VMNQCTwFQfQdZlzi6wmL6EiEtbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472135; c=relaxed/simple;
	bh=snnPO8GLX3D7Eq+joehxfeEUxyBZ7azPh1/Vs4yuTVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnhtM0JYYbOrnwfH4csMp1camSWIrsqJ71mw2uppU6CVT5dve6SU8otFopA1j+CvlBV7QAdZpfxkZCrACyP/jSW0aV6gXv3fFCLAIqs3PdRo1QPe0XnnFF50yNM1FqknZjnm4O7+V999ljqaUA60/EgSm3Le3xmms2hKi3GpXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrbnUyOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0761DC116B1;
	Thu,  1 Aug 2024 00:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472134;
	bh=snnPO8GLX3D7Eq+joehxfeEUxyBZ7azPh1/Vs4yuTVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrbnUyOiY94lDA68WU0O2DmYGc3N6c3IvTS2UgenTTgGUPFTQhRE5hriiqrABQPX4
	 5ByTSqaY4bL6FIEEw5m7EtkhVtqRc4jlPrSwtCS0O2AJMBd6b6y2ltlRGBEZYMEF2E
	 6ABSntG5c300BvhuFTAscmUvEYQdnH1pZVRunCgK5X6uVDEwBkGyrCICh7JscAbwaK
	 rAuQIMkwM7c4NRieXisT/9nJmJHdRmstZ9QHJTnJbdkDU11Dmuuv4B5xz/PFm1QFwD
	 323DFtBrM/pI/emiT3aLb5/57FK0wnQj4clMDPb+XVpyoFPeebtlDw+ifXCpzy1qgE
	 uvCBz3q2FKpAA==
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
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 11/61] drm/amd/display: Check msg_id before processing transcation
Date: Wed, 31 Jul 2024 20:25:29 -0400
Message-ID: <20240801002803.3935985-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit fa71face755e27dc44bc296416ebdf2c67163316 ]

[WHY & HOW]
HDCP_MESSAGE_ID_INVALID (-1) is not a valid msg_id nor is it a valid
array index, and it needs checking before used.

This fixes 4 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 4233955e3c47b..c9851492ec84a 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -131,13 +131,21 @@ static bool hdmi_14_process_transaction(
 	const uint8_t hdcp_i2c_addr_link_primary = 0x3a; /* 0x74 >> 1*/
 	const uint8_t hdcp_i2c_addr_link_secondary = 0x3b; /* 0x76 >> 1*/
 	struct i2c_command i2c_command;
-	uint8_t offset = hdcp_i2c_offsets[message_info->msg_id];
+	uint8_t offset;
 	struct i2c_payload i2c_payloads[] = {
-		{ true, 0, 1, &offset },
+		{ true, 0, 1, 0 },
 		/* actual hdcp payload, will be filled later, zeroed for now*/
 		{ 0 }
 	};
 
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
+	offset = hdcp_i2c_offsets[message_info->msg_id];
+	i2c_payloads[0].data = &offset;
+
 	switch (message_info->link) {
 	case HDCP_LINK_SECONDARY:
 		i2c_payloads[0].address = hdcp_i2c_addr_link_secondary;
@@ -311,6 +319,11 @@ static bool dp_11_process_transaction(
 	struct dc_link *link,
 	struct hdcp_protection_message *message_info)
 {
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
 	return dpcd_access_helper(
 		link,
 		message_info->length,
-- 
2.43.0


