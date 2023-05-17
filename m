Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3270666D
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjEQLQO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjEQLQB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 07:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB565A8
        for <stable@vger.kernel.org>; Wed, 17 May 2023 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684322102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLrmsEYYReNl8EuhRQlXtdVX1JQekdmNbdM+/Oi1njE=;
        b=U3nyMkSNpEA69Mx2Oy/4GorrxV4Dp2PFeN9fJN9v5C40Wv+vq3x8Me/R86YHtCDueV3qCe
        4YxLq7Uspit/Dl74Y7dpmSmWH9gUFAs+R/13aoKJ2VIZ9mAYduS1FW/Y/76uUM8C8PThuc
        9ZOKseZQG6SNqUkfMI9PQDBw9fbhNzU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320--OEbo7nRPAq11lw7EzwQow-1; Wed, 17 May 2023 07:15:01 -0400
X-MC-Unique: -OEbo7nRPAq11lw7EzwQow-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2533b914d33so839175a91.3
        for <stable@vger.kernel.org>; Wed, 17 May 2023 04:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322100; x=1686914100;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLrmsEYYReNl8EuhRQlXtdVX1JQekdmNbdM+/Oi1njE=;
        b=VnCgZBwBC71ohENx3tBACHNYlou1XmaAEDUz79lL+4NGPaOqC5NdQ2KX3Srvfm/pJX
         2Q4PMIQt+P9t22yPwPJ7+H9IAGmIOZUu9yb2btrHBpT0Qb9ojCWRxAs5c9Ft9kefLhzR
         IO8a/zcDuKB7ny5xaHBmcjy6PMZXsshW1mSnU1MTnqF6hyqY1hscpvjtts3UXQsfm5Rl
         oXASkpgNU/FGq3GuQ48r4UmrsFHoCwcaGartFBmDwDmAcD4TYIBVQKJ3OCAo0DCbmzrp
         eIVVQkFvViSiowASFzK8KoxmHlmd2akjlybA77NlVgW0JFjHHN8yhSTxyvkoPz2/leyL
         B8yQ==
X-Gm-Message-State: AC+VfDw32LCZnt+m3xnYW/uoDfnpqNFguKuTcOUHuT4RFo6+b7nodyk0
        NF57rgHsprjKsUWgV9mci6UGuDvuigMOw3QYYtG4Ia3XZHmZEZBM7ArxyupmVH143PvXem5fkdn
        rlnXyOxHFuPVMdNOUl4nNoQgOPwo=
X-Received: by 2002:a17:90a:cb02:b0:249:6098:b068 with SMTP id z2-20020a17090acb0200b002496098b068mr40421596pjt.45.1684322100177;
        Wed, 17 May 2023 04:15:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XCJd7kPd+Urz75M8EkZCYpcDi5jQuyNTsPQlznTgQfEmfAta4UXV/m8dY2eNaAkJcsRjK8Q==
X-Received: by 2002:a17:90a:cb02:b0:249:6098:b068 with SMTP id z2-20020a17090acb0200b002496098b068mr40421580pjt.45.1684322099840;
        Wed, 17 May 2023 04:14:59 -0700 (PDT)
Received: from [10.72.12.110] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r20-20020a63ec54000000b005305023fed7sm13921373pgj.74.2023.05.17.04.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 04:14:59 -0700 (PDT)
Message-ID: <d6ae6f9e-07f5-0120-2cc6-b5f3f2ddca5f@redhat.com>
Date:   Wed, 17 May 2023 19:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: force updating the msg pointer in non-split case
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org,
        Frank Schilder <frans@dtu.dk>
References: <20230517052404.99904-1-xiubli@redhat.com>
 <CAOi1vP8e6NrrrV5TLYS-DpkjQN6LhfqkptR5_ue94HcHJV_2ag@mail.gmail.com>
 <b121586f-d628-a8e3-5802-298c1431f0e5@redhat.com>
In-Reply-To: <b121586f-d628-a8e3-5802-298c1431f0e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/17/23 19:04, Xiubo Li wrote:
>
> On 5/17/23 18:31, Ilya Dryomov wrote:
>> On Wed, May 17, 2023 at 7:24 AM <xiubli@redhat.com> wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
>>> request may still contain a list of 'split_realms', and we need
>>> to skip it anyway. Or it will be parsed as a corrupt snaptrace.
>>>
>>> Cc: stable@vger.kernel.org
>>> Cc: Frank Schilder <frans@dtu.dk>
>>> Reported-by: Frank Schilder <frans@dtu.dk>
>>> URL: https://tracker.ceph.com/issues/61200
>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>> ---
>>>   fs/ceph/snap.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>>> index 0e59e95a96d9..d95dfe16b624 100644
>>> --- a/fs/ceph/snap.c
>>> +++ b/fs/ceph/snap.c
>>> @@ -1114,6 +1114,9 @@ void ceph_handle_snap(struct ceph_mds_client 
>>> *mdsc,
>>>                                  continue;
>>>                          adjust_snap_realm_parent(mdsc, child, 
>>> realm->ino);
>>>                  }
>>> +       } else {
>>> +               p += sizeof(u64) * num_split_inos;
>>> +               p += sizeof(u64) * num_split_realms;
>>>          }
>>>
>>>          /*
>>> -- 
>>> 2.40.1
>>>
>> Hi Xiubo,
>>
>> This code appears to be very old -- it goes back to the initial commit
>> 963b61eb041e ("ceph: snapshot management") in 2009.  Do you have an
>> explanation for why this popped up only now?
>
> As I remembered we hit this before in one cu BZ last year, but I 
> couldn't remember exactly which one.  But I am not sure whether @Jeff 
> saw this before I joint ceph team.
>
@Venky,

Do you remember which one ? As I remembered this is why we fixed the 
snaptrace issue by blocking all the IOs and at the same time 
blocklisting the kclient before.

Before the kcleint won't dump the corrupted msg and we don't know what 
was wrong with the msg and also we added code to dump the msg in the 
above fix.

Thanks

- Xiubo

>
>> Has MDS always been including split_inos and split_realms arrays in
>> !CEPH_SNAP_OP_SPLIT case or is this a recent change?  If it's a recent
>> change, I'd argue that this needs to be addressed on the MDS side.
>
> While in MDS side for the _UPDATE op it won't send the 'split_realm' 
> list just before the commit in 2017:
>
> commit 93e7267757508520dfc22cff1ab20558bd4a44d4
> Author: Yan, Zheng <zyan@redhat.com>
> Date:   Fri Jul 21 21:40:46 2017 +0800
>
>     mds: send snap related messages centrally during mds recovery
>
>     sending CEPH_SNAP_OP_SPLIT and CEPH_SNAP_OP_UPDATE messages to
>     clients centrally in MDCache::open_snaprealms()
>
>     Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>
> Before this commit it will only send the 'split_realm' list for the 
> _SPLIT op.
>
>
> The following the snaptrace:
>
> [Wed May 10 16:03:06 2023] header: 00000000: 05 00 00 00 00 00 00 00 
> 00 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023] header: 00000010: 12 03 7f 00 01 00 00 01 
> 00 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023] header: 00000020: 00 00 00 00 02 01 00 00 
> 00 00 00 00 00 01 00 00  ................
> [Wed May 10 16:03:06 2023] header: 00000030: 00 98 0d 60 
> 93                                   ...`.
> [Wed May 10 16:03:06 2023]  front: 00000000: 00 00 00 00 00 00 00 00 
> 00 00 00 00 00 00 00 00  ................ <<== The op is 0, which is 
> 'CEPH_SNAP_OP_UPDATE'
> [Wed May 10 16:03:06 2023]  front: 00000010: 0c 00 00 00 88 00 00 00 
> d1 c0 71 38 00 01 00 00  ..........q8....           <<== The '0c' is 
> the split_realm number
> [Wed May 10 16:03:06 2023]  front: 00000020: 22 c8 71 38 00 01 00 00 
> d7 c7 71 38 00 01 00 00  ".q8......q8....       <<== All the 'q8' are 
> the ino#
> [Wed May 10 16:03:06 2023]  front: 00000030: d9 c7 71 38 00 01 00 00 
> d4 c7 71 38 00 01 00 00  ..q8......q8....
> [Wed May 10 16:03:06 2023]  front: 00000040: f1 c0 71 38 00 01 00 00 
> d4 c0 71 38 00 01 00 00  ..q8......q8....
> [Wed May 10 16:03:06 2023]  front: 00000050: 20 c8 71 38 00 01 00 00 
> 1d c8 71 38 00 01 00 00   .q8......q8....
> [Wed May 10 16:03:06 2023]  front: 00000060: ec c0 71 38 00 01 00 00 
> d6 c0 71 38 00 01 00 00  ..q8......q8....
> [Wed May 10 16:03:06 2023]  front: 00000070: ef c0 71 38 00 01 00 00 
> 6a 11 2d 1a 00 01 00 00  ..q8....j.-.....
> [Wed May 10 16:03:06 2023]  front: 00000080: 01 00 00 00 00 00 00 00 
> 01 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 00000090: ee 01 00 00 00 00 00 00 
> 01 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000a0: 00 00 00 00 00 00 00 00 
> 01 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000b0: 01 09 00 00 00 00 00 00 
> 00 00 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000c0: 01 00 00 00 00 00 00 00 
> 02 09 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000d0: 05 00 00 00 00 00 00 00 
> 01 09 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000e0: ff 08 00 00 00 00 00 00 
> fd 08 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023]  front: 000000f0: fb 08 00 00 00 00 00 00 
> f9 08 00 00 00 00 00 00  ................
> [Wed May 10 16:03:06 2023] footer: 00000000: ca 39 06 07 00 00 00 00 
> 00 00 00 00 42 06 63 61  .9..........B.ca
> [Wed May 10 16:03:06 2023] footer: 00000010: 7b 4b 5d 2d 
> 05                                   {K]-.
>
>
> And if the split_realm number equals to sizeof(ceph_mds_snap_realm) + 
> extra snap buffer size by coincidence, the above 'corrupted' snaptrace 
> will be parsed by kclient too and kclient won't give any warning, but 
> it will corrupted the snaprealm and capsnap info in kclient.
>
>
> Thanks
>
> - Xiubo
>
>
>> Thanks,
>>
>>                  Ilya
>>

