Return-Path: <stable+bounces-230832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK4ANXOtyGmvogUAu9opvQ
	(envelope-from <stable+bounces-230832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98082350A7A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A34FD3028022
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48589274B28;
	Sun, 29 Mar 2026 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYA0/G8i"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE826F2B9
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759228; cv=none; b=TwrElwOG+MDVHOTDiF0Jz3kZAHxpJzKOC0OmTUjhsSI1t+YBjFX4w+0vB7Ky6mbbPJjPD48zID270t2k1Hrfyanb49a2lClVIxFUx35W2fYA8j4lOqHlhfQKRLoBZZJPs4JfC5mUOzWSDasgNuYv7kITzEXMPZYo12aA5oAkOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759228; c=relaxed/simple;
	bh=jeIQTsqHgli2d9S6SJ7cxt+ur8s/ujcxps2GVpWXLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsCRLvYZxNo0RSHT8cMoZR33E/T/vyrki8qb+LNMI7PyRQ3BYYsuWgsOemYQxMQfE5bIcHmdxp2b7YOmGq+qfaLb0upPmAD452YoE8R4kdUtjaRAXUowfcoXfTisgG63MYqaNvyNq2iK1eFAZT5QtKSWT8dbBSE5XQpDIAHtYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYA0/G8i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a142464316so3623726e87.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759225; x=1775364025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reR9BnQPkWjZy1ztn6tX7OBCu0iHKhMxp0dC8tGeiNU=;
        b=pYA0/G8iv0u4EXcUXk9Jenx3Su46W682LPJV7UDcfqjc3/3jlmRFUNCi4kjag6Q2Q0
         uuITVj9q5jMRC4F2anQ5C5wOkKSO0YRaoavhJbCV7bTJkCV63d9hIOntEyE7Rh6NiHWr
         psxv+3gV7mjhU4tXDlOpp2FbrRKcqIr+8iABBt8wSLJZIwqRyRUOeCpLBOsQYVpw/pwn
         iR2rY9wOW7U5JLhLpVzpP5bUcKVAWz+aQubtruYRumIeuLRItafHYaRKP0nanmGgBX90
         RcrwTnCzWliY8HQMtyZedP3XRIj4wN+z6BMX2DFL3Hl4ndEwvpI9QXFYFIxKU7CDkzKt
         pNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759225; x=1775364025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reR9BnQPkWjZy1ztn6tX7OBCu0iHKhMxp0dC8tGeiNU=;
        b=gn2o+d/eXWz0Lde0TWZzaRxTy+AmBkiM85lqc3zUi/z2mWEqy+hqWhxLqiyJFXyFqb
         RY9fIDPcQyP66yQNG0qO1suwOJnXkI9etJZFQG6+qQum2Fgra6QnovnH13zLJx3f0sTj
         yRYl13IT6r371yRySCi06at144wktozX/8Y6rxE1jq6xl4wV82S1j/sjWVG9FuXqRMWR
         w53KJb8tW2U1C89ioSKCLbMTJezHoIUiLZcuYMqIvd9DqPwU16hKqiFe3eoOMi4NBVff
         babS6rkqgxX7oIbvR00+ZkFpNXACtK44RO7QSh4Cae8CnUcBRAwoYN+A7HUnVQsQXWnU
         Q8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEQZCFRAdzGv6GcO5Z0Cu7yelTt4PvUIkDDfgvnyPnv4Coq7bdvDzWcVox5pTOJhwXV2iGCmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cKjDQ7qyo3s2dHtqWKKC3Aw+1mTtxHuZrE0W557k0u2v/krP
	aHfo3mKe7TZ9hUPpzqI/YW3tLpy4i9C1gkDEuucYMXcpxgXB8XrzcEY3IXrVEHY=
X-Gm-Gg: ATEYQzxfrjKiCH1LS3j74SXnt2ZozhEWFpm3Qwo0DDQZfb4AJIMPOq0IZncVSbxThuM
	FhgTkOVUQxfNnDP2h+QOkqwXv+8fYgbvLy3EVgSkyL6Murg5zguRBMy+qHAR1uaigydRp2OcoGG
	lWYW/wy6IjTPCacgVOQB0zcre40t8bnuaFW8nI6v+LqPcPNFjD79f3Xjgl4H4UWz8dnb94WvOTR
	zwCB2TGrT7tpg8UWFOoSRK+Y0Uq7Bb2tkbVRGqTiLJwCPgZ1/go6Ucr3Vic9fPFm6/faNcpAQYP
	MZ7Ju1F6VeG/H4E43AQzbWoXJ7BKAdMYXe1hWIiJbHyPHry1oiXYOlnpph9JzHyyjkwyWLjq9XT
	Cw6Nn9JItmXwfzYOysUkxzoSV4iPhPNLXosEZ99swWV125MlOQjeH63U7SnKN7zQWxEMDeQ/2qV
	5oh7b2Q7nkwcVfnEALgidsPjfQlC8kl14BXvDvgQ==
X-Received: by 2002:a05:6512:118e:b0:5a1:53d1:d741 with SMTP id 2adb3069b0e04-5a2ab7e8ddfmr2791606e87.4.1774759224666;
        Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] drm/amd/display: add timestamp guard to vblank_control_worker for Replay
Date: Sun, 29 Mar 2026 07:40:08 +0300
Message-ID: <20260329044014.30276-5-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230832-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 98082350A7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_dm_crtc_set_panel_sr_feature() in the vblank_control_worker path
can re-enable Panel Replay as soon as vblank is disabled and
allow_sr_entry is true. Unlike amdgpu_dm_enable_self_refresh() in the
commit_planes path, there is no 500ms timestamp guard here to prevent
premature re-activation during ongoing animations.

This is a problem because the vblank worker runs asynchronously: a
compositor may disable vblank events while a workspace animation is still
producing commits, causing Replay to be re-enabled mid-animation and
triggering the DMCUB firmware artifacts on affected hardware.

Fix this by adding a 500ms guard using replay_disabled_timestamp_ns
(introduced in patch 2) before re-enabling Replay in the vblank worker
path. This ensures both re-enable paths have consistent timing
protection.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -142,6 +142,14 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
+		/*
+		 * Enforce 500ms delay after replay was last disabled to prevent
+		 * re-enabling during ongoing animations (e.g., workspace switch).
+		 * Mirrors the guard in amdgpu_dm_enable_self_refresh().
+		 */
+		if ((ktime_get_ns() - link->replay_settings.replay_disabled_timestamp_ns)
+		    <= 500000000)
+			return;
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
--
2.48.1


