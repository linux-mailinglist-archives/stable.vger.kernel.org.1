Return-Path: <stable+bounces-232623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMZQC5xpzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD75373353
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 948B830379F2
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90D21EE7D5;
	Wed,  1 Apr 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuHYvza4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A811DF74F
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003978; cv=none; b=aIsjX32oA50gg3Uad3mcs6L0rfu8XcgI5eK5MfDaU+6UlUzKqIaXZ4saxTy2scnwkB1oI4P+qWp18D13f1AnDKFM79ESIZwsxJKtQRR0Q5k6tNiCD5660NtoGg54lLV7hQ19apl8HoSPuxcSHuzbHhSRPvOcFWAr7LSpnS9xkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003978; c=relaxed/simple;
	bh=KDqNex0SrS190A1ilN+y9+8TCpjpm9vndDHmyB+HvwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLFJG11GL1HEnlfUHA9qRjwRnjfKeNk2sURESDo71Zz088X0jbaWMZx21+FO9G5zDpdeDkUcj5tSO/iA2TJtaol4AMrRVt9OCByFFyhi3AlXFoj5Qoup9p8HQMtiJ6TNCF6Xum5MNCFu3Gx2QFAD11zniO6IjaaRXfmwXs45CXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuHYvza4; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c54c68db4dso5251196eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003976; x=1775608776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
        b=WuHYvza4RotaY3Pq3Sh4dZjS4UrkvwiZHbZqPVHQ5ow0t0V54IV5lP1Qom2k7XIWzw
         dwlu729N/SdK3J6ByO4NWQb/nuTtUCOhE7ywyWBLcoUr1DvH32ntEjEvyevsmGAvxqfj
         IH09/URmAIgH5MtG3qYaWhtQwkWamXB+Zjx12r9hNtrM2v0+TdLUHuIBQHho+SnH9TTn
         hhwrDTZwbyQUYM73RPcxhirPjG/nyPZy1WNabaP3+xt6S8l78zPmt1TGRe/3gcvvxA+K
         xlAwlpuC7A7LrQFYcH2HW0mgkxiEg2zv4PQfiR+fLq3LiQ+tarcwlSlCg0eixPdR9OSG
         8/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003976; x=1775608776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
        b=X0Jv2OtP/FtxGizc3D9san9TjFSeMAAWI6qUIrEMqf83EUvlwBF7ueb3umHp6WftCQ
         HmenXOqF7pWfrGFq7jOPs2SnY+9L2sVlj2dw23hNCCEUm42e4U3jjwGNd6ig+Kaq4p9L
         J7fJkpMPDTY8y6IQ/bUm8TTry8Ib2AsmIRmpDaPn2pcMdh9vJX8QTeySGbMvWKO4UTnI
         CoPmMgzlFWb53qjtyTF0N5BAztyjActHkEc79a1FUEEcCy7+AAf3SAgayJRszx9ymRfp
         XId6PLaJz3UPpTcZmdcR0v8j3n24+v4ftc1zlMk5VaFgBRWaQvL+MfujGkVukbUtcXRm
         Zv4w==
X-Gm-Message-State: AOJu0YzTDxgXoTK0zALXzn8e2b7OzZ7M+EINVzsCA4UASBIsPHf2WII9
	Uao1HdHnrxUi4HQ3yGdl/FCJU5ECEhY8fFMSj/9SKl8giqY+ss1QRy1P6z6SnVdu
X-Gm-Gg: ATEYQzyHZBr0N4R2VZlL1RXkyLwa0xhPNPjfoOcPBI1tgrq4roIxee23/CkGSqNCAsP
	vTwSarlwyk1wVnb6w+x0RCyRFmHFWmx8Ulk3wtzhHHyyWNA09GOlZYGbztkJsIRAUFywNAWw8jE
	0+vb/anJ1q2hbSy6T4Y3xY30+2VBRFntpzEqDHBGIjFZ1uYEwgp6gtoABoPXTCL/QkWzSAwGOOy
	tQH5kZNFCj5kiZj65V427hXGyHBZQ0leKrmbG10Yzi2khx9uuGWeA5lmN/ed+wrN/v9tr9Iy6Po
	99SjzEc6JBWHTIei2DtOGBWdZb3V1h5q94MoI0ZoOl35hb8u8QhGAXdTIFdw4aFniNIM1Sns2Pi
	wbHIOYfINzLfNbyZ1hKIF8A6cP1FJI+Q+vJohz+KQfGyaJwWvBds/4ETMgpOHeXrRivOpK4wv8u
	MCXLfCOnEpU1r4ZyzS4xcntPRWi0smsXh2EQEUXf5xZ/biTW8sCcWAop4=
X-Received: by 2002:a05:7300:ed0e:b0:2b9:80c1:bb5 with SMTP id 5a478bee46e88-2c9337a0ef3mr1033986eec.33.1775003975796;
        Tue, 31 Mar 2026 17:39:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 04/10] drm/amd/display: Reject modes with too high pixel clock on DCE6-10
Date: Tue, 31 Mar 2026 17:39:02 -0700
Message-ID: <20260401003908.3438-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232623-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CD75373353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 118800b0797a046adaa2a8e9dee9b971b78802a7 ]

Reject modes with a pixel clock higher than the maximum display
clock. Use 400 MHz as a fallback value when the maximum display
clock is not known. Pixel clocks that are higher than the display
clock just won't work and are not supported.

With the addition of the YUV422	fallback, DC can now accidentally
select a mode requiring higher pixel clock than actually supported
when the DP version supports the required bandwidth but the clock
is otherwise too high for the display engine. DCE 6-10 don't
support these modes but they don't have a bandwidth calculation
to reject them properly.

Fixes: db291ed1732e ("drm/amd/display: Add fallback path for YCBCR422")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  3 +++
 .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  5 +++++
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c  | 10 +++++++++-
 .../amd/display/dc/resource/dce100/dce100_resource.c   | 10 +++++++++-
 .../drm/amd/display/dc/resource/dce80/dce80_resource.c | 10 +++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b268c367c27c..a2e100aa3cba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -460,6 +460,9 @@ void dce_clk_mgr_construct(
 		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
 	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
 
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index a39641a0ff09..69dd80d9f738 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -147,6 +147,8 @@ void dce60_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_internal *clk_mgr)
 {
+	struct clk_mgr *base = &clk_mgr->base;
+
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
 	memcpy(clk_mgr->max_clks_by_state,
@@ -157,5 +159,8 @@ void dce60_clk_mgr_construct(
 	clk_mgr->clk_mgr_shift = &disp_clk_shift;
 	clk_mgr->clk_mgr_mask = &disp_clk_mask;
 	clk_mgr->base.funcs = &dce60_funcs;
+
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f7514466..7886a2a55caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -34,6 +34,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce60/irq_service_dce60.h"
 #include "dce110/dce110_timing_generator.h"
@@ -870,10 +871,17 @@ static bool dce60_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 53a5f4cb648c..6717ed84a032 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
@@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a73d3c6ef425..af4a45718c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -32,6 +32,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce80/irq_service_dce80.h"
 #include "dce110/dce110_timing_generator.h"
@@ -876,10 +877,17 @@ static bool dce80_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
-- 
2.53.0


