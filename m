Return-Path: <stable+bounces-135804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D6A990B0
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFB93A88F6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE0284B20;
	Wed, 23 Apr 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2wW2OAhZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D6156F28;
	Wed, 23 Apr 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420887; cv=none; b=CbEKW74nOZCNteNVCkLfSb+h2meDdVvPX01Cg5wh+GWxSbPgFAIZPXSuaP77YowOn38UpKGAquqhUOiXGF4KXRxBtRiOgnZHjaysvoFEgEYmDqixRaPoVhOi0TkSq5rV7i6HLOC2kzLuzCLIu3F3UlKnnVMjCOEgEwHRy/LEwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420887; c=relaxed/simple;
	bh=k6biEyu2tCgaR03QdATC9epmCTvd9ER7bgZDnhHncbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn7oFuyV8Rmhk+XN6VA+K56Y1NF7X1nKNvekm8S2huG7Vupl0L9MB3bVKinsKGrBJ4Tf02i1vWHjmgB8Ey27s+f46YMrmAFUsU9SohNby/YWN67ETfxW2TMYZzVoyfuJ4NKrmnkkep9m/PgXsUgZvwgOLeerV8Qhf1Dq+u78aQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2wW2OAhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C9C4CEE2;
	Wed, 23 Apr 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420887;
	bh=k6biEyu2tCgaR03QdATC9epmCTvd9ER7bgZDnhHncbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2wW2OAhZE8kkrXX+0bUEE4fev+2z/aXA+nr+AiMw1T30pP+coODM3CKMpmykJy6VK
	 6ZyFL737eRw8JRLOCx+QTB0FwDXG9tL5UOCUYHTRLkkyp0/yY4YI42uC2KQy7p9Q8a
	 z7zjids4o3k70qvpd9Fb9v/wwqvKDwhFq3woIRCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Stable@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12 171/223] drm/nouveau: prime: fix ttm_bo_delayed_delete oops
Date: Wed, 23 Apr 2025 16:44:03 +0200
Message-ID: <20250423142624.130188454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

From: Chris Bainbridge <chris.bainbridge@gmail.com>

commit 8ec0fbb28d049273bfd4f1e7a5ae4c74884beed3 upstream.

Fix an oops in ttm_bo_delayed_delete which results from dererencing a
dangling pointer:

Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b7b: 0000 [#1] PREEMPT SMP
CPU: 4 UID: 0 PID: 1082 Comm: kworker/u65:2 Not tainted 6.14.0-rc4-00267-g505460b44513-dirty #216
Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/2024
Workqueue: ttm ttm_bo_delayed_delete [ttm]
RIP: 0010:dma_resv_iter_first_unlocked+0x55/0x290
Code: 31 f6 48 c7 c7 00 2b fa aa e8 97 bd 52 ff e8 a2 c1 53 00 5a 85 c0 74 48 e9 88 01 00 00 4c 89 63 20 4d 85 e4 0f 84 30 01 00 00 <41> 8b 44 24 10 c6 43 2c 01 48 89 df 89 43 28 e8 97 fd ff ff 4c 8b
RSP: 0018:ffffbf9383473d60 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffffbf9383473d88 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffbf9383473d78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 6b6b6b6b6b6b6b6b
R13: ffffa003bbf78580 R14: ffffa003a6728040 R15: 00000000000383cc
FS:  0000000000000000(0000) GS:ffffa00991c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000758348024dd0 CR3: 000000012c259000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x26
 ? die_addr+0x3d/0x70
 ? exc_general_protection+0x159/0x460
 ? asm_exc_general_protection+0x27/0x30
 ? dma_resv_iter_first_unlocked+0x55/0x290
 dma_resv_wait_timeout+0x56/0x100
 ttm_bo_delayed_delete+0x69/0xb0 [ttm]
 process_one_work+0x217/0x5c0
 worker_thread+0x1c8/0x3d0
 ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
 kthread+0x10b/0x240
 ? kthreads_online_cpu+0x140/0x140
 ret_from_fork+0x40/0x70
 ? kthreads_online_cpu+0x140/0x140
 ret_from_fork_asm+0x11/0x20
 </TASK>

The cause of this is:

- drm_prime_gem_destroy calls dma_buf_put(dma_buf) which releases the
  reference to the shared dma_buf. The reference count is 0, so the
  dma_buf is destroyed, which in turn decrements the corresponding
  amdgpu_bo reference count to 0, and the amdgpu_bo is destroyed -
  calling drm_gem_object_release then dma_resv_fini (which destroys the
  reservation object), then finally freeing the amdgpu_bo.

- nouveau_bo obj->bo.base.resv is now a dangling pointer to the memory
  formerly allocated to the amdgpu_bo.

- nouveau_gem_object_del calls ttm_bo_put(&nvbo->bo) which calls
  ttm_bo_release, which schedules ttm_bo_delayed_delete.

- ttm_bo_delayed_delete runs and dereferences the dangling resv pointer,
  resulting in a general protection fault.

Fix this by moving the drm_prime_gem_destroy call from
nouveau_gem_object_del to nouveau_bo_del_ttm. This ensures that it will
be run after ttm_bo_delayed_delete.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Fixes: 22b33e8ed0e3 ("nouveau: add PRIME support")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3937
Cc: Stable@vger.kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/Z-P4epVK8k7tFZ7C@debian.local
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c  |    3 +++
 drivers/gpu/drm/nouveau/nouveau_gem.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -144,6 +144,9 @@ nouveau_bo_del_ttm(struct ttm_buffer_obj
 	nouveau_bo_del_io_reserve_lru(bo);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
 
+	if (bo->base.import_attach)
+		drm_prime_gem_destroy(&bo->base, bo->sg);
+
 	/*
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -87,9 +87,6 @@ nouveau_gem_object_del(struct drm_gem_ob
 		return;
 	}
 
-	if (gem->import_attach)
-		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-
 	ttm_bo_put(&nvbo->bo);
 
 	pm_runtime_mark_last_busy(dev);



