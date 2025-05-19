Return-Path: <stable+bounces-144878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C6ABC278
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46C3189E627
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0E28540E;
	Mon, 19 May 2025 15:30:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2527CCDA;
	Mon, 19 May 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668637; cv=none; b=RAKXyyJGQznY4oEURge9Bpm8zysCVaXQkbFIjJjqelHkO9S8Gzp8pry2C8VNAbT7bv5KStWwsNxbWZvwQj9zGgVrRMHemSjEakh7+xhIjBqRgWyn/8W2apF5kxvuZh2nuK/xXjdWodaiPJTk4n8AN7UJhZ6nJ/YMktMnf+sK9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668637; c=relaxed/simple;
	bh=tf5L2fCE4dGtpAhYewQzZfypzzNRaPuFIUwDAS5IA64=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=thu6QuqOsFZ5Eq1lH5qfWbVq3hlBcRjIUUgJiTnyshmgOSc5S/Lo8hy8nR/mTKGPC2KS6cw56KkSSDyvFPm+Pet4upp790OZj5B7lCkHxs1GeV0TLQCCKOjwhqTsC1Dq4MFPFPdYEEXfgq7ukfsxdVXvMZC8LmsUU3MyZsFdnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b1M932mdFz27hwY;
	Mon, 19 May 2025 23:31:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 11E6B1A016C;
	Mon, 19 May 2025 23:30:31 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 23:30:30 +0800
Message-ID: <3f03a8d0-c056-4c46-8f98-a5b5f48c6159@huawei.com>
Date: Mon, 19 May 2025 23:30:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <horms@kernel.org>, <lanhao@huawei.com>,
	<wangpeiyang1@huawei.com>, <rosenp@gmail.com>, <liuyonglong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: Add error handling for VLAN filter hardware
 configuration
To: Wentao Liang <vulab@iscas.ac.cn>, <shenjian15@huawei.com>,
	<salil.mehta@huawei.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20250517141514.800-1-vulab@iscas.ac.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250517141514.800-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/5/17 22:15, Wentao Liang wrote:
> The hclge_rm_vport_vlan_table() calls hclge_set_vlan_filter_hw() but does
> not check the return value. This could lead to execution with potentially
> invalid data. A proper implementation can be found in

Hi:

Are there any real functional problems?
Would you please tell me your test cases? I'm going to try to reproduce the problem.

Thanks,
Jijie Shao

> hclge_add_vport_all_vlan_table().
>
> Add error handling after calling hclge_set_vlan_filter_hw(). If
> hclge_set_vlan_filter_hw() fails, log an error message via dev_err() and
> return.
>
> Fixes: c6075b193462 ("net: hns3: Record VF vlan tables")
> Cc: stable@vger.kernel.org # v5.1
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   .../hisilicon/hns3/hns3pf/hclge_main.c        | 20 +++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index db7845009252..5ab4c7f63766 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -10141,15 +10141,23 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
>   {
>   	struct hclge_vport_vlan_cfg *vlan, *tmp;
>   	struct hclge_dev *hdev = vport->back;
> +	int ret;
>   
>   	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
>   		if (vlan->vlan_id == vlan_id) {
> -			if (is_write_tbl && vlan->hd_tbl_status)
> -				hclge_set_vlan_filter_hw(hdev,
> -							 htons(ETH_P_8021Q),
> -							 vport->vport_id,
> -							 vlan_id,
> -							 true);
> +			if (is_write_tbl && vlan->hd_tbl_status) {
> +				ret = hclge_set_vlan_filter_hw(hdev,
> +							       htons(ETH_P_8021Q),
> +							       vport->vport_id,
> +							       vlan_id,
> +							       true);
> +				if (ret) {
> +					dev_err(&hdev->pdev->dev,
> +						"restore vport vlan list failed, ret=%d\n",
> +						ret);
> +					return;
> +				}
> +			}
>   
>   			list_del(&vlan->node);
>   			kfree(vlan);

