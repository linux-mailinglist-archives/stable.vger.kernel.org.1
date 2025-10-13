Return-Path: <stable+bounces-185435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4ABD4E9D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269C43E5557
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EF315D35;
	Mon, 13 Oct 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+esT7Mr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50B27055F;
	Mon, 13 Oct 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370286; cv=none; b=jk4gGRiVdrU0u7iyRl7jJZdwygCZe76mDTLjstvkmCVxuurHsgwkhIHIJdJ/qdAMyQgmTLGIlQoFhoiA5ItyUjYVXPkAe1NiqHf9ujdPT1byuYu8kWAX+8I7jzBTN5fhHWr9GduWuF0nG7jcToSfVk0sXd/Ve+DJNd8DOKu2iCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370286; c=relaxed/simple;
	bh=IzSLF7yNsi1ApJqcysZgZvXKAZV8EosL03eOeitA1aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXyR0rJiaV9scwJDvl3USPUbuF2q+il0Y/sMfbFUUNo9utJX8y2BdAUfIoNKZ8r+JTuc+JcfP4OhWG245t/kdAAckrae9QfWoEI1IOTpDQAYBmfVhKaNqQsTdUFQy0R3xMDMgEp404NikeSjRvD8cU3JD5RQCF3IMoFXGFAIGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+esT7Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D411C4CEE7;
	Mon, 13 Oct 2025 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370285;
	bh=IzSLF7yNsi1ApJqcysZgZvXKAZV8EosL03eOeitA1aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+esT7MrK4aSXdaVMu5hxMKZXA++whL7/LvsYyuw3wgS20oTzgs02DNkVDdA2tAXH
	 xij3mwiqZDz3AcE2l/1T+h4A0OF8GgaAJ912UBcdayORPHqOVfrHDyWruittln50jQ
	 JjapdZw5dNSyt9l8OyQPaRSxGqDk3A5n5YCyCoZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Ling Xu <quic_lxu5@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6.17 543/563] misc: fastrpc: Save actual DMA size in fastrpc_map structure
Date: Mon, 13 Oct 2025 16:46:44 +0200
Message-ID: <20251013144430.979602493@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ling Xu <quic_lxu5@quicinc.com>

commit 8b5b456222fd604079b5cf2af1f25ad690f54a25 upstream.

For user passed fd buffer, map is created using DMA calls. The
map related information is stored in fastrpc_map structure. The
actual DMA size is not stored in the structure. Store the actual
size of buffer and check it against the user passed size.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://lore.kernel.org/r/20250912131236.303102-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -323,11 +323,11 @@ static void fastrpc_free_map(struct kref
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
-			err = qcom_scm_assign_mem(map->phys, map->size,
+			err = qcom_scm_assign_mem(map->phys, map->len,
 				&src_perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-						map->phys, map->size, err);
+						map->phys, map->len, err);
 				return;
 			}
 		}
@@ -758,7 +758,8 @@ static int fastrpc_map_create(struct fas
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
 	struct sg_table *table;
-	int err = 0;
+	struct scatterlist *sgl = NULL;
+	int err = 0, sgl_index = 0;
 
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
@@ -798,7 +799,15 @@ static int fastrpc_map_create(struct fas
 		map->phys = sg_dma_address(map->table->sgl);
 		map->phys += ((u64)fl->sctx->sid << 32);
 	}
-	map->size = len;
+	for_each_sg(map->table->sgl, sgl, map->table->nents,
+		sgl_index)
+		map->size += sg_dma_len(sgl);
+	if (len > map->size) {
+		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
+				len, map->size);
+		err = -EINVAL;
+		goto map_err;
+	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
 
@@ -815,10 +824,10 @@ static int fastrpc_map_create(struct fas
 		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
 		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
+		err = qcom_scm_assign_mem(map->phys, (u64)map->len, &src_perms, dst_perms, 2);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
-					map->phys, map->size, err);
+					map->phys, map->len, err);
 			goto map_err;
 		}
 	}
@@ -2046,7 +2055,7 @@ static int fastrpc_req_mem_map(struct fa
 	args[0].length = sizeof(req_msg);
 
 	pages.addr = map->phys;
-	pages.size = map->size;
+	pages.size = map->len;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
 	args[1].length = sizeof(pages);
@@ -2061,7 +2070,7 @@ static int fastrpc_req_mem_map(struct fa
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
-			req.fd, req.vaddrin, map->size);
+			req.fd, req.vaddrin, map->len);
 		goto err_invoke;
 	}
 
@@ -2074,7 +2083,7 @@ static int fastrpc_req_mem_map(struct fa
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		/* unmap the memory and release the buffer */
 		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
-		req_unmap.length = map->size;
+		req_unmap.length = map->len;
 		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
 		return -EFAULT;
 	}



