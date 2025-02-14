Return-Path: <stable+bounces-116432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B0A363DF
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3057A1D12
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E0267706;
	Fri, 14 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDUflcv3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE813C67E
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552752; cv=none; b=rbgLuYbQB0yKe6CGaJYDaLxbDVB6LUL1eu3iJEzG1kNagv9z/HxdUWWm4JTwMHifPOCYou5cAylhF1qCFuZCMk71z8k2Vr/QGZed2BzKA3WriNO3SUoLQgMQ05UUqkXfM6jhWKNS4rJ4wKXbj7mI+ZeyKS8BYzI0fyTsIg881do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552752; c=relaxed/simple;
	bh=ZHc0Me6eSm6dCCq5HnWbRrBO4ZYUq7DcvRlldVbmHO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qh/8sKeUOeQ+B/nYXFfLpkhUaT6jaAMkYLqziXX56p8bCm/kAehsr5ZE9szrpcCPITcgOHpLJQ2aUNknP5kv76IysVrhc2hUfWnJ/BrZDduZVVZYb75sL+8mXSiqYqlg93hVE4mlBW3DV4y+vwuHr32IkX3yZEPcykuR/pzqeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDUflcv3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739552751; x=1771088751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZHc0Me6eSm6dCCq5HnWbRrBO4ZYUq7DcvRlldVbmHO4=;
  b=lDUflcv31QyuFJWgX9FDVQ4ugh3NRqQ+OQEw0iUp0RnkwioYvoVszC71
   3fUVs82Tk3G919OVls3GKGeZGjAL9rDEym4GFL2UWktYO7ZOSoapqbNIr
   xKawimLNy5tM669nSvel09YY5jv8YlADY1rCHMTSrvP2j9toArUrlvi+j
   VU0yZfwH987f9EZne6L3RqxAIquzhQi75pvkzbxbOdgpXGJ7Jd8wPImnE
   wZ1r5fPhcCmK/HOzuzI8mPMdwpgf1aua1r89ldNdpi8eOvTZlwJ0/L0ur
   Qa26OKa5EnwcTeF9RFXmtVSPeyTMUJI61WC8dVmvwbcs5d8eSUhNUIX76
   A==;
X-CSE-ConnectionGUID: UavX6gijTFamiGXl7WoOog==
X-CSE-MsgGUID: hNp4Y29bQ2uuLFlBEBYkow==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40575940"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40575940"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:05:40 -0800
X-CSE-ConnectionGUID: paH0k3FLRXOU5+goo0DZ9A==
X-CSE-MsgGUID: OrvJ9jlRQKGe7d3CCSBDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113235217"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:05:38 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on error
Date: Fri, 14 Feb 2025 17:05:28 +0000
Message-ID: <20250214170527.272182-4-matthew.auld@intel.com>
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

Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d664f2e418b2..668b0bde7822 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
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
@@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
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
@@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
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
-- 
2.48.1


