Return-Path: <stable+bounces-191459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3FC14896
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CE71A66B43
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB532B98D;
	Tue, 28 Oct 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MVSySQgb"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909532ABC3;
	Tue, 28 Oct 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653371; cv=none; b=qyhdbvnmI46mQ1hGAzCZALTk3VLLnRdciaOXODL/LYek4EreQiIZn84kwcbPEMDSxzq/+QZDnAnoTJbsww9Htzb33vEWm3z3IqAB3bbcWegCDcGzzy2PhnKvwNs4dKUwgxDrk57NIcqn86ePv7QRvtCy9DH8w5231I3CCis4amQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653371; c=relaxed/simple;
	bh=sq/+NYsU4r7RvYZ2ya2yoklYEVwQfJyNA5iHGuBj/+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxTpb1kyOQp9+dGjXiJh3tfp4iWqFsrYo6E84Zw6QZKkS6vw3mPGTLfLYP5OZUszjhJ8VVsdp5rnDiSjRCvaKTbky2I5Dv7hxv5LqmfiJsF9epMOIf6Ze7h5xj1a0WVxLO1D+kLh3y+uveMkuEwRg4/87woP5jJ9wjV00Vtv7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MVSySQgb; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HzJIrWRLCn8I6nS80yYg5Y6x7gHb7y3xFpXXzspSdII=;
	b=MVSySQgbkTTGGWtZC9JwWFGka1Me7bJhgkeJ7ED6kcIKEnWvY2qJnxHM8U9hxdoHEVvZZc3S9
	DJ+UWSuWZnpqtTjIRvSde+9otV6MHGFJP5I4LGUdabQezVfwO0tdIWJAFwzJgPBElDhyE4nxcnU
	bgqzHnwkPw/XlM/Uhp0f7ss=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cwpzg4SS0zcZyk;
	Tue, 28 Oct 2025 20:07:59 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id D340918048B;
	Tue, 28 Oct 2025 20:09:21 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 20:09:21 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>, <stable@vger.kernel.org>,
	Barry Song <baohua@kernel.org>
Subject: [PATCH v5 1/2] dma-mapping: benchmark: Restore padding to ensure uABI remained consistent
Date: Tue, 28 Oct 2025 20:08:59 +0800
Message-ID: <20251028120900.2265511-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251028120900.2265511-1-xiaqinxin@huawei.com>
References: <20251028120900.2265511-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index 62674c83bde4..48e2ff95332f 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -27,5 +27,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76]; /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
-- 
2.33.0


