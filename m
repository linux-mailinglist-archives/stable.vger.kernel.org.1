Return-Path: <stable+bounces-248596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEvZGY5XB2pVzQIAu9opvQ
	(envelope-from <stable+bounces-248596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:27:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF855550C3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EDB33926F8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE63E00BB;
	Fri, 15 May 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGUQZ7fG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713F26CE11;
	Fri, 15 May 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862137; cv=none; b=XS3MRA4mOmgFeAf4QnN6jcdNtdjfZfiuVRXklkIX+2kMppXA/jaWBOufPGfetngP/TeapNSUggoWWCIRFDL4AwBRLOQDSvq6crQGUYvuhMnlAWHjdVuJ4h937hbiJkpW0n/OAajySJlWHp9We2V02UrQtdXPUsUeDcSRg7Lzhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862137; c=relaxed/simple;
	bh=tereJNCvk04N3aQaQ1glXl2aLUeBUuiI/XFXvp4e9WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P89cKpEweqCmIoDPsmSvZ62QTIdU7rFO7HKa7fZ9XHjuOIdXdkD7oP8jq9s8Mo+IxLQV5fMNYJW5MQ/46MGnpYmdX1a/G6AsvQfSb2zSflmf1RCVLhd5Q9bYZhm9r7uSXKUwjJZ30CXp1/TUZFM8FOApxsSPluo0Mb5LQq9h8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGUQZ7fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A140C2BCB0;
	Fri, 15 May 2026 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862136;
	bh=tereJNCvk04N3aQaQ1glXl2aLUeBUuiI/XFXvp4e9WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGUQZ7fG8StaV7qbD9yQMA3jZ3JI+qcOQ3zdviE4Qin0i2tT+T/k7q7IUeNPyZSJK
	 4CEuvsoxJr0xZ4tJZu8rRvZe+0MUbiBeYTO2ekIwOmNM47Zf77uLcYHVMYq0LW7BVS
	 htBB0Pulv2kD19uhP1QorN2N0kBRng8aFto6GcgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Kuehling <felix.kuehling@amd.com>,
	Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 123/188] drm/amdgpu: zero-initialize GART table on allocation
Date: Fri, 15 May 2026 17:49:00 +0200
Message-ID: <20260515154659.998704380@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1BF855550C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248596-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

commit e6c2e6c2e1fa066968a16aca1cb66cd1bdde7741 upstream.

GART TLB is flushed after unmapping but not after mapping. Since
amdgpu_bo_create_kernel() does not zero-initialize the buffer, when a
single PTE is written the TLB may speculatively load other uninitialized
entries from the same cacheline. Those garbage entries can appear valid,
and a subsequent write to another PTE in the same cacheline may cause the
GPU to use a stale garbage PTE from the TLB.

Fix this by calling memset_io() to zero-initialize the GART table with
gart_pte_flags immediately after allocation.

Using AMDGPU_GEM_CREATE_VRAM_CLEARED, SDMA-based clear will not work
since SDMA needs GART to be initialized to work.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d9af8263b82b6eaa60c5718e0c6631c5037e4b24)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -262,12 +262,19 @@ void amdgpu_gart_table_ram_free(struct a
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (adev->gart.bo != NULL)
 		return 0;
 
-	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
-				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
-				       NULL, (void *)&adev->gart.ptr);
+	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				    NULL, (void *)&adev->gart.ptr);
+	if (r)
+		return r;
+
+	memset_io(adev->gart.ptr, adev->gart.gart_pte_flags, adev->gart.table_size);
+	return 0;
 }
 
 /**



