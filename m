Return-Path: <stable+bounces-232627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEfONLppzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF3373386
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38519303CC35
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED21E9B37;
	Wed,  1 Apr 2026 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzjdZ0JF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570811D8E01
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003986; cv=none; b=XQdJ5WCJcXQHc3B3VWQtLcbDnBHSvTDO8SgBlmywabVxPuOMvd7D2Se8ywSV8hG6Qtn1qU9xI4VpzOL1H4/gj5c2RRIlpikVRyC2d29Y8rW15iLetPnFBCiHHJ4yLvk3k3BYSpqwUcFJbf2HKUM83msrC1mnLq/p2oNOyp27T7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003986; c=relaxed/simple;
	bh=HjDa2ZaVfCGyD0njzM/Hx1F3qeaUeXvsmO8wpznl5Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mo07eQyzPHDKHCsbgAcdOQs9IeJKi6Vnl3qhk6ljqaRhvgiPpzQZ9h2YAefvVTSfhKWOABUfADJYiQdJ2M4c99p0Wo0kD0AG44U/nKPqVndxdYaKItq4MFfaAKyT0oysx+0L/GdoBMl7JwGHFPBbUuQoJl0V3V3G9F39IxFmFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzjdZ0JF; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c88992d77dso238194eec.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003981; x=1775608781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
        b=RzjdZ0JFnwOri102cH94pgyHIGTjEheZ4jq9aQUdWUUhrBlEaiHuBV4ZYBnX4J/DEN
         mAZu5PnYjYivMJK/Cry+Wcg3djV1kSRaJgdOMGFChz3DWvb1xC9FCzBpQBlVNp9T+Hi3
         sZ27iqDsZjbEkI6Etj6BEeVMcSfF2jiyAqHoAAYfoiYvWgIaILGBidv8Kz1AwoEEtLjx
         Fn1X0RxTHe0VsxTyjr+urz0hyHBHkv8UuBL5X4ZTgsoI43ws8DBa2Y5jqpshgBEOG0TU
         wBOGqw8yJagKt+gGGG70oEDPcD2GKcvRuEPmduFF036bmaVEgbkWAA4Q1vr8u3dMG+hE
         X3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003981; x=1775608781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
        b=Ev8Kgc0qLQ/Jxc/4Oz98dtFBtJjo5zkCn+n5S/JXpEgX1wwDDoPVJzwfLKR6RUF7/x
         m2CMXtitMZRn7BqIr0uUP56jJhBKFPfZBmhji7w7UNW/7VCbN0CCFkA3wCXrR35CcgpP
         OPT/Aq8QVOp/jN15X/MWuGcfjqXL7O7remwhV4vmL3m2ElsevmqOtUuWtavJtWOclG+s
         xDmaPKxQkOwocfciQwa/RYXMonue2BSIflZ8OHyXrLlpEvJEsFy5QBLWy/7Df4E5YpFC
         hKv0giJ4OrAT7HeaFOtrOqnnNVnLahFoV0M5CwDCQothu+M3hfHdu6Dr1ScnSMXmNrXb
         6F+w==
X-Gm-Message-State: AOJu0Yzq7ItaCKTpWFUDC5WcLyt7ZIwIDXPm5WkAno5pB39rXmkdjuM/
	dJX4wDv4V+lY5tatf1r7S+puaNPVbE26n7/uttKL3bJRd6R57CADFn4hCYBFbyCG
X-Gm-Gg: ATEYQzziQ6+lOsgK9pwuxajHunPjzSA9wpB4oePP/rJH7B30oinG9V1Pv7QUl5jaCGD
	qmGOaD1aEe4CasztCEeI4cLYdWyEyjgCZWdQ1dj5gnFuJDLr3BtwIpUK7tK6CoVMtLMjZfz27Mo
	cyuKTCjco7cOHsyIMmsWVN/2fd3WH/OU9+WCTrE9z5VI134oareX3hBLXzQSJs7BkAQDcX66rXe
	390yjymCd8N05FH+6OZORwJwykpxjHdiZ3Ny7GUp+n0oxjyEBmdfezS7Kz8Yg+7+9DbOA9SV2FE
	YaX/jLy7KWTKY84jj+wsXyMhDieNg2WYoUqHlrrW5MrCOiTg/DsukPeXpoCLrlAYm7IHSJejhFg
	xD0o/Wr75W66qewGpd9+4WbPumAksO44vafhRVBIeWnAylseTj3oxTO7w52MH71O2XhyFwaoJC2
	qdb0BYp5I0frxgSF/KHvZGR/jllndvLwL+lOLCTnKeEY7GPRDWsjOCnS0=
X-Received: by 2002:a05:7301:fa0a:b0:2be:17b1:e49f with SMTP id 5a478bee46e88-2c7baf442a2mr2983559eec.4.1775003981000;
        Tue, 31 Mar 2026 17:39:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:40 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 07/10] drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
Date: Tue, 31 Mar 2026 17:39:05 -0700
Message-ID: <20260401003908.3438-8-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232627-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,igalia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDCF3373386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 1ae45b5d4f371af8ae51a3827d0ec9fe27eeb867 ]

Adjust the nominal (and performance) clocks for DCE 8-10,
and set them to 625 MHz, which is the value used by the legacy
display code in amdgpu_atombios_get_clock_info.

This was tested with Hawaii, Tonga and Fiji.
These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 8-10 which
are already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also	adds a check to	make sure
not to exceed the maximum DCE 8-10 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 5dbe89d9b72d..6131ede2db7a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
 /* ClocksStateLow */
 { .display_clk_khz = 352000, .pixel_clk_khz = 330000},
 /* ClocksStateNominal */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
 /* ClocksStatePerformance */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
 
 int dentist_get_divider_from_did(int did)
 {
@@ -403,11 +403,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.53.0


