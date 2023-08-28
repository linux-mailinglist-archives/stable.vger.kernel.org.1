Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3878B32F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjH1OaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjH1O3j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 10:29:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024B3DA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:29:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760dff4b701so31952239f.0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1693232975; x=1693837775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9z52IDwPkyV0fJoLzvn17JSKtcN3iBkr3iaP0OrIMXQ=;
        b=LuZKarlfmElOxzaTgH4D81jj1VlQYPdmz3TXBxWOEQCJSFCvsQ0rT/9fqJs9EAkbM1
         20bntthCs0dgeFGvWcONti/DF3eSfdD3ZdyB/PC6jgdjiTiVTqEJODnU8ijMxklKBrFx
         zvqjV8/jB5o6OCkI7lw95A1S93e7KKAs0wx1zmW8b/OKWQ9LufOEe2/HhylFQh2aXciW
         CQOakE/wAoOU7agg/Cm0C+WkrxFFK4nRKiGcZwv13rg8d/HvdEQHPUSL/q/jRExmSlQe
         1jdRJHVKls549edJaG3U24yehcO6odqJzGwLasgDR16XYzZHaVrG7ESB+egkNVzxNU8z
         gfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232975; x=1693837775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9z52IDwPkyV0fJoLzvn17JSKtcN3iBkr3iaP0OrIMXQ=;
        b=R5s1O3PdDyN6ng7lGDy8ANcsXQCrnh+Q66Dc3FtH6MDZYoYA5Bxi2E0eqXpvFxldWB
         YmS3IpawAVGiZLbswten5bdnmRG2TDyKqR6fon8laj9EzoeZB4yJ0/05GxV36gcUkSOf
         GyYCAl8f4d32mFMQj+3GCZT/hFCtao28s6y2uGh0UV0D7Kfptzzwthc0uEGeWF05vfBa
         77SFVfABoGLeNrxBzv+0of0r6Ujm7lac6pgVUzIwnoP2qM9+afz5CqegdatiY9xkn3PF
         OcixFqsbJZARb2FlvxQ8CO8Lj1Fj2dC9j28m8Ko3Eb5TBWgEXYFmAHHtcUkm652IWj9c
         8jJw==
X-Gm-Message-State: AOJu0YxvYM8HiQ6HDth2hGOXtleYzxyjXijXBHEIUg3l8BuhISS2cUq4
        1QScVcKCXg24DlxH/yLF7nZ4KQ==
X-Google-Smtp-Source: AGHT+IGI9WOv5p4/hqui6QriwVIAb4V4C2Xxt2QS/sZsJp6viH2NWpfhjaGGnsKAMMmZUrXzICJzxA==
X-Received: by 2002:a05:6e02:14d:b0:349:5c87:e712 with SMTP id j13-20020a056e02014d00b003495c87e712mr25320714ilr.1.1693232975368;
        Mon, 28 Aug 2023 07:29:35 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t16-20020a92ca90000000b003460b697bc0sm2459509ilo.59.2023.08.28.07.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 07:29:34 -0700 (PDT)
Message-ID: <e3b111d1-c526-41e4-96e9-cce9b1abad7e@kernel.dk>
Date:   Mon, 28 Aug 2023 08:29:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patches for 6.1-stable
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>
References: <7bebe361-e33f-42e7-b4d7-00efd024a986@kernel.dk>
 <2023082752-entangled-unhook-de55@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023082752-entangled-unhook-de55@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/27/23 1:14 AM, Greg Kroah-Hartman wrote:
> On Tue, Aug 22, 2023 at 06:07:28PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Looks like we missed a few backports related to MSG_RING, most likely
>> because they required a bit of hand massaging. Can you queue these up?
>> Thanks!
> 
> All now queued up, thanks.

Thanks Greg!

-- 
Jens Axboe


