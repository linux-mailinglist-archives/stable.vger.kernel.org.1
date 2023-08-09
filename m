Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604407758EA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjHIK4A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjHIKzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B12137
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 303FF63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B89C433C8;
        Wed,  9 Aug 2023 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578535;
        bh=2aWB3gU7X6NtYXfDX9pde5ZUi6gsgHqxac/KJqsdpp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPAZDtfyJVsQKfpL6OWANG8TUulwjPAn0lUmyVOGp5m1+uwjolBasIFABLfBFbnhu
         Vkgj/RTO5CenDAuRih2TzadVLEAa8oBNUmpuuuvOSHNQWYYyruNdBCMwf94c6huxpi
         ogsOwMvTIf3zN83kfXMBIkGjBRrVNG6MDm6dVOP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.1 094/127] drm/ttm: check null pointer before accessing when swapping
Date:   Wed,  9 Aug 2023 12:41:21 +0200
Message-ID: <20230809103639.745729882@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

commit 2dedcf414bb01b8d966eb445db1d181d92304fb2 upstream.

Add a check to avoid null pointer dereference as below:

[   90.002283] general protection fault, probably for non-canonical
address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   90.002292] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[   90.002346]  ? exc_general_protection+0x159/0x240
[   90.002352]  ? asm_exc_general_protection+0x26/0x30
[   90.002357]  ? ttm_bo_evict_swapout_allowable+0x322/0x5e0 [ttm]
[   90.002365]  ? ttm_bo_evict_swapout_allowable+0x42e/0x5e0 [ttm]
[   90.002373]  ttm_bo_swapout+0x134/0x7f0 [ttm]
[   90.002383]  ? __pfx_ttm_bo_swapout+0x10/0x10 [ttm]
[   90.002391]  ? lock_acquire+0x44d/0x4f0
[   90.002398]  ? ttm_device_swapout+0xa5/0x260 [ttm]
[   90.002412]  ? lock_acquired+0x355/0xa00
[   90.002416]  ? do_raw_spin_trylock+0xb6/0x190
[   90.002421]  ? __pfx_lock_acquired+0x10/0x10
[   90.002426]  ? ttm_global_swapout+0x25/0x210 [ttm]
[   90.002442]  ttm_device_swapout+0x198/0x260 [ttm]
[   90.002456]  ? __pfx_ttm_device_swapout+0x10/0x10 [ttm]
[   90.002472]  ttm_global_swapout+0x75/0x210 [ttm]
[   90.002486]  ttm_tt_populate+0x187/0x3f0 [ttm]
[   90.002501]  ttm_bo_handle_move_mem+0x437/0x590 [ttm]
[   90.002517]  ttm_bo_validate+0x275/0x430 [ttm]
[   90.002530]  ? __pfx_ttm_bo_validate+0x10/0x10 [ttm]
[   90.002544]  ? kasan_save_stack+0x33/0x60
[   90.002550]  ? kasan_set_track+0x25/0x30
[   90.002554]  ? __kasan_kmalloc+0x8f/0xa0
[   90.002558]  ? amdgpu_gtt_mgr_new+0x81/0x420 [amdgpu]
[   90.003023]  ? ttm_resource_alloc+0xf6/0x220 [ttm]
[   90.003038]  amdgpu_bo_pin_restricted+0x2dd/0x8b0 [amdgpu]
[   90.003210]  ? __x64_sys_ioctl+0x131/0x1a0
[   90.003210]  ? do_syscall_64+0x60/0x90

Fixes: a2848d08742c ("drm/ttm: never consider pinned BOs for eviction&swap")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230724024229.1118444-1-guchun.chen@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -552,7 +552,8 @@ static bool ttm_bo_evict_swapout_allowab
 
 	if (bo->pin_count) {
 		*locked = false;
-		*busy = false;
+		if (busy)
+			*busy = false;
 		return false;
 	}
 


