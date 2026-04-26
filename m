Return-Path: <stable+bounces-241194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W/ZWHmGJ7mlyvAAAu9opvQ
	(envelope-from <stable+bounces-241194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94C46B52D
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9D3D3001303
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155483090D9;
	Sun, 26 Apr 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwgf8Dpn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442C302146
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240410; cv=none; b=OFxhe5O1N49FUKgL2XvEozkx86EXYZ9t9MICk5ww2OdxckJCRPxksB8OdTf/SQxUhQHQZKw6q6Z9frT6AIdaxh9xGs3cIEF1mpt2cRGU0PPk6IQ1Z2wab5RCvA4+qq9gmYGZYtZzem2+ehGdGu4FuTDR9rkK9pG0xbxCQrSTdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240410; c=relaxed/simple;
	bh=IDh3ZoFM+69Zbv3S4KlrdzwoCUk0y03iiOyWAbR8WvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcqwLBDSegWBZKSZP4XCx3wpO86HEQXlrGKjz0SoFLPYIsXbjNzPzXQ82XCXRDpwG9jT/5UL1w4EM8YqcokQ5DUM9bgWnVWNb4+xSeBzvCTyMiXU02gcLsFXXc9QUumOjxeXkc6dc85cRsxo77ewsYSuGV6nC3NJQj7OATPEvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwgf8Dpn; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcdaf06498so3915009a34.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777240405; x=1777845205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV28+n6/mN7yzVh9kacJr3+Gb3j8R740Y6yM7SQu0pc=;
        b=fwgf8DpneOGOtcp+B2HNgsxOptpxpC6zybWQBgE22Ak1nYxMkFTaLO5s1WABbOZS69
         Ah/iJTHodMDkrh8Mkmp45FnoHEfN5ejZ6Ee2U6D80OvZ+KXgZyoLiv4OUt9+yEJbO8/M
         U7lLVUSuEQZvnGBjsZzOEn5JiS9xi8aii1hmWMAzO56AlV5MX9yxCYWSU2F9/b7Rn1tr
         roeNjAcn3AvFpSGlEx/ov97K1hrNcVJOH1NlsldT0tu1fEQcVLGtly6QQfe0IvnwVPvW
         2Hie3a6gvso0l8poheNyafeJEpJKI7tJ+smSzec0j16kf7F+r8T7jfIQjVIHPrbxC4aG
         qIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240405; x=1777845205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OV28+n6/mN7yzVh9kacJr3+Gb3j8R740Y6yM7SQu0pc=;
        b=KB/xKy8+OxAaLumTFDL9/5B56QlouG1B06WDPc+WYFLUz3+TEX5u6GwYK8kfXPIs95
         izYUIrM/8ck66BRkZmC7XK57ELTuNT8O9/Hoy4PzwXxj0I5BAh9R6ylGc3BniQu6nW86
         O0CzVAx0QKE/OTcYG+tK/7JEfXmFfgwmQewkXMCAS7RjQ6kmRsUpKzUC5cQ0Raf8r878
         WkrOke9VvexoJ2wFFpnrqs3inpd7HIAnDY0uPuahjMNc2jClxWLwt3NIS3rQAkTYPae+
         r97HsW5D8Z7sok/mSR3P9KD1HGElR/vOsWaNYMIe2URAjoaww/Jz1Fpvve0Nvdssh1lo
         rjvA==
X-Forwarded-Encrypted: i=1; AFNElJ+k6WV9Xe0Q+4DZ9MyWsAcWHQcf2fLOtTn0ZW4WKG6G6T1L8c40CXn+jIGPcKKDgRzDAFgGtyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tiP9U/BJDPBf9UbfQCBTcEoT099P1onWKQqWRmgi6e9StdMD
	5hjbZTROP2zNx2mYxFkhDGNjWAQGJ42GVLUNREauM6VVDHVzGX6S4wU=
X-Gm-Gg: AeBDiesvnI8yZeLcv/7CJJW2jNNDSUmFOFUtE8Cq7ObQfQx092dIZNb1P80aswUYHve
	gYMG/VvE3p6L3drZNqh4/NOelOMteQ0+chsaOtxw5tN4z7bc9K4Dp4FunxaOJgusIWR7AZguhMR
	5FBZabijdKTgwSxdSutNEte/sSqjvbvcJ3MQebwJWkZ0etPCIHPdHV2Z2z7qq2tkhS39zhQ7m49
	zGpWhZVl+7XxzV69qvFxdk+EYy46U50AYXbXjA4YZllOMCBbv0tUl4/IePGYrjYEBd73cTVKHsk
	2hmZXLn5bc1mNKeQxqB0y8HXlphy/wwgctn0iqAYuKOipTzeqejYiTVyC2tNyFGhVH+nKm1vNTW
	qGTAuXsr2VLcSga7Wb47BTExmPJ9+7cCiZZVJ1Jix5c/H/0gr3Ckh9BqIcBPToAD2SqGIJQI74c
	YQr2pwvO4ubePU1mo7UQFt5tcQaG4hJQYM33up0on+Tx2IkoWDnQ0wER+vczuwtBuIJ/yy70kFi
	Lt0SD77QCo00fff6+jRqVEP9aNFW2ZM
X-Received: by 2002:a05:6820:168b:b0:694:a2c9:2d50 with SMTP id 006d021491bc7-694a2c92d8cmr12365552eaf.59.1777240405133;
        Sun, 26 Apr 2026 14:53:25 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6962b40d504sm4738997eaf.10.2026.04.26.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:53:24 -0700 (PDT)
From: jbmoore <jbmoore61@gmail.com>
X-Google-Original-From: jbmoore <jbmoore@nooks.dev>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: "John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE in ring emission
Date: Sun, 26 Apr 2026 16:52:51 -0500
Message-ID: <20260426215256.50722-3-jbmoore@nooks.dev>
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
X-Rspamd-Queue-Id: 5B94C46B52D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241194-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "John B. Moore" <jbmoore61@gmail.com>

Replace all BUG_ON() and BUG() assertions in the gfx_v9_0 ring
emission paths with WARN_ON_ONCE() and graceful recovery.  Ten sites
are converted across wait_reg_mem, gpu_early_init, parse_ind_reg_list,
init_rlc_save_restore_list, kiq_read_clock, emit_ib_gfx,
emit_ib_compute, emit_fence, get_wptr_compute, and set_wptr_compute.

These assertions guard conditions that are either:
- Address alignment checks on a deprecated byte-swap encoding from
  legacy pre-amdgpu hardware (bits [1:0] must be zero), or
- Switch-case defaults that should be unreachable but are better
  handled with dev_err + return -EINVAL than a kernel panic.

Several of the address alignment BUG_ON sites in the IB emission
paths (emit_ib_gfx, emit_ib_compute) are reachable from unprivileged
userspace via crafted DRM_IOCTL_AMDGPU_CS submissions, causing a
fatal kernel panic in a scheduler worker thread.

For address checks, clear the reserved bits and proceed.  For
unreachable switch defaults, log the error and return.  For the
doorbell-only wptr paths, log with WARN_ONCE and return zero /
no-op.  Ring emission callbacks return void, so force-aligning
and proceeding is the accepted pattern.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 50 +++++++++++++++++----------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2eb32f92a..47e81c33d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1182,8 +1182,8 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				 WAIT_REG_MEM_FUNCTION(3) |  /* equal */
 				 WAIT_REG_MEM_ENGINE(eng_sel)));
 
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+	if (mem_space && WARN_ON_ONCE(addr0 & 0x3))
+		addr0 &= ~0x3; /* Force dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -2107,8 +2107,10 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			return err;
 		break;
 	default:
-		BUG();
-		break;
+		dev_err(adev->dev,
+			"unsupported GFX IP version 0x%x for gfx_v9_0\n",
+			amdgpu_ip_version(adev, GC_HWIP, 0));
+		return -EINVAL;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
@@ -2808,7 +2810,8 @@ static void gfx_v9_1_parse_ind_reg_list(int *register_list_format,
 					break;
 			}
 
-			BUG_ON(idx >= unique_indirect_reg_count);
+			if (WARN_ON_ONCE(idx >= unique_indirect_reg_count))
+				break;
 
 			if (!unique_indirect_regs[idx])
 				unique_indirect_regs[idx] = register_list_format[indirect_offset];
@@ -2885,7 +2888,8 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
 			}
 		}
 
-		BUG_ON(j >= unique_indirect_reg_count);
+		if (WARN_ON_ONCE(j >= unique_indirect_reg_count))
+			break;
 
 		i++;
 	}
@@ -4209,7 +4213,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 
-	BUG_ON(!ring->funcs->emit_rreg);
+	if (WARN_ON_ONCE(!ring->funcs->emit_rreg))
+		return 0;
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
@@ -5431,7 +5436,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5527,7 +5533,8 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5567,10 +5574,13 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * the address should be Qword aligned if 64bit write, Dword
 	 * aligned if only send 32bit data low (discard data high)
 	 */
-	if (write64bit)
-		BUG_ON(addr & 0x7);
-	else
-		BUG_ON(addr & 0x3);
+	if (write64bit) {
+		if (WARN_ON_ONCE(addr & 0x7))
+			addr &= ~0x7ULL;
+	} else {
+		if (WARN_ON_ONCE(addr & 0x3))
+			addr &= ~0x3ULL;
+	}
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -5639,10 +5649,13 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, only doorbell method supported on gfx9\n",
+			  ring->name);
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -5654,8 +5667,9 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+	} else {
+		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, only doorbell method supported on gfx9\n",
+			  ring->name);
 	}
 }
 
-- 
2.43.0


