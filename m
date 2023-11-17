Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E507EEBE8
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 06:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjKQFUU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 00:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQFUT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 00:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE70127
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700198414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LgR+1cpINHMU5YnbgiAgsP+TUg2NFdn1atrpXyM33I=;
        b=Ucnd8+G/fUXtP6A7pye5OYF4BpIzZPh/UMZ4yYD99RSGz5miGPB+eMxXoNqdVKWhbubidc
        JRI+EMOanAkY8SHMOWRoO+PtWdQvGhcba4QV2So/pfGfivVvbgtKqh5NvBb7WaQaUwf5Mv
        JzmneJW7UuJamSB50Uo11W/F9Q0D8yM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-2MMLC0HvOoqJJkIy3wi9Ew-1; Fri, 17 Nov 2023 00:20:12 -0500
X-MC-Unique: 2MMLC0HvOoqJJkIy3wi9Ew-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5c87663a873so1357557b3.2
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 21:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700198412; x=1700803212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LgR+1cpINHMU5YnbgiAgsP+TUg2NFdn1atrpXyM33I=;
        b=HaXbgt3sNQ5ueMlOLjx+Ead+S1a0i5VZeAj/CLdZirM/unI5TDyGjPSqua7CEgIKj+
         UlfcYC0mRc7wGf4d122YOZMb5n/c5gHdvAmHCviOeYuewL/70R+h9crXFbK3iVBqSYR7
         tgaX9k/OhwAer+LenWM+C58mKMCcJi6M05Trufwpg0UOQqBiI2N8libxprLVRnC9q0nN
         JKwbebfKYaLM7OPHyHow1BjQMZnh2xSyEoD/BM1e9DN7tQA1TRbQQmhD4if6EqMcNTNy
         sF9dic50G0KOD2todpqVjqhypAuFRUB+KQyQ3C0A2BM0O0R0KuyCTQkjuJ/SkZuoFhd4
         3mvQ==
X-Gm-Message-State: AOJu0YzqhfmWPtbSkS9klN4f+3ywna2JphByfAl8GxHoPaxG+7Q4T2ue
        rlXDHEmwRjBEXvrZpZ+mzW0giHY+BJET7z8PTMYzf9sCwioNeNLrqE+zDdnhqiJgEoYhb9459+m
        aI0DHyptq4bnshexu
X-Received: by 2002:a81:7189:0:b0:5a7:c8f3:de4b with SMTP id m131-20020a817189000000b005a7c8f3de4bmr18598120ywc.8.1700198412153;
        Thu, 16 Nov 2023 21:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHlcZR7k6zOOCIPc4berrh6szs/JyiHPzFXnrY1X85pv3TcZ1b9h6YwlKaJN5rKt8bt5X81Q==
X-Received: by 2002:a81:7189:0:b0:5a7:c8f3:de4b with SMTP id m131-20020a817189000000b005a7c8f3de4bmr18598101ywc.8.1700198411887;
        Thu, 16 Nov 2023 21:20:11 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fj36-20020a056a003a2400b006c4d1bb81d6sm618246pfb.67.2023.11.16.21.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 21:20:11 -0800 (PST)
Message-ID: <539fee36-cbd2-bb9b-b983-130a60bd0171@redhat.com>
Date:   Fri, 17 Nov 2023 13:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: fix deadlock or deadcode of misusing dget()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com, stable@vger.kernel.org
References: <20231117031951.710177-1-xiubli@redhat.com>
 <20231117044546.GC1957730@ZenIV>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231117044546.GC1957730@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 11/17/23 12:45, Al Viro wrote:
> On Fri, Nov 17, 2023 at 11:19:51AM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The lock order is incorrect between denty and its parent, we should
>> always make sure that the parent get the lock first.
>>
>> Switch to use the 'dget_parent()' to get the parent dentry and also
>> keep holding the parent until the corresponding inode is not being
>> refereenced.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>> URL: https://www.spinics.net/lists/ceph-devel/msg58622.html
>> Fixes: adf0d68701c7 ("ceph: fix unsafe dcache access in ceph_encode_dentry_release")
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> +	if (!dir) {
>> +		parent = dget_parent(dentry);
>> +		dir = d_inode(parent);
>> +	}
> It's never actually called with dir == NULL.  Not since 2016.
>
> All you need is this, _maybe_ with BUG_ON(!dir); added in the beginning of the function.
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 2c0b8dc3dd0d..22d6ea97938f 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4887,7 +4887,6 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
>   			       struct inode *dir,
>   			       int mds, int drop, int unless)
>   {
> -	struct dentry *parent = NULL;
>   	struct ceph_mds_request_release *rel = *p;
>   	struct ceph_dentry_info *di = ceph_dentry(dentry);
>   	struct ceph_client *cl;
> @@ -4903,14 +4902,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
>   	spin_lock(&dentry->d_lock);
>   	if (di->lease_session && di->lease_session->s_mds == mds)
>   		force = 1;
> -	if (!dir) {
> -		parent = dget(dentry->d_parent);
> -		dir = d_inode(parent);
> -	}
>   	spin_unlock(&dentry->d_lock);
>   
>   	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
> -	dput(parent);
>   
>   	cl = ceph_inode_to_client(dir);
>   	spin_lock(&dentry->d_lock);

Yeah, you are right.

Will update it.

Thanks

- Xiubo


