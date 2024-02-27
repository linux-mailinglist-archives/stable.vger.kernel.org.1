Return-Path: <stable+bounces-24210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101486932D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6ED1C21AA0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7613DB98;
	Tue, 27 Feb 2024 13:42:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0D13AA55
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041340; cv=none; b=FKkoyL7Hwx4P0tZvH7RiaWsKODVMky8FMNOu5ibz7uO4Tbnt1cpyzeNxC6gIiOwpHkQPLkOaQrECoQ/Zaw2oXEQ4bzaykoswDogZLqHvWw7NHTKh0s+TwBICwgZ86whCF9ur8Oir2tqZgjqjtgRncQ4aeK2zlOt2rXLnP7qp9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041340; c=relaxed/simple;
	bh=6OR8pYM7suBpE4VlEJa7l0D5FXGcWyQjXvn2iIAyXQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IYi/sma23t6DkF57gnFsN+bsP4pi/QgPhsYXimryJr+j/DFQE+fQzIScyCnjxEPUPQ04wXzpJrcoMqMOg82h1JPBSmvwXQ9USD+nk6VFYyhAJnVCM+/7xed9dhxTKx4JBswx3qdlUNkfGCzDJ2n8gfTx3DJd/WdgtVDrOoda+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tkdtk66WYzqhms;
	Tue, 27 Feb 2024 21:41:34 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id AAFF1140336;
	Tue, 27 Feb 2024 21:42:11 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 21:42:11 +0800
Message-ID: <5a95aeb6-d070-fb3e-d619-8f26164b293c@huawei.com>
Date: Tue, 27 Feb 2024 21:42:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5.15 2/2] ext4: avoid bb_free and bb_fragments
 inconsistency in mb_free_blocks()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <sashal@kernel.org>, <tytso@mit.edu>,
	<jack@suse.cz>, <patches@lists.linux.dev>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20240227130050.805571-1-libaokun1@huawei.com>
 <20240227130050.805571-2-libaokun1@huawei.com>
 <2024022725-broadly-gave-6b16@gregkh>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2024022725-broadly-gave-6b16@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/27 21:06, Greg KH wrote:
> On Tue, Feb 27, 2024 at 09:00:50PM +0800, Baokun Li wrote:
>> commit 2331fd4a49864e1571b4f50aa3aa1536ed6220d0 upstream.
>>
>> After updating bb_free in mb_free_blocks, it is possible to return without
>> updating bb_fragments because the block being freed is found to have
>> already been freed, which leads to inconsistency between bb_free and
>> bb_fragments.
>>
>> Since the group may be unlocked in ext4_grp_locked_error(), this can lead
>> to problems such as dividing by zero when calculating the average fragment
>> length. Hence move the update of bb_free to after the block double-free
>> check guarantees that the corresponding statistics are updated only after
>> the core block bitmap is modified.
>>
>> Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
>> CC:  <stable@vger.kernel.org> # 3.10
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Link: https://lore.kernel.org/r/20240104142040.2835097-5-libaokun1@huawei.com
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 39 +++++++++++++++++++++------------------
>>   1 file changed, 21 insertions(+), 18 deletions(-)
> We also need this for 5.10.y and older, right?
>
> Queued up now, thanks!
>
> greg k-h
>
5.4.y and older will regenerate the buddy on error, so this is not needed.


-- 
With Best Regards,
Baokun Li
.


