Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8366FA10D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEHHbX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 03:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjEHHbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 03:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860A30FC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 00:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683531035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15IZ3rCtajFgVKWwexbLZL0utwlWzVUecmF4CtNVjxc=;
        b=RhA5VILn+m06GNweWRvx8MH9kh/Z+knbkVkeSBVKizh/wQa/kLt4U53E7JcHojxhdMJSlw
        pmGm97WNAY3EYsSzwm8Z2UF2ftY6Mpwnn/579TbZE6MTx04NKuiLQhpuB+i/MmJL2Yh90A
        J3RcMI9Y6bQ0qa5kyfmIV6+TiXhOgyI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484--tVSLQFwNYS2QWZ5k3kxfw-1; Mon, 08 May 2023 03:30:33 -0400
X-MC-Unique: -tVSLQFwNYS2QWZ5k3kxfw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6435b907f46so2314476b3a.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 00:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531032; x=1686123032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15IZ3rCtajFgVKWwexbLZL0utwlWzVUecmF4CtNVjxc=;
        b=QFai+P4q1uEbZeoBHS9spH2VKHzsI/YxrW3vGh552Wtb+C8NznwjLN+lunpnE24w6T
         hoVssUPeIRNkorEFNySxLj9D2UMCX2yuP0ylqx/nXg6ZpfsCrlc90IJgP1/Bg5ULNgxk
         gSN+oaVgp2BMIvugO7UTZeMj61R8rjAAs8akYcmeM+qYPoKQe9geQtFCJwQjPp3sgqnT
         Tq/lL6uIT63QaFsv00Dg3eaYp+eGM6vvcEx1HOyTYob9A4Y1Q2fdgiqvfNhWrZky5D+4
         NpoIrujCZLrOjHtgtAPbYveLK1MH4435431js1w9yE+J9s5mjCT8CmGx2SdQUOe1L18N
         JyIg==
X-Gm-Message-State: AC+VfDz/8T1ncmgG/SpIU/YDKUFdTZjFjymK2ndmRevQG3vzoSf+ReSs
        nd7VnIfXXlGgFADaSIhC5svDKxN8V6FEN6JlxgsDiQtYRPZlan8C2j1dUDdmKz0WuzXCsCMaNnO
        a3YKfCZ96T46LkxRWHowT0lb2LzA=
X-Received: by 2002:a05:6a00:88f:b0:644:ad29:fd37 with SMTP id q15-20020a056a00088f00b00644ad29fd37mr5941886pfj.28.1683531032401;
        Mon, 08 May 2023 00:30:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QGZuUlJ3qCljhw9rVxaHMWwdKhqk7pbQD45W0ZZO4JpdCYUgl445clyi6/LGEm5uUkJEjcQ==
X-Received: by 2002:a05:6a00:88f:b0:644:ad29:fd37 with SMTP id q15-20020a056a00088f00b00644ad29fd37mr5941867pfj.28.1683531032100;
        Mon, 08 May 2023 00:30:32 -0700 (PDT)
Received: from [10.72.12.156] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x13-20020aa784cd000000b0063b6cccd5dcsm5371185pfn.194.2023.05.08.00.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:30:31 -0700 (PDT)
Message-ID: <b8938951-3737-6509-6cb5-547c84b12416@redhat.com>
Date:   Mon, 8 May 2023 15:30:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: fix the Smatch static checker warning in
 reconnect_caps_cb()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        stable@vger.kernel.org
References: <20230508065335.114409-1-xiubli@redhat.com>
 <83208f55-7c60-48a1-bbe2-5973e1f46a09@kili.mountain>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <83208f55-7c60-48a1-bbe2-5973e1f46a09@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/8/23 15:20, Dan Carpenter wrote:
> On Mon, May 08, 2023 at 02:53:35PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Smatch static checker warning:
>>
>>    fs/ceph/mds_client.c:3968 reconnect_caps_cb()
>>    warn: missing error code here? '__get_cap_for_mds()' failed. 'err' = '0'
>>
>> Cc: stable@vger.kernel.org
>> Fixes: aaf67de78807 ("ceph: fix potential use-after-free bug when trimming caps")
> Of course, thanks for the patch. But this is not really a bug fix since
> it doesn't change runtime at all.  And definitely no need to CC stable.

The previous patch Cced the stable, so I just added it here.

If that not necessary I will remove it.

Thanks

- Xiubo

> regards,
> dan carpenter
>

