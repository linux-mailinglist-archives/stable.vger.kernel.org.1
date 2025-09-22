Return-Path: <stable+bounces-180952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA313B914DB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D64E1862
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BA3009E3;
	Mon, 22 Sep 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="tbf7RJOH"
X-Original-To: stable@vger.kernel.org
Received: from zdiv.net (zdiv.net [46.226.106.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC043093CD
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.106.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546630; cv=none; b=Ab4xwUcfMbzkZpy/DzCPg/jHZAhpV+megDSbhqNZxS1Y2Oua4iX4OLKxiwUb3dIQdlEZHe5fTVoWUPqFDkWZEtO2HeniAXyiC3wVFrcWOeTANd0/XKJ+NlwXy/NjS08OltqSyIkOv20BOthP4FYBBt7//O2AUuZgRptrKDjMgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546630; c=relaxed/simple;
	bh=BLrO2v57fnGj1aiAW/XmTRDSpHu8RaEGZX4ST6/+FoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C214k9kHQbxip/CIAqP+j9LWWnRlcp2GA8eawNsDXLkQG+F05iDVrOoNE6s+0XFLUX6gJdOJb3NmocquBm6120BuG6rhNZJQxb5UOV0qWDCRqeerVh0NKpCrw8o2WPJjOCFotOPhT5leOIcx5+FnLmtSEk6btT4bw3cpDCJ5hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=tbf7RJOH; arc=none smtp.client-ip=46.226.106.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=24;
	t=1758546622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkX1OSso9StKcXe8Ccg7q//qAjhs+k7XaQWlVZtX2pw=;
	b=tbf7RJOHBJo5K3Fp3K/Na22CXXU6VZJabJcdrJEMaBnPMfvnvtTusAwFvljLU7cUuJYJuY
	TCqGy424GgS8gO4F9xoT9mnb9rtAN7ywR6YSFWQRoQ1L6l2+JoR67FqdqDAewhX/ojfleG
	KnjdUPsyZ2G1KmknNoJFw6Nq/Q1ekSS14uqzGVUwFUxCFNcqBr+qPB7WG2VVj52qkC2Bm6
	48fXtQh8j4HiRMuQXpomH7dQ9nruvfiNGZru0cCSMX7pA9PH7NKUWPAhAV4xQCUYWvsROZ
	LioDbKsGTlkrtA+lqS9YCVbw8rEWb8RYlZGCHMhmfi3NvIRBmnfTszSxl4U3cw==
Received: from mini.my.domain (<unknown> [2a01:e0a:12:d860:2bfd:172b:4737:fa07])
	by zdiv.net (OpenSMTPD) with ESMTPSA id ff98eb07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Sep 2025 15:10:22 +0200 (CEST)
From: Jules Maselbas <jmaselbas@zdiv.net>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Liu01 Tong <Tong.Liu01@amd.com>,
	"Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12.y 3/3] drm/amdgpu: fix task hang from failed job submission during process kill
Date: Mon, 22 Sep 2025 15:09:48 +0200
Message-ID: <20250922130948.5549-3-jmaselbas@zdiv.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922130948.5549-1-jmaselbas@zdiv.net>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Liu01 Tong <Tong.Liu01@amd.com>

commit aa5fc4362fac9351557eb27c745579159a2e4520 upstream.

During process kill, drm_sched_entity_flush() will kill the vm
entities. The following job submissions of this process will fail, and
the resources of these jobs have not been released, nor have the fences
been signalled, causing tasks to hang and timeout.

Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
stopped entity.

v2: add amdgpu_vm_ready() check before amdgpu_vm_clear_freed() in
function amdgpu_cs_vm_handling().

Fixes: 1f02f2044bda ("drm/amdgpu: Avoid extra evict-restore process.")
Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f101c13a8720c73e67f8f9d511fbbeda95bcedb1)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3a0dc1f487c30521a0fba0b935d0886b9b1984a5)
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5df21529b3b1..0316707647d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1116,6 +1116,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		}
 	}
 
+	if (!amdgpu_vm_ready(vm))
+		return -EINVAL;
+
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37d53578825b..7cfae3fb3097 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -543,11 +543,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * Check if all VM PDs/PTs are ready for updates
  *
  * Returns:
- * True if VM is not evicting.
+ * True if VM is not evicting and all VM entities are not stopped
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
-	bool empty;
 	bool ret;
 
 	amdgpu_vm_eviction_lock(vm);
@@ -555,10 +554,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	amdgpu_vm_eviction_unlock(vm);
 
 	spin_lock(&vm->status_lock);
-	empty = list_empty(&vm->evicted);
+	ret &= list_empty(&vm->evicted);
 	spin_unlock(&vm->status_lock);
 
-	return ret && empty;
+	spin_lock(&vm->immediate.lock);
+	ret &= !vm->immediate.stopped;
+	spin_unlock(&vm->immediate.lock);
+
+	spin_lock(&vm->delayed.lock);
+	ret &= !vm->delayed.stopped;
+	spin_unlock(&vm->delayed.lock);
+
+	return ret;
 }
 
 /**
-- 
2.51.0


