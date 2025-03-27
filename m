Return-Path: <stable+bounces-126851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EACA72EA7
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C997A6A34
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569920F093;
	Thu, 27 Mar 2025 11:17:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8051FFC46;
	Thu, 27 Mar 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074224; cv=none; b=smCJpZAQ0sG0spZXPSs+2oG0EJ2pE4P9cWWXcZeGYkQDFiWkiQtXnzEsp/obHu02Dtzu6TPojn5xUH5WKtST+JEvcwRPlN0JieG2YvNAXVGCMHM+mIlNaXcuEHh5F3oI6R5xtYqJTpdwTcEglr0Xc18sJT6FP0oYb9DHYMha/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074224; c=relaxed/simple;
	bh=DQVHqiuPN11gb2JpuH2GOnPPU4bG0nvnSH4cAgUtCsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lv2f6vCTONQanM4PP9NaQcDz6BigENoEC5MsnJbbscbBD5wWmpZeHC82BQdMTiSRPVkNwFn/r/yJIuFF6r259kvss8zMIWGOBe5P+b1xO+EskYOsFcFYCil8kkatOMFAcP5Cji6N3+9rL4bJZi1juWdr3b/7JAmrhOzX8atRSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZNgxS3XBPzvWpc;
	Thu, 27 Mar 2025 19:13:00 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id B17191800B4;
	Thu, 27 Mar 2025 19:16:57 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 19:16:56 +0800
Message-ID: <076babae-9fc6-13f5-36a3-95dde0115f77@huawei.com>
Date: Thu, 27 Mar 2025 19:16:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: David Hildenbrand <david@redhat.com>, <yangge1116@126.com>,
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <21cnbao@gmail.com>,
	<baolin.wang@linux.alibaba.com>, <aneesh.kumar@linux.ibm.com>,
	<liuzixing@hygon.cn>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
 <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
 <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo200002.china.huawei.com (7.202.195.209)


在 2025/3/26 20:46, David Hildenbrand 写道:
> On 26.03.25 13:42, Jinjiang Tu wrote:
>> Hi,
>>
>
> Hi!
>
>> We notiched a 12.3% performance regression for LibMicro pwrite 
>> testcase due to
>> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before 
>> adding to LRU batch").
>>
>> The testcase is executed as follows, and the file is tmpfs file.
>>      pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE
>
> Do we know how much that reflects real workloads? (IOW, how much 
> should we care)

No, it's hard to say.

>
>>
>> this testcase writes 1KB (only one page) to the tmpfs and repeats 
>> this step for many times. The Flame
>> graph shows the performance regression comes from 
>> folio_mark_accessed() and workingset_activation().
>>
>> folio_mark_accessed() is called for the same page for many times. 
>> Before this patch, each call will
>> add the page to cpu_fbatches.activate. When the fbatch is full, the 
>> fbatch is drained and the page
>> is promoted to active list. And then, folio_mark_accessed() does 
>> nothing in later calls.
>>
>> But after this patch, the folio clear lru flags after it is added to 
>> cpu_fbatches.activate. After then,
>> folio_mark_accessed will never call folio_activate() again due to the 
>> page is without lru flag, and
>> the fbatch will not be full and the folio will not be marked active, 
>> later folio_mark_accessed()
>> calls will always call workingset_activation(), leading to 
>> performance regression.
>
> Would there be a good place to drain the LRU to effectively get that 
> processed? (we can always try draining if the LRU flag is not set)

Maybe we could drain the search the cpu_fbatches.activate of the local cpu in __lru_cache_activate_folio()? Drain other fbatches is meaningless .

>
>

