Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3777475F682
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGXMlW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGXMlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 08:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655A1B8
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690202435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXsloDiGpIg8qGR9m9vo1J1SkzXL7p6lXFOemvxFP9Y=;
        b=cgS1Ah7F7idEOQxe7NHqcLNh+DIBhqXkEG5wY1CsJVRwtjjF+7ZLjenX4v4WmXioAbL/Ux
        Zn1Mhlf8RxyCzc7jvS3i3qFRaWeYKE9JWBQqKcS8KNrvepvR03h7qt3da8GlTWLz54z/Su
        Xeie35mtLJlWyIA+z71b/rgr5vc/AEk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Cnep0H_mPZqnhGWQNdYJKw-1; Mon, 24 Jul 2023 08:40:31 -0400
X-MC-Unique: Cnep0H_mPZqnhGWQNdYJKw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c29c5594dso4366927a12.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202430; x=1690807230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXsloDiGpIg8qGR9m9vo1J1SkzXL7p6lXFOemvxFP9Y=;
        b=V5JSUkCPrFNr0G2hDs9TePM//ZYHzcbBHGIldiRIAodMIreQ+Cfiw/gW3xHM/vFnAm
         7jQlTP7oogXSga7yHLbZz1TXUPbIgqkN+TsXh64mVZ/xpFrsB/JidmBsredESoVi75M9
         i9ia9lF1TCYg1nT88RW9IHxWj8e9DWsCUVX7u09501Bl1kX9YbDM1MMvxVRi+wf/o566
         SA6ssYtJx5lwdFnNg6vm1VjxvXXlVmS637WMLaMSPBJG7o5wazPMZDfKNlwgP+RYixsD
         IC6zHKfKxLdjpnNQ7o87mCIkUY5A+uFZ/mT+B+Wyc20mREoJbIxBXYsExzOCNAALe6MJ
         1zGw==
X-Gm-Message-State: ABy/qLbMRpl4f6r2VqQFi87fbpTdjga86vUdKhi2JdWDwX88wOxuKNyS
        vT/Rh5wa+Tfv56XNjr3W70UGa5SYKbDNYSzdsP3nOET2UC1Ni/ZPUfFAyI3nge9b/9f58rvGB8r
        7IC0NtoaGM28oBogw
X-Received: by 2002:a17:902:6b82:b0:1b8:7f95:7ba2 with SMTP id p2-20020a1709026b8200b001b87f957ba2mr10265405plk.42.1690202430765;
        Mon, 24 Jul 2023 05:40:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcqXKheYfAKfo57gFCYKNJojWj2lLEO7K1mFNCrOtch0EkElbw8DiKTbihmJVn9demmMed3w==
X-Received: by 2002:a17:902:6b82:b0:1b8:7f95:7ba2 with SMTP id p2-20020a1709026b8200b001b87f957ba2mr10265388plk.42.1690202430441;
        Mon, 24 Jul 2023 05:40:30 -0700 (PDT)
Received: from [10.72.12.127] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b001b89891bfc4sm8872525plb.199.2023.07.24.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:40:30 -0700 (PDT)
Message-ID: <09e357a7-6a44-2209-88e9-afd28d9a4059@redhat.com>
Date:   Mon, 24 Jul 2023 20:40:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ceph: defer stopping the mdsc delayed_work
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com, stable@vger.kernel.org
References: <20230724084214.321005-1-xiubli@redhat.com>
 <CAOi1vP9Yygpavo8fS=Tz8YGeQJ7Wmieo=14+HS20+MSMErb79A@mail.gmail.com>
 <e28b9ea0-a62c-5aae-50d0-bc092675e20d@redhat.com>
 <CAOi1vP_80f8v_3c9O0O2AW7kB3YCv9TF4rUXjZHFgkXb4ZLZyA@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP_80f8v_3c9O0O2AW7kB3YCv9TF4rUXjZHFgkXb4ZLZyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 7/24/23 20:34, Ilya Dryomov wrote:
> On Mon, Jul 24, 2023 at 2:20 PM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 7/24/23 19:12, Ilya Dryomov wrote:
>>> On Mon, Jul 24, 2023 at 10:44 AM <xiubli@redhat.com> wrote:
>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> Flushing the dirty buffer may take a long time if the Rados is
>>>> overloaded or if there is network issue. So we should ping the
>>>> MDSs periodically to keep alive, else the MDS will blocklist
>>>> the kclient.
>>>>
>>>> Cc: stable@vger.kernel.org
>>> Hi Xiubo,
>>>
>>> The stable tag doesn't make sense here as this commit enhances commit
>>> 2789c08342f7 ("ceph: drop the messages from MDS when unmounting") which
>>> isn't upstream.  It should probably just be folded there.
>> No, Ilya. This is not an enhancement for commit 2789c08342f7.
>>
>> They are for different issues here. This patch just based on that. We
>> can apply this first and then I can rebase the testing branch.
> Ah, thanks for letting me know.  Please go ahead and structure it that
> way in the testing branch.  As it is, it conflicts heavily as the enum
> that it adds a new member to was added in commit 2789c08342f7.

Sure. Thanks


>
>                  Ilya
>

