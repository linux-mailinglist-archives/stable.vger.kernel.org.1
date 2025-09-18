Return-Path: <stable+bounces-178743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EEB47FE2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A871A200960
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87998269CE6;
	Sun,  7 Sep 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKZTg+30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441294315A;
	Sun,  7 Sep 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277816; cv=none; b=JjUf3VBQZkj7SoA/YAtJlHohQsu6CaKSsu90MP8AsZ2ZFKXN2XfeZ0Tm7jm6/8OZiiUQMzdkRP1PVUM1z4NqjMUb5mcsUYUVpj9A1oL6QDs9KIVn0n4TrFo70nJ3kboya53ZTS0p+fNDbtqGvkQCyjDjt6ZCKvLaOauv7SBwws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277816; c=relaxed/simple;
	bh=wJKAjU+7JDxFNuBLvvun6Us0at0ereJKksTWUiFe+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxEBObsN+8wADm32FdziX8VRwLXQkmzqnByxAgelFy6h2Qh/YVZIe5oxNNNKvuloWOsMCnnF2BXWA0lDSbju5i7eQJQA9mODWP+oLdOWA8TJhcIXCtiaebV1NwLGF5qGkphQTI6wmwOdDtTiuZlF/4mYHggDDE9MBEsxbDAgVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKZTg+30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B31C4CEF0;
	Sun,  7 Sep 2025 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277816;
	bh=wJKAjU+7JDxFNuBLvvun6Us0at0ereJKksTWUiFe+X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wKZTg+30eYRiH6SJzdGxF9HU+Hrhj2pZ52wOUyLhT91JAs/Jbmhs6eCfLN4UIaUMs
	 2p0y8uLNFEkqADitZuGnGkR/a0ninbzTL8arDOgcpAWhKx9YszPtIQceQB+Vn7h3be
	 8dT53GX+o5cVEC5Sdzk5RwC5RRNpVl25tyVdVXjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.16 133/183] nouveau: Membar before between semaphore writes and the interrupt
Date: Sun,  7 Sep 2025 21:59:20 +0200
Message-ID: <20250907195618.954931545@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Faith Ekstrand <faith.ekstrand@collabora.com>

commit 2cb66ae6040fd3cb058c3391b180f378fc0e3e2f upstream.

This ensures that the memory write and the interrupt are properly
ordered and we won't wake up the kernel before the semaphore write has
hit memory.

Fixes: b1ca384772b6 ("drm/nouveau/gv100-: switch to volta semaphore methods")
Cc: stable@vger.kernel.org
Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://lore.kernel.org/r/20250829021633.1674524-2-airlied@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/gv100_fence.c         |  7 +-
 .../drm/nouveau/include/nvhw/class/clc36f.h   | 85 +++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/gv100_fence.c b/drivers/gpu/drm/nouveau/gv100_fence.c
index cccdeca72002..317e516c4ec7 100644
--- a/drivers/gpu/drm/nouveau/gv100_fence.c
+++ b/drivers/gpu/drm/nouveau/gv100_fence.c
@@ -18,7 +18,7 @@ gv100_fence_emit32(struct nouveau_channel *chan, u64 virtual, u32 sequence)
 	struct nvif_push *push = &chan->chan.push;
 	int ret;
 
-	ret = PUSH_WAIT(push, 8);
+	ret = PUSH_WAIT(push, 13);
 	if (ret)
 		return ret;
 
@@ -32,6 +32,11 @@ gv100_fence_emit32(struct nouveau_channel *chan, u64 virtual, u32 sequence)
 		  NVDEF(NVC36F, SEM_EXECUTE, PAYLOAD_SIZE, 32BIT) |
 		  NVDEF(NVC36F, SEM_EXECUTE, RELEASE_TIMESTAMP, DIS));
 
+	PUSH_MTHD(push, NVC36F, MEM_OP_A, 0,
+				MEM_OP_B, 0,
+				MEM_OP_C, NVDEF(NVC36F, MEM_OP_C, MEMBAR_TYPE, SYS_MEMBAR),
+				MEM_OP_D, NVDEF(NVC36F, MEM_OP_D, OPERATION, MEMBAR));
+
 	PUSH_MTHD(push, NVC36F, NON_STALL_INTERRUPT, 0);
 
 	PUSH_KICK(push);
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
index 8735dda4c8a7..338f74b9f501 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
@@ -7,6 +7,91 @@
 
 #define NVC36F_NON_STALL_INTERRUPT                                 (0x00000020)
 #define NVC36F_NON_STALL_INTERRUPT_HANDLE                                 31:0
+// NOTE - MEM_OP_A and MEM_OP_B have been replaced in gp100 with methods for
+// specifying the page address for a targeted TLB invalidate and the uTLB for
+// a targeted REPLAY_CANCEL for UVM.
+// The previous MEM_OP_A/B functionality is in MEM_OP_C/D, with slightly
+// rearranged fields.
+#define NVC36F_MEM_OP_A                                            (0x00000028)
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_TARGET_CLIENT_UNIT_ID        5:0  // only relevant for REPLAY_CANCEL_TARGETED
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_INVALIDATION_SIZE                   5:0  // Used to specify size of invalidate, used for invalidates which are not of the REPLAY_CANCEL_TARGETED type
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_TARGET_GPC_ID               10:6  // only relevant for REPLAY_CANCEL_TARGETED
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_MMU_ENGINE_ID                6:0  // only relevant for REPLAY_CANCEL_VA_GLOBAL
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR                         11:11
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR_EN                 0x00000001
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR_DIS                0x00000000
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_TARGET_ADDR_LO                    31:12
+#define NVC36F_MEM_OP_B                                            (0x0000002c)
+#define NVC36F_MEM_OP_B_TLB_INVALIDATE_TARGET_ADDR_HI                     31:0
+#define NVC36F_MEM_OP_C                                            (0x00000030)
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE                                        2:0
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE_SYS_MEMBAR                      0x00000000
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE_MEMBAR                          0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB                                 0:0
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ONE                      0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ALL                      0x00000001  // Probably nonsensical for MMU_TLB_INVALIDATE_TARGETED
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC                                 1:1
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC_ENABLE                   0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC_DISABLE                  0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY                              4:2  // only relevant if GPC ENABLE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_NONE                  0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_START                 0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_START_ACK_ALL         0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_TARGETED       0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_GLOBAL         0x00000004
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_VA_GLOBAL      0x00000005
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE                            6:5  // only relevant if GPC ENABLE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_NONE                0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_GLOBALLY            0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_INTRANODE           0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE                         9:7 //only relevant for REPLAY_CANCEL_VA_GLOBAL
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_READ                 0
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_WRITE                1
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_STRONG        2
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_RSVRVD               3
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_WEAK          4
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_ALL           5
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_WRITE_AND_ATOMIC     6
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ALL                  7
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL                    9:7  // Invalidate affects this level and all below
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_ALL         0x00000000  // Invalidate tlb caches at all levels of the page table
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_PTE_ONLY    0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE0  0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE1  0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE2  0x00000004
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE3  0x00000005
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE4  0x00000006
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE5  0x00000007
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE                          11:10  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_VID_MEM             0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_SYS_MEM_COHERENT    0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_SYS_MEM_NONCOHERENT 0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ADDR_LO                       31:12  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_C_ACCESS_COUNTER_CLR_TARGETED_NOTIFY_TAG            19:0
+// MEM_OP_D MUST be preceded by MEM_OPs A-C.
+#define NVC36F_MEM_OP_D                                            (0x00000034)
+#define NVC36F_MEM_OP_D_TLB_INVALIDATE_PDB_ADDR_HI                        26:0  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_D_OPERATION                                        31:27
+#define NVC36F_MEM_OP_D_OPERATION_MEMBAR                            0x00000005
+#define NVC36F_MEM_OP_D_OPERATION_MMU_TLB_INVALIDATE                0x00000009
+#define NVC36F_MEM_OP_D_OPERATION_MMU_TLB_INVALIDATE_TARGETED       0x0000000a
+#define NVC36F_MEM_OP_D_OPERATION_L2_PEERMEM_INVALIDATE             0x0000000d
+#define NVC36F_MEM_OP_D_OPERATION_L2_SYSMEM_INVALIDATE              0x0000000e
+// CLEAN_LINES is an alias for Tegra/GPU IP usage
+#define NVC36F_MEM_OP_B_OPERATION_L2_INVALIDATE_CLEAN_LINES         0x0000000e
+#define NVC36F_MEM_OP_D_OPERATION_L2_CLEAN_COMPTAGS                 0x0000000f
+#define NVC36F_MEM_OP_D_OPERATION_L2_FLUSH_DIRTY                    0x00000010
+#define NVC36F_MEM_OP_D_OPERATION_L2_WAIT_FOR_SYS_PENDING_READS     0x00000015
+#define NVC36F_MEM_OP_D_OPERATION_ACCESS_COUNTER_CLR                0x00000016
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE                            1:0
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_MIMC                0x00000000
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_MOMC                0x00000001
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_ALL                 0x00000002
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_TARGETED            0x00000003
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE                   2:2
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE_MIMC       0x00000000
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE_MOMC       0x00000001
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_BANK                   6:3
 #define NVC36F_SEM_ADDR_LO                                         (0x0000005c)
 #define NVC36F_SEM_ADDR_LO_OFFSET                                         31:2
 #define NVC36F_SEM_ADDR_HI                                         (0x00000060)
-- 
2.51.0




