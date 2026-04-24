Return-Path: <stable+bounces-240978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJfDDVh562npNAAAu9opvQ
	(envelope-from <stable+bounces-240978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F1460021
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A38E93007BBC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C53DB644;
	Fri, 24 Apr 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os1co7mV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA63D813E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039701; cv=none; b=ok0gXzuR4MIq8UuHCMTbsD6oUb7lhPNId+SyfWzRG4Gm3Zu2mCDJ3a+yjmFyd8rVIiPcvlf1Q8GysffG3J5romOcmaAgXiYCKCFFVbGlyl+nIbgOar/9xz+ws/CfTOwcWdv2u1PEnesh2FU3ptMWr2rGs/b//36d91QzSS2xEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039701; c=relaxed/simple;
	bh=lVGOWOzAdzolib8EMYbv/le1a5M6MmUXlgwtNMMTxfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkhbVRO0Rmjg5GVT+V7rm7uHWJqmz/45n9tNAmEu17QpYf7+dZXg8mqIibqGX/A8TWCa/FFKwi8B2mtdwzef75fddNf41uoteXPMWsR7+be3OB6ItWxFEgSC/g6KrU1l1Hc4uLdSjH2tzh79v9iRpaR011fCSb8JG1Hsxi83rzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os1co7mV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dd73b7c757so1704209a34.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039699; x=1777644499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
        b=Os1co7mVYdb3tS/pke+iYLTJchw3Jv5Q+XUdNUC6+rDHqwajJhK7+KoilOSsrLbYVi
         fbiogXbi+uqldqHkzh5s7aZXOXw9DIc7hXdtoS0jKdX0kBlU9ygiAguCnSMlvbnUW9Va
         CVpcXAtGi1MHAeELitALXV9sBs7iIw496O/tlrnEls3KDGv5jxtF4KspGktOqxmWJxyN
         IZ003XUiKCD2IrGhpHuS6uYprSsVPBCGxn2zdifoNliuDVUNaEAb5Ni0saBu93WQxSp9
         6JyBB8PpRpbZ+5DDNQYQcNRJsyQ33JLunhcRXvROPO7WzUkPGZ7Cs/Ml9UOOKDxDRvUA
         8HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039699; x=1777644499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
        b=hG7+LNHYHu2fQLKpJoJmbXSxTm1OCf7vRJCJ/NDtcJPrL5jkQgSNiH1UtkraJwnn0P
         /R6JyHL8p/S4UwK2bAZYBkpSHvPRXHpo8i4lqIYBwpRQCfXCTqxztqoMJ1f0mJaqMuX8
         JIq+zkT9p9A45fobUi14mk/Lm/0WvjElk6Q5Zv9jY8+6SwiWanwO7wUlqjckMD9Xhs88
         fSx44ZVEXc/SibpxR/5JKw+0Hh35POKwiG+VIawOv2AMNvWTWdQ+hvzGSXX8dv9fbdxU
         LP+vUrNYpOLZqCBPDzk9Kt16F7tqE8zUve5rHvvHrR3HSX6/reghSPiDEpfnpxlVJ9/C
         DJow==
X-Forwarded-Encrypted: i=1; AFNElJ9kpjHINMXTR5nW6lsUTfI6QweHN7rbfuNdBdIZXW2uuHZxfKkwhRgolXoPWQMpu5bo1AAw9y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2kJVyGuECxfkW6iYcVEchhh/Kfe7OfVPyCBISWYyCqZK+iim
	oux9Mui7MtUfRrR3eO+yelGqZ6BhdwHQuMxAJ2bPLW0oPpuqCivm8sQ=
X-Gm-Gg: AeBDieuGpi62VVbkGs65IZLmki6CkU3ptEamKTRbchOU+vzOv5MM4dNW46qhCMSSY8t
	pS3dNt45QZRVyyTMFhNDEzUscAxr5m4kgrWJzf6cTl0ZAOC73GHed/fugj4kDLfNY4WLS/mN3eR
	BkU6RbjGjpWjx7sPpqTUOfKllTn4Qqcvdzh0XU4pxVHCrcvbt56E7nFMglLIzH9M4zOXp3AKFRJ
	qWUr0YhbDOiBbD+Jf/zdhz3HQdt8Ki46Q+abFGXKOg+67/N+M5QD2AJQfUgN5R2gFe8V0OeLdS1
	8xNgSoec+ikrsOWbU7JMSFtzgecFO8RppUCdp0Rjo+j1qcuL1jAJns85mBQLG3a1pF43EY1HdML
	basNpUCyN5X0OwALzZDJJaYrw+4aMYmuxHZAtypEsJwr15h+GEBJcxBiVwQ6zwPcLKnPtLkb2yk
	DuGtF7PKuPt2zlvWPX/KrHZEfvHt/7O+TCaeo+vV3eoDboxHqVisLms62/T/5uRtwexj2x6hEME
	MBDSyQL4swU0dGAfJ6t8pVoxYfJFIJ+GJU=
X-Received: by 2002:a05:6830:490e:b0:7dc:dd19:7f69 with SMTP id 46e09a7af769-7dcdd198242mr9266087a34.17.1777039699009;
        Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 1/2] drm/amdgpu: reject IB addresses with reserved byte-swap bits
Date: Fri, 24 Apr 2026 09:08:15 -0500
Message-ID: <20260424140816.43766-2-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA4F1460021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240978-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Reject IB GPU addresses with bits [1:0] set early in the CS parser,
before they reach ring emission callbacks. On legacy AMD hardware
(pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
fetches. That feature was dropped on all hardware that amdgpu supports,
but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
that crash the kernel if userspace submits a misaligned IB address.

Add an early check in amdgpu_cs_p2_ib() to reject such submissions
with -EINVAL before the IB is allocated, and a defense-in-depth
WARN_ON_ONCE in amdgpu_ib_schedule() to catch any that slip through
from other code paths.

Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a..53f537f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -379,6 +379,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
+	/* Reject IB addresses with reserved byte-swap bits set.
+	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
+	 * for IB fetches. That feature is deprecated on all HW that
+	 * amdgpu supports, so these bits must be zero.
+	 */
+	if (chunk_ib->va_start & 0x3)
+		return -EINVAL;
+
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436..3111d2c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -272,6 +272,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
+		/* Defense-in-depth: the CS parser rejects misaligned IB
+		 * addresses, but catch any that slip through before they
+		 * hit BUG_ON(addr & 0x3) in ring emission callbacks.
+		 */
+		if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) {
+			r = -EINVAL;
+			amdgpu_ring_undo(ring);
+			goto free_fence;
+		}
+
 		if (job && ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
-- 
2.43.0


