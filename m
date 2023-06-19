Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E38735290
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFSKgX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFSKfo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871C31997
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F237060B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1263AC433C0;
        Mon, 19 Jun 2023 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170933;
        bh=BepBESkSn/SYV9jPUIP25R3GgUvzSqOOqVTW5Ydp2+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmZqynz/QhxgFjJ4D1rTWWTaeTp9gEt6/8zRsAM3/h+wO1jqeUBqQ+fIN0B09kHQF
         MQU6w0kHb7SssbEOaumBMG42wCKvviZNqaC4UMOTcuRz95+Ul73DJHtaYXYeR/hAIQ
         AfHTpbh7FEHJxLIauHRuNUDeyEL8Hq/cngE7wde4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiadong Zhu <Jiadong.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 087/187] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
Date:   Mon, 19 Jun 2023 12:28:25 +0200
Message-ID: <20230619102201.825667204@linuxfoundation.org>
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

commit 1dbcf770cc2d15baf8a1e8174d6fd014a68b45ca upstream.

When MEC executes unmap_queue for mid command buffer preemption, it will
kick the write pointer of the gfx ring, set CP_VMID_PREEMPT to trigger the
preemption and wait for CP_VMID_PREEMPT becomes zero after the preemption
done. There is a race condition that PFP may excute the resetting command
before MEC set CP_VMID_PREEMPT. As a result, hang happens as
CP_VMID_PREEMPT is always 0xffff.

To avoid this, we send resetting CP_VMID_PREEMPT command after the trailing
fence is siganled and update gfx write pointer explicitly.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.3.x
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2535
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5366,10 +5366,6 @@ static int gfx_v9_0_ring_preempt_ib(stru
 	amdgpu_ring_alloc(ring, 13);
 	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
-	/*reset the CP_VMID_PREEMPT after trailing fence*/
-	amdgpu_ring_emit_wreg(ring,
-			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
-			      0x0);
 
 	/* assert IB preemption, emit the trailing fence */
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
@@ -5392,6 +5388,10 @@ static int gfx_v9_0_ring_preempt_ib(stru
 		DRM_WARN("ring %d timeout to preempt ib\n", ring->idx);
 	}
 
+	/*reset the CP_VMID_PREEMPT after trailing fence*/
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
+			      0x0);
 	amdgpu_ring_commit(ring);
 
 	/* deassert preemption condition */


