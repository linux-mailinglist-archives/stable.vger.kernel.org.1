Return-Path: <stable+bounces-232626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ7VD6BqzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:45:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79F373434
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4AA230E1F8B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B251E98EF;
	Wed,  1 Apr 2026 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR+j0dcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A761DED63
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003986; cv=none; b=C4SUr7ZIKKGSuX4613E29ZmqhSxpm4FpbL8YHAg0A2Oxaf+F0xDv8mmDTXvasSFJeiGs2czCO3JZUtobz4gVBEDEeb0qRtwPGCfx/huwfKixou3D0SOaiWdd89aqZ9HytznSq2df3r4VFn8WvIclx7Ew9LXyoriFlG7A+z2QKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003986; c=relaxed/simple;
	bh=mQkiW4SfMzS137EmyrdOnE67zcpG0+2zfv8kd36ZGCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo6OPICykIvhO22KIkCllquCXlRy+d39D4SiPCHCzn0b2lli1sA7yA6fwFOXW8mqjeKWuclTEzBQkKe4kflYfAvUjwH3bk8T/cNJ7ISvPJW7XmdfuoWR4Rz8MUACo6m//BCGLtxvzKTvTZtbIKeYhlxOCdCd1M4pPLkIV4TAWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR+j0dcw; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6814915eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003983; x=1775608783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
        b=UR+j0dcwrEW7NoOEXqGZQ86ss5xP4Jo3RjFbTU1IQrpZNIufyEO3xV/VpvhYg4GJsy
         SdumfMFjv0cF5U0XCyT1ho6TnzMO4XScts+yxbLeAGDI6/j6D72t82CccZLNNc2mXYFG
         URV/R9JlSBYTc0Yvl9LP2+53ts0tAwJ3bFXwtRlRXD+beFDkmDu/ED+ZhLhhXsOeKNR0
         3YsRulO7j4KAlmisjIGkgXsrSeNEqQ/6U//rdFFCOKeNQXlzxk848d5apQZlCDp25oAi
         2JNfdjDfJdWHc985TvbmOUPV4ugCAoIWs47Z0yZ5W5UBbBODHDkobSNVbgdOcla25MO6
         ETEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003983; x=1775608783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
        b=Tgnkqni9Mj4UlRnwG2PrMJzdP3XBy2WJr/+l1jn3NA9A73GK/NkGhu97jWX4sgnGwr
         GY+Msb1kSaV6Z1CraKaGNYXRvRoTEm0VWGTtn7xccBU67fsPZgZ+PF5JPTRvmO/k4ogb
         LHgB32pNXduMf862kjEIxGC1Fg+8rXXiGzDROeBo3e+miWtJTJsfRnKRuOy7MUCDkyL+
         +TUARS+kvD4lxzBgsKsFr3AC6jKoFBTUjWe84jJYGbQ69BQTP6O6Trei5cNEdqNo0yQA
         yAxFoOP5on0BEsmYG6JyT8EMQqNJ/TlhSfJYPfGPek/DDvgddnjiY0ADAPnKHx6yLemq
         w7qg==
X-Gm-Message-State: AOJu0Yy0a/BBw98xlAPWHAjnx0o/iq13SDzfIJgip3E6JDO1rLCkfMlW
	fKRnyVDhIZTezNh+7tZ8bnjxNLKdMep4sj+96qFWLAaVTCYRd+F8/AI9ZYi+dqVm
X-Gm-Gg: ATEYQzzLI93Y9oSgge9LvL0IP0lnzQZODt1EjbmSOZVAjMjLTveN9XZK+M6Nm4IPVGc
	oz1BU6kp+b+L+aO2UNO/9DQ+9wPNtCprPYCFSM59c1JXb3Ws5iAUH53OtznWoMo5Cy6yew9WdDI
	n9iISQGNSkGYJestz0tbBUEsiykX1CRrSZaiMgtDOG+82jhCRpvkNltKj3blWPwoM78lefQGo+Y
	8LL7mrSKcFOMsRa3YIBOY6BdpsoyExsCuRftv+bNupjjUv6NDXIdQh9nHy9M4q7/oqOzYsO+ELu
	c75TdmFW4H8Vuwv5aRSjrVeW1ksyLuGOvvFrZIUAl4GhMlagquQe7po5VDesM3SQCUdD1B+ukkZ
	BAOZCDkHzz5e9d6ERjwGA83SbR6uS/S8IIjhv4DrZOUUQI+czkKz8B33ZZlGzFEuFwhgIn02IjV
	QNSTtsyFJEUH0aOngnQef0LfNHqZHF88PjvopeIQ+S8osivfcTCKb9Hkw=
X-Received: by 2002:a05:7300:fb8b:b0:2c4:b8d6:45ce with SMTP id 5a478bee46e88-2c932aae004mr813092eec.25.1775003982823;
        Tue, 31 Mar 2026 17:39:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:42 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 08/10] drm/amd/display: Disable scaling on DCE6 for now
Date: Tue, 31 Mar 2026 17:39:06 -0700
Message-ID: <20260401003908.3438-9-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232626-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: BE79F373434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 978c024c97ba..3f9ea4fdc7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.53.0


