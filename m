Return-Path: <stable+bounces-146954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5AAC55AF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701FE3B1BC4
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF327CCF0;
	Tue, 27 May 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRWD39Q+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0C139579;
	Tue, 27 May 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365823; cv=none; b=VOGTqI5/n3xpJmAQGHZ1s88E3GtxOk8JLIpq1ICCVIAxGgUdXov/iiN8PO14ZhydOztSqiXx5YFzbdfE3dJ25IlpwjBBmDd8fKctklVwPv6bujAOyO1p/sPGCS673/pB8BfaWeFmT1itmYFFbGRc8f2SP/mApgmjby1iDLS/IrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365823; c=relaxed/simple;
	bh=HSriP0PvkuIvl6pmUNEdwJfuvOb9mUkJgkYBlDW/wD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST7qX4jOEtNj1FwT07W+uDryZXOGexCYBgt910JvQfa2MNBPwi9+TP2WrjehNHs9iciCHl1Pgm1zFS7VWsFzcp1YkZxBOpkTY4XPEdpPbMfypOHHOflbcHZ0G30G7s+e8g0L37yhfrUdhMjfiHc0GOy3vVTCRYMkZ/RHauUySO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRWD39Q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F2C4CEE9;
	Tue, 27 May 2025 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365823;
	bh=HSriP0PvkuIvl6pmUNEdwJfuvOb9mUkJgkYBlDW/wD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRWD39Q+A0zrnJ8EZXKAdzXiv9eIcjgbMnymedQjc9K52oSqV0OofRyM7DPPyoldw
	 Uqqtsb8fuuWz4+vvKXDR8Ma0xnYQXkreiyR8CmUnImS14gWvgsFebDmNdhgTJ2IsxC
	 OPbenrYS6p2lTgh+AUi69a7FfwWpx7+CVpF3dHZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 500/626] drm/xe: Reject BO eviction if BO is bound to current VM
Date: Tue, 27 May 2025 18:26:33 +0200
Message-ID: <20250527162505.290060479@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 35a8242a9f541..8acc4640f0a28 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -702,6 +702,21 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
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




