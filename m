Return-Path: <stable+bounces-214309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEdnI4Bug2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:06:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BDE9DEA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4483D30D8583
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2582DBF75;
	Wed,  4 Feb 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIYub/J3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E22D6611;
	Wed,  4 Feb 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219259; cv=none; b=bydMuR4fAdWQZqqxjRVNKb0axa3gBoS1a3kwfJE1kEZmSD8K+HrQsLGiWvjEewgbOl8KLf++VkaDa7fV25deqKwF+YQxm9Vqf8ZgW2AFQR9qiQuE19/4rmTDnLHe9TdDQ2a52zbBbBav/kMYzjEV+2/HYF6cSybXxjOemNEMruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219259; c=relaxed/simple;
	bh=ydqz8MTILKryS+L4pDy3YONvp8VxMHgfnv4nGpMtdaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deZ8AQbSZ0ci8XbSRMhYH3AkVPl6mS3haqQU0Fqb/eP0YKy1vSj1n0w4sudxkyg36Mz/EOzDxz2jWzPBBn1GqF/0sKv0XJSEk+NXclsoqROMUyS0TBp53i0R2tErsFQLjGu6xsckAv4+FE63Eff4po/t5JQSWXWATs7neLvy49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIYub/J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6B8C4CEF7;
	Wed,  4 Feb 2026 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219259;
	bh=ydqz8MTILKryS+L4pDy3YONvp8VxMHgfnv4nGpMtdaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xIYub/J3KRspcK62BNcevwwTIYYjYQQX9rxBY3sope3/IocKJeeisXu1OkMwTB8Om
	 22xhvFp7h6TQMR1q7R1sRKH2i0t3j0W45T5U7YGaUEQPA1njQ9BS9vfwblRTlLpsx3
	 0qj8JsrkPN8l2FTm/xJZVI1MAAi8wdGav4TdD8Bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 114/122] drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()
Date: Wed,  4 Feb 2026 15:41:36 +0100
Message-ID: <20260204143855.954698840@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214309-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A84BDE9DEA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit b1defcdc4457649db236415ee618a7151e28788c upstream.

The EXEC_COUNT field must be > 0.  In the gfx shadow
handling we always emit a cond_exec packet after the gfx_shadow
packet, but the EXEC_COUNT never gets patched.  This leads
to a hang when we try and reset queues on gfx11 APUs.

Fixes: c68cbbfd54c6 ("drm/amdgpu: cleanup conditional execution")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ba205ac3d6e83f56c4f824f23f1b4522cb844ff3)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -228,7 +228,7 @@ int amdgpu_ib_schedule(struct amdgpu_rin
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
@@ -284,7 +284,8 @@ int amdgpu_ib_schedule(struct amdgpu_rin
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
-	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) {
+	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &&
+	    adev->gfx.cp_gfx_shadow) {
 		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}



