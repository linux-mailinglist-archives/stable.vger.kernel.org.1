Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6273528E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFSKgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFSKgA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F0E51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCD460B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D19C433C0;
        Mon, 19 Jun 2023 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170941;
        bh=IkULSifLx98C3O9KONoRx37bTXAjXxNA/y0IdXo1rdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUO0OZdtwLs/u/v5vvV+PPKWl5xkWWQYpM5kyj6jYnw+6wv6nI2yHTtWOBdRUfkmZ
         E8jmuTW939r61ofHSkeaZ09RT527BmJ1sqNFV54SS9fEeWrCzdvJeNy1J4Y07XCSws
         j7hAr+iZHxpet9K69tksuhhc/lLtSXd55kPJNh74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiadong Zhu <Jiadong.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 090/187] drm/amdgpu: Modify indirect buffer packages for resubmission
Date:   Mon, 19 Jun 2023 12:28:28 +0200
Message-ID: <20230619102201.964726292@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

commit 87af86ae89963c227a3beb4d914f3dc7959a690e upstream.

When the preempted IB frame resubmitted to cp, we need to modify the frame
data including:
1. set PRE_RESUME 1 in CONTEXT_CONTROL.
2. use meta data(DE and CE) read from CSA in WRITE_DATA.

Add functions to save the location the first time IBs emitted and callback
to patch the package when resubmission happens.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.3.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |   18 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |    9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c |   60 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |   15 ++++++
 4 files changed, 102 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -581,3 +581,21 @@ void amdgpu_ring_ib_end(struct amdgpu_ri
 	if (ring->is_sw_ring)
 		amdgpu_sw_ring_ib_end(ring);
 }
+
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_CONTROL);
+}
+
+void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_CE);
+}
+
+void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_DE);
+}
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -227,6 +227,9 @@ struct amdgpu_ring_funcs {
 	int (*preempt_ib)(struct amdgpu_ring *ring);
 	void (*emit_mem_sync)(struct amdgpu_ring *ring);
 	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
+	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
+	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
+	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 };
 
 struct amdgpu_ring {
@@ -316,10 +319,16 @@ struct amdgpu_ring {
 #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
+#define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
+#define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
+#define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
 
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
 void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
 
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -105,6 +105,16 @@ static void amdgpu_mux_resubmit_chunks(s
 				amdgpu_fence_update_start_timestamp(e->ring,
 								    chunk->sync_seq,
 								    ktime_get());
+				if (chunk->sync_seq ==
+					le32_to_cpu(*(e->ring->fence_drv.cpu_addr + 2))) {
+					if (chunk->cntl_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_cntl(e->ring,
+								       chunk->cntl_offset);
+					if (chunk->ce_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_ce(e->ring, chunk->ce_offset);
+					if (chunk->de_offset <= e->ring->buf_mask)
+						amdgpu_ring_patch_de(e->ring, chunk->de_offset);
+				}
 				amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, e->ring,
 								      chunk->start,
 								      chunk->end);
@@ -407,6 +417,17 @@ void amdgpu_sw_ring_ib_end(struct amdgpu
 	amdgpu_ring_mux_end_ib(mux, ring);
 }
 
+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mux_offset_type type)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+	unsigned offset;
+
+	offset = ring->wptr & ring->buf_mask;
+
+	amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type);
+}
+
 void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
 	struct amdgpu_mux_entry *e;
@@ -429,6 +450,10 @@ void amdgpu_ring_mux_start_ib(struct amd
 	}
 
 	chunk->start = ring->wptr;
+	/* the initialized value used to check if they are set by the ib submission*/
+	chunk->cntl_offset = ring->buf_mask + 1;
+	chunk->de_offset = ring->buf_mask + 1;
+	chunk->ce_offset = ring->buf_mask + 1;
 	list_add_tail(&chunk->entry, &e->list);
 }
 
@@ -454,6 +479,41 @@ static void scan_and_remove_signaled_chu
 	}
 }
 
+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
+				    struct amdgpu_ring *ring, u64 offset,
+				    enum amdgpu_ring_mux_offset_type type)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
+	if (!chunk) {
+		DRM_ERROR("cannot find chunk!\n");
+		return;
+	}
+
+	switch (type) {
+	case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
+		chunk->cntl_offset = offset;
+		break;
+	case AMDGPU_MUX_OFFSET_TYPE_DE:
+		chunk->de_offset = offset;
+		break;
+	case AMDGPU_MUX_OFFSET_TYPE_CE:
+		chunk->ce_offset = offset;
+		break;
+	default:
+		DRM_ERROR("invalid type (%d)\n", type);
+		break;
+	}
+}
+
 void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
 	struct amdgpu_mux_entry *e;
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -50,6 +50,12 @@ struct amdgpu_mux_entry {
 	struct list_head        list;
 };
 
+enum amdgpu_ring_mux_offset_type {
+	AMDGPU_MUX_OFFSET_TYPE_CONTROL,
+	AMDGPU_MUX_OFFSET_TYPE_DE,
+	AMDGPU_MUX_OFFSET_TYPE_CE,
+};
+
 struct amdgpu_ring_mux {
 	struct amdgpu_ring      *real_ring;
 
@@ -72,12 +78,18 @@ struct amdgpu_ring_mux {
  * @sync_seq: the fence seqno related with the saved IB.
  * @start:- start location on the software ring.
  * @end:- end location on the software ring.
+ * @control_offset:- the PRE_RESUME bit position used for resubmission.
+ * @de_offset:- the anchor in write_data for de meta of resubmission.
+ * @ce_offset:- the anchor in write_data for ce meta of resubmission.
  */
 struct amdgpu_mux_chunk {
 	struct list_head        entry;
 	uint32_t                sync_seq;
 	u64                     start;
 	u64                     end;
+	u64                     cntl_offset;
+	u64                     de_offset;
+	u64                     ce_offset;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
@@ -89,6 +101,8 @@ u64 amdgpu_ring_mux_get_wptr(struct amdg
 u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+				    u64 offset, enum amdgpu_ring_mux_offset_type type);
 bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);
 
 u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
@@ -97,6 +111,7 @@ void amdgpu_sw_ring_set_wptr_gfx(struct
 void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mux_offset_type type);
 const char *amdgpu_sw_ring_name(int idx);
 unsigned int amdgpu_sw_ring_priority(int idx);
 


