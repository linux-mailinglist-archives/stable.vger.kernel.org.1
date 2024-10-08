Return-Path: <stable+bounces-82059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44280994AD8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5C1C24DC6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D51DE886;
	Tue,  8 Oct 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0mYiDj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11181D27B3;
	Tue,  8 Oct 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391030; cv=none; b=rocz83McDo3OUT/oxJMcrQjcahMO6sNKspXA03CprWHuuOYkdo3CicIriDlbrx5L46mqk/TMwOZNDpxys6zPUHlnktxLHSwk2jDW99NxRAIgdl8a4/Wvu9QVckTx046W/JKOv3JI3Hm+octFr4NMHILU8qFo5qdoWkl39cputhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391030; c=relaxed/simple;
	bh=ukqLDZ0952gi3JP/Foih9kzNg1cDPJE6qhTu/KQ3Mog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDYqUFpvICYBCpDZ+qld8Nmet1kZa64LPTKx2PEZTX+dPsFiRnVAmOQVoFDiPLUCail+2LYG9Ta8yB7U0HWHfnRlfI6JOSe5hdxLkbzlAQFpKID635k32iwKwVE56Hg9xy3ybiD009w9aOnlk1Ch8o7xW2JZKQHHHXvgFdgx5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0mYiDj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACB6C4CEC7;
	Tue,  8 Oct 2024 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391030;
	bh=ukqLDZ0952gi3JP/Foih9kzNg1cDPJE6qhTu/KQ3Mog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0mYiDj/2vx11KrNr/tUkMca0VETemqNV1mGxJ8gyDUwsN0ulDDrw73Qzjne2P8Qm
	 1McByvLgDTQf3Hz7SmNC2QS9KZKKv/rf/nbWYsdM3UYL6DMdy/3CZdaRqR248vnNBF
	 CuiFtkuo9aGZAjQOVlJf+TyeukPdUuwmXH7ZuqCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 461/482] net: mana: Add support for page sizes other than 4KB on ARM64
Date: Tue,  8 Oct 2024 14:08:44 +0200
Message-ID: <20241008115706.655212127@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 382d1741b5b2feffef7942dd074206372afe1a96 ]

As defined by the MANA Hardware spec, the queue size for DMA is 4KB
minimal, and power of 2. And, the HWC queue size has to be exactly
4KB.

To support page sizes other than 4KB on ARM64, define the minimal
queue size as a macro separately from the PAGE_SIZE, which we always
assumed it to be 4KB before supporting ARM64.

Also, add MANA specific macros and update code related to size
alignment, DMA region calculations, etc.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1718655446-6576-1-git-send-email-haiyangz@microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9e517a8e9d9a ("RDMA/mana_ib: use the correct page table index based on hardware page size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/Kconfig            |  2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c   | 10 +++++-----
 drivers/net/ethernet/microsoft/mana/hw_channel.c  | 14 +++++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c     |  8 ++++----
 drivers/net/ethernet/microsoft/mana/shm_channel.c | 13 +++++++------
 include/net/mana/gdma.h                           | 10 +++++++++-
 include/net/mana/mana.h                           |  3 ++-
 7 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 286f0d5697a16..901fbffbf718e 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
 config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
 	depends on PCI_MSI
-	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
+	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb9..e1d70d21e207f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, unsigned int length,
 	dma_addr_t dma_handle;
 	void *buf;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
 	gmi->dev = gc->dev;
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_MANA);
 static int mana_gd_create_dma_region(struct gdma_dev *gd,
 				     struct gdma_mem_info *gmi)
 {
-	unsigned int num_page = gmi->length / PAGE_SIZE;
+	unsigned int num_page = gmi->length / MANA_PAGE_SIZE;
 	struct gdma_create_dma_region_req *req = NULL;
 	struct gdma_create_dma_region_resp resp = {};
 	struct gdma_context *gc = gd->gdma_context;
@@ -727,10 +727,10 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	int err;
 	int i;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
-	if (offset_in_page(gmi->virt_addr) != 0)
+	if (!MANA_PAGE_ALIGNED(gmi->virt_addr))
 		return -EINVAL;
 
 	hwc = gc->hwc.driver_data;
@@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	req->page_addr_list_len = num_page;
 
 	for (i = 0; i < num_page; i++)
-		req->page_addr_list[i] = gmi->dma_handle +  i * PAGE_SIZE;
+		req->page_addr_list[i] = gmi->dma_handle +  i * MANA_PAGE_SIZE;
 
 	err = mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp);
 	if (err)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 0a868679d342e..a00f915c51881 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -368,12 +368,12 @@ static int mana_hwc_create_cq(struct hw_channel_context *hwc, u16 q_depth,
 	int err;
 
 	eq_size = roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
-	if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		eq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (eq_size < MANA_MIN_QSIZE)
+		eq_size = MANA_MIN_QSIZE;
 
 	cq_size = roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
-	if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		cq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (cq_size < MANA_MIN_QSIZE)
+		cq_size = MANA_MIN_QSIZE;
 
 	hwc_cq = kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
 	if (!hwc_cq)
@@ -435,7 +435,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_context *hwc, u16 q_depth,
 
 	dma_buf->num_reqs = q_depth;
 
-	buf_size = PAGE_ALIGN(q_depth * max_msg_size);
+	buf_size = MANA_PAGE_ALIGN(q_depth * max_msg_size);
 
 	gmi = &dma_buf->mem_info;
 	err = mana_gd_alloc_memory(gc, buf_size, gmi);
@@ -503,8 +503,8 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	else
 		queue_size = roundup_pow_of_two(GDMA_MAX_SQE_SIZE * q_depth);
 
-	if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		queue_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (queue_size < MANA_MIN_QSIZE)
+		queue_size = MANA_MIN_QSIZE;
 
 	hwc_wq = kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
 	if (!hwc_wq)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index bb77327bfa815..a637556dcfae8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1901,10 +1901,10 @@ static int mana_create_txq(struct mana_port_context *apc,
 	 *  to prevent overflow.
 	 */
 	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
-	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
+	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
 
 	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
-	cq_size = PAGE_ALIGN(cq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	gc = gd->gdma_context;
 
@@ -2203,8 +2203,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	if (err)
 		goto out;
 
-	rq_size = PAGE_ALIGN(rq_size);
-	cq_size = PAGE_ALIGN(cq_size);
+	rq_size = MANA_PAGE_ALIGN(rq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c b/drivers/net/ethernet/microsoft/mana/shm_channel.c
index 5553af9c8085a..0f1679ebad96b 100644
--- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
@@ -6,6 +6,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
+#include <net/mana/gdma.h>
 #include <net/mana/shm_channel.h>
 
 #define PAGE_FRAME_L48_WIDTH_BYTES 6
@@ -155,8 +156,8 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 		return err;
 	}
 
-	if (!PAGE_ALIGNED(eq_addr) || !PAGE_ALIGNED(cq_addr) ||
-	    !PAGE_ALIGNED(rq_addr) || !PAGE_ALIGNED(sq_addr))
+	if (!MANA_PAGE_ALIGNED(eq_addr) || !MANA_PAGE_ALIGNED(cq_addr) ||
+	    !MANA_PAGE_ALIGNED(rq_addr) || !MANA_PAGE_ALIGNED(sq_addr))
 		return -EINVAL;
 
 	if ((eq_msix_index & VECTOR_MASK) != eq_msix_index)
@@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* EQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(eq_addr);
+	frame_addr = MANA_PFN(eq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* CQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(cq_addr);
+	frame_addr = MANA_PFN(cq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* RQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(rq_addr);
+	frame_addr = MANA_PFN(rq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* SQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(sq_addr);
+	frame_addr = MANA_PFN(sq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d1..35507588a14d5 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -224,7 +224,15 @@ struct gdma_dev {
 	struct auxiliary_device *adev;
 };
 
-#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
+/* MANA_PAGE_SIZE is the DMA unit */
+#define MANA_PAGE_SHIFT 12
+#define MANA_PAGE_SIZE BIT(MANA_PAGE_SHIFT)
+#define MANA_PAGE_ALIGN(x) ALIGN((x), MANA_PAGE_SIZE)
+#define MANA_PAGE_ALIGNED(addr) IS_ALIGNED((unsigned long)(addr), MANA_PAGE_SIZE)
+#define MANA_PFN(a) ((a) >> MANA_PAGE_SHIFT)
+
+/* Required by HW */
+#define MANA_MIN_QSIZE MANA_PAGE_SIZE
 
 #define GDMA_CQE_SIZE 64
 #define GDMA_EQE_SIZE 16
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 5927bd9d46bef..f384d3aaac741 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -42,7 +42,8 @@ enum TRI_STATE {
 
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
 
-#define EQ_SIZE (8 * PAGE_SIZE)
+#define EQ_SIZE (8 * MANA_PAGE_SIZE)
+
 #define LOG2_EQ_THROTTLE 3
 
 #define MAX_PORTS_IN_MANA_DEV 256
-- 
2.43.0




