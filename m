Return-Path: <stable+bounces-131903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC11A81F22
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 10:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6870917AFAA
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940525B69D;
	Wed,  9 Apr 2025 08:02:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC625B685;
	Wed,  9 Apr 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185771; cv=none; b=XL2r/LtyPJCpwOPnc94bjPOkStg2q3bLZXz7jajqjCX1atzRtRfOZsQEf2kR6eZ6YUOXJn2XJDZJ5yZMT5EG6oOuC1pejPErMP9Wlh/6di5+Hg2yQ1x3YbkW4/caprUJTDb/EQyerJ8dTWUU2Abse5efiRBmTc4oLs1eqjziPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185771; c=relaxed/simple;
	bh=J/uu+qgNusqrRm+lKxXP1nlROH5aUHnwJ4eWR386yUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iN+VEgIlU3DWLGEHAwtX5pEY6OnMxy3QcWFfZQ+rhYAHDxQc4OOG2fPry6if7Ddf9q30u70+fWpGnkizDIs4scrFrJnmyLwujP30SsARfA29Oajv1r+rxhRbCCtbKIZ6/RlWXFfI89KhLXHN4hFcmDq+tRZiz/xD0d6xfE66bU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZXb065Mkrz1f1sB;
	Wed,  9 Apr 2025 15:57:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 75A7D1A0188;
	Wed,  9 Apr 2025 16:02:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 16:02:40 +0800
Message-ID: <38964e68-ac20-4595-b41d-8adc83ae6ba0@huawei.com>
Date: Wed, 9 Apr 2025 16:02:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>,
	Mel Gorman <mgorman@techsingularity.net>, Carlos Song <carlos.song@nxp.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, <stable@vger.kernel.org>
References: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/8 2:01, Johannes Weiner wrote:

...

>  
> @@ -2934,6 +2981,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  {
>  	struct page *page;
>  	unsigned long flags;
> +	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
>  
>  	do {
>  		page = NULL;
> @@ -2945,7 +2993,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  		if (alloc_flags & ALLOC_HIGHATOMIC)
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  		if (!page) {
> -			page = __rmqueue(zone, order, migratetype, alloc_flags);
> +			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
>  
>  			/*
>  			 * If the allocation fails, allow OOM handling and

It was not in the diff, but it seems the zone->lock is held inside the do..while loop,
doesn't it mean that the freelists are subject to outside changes and rmqm is stale?

