Return-Path: <stable+bounces-188954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A3BFB3E6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184393BB569
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72A314D0A;
	Wed, 22 Oct 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JGO3i+I+"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750C296BC3
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127003; cv=none; b=S5melq5agVw4pZnkbtgb+0SXMqG2039aqLBxnrliDBJ6tqggJrVJTHmF4Dnc3G9MS/EmeJi7npEL1nKHxN+4VYt2HyNA8o5rYpu/PlGuBnsu8M6MvwfZ+Qmgd8rfJdWxIj2RPXMoSeunBuuxeUIpG0R9ZlZlpA8cVUucyK1/jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127003; c=relaxed/simple;
	bh=M92oZjJRV29zncBnFJrQxQTJHBtsqpM7ptA2wW3uN+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeKjgqMAeQ1k7EtKPW9pYVLPF3nJWmddFPzbgcyUb14U8O8Ldrx6eVqIGY5YrZUxuiRMZ8Y4QiwHqdD/6CQdZiDqISnDn1iY+6zRG4l0uN5gfB+dVVlg8Xc66tQws9m+oo1XKnmmD/32b6mo24xL2adNEBy9BUNy5MXltNqIQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JGO3i+I+; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xli/qbpvNWvvC2EqcDhSBwe7VGcn6AodXA6fZIGnxsU=;
	b=JGO3i+I+57r8U3YWOgPLeZx/BUHaU7rxnG+olIQ2ARxUIzGm25wZ4RHygoKLP5Ao+rVoWGhEK
	u6d1rVpUZhILYNA7vNpNARGjBQOqdOr1Yxy6zv4oRldvs46jlsBW23s5LPmQz6dBqxeNL4WX4hZ
	5s/yxw9LJRBwtlZ2yrGZFhU=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cs4LJ1btmz1cyVL;
	Wed, 22 Oct 2025 17:56:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C16CD140259;
	Wed, 22 Oct 2025 17:56:32 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 17:56:32 +0800
Message-ID: <ebcee1f6-1a10-464d-8f79-233d7e312938@huawei.com>
Date: Wed, 22 Oct 2025 17:56:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: <wangzhou1@hisilicon.com>
CC: <stable@vger.kernel.org>, Barry Song <baohua@kernel.org>
References: <20251022095208.2301302-1-xiaqinxin@huawei.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20251022095208.2301302-1-xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/10/22 17:52:08, Qinxin Xia <xiaqinxin@huawei.com> wrote:
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
> 
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
> 
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>   include/linux/map_benchmark.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
> index 62674c83bde4..2ac2fe52f248 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -27,5 +27,6 @@ struct map_benchmark {
>   	__u32 dma_dir; /* DMA data direction */
>   	__u32 dma_trans_ns; /* time for DMA transmission in ns */
>   	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> +	__u8 expansion[76];     /* For future use */
>   };
>   #endif /* _KERNEL_DMA_BENCHMARK_H */
Dear All,

Please ignore this email, I have resent.

Thanks.

