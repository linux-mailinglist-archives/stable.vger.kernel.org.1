Return-Path: <stable+bounces-140363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170FDAAA813
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873223A222D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEB2951DB;
	Mon,  5 May 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI24fnyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5E342C58;
	Mon,  5 May 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484699; cv=none; b=nFLWMU/Mrydx8InsEGu2V6DvdffDG/WnlkZVURpfla/NWLdGF4qV6jwKZkv1czvznjEvqvQ0kaDAHExLkG87+02r7NUxgLCrXl1lhNqHScQtiCj+g8wVHXqrBI8ixTdC+TYeiCrxzcfLgPYZDzJ6+i66xxq5FSk1lIEZcexM1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484699; c=relaxed/simple;
	bh=0jJpeiHnYWgIFgKj0qEsk+AkW9DP3GPJTJhyg3HrpxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPmG0g8t7i8ZCm7V80UQaFbMj1vVn1f2NFiMESSg3YwLDVt2/BUoxCMi0s8dfpKa6800u+4H+OWcMNZRz1HPs9wvJ/TVTYH0ifrZsxar2xSfEe7cj1h0AAxYvxzGXXfJqoPHs5RraDPYagl1gPOtCkVl1HFDtMPMAYb0ro/ie7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI24fnyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBA9C4CEE4;
	Mon,  5 May 2025 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484699;
	bh=0jJpeiHnYWgIFgKj0qEsk+AkW9DP3GPJTJhyg3HrpxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EI24fnyq0MMWtHxf2gBvFP6xSFH0KDQr4fHyZkp9qk0rewZmUNlLN4qG7KS85xrFH
	 kAkLemgL4teSgt5+xSnICIWWgfdZqmnlURzV9DbLIqVZwcQWJJezB4oXTVdmkQ68vS
	 U9P55Li4+/HRZ4ta5neTbVTYnM45E627rctKzEajBQt+Cu5hX5NF8gDZF+YkFojsri
	 3VCazVpAXfK712ZV9QxFk0Izfcv/mMAOA+WTxVg4DKCmJtMY52akr+f5CvxiPtSO3E
	 yfMUDE9HW8ab5KxldhEF0R2fTTPbd2Y/iI2c3ytRwD0ZALyiWiSVcJiYLE6K5obqZF
	 DTPZv90rMumSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oak Zeng <oak.zeng@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 614/642] drm/xe: Reject BO eviction if BO is bound to current VM
Date: Mon,  5 May 2025 18:13:50 -0400
Message-Id: <20250505221419.2672473-614-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Oak Zeng <oak.zeng@intel.com>

[ Upstream commit 0af944f0e3082ff517958b1cea76fb9b8cb379dd ]

This is a follow up fix for
https://patchwork.freedesktop.org/patch/msgid/20241203021929.1919730-1-oak.zeng@intel.com
The overall goal is to fail vm_bind when there is memory pressure. See more
details in the commit message of above patch. Abbove patch fixes the issue
when user pass in a vm_id parameter during gem_create. If user doesn't pass
in a vm_id during gem_create, above patch doesn't help.

This patch further reject BO eviction (which could be triggered by bo validation)
if BO is bound to the current VM. vm_bind could fail due to the eviction failure.
The BO to VM reverse mapping structure is used to determine whether BO is bound
to VM.

v2:
Move vm_bo definition from function scope to if(evict) clause (Thomas)
Further constraint the condition by adding ctx->resv (Thomas)
Add a short comment describe the change.

Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Oak Zeng <oak.zeng@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250110210137.3181576-1-oak.zeng@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index d1eb87cb178bd..2070aa12059ce 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -713,6 +713,21 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		goto out;
 	}
 
+	/* Reject BO eviction if BO is bound to current VM. */
+	if (evict && ctx->resv) {
+		struct drm_gpuvm_bo *vm_bo;
+
+		drm_gem_for_each_gpuvm_bo(vm_bo, &bo->ttm.base) {
+			struct xe_vm *vm = gpuvm_to_vm(vm_bo->vm);
+
+			if (xe_vm_resv(vm) == ctx->resv &&
+			    xe_vm_in_preempt_fence_mode(vm)) {
+				ret = -EBUSY;
+				goto out;
+			}
+		}
+	}
+
 	/*
 	 * Failed multi-hop where the old_mem is still marked as
 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
-- 
2.39.5


