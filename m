Return-Path: <stable+bounces-241798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yg8yNOhn8WmhggEAu9opvQ
	(envelope-from <stable+bounces-241798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:07:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AA48E39C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A1B3058600
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0B378D7B;
	Wed, 29 Apr 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUgdYF5M"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D983B1B3
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428448; cv=none; b=oKrieTVRl6E1lGEU6wRDKpbQ00CGfApxc1ihdNSY15Wqzb8OAyCUZyIJHQt3bQ2l8fdVkRtYPx6QONs3K0+aVUARmPFHSTqSpPVNO0NNqyUA6h6C3cX8Cb/bhIeL6poAGgSa9CWwOXw9sAbCNck6ZPFcqBdj9G/NvEr99kcK6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428448; c=relaxed/simple;
	bh=zj1ETYHpyHqZIBxV38PWz7ZMaVB/ydUYsUsypZ1FBfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PuRvgSzqr04JkuYIdrdfmRKM64s5ViG2qjEFHjOQEQefE+T385O09s6fP3zunA1BUivj3osU+tPO+piyy4+ZP7gUBGGk18RHS08mBTPxu3xt7MLCSOOSetPimZnDLXuUTg6cDFpfiwfTSe16sNVRC6a8qHEjVuiQK27t+sq7qcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUgdYF5M; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6948da50eb5so241866eaf.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 19:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777428445; x=1778033245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2w0ci/3nfogT9TVWzSGKqAaPzS8O2uQ/Ty6gdAnz4I=;
        b=FUgdYF5MeD7RZia/NJOMr+84O7vEpqK3ulUc8f59YeXGoo3jJVcNG7UJs5lvSjvCKB
         pWEcGabcjMAoYgUVSal/RkU3lyJX1EYG/aci/iNVOVsXyFT6LJ3wEue92XPb2Xuij8BM
         Xzs4iWjuP09Pn0QD7dGiQaKyioMuGIMuaJI+TUu/JhkFuziZdWFeSqZQ4dB9WkJ7WM3F
         ibnHY+8ahEJc6Cp1LLqFW1/qWtdC9sv9C/ue7d6B/cvppDwRfq25tb/Q0ZDsYcvTec1l
         7K+DU5/fKCxJHu3R1JiYKQXavdSnOaGH8aTgQHLtd53mgx6awyf0jqLONg2qQ2VLJiuR
         4jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777428445; x=1778033245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2w0ci/3nfogT9TVWzSGKqAaPzS8O2uQ/Ty6gdAnz4I=;
        b=IpiWgx0vcf2bef2oxyuFhv+yh49/I69k+OvHQzKQqvpxKF4fHMq6xLw6oy3BCWiaIx
         A4yNfnZ+M8ZHIYVKEROCL1HMQswMyfyJINE/sMo6hToKQoyG+mjHKNQIK4+yGpswDDVi
         22+d768ft3Y3bib0vMYCSP3AATL2vndZ2RruxMdW0v9WRCqUbZveGJnROVETtwEvs6cm
         JNH88NItyRjm6q2ITTZzuvqVa4p0d/ddO5MfA818NwmJwuL8SXXMaS0JtrH99yBLWzu/
         V3WskSab5ofRefiBPmbyy9kEujECqJEnbhHKpYuSWLcLQWZ7W+4X6tuMBaZj/IDAQW5f
         4bNA==
X-Forwarded-Encrypted: i=1; AFNElJ8vdGoVWHzT3M88UAGULkYwrvO+hwLjGmatB4uMLjpeSDhxGvuEzxdKpWEoD12o5f9RQkBR5fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHot6Dpl7V3TdQTlBJVXclsRmziFJ8mIguWuPfn7GvTsf3WjTv
	n/aOR8v5LSlg1a0uoE17ArkPuhwJWetwTyVUDGadj4ySqWWc5RA0R28=
X-Gm-Gg: AeBDieuIiKTNUB460iFxFe31FuH/ji32UbsDGsADC+bDfDspDyYOUKOUT+/5fAWqKia
	+YD96vsBrD+p5WmyAQu6pZ9Vfcnd6Nnla+65xQAhjl2mhwuZ9HyePE8bUShRXdBO0KPbQ79zlzg
	P8EbJYEGoPdrWkC0WVZEgCHOa/RUUH5ZAHLP78Vgt+895wTY0bn/PZ48uWMFrX83NccbGn+oU+n
	JOfoSyKS4IizrWOQB13HqaZaTr8S63+cVRhFNvZKF5ZrdRE58Cy91RLTzCqZPmCkG5DxNqIWoK4
	DSxJ1cE3zFsjN4OwQoAv+ZOrjDqXiOHD2RTHk3U9Yp+8eZlTscW4acNxXsiLzxBrvSAUxW42pTV
	3W7Dr8D3tlDidjsK1OJgBukhaUFler1cTiqsB0/SZH9ljHXUBd+ZXKOdOhbzhGSLbqRz7Cy+HS9
	nEhbEv5HnVxXKhFkFeMDWZ/J/8tRUcy2z5VgZpY4XIfWtVv8HQxbZL81nbz6u+cIww7efddNk9n
	WwbIj50cyxlGwZ2URkmXj4oeN8UXAjvqb0=
X-Received: by 2002:a05:6820:1388:b0:694:8e28:fd7a with SMTP id 006d021491bc7-696699fa5afmr593877eaf.25.1777428445461;
        Tue, 28 Apr 2026 19:07:25 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6966bdefcf5sm290243eaf.11.2026.04.28.19.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 19:07:24 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alexander Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	"John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE in ring emission
Date: Tue, 28 Apr 2026 21:07:23 -0500
Message-ID: <20260429020723.33301-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 421AA48E39C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241798-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 
@@ -5654,8 +5666,8 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
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


