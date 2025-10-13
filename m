Return-Path: <stable+bounces-184215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C9BD2D58
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1F4E67B3
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54351F63F9;
	Mon, 13 Oct 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLzwPd5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279819ABDE
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355946; cv=none; b=BuhRRY6MrM4hWNiyrytsG7KqDhDf6IGNVaGW1Uy4MB6TxLA/TsPrFgxC+m63EzfaaeZrUCqdfL5/oTSi8Ht9JCmyhrbRhEv003+fhNIjjgAGA/46DalmVfN8tcOXu/tjfV9ReJ+o1Qx+dH24VslCifz4Ug3ZYvBS1ZOQxn2bQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355946; c=relaxed/simple;
	bh=OFr8Yeh88emddnkg4iXV+zQBM4/HZRua3cT7GiX/Trw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lxuE6PtOZ5L7cff2nOtDwphbXuaCPBE/ZKAWN2j4LxbuxkFHnalYMlNY7MEy6Uv62mp6GIoxAW1g4FsOAt3Mex/HNjr2ZR+CSjNQcX1OXoJSo2a7jyVyNBABxz5hwOrL0aRzHUr81HThwitV742URlq5llly4DOvsC7Z+gGqqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLzwPd5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EDC4CEE7;
	Mon, 13 Oct 2025 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760355945;
	bh=OFr8Yeh88emddnkg4iXV+zQBM4/HZRua3cT7GiX/Trw=;
	h=Subject:To:Cc:From:Date:From;
	b=dLzwPd5bV+J9FMaFI/RxMDYRYUKrOuVZdHOwXDVZfTlDXKNYPsR/j73d+LVmY4Il9
	 0NFj33bEGgA9PcZmmoTTqWgK3G8dFMRedDpa3dDgS07Fuin2moWyHxzbjR0dn5Qw78
	 3tphN0ZIMjDzgaPwrpGaKLtjOKBnQyWOEKMTYoe4=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Save actual DMA size in fastrpc_map structure" failed to apply to 5.15-stable tree
To: quic_lxu5@quicinc.com,dmitry.baryshkov@linaro.org,dmitry.baryshkov@oss.qualcomm.com,ekansh.gupta@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:45:30 +0200
Message-ID: <2025101330-radio-nemesis-fbaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8b5b456222fd604079b5cf2af1f25ad690f54a25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101330-radio-nemesis-fbaf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b5b456222fd604079b5cf2af1f25ad690f54a25 Mon Sep 17 00:00:00 2001
From: Ling Xu <quic_lxu5@quicinc.com>
Date: Fri, 12 Sep 2025 14:12:33 +0100
Subject: [PATCH] misc: fastrpc: Save actual DMA size in fastrpc_map structure

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

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 53e88a1bc430..52571916acd4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -323,11 +323,11 @@ static void fastrpc_free_map(struct kref *ref)
 
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
@@ -758,7 +758,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
 	struct sg_table *table;
-	int err = 0;
+	struct scatterlist *sgl = NULL;
+	int err = 0, sgl_index = 0;
 
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
@@ -798,7 +799,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
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
 
@@ -815,10 +824,10 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
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
@@ -2046,7 +2055,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[0].length = sizeof(req_msg);
 
 	pages.addr = map->phys;
-	pages.size = map->size;
+	pages.size = map->len;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
 	args[1].length = sizeof(pages);
@@ -2061,7 +2070,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
-			req.fd, req.vaddrin, map->size);
+			req.fd, req.vaddrin, map->len);
 		goto err_invoke;
 	}
 
@@ -2074,7 +2083,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		/* unmap the memory and release the buffer */
 		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
-		req_unmap.length = map->size;
+		req_unmap.length = map->len;
 		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
 		return -EFAULT;
 	}


