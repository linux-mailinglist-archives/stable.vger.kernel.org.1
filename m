Return-Path: <stable+bounces-207362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F46D09C5B
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B9D73077C14
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE335B12B;
	Fri,  9 Jan 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dcrRsj23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990735B134;
	Fri,  9 Jan 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961840; cv=none; b=EFzKQcKalrVzDQwM+16mC0j7LZfHSlwASyjFOvTojqmXz4Uv3/7kIkMA4OxtEV/DL5XDSEBxmOgR09FDcOugj8konsxFDqFWcX6v+zN96KfBJ9M57rRxQH1ssvpbDOP16wzFJy5wMrigD6CWuEfytRfDL2fnQPVY7btyQPogMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961840; c=relaxed/simple;
	bh=Tr4K6GFOH+hd7KFgYxmXWtl712CSf6ySJBxEsOpwD1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNdWfm4H/e7IW3XZMK2ZSXYj/SuB1ybdCWuk7f8/dz0CjtjwH7JawvJKQaLLYQE/VI/7X6FpufUFu60GFLElaPsKNvgNKMjfoZe+9s5K8bR1o0BDBTwbFCZZjDtKrfQjJUQ6I9pnDOboVetwtYaEHa1CbkKqIlVUXlmaLYxZvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dcrRsj23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3927C19421;
	Fri,  9 Jan 2026 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961840;
	bh=Tr4K6GFOH+hd7KFgYxmXWtl712CSf6ySJBxEsOpwD1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcrRsj2335Jqda8PZnvFGY/uMJQp40Cl0ahGD3gMae1Gi1IzuAmJ6A8cIAIUiijtE
	 gLUwf555TEtBJBOZGpX6OXWS2gVp5zixuFlgRDl6s82evmme8ZT+T5xEGWQsVOpCpW
	 ctPQx9tqEtNrTPqMhdzMxpm5IrEy/KGVSnkYjTJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 154/634] RDMA/irdma: Fix data race in irdma_free_pble
Date: Fri,  9 Jan 2026 12:37:12 +0100
Message-ID: <20260109112123.247000556@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

[ Upstream commit 81f44409fb4f027d1e6d54edbeba5156ad94b214 ]

Protects pble_rsrc counters with mutex to prevent data race.
Fixes the following data race in irdma_free_pble reported by KCSAN:

BUG: KCSAN: data-race in irdma_free_pble [irdma] / irdma_free_pble [irdma]

write to 0xffff91430baa0078 of 8 bytes by task 16956 on cpu 5:
 irdma_free_pble+0x3b/0xb0 [irdma]
 irdma_dereg_mr+0x108/0x110 [irdma]
 ib_dereg_mr_user+0x74/0x160 [ib_core]
 uverbs_free_mr+0x26/0x30 [ib_uverbs]
 destroy_hw_idr_uobject+0x4a/0x90 [ib_uverbs]
 uverbs_destroy_uobject+0x7b/0x330 [ib_uverbs]
 uobj_destroy+0x61/0xb0 [ib_uverbs]
 ib_uverbs_run_method+0x1f2/0x380 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
 ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
 __x64_sys_ioctl+0xc9/0x100
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

read to 0xffff91430baa0078 of 8 bytes by task 16953 on cpu 2:
 irdma_free_pble+0x23/0xb0 [irdma]
 irdma_dereg_mr+0x108/0x110 [irdma]
 ib_dereg_mr_user+0x74/0x160 [ib_core]
 uverbs_free_mr+0x26/0x30 [ib_uverbs]
 destroy_hw_idr_uobject+0x4a/0x90 [ib_uverbs]
 uverbs_destroy_uobject+0x7b/0x330 [ib_uverbs]
 uobj_destroy+0x61/0xb0 [ib_uverbs]
 ib_uverbs_run_method+0x1f2/0x380 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
 ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
 __x64_sys_ioctl+0xc9/0x100
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

value changed: 0x0000000000005a62 -> 0x0000000000005a68

Fixes: e8c4dbc2fcac ("RDMA/irdma: Add PBLE resource manager")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Link: https://patch.msgid.link/20251125025350.180-3-tatyana.e.nikolova@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/pble.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index 8dd9e44ed2a4c..d69ebab5c2111 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -498,12 +498,14 @@ int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 void irdma_free_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		     struct irdma_pble_alloc *palloc)
 {
-	pble_rsrc->freedpbles += palloc->total_cnt;
-
 	if (palloc->level == PBLE_LEVEL_2)
 		free_lvl2(pble_rsrc, palloc);
 	else
 		irdma_prm_return_pbles(&pble_rsrc->pinfo,
 				       &palloc->level1.chunkinfo);
+
+	mutex_lock(&pble_rsrc->pble_mutex_lock);
+	pble_rsrc->freedpbles += palloc->total_cnt;
 	pble_rsrc->stats_alloc_freed++;
+	mutex_unlock(&pble_rsrc->pble_mutex_lock);
 }
-- 
2.51.0




