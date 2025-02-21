Return-Path: <stable+bounces-118599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A68A3F779
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1628862F60
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBF20FAB3;
	Fri, 21 Feb 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSf/iSjB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24C1DA53
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148766; cv=none; b=YSpx2U0vy9pZj7+mpK+GEhqz16C/OP9u2axuLvDyj3titg7Vs7j+QK4SFS0BHwM96DYV2IIV6LEerII9r5WHGIjpMI71EtOFNa9MFOsPZprUUoKwfqMvdmI7A9XvB8+FGBW7hwJrBlMCUvjO0IVGC6HzymLAiFmEBEeDbUFepYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148766; c=relaxed/simple;
	bh=CESpiVpdPIFpj6wiOMNyTEvB+ZBCyFHqOaTh0Q8w7Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJTK1sV4hcTz2T4PhNSwd3KSf0cOOkiHXDK4u9pukD4txiialjeBU+ishK9HScJmwOasbd6UYJHLeJcgLwZmygPt3E+aEYxr3VNw0Ta8vqyD12K3p9oIIGOa04tQnsTij744V5cB/08Gj1RV/9FCFPOdYGu3ULU7eJq4ejJ7Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSf/iSjB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148764; x=1771684764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CESpiVpdPIFpj6wiOMNyTEvB+ZBCyFHqOaTh0Q8w7Co=;
  b=VSf/iSjBemBHironaMlapBcGu2ZpTWDPGr59S98j5wiP7LeksGiATnlt
   efE8Tff3z9iR+nEYJ2jmkCwrg64X0soVYDt3iLZE5CoSn026S6APGf/+i
   ZSHvIXo0f9CrAOL0AtEwRI1vDQR1U+rZRlfHrMW3knXFwWlGd9d4h6InC
   4H757DU5bdO6/ck2hrfkfz5RvjhnlaYWabi0WK7P2U3FKILLH1JnOjTqy
   G46tHoXzx44atLxvAOXPsGIEGsReJq4hJA2HkhKVine8aNwIan0zS0w44
   0u+yZ5pyX9Cym7pGQFPqQHMv3td9xEyrc4g3kBrX0quh5R0laB3MMxt5d
   A==;
X-CSE-ConnectionGUID: kk0LjMniQjmys3ibjVUiew==
X-CSE-MsgGUID: EWqgZitPTFShTkMJu2lf6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58377714"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="58377714"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:39:23 -0800
X-CSE-ConnectionGUID: ctxNmrTgQLGh8N3oAsbXYw==
X-CSE-MsgGUID: ICvp5ByISj6H0wdt+Xhk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152580285"
Received: from sosterlu-desk.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:39:22 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/xe/userptr: restore invalidation list on error
Date: Fri, 21 Feb 2025 14:38:41 +0000
Message-ID: <20250221143840.167150-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On error restore anything still on the pin_list back to the invalidation
list on error. For the actual pin, so long as the vma is tracked on
either list it should get picked up on the next pin, however it looks
possible for the vma to get nuked but still be present on this per vm
pin_list leading to corruption. An alternative might be then to instead
just remove the link when destroying the vma.

v2:
 - Also add some asserts.
 - Keep the overzealous locking so that we are consistent with the docs;
   updating the docs and related bits will be done as a follow up.

Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d664f2e418b2..3dbfb20a7c60 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -667,15 +667,16 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 
 	/* Collect invalidated userptrs */
 	spin_lock(&vm->userptr.invalidated_lock);
+	xe_assert(vm->xe, list_empty(&vm->userptr.repin_list));
 	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
 				 userptr.invalidate_link) {
 		list_del_init(&uvma->userptr.invalidate_link);
-		list_move_tail(&uvma->userptr.repin_link,
-			       &vm->userptr.repin_list);
+		list_add_tail(&uvma->userptr.repin_link,
+			      &vm->userptr.repin_list);
 	}
 	spin_unlock(&vm->userptr.invalidated_lock);
 
-	/* Pin and move to temporary list */
+	/* Pin and move to bind list */
 	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
 				 userptr.repin_link) {
 		err = xe_vma_userptr_pin_pages(uvma);
@@ -691,10 +692,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 			err = xe_vm_invalidate_vma(&uvma->vma);
 			xe_vm_unlock(vm);
 			if (err)
-				return err;
+				break;
 		} else {
-			if (err < 0)
-				return err;
+			if (err)
+				break;
 
 			list_del_init(&uvma->userptr.repin_link);
 			list_move_tail(&uvma->vma.combined_links.rebind,
@@ -702,7 +703,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 		}
 	}
 
-	return 0;
+	if (err) {
+		down_write(&vm->userptr.notifier_lock);
+		spin_lock(&vm->userptr.invalidated_lock);
+		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
+					 userptr.repin_link) {
+			list_del_init(&uvma->userptr.repin_link);
+			list_move_tail(&uvma->userptr.invalidate_link,
+				       &vm->userptr.invalidated);
+		}
+		spin_unlock(&vm->userptr.invalidated_lock);
+		up_write(&vm->userptr.notifier_lock);
+	}
+	return err;
 }
 
 /**
@@ -1067,6 +1080,7 @@ static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
 		xe_assert(vm->xe, vma->gpuva.flags & XE_VMA_DESTROYED);
 
 		spin_lock(&vm->userptr.invalidated_lock);
+		xe_assert(vm->xe, list_empty(&to_userptr_vma(vma)->userptr.repin_link));
 		list_del(&to_userptr_vma(vma)->userptr.invalidate_link);
 		spin_unlock(&vm->userptr.invalidated_lock);
 	} else if (!xe_vma_is_null(vma)) {
-- 
2.48.1


