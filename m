Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1256FF2E2
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjEKNck (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEKNcF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 09:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3EFDC7E
        for <stable@vger.kernel.org>; Thu, 11 May 2023 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683811870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNjSXYigSjFKy+QUeKCUEASx47pCMdyUi/tX4R1i/fw=;
        b=cwgFq8N8ee7zoxigcCVWoU6Cvrgyk0OTRm0acYZaE3CXTkVNB5zSldidznSIPn/G7otrc+
        zGTuK/QoD4FOSDavNcV7XIHVl4EgJSLvSjDnw+6D9d3AEGMZFEJVwxpdRim3ucJ2bsjGau
        s1teMiKKYClB1yxR6tRFkT1Y8KhXBzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-AWM4SUyBPAquAMK2tzhs1A-1; Thu, 11 May 2023 09:31:08 -0400
X-MC-Unique: AWM4SUyBPAquAMK2tzhs1A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4ef4bf00dso2334035e9.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 06:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683811867; x=1686403867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNjSXYigSjFKy+QUeKCUEASx47pCMdyUi/tX4R1i/fw=;
        b=W/x5Qa25mQjBQkffAvAH7d8XY8zPG30VIBK2kYOfVXpnLa2FBfLwsI8h7oGw4LEXwX
         xSaQrgxGYN5XeZmZbbzbigmrVl7Se7Zd0NlzmO8DlRm+XJCVbTckStg1tZumokzNGwoQ
         U7XVnfZhn0joWxkBmlp0IuOuwljaMoD19tku3EicmLXJCJC2uoxl+cQVjADicZLGQGtC
         zynGlObqGzvflxxeXVfuAdjBj3s7mvFIwUS8HhdpoZkwRmVf6h1LVzCovsB4khDaBykS
         73BG8tZz4Bi6OV5CqSukDg/I2FbxI7jrYZ/53bA+py32EvIK9NgdS1u/LKgRD5x6oU0G
         7R2A==
X-Gm-Message-State: AC+VfDzVxlWa7YQKPzV2B74CJczDDuzBH/NwUnSpGkNfv8x27yDAnrMi
        y91+mutQXEnGmAQIR1pS7gaT+6EPLnfQA8RcUJrsMAsN9KoPzyFr3tEsoZIXbkAnMPIrWumFAUe
        mVF3dc4uXbqxBgCPl
X-Received: by 2002:a1c:f715:0:b0:3f1:661e:4686 with SMTP id v21-20020a1cf715000000b003f1661e4686mr16029363wmh.7.1683811867017;
        Thu, 11 May 2023 06:31:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7L9to6DXGbiJOc7XWLzmBnCCDcfKe7PVBm5u+458DsvZQv52Cv7TLitHiLYrOTKBgMtsdHNg==
X-Received: by 2002:a1c:f715:0:b0:3f1:661e:4686 with SMTP id v21-20020a1cf715000000b003f1661e4686mr16029337wmh.7.1683811866731;
        Thu, 11 May 2023 06:31:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc014000000b003ef64affec7sm25670321wmb.22.2023.05.11.06.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 06:31:06 -0700 (PDT)
Message-ID: <761364fc-7e21-581d-4fd4-d81cd27bd4b1@redhat.com>
Date:   Thu, 11 May 2023 15:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] drm/mgag200: Fix gamma lut not initialized.
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        javierm@redhat.com, lyude@redhat.com
Cc:     stable@vger.kernel.org, Phil Oester <kernel@linuxace.com>
References: <20230510131034.284078-1-jfalempe@redhat.com>
 <3cdf3215-99ac-5000-1911-28639c4e6248@suse.de>
Content-Language: en-US
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3cdf3215-99ac-5000-1911-28639c4e6248@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/05/2023 14:26, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.05.23 um 15:10 schrieb Jocelyn Falempe:
>> When mgag200 switched from simple KMS to regular atomic helpers,
>> the initialization of the gamma settings was lost.
>> This leads to a black screen, if the bios/uefi doesn't use the same
>> pixel color depth.
>>
>> v2: rebase on top of drm-misc-fixes, and add Cc stable tag.
> 
> Looks good. Please add the patch to drm-misc-fixes.
Applied to drm-misc-fixes

Thanks

-- 

Jocelyn
> 
> Best regards
> Thomas
> 
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2171155
>> Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular 
>> atomic helpers")
>> Cc: <stable@vger.kernel.org>
>> Tested-by: Phil Oester <kernel@linuxace.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c 
>> b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> index 0a5aaf78172a..576c4c838a33 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -640,6 +640,11 @@ void mgag200_crtc_helper_atomic_enable(struct 
>> drm_crtc *crtc, struct drm_atomic_
>>       if (funcs->pixpllc_atomic_update)
>>           funcs->pixpllc_atomic_update(crtc, old_state);
>> +    if (crtc_state->gamma_lut)
>> +        mgag200_crtc_set_gamma(mdev, format, 
>> crtc_state->gamma_lut->data);
>> +    else
>> +        mgag200_crtc_set_gamma_linear(mdev, format);
>> +
>>       mgag200_enable_display(mdev);
>>       if (funcs->enable_vidrst)
>>
>> base-commit: a26cc2934331b57b5a7164bff344f0a2ec245fc0
> 

