Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B5789490
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 09:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjHZH4H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHZHzi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 03:55:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBED2D53;
        Sat, 26 Aug 2023 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693036496; x=1693641296; i=deller@gmx.de;
 bh=Mx0E12jEnjJ3711WEut814w+2AjrEKMuutahNnbOUTU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Oo+30SVM6j9jPSDTjtQSu/2UusaMrmKoIjDxEv7PWI+1Cpvw294QGneqHePh5lcP7Z7hS3p
 URV4g28cU1t4+bsk1dh6O6C5X3HH+GUdQnSuyNFnUxQX6J+dM4MMbc7ICbLidObQYnsjqwqPK
 GI7zFuOzi/JH7lA09oHiO+Wx2R967CDsXRVraelnkJHAFPe1dUi31GUHdT604xdECvnSWQUiG
 ILHTM8TR1Q6UfMVlYV34gHjQ5Y5gq01c+A+UxObvgbUp/WSx5tRwnh6Y3hr8bGLzIwqfWEAKd
 3i41g+JCDclqFVpIykgIoR45/qSfjroPWdnm24oShkZCKK7T5b3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.244]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1qDaHx1PKz-00V4fM; Sat, 26
 Aug 2023 09:54:56 +0200
Message-ID: <15c20ace-62c9-a986-cb68-f74953bef624@gmx.de>
Date:   Sat, 26 Aug 2023 09:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] parisc: led: Reduce CPU overhead for disk & lan LED
 computation
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-parisc@vger.kernel.org, stable@vger.kernel.org
References: <20230825180928.205499-1-deller@kernel.org>
 <2023082636-refreeze-plot-9f6e@gregkh>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2023082636-refreeze-plot-9f6e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L9T9BNLM8oC8kFIS2dvjd/HbglAIpHDPfQLhH2kMtiXLcttbNWt
 E3L/sXSeY2+2v6cDjocYFFor3n3lO2dq1HKGselUV4LN0EvwHo2gNkiNnK/C+NOvFtPug3F
 2BIqrkh92mT4p1n+oUlDkT2CGkRvtaLrDSwI3onrITao2Octhdvy3QmfjQeMIECpnXqmcTY
 vr+7rw0jgV+9FcwQwkIHw==
UI-OutboundReport: notjunk:1;M01:P0:zLWQEfmImOw=;GrwH6CVRgpSv8R4jADAZJsBHy18
 zMhp7VA8QmRRELt/t06JmVP2nluQPklVFy8GCAdmEZQiHZWanJoAtqcas39+4+9m97AVFLmCp
 qIe3YDYEcTeIX7vfMITlw5Nk/FFyTHyqII6sJGidUsrRYnxruV9lgi2EdlZysAog4cKmS55GS
 YuJ4IOeZyjtp1vAZjYOEWUoYthi3hVr2+lekhvQVk8BLjYmyBo9eyAL6n3Sl6o9WVNvVhNGjl
 Z93a1vGzBJ192Six+0xv8Ld6mCobbWfhiZLwHfkb6CBRBTMTzBbNfZwPkGJkNNfROhGQS9Kcg
 T2lxZGyJj0j7aLudh8Gw+lkICzd8EaIzXBotbUEELEYjv4FnI7dku1qRVZwGr+vtA/2t7jjsR
 JVXlLEDTwPKhQZ2GPD2O8332pxtdh5tTDczU2nTH02U2/RF7VnKa6L3+D7IYIH8EjlM5Pzz1F
 TTnTZgsdb2vbtIFzVpRVsZPWP2WbvdgwW36GRP3BaUHi/atUmntslRheg9GER73muyWSeudMY
 WGn6BlJFzgbWrSsVfOMB0jUW0+RWDACFw0F1TRPqJAHmXZCT94BhZJcJm+obx4h27vm7tyuFK
 cxEYqpKBUAgn+ZYeVRhtScpFBN7cgn8ZhFVhYdEFTqwyuFovZpSfaXXNSZC2dAaiSrfuHFRpl
 vWB2TXTdwJeGBRPVNNi2tQxmzmb60MJu8xbsvJxJNLyNXFC2xnQo7vLFBZFiR482dB2WHLj2b
 3jGkuWeraXvL1S6Rxk+aCmEjzQHgsmH8YOq+iUf2m6Heki/sqSsQ1Hced2QcagLogYooZNe99
 rbePG0iIkn6xK7OGGjDcoTCRv+RDiHGpw9GqfcMHnxhUQMHfqo8/Z0XXyb5zv6LCO7SWs9Eu3
 wP/WB2BVg+y/judM5LKGviLzKl13OoCp049LKmtLAKfbomEf2sOiyru6ybKm7lMJ7fl0U1Xe9
 k5XJ8w==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/26/23 09:34, Greg KH wrote:
> On Fri, Aug 25, 2023 at 08:09:26PM +0200, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Older PA-RISC machines have LEDs which show the disk- and LAN-activity.
>> The computation is done in software and takes quite some time, e.g. on =
a
>> J6500 this may take up to 60% time of one CPU if the machine is loaded
>> via network traffic.
>>
>> Since most people don't care about the LEDs, start with LEDs disabled a=
nd
>> just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
>> manually via /proc/pdc/led.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   drivers/parisc/led.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
>> index 8bdc5e043831..765f19608f60 100644
>> --- a/drivers/parisc/led.c
>> +++ b/drivers/parisc/led.c
>> @@ -56,8 +56,8 @@
>>   static int led_type __read_mostly =3D -1;
>>   static unsigned char lastleds;	/* LED state from most recent update *=
/
>>   static unsigned int led_heartbeat __read_mostly =3D 1;
>> -static unsigned int led_diskio    __read_mostly =3D 1;
>> -static unsigned int led_lanrxtx   __read_mostly =3D 1;
>> +static unsigned int led_diskio    __read_mostly;
>> +static unsigned int led_lanrxtx   __read_mostly;
>>   static char lcd_text[32]          __read_mostly;
>>   static char lcd_text_default[32]  __read_mostly;
>>   static int  lcd_no_led_support    __read_mostly =3D 0; /* KittyHawk d=
oesn't support LED on its LCD */
>> @@ -589,6 +589,9 @@ int __init register_led_driver(int model, unsigned =
long cmd_reg, unsigned long d
>>   		return 1;
>>   	}
>>
>> +	pr_info("LED: Enable disk and LAN activity LEDs "
>> +		"via /proc/pdc/led\n");
>
> When drivers are working properly, they should be quiet.  Who is going
> to see this message?

That patch shouldn't have gone to stable@ yet... git-send-patch just
pulled the CC in and I didn't noticed.
So, please don't apply it yet.

Anyway, yes, I can drop this info.

> I don't even understand it, are you saying that you now need to go
> enable the led through proc?  And why are leds in proc, I thought they
> had a real class for them?  Why not use that instead?

This is an old driver from the very beginning, and I don't want to change
much in it for old kernels other than to reduce the CPU overhead it genera=
tes.

Additionally I've started a rewrite of the driver (in my for-next tree),
and I did look at the led class and led trigger classes. If it fits, I'll
convert to those, but at least for hdd activity it seems only IDE/ATA acti=
vity
is monitored and SCSI activity is missing. Anyway, this is still work-in-p=
rogress...

> And finally, you shouldn't split strings across lines :)

Ok.

Thanks!
Helge
