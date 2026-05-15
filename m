Return-Path: <stable+bounces-248812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E8FKf5ZB2qzzwIAu9opvQ
	(envelope-from <stable+bounces-248812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:38:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24717555569
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EA9324B5B9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C83F44E4;
	Fri, 15 May 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdhBAbb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CB3F58D7;
	Fri, 15 May 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862694; cv=none; b=cdXgpwIcEJegl5Zndc38/KOTL2ogml6yGxYf8QkYYYsTyXTKdqzFKkzIFLcPFlT6lm2MlmpJXesI3Ez9LCtURQ30bWpoo9QtwyX90CWcpo+aKqVA/tayC/TuooTVL8zMvo65GncIQSZwxkPUJ4/ErUaAlUoErglKteNlObwEVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862694; c=relaxed/simple;
	bh=cV/tRIyrSIMkIKr7f4KcpRYgJAITScezyOkCEMDdbKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIuq4raZELydkHo3dNMlYg48mt+nFgxhrGgLmRvw1MycvQd96qurkE4BNc7C6l5mA+/tMI0KEF6m1wa89Nf8neTu2GdFNg+6bJ4VdIL0bpuoDbtAHf8QFiIJpYAG/Tnm6no+vHSQZPN7UWOykfnCbHq0NIu4IfRd2kcHSODji5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdhBAbb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371EC2BCC9;
	Fri, 15 May 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862694;
	bh=cV/tRIyrSIMkIKr7f4KcpRYgJAITScezyOkCEMDdbKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdhBAbb8nE46GBJr6x6H1enuD6HUN/L/WxZSh+PDyVFxg5gWe1cIA2znDzuqWTQdt
	 Kk9eRp8fuXs6VRDvxuE5cgNAt+6qpalLYJn2AxHrKoKBc2HW6CY3H/d9oyfCM7Ga1O
	 iAFtPhcdXtHqUs7GASsgGqd9wWenVXc68wf86ONU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Shetaia <Amir.Shetaia@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 130/201] drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure
Date: Fri, 15 May 2026 17:49:08 +0200
Message-ID: <20260515154701.381952917@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 24717555569
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248812-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1735,7 +1735,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
-			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+				AMDGPU_GEM_CREATE_VRAM_CLEARED;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 



