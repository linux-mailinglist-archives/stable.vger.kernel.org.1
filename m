Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4141373528C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFSKgZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFSKf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5679E50
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6580960B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B91CC433C8;
        Mon, 19 Jun 2023 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170938;
        bh=Fxwm/A/YrnlbP1xH1e92iHPEpfVUU1EiQTtWPB8O+wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rSmT0LMS1Puz4bM81pW8XBxtlyqRcO9+AZGRTk6eiKwrGSJRgqORP2uciG5ymcmU
         invh0SrPOnLLV6F0p1wnfez5kgmGvK5efUSg1GMc8TdlbI7/9NyE6N1/UEZebv+TQw
         gSGkJi/wfP0MeQ3OcJ0DD17c/LwDgNdVVi3R6bL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiadong Zhu <Jiadong.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 089/187] drm/amdgpu: Implement gfx9 patch functions for resubmission
Date:   Mon, 19 Jun 2023 12:28:27 +0200
Message-ID: <20230619102201.913596258@linuxfoundation.org>
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

commit 5b711e7f9c73e5ff44d6ac865711d9a05c2a0360 upstream.

Patch the packages including CONTEXT_CONTROL and WRITE_DATA for gfx9
during the resubmission scenario.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.3.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |   80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5136,9 +5136,83 @@ static void gfx_v9_0_ring_emit_ib_gfx(st
 #endif
 		lower_32_bits(ib->gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_ib_on_emit_cntl(ring);
 	amdgpu_ring_write(ring, control);
 }
 
+static void gfx_v9_0_ring_patch_cntl(struct amdgpu_ring *ring,
+				     unsigned offset)
+{
+	u32 control = ring->ring[offset];
+
+	control |= INDIRECT_BUFFER_PRE_RESUME(1);
+	ring->ring[offset] = control;
+}
+
+static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
+					unsigned offset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	void *ce_payload_cpu_addr;
+	uint64_t payload_offset, payload_size;
+
+	payload_size = sizeof(struct v9_ce_ib_state);
+
+	if (ring->is_mes_queue) {
+		payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+					  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+	} else {
+		payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	}
+
+	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
+		memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, payload_size);
+	} else {
+		memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr,
+		       (ring->buf_mask + 1 - offset) << 2);
+		payload_size -= (ring->buf_mask + 1 - offset) << 2;
+		memcpy((void *)&ring->ring[0],
+		       ce_payload_cpu_addr + ((ring->buf_mask + 1 - offset) << 2),
+		       payload_size);
+	}
+}
+
+static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
+					unsigned offset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	void *de_payload_cpu_addr;
+	uint64_t payload_offset, payload_size;
+
+	payload_size = sizeof(struct v9_de_ib_state);
+
+	if (ring->is_mes_queue) {
+		payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+					  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+	} else {
+		payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	}
+
+	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
+		memcpy((void *)&ring->ring[offset], de_payload_cpu_addr, payload_size);
+	} else {
+		memcpy((void *)&ring->ring[offset], de_payload_cpu_addr,
+		       (ring->buf_mask + 1 - offset) << 2);
+		payload_size -= (ring->buf_mask + 1 - offset) << 2;
+		memcpy((void *)&ring->ring[0],
+		       de_payload_cpu_addr + ((ring->buf_mask + 1 - offset) << 2),
+		       payload_size);
+	}
+}
+
 static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					  struct amdgpu_job *job,
 					  struct amdgpu_ib *ib,
@@ -5334,6 +5408,8 @@ static void gfx_v9_0_ring_emit_ce_meta(s
 	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
 
+	amdgpu_ring_ib_on_emit_ce(ring);
+
 	if (resume)
 		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
 					   sizeof(ce_payload) >> 2);
@@ -5445,6 +5521,7 @@ static void gfx_v9_0_ring_emit_de_meta(s
 	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
 
+	amdgpu_ring_ib_on_emit_de(ring);
 	if (resume)
 		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
 					   sizeof(de_payload) >> 2);
@@ -6857,6 +6934,9 @@ static const struct amdgpu_ring_funcs gf
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.patch_cntl = gfx_v9_0_ring_patch_cntl,
+	.patch_de = gfx_v9_0_ring_patch_de_meta,
+	.patch_ce = gfx_v9_0_ring_patch_ce_meta,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {


