Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310D75546B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGPUaC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjGPUaB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17649D3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9B660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6656C433C8;
        Sun, 16 Jul 2023 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539400;
        bh=oh+bpNpnuRgFrG82qkGA8DJNXxDlfCEzL2HxGpnN5nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCduq+DlrWznJhoPVpa91sGy3dVK+9+W405PfqoIqupfirj5O8JJV6yQWDF4fxXz6
         NwZ+FtJHRe4FOFyKZ3PGmZRnoZbtknvv/+OvghIgpmzGMCIyuT8+rbRCgxHUgu6/1M
         zD5KaDJaPl6fubf47Sc3pqhqGe13dOcGGRk9ihqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH 6.4 787/800] drm/amdgpu: make sure BOs are locked in amdgpu_vm_get_memory
Date:   Sun, 16 Jul 2023 21:50:40 +0200
Message-ID: <20230716195007.428178299@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

commit e2ad8e2df432498b1cee2af04df605723f4d75e6 upstream.

We need to grab the lock of the BO or otherwise can run into a crash
when we try to inspect the current location.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Guchun Chen <guchun.chen@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.3.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   69 ++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 30 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -920,42 +920,51 @@ error_unlock:
 	return r;
 }
 
+static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
+				    struct amdgpu_mem_stats *stats)
+{
+	struct amdgpu_vm *vm = bo_va->base.vm;
+	struct amdgpu_bo *bo = bo_va->base.bo;
+
+	if (!bo)
+		return;
+
+	/*
+	 * For now ignore BOs which are currently locked and potentially
+	 * changing their location.
+	 */
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
+	    !dma_resv_trylock(bo->tbo.base.resv))
+		return;
+
+	amdgpu_bo_get_memory(bo, stats);
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	    dma_resv_unlock(bo->tbo.base.resv);
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats *stats)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
 	spin_unlock(&vm->status_lock);
 }
 


