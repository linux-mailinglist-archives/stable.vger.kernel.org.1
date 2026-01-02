Return-Path: <stable+bounces-204508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29ECEF50B
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5E2301D0D2
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35972C026E;
	Fri,  2 Jan 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k14/f5PB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CF26A0DB
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386268; cv=none; b=TXY92JNKDezS9MrHdcvNmup2fiewXD/W7DSmdt0kkNhZBRwhnhyFAtamQbzJvW6bwLfS0A3gxhRb6yS+6APXPB4j7x55yzsfvL1nf+VEXJN4MIZvrjLG9KsiAz8BLP9KzVXgSwBB66NhlwaqbLbG6zGoNNJd/U54CK8YUSQEbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386268; c=relaxed/simple;
	bh=dvnDyUvfpP8BkRQcBRbGXtHWiKsoaVWZXeAH8iUOoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLmPFhzJ6nt0QWOJt6R85jZDvdrGevFxKvleiDsZYTRKLOYsBobhgCC0H0YYfgYA3V3PnUzqB4r6REslT+aXlPigdre5F/90GVfkGO9hCAwKk1Hy4+vAGksEqtVY0wdHBqSRbJNkjT9CISqnn+tP0NNy1oerHL4zdV6eleSMzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k14/f5PB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602BuraY3043521;
	Fri, 2 Jan 2026 20:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=96MuQ
	M0WxjYiou8YGHHN6tFFL9xJHaZExH2NgrVKyT0=; b=k14/f5PB29kBi35NdvbWg
	NsAGJfSHZCOOuj7Q1FRfgf3bR8PPPSc+lYtVb3K3rc7hND7FwB0fQIx8+gSPf3Cj
	q9H0/FT+qtF0epahVzDdd9HuApPPoKkbaptr2u4TG1ebHNc58CZg0EdO+VBv5pXl
	gx5cJnr8aqVkI7Huu81HJf3ZE1+rlUfA37v4uN3WZZl7LfRVj7RKl5kTTPEcgFF/
	fTu3Cv5VB8bobLgPJ42x4zTVEXBBK7Tuq7S9/dRWT1eCkknpvDZQTeuJNyojHpYS
	QgtLn687kYgLvZDPoJfc5ayfKFv8sNMW6rwMO/ZJfoQ1rE5DFOTEd9XraN0xhaW9
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7b5nenh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602HNDf6023129;
	Fri, 2 Jan 2026 20:37:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4Z025726;
	Fri, 2 Jan 2026 20:37:41 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-4;
	Fri, 02 Jan 2026 20:37:41 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 3/7] drm/panthor: Flush shmem writes before mapping buffers CPU-uncached
Date: Fri,  2 Jan 2026 12:37:23 -0800
Message-ID: <20260102203727.1455662-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
References: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfX4kKPBDEBIOX0
 +davWpcnvopIMG4/L4hl5NNQKAs0ZgIgKdNUoB1R2BZQTOeN312kagv2hQXuzu3Scc8ECbOPHom
 +U1c4CK8/mzsH1mMwic2/nPfsNLLuAflWxm8xbcrGza5NN0TKS2n2AAyjsjDk3F0Kn6GPA3Vl7g
 CA+qC5YHJMql7ylvOzdQROgX4VtpMdchglE62seGAw5SbvrNdFwzBTxwTmXOC5B0aSFe5Lo4I5l
 K8WDg7NFUxBDgsd/R7XQGonoyEh+x4PhqnjnfpT6iJ8Q0LHUXvL6EzN3u0aTXEwhPdBG8ibkyz/
 lUtIUwuRvEFk4qlvJDLOVqeDvFhJ7tKJIsl+QdAySMeNh66dJQyXCTihJyYHcpAEuWqryBTuXnP
 EvqzWvc+CR/UKsKGd/je5xwsgsbowMgjV/zkBx8jiOxdkfE9aG/72uzkhieW6Mj4ibJKCc34EKa
 QcyOs19AUGTFGf4Pupw==
X-Proofpoint-GUID: jQGLm5lrd-YHdDpq4MYx8rzw4_uZMKRv
X-Authority-Analysis: v=2.4 cv=ccjfb3DM c=1 sm=1 tr=0 ts=69582c96 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=PU_BD7ytV0Cl6fRA0A0A:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: jQGLm5lrd-YHdDpq4MYx8rzw4_uZMKRv

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit 576c930e5e7dcb937648490611a83f1bf0171048 ]

The shmem layer zeroes out the new pages using cached mappings, and if
we don't CPU-flush we might leave dirty cachelines behind, leading to
potential data leaks and/or asynchronous buffer corruption when dirty
cachelines are evicted.

Fixes: 8a1cc07578bf ("drm/panthor: Add GEM logical block")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20251107171214.1186299-1-boris.brezillon@collabora.com
(cherry picked from commit 576c930e5e7dcb937648490611a83f1bf0171048)
[Harshit: Resolve conflicts due to missing commit: fe69a3918084
("drm/panthor: Fix UAF in panthor_gem_create_with_handle() debugfs
code") in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 0438b80a6434..09b318fb8e7c 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -214,6 +214,23 @@ panthor_gem_create_with_handle(struct drm_file *file,
 		bo->base.base.resv = bo->exclusive_vm_root_gem->resv;
 	}
 
+	/* If this is a write-combine mapping, we query the sgt to force a CPU
+	 * cache flush (dma_map_sgtable() is called when the sgt is created).
+	 * This ensures the zero-ing is visible to any uncached mapping created
+	 * by vmap/mmap.
+	 * FIXME: Ideally this should be done when pages are allocated, not at
+	 * BO creation time.
+	 */
+	if (shmem->map_wc) {
+		struct sg_table *sgt;
+
+		sgt = drm_gem_shmem_get_pages_sgt(shmem);
+		if (IS_ERR(sgt)) {
+			ret = PTR_ERR(sgt);
+			goto out_put_gem;
+		}
+	}
+
 	/*
 	 * Allocate an id of idr table where the obj is registered
 	 * and handle has the id what user can see.
@@ -222,6 +239,7 @@ panthor_gem_create_with_handle(struct drm_file *file,
 	if (!ret)
 		*size = bo->base.base.size;
 
+out_put_gem:
 	/* drop reference from allocate - handle holds it now. */
 	drm_gem_object_put(&shmem->base);
 
-- 
2.50.1


