Return-Path: <stable+bounces-218340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMO5BKdSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDE18F489
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5DA431A24C4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE391EB5E1;
	Wed, 25 Feb 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="078AUhaE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330C18DB2A;
	Wed, 25 Feb 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983147; cv=none; b=OUNjTAi2vdUAdyT50sgG3VmSAoZ7UIaTWnnEdH7Edp9O408xj9exXQKTyIE7d+opAqLLOTBdwo79fRb9bhqhsY1fmXAfZ7DFEWxc2m9ZsL1JLzLUaLcxaxz9h4DaTsO4JLZxDkM+MEdB3RBX5zQhNkCHfp+V+tEMHKR/ss35S/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983147; c=relaxed/simple;
	bh=eayvUpfs1mNH3n0yTzyWGSrFFbCl2P+8miaSqwh3k4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWW9u+8Pcd/VJUjwg0ZBvfgL3CsxAS7WzEgOr7MxBBtul9sX8QQbkT74Ka1DNBBPQiRNkHUThTvntZnCrnlx2l9lXnQEXl4uXgB9+VkWPyhRiRZE+Ha5dYqJQRknm0aU3nUfJmr8tvBTkGnCPHJeWAQLwOlyaoAOJzdMaF+QXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=078AUhaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB17C116D0;
	Wed, 25 Feb 2026 01:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983147;
	bh=eayvUpfs1mNH3n0yTzyWGSrFFbCl2P+8miaSqwh3k4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=078AUhaEmMVt1mtvRUjR7xODESt82sQJfMF+GBRdfv8lpI4DtuAbywg0EF1p5/p6B
	 6ZrwWYlHqIlh7pNcCG1gXl24NSE280FHTTyDqbNOx3U480DRJXGhgBO4qutdt3Ow8v
	 psWcxuUPu0U3J4n7d+xQkk8f249zHsusCw7QNW28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 258/781] drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at Init v2
Date: Tue, 24 Feb 2026 17:16:07 -0800
Message-ID: <20260225012406.032537433@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218340-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 84FDE18F489
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit de8955508b72f8a88afc3f2cbb62334d5f79ccc3 ]

MMIO_REMAP (HDP flush page) is a hardware I/O window exposed via a PCI
BAR.  It must not migrate or be evicted.

Allocate a single 4 KB GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP during TTM
initialization when the hardware exposes a remap bus address and the
host page size is <= 4 KiB. Reserve the BO and pin it at the TTM level
so it remains fixed for its lifetime. No CPU mapping is established
here.

On teardown, reserve, unpin, and free the BO if present.

This prepares the object to be shared (e.g., via dma-buf) without
triggering placement changes or no CPU-access migration

v2: Added extra NULL checks

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 96e97a562d06 ("drm/amdgpu: Drop MMIO_REMAP domain bit and keep it Internal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2b931e855abd9..ac67886acaa24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1820,6 +1820,10 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
  *
+ * The BO is created as a normal GEM object via amdgpu_bo_create(), then
+ * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
+ * migrated or evicted. No CPU mapping is established here.
+ *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
  *  * negative errno on allocation failure
@@ -1848,7 +1852,26 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, true);
+	if (r)
+		goto err_unref;
+
+	/*
+	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
+	 * Use TTM-level pin so the BO cannot be evicted/migrated,
+	 * independent of GEM domains. This
+	 * enforces the “fixed I/O window”
+	 */
+	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
+
+err_unref:
+	if (adev->rmmio_remap.bo)
+		amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+	return r;
 }
 
 /**
@@ -1860,6 +1883,15 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
  */
 static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
 {
+	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
+
+	if (!bo)
+		return;   /* <-- safest early exit */
+
+	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
+		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
+		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+	}
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 }
-- 
2.51.0




