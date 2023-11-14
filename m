Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2E7EAC2E
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKNI4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 03:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjKNI4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 03:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68690198
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 00:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699952158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2eptL0/hRZAJ5UVmQrsn8paC3yYwq6Vrl06QgAw1qU=;
        b=P820N7b/ffULunS0DhYiwscCj6WdLma7Ma8bCfkBFqjA0kO5oTeVd0HXZeEq1J+D2lt/6v
        gsUgmZ5Wgc4IZJ0MQ50uBDK6lcqHnMy7FfAA27UH/61b0e8T9Q27A9+ZflZSeSusAgYGRC
        Ur70eDdMvCJ5EsvmFV+foLb7xxNXdDE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-E60Ihx4bPJuP0jmerF99KA-1; Tue, 14 Nov 2023 03:55:56 -0500
X-MC-Unique: E60Ihx4bPJuP0jmerF99KA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408534c3ec7so35210415e9.1
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 00:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952155; x=1700556955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2eptL0/hRZAJ5UVmQrsn8paC3yYwq6Vrl06QgAw1qU=;
        b=XGDQ8gJ3rOVITst8574m8jerO7U0vPuAhN+u1cBxRinxns4WwZHgY5EJoobXOWKcoB
         c5kGfyf4+/cGTNNVC8YrZ1PRDJLBxns0izEDgAfTUSGD/bjYaQH85UsTNQnIzBzZ8GoG
         GDqI9SflH4rCeEFfwKPlcpRYeyj/ikU/bufj4VL3e1Lt/R6EHpg+Y+9Rz0Ygdj6rkyeI
         TLeUJ+zcwYdRDcEh9VhurJH/SvNfSZsHBBe25tcHmaYZLgEYGi0FWvlcIo//dH3n5Rx+
         lICgZzG4wEnJBB5U2cFV4drxd3sER/fN7/7xnWJbt0OpnsL9Amee7P8otXpMnGiEv1W3
         K65w==
X-Gm-Message-State: AOJu0YwnGiHLjGU67DtGj93MvTmbX0pI1z48sSIhtb70nQwLGzS/FCoz
        d0LrruXzL72MqtTa3WbJEqOPuUCHssig0yHeXw2Mc49yXfkQTEN8fOYj7SwlAIhmtc7fOnBWNuX
        AMzN4sKEw+9DCON4S
X-Received: by 2002:a05:600c:4689:b0:406:53f1:d629 with SMTP id p9-20020a05600c468900b0040653f1d629mr7066885wmo.5.1699952155646;
        Tue, 14 Nov 2023 00:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwmxzArCE1yT7c6VWtUi4CeGvspYKMMRsTRuOyn603I9zaKES8gBzQS1aSNYvHBK4R3G7DMw==
X-Received: by 2002:a05:600c:4689:b0:406:53f1:d629 with SMTP id p9-20020a05600c468900b0040653f1d629mr7066871wmo.5.1699952155285;
        Tue, 14 Nov 2023 00:55:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003fe1fe56202sm10557897wma.33.2023.11.14.00.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 00:55:54 -0800 (PST)
Message-ID: <bafd23a9-81d4-4d3b-9fd3-10461cba6b89@redhat.com>
Date:   Tue, 14 Nov 2023 09:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete stable drm/ast backport - screen freeze on boot
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Keno Fischer <keno@juliahub.com>, stable@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
References: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
 <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>
 <9dc39636-ff41-44d7-96cb-f954008bfc9d@suse.de> <ZVJQxS6h_K73fMfQ@sashalap>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZVJQxS6h_K73fMfQ@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 13/11/2023 17:37, Sasha Levin wrote:
> On Mon, Nov 13, 2023 at 10:49:01AM +0100, Thomas Zimmermann wrote:
>> (cc: gregkh)
>>
>> Hi Jocelyn
>>
>> Am 13.11.23 um 10:36 schrieb Jocelyn Falempe:
>>> On 13/11/2023 09:34, Keno Fischer wrote:
>>>> Greetings,
>>>>
>>>> When connected to a remote machine via the BMC KVM functionality,
>>>> I am experiencing screen freezes on boot when using 6.5 stable,
>>>> but not master.
>>>>
>>>> The BMC on the machine in question is an ASpeed AST2600.
>>>> A quick bisect shows the problematic commit to be 2fb9667
>>>> ("drm/ast: report connection status on Display Port.").
>>>> This is commit f81bb0ac upstream.
>>>>
>>>> I believe the problem is that the previous commit in the series
>>>> e329cb5 ("drm/ast: Add BMC virtual connector")
>>>> was not backported to the stable branch.
>>>> As a consequence, it appears that the more accurate DP state detection
>>>> is causing the kernel to believe that no display is connected,
>>>> even when the BMC's virtual display is in fact in use.
>>>> A cherry-pick of e329cb5 onto the stable branch resolves the issue.
>>>
>>> Yes, you're right this two patches must be backported together.
>>>
>>> I'm sorry I didn't pay enough attention, that only one of the two was 
>>> picked up for the stable branch.
>>>
>>> Is it possible to backport e329cb5 to the stable branch, or should I 
>>> push it to drm-misc-fixes ?
>>
>> I think stable, which is in cc, will pick up commit e329cb5 
>> semi-automatically now. Otherwise, maybe ping gregkh in a few days 
>> about it.
> 
> I thikn it would be more appropriate to revert 2fb9667, as e329cb5
> doesn't look like -stable material. I'll go ahead and do that.
> 
Ok, that's the best thing to do, as Thomas also found that userspace can 
be confused by the new BMC virtual connector, so it's safer to revert.

Thanks,

-- 

Jocelyn

