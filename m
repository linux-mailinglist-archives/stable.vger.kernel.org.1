Return-Path: <stable+bounces-230548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HVdJa7FxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:47:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172233D35E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C4083048525
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987B2EC0AE;
	Thu, 26 Mar 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlabgnAe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E532FFFA4
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568867; cv=none; b=KcjKl3p+A0zRstmAUaueMP+OfIjxb/OpaJAHAZ6h2ndsFnaoDPtUnFLGs4+WYb+ffaMPIhPxOCsmmRVS2+BksykO40U6CQdwfrFfvaaj67ACrwA0PMFXlbTgmIBImIov1LShD8a75Plr01IZTgomvJge5EcrgptYT6dGwjQTclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568867; c=relaxed/simple;
	bh=RwoqpXy71D2hq/9YeKiguZNaZPXik4kFxfn+hYcauuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2LV6yz+AZMfraSYDgC/zlb8NZBoL1HfqEKeRWvOuRp/tAjbTESQ4/T6QKLObruumIIHYJqj47u7JrT63xGOStY6ipSBW05O1tCx5hgsFsvrRKyoTKodoEebfwNs1B31pM+Pv+CfTBxnwpkx0gVDLVQa0ay9PU+MSabZueIWk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlabgnAe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a9296b3926so9917785ad.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568861; x=1775173661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
        b=RlabgnAe32e98ogTMNQgIFQqmbK1mMjBGXUj630+Kvz5qioX+707S2V+oCf+tOcImo
         R/QoG7hnTcPzkwLrlzfHixGfn8qoYvEDQ3XCjh9ws7+hxwQHTI3/mjVTSmotzv6fdili
         vJuP7Fn3AgSUbS3qc1GeUb4e1CQU3xML+Ujshvzio9GLhvFzs8cqYNXeblVG5olBVIE/
         E4bP2QymXRtKvpvjxWwGRcMzHvL77gZgSYC98mVE7BkRl5hlquVzLHZHNcw/LkqZBpXD
         ReuNSoVJwoH78rfQVhETE4eF1HEygSu0h29+bMi92hzoxnl5HQiUCfhSPpnGjSlYFMTq
         c71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568861; x=1775173661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
        b=djfsx8VZhYzsxYg3/Xp/RiYO/bnZYSB9l7lkhd95bsE+zWRYvLlygvqFTNRU37cRe3
         daRBoup1ONnf1XZ2FZQrwHUjcD5L9vSe3YYAo1s1IOT4uXeeEt1L7IBhcuXOCW3tk3to
         hxBn8H3OGXbjXmzu79zTCEr6NYmO6az4rqHKL5BB4J8WPSvAoEpWrazvxtmDWXPyX6T7
         PF1JZBrU0ar53sz4qp4l4RUM1p5qlKUxoTTaQmxIoKXPwVse0mdL7BhgzlzryXzFalCO
         vlQzp+D1KUhlB8QXxgt4lIBHaBsenGOKA4v9lfvmZXxw20uNWgOzUDWYijkZ/Ih3w0bC
         uQig==
X-Gm-Message-State: AOJu0YyPX65GBT26aFTsTg0PT9Fhn1vQFT7eyXvDnXD8MoOxovxI3Yt2
	09ozKSRxW1iHLtOxPWuZA8nojEJvdiTzmR/1vHOQ5YugVcDx0YPDOH+RkMNNOnDd
X-Gm-Gg: ATEYQzyfvLTF7MX9X5Fzn7d94CyQhXWa7estDalFc2w0pBQBK8D/6OhM3oRYKy5UL2E
	BP7Aur9XpJYtgZqjlF37ZCdzapO+BDbLFN6Qz+auMMu+M6FssiGDJ8l7TvgWo/9vPjURpMx7hNk
	ylCE9RFNF/Ux0b0UgQ8ivnXvFQwbDBlKNiAmGKPslfBy9TpMvQRXmme0AVPidPllri7lf80gVwm
	56jTk72sPjqc5xAfhf+LHPHC9jqcoKuXhm1qKlcajra0aPq2LhQQDDmXaUegMabpuITaTpVw0mO
	ItXSzaHwwz4CJxgZtGNKw04SWTnHyRv/9NmVF/VkWQlvNfHJuLN2QC0fnEUGxTsLK6iPZ1TUztG
	De9itsoyBE26zKV241jtv95OXwQVmPTlTRBqGrEsnFXcWMeChEzN0p8t7XQQH5pHc9xCfTkX9kR
	2W4wD/B80eSX/8zTUItKTULqMEmfaZ7oaNTBHDq80ChMuTd3wPfWzR+QA=
X-Received: by 2002:a17:902:e5cd:b0:2ae:c907:85e6 with SMTP id d9443c01a7336-2b0cddb3827mr4478145ad.50.1774568861439;
        Thu, 26 Mar 2026 16:47:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:40 -0700 (PDT)
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
Subject: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6 too
Date: Thu, 26 Mar 2026 16:47:10 -0700
Message-ID: <20260326234716.16723-4-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230548-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6172233D35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index df69e0cebf78..7dc99c85b8ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0


