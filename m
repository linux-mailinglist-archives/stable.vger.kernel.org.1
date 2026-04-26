Return-Path: <stable+bounces-241196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JhjDWmJ7mlyvAAAu9opvQ
	(envelope-from <stable+bounces-241196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51D46B53E
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F4E3008089
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC230596F;
	Sun, 26 Apr 2026 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9Bq+wQ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532B2FBE1F
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240412; cv=none; b=hbxkgc3bf9w/lFCs+xqW8d+A1awySllPf5Cj4o21gyHgMnoUf10AlheYBWqC3poFtOZ24vt3lQOzNBHCj66LwJLEcmIhBfxJ/Uufyw/YELaV6VHMWEOaEltHA4NwCreSXIbGroY+pxk3Mw7ivgoKSNcZu9j2kOuGleTU6Gl9uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240412; c=relaxed/simple;
	bh=Wi4Fv0juR5nS1PAq5xdcIGtRmh6N2GwGB/2Aa4KaFW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bie2nGpVry7Ev8XGGUY6iXzCT/LbfbUecG1hNQlgG28I45mffSYLSB32y7nD2+Zd+oJaW9DBvu1ppIM7b0GOEdBDpzEcBhVMul3U/o+8M8m4OB8Rugi7eMgO7g0VSxop/1OrAaxLo3sUqUdHndNwIq+2Ji9Yri2JBrxZiw5l/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9Bq+wQ7; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de431da8fbso3818500a34.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777240407; x=1777845207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2/6bOX3xGdDGZcmRDZLBCFucwqOFV+5pfd4G013dcg=;
        b=K9Bq+wQ7MlHnEaL5mHvpVtvxG04QTek0VUAnL5N5ttGUDXGgTu2ixJ+tx9kyxZkkNa
         2RFnasIiGQYtoC+DPoUYBDezUYsElziYRDBIolDRruir7f2ElKtSwO27443z/v0b6RWH
         u515BrLYvqiLwm3NKtYyYwksoj6tKQgyHLp3NqZ+Ai+iXE9fDXmjbLtZi/W+O2Hi2Ly6
         bS0T4nibgx4tmkD3fTPgxjhPl8p4d3AWMSXcr1WTfP8aO0uetPdsEI9ef2CA+FwxwgH4
         pke4iKGbStk5gda6X75jbN9E1b88eXzz2p2V/9cRFgIrqoiic9TwzKmAuEcbxLb3tQ0t
         UCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240407; x=1777845207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2/6bOX3xGdDGZcmRDZLBCFucwqOFV+5pfd4G013dcg=;
        b=Szvm5LxFd+gAfLmsuHtYIHwheOR+klIcOLDDQZemkBVDg+IIRpjRii0i12YynTKbBG
         dEJii6wNkhcw5goJUzEreDunJUkkGMfSCVldlDNXelksw451XEgv3BTK0kCeMvlfZXha
         ZUsIj8FT65EFClWX7FHmjionF65ZDADK5GgLRho0M8uFFXb9/rSYxzBit/6eo3qrlxB0
         XTbTGZw5rqfqBNY2XB0GUN/3STNdrlYlhd4+MtF2REY+UZNnq9aqGSD7hNYPnCNUHYaI
         j8O28mSDXo6a3xgRmyLIwht9v0i8Lu6IVK9j/Z03Qaprs4TYAsP3tpgdJD1BrSO5yo7N
         MZIg==
X-Forwarded-Encrypted: i=1; AFNElJ+dP15BsiMS/VS/aJpb/eKFC2PxiMzwTIo7XxnodFcWZIsAPNCHdQXD1dx9vjQkaZlUu6c7DlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf20IZnkpo9z91/vwVFA/VrNZqMGL3FetCknmM2Rqx9FGR9f50
	qfuxGZhbrHLk3s3pyWJW7v9jICqFzU2FoQPpdiLOqWmWS0l8PTAPvpA=
X-Gm-Gg: AeBDietyI4+JHayn3llWjMClS5l596sM+vV2MOI3EwCZ3hxBVes4n9SSGrKVQUxphOi
	aocSjTe2w3T0iElIZPbsOlev0x2PzT2wzcgWolxUMvy+fL0UOWdkI05V62CLrsSX2vEmDEzhZKv
	Bw2vojN61XQ5gYwfG1Pb+g4FbGIs4fcqnvpqAU81DC4E14edNqRC2IyEM8wWTK03wRSU1aM6Qs8
	vqj9Y0t6aQOtU3snBctVJmMSHBFMcqxMjHiIpEmaHRDAa+1DSs3BFczQr6Zv5Nd6mM027GZPch8
	dL56gijZ8qeEKbuxgFS42HjYhTs1VR2AzeKFgMqJC4wmzOBP4U4uNahJcca+Hklk4QTUqUG0I3r
	682+tTB1Ck3tI2cp3gUfsHPwBxSTaJu4ICOgPnW9a586eIKjHDJNqEt69xsUvG3CGTYJN8khYZW
	3/7N++/VQAc5R12Q0ln+6IU6hvWK5DdI8olCnLF3FuQi6r+cHusDq0k2zK/kPVqEO+i+R+SiNY+
	nElRNC1sCaMZMRl8u7+gjvJxov9QOex
X-Received: by 2002:a05:6820:993:b0:696:21ad:a4ef with SMTP id 006d021491bc7-69621adac97mr7155515eaf.30.1777240407141;
        Sun, 26 Apr 2026 14:53:27 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6962b40d504sm4738997eaf.10.2026.04.26.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:53:26 -0700 (PDT)
From: jbmoore <jbmoore61@gmail.com>
X-Google-Original-From: jbmoore <jbmoore@nooks.dev>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: "John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] drm/amdgpu/vcn: prevent silent fence drop on 64-bit flag mismatch
Date: Sun, 26 Apr 2026 16:52:53 -0500
Message-ID: <20260426215256.50722-5-jbmoore@nooks.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426215256.50722-1-jbmoore@nooks.dev>
References: <20260426215256.50722-1-jbmoore@nooks.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB51D46B53E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241196-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "John B. Moore" <jbmoore61@gmail.com>

VCN, UVD, and VCE encoder/decoder ring fence emission callbacks only
support 32-bit fence writes.  When AMDGPU_FENCE_FLAG_64BIT is passed,
the existing bare WARN_ON() fires but execution continues, emitting
a truncated fence that causes the VCN hardware unit to issue a
no-retry UTCL2 page fault at NULL address (0x0).

The hardware fault is non-recoverable: the VCNU client is permanently
stalled, the VCN ring stops processing jobs, and all pending fences
on the affected ring never signal.

Convert WARN_ON() to WARN_ON_ONCE() and add an early return to
prevent the corrupted fence emission.  The early return is safe
because the WARN_ON fires before any ring buffer writes in all five
affected callsites:
  - vcn_v1_0_dec_ring_emit_fence()
  - vcn_v1_0_enc_ring_emit_fence()
  - vcn_v2_0_dec_ring_emit_fence()
  - vcn_v2_0_enc_ring_emit_fence()
  - vcn_dec_sw_ring_emit_fence()

The missing fence will be caught by the scheduler timeout mechanism,
which will clean up the job without hardware damage.

Using WARN_ON_ONCE instead of the bare WARN_ON also prevents kernel
log flooding if the condition is triggered repeatedly by a fuzzer.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: 8ace845ff0e8 ("drm/amdgpu: add vcn enc ring type and functions")
Fixes: cca69fe8ff98 ("drm/amdgpu: add vcn decode ring type and functions")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index 2b9ddb3d2..aa0022deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -27,7 +27,8 @@
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		return;
 
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e9d790914..2acf6e621 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1548,7 +1548,8 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		return;
 
 	amdgpu_ring_write(ring,
 		PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_CONTEXT_ID), 0));
@@ -1724,7 +1725,8 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 static void vcn_v1_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 			u64 seq, unsigned flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		return;
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e35fae9cd..6cfb5aedd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1537,7 +1537,8 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		return;
 	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
 	amdgpu_ring_write(ring, seq);
 
@@ -1722,7 +1723,8 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				u64 seq, unsigned flags)
 {
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		return;
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
 	amdgpu_ring_write(ring, addr);
-- 
2.43.0


