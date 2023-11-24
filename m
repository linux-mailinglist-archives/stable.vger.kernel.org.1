Return-Path: <stable+bounces-1487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249347F7FEE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EC928222C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029F381A2;
	Fri, 24 Nov 2023 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXLd+Q5k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA55364A0;
	Fri, 24 Nov 2023 18:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0C1C433C8;
	Fri, 24 Nov 2023 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851523;
	bh=5o458WdnwgpMytmLDXVQWSiiY+lLhw3H/y3c/rxAjds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXLd+Q5kygOxNRbRoqzNDuW7U6tVhUQ6pEj87+usd+dVzXym7hydv/1Ja/ue8cmtL
	 CYGk2rhO05I+LcBVA8Ll/SMq7zepzZ+vyhAJUHr03IKqHitjSi4zqF69JUHP8BDd9e
	 ypzt0oBXKX/pBBv3fgDvYgJ1tMLLfUqPAUSSEkBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 481/491] drm/amdgpu: fix error handling in amdgpu_vm_init
Date: Fri, 24 Nov 2023 17:51:57 +0000
Message-ID: <20231124172039.087165100@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 8473bfdcb5b1a32fd05629c4535ccacd73bc5567 upstream.

When clearing the root PD fails we need to properly release it again.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2129,7 +2129,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_v
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		   int32_t xcp_id)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2148,6 +2149,7 @@ int amdgpu_vm_init(struct amdgpu_device
 	INIT_LIST_HEAD(&vm->done);
 	INIT_LIST_HEAD(&vm->pt_freed);
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
+	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
 	if (r)
@@ -2182,34 +2184,33 @@ int amdgpu_vm_init(struct amdgpu_device
 				false, &root, xcp_id);
 	if (r)
 		goto error_free_delayed;
-	root_bo = &root->bo;
+
+	root_bo = amdgpu_bo_ref(&root->bo);
 	r = amdgpu_bo_reserve(root_bo, true);
-	if (r)
-		goto error_free_root;
+	if (r) {
+		amdgpu_bo_unref(&root->shadow);
+		amdgpu_bo_unref(&root_bo);
+		goto error_free_delayed;
+	}
 
+	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
 	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
 	if (r)
-		goto error_unreserve;
-
-	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
+		goto error_free_root;
 
 	r = amdgpu_vm_pt_clear(adev, vm, root, false);
 	if (r)
-		goto error_unreserve;
+		goto error_free_root;
 
 	amdgpu_bo_unreserve(vm->root.bo);
-
-	INIT_KFIFO(vm->faults);
+	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
-error_unreserve:
-	amdgpu_bo_unreserve(vm->root.bo);
-
 error_free_root:
-	amdgpu_bo_unref(&root->shadow);
+	amdgpu_vm_pt_free_root(adev, vm);
+	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
-	vm->root.bo = NULL;
 
 error_free_delayed:
 	dma_fence_put(vm->last_tlb_flush);



