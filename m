Return-Path: <stable+bounces-95067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B739D72CC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA841650EB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5120896A;
	Sun, 24 Nov 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1KUnzAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209B208962;
	Sun, 24 Nov 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455869; cv=none; b=EzioN3ufq0hmLdGgSoz/Q619Ko9O/1F4FLomMx3hlOBybGRiSB3e4n0krnaTI7RqGU/1MKHY09Rz4o/8BJ3JfnIaD9y+taY+StrGhqde94NWIqifzvkmlEA6+fTVc0KRfcx3MPsQfFhKNWIsLZ+kJWsgq+IvdTITNrUDCKmNbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455869; c=relaxed/simple;
	bh=ap957JtvfHbYWHg1Q7vq2lncJ149BsmA68cfpoBdArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9bNYYsSgU1CaHlNeLv6hDP/6aAcmgFqPq2qEgNrGmabwbAjCSMcUaa+YMfXKH+/syI+dqYLsQlO8TxtzLambNvJ3oLEm374+Jm/V90g9SBBq2lGtMWadY/HCl25r8WSKewyAG7JCjKUiouVIrdU55oa3/Qbu8L1Dh33kOdkxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1KUnzAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6D8C4CED1;
	Sun, 24 Nov 2024 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455869;
	bh=ap957JtvfHbYWHg1Q7vq2lncJ149BsmA68cfpoBdArU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1KUnzAwHMqtKlZBASJlhWLE5RX18jIGa5xRRY9eoHg3uk8BjZMKBHje9xSbabLh0
	 Y8t3x16vs0A10Udv5oW0cSCldL7lcEgRO8A0LL3888DR9TlPv3NbATg+pZMkC63v2W
	 Ak9QACazcPjb9L4UZEL/wMTJHL2aM6ZQVdlhZSF4kvdvmZJwlMgvNYgaOlQqwyxK4L
	 ceny6WHfpWK9tFIXWjTlw96uEGmhT0HhqE9NGJpwzhdCBMj7EoTFHHPlDBMwGKRR6v
	 81k0rjw6aUtvbZjemyaRVb3qEAafVYd0XUppZDCtBC4sSZ6xDkNyN6gWvsDhIsF3k6
	 /m+5cIKdzLOHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ausef Yousof <Ausef.Yousof@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
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
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	michael.strauss@amd.com,
	george.shen@amd.com,
	daniel.sa@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 64/87] Revert "drm/amd/display: Block UHBR Based On USB-C PD Cable ID"
Date: Sun, 24 Nov 2024 08:38:42 -0500
Message-ID: <20241124134102.3344326-64-sashal@kernel.org>
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[ Upstream commit d7b86a002cf7e1b55ec311c11264f70d079860b9 ]

This reverts commit 4f01a68751194d05280d659a65758c09e4af04d6.

[why & how]
The offending commit caused a lighting issue for Samsung Odyssey G9
monitors when connecting via USB-C. The commit was intended to block certain UHBR rates.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_capability.c    | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ae6d7e3d117e2..60015e94c4aa8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1402,8 +1402,7 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 
 	if (!link->ctx->dmub_srv ||
 			link->ep_type != DISPLAY_ENDPOINT_PHY ||
-			link->link_enc->features.flags.bits.DP_IS_USB_C == 0 ||
-			link->link_enc->features.flags.bits.IS_DP2_CAPABLE == 0)
+			link->link_enc->features.flags.bits.DP_IS_USB_C == 0)
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1416,9 +1415,7 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 		cable_id->raw = cmd.cable_id.data.output_raw;
 		DC_LOG_DC("usbc_cable_id = %d.\n", cable_id->raw);
 	}
-
-	ASSERT(cmd.cable_id.header.ret_status);
-	return true;
+	return cmd.cable_id.header.ret_status == 1;
 }
 
 static void retrieve_cable_id(struct dc_link *link)
@@ -2090,8 +2087,6 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	/* get max link encoder capability */
 	if (link_enc)
 		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
-	else
-		return max_link_cap;
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
@@ -2125,15 +2120,10 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 */
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
-	if (!link->dc->debug.ignore_cable_id) {
-		if (cable_max_link_rate != LINK_RATE_UNKNOWN)
-			// cable max link rate known
-			max_link_cap.link_rate = MIN(max_link_cap.link_rate, cable_max_link_rate);
-		else if (link_enc->funcs->is_in_alt_mode && link_enc->funcs->is_in_alt_mode(link_enc))
-			// cable max link rate ambiguous, DP alt mode, limit to HBR3
-			max_link_cap.link_rate = MIN(max_link_cap.link_rate, LINK_RATE_HIGH3);
-		//else {}
-			// cable max link rate ambiguous, DP, do nothing
+	if (!link->dc->debug.ignore_cable_id &&
+			cable_max_link_rate != LINK_RATE_UNKNOWN) {
+		if (cable_max_link_rate < max_link_cap.link_rate)
+			max_link_cap.link_rate = cable_max_link_rate;
 
 		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY &&
 				link->dpcd_caps.cable_id.bits.CABLE_TYPE >= 2)
-- 
2.43.0


