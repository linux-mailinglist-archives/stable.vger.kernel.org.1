Return-Path: <stable+bounces-230550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHkRMurFxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D033D3C0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F63D3036A21
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC42327C18;
	Thu, 26 Mar 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIwnNE0K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B42609E3
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568874; cv=none; b=qYvgKW5IQCSzNBQmAW3HzVAjdJSJoa+ifPWLlMP1JfyoX35TbihmyAe5co16dEobxINeugSBefOpeWY3Fmxb//8fQaSqySnXW6UZw0q8zZkRZfDzh+q4hBmUIJyXO1eJPo166BjaZli/7Iww2QTg83MALxpYr/QzYsGhdoX/jvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568874; c=relaxed/simple;
	bh=nxNHchBEAgurZmPLW41iEo80XDuWVJCQL7AK7y+NaqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vsyc1ZThx6fo20eTN8UGlIH5HWqtbKfeCmFqYbU9kmIhL57MqEYda8zPZ9C7YNu/2kH7zG8PUvReAy8nW+IA5NOPrBtxSbIUst7IdEU7nn+0g2Z083yvOFWAFTk3vPgPu/y0eq9EKWu8cPmwpxvAnfby8TxYd+MQn2byjIwobVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIwnNE0K; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso621036a12.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568868; x=1775173668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
        b=kIwnNE0KewhoCVNqV0qTfFIWmST5NNAjTjEn6yAQJvKKUfYopcgZsjfkHdBYrJrIog
         ZYo/SdeWvegeBl5A/rDOvEzNe77W63mq0rKopnJGnEr3VO4tjIP51FVHpID2Z98FZ1YO
         ckRZXSxYanL4pX9coCXqeTrAPRCHV0npcqZccHb7ivl18uKknV6zxRuHT9ThKN4WNrWR
         fH+kZFhpNS82PFcVgfXr07bpALGZDY9KkRL5Ka8GlrVSHENigXkM0CJ5SfvbSuk36nCL
         MAp4qhjHEHD5Z6jhaF9EXWS0n6jTpfvM/cpkzFMiAVWnNHGlluy9o6J4vE10ZEB1s/il
         izjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568868; x=1775173668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
        b=etiW4dVJ1PZ+KnTgERAtqGjYXZJHMImiXiLySlP17seKwAg1uvn/uqF7G+M0QczWz0
         HIAaYgTvB6FLRnVeFIeHI4OFcNd3P3VDu50CPL2X85T4KEeXQxivpC71GNEZ208bRgJe
         eyBAwK3vyaCG3LuPKjS58t0nl4qmXJ2ygGJL8WiMmbgk0dkJZwVO21SaJvq2F1B1FlIM
         TjXr27zQHrx+gfeHr3sCKoZK0UldpMMoaIyH95R63vaHyZ5KzKmaanpxjMcNfKlK4/EI
         Xbp1+JtDHQU3V+vpvB++utGT2pfkkzQACwDyreyvIpUr7yRJ6abT82PvCBAbZLGyktQY
         kaIg==
X-Gm-Message-State: AOJu0YwmzEXmy1IFY4m5Chzym00C2ZFzmxU+/uqSXn9D5idm4+ZnhTDf
	XLeD3gQrXwJ9qW0kv2AvFZ0mSOzmrR+mpGke+8Ss3TpC9ZEFbfH6Gyv4gJ1RZ4fp
X-Gm-Gg: ATEYQzzIKg0b6QEWOB1JLxF/JfR8L+wsMST8xVPlUreX7+3DRRxisVWNwIssepyiegd
	/cKX8mStscaqebybRsIs+Me5WHI+TI46chb2zPyPZDJ6bXN65kZpos+6Sb3zUKNQfZuqoOqnxVR
	42PbDYwiuTnzkhHxO5VzgTnGHKhnUBIxGKgmJ2H7pOb03x+VEmyjtehDZoIcNk/Y5ZopWe5rEjA
	AexlEMHXbY9zwSkkVmGcJ5w0yKHErUT5lflN7hWDTSu3nbG2Hyii27OGIyEbfusbqicWLI5c3Rv
	s0bhioJlo9VxZsIqSYooynJgetVlE+SKwL2jl+AIDyO+nzwWveLGq8ZWy9P0+gl/AsKonDFbgVM
	ofr+j19QvJ/fRxfqad2VCmHs8UTWCFxGkUBRZz4UMx7Ito0A2FFTOqOK65R5C6RT/ImRVCyWm8G
	OLQqCkq18KfdLD8DF1j88e7JMgSA+95uKW3pMsgsLFhvjBeGVC1x8KV3Y=
X-Received: by 2002:a05:6a21:32a4:b0:398:79a8:5bf4 with SMTP id adf61e73a8af0-39c87a364bemr573477637.37.1774568868091;
        Thu, 26 Mar 2026 16:47:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 6/9] drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
Date: Thu, 26 Mar 2026 16:47:13 -0700
Message-ID: <20260326234716.16723-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230550-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 142D033D3C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 35222b5934ec8d762473592ece98659baf6bc48e ]

Apparently, both DCE 6.0 and 6.4 have 3 PLLs, but PLL0 can only
be used for DP. Make sure to initialize the correct amount of PLLs
in DC for these DCE versions and use PLL0 only for DP.

Also, on DCE 6.0 and 6.4, the PLL0 needs to be powered on at
initialization as opposed to DCE 6.1 and 7.x which use a different
clock source for DFS.

The following functions were used as reference from the	old
radeon driver implementation of	DCE 6.x:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 34 +++++++++++--------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index a2e100aa3cba..5dbe89d9b72d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -245,6 +245,11 @@ int dce_set_clock(
 	pxl_clk_params.target_pixel_clock_100hz = requested_clk_khz * 10;
 	pxl_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
 
+	/* DCE 6.0, DCE 6.4: engine clock is the same as PLL0 */
+	if (clk_mgr_base->ctx->dce_version == DCE_VERSION_6_0 ||
+	    clk_mgr_base->ctx->dce_version == DCE_VERSION_6_4)
+		pxl_clk_params.pll_id = CLOCK_SOURCE_ID_PLL0;
+
 	if (clk_mgr_dce->dfs_bypass_active)
 		pxl_clk_params.flags.SET_DISPCLK_DFS_BYPASS = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index c4d7fa60d654..978c024c97ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -374,7 +374,7 @@ static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 6,
 };
 
@@ -390,7 +390,7 @@ static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
 		.num_stream_encoder = 2,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 2,
 };
 
@@ -990,21 +990,24 @@ static bool dce60_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
@@ -1382,21 +1385,24 @@ static bool dce64_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
-- 
2.53.0


