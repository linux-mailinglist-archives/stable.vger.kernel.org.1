Return-Path: <stable+bounces-65144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DE943F1F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1743B282E37
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF81BE227;
	Thu,  1 Aug 2024 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6qDz9LK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332781BDAA3;
	Thu,  1 Aug 2024 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472636; cv=none; b=lRVTmf+n8TkwmbwIEbLhWloRfld3kT70Htyt8jYr4Hu1SPzPCeF0VvF+W8TYe051VDjaljx0daZcZZsyW5l6YpHRCq7glO/cjupTvNepMvfGG4CwapY58sH6OEROfUIV7h0Z6pnA0k2xM1s3zH37cgrnCqo+jKE4aGj/3mztoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472636; c=relaxed/simple;
	bh=nXnKs/+JsqnjBgbIDB8+2kHNEBoTVbUppRoBRcjxYi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQpOhsNcScIJ73Bjza+IWae2a32D9AmC6I9IgWpzdbX6VdQdpSvnRSrX1XhvFlB+5HwIAyvycgKLfoeND3vDpNFfPLD4oN8yAqcRpR50CNPjK7r51Qyv/LcsVdMqQ7Xmr7ir0w3KKRk9D7E192u8keDmJrJlTPnFLwnNapeqav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6qDz9LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE08C116B1;
	Thu,  1 Aug 2024 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472636;
	bh=nXnKs/+JsqnjBgbIDB8+2kHNEBoTVbUppRoBRcjxYi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6qDz9LKrlRpdPVvG9sfWwGAcLVBvsuvp5hZuDrpYH6KPvWpiWpclddSj/+2WqiDk
	 RvYMCdofmILqJzn3gzJut80qOGH9dq8u2FHQJQbaT3eIGgK3ZpiqPsCGIGUQVjlsAh
	 2uDl9WuizJNz+TDhP+8NOKF7sP6ZemkERv5hcDr27bhQRqJbXxzGH4g79OqHqGLIW2
	 WmSJgCUSY4owWZQv+/mAwtHGjengPvyaeGbiNCEgw+FEQSvXTe8Cj731CE+Imxcgkc
	 wyV3Q+D4jp3rW8d6WUcAspnal2EpQtodktnGA32XXGCX6E4CNSNYad7iKndpY8o9+L
	 wC/Ue9aqkZa9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jiapeng.chong@linux.alibaba.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 07/38] drm/amd/display: Add array index check for hdcp ddc access
Date: Wed, 31 Jul 2024 20:35:13 -0400
Message-ID: <20240801003643.3938534-7-sashal@kernel.org>
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

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 4e70c0f5251c25885c31ee84a31f99a01f7cf50e ]

[Why]
Coverity reports OVERRUN warning. Do not check if array
index valid.

[How]
Check msg_id valid and valid array index.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 8e9caae7c9559..1b2df97226a3f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,11 +156,16 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.read_dpcd(hdcp->config.ddc.handle,
@@ -175,6 +180,11 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		success = hdcp->config.ddc.funcs.read_i2c(
 				hdcp->config.ddc.handle,
 				HDCP_I2C_ADDR,
@@ -219,11 +229,16 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.write_dpcd(
@@ -239,6 +254,11 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		hdcp->buf[0] = hdcp_i2c_offsets[msg_id];
 		memmove(&hdcp->buf[1], buf, buf_len);
 		success = hdcp->config.ddc.funcs.write_i2c(
-- 
2.43.0


