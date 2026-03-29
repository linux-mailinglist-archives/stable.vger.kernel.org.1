Return-Path: <stable+bounces-230824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN+CCnejyGnBoAUAu9opvQ
	(envelope-from <stable+bounces-230824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08535097C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D92F300721F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 03:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A81E5702;
	Sun, 29 Mar 2026 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwFUJshR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640218787A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774756720; cv=none; b=G1imrJRIuj6JMaxzx8R0bIYK8G/yzZ7nhFGLEkdFCqJMhfSR1D5HZrw7KIIa7DB3PiyvbM9WEEYr0sdFirvcnx5MYzF8HGxOyTXCN6qgsI1PVKMX5j9YPVMjohoCyse2DZEMyQlA4w5pYq1Fa49K8GQXdQ5s0npyFrWf6H2cxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774756720; c=relaxed/simple;
	bh=hrurfKISzzueruojuIRwToXP3UUX9DY20FWSEQTWkkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdhqwarPMakAXk6J+8tMv7kbeqsra+mkn5wTDPfi40KD/FDw4Ny258VqJIuxD9+A4FNWp//N6tAnAbh17Sfi7BpcEamLB3kszN84cT/EKoHpxB0UYSrWM5wNUaryCrrJhfiRdpBMty31ZNPfNPSUrqhkrN3bEt7wyaWX2EAFjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwFUJshR; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a12c19affeso5752906e87.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774756717; x=1775361517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tCXEdj2YgaEL32qjVel/tUPs3C0C+6eC3HnQoDVSqc=;
        b=SwFUJshRz/Re/ucPtXdQNjtXmkUXY3PM34xmKVLVPA+7MCWGAqORnt7K7ZdQ3hx+mP
         EHSLuGMiKzKLgKix8seoQ6oJ7IUeXlptz3XCOJrMKygCCIqSaByz0JMaeVIeW7g1bhsF
         q+IFRb23BpMMX1vY7b9BbsmyTQ7UZhNaGFOzfol18D1J/MsrOBoNPMD4NPUc/qIkKsaB
         twEbftPc5b0zT5I15JTwZZudk18Hn8tyub0ZMh/wp6K7C8Wj0cPCeHm36BTXJXiFVC99
         SRqlDl/b62ALw14UXsrpJO1RXZlb2E/PZVdEZHsKYSbJHVUTEOJXx8bdk3pCtOyMxqNJ
         eLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774756717; x=1775361517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tCXEdj2YgaEL32qjVel/tUPs3C0C+6eC3HnQoDVSqc=;
        b=kiHWGWCrRlg8k6wiR6JLQkOsLy2/FMLrJmrDPNIviPSXZPMuJkGxA5DXY3BU3j+xqy
         kEr+VVEy/PusZ2CL2tK58qsR+TSi03X5DtqDgWBvjI1tinuRClTvuGKfb6j7SQ5Kn7sG
         UlQX7Xn46fQe7a7vloFrJKCzqnMgAZ5x80b9uvF/RrWB9rPq3B0NGhMxKUClM8eDcNZg
         I3M0+2PE/o22cYpNpIRX7v+Epx+7b53ZXUmIaxD8+XYhxRM0gScZ+jubZBGFbK+jf3Qg
         VW31+xxIi4Ks5SWLdWs6Uv1fc/PtwYKklmkVr+eLfIFFQXODoNG8xbRoiwEuJkiNrCS9
         WHFw==
X-Forwarded-Encrypted: i=1; AJvYcCWJcO5r/ia10PiCCF9AKDd0dXWEfM+dJnwksweaZUQngghjuVSO/8jYkoIo1v/c2sKQqR+7Umo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiUHGtv4TJQ5PX2zG/flTmT1J2dYawFYwdE8PyGfKlY7UO2JT
	Zz8O4Ctc+w95OZM86C0AT4Ozo5T6qdAxRDLtjWckYn8Pi/iHBCz7TB4=
X-Gm-Gg: ATEYQzxGqVckEug0P7RmRXsTCA1kUiTQiqK/KIn+vLunIyq4jAK7KO7H7yBsUMnFNGE
	awWmJ3vY1gZmsNSGOCvnNds/0NMruJHfB3nq+o+1t1brl5F4J98bipm/AZQB5OHxpHlKR2LYTDx
	LDOtZ0CaMBSY2JrzBiGMLMdMyzGtXvto4PMbQ9kJSlrkb8ax5QhqESajczj8iQc5YOMQoy8LW/M
	avpkUlYVipcxEJFQtskQBIBjhd2j5tuyGTdGXhkNbMaeC2OnP7biiH8AtrN0g2fR1sTdytXADPy
	uVree1TP3F5gIB2UukLU39eKdCpQxzeXBJmMmpEvOtRteshfLIq7dvnFDUm3IZutfZiR8YR/AvL
	8/6VJsjpHKeRf3f7Dt+o6eJ+2dRPjbo/f4xBlGqHAZsdAYPvwvkUbcngajRTc3XA2txUtZlyuHs
	3sdxkGAUwqB7p0bSjvr5M3795ZHKw=
X-Received: by 2002:a05:6512:a85:b0:5a2:7cde:3438 with SMTP id 2adb3069b0e04-5a2a508cfddmr4020108e87.22.1774756715989;
        Sat, 28 Mar 2026 20:58:35 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 20:58:35 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	alex.deucher@amd.com,
	tom.chung@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/amd/display: fix Panel Replay using stale PSR timestamp for re-enable guard
Date: Sun, 29 Mar 2026 06:58:28 +0300
Message-ID: <20260329035830.21953-3-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230824-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1A08535097C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_dm_enable_self_refresh() uses psr_dirty_rects_change_timestamp_ns
as a 500ms guard to prevent premature re-enabling of self-refresh
features after screen updates. However, this timestamp is only updated
in the PSR-SU dirty rects path (when psr_version >= DC_PSR_VERSION_SU_1
and dirty_rects_changed). For Panel Replay, this timestamp is never
updated, so the guard check:

    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000

always evaluates to true (since the timestamp is 0 or stale), rendering
the 500ms delay ineffective for Panel Replay.

Fix this by updating the timestamp when Panel Replay is disabled during
non-fast updates. This ensures the 500ms guard correctly prevents
re-enabling Replay during animations that generate a mix of full and
fast commits (e.g., GNOME workspace switch animations).

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10225,8 +10225,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		mutex_lock(&dm->dc_lock);
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
-			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
+			if (acrtc_state->stream->link->replay_settings.replay_allow_active) {
 				amdgpu_dm_replay_disable(acrtc_state->stream);
+				/*
+				 * Update timestamp so the 500ms re-enable guard in
+				 * amdgpu_dm_enable_self_refresh() works for Replay too.
+				 */
+				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns = ktime_get_ns();
+			}
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
--
2.48.1


