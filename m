Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21F6FBC16
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 02:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjEIArU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 20:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEIArT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 20:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A759E8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683593191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/yuut+R0uO7/CLdGSwN7f7x0QInXsq16bQxgohaOso=;
        b=FTLEH7QQ41N4mpQqaIpD5FBJ4JBu2n1X7rW5kYn3es+w6bWskbYSyoWjgoZ3ZOVgk73haj
        MKrjXinMoAW77kGBd2lDiysFwmt3yuy7Rv2x1attYHw4m+bD2KO7BRoEW2vH56+kmCHspx
        PebVybYhgoMaTPQBZp/HYAKXzuVvH8k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-YamVEsX7PT2kKkf6szb3rQ-1; Mon, 08 May 2023 20:46:30 -0400
X-MC-Unique: YamVEsX7PT2kKkf6szb3rQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ab032d91a1so30618025ad.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 17:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593189; x=1686185189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/yuut+R0uO7/CLdGSwN7f7x0QInXsq16bQxgohaOso=;
        b=SNGz/ilId62MxeC+G4C0hgnh7nCaengtTqk2LBFk6c/X7qo/VB87QzJdt6eRs7nsIC
         5WbzqnoQlJE9qb7ztnuNRrmwaEkjOHH8HcL+6nTZ9e57c1w9YvLFF3TkrP1fhZoSUCiA
         C7cO3y7K4bEkFRx6ypQz50ZVDMiSWpWzmVcH8lxd550x48lj8NlOqQbiGrYx5krcTLLP
         C9ffsmv+ijFqvjpXeqTA4//z16Pr1fSz9+9Gc5+Rc7vsdof2DhWdnR2q70/wTLkOp8lL
         FhzJpCuolZrJMsgO9ak6/7s2yvG+fPVWvnikDBYiKA5PY1BMDNYzMzfiyZ5kiQ6bbMH2
         cc/w==
X-Gm-Message-State: AC+VfDx4kBmMA6hKNDLHp4PJV8CtYAT+xnRV8oVPHDKrsChiaEGhjAJo
        ERUX8h/9keNFPMjGV0EzyBmbiFjSol7SutVX938PjjbYMLz9oIK9GYsCDR++PGpE7fSzlZf1r48
        BMEryZqyjR0RBrE+Z
X-Received: by 2002:a17:903:2310:b0:1a9:8ddd:8213 with SMTP id d16-20020a170903231000b001a98ddd8213mr15146483plh.57.1683593189458;
        Mon, 08 May 2023 17:46:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mFzhy772rttrQLb3CC1dS9J5oWkKzJEyYo8zdrd9r3VGk6qOCuWS9uoxZn/VIaqrFddAqNQ==
X-Received: by 2002:a17:903:2310:b0:1a9:8ddd:8213 with SMTP id d16-20020a170903231000b001a98ddd8213mr15146467plh.57.1683593189141;
        Mon, 08 May 2023 17:46:29 -0700 (PDT)
Received: from [10.72.12.156] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001a5fccab02dsm86071plg.177.2023.05.08.17.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 17:46:28 -0700 (PDT)
Message-ID: <afda1cfc-08b6-5777-673e-fb49b9e74db7@redhat.com>
Date:   Tue, 9 May 2023 08:46:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ceph: fix blindly expanding the readahead windows
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, lhenriques@suse.de, mchangir@redhat.com,
        stable@vger.kernel.org, Hu Weiwen <sehuww@mail.scut.edu.cn>
References: <20230504111100.417305-1-xiubli@redhat.com>
 <CAOi1vP_8hUUZBHXLUJP3Xq74LONKq=weFQMV+Es45yV3wH-wTw@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP_8hUUZBHXLUJP3Xq74LONKq=weFQMV+Es45yV3wH-wTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/8/23 20:46, Ilya Dryomov wrote:
> On Thu, May 4, 2023 at 1:11 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Blindly expanding the readahead windows will cause unneccessary
>> pagecache thrashing and also will introdue the network workload.
>> We should disable expanding the windows if the readahead is disabled
>> and also shouldn't expand the windows too much.
>>
>> Expanding forward firstly instead of expanding backward for possible
>> sequential reads.
>>
>> Bound `rreq->len` to the actual file size to restore the previous page
>> cache usage.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
>> URL: https://lore.kernel.org/ceph-devel/20230504082510.247-1-sehuww@mail.scut.edu.cn
>> URL: https://www.spinics.net/lists/ceph-users/msg76183.html
>> Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> V3:
>> - Folded Hu Weiwen's fix and bound `rreq->len` to the actual file size.
> Hi Xiubo,
>
> This looks much better!  Just a couple of nits:
>
>>
>>
>>   fs/ceph/addr.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index ca4dc6450887..357d9d28f202 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -188,16 +188,32 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
>>          struct inode *inode = rreq->inode;
>>          struct ceph_inode_info *ci = ceph_inode(inode);
>>          struct ceph_file_layout *lo = &ci->i_layout;
>> +       unsigned long max_pages = inode->i_sb->s_bdi->ra_pages;
>> +       unsigned long max_len = max_pages << PAGE_SHIFT;
>> +       loff_t end = rreq->start + rreq->len, new_end;
>>          u32 blockoff;
>>          u64 blockno;
>>
>> -       /* Expand the start downward */
>> -       blockno = div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
>> -       rreq->start = blockno * lo->stripe_unit;
>> -       rreq->len += blockoff;
>> +       /* Readahead is disabled */
>> +       if (!max_pages)
>> +               return;
>>
>> -       /* Now, round up the length to the next block */
>> -       rreq->len = roundup(rreq->len, lo->stripe_unit);
>> +       /*
>> +        * Try to expand the length forward by rounding  up it to the next
>> +        * block, but do not exceed the file size, unless the original
>> +        * request already exceeds it.
>> +        */
>> +       new_end = round_up(end, lo->stripe_unit);
>> +       new_end = min(new_end, rreq->i_size);
> This can be done on single line:
>
>          new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
Sure, will fix it.
>> +       if (new_end > end && new_end <= rreq->start + max_len)
>> +               rreq->len = new_end - rreq->start;
>> +
>> +       /* Try to expand the start downward */
>> +       blockno = div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
>> +       if (rreq->len + blockoff <= max_len) {
>> +               rreq->start = blockno * lo->stripe_unit;
> Can this be written as:
>
>                  rreq->start -= blockoff;
>
> It seems like it would be easier to read and probably cheaper to
> compute too.

Yeah, this looks much easier to understand.

Thanks

- Xiubo

> Thanks,
>
>                  Ilya
>

