Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89175BD33
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGUEWD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGUEWB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B42729
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689913271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbXeweKGaVCtCnjWbK7Zvoz7xcoUnU8dTrJ4wHJXsmM=;
        b=E72X3aLAnQHlrLtIZ2wpErEhQ/r9FgG44rE4LJ/f81sqSjE/NmFaAH+64ZjUDkoZ7RYY9L
        u4eelQqvm7gA392fcIcYSp82gU/kXBIp6vPOdF3f4EFWwZWlCduBiv/4aOdaF2GTupSJQP
        t+Xi5iCIVwSLt8bK2hyd7A0TAyJHCuY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-_EUuae_VNVmyfzBxUMoJDA-1; Fri, 21 Jul 2023 00:21:09 -0400
X-MC-Unique: _EUuae_VNVmyfzBxUMoJDA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-786f4056ac0so79657239f.1
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689913268; x=1690518068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbXeweKGaVCtCnjWbK7Zvoz7xcoUnU8dTrJ4wHJXsmM=;
        b=lBKPlTPuCK9opk1uoezoJ1pzv+yieRzQsHs0SRAtmT5suKcgsWOYEyOj9Dn9+N43mv
         byotYRo18sKnh2LTNMUpXVKsPNA/1I5OY/iSUrzDTwYxHrlHzwy7L8+XZ8hXNvBfYVlI
         XpeXlmO4NKc6JLuoVkzAlRQ/7uw6STkyEmuO/VZtn0TvS6f7hlCaD/jof5RNYACvkqXn
         +XsY0cLcopRJtYqCjuujyVVX8o5iX24pVWNH7qrBQGyoYGuX6aQ7asOhzpipNBCR6j2x
         evrAMSqhBMaIkmoLrIcKUDSW9iAHgKjhNzebk/asjukEXql2N54y9EHgfVM8H80nsEqn
         r/jQ==
X-Gm-Message-State: ABy/qLbCa3oX1bxZH7QJVM7gTyiMkWCTih8jeCCPWHoMRivt1Bc8SoPq
        +wju1eNDzPCryh0w5pQzi0tLdGqVseW9kQCBxGwe9/yqtMcGY4juCplcwbFJFnqaRJASFpVfi+7
        fjOU3+cy7WL8bAbff
X-Received: by 2002:a92:cd87:0:b0:346:63f1:a979 with SMTP id r7-20020a92cd87000000b0034663f1a979mr1091705ilb.30.1689913268282;
        Thu, 20 Jul 2023 21:21:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvH+jg7j3eSDELajZkyGfZiuFaf12HEQaI8hOWaK2pMfTAZcrOasThhNP2BjOAzMleltY2fA==
X-Received: by 2002:a92:cd87:0:b0:346:63f1:a979 with SMTP id r7-20020a92cd87000000b0034663f1a979mr1091699ilb.30.1689913267990;
        Thu, 20 Jul 2023 21:21:07 -0700 (PDT)
Received: from [10.72.12.27] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78495000000b0067886c78745sm1985009pfn.66.2023.07.20.21.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 21:21:07 -0700 (PDT)
Message-ID: <66314c2d-ae3a-35db-9eaa-56848c4deb62@redhat.com>
Date:   Fri, 21 Jul 2023 12:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ceph: defer stopping the mdsc delayed_work
Content-Language: en-US
To:     Milind Changire <mchangir@redhat.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org
References: <20230629033533.270535-1-xiubli@redhat.com>
 <CAED=hWCkMMjina5q1VhygNnkHD+nqLfeNKVp8Oof623K6iEwbw@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAED=hWCkMMjina5q1VhygNnkHD+nqLfeNKVp8Oof623K6iEwbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 7/21/23 11:19, Milind Changire wrote:
> Looks good to me.
>
> nit: typo for perioudically in commit message

Good catch and thanks Milind, I will fix it.

-- Xiubo


> Reviewed-by: Milind Changire <mchangir@redhat.com>
>
>
> On Thu, Jun 29, 2023 at 9:07 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Flushing the dirty buffer may take a long time if the Rados is
>> overloaded or if there is network issue. So we should ping the
>> MDSs perioudically to keep alive, else the MDS will blocklist
>> the kclient.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Venky Shankar <vshankar@redhat.com>
>> URL: https://tracker.ceph.com/issues/61843
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/mds_client.c | 2 +-
>>   fs/ceph/mds_client.h | 3 ++-
>>   fs/ceph/super.c      | 7 ++++---
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 65230ebefd51..70987b3c198a 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -5192,7 +5192,7 @@ static void delayed_work(struct work_struct *work)
>>
>>          doutc(mdsc->fsc->client, "mdsc delayed_work\n");
>>
>> -       if (mdsc->stopping)
>> +       if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
>>                  return;
>>
>>          mutex_lock(&mdsc->mutex);
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index 5d02c8c582fd..befbd384428e 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -400,7 +400,8 @@ struct cap_wait {
>>
>>   enum {
>>          CEPH_MDSC_STOPPING_BEGIN = 1,
>> -       CEPH_MDSC_STOPPING_FLUSHED = 2,
>> +       CEPH_MDSC_STOPPING_FLUSHING = 2,
>> +       CEPH_MDSC_STOPPING_FLUSHED = 3,
>>   };
>>
>>   /*
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index 8e1e517a45db..fb694ba72955 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -1488,7 +1488,7 @@ static int ceph_init_fs_context(struct fs_context *fc)
>>   static bool __inc_stopping_blocker(struct ceph_mds_client *mdsc)
>>   {
>>          spin_lock(&mdsc->stopping_lock);
>> -       if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED) {
>> +       if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHING) {
>>                  spin_unlock(&mdsc->stopping_lock);
>>                  return false;
>>          }
>> @@ -1501,7 +1501,7 @@ static void __dec_stopping_blocker(struct ceph_mds_client *mdsc)
>>   {
>>          spin_lock(&mdsc->stopping_lock);
>>          if (!atomic_dec_return(&mdsc->stopping_blockers) &&
>> -           mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
>> +           mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHING)
>>                  complete_all(&mdsc->stopping_waiter);
>>          spin_unlock(&mdsc->stopping_lock);
>>   }
>> @@ -1562,7 +1562,7 @@ static void ceph_kill_sb(struct super_block *s)
>>          sync_filesystem(s);
>>
>>          spin_lock(&mdsc->stopping_lock);
>> -       mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
>> +       mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHING;
>>          wait = !!atomic_read(&mdsc->stopping_blockers);
>>          spin_unlock(&mdsc->stopping_lock);
>>
>> @@ -1576,6 +1576,7 @@ static void ceph_kill_sb(struct super_block *s)
>>                          pr_warn_client(cl, "umount was killed, %ld\n", timeleft);
>>          }
>>
>> +       mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
>>          kill_anon_super(s);
>>
>>          fsc->client->extra_mon_dispatch = NULL;
>> --
>> 2.40.1
>>
>

