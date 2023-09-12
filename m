Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443479BA73
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjIKVag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbjIKOEX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E68E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8317C433C7;
        Mon, 11 Sep 2023 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441058;
        bh=ye+xwRDKggz7Foz+AO/LW7gsSg8xFzSlmcCbejNLZh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSCPHGgBfGkYMhh0Xjt3ooVwTlNeBav2/cEsoLGCurOLs5a5+QU8eEPhmlSgO6J43
         CjpoPphUvszqt/e/ZzV+KnG8fnc40EGUbI4J5tvERFoO/6XFk89MXiIpMTdUzehxcl
         isve6DpLypZXpochpFpMryHB5jQehzwte4EUmeuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 280/739] drm/amdgpu: Use seq_puts() instead of seq_printf()
Date:   Mon, 11 Sep 2023 15:41:19 +0200
Message-ID: <20230911134658.944695081@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit fc8e55f378cf11f3abe25ec5cd67b6fc5e915a96 ]

For a constant format without additional arguments, use seq_puts()
instead of seq_printf(). Also, it fixes the following warning.

WARNING: Prefer seq_puts to seq_printf

And other style fixes:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Block comments should align the * on each line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ebeddc9a37e9b..6aa3b1d845abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -62,7 +62,7 @@
  * Returns 0 on success, error on failure.
  */
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		  unsigned size, enum amdgpu_ib_pool_type pool_type,
+		  unsigned int size, enum amdgpu_ib_pool_type pool_type,
 		  struct amdgpu_ib *ib)
 {
 	int r;
@@ -123,7 +123,7 @@ void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
  * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
  * to SI there was just a DE IB.
  */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
@@ -131,16 +131,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
 	bool need_ctx_switch;
-	unsigned patch_offset = ~0;
+	unsigned int patch_offset = ~0;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
-	unsigned fence_flags = 0;
+	unsigned int fence_flags = 0;
 	bool secure, init_shadow;
 	u64 shadow_va, csa_va, gds_va;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 
-	unsigned i;
+	unsigned int i;
 	int r = 0;
 	bool need_pipe_sync = false;
 
@@ -282,7 +282,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
 
 		if (ring->funcs->init_cond_exec) {
-			unsigned ce_offset = ~0;
+			unsigned int ce_offset = ~0;
 
 			ce_offset = amdgpu_ring_init_cond_exec(ring);
 			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
@@ -385,7 +385,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 {
 	long tmo_gfx, tmo_mm;
 	int r, ret = 0;
-	unsigned i;
+	unsigned int i;
 
 	tmo_mm = tmo_gfx = AMDGPU_IB_TEST_TIMEOUT;
 	if (amdgpu_sriov_vf(adev)) {
@@ -402,7 +402,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		/* for CP & SDMA engines since they are scheduled together so
 		 * need to make the timeout width enough to cover the time
 		 * cost waiting for it coming back under RUNTIME only
-		*/
+		 */
 		tmo_gfx = 8 * AMDGPU_IB_TEST_TIMEOUT;
 	} else if (adev->gmc.xgmi.hive_id) {
 		tmo_gfx = AMDGPU_IB_TEST_GFX_XGMI_TIMEOUT;
@@ -465,13 +465,13 @@ static int amdgpu_debugfs_sa_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = m->private;
 
-	seq_printf(m, "--------------------- DELAYED --------------------- \n");
+	seq_puts(m, "--------------------- DELAYED ---------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
 				     m);
-	seq_printf(m, "-------------------- IMMEDIATE -------------------- \n");
+	seq_puts(m, "-------------------- IMMEDIATE --------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_IMMEDIATE],
 				     m);
-	seq_printf(m, "--------------------- DIRECT ---------------------- \n");
+	seq_puts(m, "--------------------- DIRECT ----------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT], m);
 
 	return 0;
-- 
2.40.1



