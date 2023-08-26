Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE247894B8
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHZIMg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjHZIMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 04:12:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501C1FD7;
        Sat, 26 Aug 2023 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693037530; x=1693642330; i=deller@gmx.de;
 bh=hm1F3N09SJ+WGgO0vYyvNvla2f7QTLVFBvCg3MxxSCo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oYiYBoZFErgc1j45ACFKyinCnwtftKkPXzUuXZNsQ3GEtEjdoZfe3NiqzS3eeDFzwHhCjB+
 pJyV4eWZIdl1aN08SNVtba/gULQwsP0q6HtAUoyeWP1D2K4IP4FmJkFIH2rpesjjC34sXUdO1
 sjjmqx0Piw+llAJQ19kjHS5+DcDGviiBIXXdEcTDnWUBjk1Uo9/DYIZ4JHgsUvMdDH4EbKWJy
 27duX+7gACT+4ypLiJ178xMcLmOiWw84GEpWpseyln9ReKTIrlUGJ1wXvmRUHoqoWXtPvbDx8
 hrpIJAhDQM0JsiS8mkb+It3va7U/91U5IR92J6GmcC0OW0T876ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1q0kQr0s6t-00aF3g; Sat, 26
 Aug 2023 10:12:10 +0200
Message-ID: <d819f689-9a38-3ab7-7585-ca85b69795bf@gmx.de>
Date:   Sat, 26 Aug 2023 10:12:09 +0200
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
 <15c20ace-62c9-a986-cb68-f74953bef624@gmx.de>
 <2023082605-vista-probably-faac@gregkh>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2023082605-vista-probably-faac@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGoVkgBijaEutkD1CRFkxYCy7VLZgWn3iBSeaxdIJomcYNDkaey
 c1+D4EohHsQPulUzHTDiwCEhu4erorhktfGd275dHBXQwtS8GF+GYj/gUZylBkT8djnf2Eq
 87nIhU8hl8uKbLRuJKiHoFXDDmGAE1GZ0PzlCskvWq7ewu82Rf+o5czDi0aILEithZYP9Ys
 vSmRDBHpl36Z3BMlqYniw==
UI-OutboundReport: notjunk:1;M01:P0:olqhuQ1V458=;sF5dNz4EvTLEvk6WwSSfUrbLEEA
 n8M+RpZETPhF/Ii9Z1etHW753xgieEriXGzuwELxVm/wXIGBsrGWB6f4g/zsVd3GkBrZQYtT1
 yU8q3ELM/OKwudRcgAhLH7U/EH1pdWiE0Nqzm1lp89EQOuVv89Labq49o69PqNe4cotpEFfGP
 uKRRJwRUu3HU3zIkA+28R4Bqq47I1Gis8crt2soHPOQOh8ykVzjgXud6wMbOdNk9KyKM62Nu+
 VKRXYtxrRNO0JHKqSVX8Ih9b7Ey/dP4ouoGUQIxdCHkUGSYWz1wW/sq+ij607Z5pcyWlKxCNO
 kt4936+ZojfVxSxSttdB6r8AGCYmRYJ4719/Z7ndZ2vZo2pUsRf3dwsTDu95BlpdIlm1FQr4m
 aCFq3JRMRwu5A2n1+AYsa/8GUJpHqVT+aHDAzpcn4hVWi5BNoNNRqEKbiWgdYg4d2pOcCZ2cz
 XoU+1F2gDOWRX6Tcnfpw76dA0kdDzpJp1F4IQ+X/NRnW6poHaVgF07a5FtCKdhxBPjvEI1lD7
 F2wtvbzLgDu2tDzgq5w8ri1GBYf4oWuB0etHHSoXnq7aRLmmHCHbBV3ycDfbyGooGfHQnhg3V
 00gw1cJ1ZzcmHSvvk5AnRGjo0WdC+aG+D1UUt8Sx8Wl/zg42C6jyT9SXoN3mOXDCBP2n46a3t
 rJjGT5VYNDqETNy8QshZgJn0nDozNRWrQh/xjKFxvpbbSs0EKYwdn/xCmwyKJGPKhbQTORQR6
 OK4vgNLucKsDHdSP7gXa9Ssq4+YZj9/B0r9HzjlcQcQvObICnlgLShL6l8y19YUGVnW+A73iA
 9tnGR/f0Hc/qaDDrstjVKgN7rtsmt+peVv4sKhDKjNgDwDhADzQSsjVSW0RGFAtY0VZVtYOaM
 EzLxpezWDJ+NR67C518dnvSFjYidkPg1zGGRxUil3mbfJ8p5l0Rz8iNf+zvVpMWXb9LdUHfqk
 nvvOk8OwaUd1B2/BsMDe8P4LB3w=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/26/23 09:58, Greg KH wrote:
> On Sat, Aug 26, 2023 at 09:54:55AM +0200, Helge Deller wrote:
>> On 8/26/23 09:34, Greg KH wrote:
>>> On Fri, Aug 25, 2023 at 08:09:26PM +0200, deller@kernel.org wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Older PA-RISC machines have LEDs which show the disk- and LAN-activit=
y.
>>>> The computation is done in software and takes quite some time, e.g. o=
n a
>>>> J6500 this may take up to 60% time of one CPU if the machine is loade=
d
>>>> via network traffic.
>>>>
>>>> Since most people don't care about the LEDs, start with LEDs disabled=
 and
>>>> just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
>>>> manually via /proc/pdc/led.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>>    drivers/parisc/led.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
>>>> index 8bdc5e043831..765f19608f60 100644
>>>> --- a/drivers/parisc/led.c
>>>> +++ b/drivers/parisc/led.c
>>>> @@ -56,8 +56,8 @@
>>>>    static int led_type __read_mostly =3D -1;
>>>>    static unsigned char lastleds;	/* LED state from most recent updat=
e */
>>>>    static unsigned int led_heartbeat __read_mostly =3D 1;
>>>> -static unsigned int led_diskio    __read_mostly =3D 1;
>>>> -static unsigned int led_lanrxtx   __read_mostly =3D 1;
>>>> +static unsigned int led_diskio    __read_mostly;
>>>> +static unsigned int led_lanrxtx   __read_mostly;
>>>>    static char lcd_text[32]          __read_mostly;
>>>>    static char lcd_text_default[32]  __read_mostly;
>>>>    static int  lcd_no_led_support    __read_mostly =3D 0; /* KittyHaw=
k doesn't support LED on its LCD */
>>>> @@ -589,6 +589,9 @@ int __init register_led_driver(int model, unsigne=
d long cmd_reg, unsigned long d
>>>>    		return 1;
>>>>    	}
>>>>
>>>> +	pr_info("LED: Enable disk and LAN activity LEDs "
>>>> +		"via /proc/pdc/led\n");
>>>
>>> When drivers are working properly, they should be quiet.  Who is going
>>> to see this message?
>>
>> That patch shouldn't have gone to stable@ yet... git-send-patch just
>> pulled the CC in and I didn't noticed.
>> So, please don't apply it yet.
>
> I will not, and it's fine to cc: stable@ on stuff that is still making
> it's way into the kernel tree.  It gives us a heads-up on stuff, AND
> sometimes it gives you an additional free review :)

Yes, thanks!  :-)

>>> I don't even understand it, are you saying that you now need to go
>>> enable the led through proc?  And why are leds in proc, I thought they
>>> had a real class for them?  Why not use that instead?
>>
>> This is an old driver from the very beginning, and I don't want to chan=
ge
>> much in it for old kernels other than to reduce the CPU overhead it gen=
erates.
>
> Ah, makes sense, that is a crazy amount of cpu time for a blinking led.
>
> How about just default to it off (like the first chunk you have here),
> which will go to stable trees,

Yes, that was the idea of this patch. I'll drop the pr_info() next time.

> and then a rewrite to use the proper LED api?

Yes.

Helge
