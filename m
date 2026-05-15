Return-Path: <stable+bounces-247950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G3hK+lEB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32916552B77
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95B4322C40B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3623FF1A2;
	Fri, 15 May 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhCVAXXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC71175A87;
	Fri, 15 May 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860490; cv=none; b=iCBMXu2XYYzZSRgZDeLq6TmaT3hXnN4XFbo9SPx6YOpTQDXWrBgu0nXQa6ZF7aQ4BXN4xqDPayfGId4AFw7LibDt2lELPFRCpfSYsP3NIWA37W67bVU4GtP78Ph2qdr9KqisyDaRrkWV6CnaA5Q8DmE2L54dbR6wVnMzpfp38YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860490; c=relaxed/simple;
	bh=Ktd8c9uz6DnSb3uv7cHWs8ZZ6ngdRSbuFQVZ6gsby/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOXx0lDmgYZPKJ6ND5Q4HS5Hn3SJ9eifVBonASvxitemwOeZsSXHOGy2MlryVW28+aRrFUkbmzKeu9wDgzj8TcXIu3ifzBccWj2KaOqLBbxF5FoDeENSEkufQxTrviKChbKoa9B9cEchcqYkA4Q5QqjO3befqYdL2tz7oKThgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhCVAXXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A2EC2BCB0;
	Fri, 15 May 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860490;
	bh=Ktd8c9uz6DnSb3uv7cHWs8ZZ6ngdRSbuFQVZ6gsby/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhCVAXXcaosMPi7LdtPEpLfV4KbQja6pDpZZgcg0mx1X20ljBGPtOB1xAkwpGOQPc
	 z1MWrnVgTBSwYRPwM6ZupPcMnyNoofoZWzEY1xkFmYRliQ5/nMbpFiP+2OThfn6R6z
	 MBv5ehxD0PvElHxuPgHIiT0dRdvYj13XDNOZLIRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Shetaia <Amir.Shetaia@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 067/144] drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure
Date: Fri, 15 May 2026 17:48:13 +0200
Message-ID: <20260515154655.098418734@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 32916552B77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247950-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Shetaia <Amir.Shetaia@amd.com>

commit ad52d61d82181dbdb7f05826de38352d5e550cc2 upstream.

KFD VRAM allocations set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
but not AMDGPU_GEM_CREATE_VRAM_CLEARED, leaving freshly allocated
VRAM with stale data from prior use observable by compute kernels.

The GEM ioctl path already sets VRAM_CLEARED for all userspace
allocations via amdgpu_gem_create_ioctl() and
amdgpu_mode_dumb_create(). The KFD path was missing this flag,
allowing stale page table remnants to leak into user buffers.

This causes crashes in RCCL P2P transport where non-zero data in
ptrExchange/head/tail fields corrupts the protocol handshake.

Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1737,7 +1737,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
-			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+				AMDGPU_GEM_CREATE_VRAM_CLEARED;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 



