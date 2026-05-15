Return-Path: <stable+bounces-248645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCqnCAtOB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8B553E8C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B6073023BF6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668573F9270;
	Fri, 15 May 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsKgWRoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294143EFFA2;
	Fri, 15 May 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862264; cv=none; b=ioRyhcVa+o+xRDqIPsQZPXwN6yxa/cYSMbNNzwVHbmRRE93Y1V6QNhBOA8iAiNp8C2G8TuUFoSTOsRvFkl5aeBwvr6Rgr84YcYpuDIUbyhdz67rU17fIGJwlDe9XcuOwIbHx/cNOjdcUien++aY7CYYlFJ6MZnrcH0pxfRiink4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862264; c=relaxed/simple;
	bh=Cc1UFohVm9/9afw/oPYXjd94S5vwnANF5J+msfDN5+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcYKV+4z/6mZaFmuNAPnvhzyA2EEC7QVNx6BoXjyYY5pD5DKf2tUXzBcDyKiTD9VsFGNaEVhIhYKMU3a+yYfpS98FS5kPUchHn+45pRf63Vjm0CKczVTVFn9f+a4pTyD3RH43NPSAJ3wqVfCE7G0zqWY1cclskf1eg0kDoyS10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsKgWRoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0AC2BCB3;
	Fri, 15 May 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862264;
	bh=Cc1UFohVm9/9afw/oPYXjd94S5vwnANF5J+msfDN5+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsKgWRoLVPnZCRScQY6ztYN6xIT31ZPk8nWQ5xgAZxiDyGa+Z4boD0mKGX84sZxHa
	 2+M1eHgU3nkeUMcmokEfJHRpzuUmQkzs4vQuZpG+nKOelyhHZTDNrFmhrb4HD+G03v
	 L6c0Czp729XQsMfo+M/U8xrlX1QPP2CXBWSnfVVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 154/188] Revert "drm/amdgpu: dont attach the tlb fence for SI"
Date: Fri, 15 May 2026 17:49:31 +0200
Message-ID: <20260515154700.664677235@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4C8B553E8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248645-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prike Liang <Prike.Liang@amd.com>

commit 9163fe4d790fb4e16d6b0e23f55b43cddd3d4a65 upstream.

This reverts commit 820b3d376e8a102c6aeab737ec6edebbbb710e04.

It’s better to validate VM TLB flushes in the flush‑TLB backend
rather than in the generic VM layer.

Reverting this patch depends on
commit fa7c231fc2b0 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
being present in the tree.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1066,9 +1066,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_upd
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked &&
-	    /* SI doesn't support pasid or KIQ/MES */
-	    params->adev->family > AMDGPU_FAMILY_SI) {
+	if (!params->unlocked) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */



