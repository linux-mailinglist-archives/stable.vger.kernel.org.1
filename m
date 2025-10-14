Return-Path: <stable+bounces-185691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA4BDA411
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 746D934D047
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0123009D4;
	Tue, 14 Oct 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCJRv0ok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84F3009CC
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454750; cv=none; b=IXxNBEQyx/X7MuwnrAk32XrD/rseAmOHl11MWGOMvChSB6YvOlalDMzYHhtgUHsT9yscGcdu6YCqB7zDGBk5JlgNpLc2q3m5D+IsA/s2goHJTVGJJTl6P09aVVXk/5YdgaWL73XybhP3jCbMzK9rJzVo4zTavoXou05LSki6v4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454750; c=relaxed/simple;
	bh=5MHnFkE/CM4zGXmiFbCB7i4SLRasL7W5MN8/MgSH3/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxlNB31iw+xCuXCgpQ2bAiAHx7rSkodPAcImldz0rcbSZ0Pum1L2i6WXR6r1pcBx47ROJwwPS1s4LjNYYoHlZV5CAi626YxS6zeiVaeXG0YbzqFtNO8lfwXucVYpPlXZ23bom9nAtIsVFyqro8WTKVI7Jp8enDje3RbFCK0h8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCJRv0ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E95C113D0;
	Tue, 14 Oct 2025 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760454750;
	bh=5MHnFkE/CM4zGXmiFbCB7i4SLRasL7W5MN8/MgSH3/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCJRv0ok+bcmVs5+nKR54BtBr+Ja+P1FG4H+0sHMJL87aVTTCc82pjB68m5rQZYFF
	 hOK9edMYokMXiNGFDBY2RzSD+5EnUjFBtVL2NR4dnU104WwzMGWwtoqo5vPlL0J3bO
	 xBQlsKrz53ys+fvIcKS8G+ip15/QExazYNpLcHtxvjMRipuzFR5EYh6ksMzWIpApvx
	 RIjr8HWXAZuWvqyYS+4sJEH9hwfUy0igncuxI3yPdscZvCheuLhhvs3U6lgjo5oMOa
	 5KwuZN/ONPHSRpPMTMn/dEEt/H3Gc4r+aloWn+LwhUj39C6dN/cGtRt8MlDpS6QEd2
	 ohHLSq5kDcJlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ling Xu <quic_lxu5@quicinc.com>,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] misc: fastrpc: Save actual DMA size in fastrpc_map structure
Date: Tue, 14 Oct 2025 11:12:26 -0400
Message-ID: <20251014151226.111084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014151226.111084-1-sashal@kernel.org>
References: <2025101329-freestyle-unfair-5d44@gregkh>
 <20251014151226.111084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

[ Upstream commit 8b5b456222fd604079b5cf2af1f25ad690f54a25 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 83f0f516a230b..55386528da0de 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -322,11 +322,11 @@ static void fastrpc_free_map(struct kref *ref)
 
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
@@ -757,7 +757,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
 	struct sg_table *table;
-	int err = 0;
+	struct scatterlist *sgl = NULL;
+	int err = 0, sgl_index = 0;
 
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
@@ -797,7 +798,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
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
 
@@ -814,10 +823,10 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
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
@@ -2045,7 +2054,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[0].length = sizeof(req_msg);
 
 	pages.addr = map->phys;
-	pages.size = map->size;
+	pages.size = map->len;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
 	args[1].length = sizeof(pages);
@@ -2060,7 +2069,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
-			req.fd, req.vaddrin, map->size);
+			req.fd, req.vaddrin, map->len);
 		goto err_invoke;
 	}
 
@@ -2073,7 +2082,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		/* unmap the memory and release the buffer */
 		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
-		req_unmap.length = map->size;
+		req_unmap.length = map->len;
 		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
 		return -EFAULT;
 	}
-- 
2.51.0


