Return-Path: <stable+bounces-56158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071991D50A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4963E28141D
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6E28F1;
	Mon,  1 Jul 2024 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osr4dRa9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256F28F4;
	Mon,  1 Jul 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792783; cv=none; b=JQ9FjNvSRDM4I3tud607zJJt6AoAihqduqcv0asJVd4HK8O2NFf4L5a7XpWGSGd2IvRfLGEyqEM2fINp5YY4zNE9xsw17T1Jk1FcUJeRO0YQzY9Xjxcic7re8yCwH23/3kCXG75BOtLqZKWMyAaa+mvBrPJQEGMf0UitJBlaMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792783; c=relaxed/simple;
	bh=C7B1z7zRNyQoTb37dINXnouKlYBV0R6doHvDIjnpcoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsfQI2gtwgbUvZRcxZhSfrfM6f+jmpsRxszunAT9/+yRhUXXPKB1pqinDoLidIxd6VpWpgxTrbSh4mglaAW4QaknYqiVJS9gcJkErU60WHxtkvjDmTXi1qQjKVl59o/avZ0bbWyCFA4v6kSdEwSw3cKSXXOS0AVcoFO08/eCoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osr4dRa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE4BC2BD10;
	Mon,  1 Jul 2024 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792783;
	bh=C7B1z7zRNyQoTb37dINXnouKlYBV0R6doHvDIjnpcoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Osr4dRa9kdJGTCfiJE3buJql4sUbGSS03spsEEAycOouoizCGCcdanN8OjBwDzILA
	 lgnzQeqkCwKYI8+KaqIOp81HTnElv1QloQTF7zvGl8bU6yfPObKKgdp3FluyOqvZVW
	 NULwAgECu5Cgt2MVW3ve3LfRyoYAvJpqemFruQbQBFZy0MqddK4dne3LZj9+AETBwu
	 glIU9AJ7ZXMOuPtWfpeFWVqq6LbBQrI1CbMtRvH1sGRZK3rlXILabKDlwptBHEiQqk
	 odW9pypoVmolZX4siaLwL5WGI+D6c0Z9ET1wUefCa3BwGS1fgcgTaHeGUJpRL3Bpr3
	 U2kT+65lAYvng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Miess <daniel.miess@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
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
	charlene.liu@amd.com,
	hamza.mahfooz@amd.com,
	wayne.lin@amd.com,
	syed.hassan@amd.com,
	natanel.roizenman@amd.com,
	nicholas.susanto@amd.com,
	ahmed.ahmed@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 15/20] drm/amd/display: Change dram_clock_latency to 34us for dcn351
Date: Sun, 30 Jun 2024 20:11:20 -0400
Message-ID: <20240701001209.2920293-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit c60e20f13c27662de36cd5538d6299760780db52 ]

[Why]
Intermittent underflow observed when using 4k144 display on
dcn351

[How]
Update dram_clock_change_latency_us from 11.72us to 34us

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index b3ffab77cf889..40ca38dd1b23e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -215,7 +215,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 34,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.43.0


