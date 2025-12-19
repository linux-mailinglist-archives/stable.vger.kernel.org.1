Return-Path: <stable+bounces-203058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFBCCF41F
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2713038994
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0C2EFD99;
	Fri, 19 Dec 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FHE6ipyz"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204D2DA771;
	Fri, 19 Dec 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138395; cv=none; b=k9gjF7qE4htQ+pWBcdgqS1XpAelqmrqrQ4nKZf9E5Dpzuw6KuniEtmabM/dHlCwhad2KAfQg2Ed30hI68nnzxKUXaTJAihdD5Zjh4VpbRR2YS2LtkvEgj55UO7FPq/b1nUMSkUWcX80laNenZr8AxG5BdWROi3sqsiucrtHk/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138395; c=relaxed/simple;
	bh=uCBMvXjxFJlxDTngWRkAtxc6kPWbGbywqy5yNX+ft38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFboClgRhEjKbDgyjurILIpK+vyiE+/yj7efeU2wq9G5TBi8nJVblMIgvoeDu8RnuQAR0NC9o2pmBreo1KafW0rfZAFRcj3d0EY2+MbwXdTXTtJMM/rwq1E15ChWGWSlYJMYByIxT1tUigSSjUr51DijTuTv3sgFmOpxGDmHeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FHE6ipyz; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766138383; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XgQizcauHnh/ysYzDZP7I8/fUHcU7RgcJ9ws2O2qYhk=;
	b=FHE6ipyz2MtpD3jkQ9VpU1FlVcsfaK4ePXb+V8H+2NFC9iOCiczY6VAjpi/20qFGnH5F9tyVxHk1yikpqehISGcXC5Ht5XaYOwEIJxk/X7RBTkxk+HHM+E55vb8nzNBn733HkqFnO8yItS4Pa5k2gMKfX9V0/oTuOcA9rt/9Hgs=
Received: from 30.221.131.220(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvCXM1G_1766138062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Dec 2025 17:54:23 +0800
Message-ID: <9cc27554-740b-461d-a550-3d8af63a2b94@linux.alibaba.com>
Date: Fri, 19 Dec 2025 17:54:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 'Jaewook Kim' <jw5454.kim@samsung.com>,
 'Sungjong Seo' <sj1557.seo@samsung.com>
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
 <20251219071034.2399153-1-junbeom.yeom@samsung.com>
 <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
 <000001dc70cc$6cc150c0$4643f240$@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000001dc70cc$6cc150c0$4643f240$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/19 17:47, Junbeom Yeom wrote:
> Hi Xiang,
> 
>>
>> Hi Junbeom,
>>
>> On 2025/12/19 15:10, Junbeom Yeom wrote:
>>> erofs readahead could fail with ENOMEM under the memory pressure
>>> because it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while
>>> GFP_KERNEL for a regular read. And if readahead fails (with
>>> non-uptodate folios), the original request will then fall back to
>>> synchronous read, and `.read_folio()` should return appropriate errnos.
>>>
>>> However, in scenarios where readahead and read operations compete,
>>> read operation could return an unintended EIO because of an incorrect
>>> error propagation.
>>>
>>> To resolve this, this patch modifies the behavior so that, when the
>>> PCL is for read(which means pcl.besteffort is true), it attempts
>>> actual decompression instead of propagating the privios error except initial EIO.
>>>
>>> - Page size: 4K
>>> - The original size of FileA: 16K
>>> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
>>> [page0, page1] [page2, page3] [PCL0]---------[PCL1]
>>>
>>> - functions declaration:
>>>     . pread(fd, buf, count, offset)
>>>     . readahead(fd, offset, count)
>>> - Thread A tries to read the last 4K
>>> - Thread B tries to do readahead 8K from 4K
>>> - RA, besteffort == false
>>> - R, besteffort == true
>>>
>>>           <process A>                   <process B>
>>>
>>> pread(FileA, buf, 4K, 12K)
>>>     do readahead(page3) // failed with ENOMEM
>>>     wait_lock(page3)
>>>       if (!uptodate(page3))
>>>         goto do_read
>>>                                  readahead(FileA, 4K, 8K)
>>>                                  // Here create PCL-chain like below:
>>>                                  // [null, page1] [page2, null]
>>>                                  //   [PCL0:RA]-----[PCL1:RA]
>>> ...
>>>     do read(page3)        // found [PCL1:RA] and add page3 into it,
>>>                           // and then, change PCL1 from RA to R ...
>>>                                  // Now, PCL-chain is as below:
>>>                                  // [null, page1] [page2, page3]
>>>                                  //   [PCL0:RA]-----[PCL1:R]
>>>
>>>                                    // try to decompress PCL-chain...
>>>                                    z_erofs_decompress_queue
>>>                                      err = 0;
>>>
>>>                                      // failed with ENOMEM, so page 1
>>>                                      // only for RA will not be uptodated.
>>>                                      // it's okay.
>>>                                      err = decompress([PCL0:RA], err)
>>>
>>>                                      // However, ENOMEM propagated to next
>>>                                      // PCL, even though PCL is not only
>>>                                      // for RA but also for R. As a result,
>>>                                      // it just failed with ENOMEM without
>>>                                      // trying any decompression, so page2
>>>                                      // and page3 will not be uptodated.
>>>                   ** BUG HERE ** --> err = decompress([PCL1:R], err)
>>>
>>>                                      return err as ENOMEM ...
>>>       wait_lock(page3)
>>>         if (!uptodate(page3))
>>>           return EIO      <-- Return an unexpected EIO!
>>> ...
>>
>> Many thanks for the report!
>> It's indeed a new issue to me.
>>
>>>
>>> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
>>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>>> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
>>> ---
>>>    fs/erofs/zdata.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c index
>>> 27b1f44d10ce..86bf6e087d34 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct
>> z_erofs_decompressqueue *io,
>>>    	};
>>>    	struct z_erofs_pcluster *next;
>>>    	int err = io->eio ? -EIO : 0;
>>> +	int io_err = err;
>>>
>>>    	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
>>> +		int propagate_err;
>>> +
>>>    		DBG_BUGON(!be.pcl);
>>>    		next = READ_ONCE(be.pcl->next);
>>> -		err = z_erofs_decompress_pcluster(&be, err) ?: err;
>>> +		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
>>> +		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
>>
>> I wonder if it's just possible to decompress each pcluster according to io
>> status only (but don't bother with previous pcluster status), like:
>>
>> 		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;
>>
>> and change the second argument of
>> z_erofs_decompress_pcluster() to bool.
>>
>> So that we could leverage the successful i/o as much as possible.
> 
> Oh, I thought you were intending to address error propagation.

We could still propagate errors (-ENOMEM) to the callers, but for
the case you mentioned, I still think it's useful to handle the
following pclusters if the disk I/Os are successful.

and it still addresses the issue you mentioned, I think it's also
cleaner.

> If that's not the case, I also believe the approach you're suggesting is better.
> I'll send the next version.

Thank you for the effort!

Thanks,
Gao Xiang

> 
> Thanks,
> Junbeom Yeom
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>    	}
>>>    	return err;
>>>    }
>>
> 


