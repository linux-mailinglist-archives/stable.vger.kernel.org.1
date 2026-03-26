Return-Path: <stable+bounces-230549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK72OmnGxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:51:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4C833D3E6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F2730A1679
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2719C542;
	Thu, 26 Mar 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4idUwH4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B514303C83
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568869; cv=none; b=szWgcNMPKsAdRGCQ89QbgBylUe3HbDMw8yQcMeIhqEgy6Rq1K1MHwU0/HfnnNkZrmPAvKOR8AkyR7LnebnYJfCNH3xiSEDumZFHl71z4fWNtYPOESHOVGPLX6z8SobJXkSYHVE0IS+SxODpSK9lw6+ZoUx7gFw60mVbZuGJBnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568869; c=relaxed/simple;
	bh=7iOT+Z7eb7KqS/bY5XBbf4Vi9sbim1UF/Q/8f3P5oDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gC086lGiiXwhQlFfoEUNRT/qw8s8fNk1/VRrGT3eoMpG9wsQllVXGVZbgxB36Vjxhz3+LOw4WcFnA3x66t7byRUguLVpmyBFLuh4DTl2r8HlsD1YBMH3DXdLojON/RFEjwCietBxWPJsWcpoHious8hyITKsdnEjAItj0f2C8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4idUwH4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso668494a12.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568866; x=1775173666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
        b=e4idUwH4Ixn6EZQZ/LPajFCZ4CFzqKsGYeSSuqbaB1XAEo6A0u64AWisZCIu4IkF8Q
         e3fQk2AQLmmKWnLOigDQPOoZfVqlZzhqx9tyIfo2o+wkTIXXl7GgBvg8vMcgpp+J9I6Z
         yPF6sh5uyOi1UVjN15IuZ2Thers6G8C1xVS2zOCHm/qWBbsen/MX05yxNsoeN6lS8HYM
         PbQBzSzTkf0VurW9idSMHNkeZiJBtGt/EfI/qYd2XOMY/ve13HmLim9LYQoEYZjwxBKq
         9JHjOsW5DCCtFTEWbgsYVRxx5UO8Pt0ghKv3j6aEiCGcVo3bLhK8vyX6vmK8MWRn/XO9
         6uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568866; x=1775173666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
        b=PdbRnk6D4p2rdNc0+ZPvYrcztx4mfB7DfkNevgCbCyyAhRJtN0BD4fFIvEYsY21jVr
         u6yE+/UqR5kJW35MKe4WZy9J5ayCTBvg8B3gn6pdMGaPuy0yuA29Gdvn3Uc6v0UW1/tf
         JK8jrvHlkYiR56GnT9EX6chXLO2XhFT7GzXcW4kBsAgiAGdAN/+3ZWoJhEK6UoJVK57V
         v19LvpMDQh7f2IJJsc4/xLoFud/2XyHI/QhcJQjVXlTqMfROfMpIh2fhWuez2BfMyQSS
         /fwpumQhhMjDMsq6I4rR02HGHjC4UrRVlRzjMMzTLs1ITAzTi03Om0EBP0qcnEpbCsFT
         qucw==
X-Gm-Message-State: AOJu0YxOaksRGd549XjHVSs0IpJfKefSMtVF14jtwYwjhRa04qqNHGml
	QGZ65vH62Wx3XjFyNsHKf2c9YqDHcZPAOKcRSXoubVxuvh0KZKl6K6u+89uzg/Od
X-Gm-Gg: ATEYQzwU+Hh2xtKKJms6TNrtL+nHPf1QzeOgr1N3qXnxV77/ig3Xo+LI1reTQlkgNbe
	GGhsBsvKCO/EuD2kOzmn92HIdMBMIVanmxvrY4ZDGPB3neUnh3VGB6uIifM3vWkz+I/+uSCt3Lx
	IDKLB0w8zoKhLUj/s0EWYmjl+NY0QEoGZoT3c32aBhKDvhjqcd/ddUItWmY/9uSJbsdDj8u26Tr
	1gDpC5y30J9Y4k7rB+l9bjyJGn/yGIEOOf3oaCAW5+Ehs6WQGxGvNxzlWIBBWd9LbEEPm7X4Vv5
	xIEBlFJfKYizR9SauPn2zRgIYyxQL7KMypiDvW9uMr8ChAG/NIOuAbBc+DonKkeTnk9zeLtn+Jp
	Q2L2vAnO4NYX8mNI8CaVQtJMcJLBs38eNdnq2/1tdSXNy3gVxyKYCcE+4QW5NB275D1Idl2pp5h
	eTLJ0QXH/niOIbZlF7uc5nyUhxGnnwAR9VBHx5jlylzUIZPesTge9k9/M=
X-Received: by 2002:a05:6a21:6d97:b0:398:b16f:703e with SMTP id adf61e73a8af0-39c87abf84fmr507549637.40.1774568866039;
        Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:45 -0700 (PDT)
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
Subject: [PATCH for 6.12 5/9] drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
Date: Thu, 26 Mar 2026 16:47:12 -0700
Message-ID: <20260326234716.16723-6-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230549-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E4C833D3E6
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


