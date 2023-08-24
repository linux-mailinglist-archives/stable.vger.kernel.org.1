Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566BE78725D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjHXOxG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbjHXOwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3110D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2886966E9E
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE41C433C7;
        Thu, 24 Aug 2023 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888763;
        bh=U0eIEKSt4OQjBfn1H3Tf/Ov92yvJZOToucofV9V4W6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AApKwEya5pmJUSPUxmLaR1sw0wd2D33SFdljlJVTzkLpBcMuLqrzP3GJSWJ5AsV0F
         ztajvxPPEgADVm3Og9aZ9vzK6Vdhy1Z5Il+rnEfU5HPo632BRiE6rJ//h8ICy485Pg
         Lwr5Px0FS3IWhEeOgXlD6Nkndrqbfa8ptHH27KXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Lang Yu <Lang.Yu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/139] drm/amdgpu: install stub fence into potential unused fence pointers
Date:   Thu, 24 Aug 2023 16:48:58 +0200
Message-ID: <20230824145024.239654518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]

When using cpu to update page tables, vm update fences are unused.
Install stub fence into these fence pointers instead of NULL
to avoid NULL dereference when calling dma_fence_wait() on them.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e4554950e072..788611a50a68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2260,6 +2260,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
+	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2974,7 +2975,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-	vm->last_update = NULL;
+
+	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
@@ -3117,7 +3119,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
 	dma_fence_put(vm->last_update);
-	vm->last_update = NULL;
+	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
-- 
2.40.1



