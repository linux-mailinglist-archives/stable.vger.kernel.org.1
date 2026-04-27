Return-Path: <stable+bounces-241372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MhBO2GR72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:40:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACE947689A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF0203035633
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52978359A65;
	Mon, 27 Apr 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruKz8AZh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D238178
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307578; cv=none; b=p9CplhLXUjE2Syi3c9XqaeOPGiplMuijkiqhA1SruYT3D9uw5/ByQ7FeKK22XsF82WE2xKlqkekprTs5IpV5PLuI9tKcJszxx2vQOeyVolo0PytuddP84hS9NG24FY0nVkdL2kJlPgVkm0RHLqauyWImJiQwo0VhgJLwxlIHaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307578; c=relaxed/simple;
	bh=LUblKTbYjisEkGY2t39Z5jXnvaPL+95I17rV+EntEjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTViQ9oJc5mvcQhFOaQUpyM1byaj/PnuJUru6qlSlALYBDtH2oUya1VXVH2oUYjaXtd7VJBN3SCpOw+rkPhV/jvecuM9ZqGnl4L4yW2Qvdd7Pv3vSZQEYy+/vJUv6t5sBCIkFF818zVmymrRWfNOOjeiySaL2Ke1jM7+l6Ckso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruKz8AZh; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47bdee5bfc4so1849764b6e.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307575; x=1777912375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj5JX4AXyRriyoV2ZteJLL2hjeTTbQg2WsoxX3X6R18=;
        b=ruKz8AZhErSkGbpVAcZny57H/7gi7J7Dn0zRebqk0wdK6nw9zOqXtM+Oc0FJp0sXYz
         oLrKdqbxAEIUtfT123sMZmwGeftB6v5TDWe+tX7W8Jcr2r6PYc2xYDzl9T2tr+8QaLta
         eDHsGHgzMaxXesH2JLLOXL2gJCkuGh3KLxnE/v9ol822VgVAhUeb5PL8thWeKvl6HJ1J
         2Es85/lAFPhZx6txZMd8Kx91UU8WPSeNIcZn+zDqHbkaarWbroU7RNGuNyu9HVFx5X6I
         g3GZNRwi/69w9Ii+fF2NpssqOnCy+NznPL82CQgGJR+woPMEAXe1I9N9Iz7PiHK66Y1O
         CJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307575; x=1777912375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj5JX4AXyRriyoV2ZteJLL2hjeTTbQg2WsoxX3X6R18=;
        b=UzdvBBpMI9REhzvXkRA5TKZpFDipNwiCxRhKgDZJZ+uru7mnuKahK+r4sYIbZtcSKU
         ad2z5AySGSu2ARt3r87irO+mo5wbO56vWCschFx4CejevS6+oh6d4pYyslH+VYqdMYfZ
         KskDb5ZYxJji+tcneZW1bFdkqRIib/l/jVmSAtU6VHINc5TZivq1W6DGLoSaQ4IOXPh1
         u8JmzlLrVcOdOWpUDWmP2XkAQfGQQVT/dVsQjAk+U+gzlbnBJ3oN+T1qP76yvCLEWua2
         Q52guDIMDaOiS00kodopVzOMlBdXN2TEZzbIUnUxa9FnwLH3CijNGhsGZTfnHaWwYpUF
         J16w==
X-Gm-Message-State: AOJu0YzKFnmDa6mF+Unu2uOVADhbdvYthhh0ZoiAergg4Lr0N22waPXI
	bEXSE8DIjBZzEPhK0Ib4nnsIFmpjD7S//Sd0p0pWxnvNzhYnODoBvcg=
X-Gm-Gg: AeBDieubbZyHg/usQXvFd1pexRyCPqILi/Eum7afc0rhL7v7DOlQv9drpKcpKvTGblW
	+/UHy+5ketpcPMBkk8JRbthbuWl2chH1RVWbmvx10ebCWpRRXjyndKKfDFkAqUNvFpqSQYWaCbM
	iJj2tTOBW5RSdmBfM8nUIcxB03I/OFYTWUeaSF8G3+bqI4qpUxL7SFkJpMtYHNlya/ftK+jliQV
	N36u0tFNq3iiykTO1/bMLZKrvRN3WWOGoGYVfJoYvM05FDphAS1yMub3skIaIZNJZj6lj0F0lP7
	hleaIG+M1E0CPqsmYqVGBRXZGpVwp3kivfkvd3rb/aLWoDX6Ty30qs9HCJ8FvK9Co9Ql/u+D0RG
	yj79mZvXNbGlAr3wxeydN1duUiXtOqoW1kMTJwAHKCjMyPZrruDXeZCHbw60q63XB+YkWOWhXoJ
	GcXc897mo4yJ2vSF9XoJ7dEUOkxa9v33g4Z65ydv/88I9cQxEHxgvviXNntsI6xBZteKlvMShf1
	24U2JvoR/IfL1zT8Sn5wzgFTq710FYvxbQ=
X-Received: by 2002:a05:6808:4f0a:b0:468:698:a626 with SMTP id 5614622812f47-4799bf4b93dmr20665738b6e.22.1777307574544;
        Mon, 27 Apr 2026 09:32:54 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc712b4easm20653092a34.23.2026.04.27.09.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:32:54 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v4 4/4] drm/amdgpu: do not pass AMDGPU_FENCE_FLAG_64BIT to media rings
Date: Mon, 27 Apr 2026 11:32:49 -0500
Message-ID: <20260427163249.13645-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2ACE947689A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241372-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


