Return-Path: <stable+bounces-89777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4849BC372
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 03:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8951F22C7B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150B51C4A;
	Tue,  5 Nov 2024 02:55:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7A481A3;
	Tue,  5 Nov 2024 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775343; cv=none; b=ZGYKB9oWeMDV2TEQ/JIMFg9TWnzJ9WoiTQtVx+RPRCRPKj4wupJgEqS4/9/56d+Pn+gZzhFClsRoEl5xrAcv4m1pOge2hVL08Dl1MMOz6jVtt3vIzvJbUd1BKqZZPj1aQuETgo6izUz7R30f9zIeJuM+r8bY0ROLhYbRXpmLVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775343; c=relaxed/simple;
	bh=L1q/BU0LxaWh2tUcwu9Q99hm+1IOyr7ni0dACL0DnSY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rCvZW7TvEqdfqkjiIc9z3FJLMigzeF5Q233+ZmGOm97Ia6SCShizCevfokcHzNvHrRdfsu99MdgGG9VaUj7wmlHkeZXd3u2FF3sGsfWt0ET075zVfPkV2hco89AwIbdRGm5QSEjlPjx8tBhswu53DYbbEIj9p4lWxrzSDHFA0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XjCWr1BZNz1JB91;
	Tue,  5 Nov 2024 10:51:04 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D0C5A1402E0;
	Tue,  5 Nov 2024 10:55:38 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Nov 2024 10:55:38 +0800
Message-ID: <65c41d94-8aca-4161-b81b-0e420cfe3694@huawei.com>
Date: Tue, 5 Nov 2024 10:55:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: Patch "net: hns3: add sync command to sync io-pgtable" has been
 added to the 6.6-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
	<shenjian15@huawei.com>
References: <20241101192454.3850887-1-sashal@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241101192454.3850887-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/2 3:24, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      net: hns3: add sync command to sync io-pgtable
>
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       net-hns3-add-sync-command-to-sync-io-pgtable.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi:
This patch was reverted from netdev,
so, it also need be reverted from stable tree.
I am sorry for that.
  
reverted link:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568

Thanks,
Jijie Shao

>
>
>
> commit 98cb88cce78da8a369cf780343d0280f9d3af4ca
> Author: Jian Shen <shenjian15@huawei.com>
> Date:   Fri Oct 25 17:29:31 2024 +0800
>
>      net: hns3: add sync command to sync io-pgtable
>      
>      [ Upstream commit f2c14899caba76da93ff3fff46b4d5a8f43ce07e ]
>      
>      To avoid errors in pgtable prefectch, add a sync command to sync
>      io-pagtable.
>      
>      This is a supplement for the previous patch.
>      We want all the tx packet can be handled with tx bounce buffer path.
>      But it depends on the remain space of the spare buffer, checked by the
>      hns3_can_use_tx_bounce(). In most cases, maybe 99.99%, it returns true.
>      But once it return false by no available space, the packet will be handled
>      with the former path, which will map/unmap the skb buffer.
>      Then the driver will face the smmu prefetch risk again.
>      
>      So add a sync command in this case to avoid smmu prefectch,
>      just protects corner scenes.
>      
>      Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
>      Signed-off-by: Jian Shen <shenjian15@huawei.com>
>      Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>      Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>      Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 1f9bbf13214fb..bfcebf4e235ef 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -381,6 +381,24 @@ static const struct hns3_rx_ptype hns3_rx_ptype_tbl[] = {
>   #define HNS3_INVALID_PTYPE \
>   		ARRAY_SIZE(hns3_rx_ptype_tbl)
>   
> +static void hns3_dma_map_sync(struct device *dev, unsigned long iova)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_iotlb_gather iotlb_gather;
> +	size_t granule;
> +
> +	if (!domain || !iommu_is_dma_domain(domain))
> +		return;
> +
> +	granule = 1 << __ffs(domain->pgsize_bitmap);
> +	iova = ALIGN_DOWN(iova, granule);
> +	iotlb_gather.start = iova;
> +	iotlb_gather.end = iova + granule - 1;
> +	iotlb_gather.pgsize = granule;
> +
> +	iommu_iotlb_sync(domain, &iotlb_gather);
> +}
> +
>   static irqreturn_t hns3_irq_handle(int irq, void *vector)
>   {
>   	struct hns3_enet_tqp_vector *tqp_vector = vector;
> @@ -1728,7 +1746,9 @@ static int hns3_map_and_fill_desc(struct hns3_enet_ring *ring, void *priv,
>   				  unsigned int type)
>   {
>   	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
> +	struct hnae3_handle *handle = ring->tqp->handle;
>   	struct device *dev = ring_to_dev(ring);
> +	struct hnae3_ae_dev *ae_dev;
>   	unsigned int size;
>   	dma_addr_t dma;
>   
> @@ -1760,6 +1780,13 @@ static int hns3_map_and_fill_desc(struct hns3_enet_ring *ring, void *priv,
>   		return -ENOMEM;
>   	}
>   
> +	/* Add a SYNC command to sync io-pgtale to avoid errors in pgtable
> +	 * prefetch
> +	 */
> +	ae_dev = hns3_get_ae_dev(handle);
> +	if (ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V3)
> +		hns3_dma_map_sync(dev, dma);
> +
>   	desc_cb->priv = priv;
>   	desc_cb->length = size;
>   	desc_cb->dma = dma;

