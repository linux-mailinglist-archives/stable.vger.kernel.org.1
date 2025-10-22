Return-Path: <stable+bounces-188950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435EBFB38E
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E04EB2CF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842D30CDB6;
	Wed, 22 Oct 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bU4pdFOU"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C0314B8E
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126736; cv=none; b=MX8qlwWcjQnQWty8QC+JqW8WITH2T9JRrmc88f/SwdATH/S/4a2oksSMMmEiGcvFqNe9CQJZRvc+tWhS+vy02aKkqfcGlJCSpe8ata0Lb3smWpQdut3/kpCi2pb6jyRAESOeLlJCy6lcz7mhHCNLNLon9X+95FriLOsxRPUw5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126736; c=relaxed/simple;
	bh=LviThTNa7WFSySQCtkVWg9h/yH8uPysYxenL5Gkm01I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gG975+gb6Bu9UlGAo7lMagYK/9erD3Cd5FB8gg5LjpyYOgV+hiYGSoEQz/sx80RS9+obn8ungdvDvdvNDH6qSILLfLABPhaUsocQc2nQRExhn+I5QbgQCjx26mUol6P01Z8sE4u0s7Ox1PdFcx3wkOSCMPk+y9eH3L1YOxku9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bU4pdFOU; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OQVYvNdDJr8SSoGfFXqOa+UsVtn44YR9NeJ3kACd3JA=;
	b=bU4pdFOU0aQ6nMAcDmIwrZ4AsqBEw9EBXz//poVQF3RDVON0+oruAKCK3BN3SdYqNyADFRmAu
	PBTnv57uK77UmBniVYe4SIN1gREpuN5RiAVXmBlBbbSdBnIFjg05RlIhy3Ti1VqXYq5ozM1LN70
	l/Jbh+3ADMOXamXIMRtY4EM=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cs4FG1rTTzLlVq;
	Wed, 22 Oct 2025 17:51:46 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id D0CB7140155;
	Wed, 22 Oct 2025 17:52:10 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 17:52:10 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <wangzhou1@hisilicon.com>
CC: Qinxin Xia <xiaqinxin@huawei.com>, <stable@vger.kernel.org>, Barry Song
	<baohua@kernel.org>
Subject: [RESEND PATCH] dma-mapping: benchmark: Add padding to ensure uABI remained consistent
Date: Wed, 22 Oct 2025 17:52:08 +0800
Message-ID: <20251022095208.2301302-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)

The padding field in the structure was previously reserved to
maintain a stable interface for potential new fields, ensuring
compatibility with user-space shared data structures.
However,it was accidentally removed by tiantao in a prior commit,
which may lead to incompatibility between user space and the kernel.

This patch reinstates the padding to restore the original structure
layout and preserve compatibility.

Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
Cc: stable@vger.kernel.org
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..2ac2fe52f248 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -27,5 +27,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76];     /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
-- 
2.33.0


