Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020B5735267
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjFSKeV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFSKeT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B56CD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB3460B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AC3C433C0;
        Mon, 19 Jun 2023 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170857;
        bh=4k3pDR9DQdCDrCnrxZgNgOQ0Y3BMlPys7q1ey9lMpvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruelD03mhRFYsgg6u4i3Rdzq1VbeTmvzrpe99r/SP/iGwB1DYpuIhBYcaW1Mfai4v
         W8YaHT5lLjUZMT7kH5fyA0k6JNoY92PvhMn5IGwg/bL14RzSdHZ17CE/iJTXwMiwgP
         NgUiYOS4ZMXKAmmeNrSy5Xqr32F5t6WQmTs8rsSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 060/187] Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM in large bar system"
Date:   Mon, 19 Jun 2023 12:27:58 +0200
Message-ID: <20230619102200.579966355@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

commit 34e5a54327dce5033582f3609eb54812a8c61b90 upstream.

This reverts commit c105518679b6e87232874ffc989ec403bee59664.

This patch disables the TOPDOWN flag for APU and few dGPU cards
which has the VRAM size equal to the BAR size.

When we enable the TOPDOWN flag, we get the free blocks at
the highest available memory region and we don't split the
lower order blocks. This change is required to keep off
the fragmentation related issues particularly in ASIC
which has VRAM space <= 500MiB

Hence, we are reverting this patch.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2270
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3b225be89cb7..a70103ac0026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -140,7 +140,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			places[c].lpfn = visible_pfn;
-		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
+		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
 		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
-- 
2.41.0



