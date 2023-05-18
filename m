Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213870775B
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjERBTB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 21:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjERBTA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 21:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9A30DC
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684372692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJMCtekTagxpZSJAlsM/vN+8wHjXgxbwk9+1lLcU+wk=;
        b=LJsgvWx0jI3ZX7+ZFj7OEtjJjENK6GbXeJmbv1rv+98aDIgmA2vxG0rAdutv3wU1C0PRuL
        2IH/jXb3llM3dAx53mIcFoR4jb06bjQVW2cngeLGRRlDSYzQGfkcWuQwPk6VSLkTm2WXV/
        ZIvyArKX1NqIRVrEjtAZehJF5awAyqI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-eCot94CMPFGrP46XuEtcZA-1; Wed, 17 May 2023 21:18:11 -0400
X-MC-Unique: eCot94CMPFGrP46XuEtcZA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-643a9203dc2so907377b3a.1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684372690; x=1686964690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJMCtekTagxpZSJAlsM/vN+8wHjXgxbwk9+1lLcU+wk=;
        b=JSUwNjQW+K+44oijo1LTJY/cZwzVqruNwqWy6nFj5c8gcQbGUyi8NJQtyGWimj4PLG
         Xu+yAA0QuN0ghEB3iYi68UF0ZgvrUdA4ket2lC4Ucp8hYvV9CvgWL9EW8AKNhRjfQluK
         eam4bRoHsg7xtNcFcKNmPD23rMbugNVXKAY6htgv+I62Kg/+UcSG0hatiUetTleCuHgY
         UF1U9d/IW6CtRNiNss24NMu0M1CBy1m1BOv6cE5yelarmOtjP0LFzWMdLFMawzMuUcb+
         t7xj0MFCwHK4TVtXAWE5MiIvvYAy8wp2vXrRiR+6ON8xsP3clTefXIOJu2iG9EOPGIvo
         Cy8g==
X-Gm-Message-State: AC+VfDxshk4fERf7jtNWqQRc5V4SOryH/408FMrVm9hk9AfMv4KJSaD2
        fFZak1sWZCWjsZqOtowEXQVU6+AumlUrAmsIqvaPdU8BfCi+i8jN2pfNzI0yQp8oHCOH+TxckZ6
        FG6TO1+r+3AUhmaOL
X-Received: by 2002:a05:6a00:150a:b0:63b:5501:6795 with SMTP id q10-20020a056a00150a00b0063b55016795mr2310799pfu.24.1684372690343;
        Wed, 17 May 2023 18:18:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kj+VN71fThcYgIorw78JdB/oA5Jf3ZyuACWW+b3e3lU4lljylU6OFh/eVtH4mSjv53i8Pxw==
X-Received: by 2002:a05:6a00:150a:b0:63b:5501:6795 with SMTP id q10-20020a056a00150a00b0063b55016795mr2310770pfu.24.1684372690016;
        Wed, 17 May 2023 18:18:10 -0700 (PDT)
Received: from [10.72.12.110] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0063f0068cf6csm122961pfm.198.2023.05.17.18.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 18:18:09 -0700 (PDT)
Message-ID: <530d3444-e76e-c742-d10b-900c6f76714b@redhat.com>
Date:   Thu, 18 May 2023 09:18:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: force updating the msg pointer in non-split case
Content-Language: en-US
To:     Gregory Farnum <gfarnum@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org,
        Frank Schilder <frans@dtu.dk>
References: <20230517052404.99904-1-xiubli@redhat.com>
 <CAOi1vP8e6NrrrV5TLYS-DpkjQN6LhfqkptR5_ue94HcHJV_2ag@mail.gmail.com>
 <b121586f-d628-a8e3-5802-298c1431f0e5@redhat.com>
 <CAOi1vP-vA0WAw6Jb69QDt=43fw8rgS7KvLrvKF5bEqgOS_TzUQ@mail.gmail.com>
 <CAJ4mKGbp3Csdy56hcnHLam6asCv9tMSANL_YzD6pM+NV3eQicA@mail.gmail.com>
 <CAOi1vP90QTPTtTmjRrskX4WEJKcPs52phS0C383eZxHmG4q5zQ@mail.gmail.com>
 <CAJ4mKGZUvrVHsEX-==kD9x_ArSL5FD_k0PDmYT4e6mo_80Ah_g@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAJ4mKGZUvrVHsEX-==kD9x_ArSL5FD_k0PDmYT4e6mo_80Ah_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/17/23 23:03, Gregory Farnum wrote:
> On Wed, May 17, 2023 at 7:27 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>> On Wed, May 17, 2023 at 3:59 PM Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Wed, May 17, 2023 at 4:33 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>>> On Wed, May 17, 2023 at 1:04 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>
>>>>> On 5/17/23 18:31, Ilya Dryomov wrote:
>>>>>> On Wed, May 17, 2023 at 7:24 AM <xiubli@redhat.com> wrote:
>>>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>>>
>>>>>>> When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
>>>>>>> request may still contain a list of 'split_realms', and we need
>>>>>>> to skip it anyway. Or it will be parsed as a corrupt snaptrace.
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Cc: Frank Schilder <frans@dtu.dk>
>>>>>>> Reported-by: Frank Schilder <frans@dtu.dk>
>>>>>>> URL: https://tracker.ceph.com/issues/61200
>>>>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>>>>> ---
>>>>>>>    fs/ceph/snap.c | 3 +++
>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>>>>>>> index 0e59e95a96d9..d95dfe16b624 100644
>>>>>>> --- a/fs/ceph/snap.c
>>>>>>> +++ b/fs/ceph/snap.c
>>>>>>> @@ -1114,6 +1114,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>>>>>>>                                   continue;
>>>>>>>                           adjust_snap_realm_parent(mdsc, child, realm->ino);
>>>>>>>                   }
>>>>>>> +       } else {
>>>>>>> +               p += sizeof(u64) * num_split_inos;
>>>>>>> +               p += sizeof(u64) * num_split_realms;
>>>>>>>           }
>>>>>>>
>>>>>>>           /*
>>>>>>> --
>>>>>>> 2.40.1
>>>>>>>
>>>>>> Hi Xiubo,
>>>>>>
>>>>>> This code appears to be very old -- it goes back to the initial commit
>>>>>> 963b61eb041e ("ceph: snapshot management") in 2009.  Do you have an
>>>>>> explanation for why this popped up only now?
>>>>> As I remembered we hit this before in one cu BZ last year, but I
>>>>> couldn't remember exactly which one.  But I am not sure whether @Jeff
>>>>> saw this before I joint ceph team.
>>>>>
>>>>>
>>>>>> Has MDS always been including split_inos and split_realms arrays in
>>>>>> !CEPH_SNAP_OP_SPLIT case or is this a recent change?  If it's a recent
>>>>>> change, I'd argue that this needs to be addressed on the MDS side.
>>>>> While in MDS side for the _UPDATE op it won't send the 'split_realm'
>>>>> list just before the commit in 2017:
>>>>>
>>>>> commit 93e7267757508520dfc22cff1ab20558bd4a44d4
>>>>> Author: Yan, Zheng <zyan@redhat.com>
>>>>> Date:   Fri Jul 21 21:40:46 2017 +0800
>>>>>
>>>>>       mds: send snap related messages centrally during mds recovery
>>>>>
>>>>>       sending CEPH_SNAP_OP_SPLIT and CEPH_SNAP_OP_UPDATE messages to
>>>>>       clients centrally in MDCache::open_snaprealms()
>>>>>
>>>>>       Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>>>>>
>>>>> Before this commit it will only send the 'split_realm' list for the
>>>>> _SPLIT op.
>>>> It sounds like we have the culprit.  This should be treated as
>>>> a regression and fixed on the MDS side.  I don't see a justification
>>>> for putting useless data on the wire.
>>> I don't really understand this viewpoint. We can treat it as an MDS
>>> regression if we want, but it's a six-year-old patch so this is in
>>> nearly every version of server code anybody's running. Why wouldn't we
>>> fix it on both sides?
>> Well, if I didn't speak up chances are we wouldn't have identified the
>> regression in the MDS at all.  People seem to have this perception that
>> the client is somehow "easier" to fix, assume that the server is always
>> doing the right thing and default to patching the client.  I'm just
>> trying to push back on that.
>>
>> In this particular case, after understanding the scope of the issue
>> _and_ getting a committal for the MDS side fix, I approved taking the
>> kernel client patch in an earlier reply.
>>
>>> On Wed, May 17, 2023 at 4:07 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>> And if the split_realm number equals to sizeof(ceph_mds_snap_realm) +
>>>> extra snap buffer size by coincidence, the above 'corrupted' snaptrace
>>>> will be parsed by kclient too and kclient won't give any warning, but it
>>>> will corrupted the snaprealm and capsnap info in kclient.
>>> I'm a bit confused about this patch, but I also don't follow the
>>> kernel client code much so please forgive my ignorance. The change
>>> you've made is still only invoked inside of the CEPH_SNAP_OP_SPLIT
>>> case, so clearly the kclient *mostly* does the right thing when these
>> No, it's invoked outside: it introduces a "op != CEPH_SNAP_OP_SPLIT"
>> branch.
> Oh I mis-parsed the braces/spacing there.
>
> I'm still not getting how the precise size is causing the problem —
> obviously this isn't an unheard-of category of issue, but the fact
> that it works until the count matches a magic number is odd. Is that
> ceph_decode_need macro being called from ceph_update_snap_trace just
> skipping over the split data somehow? *puzzled*

Yeah, it's called and this is where the corrupted snaptrace reported.

The ceph_update_snap_trace() will try to parse the snaptraces in a loop 
and if there still has extra memories it will try to prase the rest 
memories as a new snaptrace, but the extra memories do not have enough 
memories needed and just reports it as a bad msg.

Thanks

- Xiubo

> -Greg
>
>> Thanks,
>>
>>                  Ilya
>>

