Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413C6FDAC3
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJJaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjEJJaR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 05:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF123A88
        for <stable@vger.kernel.org>; Wed, 10 May 2023 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683710973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cismO5gcoL07rHvXzj2jjNiv1+1GOYd4Bvca5n96tH4=;
        b=LDMlMs+mQIGkya4O5YMTDKulb2MsOj2vh+9ywXreiJ/UEKVuLL0HsrQq9cC19OKkyPQO4U
        n2251SeO+jw3UJuDzIeJbgQsU1jl800qJ8aKokQ1PtHitOlYzP6RjARNqI5RNR65Biq4lT
        up6TurwGHWx55MdvP7xbdBoECMLIKqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-EZ4Gh0OBNF-M0G6ZByKgwQ-1; Wed, 10 May 2023 05:29:32 -0400
X-MC-Unique: EZ4Gh0OBNF-M0G6ZByKgwQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f429072212so10329695e9.1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 02:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683710971; x=1686302971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cismO5gcoL07rHvXzj2jjNiv1+1GOYd4Bvca5n96tH4=;
        b=Xo9MFRyGyuahsTpSkyl44igwGzP87v6w4YEcIRUq+EbwhzCgE+qW1JzrT8ERebm8mM
         0GYzS9HtPNcxP9zSVKizwJg11ZARuDaoIgBUZlzVQ/KEJtcIcW+/iinJ3pLnng8jQHq4
         846hmBd5ATvNHJyfOsPmkyoP55QFEnw4+FYgMXTl1U00AhByQmaBtlavyUmh8feZazdf
         SYK2yzCCd7rfF0r605HHNo00hv30Yd1Hy0P3zt5gDpp/F7yRsiLc30nf4Um8U7Cmdcul
         TMzGLzN//6EpsCKrvTt0j3Y45J6vTafmHHLp/kmUXGZMlRkzUYS6ZqW1i4fSOOOo1Xad
         PJrw==
X-Gm-Message-State: AC+VfDzKgok7Zy5Fkdvw9EUnNm/60Xoper5QSuPwUrwJAYnWGGWKGGrP
        RTYxfxYJ681N5Hnkot8OmkBrfUdJ1+vKsgrBHuit2gfXxe/NE2/A9e+tiHePxXhAYisinTWNuD9
        hAZR6ineGHnmJQGmT
X-Received: by 2002:a05:600c:22d8:b0:3f4:2805:c3a with SMTP id 24-20020a05600c22d800b003f428050c3amr5442294wmg.21.1683710970855;
        Wed, 10 May 2023 02:29:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57fjpPdjECjuDtIgxYVX6FkLTJshIH/D+lPxF2ej3tBCGB9xuDov3RkI+U0DR5LbpceVDVzA==
X-Received: by 2002:a05:600c:22d8:b0:3f4:2805:c3a with SMTP id 24-20020a05600c22d800b003f428050c3amr5442281wmg.21.1683710970518;
        Wed, 10 May 2023 02:29:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id u24-20020a7bc058000000b003f173987ec2sm22282453wmc.22.2023.05.10.02.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 02:29:30 -0700 (PDT)
Message-ID: <b719c37e-a0ff-b337-1d9f-51e3964dbe81@redhat.com>
Date:   Wed, 10 May 2023 11:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized.
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        javierm@redhat.com, lyude@redhat.com
Cc:     Phil Oester <kernel@linuxace.com>, stable@vger.kernel.org
References: <20230510085451.226546-1-jfalempe@redhat.com>
 <3efea3e4-09e2-a9f6-a4a2-365b48b1e63b@suse.de>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3efea3e4-09e2-a9f6-a4a2-365b48b1e63b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/05/2023 11:15, Thomas Zimmermann wrote:
> Hi,
> 
> oh great! Thank you for fixing this bug. And sorry that I broke it.
> 
> Am 10.05.23 um 10:54 schrieb Jocelyn Falempe:
>> When mgag200 switched from simple KMS to regular atomic helpers,
>> the initialization of the gamma settings was lost.
>> This leads to a black screen, if the bios/uefi doesn't use the same
>> pixel color depth.
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2171155
>> Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular 
>> atomic helpers")
>> Tested-by: Phil Oester <kernel@linuxace.com>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Also needs:
> 
> Cc: <stable@vger.kernel.org> # v6.1+

Should I send a v2 with this added ?
> 
> In terms of what it does:
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> but the patch is apparently for against an old version. (v6.1?) The code 
> in mgag200_crtc_helper_atomic_enable has changed quite a bit.

Yes, I based it on the culprit commit 1baf9127c482, but it applies 
cleanly with git am -3 on top of v6.3

> 
> Best regards
> Thomas
> 
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c 
>> b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> index 461da1409fdf..911d46741e40 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -819,6 +819,11 @@ static void 
>> mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>>       else if (mdev->type == G200_EV)
>>           mgag200_g200ev_set_hiprilvl(mdev);
>> +    if (crtc_state->gamma_lut)
>> +        mgag200_crtc_set_gamma(mdev, format, 
>> crtc_state->gamma_lut->data);
>> +    else
>> +        mgag200_crtc_set_gamma_linear(mdev, format);
>> +
>>       mgag200_enable_display(mdev);
>>       if (mdev->type == G200_WB || mdev->type == G200_EW3)
>>
>> base-commit: 1baf9127c482a3a58aef81d92ae751798e2db202
> 

-- 

Jocelyn

