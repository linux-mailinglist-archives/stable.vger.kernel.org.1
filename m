Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAA721F63
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjFEHTJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFEHTH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 03:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517ECA
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685949496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7F656ugRgdTn+ecAEtEyIDUabqlEKXFiaPRs71udAPE=;
        b=J3jgSDVLaYRQquZSrmGx0dyQ/Hb96FNU0fA/RkdrUxaW9E9kcqOYyoFI8Bd6I9ZITSxpFo
        nODFfCzTO9ooudc2Cu+x7zLfLM8DBYUDW0fp8TwwwZIqmjlpfmfVbI0J5ZhhCrVDv3OgQ/
        xkQRB2+js8giFBEaviG8NitisABrJMI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-jaJj5zpWM9iz0pE315Vr-g-1; Mon, 05 Jun 2023 03:18:15 -0400
X-MC-Unique: jaJj5zpWM9iz0pE315Vr-g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2568fd3f360so1451161a91.2
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 00:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685949494; x=1688541494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F656ugRgdTn+ecAEtEyIDUabqlEKXFiaPRs71udAPE=;
        b=VKvjwd7g9x/5RgI8WR290m28uzAEn3vBkGHBVtMzViiYZGltg0KuyJcTFN3SB+/NsC
         d0oSqch3RxVttCzLz05IChy8q1hAaBzOCdMfQ42ZgVN6NghyiYBmrxIMyGiMTwoJXk2l
         4LTHDOjeAAMQbWEL3BCxi5kf5ykCGfsAZQXCPx0+1XV85V8yBSIV+WZl5rbeyP4qWdIV
         vXAzjrCJhgvEfBzipCOUSbfUdnLlk7uDxf93HOyFl87gjHNwaG7kRqK9H6C0ip3ANP5L
         fpwr8COZt5g1NGAPwfCHKuoSGcyCyqWAZ2FQGs2gT40/0mB1e24ITaUhldtrcDc5pzhO
         m8lQ==
X-Gm-Message-State: AC+VfDz4MyP8v+cNf/a9wTwK/W6o2gRHF0m+W5A8SB0PvqwE4kRim29I
        9rQl+tNH/oE5/0/vtCmnfnwA+32FZ+vJyQeSFndOyvptRJ0Nr41NhNlA577ze/V96yVKSvwxd3P
        DDXhyC6WunvkkU7/3
X-Received: by 2002:a17:90a:4bcc:b0:256:2518:fb26 with SMTP id u12-20020a17090a4bcc00b002562518fb26mr3314000pjl.27.1685949494024;
        Mon, 05 Jun 2023 00:18:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SOfti4BCpWK8MDo/yD36CdBBMZOnawtgCVLwM6GL2s7QY3iKk+Z+OwB/G63NuehfLkRuGwQ==
X-Received: by 2002:a17:90a:4bcc:b0:256:2518:fb26 with SMTP id u12-20020a17090a4bcc00b002562518fb26mr3313989pjl.27.1685949493662;
        Mon, 05 Jun 2023 00:18:13 -0700 (PDT)
Received: from [10.72.12.216] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090a674d00b0024dee5cbe29sm5210364pjm.27.2023.06.05.00.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 00:18:13 -0700 (PDT)
Message-ID: <622cae19-a856-ef9f-d272-22e80ce53d56@redhat.com>
Date:   Mon, 5 Jun 2023 15:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/2] ceph: fix blindly expanding the readahead windows
Content-Language: en-US
To:     =?UTF-8?B?6IOh546u5paH?= <huww98@outlook.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, sehuww@mail.scut.edu.cn,
        stable@vger.kernel.org
References: <20230515012044.98096-1-xiubli@redhat.com>
 <20230515012044.98096-3-xiubli@redhat.com>
 <TYCP286MB206692566DDEE50F7AD00A49C04DA@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <TYCP286MB206692566DDEE50F7AD00A49C04DA@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 6/5/23 14:56, 胡玮文 wrote:
> On Mon, May 15, 2023 at 09:20:44AM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Blindly expanding the readahead windows will cause unneccessary
>> pagecache thrashing and also will introdue the network workload.
> s/introdue/introduce/

Will fix it.


>> We should disable expanding the windows if the readahead is disabled
>> and also shouldn't expand the windows too much.
>>
>> Expanding forward firstly instead of expanding backward for possible
>> sequential reads.
>>
>> Bound `rreq->len` to the actual file size to restore the previous page
>> cache usage.
>>
>> The posix_fadvise may change the maximum size of a file readahead.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
>> URL: https://lore.kernel.org/ceph-devel/20230504082510.247-1-sehuww@mail.scut.edu.cn
>> URL: https://www.spinics.net/lists/ceph-users/msg76183.html
>> Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/addr.c | 40 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 93fff1a7373f..4b29777c01d7 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -188,16 +188,42 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
>>   	struct inode *inode = rreq->inode;
>>   	struct ceph_inode_info *ci = ceph_inode(inode);
>>   	struct ceph_file_layout *lo = &ci->i_layout;
>> +	unsigned long max_pages = inode->i_sb->s_bdi->ra_pages;
>> +	loff_t end = rreq->start + rreq->len, new_end;
>> +	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
>> +	unsigned long max_len;
>>   	u32 blockoff;
>> -	u64 blockno;
>>   
>> -	/* Expand the start downward */
>> -	blockno = div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
>> -	rreq->start = blockno * lo->stripe_unit;
>> -	rreq->len += blockoff;
>> +	if (priv) {
>> +		/* Readahead is disabled by posix_fadvise POSIX_FADV_RANDOM */
>> +		if (priv->file_ra_disabled)
>> +			max_pages = 0;
>> +		else
>> +			max_pages = priv->file_ra_pages;
>> +
>> +	}
>> +
>> +	/* Readahead is disabled */
>> +	if (!max_pages)
>> +		return;
>>   
>> -	/* Now, round up the length to the next block */
>> -	rreq->len = roundup(rreq->len, lo->stripe_unit);
>> +	max_len = max_pages << PAGE_SHIFT;
>> +
>> +	/*
>> +	 * Try to expand the length forward by rounding  up it to the next
> An extra space between "rounding  up".

Will fix it.


> Apart from above two typo, LGTM.
>
> Reviewed-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
>
> I also tested this patch with our workload. Reading the first 16k images
> from ImageNet dataset (1.69GiB) takes about 1.8Gi page cache (as
> reported by `free -h'). This is expected.
>
> For the fadvise use-case, I use `fio' to do the test:
> $ fio --name=rand --size=32M --fadvise_hint=1 --ioengine=libaio --iodepth=128 --rw=randread --bs=4k --filesize=2G
>
> after the test, page cache increased by about 35Mi, which is expected.
> So if appropriate:
>
> Tested-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Thanks for your tests and reviewing.

> However, also note random reading to a large file without fadvise still
> suffers from degradation. e.g., this test:
> $ fio --name=rand --size=32M --fadvise_hint=0 --ioengine=libaio --iodepth=128 --rw=randread --bs=4k --filesize=2G
>
> will load nearly every page of the 2Gi test file into page cache,
> although I only need 32Mi of them.

This is another issue since this patch just to fix blindly expanding 
readahead windows, please send one following patch to fix it.

Thanks

- Xiubo


>> +	 * block, but do not exceed the file size, unless the original
>> +	 * request already exceeds it.
>> +	 */
>> +	new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
>> +	if (new_end > end && new_end <= rreq->start + max_len)
>> +		rreq->len = new_end - rreq->start;
>> +
>> +	/* Try to expand the start downward */
>> +	div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
>> +	if (rreq->len + blockoff <= max_len) {
>> +		rreq->start -= blockoff;
>> +		rreq->len += blockoff;
>> +	}
>>   }
>>   
>>   static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
>> -- 
>> 2.40.1
>>

