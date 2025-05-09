Return-Path: <stable+bounces-142959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBEAB07D5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 04:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD71BC158E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95924466D;
	Fri,  9 May 2025 02:18:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114C242D8C;
	Fri,  9 May 2025 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757097; cv=none; b=VX3l0+Q0yK1dO2VP0synjczyIp8FRcaxbOrfss8+fYCBVa1oGjQ+owoKWQw+LQ5z0s7/qTYYWuyB09DElPTTMJgwRDvl2pwDiRQXIA8dcJynYKrU0I34Ij3j99RRmaByZzNcIkeriiuUXsDaQfQOkyWhG2KaLpD+ML3DHRw4oGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757097; c=relaxed/simple;
	bh=tytqPqeiD3YDw8o6ZV6Piy/NIVtbcyv2D9V7UPXWtAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riMhz/8AJw/TYp+w2oGBtrCJlcDjV8xVecfwt2MqR6uVX5oXC5e60k1959cVP04vknCI48IDGw9MlwmWH0eDIh0CTxi0+5KW8q2aIXDssGnSb+kzmYiVvtinoRoZL64PoxknAuc7ZI71ZlwCAnHtttGf84pRASnJhnXnjMkPWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZtscR6wMFz2CdfQ;
	Fri,  9 May 2025 09:59:03 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 53A121A0188;
	Fri,  9 May 2025 10:02:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 May 2025 10:02:39 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 0/4]{topost} dma-mapping: benchmark: Add support for dma_map_sg
Date: Fri, 9 May 2025 10:02:34 +0800
Message-ID: <20250509020238.3378396-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Modify the framework to adapt to more map modes, add benchmark
support for dma_map_sg, and add support sg map mode in ioctl.

The result:
[root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SG_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.4 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.3
[root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SINGLE_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.0 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.5

---
Changes since V2:
- Address the comments from Barry and ALOK, some commit information and function
  input parameter names are modified to make them more accurate.
- Link: https://lore.kernel.org/all/20250506030100.394376-1-xiaqinxin@huawei.com/

Changes since V1:
- Address the comments from Barry, added some comments and changed the unmap type to void.
- Link: https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/

Qinxin Xia (4):
  dma-mapping: benchmark: Add padding to ensure uABI remained consistent
  dma-mapping: benchmark: modify the framework to adapt to more map modes
  dma-mapping: benchmark: add support for dma_map_sg
  selftests/dma: Add dma_map_sg support

 include/linux/map_benchmark.h                 |  46 +++-
 kernel/dma/map_benchmark.c                    | 225 ++++++++++++++++--
 .../testing/selftests/dma/dma_map_benchmark.c |  16 +-
 3 files changed, 252 insertions(+), 35 deletions(-)

--
2.33.0


