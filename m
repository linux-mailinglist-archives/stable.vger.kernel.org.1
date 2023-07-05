Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00D749101
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 00:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGEWek (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 18:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEWej (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 18:34:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDD21730
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 15:34:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b867f9198dso7374805ad.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688596477; x=1691188477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yt7JosgSlDOLdt381GrLKtbGFlVzuv402zTByk7ztZs=;
        b=jbJyyj8IBYZO7h3KvD0MhrNfbYD1C6o2m8AS1iFhgMoYGpeE2CO8W6io9p6KMR/qI4
         jMzztjmdjaLxe54P2qH2Z+wsjUj4LMxJ89nuICUN1Cx7HEns03CL1cta4BeTqispW4Aj
         ZZS6t4M7l7BMD0BeFD98s5DE4K+SGppyUiJoBWyBYNyR54VoTMqQnyieQcogxVmrX3Mz
         86U432KDQqV1KGBcddJCAe2XYl9BtYDC3Rj8LwUA1IlF8h3rHo/lz+Q0AO1aqzbOEQtu
         Ra1I2wCGFSSes4VFr8g3hW/McfUO9OHFbZ3Fx7YG6rhAVTkJcMr1jLqnuFM2NBV5upNi
         r57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596477; x=1691188477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt7JosgSlDOLdt381GrLKtbGFlVzuv402zTByk7ztZs=;
        b=NqQyjA5OGBP+H2gK2nWle7uBlx/2JHbvmtJ2RLKGFePMun6iBjTpR2haBib6a/eQOd
         pkTxQwKONmFpOH0mX0gGX2vPSTr93igiewqlRYUKctUMl+9kcy1KgHecuIHp7QmWYzAl
         gDebzhdlJa6DpjCg1o9KzHxpBJggSWdxYCI89IpHPRiBI3Z7VQEiXVycVwv12/MdsEio
         BOhke8r+PwAcRvoxh+25WoqRUd1ONW5AzwEbqZ+V5xp4Dxvm6CVNgv0zt4tDHVnbiC+c
         0ms9INONJCfEh322XYzqFqPMt5O5dRBOiBBqLAR/hKgKU322PAPQ1jbIzO4G/+pt0yUo
         ZoVg==
X-Gm-Message-State: ABy/qLbdcpW5PxZ1gJjlpTNwwl/ka7osngtoQglPrFrEvmmSy0dhZYwe
        4GM3O39EsCsP8OvL8ZARB4UM3g==
X-Google-Smtp-Source: APBJJlGpGzW3tWovGol5Vro55MJvY9GwPUaUGLe22952trfqqf3F6PxvpcqG8ucWsbmeeKwXhb/MQg==
X-Received: by 2002:a17:902:da83:b0:1b8:811:b079 with SMTP id j3-20020a170902da8300b001b80811b079mr444796plx.0.1688596477249;
        Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b694140d96sm10514761pli.170.2023.07.05.15.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 15:34:36 -0700 (PDT)
Message-ID: <481c0e2a-320c-e53d-2a0e-ba5fa6ea4049@kernel.dk>
Date:   Wed, 5 Jul 2023 16:34:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
 <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
 <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
 <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
 <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/5/23 4:25?PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On 6/07/23 10:13, Jens Axboe wrote:
>>>> should be enough for it to go into stable from 5.2 and onwards.
>>> OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>>>>> (Greg didn't seem to object to the Fixes: as such, just to the
>>>>> incorrect version prereq)
>>>> I think it's really confusing... A patch should only have a Fixes tag if
>>>> it's fixing a specific bug in that patch. Either it is, in which case
>>>> you would not need Cc stable at all since it's only in 6.5-rc, or it
>>> It is fixing a bug in b6f3f28f60. I should have checked whether the
>>> patch series had already gone to release, not just -rc, instead of
>>> just adding the stable tag out of caution.
>> But this is the confusion - if it's fixing a bug in b6f3f28f60, then why
>> is it marked as needing to get backported much further back, predating
>> that commit?
> 
> I see - it doesn't need to be backported that far back _alone_. It
> only needs to be applied after  b6f3f28f60 once that one has been
> backported.

OK I see - I think there's some serious misunderstandings here then :-)

It sounds like it fixes a bug in b6f3f28f60 alone, and it has no
business going into stable. The commit should _just_ be marked with it
fixing that. If someone were to backport that previous series, then
their tooling or diligence should notice this dependency and this
current commit should be picked as well.

There should be no Cc: stable on this patch at all, I'll fix it up.

-- 
Jens Axboe

