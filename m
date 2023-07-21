Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA275CED8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjGUQZD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjGUQYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A43558F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108F861D34
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF76C433C8;
        Fri, 21 Jul 2023 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956466;
        bh=gnRde1v4sHoYHaddTqCtOKtldUM3sgAJo5rFFOOO7pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbUaR5UizsUXqIdNRGjhupC51PZykL6+9XEvwqtHCBSGFCcqCuWCffi8ZzJAWChrm
         7SBVXxyn4e3peQ/mwOlIhz8toTl1LqdGtaC4i857V0xeT6+KkAkv0sBUX5QPU3H/ad
         xGWakmHGr0xW9/ef7wjYmEGrz4GSqtmez7M2LE0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 203/292] drm/amdgpu: fix clearing mappings for BOs that are always valid in VM
Date:   Fri, 21 Jul 2023 18:05:12 +0200
Message-ID: <20230721160537.602468731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samuel Pitoiset <samuel.pitoiset@gmail.com>

commit ea2c3c08554601b051d91403a241266e1cf490a5 upstream.

Per VM BOs must be marked as moved or otherwise their ranges are not
updated on use which might be necessary when the replace operation
splits mappings.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1683,18 +1683,30 @@ int amdgpu_vm_bo_clear_mappings(struct a
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}


