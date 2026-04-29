Return-Path: <stable+bounces-241800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I53GnFo8WmhggEAu9opvQ
	(envelope-from <stable+bounces-241800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C18D48E3C9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF1643028E8B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E14378D7B;
	Wed, 29 Apr 2026 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA38UU+r"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460BA3B1B3
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428584; cv=none; b=kDDOpIpO1xJHbubP7KoJ2n4ZcbBGlckNzO8gR5l69x/nZ/612WpK6G9of3Xq61JJihZtk8tkvep5yIubp57LggpgGIi0wk2VbA+9HW2j16Gj7P47IwiwYUeGwKJ1b9fCzjmDFNL23h2D97YpODqqDNZmRf7OqH+mq9tJHJo2xG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428584; c=relaxed/simple;
	bh=VHE6VN4T6xleECar0FAHgEzdZiKl9nM/FO9/Bxvw0gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGg2G3EybJtn9CyQhvvjIeM8OsO3YzH2zISJWLA9C+HY0fiAxQ1MHJH8xGG4X+4ER6CgyOI+VyKG3E+wmFFOsUjMT5LIBoN7jhFDLFBDI6fvIWAI5bVNsQaT+WBMFAjpbLIPAPLKop0fAfTxLYONnPUrzJfdAeyiAIYeU9pWhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA38UU+r; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4779b2497b4so6874278b6e.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777428582; x=1778033382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nswOFEXs658sWrvLAvjXZ4RGUs1F9xaugJk5+hXxT0M=;
        b=pA38UU+r01Wp+ajVTC4lOlxZbM9rN60djBbpLpomPYi3cuUyKgtfyYN/54fINA6SdR
         mGg7RzbnGUV8wbTKiGzey1eIeSdCmeCLg0x4g3EnyPRLYrE4/jEdNf7XntQOlk7HXusg
         ymozOxpDgHfIOR65mRrmCC2Iu1N/V3kw5EeymwweoYnpZKub5hwIFp+ZIim+CQKybV5I
         vnXqaTHzmel+TsSsWg4Wxjd8e3Y5ic+SuqrFF6mY69e+rw0eralL4HNKByH5HM+NeA4a
         AyELL9h1hgXMRAZf7U6P5HuxXSPwevCyJdgY4fwsZZw3tTSnxarHuyeG1JDQ3PRdFak+
         kVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777428582; x=1778033382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nswOFEXs658sWrvLAvjXZ4RGUs1F9xaugJk5+hXxT0M=;
        b=KjUhqyCSFUBzWi92gKF1ndY5ilcUMfSlvktYb+Rsd3e0tBHegtZSA69QdfIwDR132i
         NPtey1E5AJtmoG1q/96PnuZukJLhti1WZdrZMWKdF8U8RUMOpPPvh/muhMyBdka2A1wG
         MoELi9/mr/cBE8Dp851cC+IXN38J4kT76coI4nMsCiWz7naib8cKPab4bZkKc8x/Uxni
         CQexilZ2uvwk82EQ/DL+N4uezFyh7o7hgPDGFs3lSqCq3DoR8KwtDUCLWkdN5GJQ79Cr
         MgnVk1sG3V2X84h5N/QYcqJhU8IEhe8BuQxqQxYVmqqAWAoqBXx+1ZUqS5EEVtN/Ni8N
         rfjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IOco79lcpPNiHo4hgZrg2UC6GvPDOisoGEfaGDnwkOUELYlBtqZX66ZgyjOhi3KVSfbcDatg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjiTXmXHhQt4Jd96/cX9BkRmtVh+lbaRTdKw4kdBiPBi1MM4/
	mfk7ifsVC94RnOYVFJzW0qnuRI0FQguiQu1ChPlHytteVafIUkB7Q5C66+nlVRs=
X-Gm-Gg: AeBDiesbmCUAVcwDDa/7gLM9xsuTkNXJ5lIwN+4O7TL9RtnHsBS+ZxB6R1MOjb+h9Hs
	xrtqYDNXsRyCjfthsFmuzX2ZSP3280vFxdE45jkRspwbA+y8HMmKWYzVY+AiM0EVk4KJGTb1b1T
	8XhZAjiZTl79uHZvl7GURy/hlTgD0GZbfB2I3X6pD+sLH816QQWmy6anz51h7l1UAYUVS6uU1tq
	4B2J0qLGmpiqixBTraEwdtMngLI9EV/umBhnKmzGAIvifWP4uGgz+0kT9GYbxEYAdLiryN3qQ9u
	nVxzqkVx3tYUiLm+PAN+QWi7Xhj0oM90FPZxJs5ZYM/E0jkYvERy0jyo6R9ixtPVtUMGGAyfD84
	7rOZ72w+uBB3DyfB3AETnTBKv/m23Heg+YGutXWUM9akr+75XnOj7a7JMuJQgSIKCHOezk7NDwO
	6rTwaIUbVS11r9p8Y0XxWM2tS0COp49uH0HPS7DxPA805Mjet693ot65tx9KCZyr8QtVMdHt3E4
	/j1aIqwSrq3pVnSfQGupJgmRuvkuZhWzcwl75c21m0A7Q==
X-Received: by 2002:a05:6808:178a:b0:463:efb4:f9a2 with SMTP id 5614622812f47-47c28f641a2mr3316095b6e.28.1777428582200;
        Tue, 28 Apr 2026 19:09:42 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c43edfd3csm293627b6e.5.2026.04.28.19.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 19:09:41 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alexander Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	"John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE in ring emission
Date: Tue, 28 Apr 2026 21:09:41 -0500
Message-ID: <20260429020941.33422-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C18D48E3C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241800-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Replace BUG_ON() and BUG() assertions in the gfx_v9_0 ring emission
and support paths with WARN_ON_ONCE() and graceful recovery.  Nine
sites are converted across wait_reg_mem, gpu_early_init,
parse_ind_reg_list, init_rlc_save_restore_list, emit_ib_gfx,
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
no-op.  For init_rlc_save_restore_list, return -EINVAL to abort
driver loading.  Ring emission callbacks return void, so
force-aligning and proceeding is the accepted pattern.

The kiq_read_clock BUG_ON is handled separately as it requires
a larger refactor (moving to amdgpu_ring.c as common code).

Found by a custom amdgpu DRM ioctl fuzzer.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
Changes v3 -> v4:
  - Fixed malformed patch (v3 had wrong hunk line count)

Changes v2 -> v3:
  - Dropped kiq_read_clock hunk (separate refactor per review)
  - init_rlc_save_restore_list: return -EINVAL instead of break,
    to abort driver loading (per Christian König review)
  - Dropped Fixes tag (issue predates the referenced commit)

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 49 ++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

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
+			return -EINVAL;
 
 		i++;
 	}
@@ -5431,7 +5435,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5527,7 +5532,8 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5567,10 +5573,13 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
@@ -5639,10 +5648,13 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
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
 
@@ -5654,8 +5666,9 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
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


