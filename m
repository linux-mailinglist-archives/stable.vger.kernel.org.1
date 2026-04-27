Return-Path: <stable+bounces-241371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLaSAEiP72mhCwEAu9opvQ
	(envelope-from <stable+bounces-241371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:31:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F3476669
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8D930015BB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CF3D6486;
	Mon, 27 Apr 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVVxckr7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96D3D6674
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307459; cv=none; b=te2+mqyR/2x6Lod/PlTdG50N3u4ujHyWoj0ee8nlQaJnvWMyogJjzjkIUXJ/Tse/+1YlYTMA9oBVgJvWgyeDWB2vsGUdwyd9lMAxc9rN5UKHTgIrA1pdaou4QZzkU0UZWavwDZFi4lAeZ53CARTPOq3ttLeXfrg6TtcI26ah1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307459; c=relaxed/simple;
	bh=DW8DoezT0JbQxJL8IEdwyzlR41zUIne1dKlik5SUTxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cz1aNxuwtpFRBIvwgB30Wz0YfvwR09AKMoqRynazqkxOxDMwbOXg65QzgGefGf/4SQd8dY/E6x7ynXMqDLlEZa7i/3LUqLNxt9l27uUM7mXGxFVxYFA7BaUngOB7d2r0GVoBoZ87DHWO3qGbFnfbScltbcmKj66Qk92jqpWzOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVVxckr7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ea611d1a4so3699782fac.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307454; x=1777912254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKeSpoaxW3Y4UJQ+GULSPJ7b2Fo0YRA8tP4PPYc/sbo=;
        b=UVVxckr721fMKSUJUkVazI8UJlCbOHKMGTPRMDhUf58Z+ZbbyzQcA0vFJ2szwTJwyZ
         U+WHz2zA1VPeAc5eBgy8V+iMl3QV6HyX2a7RkKLvzYHlJ2qWeczNcKbcOSvtgXAgWZsi
         VaJAMkOCyAyrSk5RBFIgO/5SfUksWh3txxNMqhjtNj1oDTqZyuxOkfp1toO/6NRD8+GP
         e/35GuOSFX655oKQFXW1vsrahOxFWIzLV8lWGKMcF6eAp/HR7dT5B8rEsEW29mUWQvAI
         Lho6XTvMDFGCQVZdKehDl+C325jz2nFLldrBCZ481/XWEHXaylLaVDjLq0V8zaDOrpKx
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307454; x=1777912254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKeSpoaxW3Y4UJQ+GULSPJ7b2Fo0YRA8tP4PPYc/sbo=;
        b=TxlPcBdvZJUAj68TkZ0y0Mki1flnikyyF6hju/H8ndZ7eLVp3IRDGv7qnls4nl1BkW
         vNy2npQu9awCfXde74caS1x1OsY0vfmJp3I83oHyBjRxPbWmUo14lsP9fKT5ORo3HhsQ
         3+et6oyY8Y3kLhm0tschN24hoasLG5ShXcuB+PYdQMeExifMeD/0xSXzXWUF0PtxwvxU
         3z0A6iKtm1TZ3x28uoPzzzTAUKBBfjpmf4RrnAHwYiSFZEhkwbDSedjvWsO+qK8Rc7BG
         95NxY4sIpSn7IzQU+msNAd0zJ+ovr1prPjvevW6LbeL8kp+FP/mizWOFZa3t/a9SbNX4
         /sxg==
X-Gm-Message-State: AOJu0Yx3bKvw7YHtkjye8wkFq027HiXGGKxYT/23CNVm8IIbFcetJNd2
	oe3ki19LxJTX8gBoBSYFdWT7NeNyo0nZh/p86xQMcVjYckAuU7KfsI9SPRjhM95XNQ==
X-Gm-Gg: AeBDievYj4g78pQLX/QWOg4F/NcLZqPNfI04w19gaFCz8mNn4RANHnMN2o90jUIFkIB
	93+W0HpOWw0t6zUBQdgR0x7MyKT3gKCIK8y+nl3YR91nW3kh/cQiDFDZKiDam1SLbEn7GvQMojk
	DyPzpEeLLWz3BMiVYcah7cyU8PlwAVgQnK1UQWdWD9t8b1cN5TAmNR8HP5RFj9PAYyxZGPp5mP+
	dLX/9TraQpw/ICpippE4jUYgg+VeBxuJpkyJD1li8SO8VpMmpG2c9RCPtgk5k7QQyWrCEWy7i98
	Br44J0B8n0zuo7iFkDOijPqhWmflsVH6+j5rP6ceIXqnCstOHHhKrilZoFb5wH1DrtoONbcTxk+
	1NAdOLMxcIxp/EmV23zeE3eK0yvL03xc8D+8mmZEOVftRjb/osLPoEKpyEhXZs7+vD6wpGxZpUp
	zWMDhfZlTB37Wn+4apGkq/20+o6mf/B22kcFiC0ZH8xHX2SjcNcBn0JjoZPLte11f+0/AQQ2R+5
	oRs6neEVkoCY4M6EoS763Yrw4oL5aou
X-Received: by 2002:a05:6870:c227:b0:42e:49e1:e50d with SMTP id 586e51a60fabf-42e49e1f8f3mr16488309fac.27.1777307453572;
        Mon, 27 Apr 2026 09:30:53 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c054997absm23264873fac.3.2026.04.27.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:30:53 -0700 (PDT)
From: jbmoore <jbmoore61@gmail.com>
X-Google-Original-From: jbmoore <jbmoore@nooks.dev>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v4 4/4] drm/amdgpu: do not pass AMDGPU_FENCE_FLAG_64BIT to media rings
Date: Mon, 27 Apr 2026 11:30:24 -0500
Message-ID: <20260427163024.13512-1-jbmoore@nooks.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 181F3476669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241371-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "John B. Moore" <jbmoore61@gmail.com>

amdgpu_ib_schedule() unconditionally ORs AMDGPU_FENCE_FLAG_64BIT into
the flags when emitting the user fence for every ring type:

  amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
                         fence_flags | AMDGPU_FENCE_FLAG_64BIT);

VCN, UVD, VCE, and JPEG encoder/decoder rings only support 32-bit
fence values.  Their emit_fence callbacks contain bare WARN_ON()
assertions for this flag, but the flag should never reach them in
the first place.

The VCN_ENC_CMD_FENCE hardware packet writes a single 32-bit
sequence value to a 64-bit GPU address.  There is no 64-bit fence
variant in the VCN/UVD/VCE/JPEG command sets.

Filter AMDGPU_FENCE_FLAG_64BIT at the call site in
amdgpu_ib_schedule(), only setting it for ring types whose hardware
supports 64-bit fence writes: GFX, compute, SDMA, KIQ, MES, and VPE.

Also convert the bare WARN_ON() guards in the five affected VCN
callbacks to WARN_ON_ONCE() to prevent kernel log flooding if
the condition is somehow triggered via another path.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: c660f40b1ef3 ("drm/amdgpu: fix user fence write race condition")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  4 ++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436..3c32a6197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -297,8 +297,24 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	/* wrap the last IB with fence */
 	if (job && job->uf_addr) {
+		unsigned int uf_flags = fence_flags;
+
+		/*
+		 * Only request 64-bit fence writes on rings whose hardware
+		 * supports them.  VCN/UVD/VCE/JPEG rings only support 32-bit
+		 * fence values; passing AMDGPU_FENCE_FLAG_64BIT causes their
+		 * emit_fence callbacks to WARN and emit a truncated fence.
+		 */
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_KIQ ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_VPE)
+			uf_flags |= AMDGPU_FENCE_FLAG_64BIT;
+
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
-				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
+				       uf_flags);
 	}
 
 	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index 2b9ddb3d2..9adc7607c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -27,7 +27,7 @@
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e9d790914..729c1c378 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1548,7 +1548,7 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	amdgpu_ring_write(ring,
 		PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_CONTEXT_ID), 0));
@@ -1724,7 +1724,7 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 static void vcn_v1_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 			u64 seq, unsigned flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e35fae9cd..a020140fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1537,7 +1537,7 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
 	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
 	amdgpu_ring_write(ring, seq);
 
@@ -1722,7 +1722,7 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				u64 seq, unsigned flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
-- 
2.43.0


