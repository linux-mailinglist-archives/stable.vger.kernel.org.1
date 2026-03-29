Return-Path: <stable+bounces-230830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA2IAzytyGmvogUAu9opvQ
	(envelope-from <stable+bounces-230830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:40:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A52350A63
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403843019CA7
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 04:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA0278156;
	Sun, 29 Mar 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKvnwyaA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256C275B1A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759225; cv=none; b=PI5lFiwm4CpK8mDQrPtkctqbI3nhE7jqOO1tjy4thui74BdVe8Ds1C3uVmn5kdIpYGKeDfKNYD6sxhMCFLrPXEoOFpVObsaE47UP7XVKbL6HoKQQpuRKjg9Nzi6TONmj3UL7c+HrTIzLBRgAK/pl9iptEWP7f0Ei2L45wFdnmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759225; c=relaxed/simple;
	bh=oqc4QEU907PahR1xN0Cao5cuGtwoCzBD9huja4Y7Zuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8LtZebQf32uSlpsPyUpAB8Ust+7cHc3b5B1hjGcpqNk0mqiCi59sdjghar+kBKD54iTrh6W/+omgey3h1ftWDuIIw+gKG9qjfjt08jYgbY1TCUlUe3V/oKCn+DQTkxotfB8kKqU1Log33WCnbFvUyXVq1rDzj5o8au47bxiI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKvnwyaA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so3922463e87.2
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759223; x=1775364023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfxKOQy6FvJNNu8OfNtSYo3Uuobrp4S+heAsvLGL+ac=;
        b=FKvnwyaAOO47sI5c3EPZgIttoVzSBR7XXud0r2g62gkysnBw8h5RND+BNZyedMqgPG
         HUvZlhnKksltv4rE7Vs1LrJd8BPl+tk2tqdoPcpYVQa7U8Wos/eP+iL2cP89tRpVR0wm
         /7Y1cNfe5Cgq5FSzcr4P2W2UUr1rL83bslbtq38JygTx21voO//FexsySXFZt8obSQGH
         uVvcfRvUa4SHgp0xERq7fvyLtA0oIUajPZc2cBwQsGY+Rh/CR3IsayueO5XKceMtN4gN
         rDflHN43Ve46UQ/oBL0KMjr37+YDbxehZ5+OG+wm/hca4M5JU2GyUAiTS66A0Gpio+7m
         IHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759223; x=1775364023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfxKOQy6FvJNNu8OfNtSYo3Uuobrp4S+heAsvLGL+ac=;
        b=JHU2NZHYbeQPGShb/cudXaT1J4lq13F6eZnJMXyV2zbjhj45p5B311yP6/KW/Tsf/S
         orYuBotmyUL9Bl+c7orSulDDN0QZAlDzcSRwCAxyYQOUbIFiI905iCDhOFPCRCIbQ2SB
         cRUN+aLD0vISj8189oROJCSrXPZCOdBtkdnaAikM8/9TN6ydxuHeYdYnYODaTEpqjS6b
         rpv0n/W1ITUpiIqDCs6bHvw0Q0eXIS+GM4KOpNhdeejuV4nrvRLI42/1qsSNRtY6rqm/
         qkkiII6UirtlUJPqrM3s2T86UiLK6gPBXxg/QrhPSAlXydQv+INVUzQBdj5YYx9XWxNC
         vrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNvHr6lBPLRCXQ29D79YdhvBFuHkhnXscCJrrCXgyImbWiy0Ij1eVTqSdKhuEBtATnjB4LwhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELSaptnVD8dSoss+2bbb/j1oUcpoL5ci5UTvQgcXEG0oyRZjx
	X8ZQmvsqYOZY3TTAB9+fhEwyV29jyK6SGjbVBe4w5DAmm+eB9GCvvlH7JmDwpl8=
X-Gm-Gg: ATEYQzwWVK/w6krEKLV4mlugRWL98e77CUFNi3CDxL4erAs0LPdZvAZLr1fA3mUvJi5
	pez+YV6I2hx3/cmFMRuTZF9U7QRk2cuqbF1CiiSCcJ4s1XyJAwbiQ6R9paFhTSViSiDRg6w3GVH
	eOCgUVT6litiS446ncr5hhlqFIvTLghXhubhQWc8Ik6fhN9Jv2Mlp3KQPk2cdaLFzrFsHbWmyZo
	k7R/N0O6NYzCqSTuB/4ioXtAvZvBt0b9IVrtteu/ul+Ppe8MqVSsYAbb+BkfBPW3gQ8iw3nJ7Y2
	uyWHKfdNm2BRth88v7Y9w5IW4SMNzcLAQMghyFggRQsg7kQTVi/9i5sGVfq4lJn7Yw4KE768253
	azNla/qeT7IPVPawbBH/xSzmTlbE7IuOgYjEyyjGjopYU2aCP0OPsY8mzI86jIK6TNzmsT8dTk0
	2kkN1VHdldm1Yy3uafhFSrWP9v/+o=
X-Received: by 2002:a05:6512:8006:20b0:5a2:abe6:7bcd with SMTP id 2adb3069b0e04-5a2abe67d29mr1866036e87.19.1774759222537;
        Sat, 28 Mar 2026 21:40:22 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:40:22 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] drm/amd/display: add replay-specific timestamp for re-enable guard
Date: Sun, 29 Mar 2026 07:40:06 +0300
Message-ID: <20260329044014.30276-3-voroninan95ton@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230830-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 78A52350A63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_dm_enable_self_refresh() uses psr_dirty_rects_change_timestamp_ns
as a 500ms guard to prevent premature re-enabling of self-refresh
features. However, this timestamp is only updated in the PSR-SU dirty
rects path. For Panel Replay, it is never updated, so the guard always
passes — the 500ms delay is ineffective.

Add a dedicated replay_disabled_timestamp_ns field to struct
replay_settings. Set it when Replay is disabled in commit_planes, and
check it in the inner Replay re-enable condition independently of the
PSR-SU timestamp.

The outer if-condition still uses the PSR-SU timestamp, which is always
stale (and therefore passes) on Replay links since PSR-SU and Replay
are mutually exclusive per-link. The new inner check provides the actual
500ms guard for Replay re-enable.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1208,6 +1208,8 @@ struct replay_settings {
 	uint32_t replay_desync_error_fail_count;
 	/* The frame skip number dal send to DMUB */
 	uint16_t frame_skip_number;
+	/* Timestamp of when replay was last disabled, for re-enable delay */
+	unsigned long long replay_disabled_timestamp_ns;
 };

 #endif /* DC_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9887,7 +9887,8 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
-			if (pr->replay_feature_enabled && !pr->replay_allow_active)
+			if (pr->replay_feature_enabled && !pr->replay_allow_active &&
+			    (current_ts - pr->replay_disabled_timestamp_ns) > 500000000)
 				amdgpu_dm_replay_enable(acrtc_state->stream, true);
 			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
@@ -10227,8 +10229,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		mutex_lock(&dm->dc_lock);
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
-			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
+			if (acrtc_state->stream->link->replay_settings.replay_allow_active) {
 				amdgpu_dm_replay_disable(acrtc_state->stream);
+				/*
+				 * Record when replay was disabled so the 500ms
+				 * re-enable guard in amdgpu_dm_enable_self_refresh()
+				 * and vblank_control_worker works correctly.
+				 */
+				acrtc_state->stream->link->replay_settings.replay_disabled_timestamp_ns =
+					ktime_get_ns();
+			}
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
--
2.48.1


