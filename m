Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8F7464D9
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGCV17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjGCV16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 17:27:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E370E7C
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 14:27:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-682a5465e9eso14743b3a.1
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688419676; x=1691011676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1+C8/vH6IOhyc7mE6cmER0+xoj1XCImsxDntHWGTAo=;
        b=XjL7Ricwke8X1q/e0s+i7ek6652bqfP8ltvtoc0dsDfajvwyPEyvRmbb40lvhCJWSh
         ZL9XiSxdaF9WOzLDQVrQe0d6HeKTkSgjM7/VoMHM0eQlQ2zuJiqcEw7W6n0a2GCKfV6X
         oYvZ/5s/KuI6MctF3Huf1Kj5MPYy+p03VGuIbTrX+yKEyTHz1q+qpF6hMVLqftHIXdza
         Femn5DCqg1kXwnoiIkhBUMWM03TfpZO5ZkmuDHvpibSlwpYC2R8Sf7qlp9jy42Qenjfu
         8EGoYTeG0+MgYkuNfkbcjxickjbLEJyb8rAnbZR4/1c3o0kGeph8vmmxMVnThmaYDe0l
         pRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419676; x=1691011676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1+C8/vH6IOhyc7mE6cmER0+xoj1XCImsxDntHWGTAo=;
        b=AkVs7Cm9kLDHtkSroRHy4j9yHCm4BLtLuNT7X+1OlYr5cgH201qEV9EvJadv/11SVN
         nFRjTR2Og9yJP0U+UWUVmwDunwZal5faGZI6FqptK2rj7Weg4OrW5Ue82grd3xHf4Bwi
         yrpfWDky8dXnZP1DBTFuNHSF0MNpO0iB66hBcCVEb/spF4zPLxiclrP2y28xweRRoeB/
         PxqcxyaQfPxh0z0FKc33YEZ7d1Lm1Wh6E/W29Trbc1X6oRCRrin4aQ0GrJKedwMRB8Ri
         crYVbYLAt0wSY17vimbjyQxqN1J6npostaptumEfsWQVC9TCHsxq8O+t70fczuWsBmbW
         qC4w==
X-Gm-Message-State: ABy/qLYomAITiJ2ycKEcA8PFiMGQBr25upJhNW/nnx/v5QFLKoXdUtdL
        +tuP3BfvBk7J/eWRJgHxhnK6RuQptY7lncb8o3I=
X-Google-Smtp-Source: APBJJlEgYS0A+LCseJShNe4zEI3DJAHouvxIrvdd/9Evb8AI4iYsB6RbaXaglmYlo4T64VWBLY2keg==
X-Received: by 2002:a05:6a00:1f90:b0:675:8627:a291 with SMTP id bg16-20020a056a001f9000b006758627a291mr12731112pfb.3.1688419675905;
        Mon, 03 Jul 2023 14:27:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b0064d32771fa8sm9886536pfu.134.2023.07.03.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 14:27:55 -0700 (PDT)
Message-ID: <fbabe412-a3a9-ef89-72ce-cc3e51984139@kernel.dk>
Date:   Mon, 3 Jul 2023 15:27:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
 <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
 <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
 <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/3/23 3:24?PM, Michael Schmitz wrote:
> Hi Christian,
> 
> On 4/07/23 02:59, Christian Zigotzky wrote:
>>> I am very happy that this bug is fixed now but we have to explain it to our customers why they can't mount their Linux partitions on the RDB disk anymore. Booting is of course also affected. (Mounting the root partition)
>>>
>>> But maybe simple GParted instructions are a good solution.
>> You can apply the patch. I will revert this patch until I find a simple solution for our community.
>>
>> Thank you for fixing this issue!
> 
> Thanks for testing - I'll add your Tested-by: tag now. I have to
> correct the Fixes: tag anyway.
> 
> Jens - is the bugfix patch enough, or do you need a new version of the
> entire series?

Well, the whole series is already upstream, so that part is set in
stone. What I'm unclear on is if the final fix is the parent of this
thread, or if there's later version burried somewhere within this big
thread?

-- 
Jens Axboe

