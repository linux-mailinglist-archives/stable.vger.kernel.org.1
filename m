Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286D7E92C1
	for <lists+stable@lfdr.de>; Sun, 12 Nov 2023 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjKLUoN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLUoM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 15:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6EC1BEC
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 12:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699821801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/lZSLfHSJ3lgfaPtLw9pH3ZZ2OWkdNMAIZm5OTZRi4=;
        b=E46OOYyobReaJ32Ha6IWPsgqiVgVWHnPucADwyMjhyYOnU0Br2RUbDEYgdxomydUlixDCh
        XeoQVYnvPhJchY/t8U9s9XyYh+z/jr++plhLsvOfNEBTCIYPRDXF82+yL/BGDnhAuD6t8s
        0RUGxPS8ajp3vNWDRkLlrbYV3INEo8w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-2KOmpCjLO-m1gATzBj4pzA-1; Sun, 12 Nov 2023 15:43:19 -0500
X-MC-Unique: 2KOmpCjLO-m1gATzBj4pzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e8b2d32d88so31748766b.0
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 12:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699821798; x=1700426598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/lZSLfHSJ3lgfaPtLw9pH3ZZ2OWkdNMAIZm5OTZRi4=;
        b=GhTwD/bI2/xzfBX6CoUiwuCxZYgaGlMfOc6On0IS0csGRW4GxVdL53X1vEHp2MIuQc
         f3wApL72+GMRwTPSIX6L18ecLvFg7Il8jTY9FEN4EJTsFoGiwL/Wqkxb1ur6Pfi3vVkh
         sYNI4qTkc/n8G8jQgGe4QgwXRmaRBxfyiCL88//xFzXv/1GuI6Acs7F63gIO5Lnz8Lp1
         rrzcLaBmY4qtssE8hPOBIJNV53pwT0xv+qYwqnHhAA7Uc7Jw7UMcZIt7a+NeAQdiKBZy
         lalbImoSCDucpRnDSy9slKr2WOOuUkc5A052+31eqbwvuLZ/u/ruISgG9KP/Ai/fywqw
         3z4Q==
X-Gm-Message-State: AOJu0Yyrq1QIbsOSx3CpKOs8UkuuZdeB9ZrFGEGx1LrE8rHGpJISJHTn
        /G60WIwq5x0u8AhZcFC/lndiohsrR4WKzyTWkAd4jJ3rVPBPd9f1hgopvT2FL7aDdzU0Jqxu0LZ
        5ae3yEiw3NT4eg8RzbnZlc0EE
X-Received: by 2002:a17:906:300b:b0:9ba:a38:531e with SMTP id 11-20020a170906300b00b009ba0a38531emr3544797ejz.52.1699821798024;
        Sun, 12 Nov 2023 12:43:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpZkasG8Lh5Q8a2Bx2iRoNIZThOCEb3KwkB/3fA6F8wH2CFJrCrtz7uQQMTLVT5JttMyI6IA==
X-Received: by 2002:a17:906:300b:b0:9ba:a38:531e with SMTP id 11-20020a170906300b00b009ba0a38531emr3544777ejz.52.1699821797566;
        Sun, 12 Nov 2023 12:43:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h8-20020a170906260800b009dd98089a48sm2973331ejc.43.2023.11.12.12.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 12:43:16 -0800 (PST)
Message-ID: <55698544-8cba-4413-bdd3-79cfaa1f3c44@redhat.com>
Date:   Sun, 12 Nov 2023 21:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
To:     "Owen T. Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
 <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>
 <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
 <CAAd53p608qmC3pvz=F+y2UZ9O39f2aq-pE-1_He1j8PGQmM=tg@mail.gmail.com>
 <d1ac9c1e-f3fe-4d06-ba2e-2c049841d19b@owenh.net>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d1ac9c1e-f3fe-4d06-ba2e-2c049841d19b@owenh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 11/10/23 17:58, Owen T. Heisler wrote:
> Hi everyone,
> 
> On 11/10/23 06:52, Kai-Heng Feng wrote:
>> On Fri, Nov 10, 2023 at 2:19 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 11/10/23 07:09, Kai-Heng Feng wrote:
>>>> On Fri, Nov 10, 2023 at 5:55 AM Owen T. Heisler <writer@owenh.net> wrote:
>>>>> #regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
>>>>> #regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
>>>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218124
>>>>
>>>> Thanks for the bug report. Do you prefer to continue the discussion
>>>> here, on gitlab or on bugzilla?
> 
> Kai-Heng, you're welcome and thank you too. By email is fine with me.
> 
>>> Owen, as Kai-Heng said thank you for reporting this.
> 
> Hans, you're welcome, and thanks for your help too.
> 
>>>>> ## Reproducing
>>>>>
>>>>> 1. Boot system to framebuffer console.
>>>>> 2. Run `systemctl suspend`. If undocked without secondary display,
>>>>> suspend fails. If docked with secondary display, suspend succeeds.
>>>>> 3. Resume from suspend if applicable.
>>>>> 4. System is now in a broken state.
>>>>
>>>> So I guess we need to put those devices to ACPI D3 for suspend. Let's
>>>> discuss this on your preferred platform.
>>>
>>> Ok, so I was already sort of afraid we might see something like this
>>> happening because of:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89c290ea758911e660878e26270e084d862c03b0
>>>
>>> As I mentioned during the review of that, it might be better to
>>> not touch the video-card ACPI power-state at all and instead
>>> only do acpi_device_fix_up_power() on the child devices.
>>
>> Or the child devices need to be put to D3 during suspend.
>>
>>> Owen, attached are 2 patches which implement only
>>> calling acpi_device_fix_up_power() on the child devices,
>>> can you build a v6.6 kernel with these 2 patches added
>>> on top please and see if that fixes things ?
> 
> Yes, with those patches v6.6 suspend works normally. That's great, thanks!
> 
> I tested with v6.6 with the 2 patches at <https://lore.kernel.org/regressions/a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com/> using <https://gitlab.freedesktop.org/drm/nouveau/uploads/788d7faf22ba2884dcc09d7be931e813/v6.6-config1>. I tested both docked and un-docked, just in case.
> 
> Tested-by: Owen T. Heisler <writer@owenh.net>
> 
>>> Kai-Heng can you test that the issue on the HP ZBook Fury 16 G10
>>> is still resolved after applying these patches ?
>>
>> Yes. Thanks for the patch.
>>
>> If this patch also fixes Owen's issue, then
>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com

Owen, Kai-Heng thank you for testing. I've submitted these patches
to Rafael (the ACPI maintainer) now (with you on the Cc).
Hopefully they will get merged soon.

Regards,

Hans

