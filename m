Return-Path: <stable+bounces-59414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1193281B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15C7B23200
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762919B3CC;
	Tue, 16 Jul 2024 14:18:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26713CA99
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139504; cv=none; b=I6IOlHuOwt9brdlea8IgjTlyGGF3vwYbqJM5pzAAiTz6rsHrx/l0NCQQciRYUpfhrkLDu6qsY6i31d1EFMOtOP7makRnd4sz18QhvJu1vMxTdy80b8R0opN8SvpPZZa9UgH7O717cOCo1qFVH3jA0NUdAneExY74n1+v3ktfOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139504; c=relaxed/simple;
	bh=jHWE6lELf4qGZSfLPtb1St+tDNSLRSoCxShdDSww7Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smtnFpA8hVHjH0oHcAHyz9rw8wDLibKIOtn2gT+F1zm0p/+oBVN0OzM7sky8R42NwZtrfcx/unr5wQELQPpFTyBy4EXcOKmBSenY2cEOEGlpK0v5Jk2IS75Jw+TExO62F8ddd7Sh/09J73Xbk8/BOa/+fHDtV+NgoTDVAnREA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WNh4H5Jqhz4f3kpj
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 22:18:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B108F1A0189
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 22:18:15 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHazkjgZZmglo1AQ--.18240S3;
	Tue, 16 Jul 2024 22:18:15 +0800 (CST)
Message-ID: <312e8f11-9f2f-4bab-86e8-f0d7fc38ffcc@huaweicloud.com>
Date: Tue, 16 Jul 2024 22:18:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6/6.9] ext4: avoid ptr null pointer dereference
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, tytso@mit.edu, jack@suse.cz,
 patches@lists.linux.dev, yi.zhang@huawei.com, yangerkun@huawei.com,
 Baokun Li <libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20240716092929.864207-1-libaokun@huaweicloud.com>
 <2024071624-ascent-breeding-7fb1@gregkh>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <2024071624-ascent-breeding-7fb1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazkjgZZmglo1AQ--.18240S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw13uFykJry3tFWxJryDAwb_yoW8JF15pr
	s5KF1UCF4jqr4qka1DuF15X34Yqw4fKF1UXr4SyF18Ca9rWr1SgrnrK3Z09F1kGFZ3Cr1S
	vFsFgFyfZrW3CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAGBWaWLvseagAAsT

On 2024/7/16 22:07, Greg KH wrote:
> On Tue, Jul 16, 2024 at 05:29:29PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> When commit 13df4d44a3aa ("ext4: fix slab-out-of-bounds in
>> ext4_mb_find_good_group_avg_frag_lists()") was backported to stable, the
>> commit f536808adcc3 ("ext4: refactor out ext4_generic_attr_store()") that
>> uniformly determines if the ptr is null is not merged in, so it needs to
>> be judged whether ptr is null or not in each case of the switch, otherwise
>> null pointer dereferencing may occur.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/sysfs.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index 63cbda3700ea..d65dccb44ed5 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -473,6 +473,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>>   			*((unsigned int *) ptr) = t;
>>   		return len;
>>   	case attr_clusters_in_group:
>> +		if (!ptr)
>> +			return 0;
>>   		ret = kstrtouint(skip_spaces(buf), 0, &t);
>>   		if (ret)
>>   			return ret;
>> -- 
>> 2.39.2
>>
>>
> Now queued up, thanks for the fix!
>
> greg k-h

Thanks for your consistent work. 😄

-- 
With Best Regards,
Baokun Li


