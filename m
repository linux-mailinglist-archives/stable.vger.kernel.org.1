Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8652717E1D
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjEaLeg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEaLef (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 07:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD5E5
        for <stable@vger.kernel.org>; Wed, 31 May 2023 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685532828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9GZuXsplbme6n3tADlHnXuKUp6TigV0Y53u9+GM6J0=;
        b=LLLRE0JOehFATzJjbm+1Om641rif4s/FDw7PsIu97Xsml+SxA+Onn/UUPhfp9r6VvC4Ik6
        oeiPCNr5otkFLdqBdvBbs4jWT3YjZvFTdrMmx970GQz+stX1ruD8b1cbES/MLZNTau1UMD
        XffcG151lBrUG4d1a2GAnR8gYfrI5i8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-E6LOlPpAND2GDqyRk4KXUw-1; Wed, 31 May 2023 07:33:46 -0400
X-MC-Unique: E6LOlPpAND2GDqyRk4KXUw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-256258bea56so3023868a91.0
        for <stable@vger.kernel.org>; Wed, 31 May 2023 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685532826; x=1688124826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9GZuXsplbme6n3tADlHnXuKUp6TigV0Y53u9+GM6J0=;
        b=anizI2kQkCrBMTTizu4qTItCJCtjE0hnWf3PZpuC9d0NzhYJAky9hyME15Er8TxL3N
         ORn4k/4KevsKnLqnMxmm7BpflM5VN6oRs4+P1YVEkGBYyYcjRB74DAj98nJ94sckYniM
         r5lkFVU3vuDIJgkaBPoa/F2/NOuPsNwkQhi2EMbeuhrGnEmxxXfBLD3DeX9LAl8s8um3
         KuPXigun3RDLIANKSNTTu0ZdFR/KSnr68WqFlFYsTZMFsHNWj4rcr7n/wgr6D1kthdIp
         r8vtHTwi26JP55cTJIlCbX5QiCO9Q6xFSmSUZbbF/wR3J9WAdINuBoyyTKVREFATAmZi
         PyEw==
X-Gm-Message-State: AC+VfDzImOOsBsD3wks+ZRRE5vl0nmJ81Rx9Fb4GBRpya3ZVdS7yxRov
        PsFyCQmD2h51zZ2mr9N9LE3/V1X6rJb6cQQ3oAXbgw48EaquyCFnfu70tsru2x5qS1mTUCIra2R
        gHd9kq086AFc3vy6Y
X-Received: by 2002:a05:6a20:7f9f:b0:111:1bd6:2731 with SMTP id d31-20020a056a207f9f00b001111bd62731mr5888858pzj.7.1685532825959;
        Wed, 31 May 2023 04:33:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bpdmLCdVmjbVMXNCrz5tMIKJvZ7MKY6xYmXkjhtzi3QjcttcCdh3In6HcCJy3slhkV2pjgw==
X-Received: by 2002:a05:6a20:7f9f:b0:111:1bd6:2731 with SMTP id d31-20020a056a207f9f00b001111bd62731mr5888843pzj.7.1685532825613;
        Wed, 31 May 2023 04:33:45 -0700 (PDT)
Received: from [10.72.12.188] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001ab2592ed33sm1136029plh.171.2023.05.31.04.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 04:33:45 -0700 (PDT)
Message-ID: <5e82e988-fa03-c580-dc53-0ffdbbc944f5@redhat.com>
Date:   Wed, 31 May 2023 19:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: fix use-after-free bug for inodes when flushing
 capsnaps
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org
References: <20230525024438.507082-1-xiubli@redhat.com>
 <CAOi1vP8aR=fnbUnpOSJ1yA6Je5c4tS3Ks4xMb10dymYv+y2EgQ@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP8aR=fnbUnpOSJ1yA6Je5c4tS3Ks4xMb10dymYv+y2EgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/31/23 19:09, Ilya Dryomov wrote:
> On Thu, May 25, 2023 at 4:45 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> There is racy between capsnaps flush and removing the inode from
>> 'mdsc->snap_flush_list' list:
>>
>>     Thread A                            Thread B
>> ceph_queue_cap_snap()
>>   -> allocate 'capsnapA'
>>   ->ihold('&ci->vfs_inode')
>>   ->add 'capsnapA' to 'ci->i_cap_snaps'
>>   ->add 'ci' to 'mdsc->snap_flush_list'
>>      ...
>> ceph_flush_snaps()
>>   ->__ceph_flush_snaps()
>>    ->__send_flush_snap()
>>                                  handle_cap_flushsnap_ack()
>>                                   ->iput('&ci->vfs_inode')
>>                                     this also will release 'ci'
>>                                      ...
>>                                  ceph_handle_snap()
>>                                   ->flush_snaps()
>>                                    ->iterate 'mdsc->snap_flush_list'
>>                                     ->get the stale 'ci'
>>   ->remove 'ci' from                ->ihold(&ci->vfs_inode) this
>>     'mdsc->snap_flush_list'           will WARNING
>>
>> To fix this we will remove the 'ci' from 'mdsc->snap_flush_list'
>> list just before '__send_flush_snaps()' to make sure the flushsnap
>> 'ack' will always after removing the 'ci' from 'snap_flush_list'.
> Hi Xiubo,
>
> I'm not sure I'm following the logic here.  If the issue is that the
> inode can be released by handle_cap_flushsnap_ack(), meaning that ci is
> unsafe to dereference after the ack is received, what makes e.g. the
> following snippet in __ceph_flush_snaps() work:
>
>      ret = __send_flush_snap(inode, session, capsnap, cap->mseq,
>                              oldest_flush_tid);
>      if (ret < 0) {
>              pr_err("__flush_snaps: error sending cap flushsnap, "
>                     "ino (%llx.%llx) tid %llu follows %llu\n",
>                      ceph_vinop(inode), cf->tid, capsnap->follows);
>      }
>
>      ceph_put_cap_snap(capsnap);
>      spin_lock(&ci->i_ceph_lock);
>
> If the ack is handled after capsnap is put but before ci->i_ceph_lock
> is reacquired, could use-after-free occur inside spin_lock()?

Yeah, certainly this could happen.

After the 'ci' being freed it's possible that the 'ci' is still cached 
in the 'ceph_inode_cachep' slab caches or reused by others, so 
dereferring the 'ci' mostly won't crash. But just before freeing 'ci' 
the 'ci->vfs_inode.i_count' will always be 0 already, this is why we can 
see the 'WARN_ON(atomic_inc_return(&inode->i_count) < 2)' call trace 
much easier in use-after-free case.

Thanks

- Xiubo

> Thanks,
>
>                  Ilya
>
>> Cc: stable@vger.kernel.org
>> URL: https://bugzilla.redhat.com/show_bug.cgi?id=2209299
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/caps.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index feabf4cc0c4f..a8f890b3bb9a 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -1595,6 +1595,11 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
>>
>>          dout("__flush_snaps %p session %p\n", inode, session);
>>
>> +       /* we will flush them all; remove this inode from the queue */
>> +       spin_lock(&mdsc->snap_flush_lock);
>> +       list_del_init(&ci->i_snap_flush_item);
>> +       spin_unlock(&mdsc->snap_flush_lock);
>> +
>>          list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
>>                  /*
>>                   * we need to wait for sync writes to complete and for dirty
>> @@ -1726,10 +1731,6 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
>>                  *psession = session;
>>          else
>>                  ceph_put_mds_session(session);
>> -       /* we flushed them all; remove this inode from the queue */
>> -       spin_lock(&mdsc->snap_flush_lock);
>> -       list_del_init(&ci->i_snap_flush_item);
>> -       spin_unlock(&mdsc->snap_flush_lock);
>>   }
>>
>>   /*
>> --
>> 2.40.1
>>

