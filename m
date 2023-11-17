Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC337EF4D9
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 16:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKQPBh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 10:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQPBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 10:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77FD4B
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700233291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZvKlexA4qE1IZw8Fj3LwrdUD9v+b3hIBxm3Oq8CuLk=;
        b=VJPdPbLKJvkGT/XXBalxcyVHXX/g1pXSPgRDfsPfllbFnW2WmKXe7H+9W0yUNhxK505B9I
        uiWLE/nAYXdjBKP+ovI+G+KYcbafLfP1QWVKUlq890S0xj7XsPDYAoHwuPWEPrbQFj2uCm
        0Tg4t/SBSwZ94WUv2+IDQDRKPfEBZCw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-utvrBTYiNl2cluakAYOkTQ-1; Fri, 17 Nov 2023 10:01:30 -0500
X-MC-Unique: utvrBTYiNl2cluakAYOkTQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so147799766b.3
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 07:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700233289; x=1700838089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZvKlexA4qE1IZw8Fj3LwrdUD9v+b3hIBxm3Oq8CuLk=;
        b=Rdas2x24eiTVpOET/HdreiRQAUHhCr+vgv3ri6PNSBg+xYDYCgJsNcgYD4pUGcYTSn
         z7frwzJUeaS/5cA8WHHO4LRm+adoFFhnwzrdfIhW6OmGKjjOHlEros/mZ5cgi+07Rnjr
         vDYS260aSg1LFu1qSNzKKkDiiNQ9DQm4kXexvWc9ndpomXplItgK3kVkk9L50oazRvx5
         DjvytFbJm88D/+2kdVGKcmIW7zM/qm4IuSopSrMQ+aqa2PrfUGm5usmJ72N5wWO+KIEx
         BlV7rF6WmbXnP1jgOL6iwGlmuc+vdYBWSEb/Cth7y9SDSK5Gi7JqmFPa/m4mSmpy57tF
         4byQ==
X-Gm-Message-State: AOJu0YyfcXAtmGhBBetf2QV99B7oFeP4utoZz1OpH2+yeVob6S8GA3/E
        c4ZBnFHVHi6XSnHRvsR1WqVkUseAoq24DmJaTEZcJbTHstzQukF6xem1zkyw8u9JN0YMdPqwFhP
        9s5MRnJKBwqqPll/i
X-Received: by 2002:a17:907:94d4:b0:9d3:8d1e:ce8 with SMTP id dn20-20020a17090794d400b009d38d1e0ce8mr18085349ejc.20.1700233289060;
        Fri, 17 Nov 2023 07:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6V2pxM69SBsfb3ukO60+ra463B4IR7Z5LGGH8zA6n04xG7X1Arr+vrPlI13/oI2eMpU1Cfw==
X-Received: by 2002:a17:907:94d4:b0:9d3:8d1e:ce8 with SMTP id dn20-20020a17090794d400b009d38d1e0ce8mr18085234ejc.20.1700233287836;
        Fri, 17 Nov 2023 07:01:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lz10-20020a170906fb0a00b009737b8d47b6sm855577ejb.203.2023.11.17.07.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:01:27 -0800 (PST)
Message-ID: <88a14de8-ceaf-4c1d-ba6c-6cfbbffa0e2a@redhat.com>
Date:   Fri, 17 Nov 2023 16:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Found a bug with my gaming gear
Content-Language: en-US, nl
To:     =?UTF-8?Q?Andr=C3=A9_Kunz?= <donatusmusic@gmx.de>,
        stable@vger.kernel.org
Cc:     regressions@lists.linux.dev
References: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi André,

On 11/16/23 23:41, André Kunz wrote:
> Hey there guys,
> 
> This is my first kernel "bug" report ever, so please bear with me if I
> didn't catch the precise right way to report this.
> 
> The bug I've found:
> 
> I'm running stable kernel 6.6.1-1 and as soon as I install it, many of
> my mouse's hardware buttons stop working. I have a Logitech G502 X Plus
> (it's a wireless mouse). As soon as I install 6.6.1 the mouse's hardware
> buttons won't work, i.e. only the two side-buttons would work, not the
> buttons (and/or my created profiles/macros) would. I have a few macros
> assigned to some buttons, which work perfectly fine under 6.5.11 (and
> earlier), but as soon as I'm on 6.6 they'd stop working.
> 
> Just wanted to report this and I hope there can be a fix.
> 
> I hope this email was not too much out of the ordinary.

For starters lets collect some logs and see if that explains
anything.

Can you do the following:

1. Boot the working 6.5.11, wiggle the mouse (so that it connects)
and the run:

dmesg > dmesg-6.5.11.txt

2. Boot the non working 6.6.1, wiggle the mouse and run:

dmesg > dmesg-6.6.1.txt

And then attach both generated dmesg-...txt files to your next email ?

Regards,

Hans



