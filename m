Return-Path: <stable+bounces-230831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLwNWytyGmvogUAu9opvQ
	(envelope-from <stable+bounces-230831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46730350A73
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFF230247C7
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6B278156;
	Sun, 29 Mar 2026 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7fb5+Ws"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84F26FD97
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759227; cv=none; b=XXKQG1Ex3KxW8ahy01rz6LDCz4z8a9Og15JMTdUswpBL3UTMbt9oMnT/nCkylYlrEMekMoejgyqiU02J2KeFOs1drBP0Jx03lwRasArL13kehWmX/Z+0HCVfuQ898P71a3UBdYLHN0zMIYiGa4FwLyHhOo+yiSiuzFvXwflMQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759227; c=relaxed/simple;
	bh=irwSiKDz0DgUi7p0E/jnlelSCR4oY62lEh0mqxDJG/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFJun6X0PwWzYvzEr7GRxdmeFmZLhml5i2AYjXZVPD6YNEt21OfhVuCfzFgnHZG3/ViuVqauCDWmPHRYkR2DAiJUkT+lew+iREkG2njip0WSnlrhN+hT3bdrVpRC6PThrkOfvrD76ndFHFOLlfZI3jq0BCqUihFQfIVQm/s1Da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7fb5+Ws; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2a5236811so2511983e87.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759224; x=1775364024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwayw7hVc2wLnLxV5KmPEi139DKPQvAF6YzQKlIAl14=;
        b=S7fb5+Ws0J7lx6sA9ba8vZhpz8er76Zt017B/XA9rRR1bt0FtT3zRZeAGsjyViL/eH
         Ru92Bf3XPgX9Ghe19Kaojmy1IoI/Ghg02QQuLAK8Yr8+OWdrQFKmL+fW/ps0/GIlsdsN
         07NBtCsH8XmZ5nBebEczmllVMXeEnZ4JFe3aeJGEGlrPMn6cNea5BNbeqais5vOappVN
         cxGy/MUbuSSZGtPYCX0y3DVNyRtc0Lr/MsUOxe9vPBNoZAkeW7zVtbqDvkkeeo7z9ZMa
         kLxHwVshRj1YjK0GAdaKW12zfy68cQcjUrbXPI0d4Q/IeiiDpUyuUziiApIuAgU46VHY
         82LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759224; x=1775364024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwayw7hVc2wLnLxV5KmPEi139DKPQvAF6YzQKlIAl14=;
        b=dcMRaru2j3ZRDppqN4EMQcFMXQAfELoQNfIVk5cAfQ31fZKbwSeqCXyqXP/eEH42Et
         LLCbo1Fwcds+sIvHUE1vsAwIQCwDARgvt/UUDiAugbu+I2G+K4NQooEZD85dhTisXD7V
         FYMe/CR/qIrTXTed/g0OvO31G5xNG3LI0gxV/BvnaIiL9RfejmdfQ/I4OPIUWoS9hFfI
         r4bytNou6LDLbzKoZOt6qyUGQ7a2zKXTLo7R1bQOV92RobI7EjiRoVxMtb7NxolNwgkC
         WfAwkS/carXomcN1V2hE3GRLfjNxlgRv7fVkxCK7aqaruNHpROjxSsFPATEwrv/jMav5
         dE6A==
X-Forwarded-Encrypted: i=1; AJvYcCXkM76Zol9w6G5EJQdFWssBhbdqWamRDzxOp/GqvqcBKCt8hcs1R1ZKTa7s9jTPYNZxNBqTmVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOR8lVPAF3M/BjWQ7OIOfW6XEh+lyrpOnqZl5bCB+jEMBBrVf
	+Iphr8/pQg6fSTv6At9mg+Vdb0ocoGvC442tQWMGAmRM6i2PggwFeh0=
X-Gm-Gg: ATEYQzyvBnhce2VqAw3ZE7xLi6lkLYJj8e5EEo4gZYcy93n0kXOdx04TYwm25Rxchr0
	aoYhfG68jdv7drfwmWE3rPWeH/gDfaEeRNwCTQ9eD8R44sQDw1dL+C2JfLW+xG+zJT39lhWAOsA
	K4ckZXAPh49KN1JcyFNI2EdRXNDwUCkjmaXOuziFVOCKMOABACa+5ZNbOjgCNWqHBpb60zvNAIs
	SOO/dMDAk8L+1jl5hL/OCQC4AyaU/8twtFvNfMKYxAk1NX1QbYg8kK9Dm8BlY5WVsuswXQ/dCjb
	uIxNLcx02ST9neiaSazo/EwLscTcEnw1UDhFbpjemRWQ29GtJZgRFbam+19/EDD2BDps+tN/HPu
	oF4KYc53ZRwXGJRt/TOVMZYgl/lj2KOi9eNGOdRBj9QY5LehRk5aFDHcRUZw5hS2DlKncvdz/ad
	gYHc4qPStJlP5YZvB0Wop1w5yNtwY=
X-Received: by 2002:ac2:43d2:0:b0:5a2:aec9:95f8 with SMTP id 2adb3069b0e04-5a2aec997cfmr1288731e87.17.1774759223449;
        Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] drm/amd/display: force full frame updates for Replay on DCN 3.14
Date: Sun, 29 Mar 2026 07:40:07 +0300
Message-ID: <20260329044014.30276-4-voroninan95ton@gmail.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230831-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 46730350A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On DCN 3.14 (Phoenix/Hawk Point, Radeon 780M), the DMCUB firmware
produces visual artifacts when Panel Replay operates in selective update
mode. The artifacts manifest as brief green/purple horizontal bands
during any screen content change — workspace switches, scrolling in
browsers, window management — and do not appear in screenshots,
confirming the corruption occurs at the display controller level rather
than in the compositor or rendering pipeline.

The issue is widely reported across multiple vendors (Framework 16,
Lenovo T14, HONOR MagicBook) and Linux distributions, tracked upstream
as drm/amd#5087. The current community workaround is to disable Panel
Replay entirely via amdgpu.dcdebugmask=0x410.

DCN 3.14 uses FreeSync Replay (DC_FREESYNC_REPLAY), not VESA Panel
Replay. Unlike the VESA variant, FreeSync Replay does not have a DPCD
SELECTIVE_UPDATE_ENABLE bit — selective update behavior is driven by the
dirty rects that the driver sends to DMCUB via DMUB_CMD__UPDATE_DIRTY_RECT.

Fix this by forcing fill_dc_dirty_rects() to always emit a full-frame
dirty rect (FFU) when Replay is active on DCN 3.14. This way DMCUB
always receives a single full-screen region and never attempts a partial
selective update. Panel Replay still allows the panel to sleep when the
screen is static — only the update granularity changes from partial to
full-frame.

The caller guarantees that dm_crtc_state->stream is non-NULL (the
function is only called when psr_feature_enabled or
replay_feature_enabled is set on the stream's link), so no additional
NULL check is needed.

The DMCUB firmware on newer generations (DCN 3.2+) handles selective
updates correctly and is not affected by this change.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6347,6 +6347,16 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
 		goto ffu;

+	/*
+	 * Force full-frame updates for Replay on DCN 3.14 (Phoenix/Hawk Point).
+	 * The DMCUB firmware on this generation produces visual artifacts when
+	 * processing selective updates within Panel Replay. Sending a single
+	 * full-screen dirty rect avoids the buggy SU code path in firmware.
+	 */
+	if (dm_crtc_state->stream->link->replay_settings.replay_feature_enabled &&
+	    dm_crtc_state->stream->ctx->dce_version == DCN_VERSION_3_14)
+		goto ffu;
+
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);

--
2.48.1


