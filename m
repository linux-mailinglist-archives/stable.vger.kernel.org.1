Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413178A519
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjH1FKE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 01:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjH1FJv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 01:09:51 -0400
X-Greylist: delayed 117178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 22:09:47 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B37CC
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 22:09:47 -0700 (PDT)
Message-ID: <b8a8451e-675d-4766-a886-2ff01fad1493@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693199385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtKdey1Sj/BWOjOfCOmDjF9BmTpO6iO3GnfdaKmuWT8=;
        b=qyZPNOa/25G1Spu7jyk8C6a6oUtRdjfuWf985ZeIVn7yx+jUOFU6ZrvovxsD+7XMehwvvE
        AwDQNSVptWkno12LtnaU//62dogoPUqbWpS3EbOlUkHrIUd4IQ4OLO9Bud0z4jCoG0k8vm
        X2WIowhF993k4oi6lWYhRK7SzwxSLPnaGPsfbVijjOScNEl0Qoj9pkwyvq61FPgPV8tec4
        b8ppGMTmQogh3DI1AIkU9x/Xbxr6VVxxMpry0ji+Ew84Isit409ciBDtCEkugmSCD0wzy+
        QCTCd6LR9b5bYzMd7v7skYqyIM4kkl/9YKldrn6zMTF2a9pUm3VyoIJhP9Nwwg==
Date:   Mon, 28 Aug 2023 07:09:43 +0200
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IDUuMTAuMTkyIGZhaWxzIHRvIGJ1aWxkIChlcnJvcjog4oCYUlQ3?=
 =?UTF-8?Q?11=5FJD2=5F100K=E2=80=99_undeclared_here_=28not_in_a_function=29?=
 =?UTF-8?Q?=29?=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Bernhard Landauer <bernhard@manjaro.org>
References: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
 <2023082729-charm-broom-6cfb@gregkh>
Content-Language: en-US
From:   =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <2023082729-charm-broom-6cfb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

I applied that patch on top of 5.10.192 however I get still the same error:

2023-08-27T20:53:30.8714926Z   -> Applying patch: 
asoc-rt711-add-two-jack-detection-modes.patch...
2023-08-27T20:53:30.8725584Z patching file sound/soc/codecs/rt711-sdw.h
2023-08-27T20:53:30.8727337Z patching file sound/soc/codecs/rt711.c
2023-08-27T20:53:30.8729516Z patching file sound/soc/codecs/rt711.h
...
2023-08-27T21:15:14.5273400Z   CC [M]  sound/soc/intel/boards/sof_sdw.o
2023-08-27T21:15:15.1639214Z sound/soc/intel/boards/sof_sdw.c:208:41: 
error: ‘RT711_JD2_100K’ undeclared here (not in a function)
2023-08-27T21:15:15.1640795Z   208 |                 .driver_data = 
(void *)(RT711_JD2_100K),
2023-08-27T21:15:15.1641904Z       | 
     ^~~~~~~~~~~~~~
2023-08-27T21:15:15.2094047Z make[4]: *** [scripts/Makefile.build:286: 
sound/soc/intel/boards/sof_sdw.o] Error 1
2023-08-27T21:15:15.2105479Z make[3]: *** [scripts/Makefile.build:503: 
sound/soc/intel/boards] Error 2
2023-08-27T21:15:15.2107050Z make[2]: *** [scripts/Makefile.build:503: 
sound/soc/intel] Error 2
2023-08-27T21:15:15.2154855Z make[1]: *** [scripts/Makefile.build:503: 
sound/soc] Error 2
2023-08-27T21:15:15.2155979Z make: *** [Makefile:1832: sound] Error 2

Is there another patch, change you may have missed?

On 27.08.23 20:29, Greg Kroah-Hartman wrote:
> On Sat, Aug 26, 2023 at 10:36:41PM +0200, Philip Müller wrote:
>> Hi Greg,
>>
>> please revert the following two patches as 5.10.192 fails to build with
>> them:
>>
>> asoc-intel-sof_sdw-add-quirk-for-lnl-rvp.patch
>> asoc-intel-sof_sdw-add-quirk-for-mtl-rvp.patch
>>
>> Error message: error: ‘RT711_JD2_100K’ undeclared here (not in a function)
>>
>> 2023-08-26T17:46:51.3733116Z sound/soc/intel/boards/sof_sdw.c:208:41: error:
>> ‘RT711_JD2_100K’ undeclared here (not in a function)
>> 2023-08-26T17:46:51.3744338Z   208 |                 .driver_data = (void
>> *)(RT711_JD2_100K),
>> 2023-08-26T17:46:51.3745547Z       |     ^~~~~~~~~~~~~~
>> 2023-08-26T17:46:51.4620173Z make[4]: *** [scripts/Makefile.build:286:
>> sound/soc/intel/boards/sof_sdw.o] Error 1
>> 2023-08-26T17:46:51.4625055Z make[3]: *** [scripts/Makefile.build:503:
>> sound/soc/intel/boards] Error 2
>> 2023-08-26T17:46:51.4626370Z make[2]: *** [scripts/Makefile.build:503:
>> sound/soc/intel] Error 2
>>
>> This happened before already:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/queue-5.10?id=2e4795b45723de3d253f38bc57724d9512c737f5
> 
> {sigh}  Sorry about that.
> 
> I just backported commit 683b0df26c33 ("ASoC: rt711: add two jack
> detection modes") instead, that should solve this issue and give more
> support to that kernel tree if anyone is actually using it there (based
> on me not geting any build errors from any CI systems for that driver, I
> kind of doubt it...)
> 
> thanks,
> 
> greg k-h

-- 
Best, Philip

