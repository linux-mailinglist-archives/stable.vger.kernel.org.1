Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AE707763
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjERBYW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 21:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42330DC
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684373014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlEfVPMTnJSqwCUOuMXKMM9sJFrXm37BO5CY5YUKY5M=;
        b=WYwq0CeF9nMfzMobrjhdvEzhCPJpl79NaOwKVkVMbZ1N1LglKbwLA0Z1fX+FcyzIrn5qPm
        QLAHN6iGTY+FehKD/Ll3Gyexr+OiHCvnIHczCp1Na/khfRZoe4Rtg4YDuEx9BfiW1sM/L4
        JN+CVQAXnHl6iObRGXVVr8f+81DpAos=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-jSOjm6IsOs6PuTDNL8mTVg-1; Wed, 17 May 2023 21:23:30 -0400
X-MC-Unique: jSOjm6IsOs6PuTDNL8mTVg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ae4a0b5a90so9568155ad.1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684373010; x=1686965010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlEfVPMTnJSqwCUOuMXKMM9sJFrXm37BO5CY5YUKY5M=;
        b=XaQl9DKIyJSNE1bsenda59POUELQN9iYaUl9jlzHNVJsi4t657IKy8YHI1H7YWVR4U
         m1IuaKvZqzTQKhEAC1D3C1YqFpnobMF4tCKSRHdsEqokDi9pChL+u1FpZDiwsKJaOBS1
         EJm9qeBIlLdLTxHO7cmTvXu8FuxHd2B3OIRfmKdxqyxCHHBVpIZBDbuMnqMYye7GHhPB
         ZH9BPsZfjGiMs3ZK7I8TmcgMLX28JmfmHUNI2CSMpzplQGPtfufwvwhMKkybm2QbXggs
         a6FwcU6A7+OTqYbT+rzkNNfL+wZZRFL66OXZ2MmpXlzU/Q3hJUS3FrfWeeNceAil/fV8
         gtfQ==
X-Gm-Message-State: AC+VfDztBVaFg3bxR4a2SdCWYH5DxeuThCv5Y8+RvXVRkz2nllkjZFzt
        8QR+a/USTaZO0+ezeB61Hmjgo39dH0xBoSd3qX7EOtbW9y1KUzI7IwpGpslC+ukwE5n/xIOmr/L
        nUjCDSLlFvHGNILN8
X-Received: by 2002:a17:903:1205:b0:1ab:224b:d1fc with SMTP id l5-20020a170903120500b001ab224bd1fcmr756756plh.41.1684373009730;
        Wed, 17 May 2023 18:23:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44/QsCUtx50aLkHEpGFsu6dSamDeGXxMs8eyuqabqVq0JJAf/TMpAEpY3E+p/THCrvCCVZEA==
X-Received: by 2002:a17:903:1205:b0:1ab:224b:d1fc with SMTP id l5-20020a170903120500b001ab224bd1fcmr756737plh.41.1684373009401;
        Wed, 17 May 2023 18:23:29 -0700 (PDT)
Received: from [10.72.12.110] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001ac84f87b1dsm20958plf.155.2023.05.17.18.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 18:23:29 -0700 (PDT)
Message-ID: <30f2da87-91ec-6a01-e0ec-1556df0ca952@redhat.com>
Date:   Thu, 18 May 2023 09:23:22 +0800
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
 <CAJ4mKGZ8YRyWYry5F8yAGDhpv3X_LkQHj+f9ONXKsrbWSjDVsQ@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAJ4mKGZ8YRyWYry5F8yAGDhpv3X_LkQHj+f9ONXKsrbWSjDVsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/17/23 23:04, Gregory Farnum wrote:
> Just to be clear, I'd like the details here so we can see if there are
> ways to prevent similar issues in the future, which I haven't heard
> anybody talk about. :)

We have hit a similar issue with Venky in 
https://github.com/ceph/ceph/pull/48382. This PR just added two extra 
members and the old kclient couldn't recognize them and also just 
incorrectly parsed them as a new snaptrace.

Venky has fixed it by checking the peer client's feature bit before 
sending the msgs.

Thanks

- Xiubo

> On Wed, May 17, 2023 at 8:03 AM Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Wed, May 17, 2023 at 7:27 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>> On Wed, May 17, 2023 at 3:59 PM Gregory Farnum <gfarnum@redhat.com> wrote:
>>>> On Wed, May 17, 2023 at 4:33 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>>>> On Wed, May 17, 2023 at 1:04 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>>
>>>>>> On 5/17/23 18:31, Ilya Dryomov wrote:
>>>>>>> On Wed, May 17, 2023 at 7:24 AM <xiubli@redhat.com> wrote:
>>>>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>>>>
>>>>>>>> When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
>>>>>>>> request may still contain a list of 'split_realms', and we need
>>>>>>>> to skip it anyway. Or it will be parsed as a corrupt snaptrace.
>>>>>>>>
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> Cc: Frank Schilder <frans@dtu.dk>
>>>>>>>> Reported-by: Frank Schilder <frans@dtu.dk>
>>>>>>>> URL: https://tracker.ceph.com/issues/61200
>>>>>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>>>>>> ---
>>>>>>>>    fs/ceph/snap.c | 3 +++
>>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>>>>>>>> index 0e59e95a96d9..d95dfe16b624 100644
>>>>>>>> --- a/fs/ceph/snap.c
>>>>>>>> +++ b/fs/ceph/snap.c
>>>>>>>> @@ -1114,6 +1114,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>>>>>>>>                                   continue;
>>>>>>>>                           adjust_snap_realm_parent(mdsc, child, realm->ino);
>>>>>>>>                   }
>>>>>>>> +       } else {
>>>>>>>> +               p += sizeof(u64) * num_split_inos;
>>>>>>>> +               p += sizeof(u64) * num_split_realms;
>>>>>>>>           }
>>>>>>>>
>>>>>>>>           /*
>>>>>>>> --
>>>>>>>> 2.40.1
>>>>>>>>
>>>>>>> Hi Xiubo,
>>>>>>>
>>>>>>> This code appears to be very old -- it goes back to the initial commit
>>>>>>> 963b61eb041e ("ceph: snapshot management") in 2009.  Do you have an
>>>>>>> explanation for why this popped up only now?
>>>>>> As I remembered we hit this before in one cu BZ last year, but I
>>>>>> couldn't remember exactly which one.  But I am not sure whether @Jeff
>>>>>> saw this before I joint ceph team.
>>>>>>
>>>>>>
>>>>>>> Has MDS always been including split_inos and split_realms arrays in
>>>>>>> !CEPH_SNAP_OP_SPLIT case or is this a recent change?  If it's a recent
>>>>>>> change, I'd argue that this needs to be addressed on the MDS side.
>>>>>> While in MDS side for the _UPDATE op it won't send the 'split_realm'
>>>>>> list just before the commit in 2017:
>>>>>>
>>>>>> commit 93e7267757508520dfc22cff1ab20558bd4a44d4
>>>>>> Author: Yan, Zheng <zyan@redhat.com>
>>>>>> Date:   Fri Jul 21 21:40:46 2017 +0800
>>>>>>
>>>>>>       mds: send snap related messages centrally during mds recovery
>>>>>>
>>>>>>       sending CEPH_SNAP_OP_SPLIT and CEPH_SNAP_OP_UPDATE messages to
>>>>>>       clients centrally in MDCache::open_snaprealms()
>>>>>>
>>>>>>       Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>>>>>>
>>>>>> Before this commit it will only send the 'split_realm' list for the
>>>>>> _SPLIT op.
>>>>> It sounds like we have the culprit.  This should be treated as
>>>>> a regression and fixed on the MDS side.  I don't see a justification
>>>>> for putting useless data on the wire.
>>>> I don't really understand this viewpoint. We can treat it as an MDS
>>>> regression if we want, but it's a six-year-old patch so this is in
>>>> nearly every version of server code anybody's running. Why wouldn't we
>>>> fix it on both sides?
>>> Well, if I didn't speak up chances are we wouldn't have identified the
>>> regression in the MDS at all.  People seem to have this perception that
>>> the client is somehow "easier" to fix, assume that the server is always
>>> doing the right thing and default to patching the client.  I'm just
>>> trying to push back on that.
>>>
>>> In this particular case, after understanding the scope of the issue
>>> _and_ getting a committal for the MDS side fix, I approved taking the
>>> kernel client patch in an earlier reply.
>>>
>>>> On Wed, May 17, 2023 at 4:07 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>> And if the split_realm number equals to sizeof(ceph_mds_snap_realm) +
>>>>> extra snap buffer size by coincidence, the above 'corrupted' snaptrace
>>>>> will be parsed by kclient too and kclient won't give any warning, but it
>>>>> will corrupted the snaprealm and capsnap info in kclient.
>>>> I'm a bit confused about this patch, but I also don't follow the
>>>> kernel client code much so please forgive my ignorance. The change
>>>> you've made is still only invoked inside of the CEPH_SNAP_OP_SPLIT
>>>> case, so clearly the kclient *mostly* does the right thing when these
>>> No, it's invoked outside: it introduces a "op != CEPH_SNAP_OP_SPLIT"
>>> branch.
>> Oh I mis-parsed the braces/spacing there.
>>
>> I'm still not getting how the precise size is causing the problem —
>> obviously this isn't an unheard-of category of issue, but the fact
>> that it works until the count matches a magic number is odd. Is that
>> ceph_decode_need macro being called from ceph_update_snap_trace just
>> skipping over the split data somehow? *puzzled*
>> -Greg
>>
>>> Thanks,
>>>
>>>                  Ilya
>>>

