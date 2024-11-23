Return-Path: <stable+bounces-94681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5D9D6971
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F38F1615FE
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7D249EB;
	Sat, 23 Nov 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNoEXyAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9121F957
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372241; cv=none; b=mxhk6R+pLpM3Agf31kooxseUpv6aTjmglzyG6jlEqmedvWjgH6xzvFYA8JiNLz4B5pvFuSIFR1g6e8ANVvSieA+G6xcj0nuh8w8VMs/CYZhorg4VwS0ZHtvsAed28EUHcsufcN/98QW0sa9jZi+ZJRBqZxsqC1+NN+E8SouNYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372241; c=relaxed/simple;
	bh=cUlvQDlJfXDUAJmMEFrl7CPHzlL6hzo7SfmNF2gt8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR1akEu5My7KORcsEzG/L4eF2FZ5NzAOU39tjvrSCy2SDSH45idhkBXXL+UeVBNREkjPbj2Njp/PPnAar0LR1LuIWLFjhQvrEMzpoEXYuUfHp8Crkyu+Qu2A7dJkyufg8hAXvoXotb4LtyPI04Hy2unzFNTtPlPYwZrszzGfNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNoEXyAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E223C4CECD;
	Sat, 23 Nov 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372240;
	bh=cUlvQDlJfXDUAJmMEFrl7CPHzlL6hzo7SfmNF2gt8ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNoEXyATAlxKEFvd2AanSh65N9YCvNVY3676GZfNi/vcq3ktegx+l7JF+EmS9z7+G
	 uD723rv5kX40C/KzVRYrwwqTIkoWDUYnrpa3irMrQvDtXNhuXgLHYH5Ozk/rzc17qy
	 wDbb0x1XycvBx3FtWaM5YE+50nVYzbI/hP27NyHAPiAp3C/vKnjv9VWpIi6t9tWG13
	 IJjWQZDZ4cNnU8bAorJO3iJblWkgrMyVQ+QzKgTEsDSUCB7gbvSkcTcCMUy8sAxOxr
	 3sstmS+CUbEPnMrxgqSJu7P0Q1fljpwjLRGtZjJDUmH7YZBEdfJG0dSQ4owznIExTx
	 +sTTlO2466Q+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 01/31] drm/xe/migrate: Handle clear ccs logic for xe2 dgfx
Date: Sat, 23 Nov 2024 09:30:38 -0500
Message-ID: <20241123083456-400083e420760b67@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-2-lucas.demarchi@intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 108c972a11c5f6e37be58207460d9bcac06698db

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Akshata Jahagirdar <akshata.jahagirdar@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 08:22:04.287621219 -0500
+++ /tmp/tmp.piLgrFj0iY	2024-11-23 08:22:04.278840217 -0500
@@ -1,3 +1,5 @@
+commit 108c972a11c5f6e37be58207460d9bcac06698db upstream.
+
 For Xe2 dGPU, we clear the bo by modifying the VRAM using an
 uncompressed pat index which then indirectly updates the
 compression status as uncompressed i.e zeroed CCS.
@@ -13,15 +15,16 @@
 Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
 Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/8dd869dd8dda5e17ace28c04f1a48675f5540874.1721250309.git.akshata.jahagirdar@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/xe_migrate.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
-index fa23a7e7ec435..85eec95c9bc27 100644
+index a849c48d8ac90..8315cb02f370d 100644
 --- a/drivers/gpu/drm/xe/xe_migrate.c
 +++ b/drivers/gpu/drm/xe/xe_migrate.c
-@@ -347,6 +347,11 @@ static u32 xe_migrate_usm_logical_mask(struct xe_gt *gt)
+@@ -348,6 +348,11 @@ static u32 xe_migrate_usm_logical_mask(struct xe_gt *gt)
  	return logical_mask;
  }
  
@@ -33,7 +36,7 @@
  /**
   * xe_migrate_init() - Initialize a migrate context
   * @tile: Back-pointer to the tile we're initializing for.
-@@ -420,7 +425,7 @@ struct xe_migrate *xe_migrate_init(struct xe_tile *tile)
+@@ -421,7 +426,7 @@ struct xe_migrate *xe_migrate_init(struct xe_tile *tile)
  		return ERR_PTR(err);
  
  	if (IS_DGFX(xe)) {
@@ -42,7 +45,7 @@
  			/* min chunk size corresponds to 4K of CCS Metadata */
  			m->min_chunk_size = SZ_4K * SZ_64K /
  				xe_device_ccs_bytes(xe, SZ_64K);
-@@ -1034,7 +1039,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
+@@ -1035,7 +1040,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
  					clear_system_ccs ? 0 : emit_clear_cmd_len(gt), 0,
  					avail_pts);
  
@@ -51,7 +54,7 @@
  			batch_size += EMIT_COPY_CCS_DW;
  
  		/* Clear commands */
-@@ -1062,7 +1067,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
+@@ -1063,7 +1068,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
  		if (!clear_system_ccs)
  			emit_clear(gt, bb, clear_L0_ofs, clear_L0, XE_PAGE_SIZE, clear_vram);
  
@@ -60,3 +63,6 @@
  			emit_copy_ccs(gt, bb, clear_L0_ofs, true,
  				      m->cleared_mem_ofs, false, clear_L0);
  			flush_flags = MI_FLUSH_DW_CCS;
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

