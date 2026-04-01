Return-Path: <stable+bounces-232624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EhPAFdpzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:39:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF761373334
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F315303645E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B51B4223;
	Wed,  1 Apr 2026 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg2Ogfuv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E81EB9F2
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003981; cv=none; b=m6WEwDgLjZKWcewwrbepmDmgysC4iIZNHSoKPmhT23MRjtTYvVTLESkkQ188p85jeEsX3ONbjhpRtSHAIXXREWLBU/dUDkFPQbBDKTv9gqXL+XNX0iM2NMevOBYcPAZpsOUfEi47EeZO7CJQZRa45p4dTK5abI10Wfneu34Qdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003981; c=relaxed/simple;
	bh=7iOT+Z7eb7KqS/bY5XBbf4Vi9sbim1UF/Q/8f3P5oDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kE6R+YHCF1tJY/z3kUHHBR5RA7j4nFzWdU2IFVRavdJI0QY/lCQueAzroiEpZzV0/rQZU4Q3kCLa5Ojr8h6fmAVkd5PEogFaea3e6tnJW04mXxJeKobt3Phj0B+wOF2hnddglmuB3tRdu4UT2LDgsDg3M6N4kpL4ZaXUP4rLUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg2Ogfuv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c54c68db4dso5251232eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003978; x=1775608778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
        b=Xg2Ogfuv/yoqp/5nQ0DnOiUlfbe7pYlkrY4COOMRvNJhMC0XT/2Chn7QOKjJhQdMKM
         bs2oH/IohycEKbSHWA0R9ix1+0VwZdkJlQFkyW+iQ8UzNrV5woSwoSgLWllZqXpThI0d
         LRip1lPY1kXUOescJKzG8SKQm+tNq4ps+SUVAsR4CnXJosWjmpD1g+4Ii9p60SPo9vt+
         FWycl8A2AXvF0ZtabTOWDwbjzUdrjIMblRpTta6keFY7P6lKhXSP58OoOiTtEgQwE5li
         OV52QKKVyJMSG3/+kcOXrYz8rXmZTwU1JcMPy08r/awoUzggp4qpRcQ5GU0FuJG53d0i
         sr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003978; x=1775608778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
        b=d47Y0fDXKRHRnN0SFEvwRdlSbkmQ7IbfgDY+GDwNEBPvo+XsmKi6wuIucztltVpaRP
         Y8a0B3NolDnBUYQ7hUllooHjSF4Wc01mNJcIWrFeWI/OQ/zCYa9YgM2Ht71Gq+v4tpiG
         iyGcVfo90iPcNZ96vLbGS2zz/JSyMLGhbZ/QeKgkWaOKq/dnww7lVIZLvFvJXE7f32Cu
         frNez/gV0eNgxr1TjAAI9GQ1bcBBWQC1fefI/dZMRZER7UKxFs9sm56AI8zjY3E4KbcN
         33Ttq97zKqO9+Bl7GAe/51EiJ9LSfKIHCBFUkgCx0Ym6er5m2YfdJZ0XTCgzP4C09qDA
         hXkg==
X-Gm-Message-State: AOJu0YwpDAIgFa4hkSeiRxWhgFKVHXwIarjLwbB5/A74dphJ5BHHDhCR
	sP6kfMdCrj+rwBG3wnnG1jlTPmp0gI44QG2A8Fwa7l8sts5JL9WhQW/eDjS1frEn
X-Gm-Gg: ATEYQzwf14omyX1Ls7y/knRvgSR38UuME2GZE5gTSku2pAygeqqM6x7S7Pyk5e0J2EG
	UjuVHF9ir3JiYOWVrxAm/zS1LUjdbBe6yERBr2wXTkeR5aVQ2loQPwUj5ObRoVSMGtXicEF9rJ0
	k+Ufjw+RwWRMhlmPgTbz1mY2+ofqg9XC5oPzcNxnRmRyqzFC41inF4TISdpoLetI3O1hA0vqgTl
	zKLy5/2Ekpk30meVoo51/SO9YCDjNTX31sfPIJioLVCXnY9tCh3hCwiFcw9BTOvaBq6mARG3NYj
	8pN8lTKuleo1TSkeS9EoCLW4thFMWpQHj8wsuGXe0KoCd0F+ANmcBNmmVoqjl8xH1OfCswli+1s
	myszTAV/FnGeiFSseevZXtnBjhtlp7Qdq1w+KnW/pQfI++iSBuYdf3nWPIK2QGIZJf106tCk8b7
	BAU5HcMhQKLVjX/pAhwZdLPbwuVvk/okO58DEcZk5dnO9T1Apy4npSGMndLNylfD43bQ==
X-Received: by 2002:a05:7300:cc1b:b0:2c4:a862:2368 with SMTP id 5a478bee46e88-2c930c76802mr929306eec.2.1775003977555;
        Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 05/10] drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
Date: Tue, 31 Mar 2026 17:39:03 -0700
Message-ID: <20260401003908.3438-6-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232624-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF761373334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 7886a2a55caf..c4d7fa60d654 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-- 
2.53.0


