Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D761770661B
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQLGG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjEQLF7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 07:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13083C0A
        for <stable@vger.kernel.org>; Wed, 17 May 2023 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684321497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4D+Si5MsjCbSFxYWlAoakdg577K6cyyeycE4LB5MhY=;
        b=Pq0+ks/ERb4A/pZSK2/XaSNOEUMvqksMzPy4iugA3M+ckCbDMYIg+5aXZhvgewp7rMQ4Pd
        R3ebuOvY+nydoSGRkmTXlnrhFCPx6TWhZIfgbDm9xcX0/mh8VT4Nj+UgrTHj5CiFlYoILh
        JVMGsBAMEMHEKx25xgoOBNc5Tg24u08=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-EqJWbcsgOkm7qpoc8TzAtg-1; Wed, 17 May 2023 07:04:56 -0400
X-MC-Unique: EqJWbcsgOkm7qpoc8TzAtg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1aaf7a766e1so8172575ad.3
        for <stable@vger.kernel.org>; Wed, 17 May 2023 04:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321495; x=1686913495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4D+Si5MsjCbSFxYWlAoakdg577K6cyyeycE4LB5MhY=;
        b=F4BYzF/MHQqwzFPVXdc55UUk8PuCVwW0KrlDq0tNuDc/H85UX0+/jELXSYmJE4FK1B
         BKhJp/GP9JES6SNMbOn4lfWKu2zb0dsZ6SPGndk0ZMVLaS7IiyeYv2+tFhE3/B8Y3Q4R
         Yk8VkeHAkusbf/0wgSofeCGE8jVw7C+le7DAzYwM9woOfkzDRjlgnU7/iWTDKVhlHIp5
         RWzwl/TR2Rq66BJSL5pvmp04UXs1nLJuOcoE7DzflVi4z+12aDJ94ZX/3eJ14Fbl5X4C
         XMD0v/r+iw2oIY6dizAnmY1vybAHDoxsDCpGmjBjsfdqRGYPysh+QCaBkmn9mNARAtg8
         LBaw==
X-Gm-Message-State: AC+VfDwYnoLCIxYU+US/Ue4tidr8pwChNUd8ZpIrUxZZCGT2v3mAQo2H
        Qr/zj+GSZg4Wgi2bjx2gTbfiQc7LsRQzgjkkR1NCqYaiTnboCMtk1qOvxbNAPVk5ODqIseyj60H
        T43Yfxa1LNi7cCKO1
X-Received: by 2002:a17:902:e80b:b0:1aa:ffed:652c with SMTP id u11-20020a170902e80b00b001aaffed652cmr54553711plg.64.1684321494930;
        Wed, 17 May 2023 04:04:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GMgix2tkj9161luYdn5azJnnafpP0SrbcYQqana0eZAd3Qw9Doz685XSvfW0KCPDFXN3Ifg==
X-Received: by 2002:a17:902:e80b:b0:1aa:ffed:652c with SMTP id u11-20020a170902e80b00b001aaffed652cmr54553673plg.64.1684321494462;
        Wed, 17 May 2023 04:04:54 -0700 (PDT)
Received: from [10.72.12.110] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001ac84f87b1dsm17342708plg.155.2023.05.17.04.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 04:04:54 -0700 (PDT)
Message-ID: <b121586f-d628-a8e3-5802-298c1431f0e5@redhat.com>
Date:   Wed, 17 May 2023 19:04:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: force updating the msg pointer in non-split case
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org,
        Frank Schilder <frans@dtu.dk>
References: <20230517052404.99904-1-xiubli@redhat.com>
 <CAOi1vP8e6NrrrV5TLYS-DpkjQN6LhfqkptR5_ue94HcHJV_2ag@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP8e6NrrrV5TLYS-DpkjQN6LhfqkptR5_ue94HcHJV_2ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/17/23 18:31, Ilya Dryomov wrote:
> On Wed, May 17, 2023 at 7:24 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
>> request may still contain a list of 'split_realms', and we need
>> to skip it anyway. Or it will be parsed as a corrupt snaptrace.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Frank Schilder <frans@dtu.dk>
>> Reported-by: Frank Schilder <frans@dtu.dk>
>> URL: https://tracker.ceph.com/issues/61200
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/snap.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>> index 0e59e95a96d9..d95dfe16b624 100644
>> --- a/fs/ceph/snap.c
>> +++ b/fs/ceph/snap.c
>> @@ -1114,6 +1114,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>>                                  continue;
>>                          adjust_snap_realm_parent(mdsc, child, realm->ino);
>>                  }
>> +       } else {
>> +               p += sizeof(u64) * num_split_inos;
>> +               p += sizeof(u64) * num_split_realms;
>>          }
>>
>>          /*
>> --
>> 2.40.1
>>
> Hi Xiubo,
>
> This code appears to be very old -- it goes back to the initial commit
> 963b61eb041e ("ceph: snapshot management") in 2009.  Do you have an
> explanation for why this popped up only now?

As I remembered we hit this before in one cu BZ last year, but I 
couldn't remember exactly which one.  But I am not sure whether @Jeff 
saw this before I joint ceph team.


> Has MDS always been including split_inos and split_realms arrays in
> !CEPH_SNAP_OP_SPLIT case or is this a recent change?  If it's a recent
> change, I'd argue that this needs to be addressed on the MDS side.

While in MDS side for the _UPDATE op it won't send the 'split_realm' 
list just before the commit in 2017:

commit 93e7267757508520dfc22cff1ab20558bd4a44d4
Author: Yan, Zheng <zyan@redhat.com>
Date:   Fri Jul 21 21:40:46 2017 +0800

     mds: send snap related messages centrally during mds recovery

     sending CEPH_SNAP_OP_SPLIT and CEPH_SNAP_OP_UPDATE messages to
     clients centrally in MDCache::open_snaprealms()

     Signed-off-by: "Yan, Zheng" <zyan@redhat.com>

Before this commit it will only send the 'split_realm' list for the 
_SPLIT op.


The following the snaptrace:

[Wed May 10 16:03:06 2023] header: 00000000: 05 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023] header: 00000010: 12 03 7f 00 01 00 00 01 00 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023] header: 00000020: 00 00 00 00 02 01 00 00 00 
00 00 00 00 01 00 00  ................
[Wed May 10 16:03:06 2023] header: 00000030: 00 98 0d 60 
93                                   ...`.
[Wed May 10 16:03:06 2023]  front: 00000000: 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00  ................ <<== The op is 0, which is 
'CEPH_SNAP_OP_UPDATE'
[Wed May 10 16:03:06 2023]  front: 00000010: 0c 00 00 00 88 00 00 00 d1 
c0 71 38 00 01 00 00  ..........q8....           <<== The '0c' is the 
split_realm number
[Wed May 10 16:03:06 2023]  front: 00000020: 22 c8 71 38 00 01 00 00 d7 
c7 71 38 00 01 00 00  ".q8......q8....       <<== All the 'q8' are the ino#
[Wed May 10 16:03:06 2023]  front: 00000030: d9 c7 71 38 00 01 00 00 d4 
c7 71 38 00 01 00 00  ..q8......q8....
[Wed May 10 16:03:06 2023]  front: 00000040: f1 c0 71 38 00 01 00 00 d4 
c0 71 38 00 01 00 00  ..q8......q8....
[Wed May 10 16:03:06 2023]  front: 00000050: 20 c8 71 38 00 01 00 00 1d 
c8 71 38 00 01 00 00   .q8......q8....
[Wed May 10 16:03:06 2023]  front: 00000060: ec c0 71 38 00 01 00 00 d6 
c0 71 38 00 01 00 00  ..q8......q8....
[Wed May 10 16:03:06 2023]  front: 00000070: ef c0 71 38 00 01 00 00 6a 
11 2d 1a 00 01 00 00  ..q8....j.-.....
[Wed May 10 16:03:06 2023]  front: 00000080: 01 00 00 00 00 00 00 00 01 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 00000090: ee 01 00 00 00 00 00 00 01 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000a0: 00 00 00 00 00 00 00 00 01 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000b0: 01 09 00 00 00 00 00 00 00 
00 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000c0: 01 00 00 00 00 00 00 00 02 
09 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000d0: 05 00 00 00 00 00 00 00 01 
09 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000e0: ff 08 00 00 00 00 00 00 fd 
08 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023]  front: 000000f0: fb 08 00 00 00 00 00 00 f9 
08 00 00 00 00 00 00  ................
[Wed May 10 16:03:06 2023] footer: 00000000: ca 39 06 07 00 00 00 00 00 
00 00 00 42 06 63 61  .9..........B.ca
[Wed May 10 16:03:06 2023] footer: 00000010: 7b 4b 5d 2d 
05                                   {K]-.


And if the split_realm number equals to sizeof(ceph_mds_snap_realm) + 
extra snap buffer size by coincidence, the above 'corrupted' snaptrace 
will be parsed by kclient too and kclient won't give any warning, but it 
will corrupted the snaprealm and capsnap info in kclient.


Thanks

- Xiubo


> Thanks,
>
>                  Ilya
>

